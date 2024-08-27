Return-Path: <linux-fsdevel+bounces-27276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B0495FFDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CA4283950
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78F24C83;
	Tue, 27 Aug 2024 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPQPTlyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48D1B964;
	Tue, 27 Aug 2024 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729707; cv=none; b=aUfGBnDaXYHXsvWeO+dyHiPZQmz9KtZ91mOXAVtX3IxeGSNa+7iD5RQpibmDd/1pe5AMZvN/3vZlqfpbOK2stz0IjgzLBf71MVlLCD3dB+nNmRDC3LXywdJRLxFrrYj4aKqC7U9InfblgUx0FZUo2gcw8Gu/fEJ6nwWPSLgIAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729707; c=relaxed/simple;
	bh=qTGWF+GVczPnsEHslBM459/DCmnEFp2b3Isxhk3wMBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLTuHkycQPutk4DiY8eWiWLZDJWy9QuXFn0IH3PytSC7qNyWKVpftVxJcfYydJqz9dfE2a6ktGudHerEH1SgJVV6UvR+F6fu8YRzcG9ODF9A1rQJXLqlZiTsGCTz9IfqjpR3vNMTz+Q/rIb+/0Ts5rgbHw0aPoSsN1IHE1rhEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPQPTlyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCBC8B7A6;
	Tue, 27 Aug 2024 03:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724729706;
	bh=qTGWF+GVczPnsEHslBM459/DCmnEFp2b3Isxhk3wMBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SPQPTlytL44h9MASGQ1Hk4pIbVOpvCTg6LElIkSaxb9r5lpkeDt4wmJKXVet21VuO
	 gy/cSN+zNnEx8tZ9TMeyGQwok6ENejQvyJWT0n7X+BeV/Wzki2Yr6pAFrQrjuQPIK6
	 gF7kZjwWbCsqo0G5sswmQIOuHJgjrAtUhrnfpUyNz4UR9ZKt27TtpRH631BacL0PS/
	 cIM7AKH8yZhFlKCRSu2FnHSh5GqTrQOPmaG5IshUWZUXBcOnH67Ukmjfx6KxxU4Wxp
	 jRjCU2d2dPsaZwTLQEHymNQ/A1ry/khZbcSzmjK7HnhMcB86eXAVp5m0owokMAz7xu
	 qP6T/w67TuLKg==
Date: Mon, 26 Aug 2024 20:35:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240827033506.GH865349@frogsfrogsfrogs>
References: <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
 <20240805143522.GA623936@frogsfrogsfrogs>
 <20240806094413.GS37996@noisy.programming.kicks-ass.net>
 <20240806103808.GT37996@noisy.programming.kicks-ass.net>
 <875xsc4ehr.ffs@tglx>
 <20240807143407.GC31338@noisy.programming.kicks-ass.net>
 <87wmks2xhi.ffs@tglx>
 <20240807150503.GF6051@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807150503.GF6051@frogsfrogsfrogs>

On Wed, Aug 07, 2024 at 08:05:03AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 07, 2024 at 04:55:53PM +0200, Thomas Gleixner wrote:
> > On Wed, Aug 07 2024 at 16:34, Peter Zijlstra wrote:
> > > On Wed, Aug 07, 2024 at 04:03:12PM +0200, Thomas Gleixner wrote:
> > >
> > >> > +	if (static_key_dec(key, true)) // dec-not-one
> > >> 
> > >> Eeew.
> > >
> > > :-) I knew you'd hate on that
> > 
> > So you added it just to make me grumpy enough to fix it for you, right?
> 
> FWIW with peter's 'ugly' patch applied, fstests didn't cough up any
> static key complaints overnight.

Unfortunately, I must take back these words -- after starting up a
nastier stress test, I can still reproduce this, but this time on arm64:

