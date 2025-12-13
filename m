Return-Path: <linux-fsdevel+bounces-71249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C778CBB007
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 14:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F26483002513
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAF3093B6;
	Sat, 13 Dec 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="3Z+TzU3Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1C2FF17F;
	Sat, 13 Dec 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765632561; cv=none; b=B2mf4GbRg0+NtZ+aCz2Kx76Ut63epz4RGzHJdQRT4yveP+UxwxcsgT1OSaP8YyQrq8AC7b+RiLrsSu3dbPZlVFryCaNy2UUjc1MBbPYS/tZaW/07aXYlH2FYXQ54KeVnb7gCNeNJzCVnxI39NGZZg+zGq7D8tLO+DACLldJ5MuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765632561; c=relaxed/simple;
	bh=xPTBpQwaM2O2EIKQCtfGy0E5hVuJYhTwisqtEsy0Ehs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn323tRDEOvXhJFlCPDdJKt84/iKJdwgBS20frhlqh0WHZkUpRcWoW2TwrWFzyZbhv2LzT7E8fMLFw4CcNtx8NIc1cLNHeeBAA/UF8nJazYg0ZlaTIA1jwY8K+P/J/sYbt9T2BHLHymUWW3mzK5bWg87r0fiMFhoFXu5m4B6128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=3Z+TzU3Y; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7C3EF14C2D6;
	Sat, 13 Dec 2025 14:29:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1765632550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l81bM0dD8P2a5n6NhQ/pPLzgNAbcgOGNQqOaIIPkEUM=;
	b=3Z+TzU3Y8x7AKnf4KM5ZBYBpvw+D8GT5oU0JWJbxdm6b9pzwzY6zFPEW6+9mM3qhLaN+UJ
	rWSyTkuEvd5gpRJXOfVtZ4c3jGWWzpwrJ7Q8D1J1/V2YyeH85tsu3XsLTTgIFoYlDomelf
	fOrmX5lZtRRar68jDDoylDLrKzRXMElAGsq+Oq0ttPUixbpFlSby6530CLm/KHYNWrW2N6
	JgdGRErAOGAXdXxxx4E5ZbWnXaS5AwzYpxGM8Y/qz6UxTnNGGzqqIEuzF3U9FRvdHeqCev
	L7rXzhZRzFp4arsRu+8sSXz8OidBea4y0GiUvVk0aMHULVG4kuchZQUhnyjOcQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 36149253;
	Sat, 13 Dec 2025 13:29:05 +0000 (UTC)
Date: Sat, 13 Dec 2025 22:28:50 +0900
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
Message-ID: <aT1qEmxcOjuJEZH9@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
 <aTkjWsOyDzXq_bLv@codewreck.org>
 <aTkwKbnXvUZs4UU9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTkwKbnXvUZs4UU9@infradead.org>

Christoph Hellwig wrote on Wed, Dec 10, 2025 at 12:32:41AM -0800:
> > Looking at the implementation for iov_iter_extract_bvec_pages() it looks
> > like it might not process all the way to the end, so we need to loop on
> > calling iov_iter_extract_pages()? (I see networking code looping on
> > "while (iter->count > 0)")
> 
> Yes.

Ok, I don't understand why the current code locks everything down and
wants to use a single scatterlist shared for the whole channel (and
capped to 128 pages?), it should only need to lock around the
virtqueue_add_sg() call, I'll need to play with that some more.

Looking at other virtio drivers I could probably use a sg_table and
have extract_iter_to_sg() do all the work for us...

> > I'll send a v2 with that when I can
> 
> You looked into this already, but in case you haven't seen it yet,
> don't forget to call unpin_user_folio on the completion side as well.

Thanks for bringing this up -- I'm not sure I understand how to decide
on what to cleanup with... Depending on the type of pages it's not
necessarily unpin_user_folio() is it? Or will it just ignore anything
else?
Ah, the caller must check iov_iter_extract_will_pin(iter), then it looks
like I'm free to call unpin_user_page() (or unpin_folio() which is the
same without pinned check) -- unpin_user_folio() would allow unpining
multiple pages within a folio, but iov_iter_extract_pages() doesn't give
us folios that could be used like that)


FWIW, the comment at the top of extract_iter_to_sg() says:
> The iov_iter_extract_mode() function should be used to query how cleanup
but I couldn't find any such function (even back when this comment was
added to netfs code in 2023...), the two copies of this comment probably
could use updating... David?


> > While I have your attention, there's some work to move away from large
> > (>1MB) kmalloc() in the non-zerocopy case into kvmalloc() that might not
> > be contiguous (see commit e21d451a82f3 ("9p: Use kvmalloc for message
> > buffers on supported transports") that basically only did that for
> > trans_fd), there's no iov_iter involved so it's off topic but how would
> > one get around "extracting pages" out of that?
> 
> vmalloc and I/O is in general problematic, because you need special
> calls to flush the cached for VIVT caches:
> flush_kernel_vmap_range / invalidate_kernel_vmap_range.
> 
> If you want to stuff that into an iov_iter, the only sane way is to
> call vmalloc_to_page and build a bvec iter from that at the moment.
> You also need to do the flush_kernel_vmap_range /
> invalidate_kernel_vmap_range in the caller for it.

Thanks, this is on the virtio/network side so I don't need an iov_iter,
but I agree virtio will not like vmap addresses as well -- I'd want to
resolve and pin the backing pages and pass that to a scatterlist like
we're doing here... Looking at extract_kvec_to_sg() it's just calling
vmalloc_to_page() on the the kvec address if it's a vmalloc address, so
no pin, so I guess pin might not be needed?
I was under the impression that vmalloc meant the kernel could shuffle
the physical data under us when we're not scheduled, but I'm really not
familiar enough with these memory management details; let's focus on the
bug at hands first...
I'll (eventually) poke back at this after we're all happy with the
zero-copy side.


> > I *think* we're fine on this end, as it's just passing the buffers into
> > a sg list for virtio, as long as things don't move under the caller I
> > assume they don't care...
> 
> Ok, if your backend is virtio that's fine.  If it's actual 9p over the
> network you might still into issues, though.

TCP and other transports don't do zero-copy straight into the iov_iter,
so virtio is our only problem right now -- thanksfully! :)


Thanks,
-- 
Dominique Martinet | Asmadeus

