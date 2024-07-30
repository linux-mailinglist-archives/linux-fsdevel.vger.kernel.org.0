Return-Path: <linux-fsdevel+bounces-24530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62950940600
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB049283BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 03:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D2A12EBD6;
	Tue, 30 Jul 2024 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q55tKe8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2522315;
	Tue, 30 Jul 2024 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310731; cv=none; b=cZbfQeQjtkdSE6138vhpb4UVuXRLXrFL9FlXM1doOScwLOPFaZIZzQXmn4lYy1uvehVClDUNa94jSErBhx9GLYF4jyhSgQ/jANyjIw5hx7/w3fGiKqSTyiXZNXVMCwahkNN+Omr6bNubFJz5Kqa/DDNmD10kHF6ilcQZKkjkBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310731; c=relaxed/simple;
	bh=xaqn4sGUdk+TsI/y3bAzUKAIt4xe/v6UKM+nkBEyJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CWgw4fDxD0FNxalKrz9axzVWtc2Yi07vTtusaY+juIIL2wC3DjMJ8wj3GeRDLA+OtwxD1ko1F2SQNwf292bh4MB85tWzCl6NjyrrAom2uimlk9FFbPXXfD5cvktXZHonKEKT3k/hzo6n7LY1DIedM2h4Atv6K0ZBJsJ0CDyp7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q55tKe8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67243C32782;
	Tue, 30 Jul 2024 03:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722310730;
	bh=xaqn4sGUdk+TsI/y3bAzUKAIt4xe/v6UKM+nkBEyJyA=;
	h=Date:From:To:Cc:Subject:From;
	b=q55tKe8imzpS5XGCMmyetnOnKVMozwfJZDGgeOzacNS9C1KA6nFs0tS716x2Iks9+
	 O4bfuHx47Pzg4sgqwqyFoNVflXmnF7pQboTR1GdBCrUHyg2ZAaEFjfYxej4iLESQXJ
	 r2Fply/7OQN9OsBW3Cb1SfiACqJmR9CX0F0h2LKWJ7k5NABGguckEkTgCQCe8CgbLa
	 YYP8onyy24oHBck9QrwgAijDx6HZ9+dyH7pDQ/TDyu9G1Sn5mz+itF3yPgtEDh5vr7
	 +OD+wcaFmb+hxQRxm+fmBd/Ew99NyDqKtAuAIAnl2UMF8cJSAZh5Fe5yjdfsOAehgI
	 4Dm2kph801meA==
Date: Mon, 29 Jul 2024 20:38:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, x86@kernel.org
Subject: Are jump labels broken on 6.11-rc1?
Message-ID: <20240730033849.GH6352@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

I got the following splat on 6.11-rc1 when I tried to QA xfs online
fsck.  Does this ring a bell for anyone?  I'll try bisecting in the
morning to see if I can find the culprit.

