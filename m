Return-Path: <linux-fsdevel+bounces-71040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA48CB2499
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 08:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79A0311E69E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD0D314B65;
	Wed, 10 Dec 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="VZdC5rnk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F92FE079;
	Wed, 10 Dec 2025 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765352313; cv=none; b=sYbMqAMLyfAkrD9eSRxaOsMXiiGE9PwRULzMO5ijF7hTTqkeaVT1gxg+kVNcl9JyGQMfyvm9GE44ylCmQdqHcFudiQuuNU41a/eXkLglA0AzIELzqLMeLKCvWPXwWrUUsou3+gBuRm7+ZSbiIFTB7xGfRmS/JAuh/rMBPVHFUpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765352313; c=relaxed/simple;
	bh=TwDoHVmEzEDvdSXCBVNneHSv/Q+x8OGpudS3aUKYeS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZI+Tv0dIgCVz3q/ZEm06WEJk56ZBcAxelKxVQ5hvgIMyOxTLjX5OY/P9oo27ifqCsBXChE/m3aQaQPy/6dusaa0efppSPzvx2C8X/wob1haV/W+zu30wdtCnZcl8eGFTOFjE0bOsnBGfw5MxZurKZbVv3hVWReKDEKAIypESnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=VZdC5rnk; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A010114C2D6;
	Wed, 10 Dec 2025 08:38:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1765352302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4rr64+/gi/yJb380jzWMQL6rUN02oFyHv+ubmApo7mE=;
	b=VZdC5rnkRkEW+cSxecmoCYneIsQVgsk3JIo+JMsx6I1H9gJHZ8oY2shar6H8BKti9vtUjz
	59zV/49TBLY6nye6HCDgykxVkuxCGqB/cAzUQYkySDzleA/2GqTW2JqBgxa7JGoUnQCgAd
	5KUXOBAEh85bKf1aN2Dx76YLbDpClWEL+GtzL9Us9lYwsJx1AYjonZmJppigME/gPU285N
	9pb+EbP+PL2k86JWBFVy9oEC0+FpgbikI0klH3A8B6RywWN6wslfhAd3MdTWjMVTMoiWAa
	EogYVUdqIPdP1HROO5Tmwk63aaHQGC51Io11DUP/rAM1QZNyabMjKf07c15kOA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 7389ebf7;
	Wed, 10 Dec 2025 07:38:17 +0000 (UTC)
Date: Wed, 10 Dec 2025 16:38:02 +0900
From: asmadeus@codewreck.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH] 9p/virtio: restrict page pinning to user_backed_iter()
 iovec
Message-ID: <aTkjWsOyDzXq_bLv@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTkNbptI5stvpBPn@infradead.org>

Christoph Hellwig wrote on Tue, Dec 09, 2025 at 10:04:30PM -0800:
> On Wed, Dec 10, 2025 at 06:04:23AM +0900, Dominique Martinet via B4 Relay wrote:
> > From: Dominique Martinet <asmadeus@codewreck.org>
> > 
> > When doing a loop mount of a filesystem over 9p, read requests can come
> > from unexpected places and blow up as reported by Chris Arges with this
> > reproducer:
> > ```
> > dd if=/dev/zero of=./xfs.img bs=1M count=300
> > yes | mkfs.xfs -b size=8192 ./xfs.img
> > rm -rf ./mount && mkdir -p ./mount
> > mount -o loop ./xfs.img ./mount
> 
> We should really wire this up to xfstests so that all file systems
> see the pattern of kmalloc allocations passed into the block layer
> and then on to the direct I/O code.

Note this doesn't seem to reproduce on my test VM so I'm not sure what
kind of precondition there is to going through this code...

> > The problem is that iov_iter_get_pages_alloc2() apparently cannot be
> > called on folios (as illustrated by the backtrace below), so limit what
> > iov we can pin from !iov_iter_is_kvec() to user_backed_iter()
> 
> As willy pointed out this is a kmalloc.

Ok I got confused because of the VM_BUG_ON_FOLIO(), but looking back
it's in a folio_get() called directly from __iov_iter_get_pages_alloc()
so that was likely a bvec...
My points of "but there's a case for it in __iov_iter_get_pages_alloc()"
and "we have no idea what to do" still stand though, but you answered
that below:

> And 9p (just like NFS) really needs to switch away from
> iov_iter_get_pages_alloc2 to iov_iter_extract_pages, which handles not
> just this perfectly fine but also fixes various other issues.

Ok, so we can remove the special branch for kvec and just extract pages
with this.
I understand it pins user spaces pages, so there's no risk of it moving
under us during the IO, and there's nothing else we need to do about it?

Looking at the implementation for iov_iter_extract_bvec_pages() it looks
like it might not process all the way to the end, so we need to loop on
calling iov_iter_extract_pages()? (I see networking code looping on
"while (iter->count > 0)")

I'll send a v2 with that when I can


While I have your attention, there's some work to move away from large
(>1MB) kmalloc() in the non-zerocopy case into kvmalloc() that might not
be contiguous (see commit e21d451a82f3 ("9p: Use kvmalloc for message
buffers on supported transports") that basically only did that for
trans_fd), there's no iov_iter involved so it's off topic but how would
one get around "extracting pages" out of that?

> Note that the networking code still wants special treatment for kmalloc
> pages, so you might have more work there.

I *think* we're fine on this end, as it's just passing the buffers into
a sg list for virtio, as long as things don't move under the caller I
assume they don't care...


Thanks,
-- 
Dominique Martinet | Asmadeus

