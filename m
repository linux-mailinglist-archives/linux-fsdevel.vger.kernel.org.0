Return-Path: <linux-fsdevel+bounces-28697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB396D1BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74A202818FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA651991B4;
	Thu,  5 Sep 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r0PeldOi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34819644B;
	Thu,  5 Sep 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523966; cv=none; b=M17OqpkwfSIRIdv8SwB2Xa5ijTIb+nHlIEyZEPgZ2/vFYpp2TVisi9GRM2RGx+5vUEgD/1UcWTYiYbdibzXxqGrzTff9LWBcOBAO5HyIsJ6W9ORbJ+1w5gBKSuwLLiADGyHwEhFWyOLZumUpP/nY2iGIrTiT1LZayC9/FBhPpEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523966; c=relaxed/simple;
	bh=jZ1hPTuJu68MVvH3zGKNlkbGMl73Pdpmv0zQGkPd6HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJLP7U5mJhUb4WshAJo9Va2WosaZbz4+YVNMdqlNDtgSPZbIzrtsI/vDkixKBdcS5s+tT7zi8iHYwTNp7M6arPPhIbMIjazBfNyNXjdaC9K8YEFJjwYS2HmfXP0ACqGpOKeZ+rkmJbh6Ug5hBPKpzkCSVcpYoBWKi81zF2M5g9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r0PeldOi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nDE1knFKALmBkS8fUEoBIuBYzR1BzbEt969vXlHxl4g=; b=r0PeldOiGQ7xBgA2qIZ6zZPxCW
	PTFgN0iT6p8/HXKwDVuQzcWGmYh3gryBrZwTrU+rnQhwc+5tNkiCIEVTpj9iqn6fXQBcWIzEbvGiQ
	SDhnIOuL6AalWsB8ViW+Ch9pat+WKkWuBMtwPMIQcBzBKJM4/9NLPdP0r++jlKxX3RLaiaMGK81O/
	e3M+qinnNe7EEYVABPbrcjfq11ccbRUiJizcAzKOukvRuvPiUOpcJif9KFLO6ahjbUUSnhwFjOAWe
	GA2vsa0EVPuc3HW8avjYAbxw32O69ZepOOVJhn/KbVXdK3W4SXw2CtMq+M2B+Mu0amT6+u8PHwK1S
	S/wbpRqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sm7bd-000000024Vl-18MP;
	Thu, 05 Sep 2024 08:12:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A3FE300599; Thu,  5 Sep 2024 10:12:41 +0200 (CEST)
Date: Thu, 5 Sep 2024 10:12:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240905081241.GM4723@noisy.programming.kicks-ass.net>
References: <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
 <87wmks2xhi.ffs@tglx>
 <20240807150503.GF6051@frogsfrogsfrogs>
 <20240827033506.GH865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827033506.GH865349@frogsfrogsfrogs>

