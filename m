Return-Path: <linux-fsdevel+bounces-40451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDDA2372D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBE81629C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4541B4156;
	Thu, 30 Jan 2025 22:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElrzF0TD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9812E7E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738275772; cv=none; b=Hqe7IHe/kyGGuEIGYpKXIFSpk1cfn2cho1zuUwKJFBREtUfiKGvIGtAQMGHqUlJXOt7qEkQ2+KyI9ygxo5Agae2l4V+mtUuSUheXIfwI71CqcFQKzowUNztloi7wAJ4FHFO2g3yi6PqQKRBSZhF1VKWbza0Swen+3RVhFqTJGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738275772; c=relaxed/simple;
	bh=s5QSv/a6s53rsvZ2R0YdTIm1T5Ooq72fFr/hbYtrXC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLGYR7IdcANqarI9h0CBEShXS6XjndCxBWHxpBu8xixbQRGTtbWNAx4YAt5/G+MhtIxTJSmtNXUY/FC55pCwUW23GtkI/oQs0ta1T0CZH5uGzwsDUfi9dBXBl4ko+5lX3zAkwxJt7XTgu4erIGjLagT9rhAYUdmxEtR3Zok1wxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElrzF0TD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B3CC4CED2;
	Thu, 30 Jan 2025 22:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738275771;
	bh=s5QSv/a6s53rsvZ2R0YdTIm1T5Ooq72fFr/hbYtrXC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElrzF0TDmiHG/x75Iq6BKvxy/uAy8t4LmczKD5qHSv8fTlEMVGIaFnsoq1FusnRgr
	 moZ1pmPpJbHm2lAjQzvFOBmcEBVzIokiNioPKXSEJqt30DvTrrbKDavMdG+ZWXr1XC
	 eXakH7mFELxT1d/JgFycfxaYO6VS+Y6ee7t/1i1U80rIX7LpKFgmT67A+AUszD9QNs
	 UsrdggeAM3JGbOTzKdAIwZh0LrdwPXQ7pKWDNn9W98ybt3zQWBGm2xFv5/OR7FBT/4
	 QiBNs+hxMjQST4fEAcRAHWzwQvTzGLRvOw6g7TyrnbbYLyMiP02qSdHekZdCJ8qXxn
	 S66lIzb4e1opw==
Date: Thu, 30 Jan 2025 15:22:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>, Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Message-ID: <Z5v7uJF7TPPEe6TI@kbusch-mbp>
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>

On Thu, Jan 30, 2025 at 01:28:55PM -0800, David Wei wrote:
> Hi folks, I want to propose a discussion on adding zero copy to FUSE
> io_uring in the kernel. The source is some userspace buffer or device
> memory e.g. GPU VRAM. The destination is FUSE server in userspace, which
> will then either forward it over the network or to an underlying
> FS/block device. The FUSE server may want to read the data.
> 
> My goal is to eliminate copies in this entire data path, including the
> initial hop between the userspace client and the kernel. I know Ming and
> Keith are working on adding ublk zero copy but it does not cover this
> initial hop and it does not allow the ublk/FUSE server to read the data.

If the server side has to be able to access the data for whatever
reason, copying does appear to be the best option for compatibility. But
if the server doesn't need to see the data, it's very efficient to reuse
the iov from the original IO without bringing it into a different
process' address space.

> My idea is to use shared memory or dma-buf, i.e. the source data is
> encapsulated in an mmap()able fd. The client and FUSE server exchange
> this fd through a back channel with no kernel involvement. The FUSE
> server maps the fd into its address space and registers the fd with
> io_uring via the io_uring_register() infra. When the client does e.g. a
> DIO write, the pages are pinned and forwarded to FUSE kernel, which does
> a lookup and understands that the pages belong to the fd that was
> registered from the FUSE server. Then io_uring tells the FUSE server
> that the data is in the fd it registered, so there is no need to copy
> anything at all.
> 
> I would like to discuss this and get feedback from the community. My top
> question is why do this in the kernel at all? It is entirely possible to
> bypass the kernel entirely by having the client and FUSE server exchange
> the fd and then do the I/O purely through IPC.

This kind of sounds like "paravirtual" features, in that both sides need
to cooperate to make use of the enhancement. Interesting thought that if
everyone is going this far to bypass memory copies, it doesn't look like
much more of a heavy lift to just bypass the kernel too. There's
probably value in retaining the filesystem semantics, though.

