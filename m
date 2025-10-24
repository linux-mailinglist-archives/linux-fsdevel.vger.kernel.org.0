Return-Path: <linux-fsdevel+bounces-65582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC29C08236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 22:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CA3B3622
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 20:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F22FCC0D;
	Fri, 24 Oct 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZCbzO11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27D2FBDF1;
	Fri, 24 Oct 2025 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339550; cv=none; b=Pq9L394wE1PdKgppq+ojJueM0i3GE+RLfTxuBw5nfcsizrdnPvxMEiMi2B0qSzTp/ANMqQcFtwEFNBVCdc7a1zCXFZiClE2zBXqsylayvB4iv8QWeMzWXzKhlAtkOZK62njkmHSB284OQC4xYVeuFKMpMR98SyY4ZrT//DklCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339550; c=relaxed/simple;
	bh=uVn4mMwStTMqcSqglqyzuyAKaEOTRTuZB51yl0EvXOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjTM5VQR2mwEQFIO45ilmLpLNHZvO2+KFyJl7+Bv+x19lfGFppVN8f6I6xsW4oyCkquzjkoxqFOUwItI0yLRmg4fPIXJkO2ZNnFoG6Ip3Pq/5rl6LbF/Kxr9aBRSyYClKAm3yK9HHhb51K+J2wVL6t8jSfsfUD1zMj9NYrsAkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TZCbzO11; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PsXLWgjSWFAJcPZbkMiI6wzRP5O/Fj0NLIbkGgGu18A=; b=TZCbzO11DeJICR2KI1ztu2LMM1
	uI6JuPDEefeVEIDzpb5WV+/ITAtKa4h8Qgz04SEChKPaamdBMzESvQinjAp9jD4QYKEZVXkhvlr27
	XPgPWv+CU2tzoIttT2506I/abi8dDqvF1ua4gS6cUrcqaA5x59T/XZ5YwONKPWkuTtH7xq7jvGR2i
	8Ve2bpMZ4jqeaoVHzsHejD2OzcRrszbFWbVVWjyOw06jFs8HUggRPbq1j79pYK9agB5Lm0lqodJHQ
	MoJFqru9VlWodYiw2Hyp0fu9WXUQrp20ypyK89hT9CqurmJnzLqe29CApZI0zedqrtsxHzQ3qgI/l
	yjgLQwkg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCOsH-0000000AZKY-3TRj;
	Fri, 24 Oct 2025 20:59:01 +0000
Date: Fri, 24 Oct 2025 21:59:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org,
	miklos@szeredi.hu, djwong@kernel.org, hch@infradead.org,
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org,
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
Message-ID: <aPvolbqCAr1Tx0Pw@casper.infradead.org>
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com>
 <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPu1ilw6Tq6tKPrf@casper.infradead.org>
 <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>

On Fri, Oct 24, 2025 at 12:22:32PM -0700, Joanne Koong wrote:
> > Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> > when testing (excluding performance testing of course; it'll do ugly
> > things to your performance numbers).
> 
> Point taken. It looks like there's a bunch of other memory debugging
> configs as well. Do you recommend enabling all of these when testing?
> Do you have a particular .config you use for when you run tests?

Our Kconfig is far too ornate.  We could do with a "recommended for
kernel developers" profile.  Here's what I'm currently using, though I
know it's changed over time:

CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PM_DEBUG=y
CONFIG_PM_SLEEP_DEBUG=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_PNP_DEBUG_MESSAGES=y
CONFIG_SCSI_DEBUG=m
CONFIG_EXT4_DEBUG=y
CONFIG_JFS_DEBUG=y
CONFIG_XFS_DEBUG=y
CONFIG_BTRFS_DEBUG=y
CONFIG_UFS_DEBUG=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_DWARF4=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
CONFIG_ARCH_HAS_EARLY_DEBUG=y
CONFIG_SLUB_DEBUG=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_SHRINKER_DEBUG=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM_IRQSOFF=y
CONFIG_DEBUG_VM=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_DEBUG_LIST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_FAULT_INJECTION_DEBUG_FS=y

(output from grep DEBUG .build/.config |grep -v ^#)