On Mon, Aug 26, 2024 at 08:35:06PM -0700, Darrick J. Wong wrote:
> On Wed, Aug 07, 2024 at 08:05:03AM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 07, 2024 at 04:55:53PM +0200, Thomas Gleixner wrote:
> > > On Wed, Aug 07 2024 at 16:34, Peter Zijlstra wrote:
> > > > On Wed, Aug 07, 2024 at 04:03:12PM +0200, Thomas Gleixner wrote:
> > > >
> > > >> > +	if (static_key_dec(key, true)) // dec-not-one
> > > >> 
> > > >> Eeew.
> > > >
> > > > :-) I knew you'd hate on that
> > > 
> > > So you added it just to make me grumpy enough to fix it for you, right?
> > 
> > FWIW with peter's 'ugly' patch applied, fstests didn't cough up any
> > static key complaints overnight.
> 
> Unfortunately, I must take back these words -- after starting up a
> nastier stress test, I can still reproduce this, but this time on arm64:
> 
> [   49.571229] run fstests xfs/286 at 2024-08-18 15:22:51
> [   49.763554] spectre-v4 mitigation disabled by command-line option
> [   50.004771] XFS (sda2): EXPERIMENTAL online scrub feature in use. Use at your own risk!
> [   50.968906] XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
> [   50.972647] XFS (sda3): EXPERIMENTAL realtime allocation group and superblock feature in use. Use at your own risk!
> [   50.982134] XFS (sda3): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
> [   50.986169] XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
> [   50.992801] XFS (sda3): Mounting V5 Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
> [   51.025796] XFS (sda3): Ending clean mount
> [   51.028980] XFS (sda3): EXPERIMENTAL realtime quota feature in use. Use at your own risk!
> [   51.036655] XFS (sda3): Quotacheck needed: Please wait.
> [   51.060215] XFS (sda3): Quotacheck: Done.
> [   51.072704] XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
> [  100.296395] Direct I/O collision with buffered writes! File: d2eb/dbbb/d6ed/f1168 Comm: fsstress
> [  109.211668] Direct I/O collision with buffered writes! File: de2a/dd5e/dcdd/f9f9 Comm: fsstress
> [  137.196279] Direct I/O collision with buffered writes! File: da23/d11dc/de52/f1826 Comm: fsstress
> [  175.740403] Direct I/O collision with buffered writes! File: d1163/d1085/d1225/f174e Comm: fsstress
> [  280.081330] Direct I/O collision with buffered writes! File: dd74/d1184/d12b8/f26b8 Comm: fsstress
> [  314.030300] Direct I/O collision with buffered writes! File: d31a1/d348a/d1a8d/f2de1 Comm: fsstress
> [  421.526543] Direct I/O collision with buffered writes! File: d762/d765/d1931/f1859 Comm: fsstress
> [  526.158683] Direct I/O collision with buffered writes! File: d4b6/d48f9/d5151/f12d7 Comm: fsstress
> [  699.273894] Direct I/O collision with buffered writes! File: d68b/d10a7/d991/fcd4 Comm: fsstress
> [  866.299077] Direct I/O collision with buffered writes! File: d7022/d4553/d5d89/f6925 Comm: fsstress
> [  885.699829] Direct I/O collision with buffered writes! File: d3a72/d4ce4/d4c6e/f58ed Comm: fsstress
> [ 1340.999610] Direct I/O collision with buffered writes! File: da8c/d26fe/d36ff/f6a94 Comm: fsstress
> [ 1591.402638] Direct I/O collision with buffered writes! File: d1d18/d321a/d7d0/f3666 Comm: fsstress
> [ 1595.377018] Direct I/O collision with buffered writes! File: d2fad/d15ef/d78da/f95e1 Comm: fsstress
> [ 1618.061948] Direct I/O collision with buffered writes! File: d7b12/d51b7/d2337/f4ed5 Comm: fsstress
> [ 1717.713414] Direct I/O collision with buffered writes! File: d5eb5/d3598/d71d/f42d0 Comm: fsstress
> [ 1851.153819] Direct I/O collision with buffered writes! File: d5bc9/d3aad/d1892/faafc Comm: fsstress
> [ 2080.574935] Direct I/O collision with buffered writes! File: d391f/d3e3a/d5246/fe17 Comm: fsstress
> [ 2598.295098] Direct I/O collision with buffered writes! File: d923d/d4d30/da5d0/faf5b Comm: fsstress
> [ 3549.070989] Direct I/O collision with buffered writes! File: da817/d87b0/dbc17/f7aeb Comm: fsstress
> [22298.378392] XFS (sda3): page discard on page ffffffff407e3c80, inode 0x6a0c8fe, pos 9170944.
> [22298.380577] sda3: writeback error on inode 111200510, offset 9166848, sector 24924992
> [32769.915951] XFS (sda3): page discard on page ffffffff4073ef00, inode 0x41c8aa1, pos 593920.
> [33965.988873] ------------[ cut here ]------------
> [33966.013870] WARNING: CPU: 1 PID: 8992 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> [33966.017596] Modules linked in: xfs time_stats mean_and_variance nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac nf_tables libcrc32c crct10dif_ce sha2_ce sha256_arm64 bfq evbug sch_fq_codel fuse configfs efivarfs ip_tables x_tables overlay nfsv4
> [33966.031983] CPU: 1 UID: 0 PID: 8992 Comm: xfs_scrub Not tainted 6.11.0-rc4-xfsa #rc4 eee7712a56abc3d2e1a397d28a5166a26e38d1d6
> [33966.035837] Hardware name: QEMU KVM Virtual Machine, BIOS 1.6.6 08/22/2023
> [33966.037739] pstate: 40401005 (nZcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> [33966.040184] pc : __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> [33966.042845] lr : __static_key_slow_dec_cpuslocked.part.0+0x48/0xc0
> [33966.045128] sp : fffffe008708f9f0
> [33966.046504] x29: fffffe008708f9f0 x28: fffffc0031a1a500 x27: 000003fd77c6e100
> [33966.048942] x26: fffffc00e82de000 x25: 0000000000000000 x24: fffffe007a96ac88
> [33966.050713] x23: fffffc00e82de000 x22: fffffc00c71f0cd0 x21: 00000000ffffffe4
> [33966.053423] x20: fffffe00812f25c8 x19: fffffe007a890940 x18: 0000000000000000
> [33966.056225] x17: 0000000000000000 x16: 0000000000000000 x15: 000003ffc8e2ef28
> [33966.059311] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> [33966.062103] x11: 0000000000000040 x10: 0000000000001b30 x9 : fffffe0080239558
> [33966.064880] x8 : fffffe008708f9b8 x7 : 2222222222222222 x6 : 00000c99773e47d7
> [33966.067463] x5 : 0000000000000002 x4 : 0000000000000000 x3 : 0000000000000001
> [33966.070363] x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
> [33966.072840] Call trace:
> [33966.073838]  __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
> [33966.076105]  static_key_slow_dec+0x48/0x88
> [33966.077739]  xfs_dir_hook_disable+0x20/0x38 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
> [33966.080947]  xchk_teardown+0x1d4/0x220 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
> [33966.084101]  xfs_scrub_metadata+0x52c/0x820 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
> [33966.087429]  xfs_ioc_scrubv_metadata+0x3ec/0x5b0 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
> [33966.090615]  xfs_file_ioctl+0xa58/0x1168 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
> [33966.093672]  __arm64_sys_ioctl+0x4f8/0xd00
> [33966.095016]  do_el0_svc+0x74/0x110
> [33966.095983]  el0_svc+0x48/0x1f0
> [33966.097124]  el0t_64_sync_handler+0x100/0x130
> [33966.098843]  el0t_64_sync+0x190/0x198
> [33966.100330] ---[ end trace 0000000000000000 ]---
> [561654.524297] XFS (sda2): Unmounting Filesystem 4b02ad48-7ae9-4d54-a76c-32266d3a2e41
> [563105.524971] XFS (sda3): Unmounting Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
> [563245.534266] XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
> [563245.575660] XFS (sda3): EXPERIMENTAL realtime allocation group and superblock feature in use. Use at your own risk!
> [563245.576454] XFS (sda3): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
> [563245.578363] XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
> [563245.592134] XFS (sda3): Mounting V5 Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
> [563245.632709] XFS (sda3): EXPERIMENTAL realtime quota feature in use. Use at your own risk!
> [563245.644275] XFS (sda3): Ending clean mount
> [563245.843692] XFS (sda3): Unmounting Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
> 
> This corresponds to the:
> 
> 	WARN_ON_ONCE(!static_key_slow_try_dec(key));

But but but,... my patch killed that function. So are you sure it is
applied ?!

Because this sounds like exactly that issue again.

Anyway, it appears I had totally forgotten about this issue again due to
holidays, sorry. Let me stare hard at Thomas' patch and make a 'pretty'
one that does boot.



