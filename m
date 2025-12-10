Return-Path: <linux-fsdevel+bounces-71039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F12CB20C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 07:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD2CD3086EAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FCD2C15B0;
	Wed, 10 Dec 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lTpfCNNp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C972621CC44;
	Wed, 10 Dec 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346676; cv=none; b=AzXoWaTwBgQVdZYk5zxybk4F5zIdGEXXitQe+GFGwUTSLWWv8ReGuqD+yx3Hu+HbKAa6XZavy60A0RcxP6yZ5xBO28clwiX64skfv3cCjeUvjqIRp9G8qGTES4OCv21X4gLcqOKlCYR6sgq9YU7iA858vecCweQc0dP6WhVw0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346676; c=relaxed/simple;
	bh=jNkMpSBANNWHKuEjybrUnhVPJ7HJykrjnIixvNfexiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8tZ4MC5dNZWESY3KmPGAanQKQBHprz1U40qCEdCwcY11pNqX/hb1f3wmqQ4RKHPxNWjuv5WfWXr6WNYyjIoyWJVdHK5hvuTn7LGffUUElcH4hm2KHJ21tIW88BGVMKpd/8X5GxFGOnhSMtNIz5wvZwQQmy6P0wpDFtM3BBWZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lTpfCNNp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZiFROAkHBJCB2v6ixbOIv0n0FEKpV73FVa0R0Tq7R8Q=; b=lTpfCNNpMhjjWeXhgYeBmyIHiO
	sf6ti+Rr5+mozQyCjgQy3fAWOmM0TrDtKu0Nyk0Y5z9aceLjuMfoMJ4/5sIDOMaPsmhe/Q4qD/6ke
	96wZr15qrZmdX/98eRhBB4Ht4ML+b/3SYwE0eRE8KiDwbfPNxYybh68pHZ6+zUfcW1TJbaWKz3Rvq
	uRtXyNJ1L/1n+B1SCCmI+ZwAo+zIs9lHURsZ313jCkFa4QByyRyfDdqP9Fi2h/2Fe6J5v4Getv4OP
	rnLIZ+OqODKsoPl9JSxSbtpUYtljUh6yFBgqTh+b11r6uXkpfgQa8HHT3bzwT6fmwBSWEuW44ECKd
	Hn//txew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTDJO-0000000F9od-0Zks;
	Wed, 10 Dec 2025 06:04:30 +0000
Date: Tue, 9 Dec 2025 22:04:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: asmadeus@codewreck.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aTkNbptI5stvpBPn@infradead.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 10, 2025 at 06:04:23AM +0900, Dominique Martinet via B4 Relay wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> When doing a loop mount of a filesystem over 9p, read requests can come
> from unexpected places and blow up as reported by Chris Arges with this
> reproducer:
> ```
> dd if=/dev/zero of=./xfs.img bs=1M count=300
> yes | mkfs.xfs -b size=8192 ./xfs.img
> rm -rf ./mount && mkdir -p ./mount
> mount -o loop ./xfs.img ./mount

We should really wire this up to xfstests so that all file systems
see the pattern of kmalloc allocations passed into the block layer
and then on to the direct I/O code.

> The problem is that iov_iter_get_pages_alloc2() apparently cannot be
> called on folios (as illustrated by the backtrace below), so limit what
> iov we can pin from !iov_iter_is_kvec() to user_backed_iter()

As willy pointed out this is a kmalloc.

And 9p (just like NFS) really needs to switch away from
iov_iter_get_pages_alloc2 to iov_iter_extract_pages, which handles not
just this perfectly fine but also fixes various other issues.

Note that the networking code still wants special treatment for kmalloc
pages, so you might have more work there.


