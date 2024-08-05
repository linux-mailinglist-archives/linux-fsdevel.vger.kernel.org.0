Return-Path: <linux-fsdevel+bounces-25021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34419947CEB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580831C21E5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733213B5BD;
	Mon,  5 Aug 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7RwbUT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F9762D2;
	Mon,  5 Aug 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868523; cv=none; b=nvtNLQlZ/D3wBhluub2kfwNZtNw105/AgX+guRXx1S64Be+UfvNgcDCJ442RdJeVOV6zoF3M7ipGjIsqUi0HcxEGCKCwxTfkUizgLGJbYUhdE4pdwUxA23rQZaPkZX33xJDPfZ8OBihbCXe2lyO+wp/6vU1YKl5HFFeD/zsOUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868523; c=relaxed/simple;
	bh=ud+YL7bhdQGWcyR5JiY7tP1I+YwfWtHLvIQtbdVEP/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBRLeHN8eWN0+mEn6N6L1gsmOvBGDyRxV2cP9XPpbu55ZeCcG+9j2bC7I5sYepwVbsaoB4beuv8E7efZUL4V0Web0+fazXs6/a9EG/007ZllxNXv4iQ1mHsnXzvkap2zLBJAt1mr4oqZigtXLahH8XWk91ohxiD11P0kS7FDJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7RwbUT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393DFC32782;
	Mon,  5 Aug 2024 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722868523;
	bh=ud+YL7bhdQGWcyR5JiY7tP1I+YwfWtHLvIQtbdVEP/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7RwbUT0Ryxlarp5gkNOWpA8ZkUr/EnZs/ojiWz4AXrd6zLegQt59CSDAHssdCsII
	 1kHGEzI4pC1VQ1gRMwOTZWsMRuc3CtENc80OxnHxCd1awYLaaY2A1NlQYmIBq5+j3t
	 JZaHRfu6NFuTImQgKtAi5+X6I9+116ChjPQQLqWQeiuKJz+MN3Ey+9HYyPWAknIRpp
	 705KyFUHrXPH71qw8/EXKGWN6SACSl+aX71f6kTCB6qttrbp44iquIqTnLiP00637+
	 wkmrMKZ5gCnQLfYZTocRN9rS2XLZsnCNoJlQk/RIDpDwi2587giC6d12f03me/1f7a
	 wGSIu47hCHjYQ==
Date: Mon, 5 Aug 2024 07:35:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org,
	tglx@linutronix.de
Subject: Re: Are jump labels broken on 6.11-rc1?
Message-ID: <20240805143522.GA623936@frogsfrogsfrogs>
References: <20240730033849.GH6352@frogsfrogsfrogs>
 <87o76f9vpj.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240730132626.GV26599@noisy.programming.kicks-ass.net>
 <20240731001950.GN6352@frogsfrogsfrogs>
 <20240731031033.GP6352@frogsfrogsfrogs>
 <20240731053341.GQ6352@frogsfrogsfrogs>
 <20240731105557.GY33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731105557.GY33588@noisy.programming.kicks-ass.net>

On Wed, Jul 31, 2024 at 12:55:57PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 10:33:41PM -0700, Darrick J. Wong wrote:
> 
> > Sooooo... it turns out that somehow your patch got mismerged on the
> > first go-round, and that worked.  The second time, there was no
> > mismerge, which mean that the wrong atomic_cmpxchg() callsite was
> > tested.
> > 
> > Looking back at the mismerge, it actually changed
> > __static_key_slow_dec_cpuslocked, which had in 6.10:
> > 
> > 	if (atomic_dec_and_test(&key->enabled))
> > 		jump_label_update(key);
> > 
> > Decrement, then return true if the value was set to zero.  With the 6.11
> > code, it looks like we want to exchange a 1 with a 0, and act only if
> > the previous value had been 1.
> > 
> > So perhaps we really want this change?  I'll send it out to the fleet
> > and we'll see what it reports tomorrow morning.
> 
> Bah yes, I missed we had it twice. Definitely both sites want this.
> 
> I'll tentatively merge the below patch in tip/locking/urgent. I can
> rebase if there is need.

Hi Peter,

This morning, I noticed the splat below with -rc2.

WARNING: CPU: 0 PID: 8578 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0x50/0x60

Line 295 is the else branch of this code:

	if (atomic_cmpxchg(&key->enabled, 1, 0) == 1)
		jump_label_update(key);
	else
		WARN_ON_ONCE(!static_key_slow_try_dec(key));

