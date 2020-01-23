Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849F014664A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 12:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgAWLFJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 06:05:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgAWLFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579777508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jxuyA80MEb2gTFQSCosXFokQLxTD9/TGE5FZXZ4AEMM=;
        b=J2s79Z7t+QeS+d8HCTZE6CMZJ1S1hG/VieatsGVbw7pQwlwEiQA6Sr6iorAf7B/XJyPcNB
        jRvF8GAmI/N2kRxY5mVbXCLtkzsCoP0Gl1/XWVutUYwWqK/6ML4rIkjqeOpXA5AnuqLLk9
        uMoNCeyEho/uEltIwqbISgJ5IGsLlFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177--nKY3tyLNCSpxiCzT7fDaA-1; Thu, 23 Jan 2020 06:05:04 -0500
X-MC-Unique: -nKY3tyLNCSpxiCzT7fDaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 360CB1005F6B;
        Thu, 23 Jan 2020 11:05:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-49.rdu2.redhat.com [10.10.120.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA64B5C1B5;
        Thu, 23 Jan 2020 11:05:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200122193306.GB4675@bombadil.infradead.org>
References: <20200122193306.GB4675@bombadil.infradead.org> <3577430.1579705075@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] iov_iter: Add ITER_MAPPING
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3785794.1579777499.1@warthog.procyon.org.uk>
Date:   Thu, 23 Jan 2020 11:04:59 +0000
Message-ID: <3785795.1579777499@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> It's perfectly legal to have compound pages in the page cache.  Call
> find_subpage(page, xas.xa_index) unconditionally.

Like this?

#define iterate_mapping(i, n, __v, skip, STEP) {		\
	struct page *page;					\
	size_t wanted = n, seg, offset;				\
	loff_t start = i->mapping_start + skip;			\
	pgoff_t index = start >> PAGE_SHIFT;			\
								\
	XA_STATE(xas, &i->mapping->i_pages, index);		\
								\
	rcu_read_lock();						\
	xas_for_each(&xas, page, ULONG_MAX) {				\
		if (xas_retry(&xas, page) || xa_is_value(page)) {	\
			WARN_ON(1);					\
			break;						\
		}							\
		__v.bv_page = find_subpage(page, xas.xa_index);		\
		offset = (i->mapping_start + skip) & ~PAGE_MASK;	\
		seg = PAGE_SIZE - offset;			\
		__v.bv_offset = offset;				\
		__v.bv_len = min(n, seg);			\
		(void)(STEP);					\
		n -= __v.bv_len;				\
		skip += __v.bv_len;				\
		if (n == 0)					\
			break;					\
	}							\
	rcu_read_unlock();					\
	n = wanted - n;						\
}

Note that the walk is not restartable - and the array is supposed to have been
fully populated by the caller for the range specified - so I've made it print
a warning and end the loop if xas_retry() or xa_is_value() return true (which
takes care of the !page case too).  Possibly I could just leave it to fault in
this case and not check.

If PageHuge(page) is true, I presume I need to support that too.  How do I
find out how big the page is?

David

