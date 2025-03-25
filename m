Return-Path: <linux-fsdevel+bounces-45001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABEFA6FF24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478B27A3E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BBF293B48;
	Tue, 25 Mar 2025 12:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GyTf87f2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3B8290BD0;
	Tue, 25 Mar 2025 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905608; cv=none; b=hSQk0JZ4tUv8X/i5CsOJC+PZ1yoNSHo9C0V+4WqEU0Z7+ef3QqZJjU205CyeppBLisdHnqWqlON/wr8PVyTw8myWiVTCDg7JCdTQxGj41Udi/c29PJkYwUXhuYI2mCKPFd7/urHJDapHIVmQxWj6BMzivAEb/6GhDUm4iJf6g3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905608; c=relaxed/simple;
	bh=k1AqHL/hCEhNTElA4gLG22MgbOQAoG3oTM9Yq4VGSNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvDBffzK9QANJqEwIZHUXQlebLCE5jM8gY0iL4xVW3mRiZHKvWmVBe632AdBdOxf9Lo14yG4CUnLP8fC9KUxUizxuO6eQ4aX0iW9Trj1b5kLdz7pNaGBHWlR4rcEohcnuGWhExkBCAuuSasphEcz+MsBnKq1upfHrRsnnGsVvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GyTf87f2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aE07qw8p05gx4/fCiHPMGKqKe68aws1wlk+gibM6tmc=; b=GyTf87f2iMAv3cbqNQbNZoj4X4
	3ECSbOBKTbk42D/XUw6HFYgyzpi2H0XaF6DC0s0aIZZqXrnF9MC2TmEsxJIlvuWUq/eAZL1BrbfAF
	F3V2nACC78/k3KFzFJO/DfHHw1KmKSlIkJEyTxNEaI2LPi4Bd1fXq0IcOOxB9kYHOJskFMVxjpmJP
	dSl5PY+Wtr3orvfh7zP5W4wwNvXzhh3E7CJYNW5hTRReADEGCWY4ycf+mv14bIQDFivAV25NyMt9U
	fIkyfFHsj8Q1Y9Ep8d6aLCInRZobt44L7QM9RkwdX3VqHS12/d4Uvthrf9yRwSsjnTxCCu8e5KfX1
	3MipvKrA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tx3Mf-00000005Plb-0roV;
	Tue, 25 Mar 2025 12:26:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B98643004AF; Tue, 25 Mar 2025 13:26:40 +0100 (CET)
Date: Tue, 25 Mar 2025 13:26:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org,
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de,
	will@kernel.org, mark.rutland@arm.com, brauner@kernel.org,
	akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com,
	unicorn_wang@outlook.com, inochiama@outlook.com, gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn, jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn,
	drew@pdp7.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com, wefu@redhat.com, kuba@kernel.org,
	pabeni@redhat.com, josef@toxicpanda.com, dsterba@suse.com,
	mingo@redhat.com, boqun.feng@gmail.com, xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn, leobras@redhat.com,
	jszhang@kernel.org, conor.dooley@microchip.com,
	samuel.holland@sifive.com, yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn, ardb@kernel.org, ast@kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org, linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT
 kernel-self with ILP32 ABI
Message-ID: <20250325122640.GK36322@noisy.programming.kicks-ass.net>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>

On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
> but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI

I'm thinking you're going to be finding a metric ton of assumptions
about 'unsigned long' being 64bit when 64BIT=y throughout the kernel.

I know of a couple of places where 64BIT will result in different math
such that a 32bit 'unsigned long' will trivially overflow.

Please, don't do this. This adds a significant maintenance burden on all
of us.