[   49.571229] run fstests xfs/286 at 2024-08-18 15:22:51
[   49.763554] spectre-v4 mitigation disabled by command-line option
[   50.004771] XFS (sda2): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[   50.968906] XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
[   50.972647] XFS (sda3): EXPERIMENTAL realtime allocation group and superblock feature in use. Use at your own risk!
[   50.982134] XFS (sda3): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[   50.986169] XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[   50.992801] XFS (sda3): Mounting V5 Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
[   51.025796] XFS (sda3): Ending clean mount
[   51.028980] XFS (sda3): EXPERIMENTAL realtime quota feature in use. Use at your own risk!
[   51.036655] XFS (sda3): Quotacheck needed: Please wait.
[   51.060215] XFS (sda3): Quotacheck: Done.
[   51.072704] XFS (sda3): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[  100.296395] Direct I/O collision with buffered writes! File: d2eb/dbbb/d6ed/f1168 Comm: fsstress
[  109.211668] Direct I/O collision with buffered writes! File: de2a/dd5e/dcdd/f9f9 Comm: fsstress
[  137.196279] Direct I/O collision with buffered writes! File: da23/d11dc/de52/f1826 Comm: fsstress
[  175.740403] Direct I/O collision with buffered writes! File: d1163/d1085/d1225/f174e Comm: fsstress
[  280.081330] Direct I/O collision with buffered writes! File: dd74/d1184/d12b8/f26b8 Comm: fsstress
[  314.030300] Direct I/O collision with buffered writes! File: d31a1/d348a/d1a8d/f2de1 Comm: fsstress
[  421.526543] Direct I/O collision with buffered writes! File: d762/d765/d1931/f1859 Comm: fsstress
[  526.158683] Direct I/O collision with buffered writes! File: d4b6/d48f9/d5151/f12d7 Comm: fsstress
[  699.273894] Direct I/O collision with buffered writes! File: d68b/d10a7/d991/fcd4 Comm: fsstress
[  866.299077] Direct I/O collision with buffered writes! File: d7022/d4553/d5d89/f6925 Comm: fsstress
[  885.699829] Direct I/O collision with buffered writes! File: d3a72/d4ce4/d4c6e/f58ed Comm: fsstress
[ 1340.999610] Direct I/O collision with buffered writes! File: da8c/d26fe/d36ff/f6a94 Comm: fsstress
[ 1591.402638] Direct I/O collision with buffered writes! File: d1d18/d321a/d7d0/f3666 Comm: fsstress
[ 1595.377018] Direct I/O collision with buffered writes! File: d2fad/d15ef/d78da/f95e1 Comm: fsstress
[ 1618.061948] Direct I/O collision with buffered writes! File: d7b12/d51b7/d2337/f4ed5 Comm: fsstress
[ 1717.713414] Direct I/O collision with buffered writes! File: d5eb5/d3598/d71d/f42d0 Comm: fsstress
[ 1851.153819] Direct I/O collision with buffered writes! File: d5bc9/d3aad/d1892/faafc Comm: fsstress
[ 2080.574935] Direct I/O collision with buffered writes! File: d391f/d3e3a/d5246/fe17 Comm: fsstress
[ 2598.295098] Direct I/O collision with buffered writes! File: d923d/d4d30/da5d0/faf5b Comm: fsstress
[ 3549.070989] Direct I/O collision with buffered writes! File: da817/d87b0/dbc17/f7aeb Comm: fsstress
[22298.378392] XFS (sda3): page discard on page ffffffff407e3c80, inode 0x6a0c8fe, pos 9170944.
[22298.380577] sda3: writeback error on inode 111200510, offset 9166848, sector 24924992
[32769.915951] XFS (sda3): page discard on page ffffffff4073ef00, inode 0x41c8aa1, pos 593920.
[33965.988873] ------------[ cut here ]------------
[33966.013870] WARNING: CPU: 1 PID: 8992 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
[33966.017596] Modules linked in: xfs time_stats mean_and_variance nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac nf_tables libcrc32c crct10dif_ce sha2_ce sha256_arm64 bfq evbug sch_fq_codel fuse configfs efivarfs ip_tables x_tables overlay nfsv4
[33966.031983] CPU: 1 UID: 0 PID: 8992 Comm: xfs_scrub Not tainted 6.11.0-rc4-xfsa #rc4 eee7712a56abc3d2e1a397d28a5166a26e38d1d6
[33966.035837] Hardware name: QEMU KVM Virtual Machine, BIOS 1.6.6 08/22/2023
[33966.037739] pstate: 40401005 (nZcv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
[33966.040184] pc : __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
[33966.042845] lr : __static_key_slow_dec_cpuslocked.part.0+0x48/0xc0
[33966.045128] sp : fffffe008708f9f0
[33966.046504] x29: fffffe008708f9f0 x28: fffffc0031a1a500 x27: 000003fd77c6e100
[33966.048942] x26: fffffc00e82de000 x25: 0000000000000000 x24: fffffe007a96ac88
[33966.050713] x23: fffffc00e82de000 x22: fffffc00c71f0cd0 x21: 00000000ffffffe4
[33966.053423] x20: fffffe00812f25c8 x19: fffffe007a890940 x18: 0000000000000000
[33966.056225] x17: 0000000000000000 x16: 0000000000000000 x15: 000003ffc8e2ef28
[33966.059311] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[33966.062103] x11: 0000000000000040 x10: 0000000000001b30 x9 : fffffe0080239558
[33966.064880] x8 : fffffe008708f9b8 x7 : 2222222222222222 x6 : 00000c99773e47d7
[33966.067463] x5 : 0000000000000002 x4 : 0000000000000000 x3 : 0000000000000001
[33966.070363] x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000000
[33966.072840] Call trace:
[33966.073838]  __static_key_slow_dec_cpuslocked.part.0+0xb0/0xc0
[33966.076105]  static_key_slow_dec+0x48/0x88
[33966.077739]  xfs_dir_hook_disable+0x20/0x38 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
[33966.080947]  xchk_teardown+0x1d4/0x220 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
[33966.084101]  xfs_scrub_metadata+0x52c/0x820 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
[33966.087429]  xfs_ioc_scrubv_metadata+0x3ec/0x5b0 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
[33966.090615]  xfs_file_ioctl+0xa58/0x1168 [xfs 81b6cc501f608332f7590e39811e5ddd66afb315]
[33966.093672]  __arm64_sys_ioctl+0x4f8/0xd00
[33966.095016]  do_el0_svc+0x74/0x110
[33966.095983]  el0_svc+0x48/0x1f0
[33966.097124]  el0t_64_sync_handler+0x100/0x130
[33966.098843]  el0t_64_sync+0x190/0x198
[33966.100330] ---[ end trace 0000000000000000 ]---
[561654.524297] XFS (sda2): Unmounting Filesystem 4b02ad48-7ae9-4d54-a76c-32266d3a2e41
[563105.524971] XFS (sda3): Unmounting Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
[563245.534266] XFS (sda3): EXPERIMENTAL metadata directory feature in use. Use at your own risk!
[563245.575660] XFS (sda3): EXPERIMENTAL realtime allocation group and superblock feature in use. Use at your own risk!
[563245.576454] XFS (sda3): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[563245.578363] XFS (sda3): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[563245.592134] XFS (sda3): Mounting V5 Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130
[563245.632709] XFS (sda3): EXPERIMENTAL realtime quota feature in use. Use at your own risk!
[563245.644275] XFS (sda3): Ending clean mount
[563245.843692] XFS (sda3): Unmounting Filesystem 035cf5e0-d5e2-4739-8dab-15a52dddf130

This corresponds to the:

	WARN_ON_ONCE(!static_key_slow_try_dec(key));

at the end of __static_key_slow_dec_cpuslocked.  Perhaps we're seeing a
-1 value from the atomic_cmpxchg(&key->enabled, 1, 0)?

If I surround the static_branch_{inc,dec} calls with a mutex the
complaints go away, though I gather that's not an acceptable hackaround.

Though as you can observe, the system ran stress testing for another 147
hours without any xfs problems reported.

--D

> > >> +/*
> > >> + * Fastpath: Decrement if the reference count is greater than one
> > >> + *
> > >> + * Returns false, if the reference count is 1 or -1 to force the caller
> > >> + * into the slowpath.
> > >> + *
> > >> + * The -1 case is to handle a decrement during a concurrent first enable,
> > >> + * which sets the count to -1 in static_key_slow_inc_cpuslocked(). As the
> > >> + * slow path is serialized the caller will observe 1 once it acquired the
> > >> + * jump_label_mutex, so the slow path can succeed.
> > >> + */
> > >> +static bool static_key_dec_not_one(struct static_key *key)
> > >> +{
> > >> +	int v = static_key_dec(key, true);
> > >> +
> > >> +	return v != 1 && v != -1;
> > >
> > > 	if (v < 0)
> > > 		return false;
> > 
> > Hmm. I think we should do:
> > 
> > #define KEY_ENABLE_IN_PROGRESS		-1
> > 
> > or even a more distinct value like (INT_MIN / 2)
> > 
> > and replace all the magic -1 numbers with it. Then the check becomes
> > explicit:
> > 
> >         if (v == KEY_ENABLE_IN_PROGRESS)
> >         	return false;
> > 
> > > 	/*
> > > 	 * Notably, 0 (underflow) returns true such that it bails out
> > > 	 * without doing anything.
> > > 	 */
> > > 	return v != 1;
> > >
> > > Perhaps?
> > 
> > Sure.
> > 
> > >> +}
> > >> +
> > >> +/*
> > >> + * Slowpath: Decrement and test whether the refcount hit 0.
> > >> + *
> > >> + * Returns true if the refcount hit zero, i.e. the previous value was one.
> > >> + */
> > >> +static bool static_key_dec_and_test(struct static_key *key)
> > >> +{
> > >> +	int v = static_key_dec(key, false);
> > >> +
> > >> +	lockdep_assert_held(&jump_label_mutex);
> > >> +	return v == 1;
> > >>  }
> > >
> > > But yeah, this is nicer!
> > 
> > :)
> 
> It probably goes without saying that if either of you send a cleaned up
> patch with all these changes baked in, I will test it for you all. :)
> 
> --D
> 
> > 
> > Thanks,
> > 
> >         tglx
> > 
> 

