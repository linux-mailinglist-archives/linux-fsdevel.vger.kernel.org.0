Return-Path: <linux-fsdevel+bounces-13085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1E86B155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0CB9B22981
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06178157E96;
	Wed, 28 Feb 2024 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K3ajiALY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20D1552F8
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129473; cv=none; b=tkxQRrPYrX7pt1fD6lK1PsbtVoniKgBaRyLhycbfZgnHTreGQySKO8uME5/EZXnK7JtBomy2idBxsRBEPqX8DE+w/PrD5/T6b0lNYIcozENKjprStUiJ0gH60R8R9RgcJHuCmTKfDV7xsRhjl1aM8AgCn0NWPCAuluLeG6Crr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129473; c=relaxed/simple;
	bh=NOeZg7n1rnLpDAaUysHN0n+UFwvBRYQQUMKyrvYERqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzjDPDX/FPem/tK+VJpiUpLQgjNKBg61id9oiLIzjXmpYUOYwshDBxfQA8tPfg+msmozww7oI17uK1dqBkmgOM5p9L5hzjCnALoI3hHEvjPWGfhbONczAUBFEax6H0GTOnxszi1u8gISe9G96CysT4J/nue3IplmfEQR2NzwuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K3ajiALY; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ozXeuEKBhGwaFu6uAoSEhqyiFnOGYyJ9Gq3+N2ervuc=; b=K3ajiALYn1JYBFPyeMEp/AIWVz
	ik3x94iFUKM5Rnzi+wN5jK9fk7TBBAKdAh9/hDq5g9McWLV5Qf49GBUVcRJdA7AUbjhjg+a8Ul8oU
	88l8BjTJcQ6K8hOYBSrWkVv6dfVcihesOJdMT6rxM49N1i3pZ8xNlFL4/mUMNLxwUAKXiA0Z9+zLV
	rs1U3oVd6hYSmXRWHYVrl401PP46H51L171Ivn4WqgHqzoC/f3O7RTlOQPSLsCbZ2XqiuyzbELoix
	5IVw+m583dfnZkN6qCY7yh3ul9vsOVkIkTit+u/LtotLfYh9isSp2PYirWU8KSmCHVCiI8qFiPA3I
	p/p39FxA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfKeI-00000005NjY-3Qpj;
	Wed, 28 Feb 2024 14:11:06 +0000
Date: Wed, 28 Feb 2024 14:11:06 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <Zd8--pYHdnjefncj@casper.infradead.org>
References: <20240228061257.GA106651@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228061257.GA106651@mit.edu>

On Wed, Feb 28, 2024 at 12:12:57AM -0600, Theodore Ts'o wrote:
> However, this proposed interface is highly problematic when it comes
> to buffered writes, and Postgress database uses buffered, not direct
> I/O writes.   Suppose the database performs a 16k write, followed by a
> 64k write, followed by a 128k write --- and these writes are done
> using a file descriptor that does not have O_DIRECT enable, and let's
> suppose they are written using the proposed RWF_ATOMIC flag.   In
> order to provide the (stronger than we need) RWF_ATOMIC guarantee, the
> kernel would need to store the fact that certain pages in the page
> cache were dirtied as part of a 16k RWF_ATOMIC write, and other pages
> were dirtied as part of a 32k RWF_ATOMIC write, etc, so that the
> writeback code knows what the "atomic" guarantee that was made at
> write time.   This very quickly becomes a mess.

I'm not entirely sure that it does become a mess.  If our implementation
of this ensures that each write ends up in a single folio (even if the
entire folio is larger than the write), then we will have satisfied the
semantics of the flag.

That's not to say that such an implementation would be easy.  We'd have
to be able to allocate a folio of the correct size (or fail the I/O),
and we'd have to cope with already-present smaller-than-needed folios
in the page cache, but it seems like a SMOP.

> Another interface that one be much simpler to implement for buffered
> writes would be one the untorn write granularity is set on a per-file
> descriptor basis, using fcntl(2).  We validate whether the untorn
> write granularity is one that can be supported when fcntl(2) is
> called, and we also store in the inode the largest untorn write
> granularity that has been requested by a file descriptor for that
> inode.  (When the last file descriptor opened for writing has been
> closed, the largest untorn write granularity for that inode can be set
> back down to zero.)

I'm not opposed to this API either.

> The write(2) system call will check whether the size and alignment of
> the write are valid given the requested untorn write granularity.  And
> in the writeback path, the writeback will detect if there are
> contiguous (aligned) dirty pages, and make sure they are sent to the
> storage device in multiples of the largest requested untorn write
> granularity.  This provides only the guarantees required by databases,
> and obviates the need to track which pages were dirtied by an
> RWF_ATOMIC flag, and the size of the RWF_ATOMIC write.

I think we'd be better off treating RWF_ATOMIC like it's a bs>PS device.
That takes two somewhat special cases and makes them use the same code
paths, which probably means fewer bugs as both camps will be testing
the same code.

