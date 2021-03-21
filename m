Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8361C343089
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Mar 2021 02:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhCUBm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 21:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCUBml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 21:42:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56484C061574;
        Sat, 20 Mar 2021 18:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OHbnhUmSKXKUNQXDuUhAYkDR4SHYPZJ41RILLR4eq0o=; b=WJD6WJqsGwCY3P1j5e3ovPL//F
        5RbS0a3Lg88hg9MB0jYULiy/rFKJzbGCbrOapYTb266XbbyKA8CTrtvek66/nG33VaFg7VdMBRbZR
        rnPMGsBm9j06adyP+A8QTZhRk0UEwOFu8zRa/WX5OeKUuZ+8YrF+LcaXS/z87nWR3tKlZ6cwW0Syp
        kq9Y5/xMHFDtxNLwNsH9lKI3RuLMynoTNQK4hzK4Vqwfsf9J1ZXgGgduQBDRr8PlJm3OFdHS6ZrwQ
        3fhRurJFVDu4wmnenxltcI7MoWu83uWJo+ueqXyOwnSdoY74gjndAyvqk62MAvIAKmI/huMjFZFAX
        h7v56bTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNn6Q-006Ymd-I3; Sun, 21 Mar 2021 01:42:05 +0000
Date:   Sun, 21 Mar 2021 01:42:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        David Wysochanski <dwysocha@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/28] netfs: Provide readahead and readpage netfs
 helpers
Message-ID: <20210321014202.GF3420@casper.infradead.org>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539537375.286939.16642940088716990995.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161539537375.286939.16642940088716990995.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 04:56:13PM +0000, David Howells wrote:
> +void netfs_readahead(struct readahead_control *ractl,
> +		     const struct netfs_read_request_ops *ops,
> +		     void *netfs_priv)
> +{
> +	struct netfs_read_request *rreq;
> +	struct page *page;
> +	unsigned int debug_index = 0;
> +
> +	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
> +
> +	if (readahead_count(ractl) == 0)
> +		goto cleanup;
> +
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, ractl->file);
> +	if (!rreq)
> +		goto cleanup;
> +	rreq->mapping	= ractl->mapping;
> +	rreq->start	= readahead_pos(ractl);
> +	rreq->len	= readahead_length(ractl);
> +
> +	netfs_rreq_expand(rreq, ractl);
> +
> +	atomic_set(&rreq->nr_rd_ops, 1);
> +	do {
> +		if (!netfs_rreq_submit_slice(rreq, &debug_index))
> +			break;
> +
> +	} while (rreq->submitted < rreq->len);
> +
> +	while ((page = readahead_page(ractl)))
> +		put_page(page);

You don't need this pair of lines (unless I'm missing something).
read_pages() in mm/readahead.c puts the reference and unlocks any
pages which are not read by the readahead op.  Indeed, I think doing
this is buggy because you don't unlock the page.

> +	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
> +	if (atomic_dec_and_test(&rreq->nr_rd_ops))
> +		netfs_rreq_assess(rreq, false);
> +	return;
> +
> +cleanup:
> +	if (netfs_priv)
> +		ops->cleanup(ractl->mapping, netfs_priv);
> +	return;
> +}
> +EXPORT_SYMBOL(netfs_readahead);

> +int netfs_readpage(struct file *file,
> +		   struct page *page,
> +		   const struct netfs_read_request_ops *ops,
> +		   void *netfs_priv)
> +{
> +	struct netfs_read_request *rreq;
> +	unsigned int debug_index = 0;
> +	int ret;
> +
> +	_enter("%lx", page->index);
> +
> +	rreq = netfs_alloc_read_request(ops, netfs_priv, file);
> +	if (!rreq) {
> +		if (netfs_priv)
> +			ops->cleanup(netfs_priv, page->mapping);
> +		unlock_page(page);
> +		return -ENOMEM;
> +	}
> +	rreq->mapping	= page->mapping;

FYI, this isn't going to work with swap-over-NFS.  You have to use
page_file_mapping().

> +	rreq->start	= page->index * PAGE_SIZE;

and page_index() here.

I rather dislike it that swap-over-NFS uses readpage which makes this
need to exist.  If somebody were to switch SWP_FS_OPS to using kiocbs,
some of this pain could go away.

