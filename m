Return-Path: <linux-fsdevel+bounces-27592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBA962AB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF16281C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73219FA80;
	Wed, 28 Aug 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGna2OCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E221C19E83D;
	Wed, 28 Aug 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856497; cv=none; b=mjDC5DEXJHJPIyvBkkJ3my4R9W64BYwR5jvzXC0IBkyCoGjOyAEssznGc07hu4lnmSfPYaPyMHQYmSPEndB5MV6ah9jqFRsZ/wXChiqcC70NQ3hbBxPLfCTqlp4W1Xo1a0tQNEzZQaFFLA9Z3N/IA91Y+q+3rHz583hfazeBXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856497; c=relaxed/simple;
	bh=m03l2pckmcLxB1u80BXxyIAto7ot9H09XhIkMydHFCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIMIgJUqAGVPzRYSJaRkDlHfMo36W9d+lI8eFzZ4atu+Oqwl0u+ErTPcMwMS+q5LPmBu7rSk94pE/S28jPVFz11F7LCfJlaq1NIvnOp36zdO4Hvt3SXvakW1Ku1iGxmnk47n6vOYoOD523YeRVzJwbx8k/vMaimZuIW7V29KdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGna2OCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B12C4FE14;
	Wed, 28 Aug 2024 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856496;
	bh=m03l2pckmcLxB1u80BXxyIAto7ot9H09XhIkMydHFCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGna2OCEOd0yRlCJ/Mi3lmHZ9WToycz/5la6bbGFhBefHrOTJ4SgA3Eu5sTfH16E+
	 ZRDHQKl//Hr0jSYe+RoBhgi1Y4qgX4S/NT7ymxesaNF4cJ8yBOm2VM/dQk3P/FmRq4
	 +Kif3jLVLYZUzYUqHvXmbeYe7Ak+/sMmrS08tr+SBCBAwcHk6zbYDu8PvNAWF/V1go
	 07avT2WOJPWscyQJklczLyWKXWtUm89dP/d5qMK1QYnqS8h7pFMgr0IoQKXEkMAvfO
	 AmEdW7kfX/Q/ld+TJNfrTlMLARNpqjgHWs4JpwlW7432MXLBo3MAsjvuKj6C85sJ8q
	 ouorR+R/JX6jQ==
From: Christian Brauner <brauner@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
Date: Wed, 28 Aug 2024 16:48:02 +0200
Message-ID: <20240828-abgegangen-neuformulierung-6fe9fc2b0b3e@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826055503.1522320-1-lizhijian@fujitsu.com>
References: <20240826055503.1522320-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=brauner@kernel.org; h=from:subject:message-id; bh=m03l2pckmcLxB1u80BXxyIAto7ot9H09XhIkMydHFCs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSdt1hZ/X/7P7dPDV5rj5mb//aXmV9yIa7GUFzGItKDV 2TGqjk7O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi+JLhD3ejT5f7g2k3tR2e dCWJ7r/H9/ncl4Ls0n17uj/Ir/i+0Yrhn7qWE6Mrw6YH59pPa23xUb5Wcqi8bmtr8wGjs3mrdjS +ZwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 13:55:03 +0800, Li Zhijian wrote:
> It's observed that a crash occurs during hot-remove a memory device,
> in which user is accessing the hugetlb. See calltrace as following:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 14045 at arch/x86/mm/fault.c:1278 do_user_addr_fault+0x2a0/0x790
> Modules linked in: kmem device_dax cxl_mem cxl_pmem cxl_port cxl_pci dax_hmem dax_pmem nd_pmem cxl_acpi nd_btt cxl_core crc32c_intel nvme virtiofs fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc s
> mirror dm_region_hash dm_log dm_mod
> CPU: 1 PID: 14045 Comm: daxctl Not tainted 6.10.0-rc2-lizhijian+ #492
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:do_user_addr_fault+0x2a0/0x790
> Code: 48 8b 00 a8 04 0f 84 b5 fe ff ff e9 1c ff ff ff 4c 89 e9 4c 89 e2 be 01 00 00 00 bf 02 00 00 00 e8 b5 ef 24 00 e9 42 fe ff ff <0f> 0b 48 83 c4 08 4c 89 ea 48 89 ee 4c 89 e7 5b 5d 41 5c 41 5d 41
> RSP: 0000:ffffc90000a575f0 EFLAGS: 00010046
> RAX: ffff88800c303600 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000001000 RSI: ffffffff82504162 RDI: ffffffff824b2c36
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000a57658
> R13: 0000000000001000 R14: ffff88800bc2e040 R15: 0000000000000000
> FS:  00007f51cb57d880(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000001000 CR3: 00000000072e2004 CR4: 00000000001706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __warn+0x8d/0x190
>  ? do_user_addr_fault+0x2a0/0x790
>  ? report_bug+0x1c3/0x1d0
>  ? handle_bug+0x3c/0x70
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  ? do_user_addr_fault+0x2a0/0x790
>  ? exc_page_fault+0x31/0x200
>  exc_page_fault+0x68/0x200
> <...snip...>
> BUG: unable to handle page fault for address: 0000000000001000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  ---[ end trace 0000000000000000 ]---
>  BUG: unable to handle page fault for address: 0000000000001000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 1 PID: 14045 Comm: daxctl Kdump: loaded Tainted: G        W          6.10.0-rc2-lizhijian+ #492
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:dentry_name+0x1f4/0x440
> <...snip...>
> ? dentry_name+0x2fa/0x440
> vsnprintf+0x1f3/0x4f0
> vprintk_store+0x23a/0x540
> vprintk_emit+0x6d/0x330
> _printk+0x58/0x80
> dump_mapping+0x10b/0x1a0
> ? __pfx_free_object_rcu+0x10/0x10
> __dump_page+0x26b/0x3e0
> ? vprintk_emit+0xe0/0x330
> ? _printk+0x58/0x80
> ? dump_page+0x17/0x50
> dump_page+0x17/0x50
> do_migrate_range+0x2f7/0x7f0
> ? do_migrate_range+0x42/0x7f0
> ? offline_pages+0x2f4/0x8c0
> offline_pages+0x60a/0x8c0
> memory_subsys_offline+0x9f/0x1c0
> ? lockdep_hardirqs_on+0x77/0x100
> ? _raw_spin_unlock_irqrestore+0x38/0x60
> device_offline+0xe3/0x110
> state_store+0x6e/0xc0
> kernfs_fop_write_iter+0x143/0x200
> vfs_write+0x39f/0x560
> ksys_write+0x65/0xf0
> do_syscall_64+0x62/0x130
> 
> [...]

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] fs/inode: Prevent dump_mapping() accessing invalid dentry.d_name.name
      https://git.kernel.org/vfs/vfs/c/e57de7d9e7fc

