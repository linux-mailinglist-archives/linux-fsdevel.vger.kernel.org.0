Return-Path: <linux-fsdevel+bounces-71289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C95CBC95B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 239D73011FB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 05:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D2632694C;
	Mon, 15 Dec 2025 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zXkc9ptY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8D031CA4A;
	Mon, 15 Dec 2025 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778121; cv=none; b=X34wNOKmOtpSqxRK6v2GD30nf7oLNYzMNSKZ9906mGBVafftgNqFCUb8XyGAXrcNk+1omftJcvXvKCq0beiF2ftvmdx954cL3JIg9rtR+OqkU7/1m2tuVHL4UmCqMt5XIDVxJLXAUZefouwI3zQUftDbxO36BwfXr+R51E9Pz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778121; c=relaxed/simple;
	bh=pnEsgskKhuRzjbwLWyR9TcA96OvIJ0Oc/FxXuhbd2DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXDqlJYgmK6kTnWHqEEHgN7oux+avkzY8y3GvvD6dzQB+MZFUp2fO7weTL59N5FdvZg+F4cW8yBn45azsVxDhvWVpqmXlc1OkI1fEDqCNJLe7mQxduX+3PDMS9lg9W5TgbFP8YBGozhtM4sfduzjVg0FtQYJdWyQonxwtR3S7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zXkc9ptY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GTHYXVtkhoIJLUXU2/KEqNFZkJXJ8jXlXDEO+Y3552c=; b=zXkc9ptY+b/H5GZ4TcDCCiJQXv
	66DKyxLWMzQCvk+59++EksWxX8PUA9h/QA5BsLpsCe7pfqtd6UKNFy3As+eaZL53yBnngm9kS5pWe
	aYNrBWTjU8wPi5wYMApSnXSTxVMCiq5zGbjPIPrXbdip0qyHXMRZz6V0zKWGHXtFG9Ufd3dSZgPwK
	eMkaCZGdGySDDn6hxnd/P2LoN/tyACeZd/AbQo+uxcj7cUH/9I7H1KjgN2KTBTMegAM1uMCTkMt0b
	Fc8q28d26SeVnHX4QKMCapvLD7ZyAjQonXWYS18ec25A7C4nrqQXD0kWvdxh1/qRvlnzMYYVb5+Zt
	pf/sZ5Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV1Y8-0000000385X-0Tmb;
	Mon, 15 Dec 2025 05:55:12 +0000
Date: Sun, 14 Dec 2025 21:55:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: asmadeus@codewreck.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aT-iwMpOfSoRzkTF@infradead.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
 <aTkjWsOyDzXq_bLv@codewreck.org>
 <aTkwKbnXvUZs4UU9@infradead.org>
 <aT1qEmxcOjuJEZH9@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aT1qEmxcOjuJEZH9@codewreck.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

[Dave: netfs questions below, please read]

On Sat, Dec 13, 2025 at 10:28:50PM +0900, asmadeus@codewreck.org wrote:
> Christoph Hellwig wrote on Wed, Dec 10, 2025 at 12:32:41AM -0800:
> > > Looking at the implementation for iov_iter_extract_bvec_pages() it looks
> > > like it might not process all the way to the end, so we need to loop on
> > > calling iov_iter_extract_pages()? (I see networking code looping on
> > > "while (iter->count > 0)")
> > 
> > Yes.
> 
> Ok, I don't understand why the current code locks everything down and
> wants to use a single scatterlist shared for the whole channel (and
> capped to 128 pages?), it should only need to lock around the
> virtqueue_add_sg() call, I'll need to play with that some more.

What do you mean with "lock down"?

> Looking at other virtio drivers I could probably use a sg_table and
> have extract_iter_to_sg() do all the work for us...

Looking at the code I'm actually really confused.  Both because I
actually though we were talking about the 9fs direct I/O code, but
that has actually been removed / converted to netfs a long time ago.

But even more so what the net/9p code is actually doing..  How do
we even end up with user addresses here at all?

Let me try to understand things:

 - p9_virtio_zc_request is the only instances of the p9_trans_module
   zc_request operation.
 - zc_request only gets called by p9_client_zc_rpc
 - p9_client_zc_rpc gets called by p9_client_read_once, p9_client_write,
   p9_client_write_subreq and p9_client_readdir

Let's go through these:

 - p9_client_write_subreq is entirely unused
 - p9_client_readdir builds a local iov_iter_kvec
 - p9_client_read_once is only called by p9_client_read, and really
   should be marked static.
 - p9_client_read is called by v9fs_issue_read on a netfs iov_iter
   and by v9fs_dir_readdir and v9fs_fid_xattr_get on a local kvec iter
 - p9_client_write is called with a iov_iter_kvec from
   v9fs_fid_xattr_set, and with a netfs-issued iov_iter by
   v9fs_issue_write
 
So right now except for netfs everything is on a kvec.  Dave, what
kind of iov_iter does netfs send down to the file system?  I had
a bit of a hard time reading through it, but I'd expect that any
page pinning would be done in netfs and not below it?  Why are we
using iov_iters here and not something like a bio_vec?  What is
the fs / transport supported to do with these iters?

Ignoring the rest of the mail for now, because I suspect the outcome
of the above might make it irrelevant, but I'll come back to it if
needed.

