Return-Path: <linux-fsdevel+bounces-39085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBEA0C0E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65634188906C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409991C5485;
	Mon, 13 Jan 2025 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOn3Y2nk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8571C07C9;
	Mon, 13 Jan 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794632; cv=none; b=UHTYt1qLbY6FCDeI3tBOEjuhIqjUcWTzzEVoi+g/clSSPugtxmCD4TpGW48h4tGxI+PIWubW6q7mW7NUIRz8dLVGXSxgRkodYwcxqrZIV6ty08hHtrVbEV+YcWEnmwAsRShItdPPuDDeESRXrbNq8x9v84Ni1czhpgtFXIIFFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794632; c=relaxed/simple;
	bh=OIt3xPUnf6RUXfeVB4EwCGZhhcnIUXUVsQ88UrEYSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfNubu68vck/E/WSD6rurjLSKEaXJRwXgCceTiZaU1JHItADieMiB1hVzUCm+7n7BV1tDAvNUnp976HcaBVlg+/5NP+8wuRbeCFy+89K23APhURvpYeMqJ1M93jxN0w5e/gN5TcHCMG4A5a1TluU2nzGxqLgeP5x4y4v5vxnBCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOn3Y2nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD34C4CED6;
	Mon, 13 Jan 2025 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736794632;
	bh=OIt3xPUnf6RUXfeVB4EwCGZhhcnIUXUVsQ88UrEYSPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOn3Y2nkkFCIavkKN8wQzBxEAvq5dGNIzOv1kO0UkzXh/Inu768z40EtO2X4ZwZCk
	 4yk94QsrAgZmc1Ksf43sQ1GW3ITvQURLSFvDt+tiHCIB0dh4nZhvyrFXwHmLQDhfn7
	 yKF8w+lTpwv/Tdw3FVI8RYpDAFGRwe3xjnp7U7ths1YwL2m0dbeMTxAZ8jZuKj4S4c
	 GQqinys61xc3dlx/MzyRmBiBhD0s4vsmR6nn09WaVUmyPDZIcnBVThGUtGBJEwswOL
	 F31ZFH+LldKOctDVSV09L/fTS/h/Ru8MFbmCQFgsPKNwWuJHvpCHRwZWuXeC7UscYw
	 +8bILCjOrQjTA==
Date: Mon, 13 Jan 2025 19:57:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Christian Brauner <christianvanbrauner@gmail.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [brauner-vfs:vfs-6.14.misc] [pipe_read]  aaec5a95d5:
 hackbench.throughput 7.5% regression
Message-ID: <20250113-unhold-geben-00f402d87606@brauner>
References: <202501101015.90874b3a-lkp@intel.com>
 <20250113185257.GA7471@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250113185257.GA7471@redhat.com>

On Mon, Jan 13, 2025 at 07:52:57PM +0100, Oleg Nesterov wrote:
> Well, I guess I need to react somehow...
> 
> On 01/10, kernel test robot wrote:
> >
> > kernel test robot noticed a 7.5% regression of hackbench.throughput on:
> >
> > commit: aaec5a95d59615523db03dd53c2052f0a87beea7 ("pipe_read: don't wake up the writer if the pipe is still full")
> > https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs-6.14.misc
> 
> Hmm. Not good ;)
> 
> But otoh,
> 
> > In addition to that, the commit also has significant impact on the following tests:
> >
> > +------------------+-------------------------------------------------------------------------------------------+
> > | testcase: change | stress-ng: stress-ng.tee.ops_per_sec 500.7% improvement                                   |
> 
> So I hope we do not need to revert this patch?
> 
> -------------------------------------------------------------------------------
> I am looking at
> 
> 	https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/hackbench/hackbench.c
> 
> and I don't understand how can this patch make a noticable difference.
> And can't reproduce,
> 
> 	hackbench -g 4 -f 10 --process --pipe -l 50000 -s 100
> 
> on my laptop under qemu doesn't show any regression.
> 
> OK, in this case the early/unnecessary wakeup (removed by this patch) is
> not necessarily bad, when the woken writer actually gets CPU pipe_full()
> will be likely false, plus receiver() can wakeup more writers when it does
> the next read()s. But 7.5% ?
> 
> Perhaps this is another case which shows that "artificial" benchmarks like
> this one are very sensitive... Or perhaps I am trying to deny the problem.
> 
> So, Christian, et al, unless you think I should try to investigate, I am
> going to forget this report. If nothing else, "500.7% improvement" doesn't
> look bad even if I have no idea whether the stress-ng.tee.ops_per_sec test
> realistic or not (I have no idea what does it do).

Fwiw, I ignored the report too and I intend to keep the patch. IOW, I
agree with you. Thanks for your work!