[  110.854792] run fstests xfs/286 at 2024-07-29 17:39:44
[  113.323388] XFS (sda4): EXPERIMENTAL exchange-range feature enabled. Use at your own risk!
[  113.326183] XFS (sda4): EXPERIMENTAL parent pointer feature enabled. Use at your own risk!
[  113.330249] XFS (sda4): Mounting V5 Filesystem 6ae91845-a649-4f4b-a05c-211c6570beb9
[  113.366071] XFS (sda4): Ending clean mount
[  113.378055] XFS (sda4): EXPERIMENTAL online scrub feature in use. Use at your own risk!
[  117.051754] jump_label: Fatal kernel bug, unexpected op at xfs_dir_update_hook+0x14/0x60 [xfs] [ffffffffa05b8bd4] (eb 15 48 8b 44 != 66 90 0f 1f 00)) size:2 type:1
[  117.063445] ------------[ cut here ]------------
[  117.065515] kernel BUG at arch/x86/kernel/jump_label.c:73!
[  117.068132] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
[  117.070593] CPU: 1 UID: 0 PID: 7088 Comm: xfs_scrub Not tainted 6.11.0-rc1-djwx #rc1 6a5cf31730abd495745b329a08aeb665e92a9b62
[  117.074096] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20171121_152543-x86-ol7-builder-01.us.oracle.com-4.el7.1 04/01/2014
[  117.077176] RIP: 0010:__jump_label_patch+0x10a/0x110
[  117.078427] Code: eb a0 0f 0b 0f 0b 48 c7 c3 a4 8a 7b 82 41 56 45 89 e1 49 89 d8 4c 89 e9 4c 89 ea 4c 89 ee 48 c7 c7 48 8a e7 81 e8 d6 db 0d 00 <0f> 0b 0f 1f 40 00 0f 1f 44 00 00 e9 56 66 93 00 66 0f 1f 44 00 00
[  117.082916] RSP: 0018:ffffc90006873bc8 EFLAGS: 00010246
[  117.084129] RAX: 0000000000000097 RBX: ffffffff81c08901 RCX: 0000000000000000
[  117.085841] RDX: 0000000000000000 RSI: ffffffff81eacf51 RDI: 00000000ffffffff
[  117.087517] RBP: ffffc90006873bf8 R08: 0000000000000000 R09: 205d343537313530
[  117.089177] R10: 61746146203a6c65 R11: 62616c5f706d756a R12: 0000000000000002
[  117.090976] R13: ffffffffa05b8bd4 R14: 0000000000000001 R15: 0000001b3f9aa79f
[  117.101135] FS:  00007ff50d200680(0000) GS:ffff88842d080000(0000) knlGS:0000000000000000
[  117.111084] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.112730] CR2: 0000563357158958 CR3: 000000010440c000 CR4: 00000000003506f0
[  117.114567] Call Trace:
[  117.115153]  <TASK>
[  117.115674]  ? die+0x32/0x80
[  117.116462]  ? do_trap+0xd4/0x100
[  117.117281]  ? do_error_trap+0x65/0x80
[  117.118387]  ? __jump_label_patch+0x10a/0x110
[  117.119483]  ? exc_invalid_op+0x4c/0x60
[  117.120497]  ? __jump_label_patch+0x10a/0x110
[  117.121563]  ? asm_exc_invalid_op+0x16/0x20
[  117.122535]  ? xfs_dir_update_hook+0x14/0x60 [xfs 0af47fdcb6d4e3620a66423ae12a83496a207bf6]
[  117.124669]  ? __jump_label_patch+0x10a/0x110
[  117.125696]  ? __jump_label_patch+0x10a/0x110
[  117.126713]  arch_jump_label_transform_queue+0x33/0x70
[  117.128028]  __jump_label_update+0x6e/0x130
[  117.129034]  __static_key_slow_dec_cpuslocked.part.0+0x2c/0x50
[  117.130411]  static_key_slow_dec+0x3e/0x60
[  117.131398]  xchk_teardown+0x1a2/0x1d0 [xfs 0af47fdcb6d4e3620a66423ae12a83496a207bf6]
[  117.133649]  xfs_scrub_metadata+0x448/0x5c0 [xfs 0af47fdcb6d4e3620a66423ae12a83496a207bf6]
[  117.135869]  xfs_ioc_scrubv_metadata+0x389/0x550 [xfs 0af47fdcb6d4e3620a66423ae12a83496a207bf6]
[  117.138220]  xfs_file_ioctl+0x8f0/0xe80 [xfs 0af47fdcb6d4e3620a66423ae12a83496a207bf6]
[  117.140398]  ? inode_needs_update_time+0x4b/0xc0
[  117.141438]  ? preempt_count_add+0x4a/0xa0
[  117.142381]  ? up_write+0x64/0x180
[  117.143233]  ? shmem_file_write_iter+0x5a/0x90
[  117.144239]  ? preempt_count_add+0x4a/0xa0
[  117.145252]  ? vfs_write+0x3a2/0x4a0
[  117.146107]  __x64_sys_ioctl+0x8a/0xb0
[  117.146974]  do_syscall_64+0x47/0x100
[  117.147835]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  117.148796] RIP: 0033:0x7ff50f71ec5b
[  117.149753] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[  117.154106] RSP: 002b:00007ff50d1ff4c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  117.155900] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff50f71ec5b
[  117.157576] RDX: 00007ff50d1ff610 RSI: 00000000c0285840 RDI: 0000000000000004
[  117.159316] RBP: 00007ff50d1ff610 R08: 0000000000000000 R09: 0000000000000064
[  117.161058] R10: 00007ff50d1ff235 R11: 0000000000000246 R12: 00007ffc370a5ea0
[  117.162767] R13: 000000000000001d R14: 00007ffc370a6048 R15: 00007ff4fc005470
[  117.164490]  </TASK>
[  117.165083] Modules linked in: xfs rpcsec_gss_krb5 auth_rpcgss nft_chain_nat xt_REDIRECT nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_tcpudp ip_set_hash_ip ip_set_hash_net xt_set nft_compat ip_set_hash_mac ip_set nf_tables libcrc32c nfnetlink bfq sha512_ssse3 pvpanic_mmio sha512_generic pvpanic sha256_ssse3 sch_fq_codel fuse configfs ip_tables x_tables overlay nfsv4 af_packet
[  117.174091] Dumping ftrace buffer:
[  117.174888]    (ftrace buffer empty)
[  117.175904] ---[ end trace 0000000000000000 ]---
[  117.177523] RIP: 0010:__jump_label_patch+0x10a/0x110
[  117.178763] Code: eb a0 0f 0b 0f 0b 48 c7 c3 a4 8a 7b 82 41 56 45 89 e1 49 89 d8 4c 89 e9 4c 89 ea 4c 89 ee 48 c7 c7 48 8a e7 81 e8 d6 db 0d 00 <0f> 0b 0f 1f 40 00 0f 1f 44 00 00 e9 56 66 93 00 66 0f 1f 44 00 00
[  117.183181] RSP: 0018:ffffc90006873bc8 EFLAGS: 00010246
[  117.184298] RAX: 0000000000000097 RBX: ffffffff81c08901 RCX: 0000000000000000
[  117.185948] RDX: 0000000000000000 RSI: ffffffff81eacf51 RDI: 00000000ffffffff
[  117.187865] RBP: ffffc90006873bf8 R08: 0000000000000000 R09: 205d343537313530
[  117.195190] R10: 61746146203a6c65 R11: 62616c5f706d756a R12: 0000000000000002
[  117.201641] R13: ffffffffa05b8bd4 R14: 0000000000000001 R15: 0000001b3f9aa79f
[  117.205179] FS:  00007ff50d200680(0000) GS:ffff88842d000000(0000) knlGS:0000000000000000
[  117.216723] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  117.220417] CR2: 00007f7d9bb54010 CR3: 000000010440c000 CR4: 00000000003506f0

--Darrick

