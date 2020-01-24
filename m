Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5311A148198
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 12:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgAXLVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 06:21:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390799AbgAXLVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8NtwvVXwMbEeKGtQBpJWoIGytCazgM6ygP8M0AMB/oU=; b=uw5i2aWn7LL3opxrLL8s3yLU7
        OlFhXFgymnVfWwiFsQv7xuY8rEzyIYDxDrHR1EfJUBpR7CaOxyBVzpag72ZwQO2HsATPjMEIsqnMx
        FxGLIux7G5uCfbbZhltleiqFqOnQCntQkAm0DW8m4MmYDdbxw8O7gP6HVg9EeIiP0WRgTu1FdaMrp
        sNjmWJFMBE4hR09qjY/ekkPZvjZt2jLDGLhd60fvpVg5yQRhlgUOINx0CfZL49q8mhHt7CRiDnSXO
        6evHpbTq9I7kRdNX3bFlOnM+U412f1nq4ftd26DBGGCqqkRFB56va9jGFf2xU4ezJZL49Z2jGV82m
        +eJ6gnGNQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iux1R-0002C3-Uo; Fri, 24 Jan 2020 11:21:09 +0000
Date:   Fri, 24 Jan 2020 03:21:09 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add ITER_MAPPING
Message-ID: <20200124112109.GK4675@bombadil.infradead.org>
References: <20200122193306.GB4675@bombadil.infradead.org>
 <3577430.1579705075@warthog.procyon.org.uk>
 <3785795.1579777499@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3785795.1579777499@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:04:59AM +0000, David Howells wrote:
> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > It's perfectly legal to have compound pages in the page cache.  Call
> > find_subpage(page, xas.xa_index) unconditionally.
> 
> Like this?
> 
> #define iterate_mapping(i, n, __v, skip, STEP) {		\
> 	struct page *page;					\
> 	size_t wanted = n, seg, offset;				\
> 	loff_t start = i->mapping_start + skip;			\
> 	pgoff_t index = start >> PAGE_SHIFT;			\
> 								\
> 	XA_STATE(xas, &i->mapping->i_pages, index);		\
> 								\
> 	rcu_read_lock();						\
> 	xas_for_each(&xas, page, ULONG_MAX) {				\

I actually quite liked the iterator you had before; I was thinking of
wrapping it up as xas_for_each_contig().

> 		if (xas_retry(&xas, page) || xa_is_value(page)) {	\
> 			WARN_ON(1);					\
> 			break;						\
> 		}							\

Actually, xas_retry() can happen, even with the page itself pinned.  It
indicates the xarray data structure changed under you while walking it
and you need to restart the walk from the top (arguably this shouldn't
be exposed to callers at all, and in the future it may not be ... it's
something inherited from the radix tree interface).

So this should be:

		if (xas_retry(&xas, page))
			continue;
		if (WARN_ON(xa_is_value(page)))
			break;

> 		__v.bv_page = find_subpage(page, xas.xa_index);		\

Yes.

> 		offset = (i->mapping_start + skip) & ~PAGE_MASK;	\
> 		seg = PAGE_SIZE - offset;			\
> 		__v.bv_offset = offset;				\
> 		__v.bv_len = min(n, seg);			\
> 		(void)(STEP);					\
> 		n -= __v.bv_len;				\
> 		skip += __v.bv_len;				\
> 		if (n == 0)					\
> 			break;					\
> 	}							\
> 	rcu_read_unlock();					\
> 	n = wanted - n;						\
> }
> 
> Note that the walk is not restartable - and the array is supposed to have been
> fully populated by the caller for the range specified - so I've made it print
> a warning and end the loop if xas_retry() or xa_is_value() return true (which
> takes care of the !page case too).  Possibly I could just leave it to fault in
> this case and not check.
> 
> If PageHuge(page) is true, I presume I need to support that too.  How do I
> find out how big the page is?

PageHuge() is only going to be true for hugetlbfs mappings.  I'm OK
with not supporting those for now ... eventually I want to get rid of
the special cases in the page cache for hugetlbfs, but there's about
six other projects standing between me and that.
