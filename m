Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8407E36945A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 16:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhDWOHh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhDWOHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:07:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC135C061574;
        Fri, 23 Apr 2021 07:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S30ovdpPLsZJJVMtk7+hTOIHIzuBQqKDqd/E3ECGbNY=; b=PUO+5rd07iXw0IxIrYHPsCwBLF
        T5s9+4Gxq1Pd8hfLwuRHgFQnchpJzv4LivhtWC7t7a2k+z7zF0UURKHVsr3zhWI0jwEt2Xb9LhYfh
        S0bUhYDXHhGLnf56/p+MZuW1m0Q6D9mYBmQzMqKkzaYGoWVCQYSZYT67l/ARCzaj+dc6bFHCsHpzD
        be96Zbyrbq1SJJbDUhjC/2c9XNN0uvvHL3Ky34MNMADISOaMjW5NjOuuspzxLTtdyFVy9KM4eLOSm
        r6rKv9II+8C9MFuJooOLgMCL2z+QAeEjwZHDZ6TtW2ivmX6FtTqMIWOcubYB2TqpRwzNkLSTW520a
        wpnjlzHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZwRu-001x7h-0W; Fri, 23 Apr 2021 14:06:30 +0000
Date:   Fri, 23 Apr 2021 15:06:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20210423140625.GC235567@casper.infradead.org>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
 <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 02:28:01PM +0100, David Howells wrote:
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
> +		if (WARN_ON(xa_is_value(head)))				\
> +			break;						\
> +		if (WARN_ON(PageHuge(head)))				\
> +			break;						\
> +		for (j = (head->index < index) ? index - head->index : 0; \
> +		     j < thp_nr_pages(head); j++) {			\

if head->index > index, something has gone disastrously wrong.

		for (j = index - head->index; j < thp_nr_pages(head); j++) { \

would be enough.

However ... the tree you were originally testing this against has the
page cache fixed to use only one entry per THP.  The tree you want to
apply this to inserts 2^n entries per THP.  They're all the head page,
but they're distinct entries as far as xas_for_each() is concerned.
So I think the loop you want looks like this:

+	rcu_read_lock();						\
+	xas_for_each(&xas, head, ULONG_MAX) {				\
+		if (xas_retry(&xas, head))				\
+			continue;					\
+		if (WARN_ON(xa_is_value(head)))				\
+			break;						\
+		if (WARN_ON(PageHuge(head)))				\
+			break;						\
+		__v.bv_page = head + index - head->index;		\
+		offset = offset_in_page(i->xarray_start + skip);	\
+		seg = PAGE_SIZE - offset;				\
+		__v.bv_offset = offset;					\
+		__v.bv_len = min(n, seg);				\
+		(void)(STEP);						\
+		n -= __v.bv_len;					\
+		skip += __v.bv_len;					\
+		if (n == 0)						\
+			break;						\
+	}								\
+	rcu_read_unlock();						\

Now, is this important?  There are no filesystems which do I/O to THPs
today.  So it's not possible to pick up the fact that it doesn't work,
and I hope to have the page cache fixed soon.  And fixing this now
will create more work later as part of fixing the page cache.  But I
wouldn't feel right not mentioning this problem ...

(also, iov_iter really needs to be fixed to handle bvecs which cross
page boundaries, but that's a fight for another day)
