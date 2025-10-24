Return-Path: <linux-fsdevel+bounces-65583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3524DC0833F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 23:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86A194EC399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DB30AAD2;
	Fri, 24 Oct 2025 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbN+kR+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673911D61B7;
	Fri, 24 Oct 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341849; cv=none; b=CntJKHx+KcLrXMSFwjNfw15GeqbI+xnxGtX9hHxETAjMz/+2fIIjW3CxCF6ZhB6EXvZ0Ce5aXaTTwD3StCuUer2l6Wrb11XefZ5hUi0QOgGMM1XrkuqGW23yIQidLWQ4xnZDqIMP9S8KkI8A0MPMKyyq5+0WtMviPHS1i7mrDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341849; c=relaxed/simple;
	bh=JGFHKzOCSuBxgkJ1cFZPD1F5rjn/Tfu8Ulz0zN8GHws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGWqVV8Q1bMiW7WDXSRr+kDK+mFTFM/Lpy7I3uKM1EVh9PvJq3QNUfR9t/dwsqc0AtzMXYpiGG9ZuGqMe9U9KR3xjUXA+n6kJyAlnvvBMvXmn3xLzMRDdzOBQlxUcmcpcWmsPkk+ae8xQGBxLqqQDl1HJMxe4l//UZMEEwX5rUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbN+kR+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DF7C4CEF1;
	Fri, 24 Oct 2025 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761341849;
	bh=JGFHKzOCSuBxgkJ1cFZPD1F5rjn/Tfu8Ulz0zN8GHws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbN+kR+DttC8Dct5cPj88N6eODAp7yTlBhv4+UGM0xUDwKMpVlFlf+coH9ZF/yNZ1
	 oEPtb+FB0D7yEFSYOJg+LqRN2+M3/xdv0k7OmKQVM5zknfUxAlOXgWztMjc9xT8niX
	 J+/A33PyypvAIUXnvBpoV7evPZZTyu0A8U917z1vh3pwmnsaMjT1oZDsp2QGK4CORQ
	 BmoBhVsL9RE/w0LdfprxlukaBxAa8xuI7FU87xqrLgG2ToQYXchJqyPbUFLGx0gYtb
	 bPlPYINocxKx5NfgS7hkA99m7YV3mWLTVbaDjIAyjLZRX4+m4BOp0lJTso4xMyCici
	 nfo5Bai+3wi6w==
Date: Fri, 24 Oct 2025 14:37:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>, brauner@kernel.org,
	miklos@szeredi.hu, hch@infradead.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
Message-ID: <20251024213728.GL4015566@frogsfrogsfrogs>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com>
 <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPu1ilw6Tq6tKPrf@casper.infradead.org>
 <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
 <aPvolbqCAr1Tx0Pw@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvolbqCAr1Tx0Pw@casper.infradead.org>

On Fri, Oct 24, 2025 at 09:59:01PM +0100, Matthew Wilcox wrote:
> On Fri, Oct 24, 2025 at 12:22:32PM -0700, Joanne Koong wrote:
> > > Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> > > when testing (excluding performance testing of course; it'll do ugly
> > > things to your performance numbers).
> > 
> > Point taken. It looks like there's a bunch of other memory debugging
> > configs as well. Do you recommend enabling all of these when testing?
> > Do you have a particular .config you use for when you run tests?
> 
> Our Kconfig is far too ornate.  We could do with a "recommended for
> kernel developers" profile.  Here's what I'm currently using, though I
> know it's changed over time:

Is there any chance you could split the VM debug checks into cheap and
expensive ones, and create another kconfig option so that we could do
the cheap checks without having fstests take a lot longer?

You could also implement shenanigans like the following:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=djwong-wtf&id=b739fff870384fd239abfd99ecee6bc47640794d

To enable the expensive checks at runtime.

(Yeah, I know, this is probably a 2 year project + bikeshed score of at
least 30...)

--D

> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_PM_DEBUG=y
> CONFIG_PM_SLEEP_DEBUG=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_BLK_DEBUG_FS=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> CONFIG_SCSI_DEBUG=m
> CONFIG_EXT4_DEBUG=y
> CONFIG_JFS_DEBUG=y
> CONFIG_XFS_DEBUG=y
> CONFIG_BTRFS_DEBUG=y
> CONFIG_UFS_DEBUG=y
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_DWARF4=y
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
> CONFIG_DEBUG_FS=y
> CONFIG_DEBUG_FS_ALLOW_ALL=y
> CONFIG_ARCH_HAS_EARLY_DEBUG=y
> CONFIG_SLUB_DEBUG=y
> CONFIG_ARCH_HAS_DEBUG_WX=y
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> CONFIG_SHRINKER_DEBUG=y
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
> CONFIG_DEBUG_VM_IRQSOFF=y
> CONFIG_DEBUG_VM=y
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_MEMORY_INIT=y
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_DEBUG_LIST=y
> CONFIG_X86_DEBUG_FPU=y
> CONFIG_FAULT_INJECTION_DEBUG_FS=y
> 
> (output from grep DEBUG .build/.config |grep -v ^#)

