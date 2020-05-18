Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875B31D7CCC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 17:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgERP0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 11:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgERP0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 11:26:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2547DC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5JgLj2+DCv1+0yfBDC+57Xxa+VbNaCmUQuN65CNtdGs=; b=JMphm1HFkx34iCMwxbaxGU6ONt
        PKTFL0wcixP1KXZMFUWMjiN36Q75Ohiwq17R3+IYkAm8KUBIBCmcXb3rDtnDRouUUdrkEDA7iVrHw
        4hQdNZL1lDz0qIyW7+DYDdG8dRBwDMbH+qcwGvqAZaz9R/WkLA2kBzcLh4UBGP3T6nrcl6PK9ACP2
        Xys01wrdcxVHilBEJKsWr2Dcg0mkuYgCQF2R4hWA2DR1yg6HbDay4/6doT1cFsIgYQ4PoMeG4HBA5
        3nng6OOy9XbauYvK/BWvzNaMJtS7IYLcio2u7QNPX9g4izcv4qmOtttmSJgVoaCLKSsn+0ACH+VXF
        4Uglmmhg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaheT-0005ZQ-KN; Mon, 18 May 2020 15:26:01 +0000
Date:   Mon, 18 May 2020 08:26:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
Message-ID: <20200518152601.GU16070@bombadil.infradead.org>
References: <87a72qtaqk.fsf@vostro.rath.org>
 <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org>
 <87368hz9vm.fsf@vostro.rath.org>
 <20200503102742.GF29705@bombadil.infradead.org>
 <CAJfpegseoCE_mVGPR5Bt8S1WZ2bi2DnUb7QqgPm=okzx_wT31A@mail.gmail.com>
 <20200518144853.GT16070@bombadil.infradead.org>
 <CAJfpegtKQ85K2iJUvm-A+cTD1TKsa1AVTDnwbeky4hyf+SJfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtKQ85K2iJUvm-A+cTD1TKsa1AVTDnwbeky4hyf+SJfgQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 04:58:05PM +0200, Miklos Szeredi wrote:
> On Mon, May 18, 2020 at 4:48 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, May 18, 2020 at 02:45:02PM +0200, Miklos Szeredi wrote:
> 
> > > page_cache_pipe_buf_steal() calls remove_mapping() which calls
> > > page_ref_unfreeze(page, 1).  That sets the refcount to 1, right?
> > >
> > > What am I missing?
> >
> > find_get_entry() calling page_cache_get_speculative().
> >
> > In a previous allocation, this page belonged to the page cache.  Then it
> > was freed, but another thread is in the middle of a page cache lookup and
> > has already loaded the pointer.  It is now delayed by a few clock ticks.
> >
> > Now the page is allocated to FUSE, which calls page_ref_unfreeze().
> > And then the refcount gets bumped to 2 by page_cache_get_speculative().
> > find_get_entry() calls xas_reload() and discovers this page is no longer
> > at that index, so it calls put_page(), but in that narrow window, FUSE
> > checks the refcount and finds it's not 1.
> 
> What if that page_cache_get_speculative() happens just before
> page_ref_unfreeze()?  The speculative reference would be lost and on
> put_page() the page would be freed, even though fuse is still holding
> the pointer.

static inline void page_ref_unfreeze(struct page *page, int count)
{
        VM_BUG_ON_PAGE(page_count(page) != 0, page);
        VM_BUG_ON(count == 0);

        atomic_set_release(&page->_refcount, count);

static inline int __page_cache_add_speculative(struct page *page, int count)
{
        if (unlikely(!page_ref_add_unless(page, count, 0))) {
                return 0;

