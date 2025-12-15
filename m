Return-Path: <linux-fsdevel+bounces-71296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCE3CBCCFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 08:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2E13012969
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F85331A53;
	Mon, 15 Dec 2025 07:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Nsmmu+CL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541563314BF;
	Mon, 15 Dec 2025 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784084; cv=none; b=H8miOwoHaiHjH0xnUrMtLNCGzAftEnSk34NGr8wWvheeM5lqCabylnaq6/AimncAdwC5tmHNuNz/Yg255YKChHFH5dSYVKwwWIStF5eK/4KW3Y8+J/Ah7wSNqKeWPYDWKnrG6UUwz0+L8Q+W5QRYcjWRZeaXWSMF1r2pnQ2cTRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784084; c=relaxed/simple;
	bh=zbm+jqicToWboMwjagVc8RU32WHSJ+AtB3NYb5q848E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wx+oUXdxq3clDHQuN/Xb7mWMWJMhpTKtu9wM/pcwV//I5eMaORhXS2TgpX3kl0v2Gd3mrQbEYmlIMLXP4Fy3FQHOYrrJFdRB/XobUpteZmPDfyPVUBjAC2BjtRI70wBVTU/w9ZeRKm2JjQWnlUO4qobuhK2VHC16vIQsFBxX+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Nsmmu+CL; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B179F14C2D6;
	Mon, 15 Dec 2025 08:34:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1765784072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/z98N9MJ0ct+E35eqpP5x8fOWj2e48oc+gfqMBBA8I=;
	b=Nsmmu+CLUPXePqnoeu5iLNIa8ueRMbyphYpZBgHEAFH+lJbXqhYlCZyWQtK1hS4bCjVEb8
	ayZ9C0gwU0w2FhFnUWDDSlDTcZ1hQyyxMUTQUIQB9OfJ5RhkWb56nFxc5376+GoBPZ6cYI
	DKmSR/YMD/Pa6eKqZmJl5nlQPtyr3ULVWOKEEvOK4on3jioZ3tC7LRUu5VP5cA/k4+Wr+u
	+WAYXzHnfGNT4hXf/nszH/FSV1i7mJ2YEgG07s7y2DIEkNTLqfPdGM0V/LWVHPcqOzDMUk
	H39j7QLwKFASohDGc+Qas2OdBiHGlf9N6bmLnVFMFeu9a97cUOgaaWQvCWdCmA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 27c7665d;
	Mon, 15 Dec 2025 07:34:27 +0000 (UTC)
Date: Mon, 15 Dec 2025 16:34:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
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
Message-ID: <aT-59HURCGPDUJnZ@codewreck.org>
References: <20251210-virtio_trans_iter-v1-1-92eee6d8b6db@codewreck.org>
 <aTkNbptI5stvpBPn@infradead.org>
 <aTkjWsOyDzXq_bLv@codewreck.org>
 <aTkwKbnXvUZs4UU9@infradead.org>
 <aT1qEmxcOjuJEZH9@codewreck.org>
 <aT-iwMpOfSoRzkTF@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aT-iwMpOfSoRzkTF@infradead.org>


Thanks for having a look

Christoph Hellwig wrote on Sun, Dec 14, 2025 at 09:55:12PM -0800:
> > Ok, I don't understand why the current code locks everything down and
> > wants to use a single scatterlist shared for the whole channel (and
> > capped to 128 pages?), it should only need to lock around the
> > virtqueue_add_sg() call, I'll need to play with that some more.
> 
> What do you mean with "lock down"?

Just the odd (to me) use of the chan->lock around basically all of
p9_virtio_request() and most of p9_virtio_zc_request() -- I'm not pretty
sure this was just the author trying to avoid an allocation by recycling
the chan->sg array around though, so ignore this.

> > Looking at other virtio drivers I could probably use a sg_table and
> > have extract_iter_to_sg() do all the work for us...
> 
> Looking at the code I'm actually really confused.  Both because I
> actually though we were talking about the 9fs direct I/O code, but
> that has actually been removed / converted to netfs a long time ago.
>
> But even more so what the net/9p code is actually doing..  How do
> we even end up with user addresses here at all?

FWIW I tried logging and saw ITER_BVEC, ITER_KVEC and ITER_FOLIOQ --
O_DIRECT writes are seen as BVEC so I guess it's not as direct as I
expected them to be -- that code could very well be leftovers from
the switch to iov_iter back in 2015...

(I'm actually not sure why Christian suggested checking for is_iovec()
in https://lkml.kernel.org/r/2245723.irdbgypaU6@weasel -- then I
generalized it to user_backed_iter() and it just worked because checking
for that moved out bvec and folioq from iov_iter_get_pages_alloc2()
to... something that obviously should not work in my opinion but
apparently was enough to not trigger this particular BUG.)


> Let me try to understand things:
> 
>  - p9_virtio_zc_request is the only instances of the p9_trans_module
>    zc_request operation.
>  - zc_request only gets called by p9_client_zc_rpc
>  - p9_client_zc_rpc gets called by p9_client_read_once, p9_client_write,
>    p9_client_write_subreq and p9_client_readdir
> 
> Let's go through these:
> 
>  - p9_client_write_subreq is entirely unused

Let's remove that.. I'll send a patch later.

>  - p9_client_readdir builds a local iov_iter_kvec
>  - p9_client_read_once is only called by p9_client_read, and really
>    should be marked static.

agreed, will cleanup too.

>  - p9_client_read is called by v9fs_issue_read on a netfs iov_iter
>    and by v9fs_dir_readdir and v9fs_fid_xattr_get on a local kvec iter
>  - p9_client_write is called with a iov_iter_kvec from
>    v9fs_fid_xattr_set, and with a netfs-issued iov_iter by
>    v9fs_issue_write
>  
> So right now except for netfs everything is on a kvec.  Dave, what
> kind of iov_iter does netfs send down to the file system?  I had
> a bit of a hard time reading through it, but I'd expect that any
> page pinning would be done in netfs and not below it?  Why are we
> using iov_iters here and not something like a bio_vec?  What is
> the fs / transport supported to do with these iters?
> 
> Ignoring the rest of the mail for now, because I suspect the outcome
> of the above might make it irrelevant, but I'll come back to it if
> needed.

(waiting for David's answer here, but as far as I see the contract
between the transport and the vfs is that the transport should handle
whatever it's being fed, so it doesn't really matter if it's a bio_vec
or an iov_iter -- ultimately virtio or whatever backend that wants to
handle zc likely won't handle bio_vec any better so it'll need
converting anyway)


Thanks,
-- 
Dominique Martinet | Asmadeus

