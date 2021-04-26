Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CD136B96F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhDZSze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbhDZSy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:54:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7754AC061574;
        Mon, 26 Apr 2021 11:54:16 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb6N2-008TLy-M3; Mon, 26 Apr 2021 18:54:12 +0000
Date:   Mon, 26 Apr 2021 18:54:12 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
Message-ID: <YIcMVCkp4xswHolw@zeniv-ca.linux.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 02:28:01PM +0100, David Howells wrote:
> -#define iterate_all_kinds(i, n, v, I, B, K) {			\
> +#define iterate_xarray(i, n, __v, skip, STEP) {		\
> +	struct page *head = NULL;				\
> +	size_t wanted = n, seg, offset;				\
> +	loff_t start = i->xarray_start + skip;			\
> +	pgoff_t index = start >> PAGE_SHIFT;			\
> +	int j;							\
> +								\
> +	XA_STATE(xas, i->xarray, index);			\
> +								\
> +	rcu_read_lock();						\
> +	xas_for_each(&xas, head, ULONG_MAX) {				\
> +		if (xas_retry(&xas, head))				\
> +			continue;					\

OK, now I'm really confused; what's to guarantee that restart will not have
you hit the same entry more than once?  STEP might be e.g.

		memcpy_to_page(v.bv_page, v.bv_offset,
			       (from += v.bv_len) - v.bv_len, v.bv_len)

which is clearly not idempotent - from gets incremented, after all.
What am I missing here?

> +		if (WARN_ON(xa_is_value(head)))				\
> +			break;						\
> +		if (WARN_ON(PageHuge(head)))				\
> +			break;						\
> +		for (j = (head->index < index) ? index - head->index : 0; \
> +		     j < thp_nr_pages(head); j++) {			\
> +			__v.bv_page = head + j;				\
> +			offset = (i->xarray_start + skip) & ~PAGE_MASK;	\
> +			seg = PAGE_SIZE - offset;			\
> +			__v.bv_offset = offset;				\
> +			__v.bv_len = min(n, seg);			\
> +			(void)(STEP);					\
> +			n -= __v.bv_len;				\
> +			skip += __v.bv_len;				\
> +			if (n == 0)					\
> +				break;					\
> +		}							\
> +		if (n == 0)						\
> +			break;						\
> +	}							\
> +	rcu_read_unlock();					\
> +	n = wanted - n;						\
> +}