Apparently static_key_slow_try_dec returned false?  Looking at that
function, I suppose the atomic_read of key->enabled returned 0, since it
didn't trigger the "WARN_ON_ONCE(v < 0)" code.  Does that mean the value
must have dropped from positive N to 0 without anyone ever taking the
jump_label_mutex?

Unfortunately I'm a little too covfid-brained to figure this out today.
:(

--D

[  104.985250] run fstests xfs/1877 at 2024-08-04 15:46:00
[  107.669818] XFS (sda4): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[  107.672983] XFS (sda4): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[  107.676466] XFS (sda4): Mounting V5 Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d
[  107.732210] XFS (sda4): Ending clean mount
[  107.744657] XFS (sda4): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[  120.562636] Direct I/O collision with buffered writes! File: d2d4/d50c/d4a2/fe7 Comm: fsstress
[  132.078284] Direct I/O collision with buffered writes! File: d820/d6b9/d6f5/fbcc Comm: fsstress
[  134.261151] Direct I/O collision with buffered writes! File: d13e/d261/d896/fc9e Comm: fsstress
[  172.025695] Direct I/O collision with buffered writes! File: rt/p2/d1/f194c Comm: fsstress
[  238.690588] Direct I/O collision with buffered writes! File: dca1/dd3f/d2346/f26e3 Comm: fsstress
[  374.677179] Direct I/O collision with buffered writes! File: de70/dd75/de74/f2f38 Comm: fsstress
[  399.084085] Direct I/O collision with buffered writes! File: dd50/d1584/d1f9/f1e65 Comm: fsstress
[  547.895266] ------------[ cut here ]------------
[  547.905274] WARNING: CPU: 0 PID: 8578 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  547.914707] Modules linked in: xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables libcrc32c nfnetlink bfq sha512_ssse3 sha512_generic pvpanic_mmio sha256_ssse3 pvpanic sch_fq_codel configfs fuse ip_tables x_tables overlay nfsv4 af_packet
[  547.934623] CPU: 0 UID: 0 PID: 8578 Comm: xfs_scrub Not tainted 6.11.0-rc2-djwx #rc2 d9817e54d8a35981d261570492175bf5e1b3bc11
[  547.941392] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
[  547.948411] RIP: 0010:__static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  547.958769] Code: 74 16 e8 a3 f7 ff ff 84 c0 74 1f 5b 48 c7 c7 60 96 13 82 e9 82 15 6f 00 e8 dd fb ff ff 5b 48 c7 c7 60 96 13 82 e9 70 15 6f 00 <0f> 0b eb dd 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55
[  547.990804] RSP: 0018:ffffc9000a033c58 EFLAGS: 00010246
[  547.996006] RAX: 0000000000000000 RBX: ffffffffa0755a40 RCX: 0000000000000000
[  548.005476] RDX: 0000000000000000 RSI: 000000000000011b RDI: ffffffffa0755a40
[  548.020780] RBP: 0000000000000001 R08: ffffe8ffffc1d808 R09: ffffe8ffffc1d820
[  548.022169] R10: ffffc9000a033b28 R11: 0000000092a11c8d R12: 00000000ffffffa1
[  548.023686] R13: ffff888101deca00 R14: ffff888102b5d000 R15: 0000007f8ffa83f7
[  548.031184] FS:  00007f41b1000680(0000) GS:ffff88842d000000(0000) knlGS:0000000000000000
[  548.039927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  548.044941] CR2: 00007f41842b43a8 CR3: 00000002d0745000 CR4: 00000000003506f0
[  548.049473] Call Trace:
[  548.050026]  <TASK>
[  548.050543]  ? __warn+0x7c/0x120
[  548.051235]  ? __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  548.053966]  ? report_bug+0x1a7/0x210
[  548.059439]  ? handle_bug+0x3c/0x60
[  548.063914]  ? exc_invalid_op+0x13/0x60
[  548.070776]  ? asm_exc_invalid_op+0x16/0x20
[  548.074709]  ? __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  548.078116]  ? __static_key_slow_dec_cpuslocked.part.0+0x2d/0x60
[  548.081773]  static_key_slow_dec+0x3e/0x60
[  548.084107]  xchk_teardown+0x1a2/0x1d0 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.089682]  xfs_scrub_metadata+0x448/0x5c0 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.098202]  xfs_ioc_scrubv_metadata+0x389/0x550 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.101209]  xfs_file_ioctl+0x8f0/0xe80 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.110146]  ? preempt_count_add+0x4a/0xa0
[  548.116282]  ? up_write+0x64/0x180
[  548.117009]  ? shmem_file_write_iter+0x5a/0x90
[  548.117987]  ? preempt_count_add+0x4a/0xa0
[  548.122761]  ? vfs_write+0x3a2/0x4a0
[  548.125244]  __x64_sys_ioctl+0x8a/0xb0
[  548.125987]  do_syscall_64+0x47/0x100
[  548.126895]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  548.128056] RIP: 0033:0x7f41b491ec5b
[  548.128874] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  548.133010] RSP: 002b:00007f41b0fff4c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  548.134754] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f41b491ec5b
[  548.136731] RDX: 00007f41b0fff610 RSI: 00000000c0285840 RDI: 0000000000000004
[  548.138545] RBP: 00007f41b0fff610 R08: 0000000000000000 R09: 0000000000000064
[  548.140068] R10: 00007f41b0fff235 R11: 0000000000000246 R12: 00007ffe4738a3b0
[  548.141605] R13: 000000000000001d R14: 00007ffe4738a558 R15: 00007f418824e4e0
[  548.143161]  </TASK>
[  548.143659] ---[ end trace 0000000000000000 ]---
[  564.628369] Direct I/O collision with buffered writes! File: d23/d2b9/db54/f14fc Comm: fsstress
[  677.002836] u16:0 (11) used greatest stack depth: 11408 bytes left
[  706.851715] Direct I/O collision with buffered writes! File: d2ee3/da3b/d3258/f255e Comm: fsstress
[  853.054101] Direct I/O collision with buffered writes! File: d1b4b/d2ac/d8b5/f13f8 Comm: fsstress
[  895.426556] Direct I/O collision with buffered writes! File: d747b/d577c/d5893/f6014 Comm: fsstress
[ 1037.454921] u16:5 (67) used greatest stack depth: 11016 bytes left
[ 1064.482959] Direct I/O collision with buffered writes! File: d60b4/d6e91/d6852/f6a87 Comm: fsstress
[ 1159.694683] XFS (sda3): Unmounting Filesystem eef3561a-2a86-49c8-9aa1-5024529cd3e7
[ 1170.139417] XFS (sda4): Unmounting Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d
[ 1179.548273] XFS (sda4): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[ 1179.553727] XFS (sda4): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[ 1179.558023] XFS (sda4): Mounting V5 Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d
[ 1179.590448] XFS (sda4): Ending clean mount
[ 1179.600826] XFS (sda4): Unmounting Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d


[  104.985250] run fstests xfs/1877 at 2024-08-04 15:46:00
[  107.669818] XFS (sda4): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[  107.672983] XFS (sda4): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[  107.676466] XFS (sda4): Mounting V5 Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d
[  107.732210] XFS (sda4): Ending clean mount
[  107.744657] XFS (sda4): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[  120.562636] Direct I/O collision with buffered writes! File: d2d4/d50c/d4a2/fe7 Comm: fsstress
[  132.078284] Direct I/O collision with buffered writes! File: d820/d6b9/d6f5/fbcc Comm: fsstress
[  134.261151] Direct I/O collision with buffered writes! File: d13e/d261/d896/fc9e Comm: fsstress
[  172.025695] Direct I/O collision with buffered writes! File: rt/p2/d1/f194c Comm: fsstress
[  238.690588] Direct I/O collision with buffered writes! File: dca1/dd3f/d2346/f26e3 Comm: fsstress
[  374.677179] Direct I/O collision with buffered writes! File: de70/dd75/de74/f2f38 Comm: fsstress
[  399.084085] Direct I/O collision with buffered writes! File: dd50/d1584/d1f9/f1e65 Comm: fsstress
[  547.895266] ------------[ cut here ]------------
[  547.905274] WARNING: CPU: 0 PID: 8578 at kernel/jump_label.c:295 __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  547.914707] Modules linked in: xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables libcrc32c nfnetlink bfq sha512_ssse3 sha512_generic pvpanic_mmio sha256_ssse3 pvpanic sch_fq_codel configfs fuse ip_tables x_tables overlay nfsv4 af_packet
[  547.934623] CPU: 0 UID: 0 PID: 8578 Comm: xfs_scrub Not tainted 6.11.0-rc2-djwx #rc2 d9817e54d8a35981d261570492175bf5e1b3bc11
[  547.941392] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
[  547.948411] RIP: 0010:__static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  547.958769] Code: 74 16 e8 a3 f7 ff ff 84 c0 74 1f 5b 48 c7 c7 60 96 13 82 e9 82 15 6f 00 e8 dd fb ff ff 5b 48 c7 c7 60 96 13 82 e9 70 15 6f 00 <0f> 0b eb dd 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55
[  547.990804] RSP: 0018:ffffc9000a033c58 EFLAGS: 00010246
[  547.996006] RAX: 0000000000000000 RBX: ffffffffa0755a40 RCX: 0000000000000000
[  548.005476] RDX: 0000000000000000 RSI: 000000000000011b RDI: ffffffffa0755a40
[  548.020780] RBP: 0000000000000001 R08: ffffe8ffffc1d808 R09: ffffe8ffffc1d820
[  548.022169] R10: ffffc9000a033b28 R11: 0000000092a11c8d R12: 00000000ffffffa1
[  548.023686] R13: ffff888101deca00 R14: ffff888102b5d000 R15: 0000007f8ffa83f7
[  548.031184] FS:  00007f41b1000680(0000) GS:ffff88842d000000(0000) knlGS:0000000000000000
[  548.039927] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  548.044941] CR2: 00007f41842b43a8 CR3: 00000002d0745000 CR4: 00000000003506f0
[  548.049473] Call Trace:
[  548.050026]  <TASK>
[  548.050543]  ? __warn+0x7c/0x120
[  548.051235]  ? __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  548.053966]  ? report_bug+0x1a7/0x210
[  548.059439]  ? handle_bug+0x3c/0x60
[  548.063914]  ? exc_invalid_op+0x13/0x60
[  548.070776]  ? asm_exc_invalid_op+0x16/0x20
[  548.074709]  ? __static_key_slow_dec_cpuslocked.part.0+0x50/0x60
[  548.078116]  ? __static_key_slow_dec_cpuslocked.part.0+0x2d/0x60
[  548.081773]  static_key_slow_dec+0x3e/0x60
[  548.084107]  xchk_teardown+0x1a2/0x1d0 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.089682]  xfs_scrub_metadata+0x448/0x5c0 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.098202]  xfs_ioc_scrubv_metadata+0x389/0x550 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.101209]  xfs_file_ioctl+0x8f0/0xe80 [xfs 6c824b8f28c8b3bc861384b1edb6577088bd4dda]
[  548.110146]  ? preempt_count_add+0x4a/0xa0
[  548.116282]  ? up_write+0x64/0x180
[  548.117009]  ? shmem_file_write_iter+0x5a/0x90
[  548.117987]  ? preempt_count_add+0x4a/0xa0
[  548.122761]  ? vfs_write+0x3a2/0x4a0
[  548.125244]  __x64_sys_ioctl+0x8a/0xb0
[  548.125987]  do_syscall_64+0x47/0x100
[  548.126895]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  548.128056] RIP: 0033:0x7f41b491ec5b
[  548.128874] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  548.133010] RSP: 002b:00007f41b0fff4c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  548.134754] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f41b491ec5b
[  548.136731] RDX: 00007f41b0fff610 RSI: 00000000c0285840 RDI: 0000000000000004
[  548.138545] RBP: 00007f41b0fff610 R08: 0000000000000000 R09: 0000000000000064
[  548.140068] R10: 00007f41b0fff235 R11: 0000000000000246 R12: 00007ffe4738a3b0
[  548.141605] R13: 000000000000001d R14: 00007ffe4738a558 R15: 00007f418824e4e0
[  548.143161]  </TASK>
[  548.143659] ---[ end trace 0000000000000000 ]---
[  564.628369] Direct I/O collision with buffered writes! File: d23/d2b9/db54/f14fc Comm: fsstress
[  677.002836] u16:0 (11) used greatest stack depth: 11408 bytes left
[  706.851715] Direct I/O collision with buffered writes! File: d2ee3/da3b/d3258/f255e Comm: fsstress
[  853.054101] Direct I/O collision with buffered writes! File: d1b4b/d2ac/d8b5/f13f8 Comm: fsstress
[  895.426556] Direct I/O collision with buffered writes! File: d747b/d577c/d5893/f6014 Comm: fsstress
[ 1037.454921] u16:5 (67) used greatest stack depth: 11016 bytes left
[ 1064.482959] Direct I/O collision with buffered writes! File: d60b4/d6e91/d6852/f6a87 Comm: fsstress
[ 1159.694683] XFS (sda3): Unmounting Filesystem eef3561a-2a86-49c8-9aa1-5024529cd3e7
[ 1170.139417] XFS (sda4): Unmounting Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d
[ 1179.548273] XFS (sda4): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[ 1179.553727] XFS (sda4): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[ 1179.558023] XFS (sda4): Mounting V5 Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d
[ 1179.590448] XFS (sda4): Ending clean mount
[ 1179.600826] XFS (sda4): Unmounting Filesystem e1e9e96c-0d94-4a7e-8405-86e4d16d331d


