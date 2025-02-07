Return-Path: <linux-fsdevel+bounces-41221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94BA2C6AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A87188C3FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A041EB184;
	Fri,  7 Feb 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGTFzkOL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91C4A1A;
	Fri,  7 Feb 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941421; cv=none; b=Nn3f3gN3O3lhb2GecM0FPRAp4F3XdxaygnX2IbjMuqGVP/fp+0sKXBBMOfSGMqI9OYF5gMXIOHxy241aY5zc+qT89Tne/GMnWZvQert+iwPGHs7yJr6P1FNii9AU19TEu8+uddNHkJBFSbb+LjLmZMcbMUTWJu1jD3e+bn2iWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941421; c=relaxed/simple;
	bh=DQX8fJk82m6yQMREjF99LALmSyrnULFCflmQR/Z58UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQ0aIZ9kKQfNnflDL8Ul+1o/fBbcL/LUgrHW8sK434IX+nGNy6Xm+NYWY4XlEJ+EvxcUXQeB18b5Pj4R38lhJXqTI/R73UnMDY9BGz38PnaO48tSPjXFpUEuLruOtEcg4h8w4xNUJOnORxTW/oriIIL6KYxeorTjVf4qp8rJW4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGTFzkOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD7C4CED1;
	Fri,  7 Feb 2025 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738941420;
	bh=DQX8fJk82m6yQMREjF99LALmSyrnULFCflmQR/Z58UM=;
	h=From:To:Cc:Subject:Date:From;
	b=IGTFzkOLfnTT51GhCCPTqlKEUJKBmDvuGagIygVJx5eLeU7SQbKIOhcnuUqTmp5+R
	 aiO5uO2pdjxM1cotlq5C7NHSbwb/nmXLgMD1KvWYrjHejvBTciQFkQ931KV/lRTGgu
	 BtudaDGuJMFYgQLa29g5ZQDIevouzqy99P3PMauJK3rhrEukqK5cpsxNLqg2h9pCXt
	 duVNLN7JY/zka07ZDR+OKBu/an4hbgXVuoA1WEYYqnzcdtC6to7At5ZwptpPYELjG9
	 h5gUyFfgvup/8zGMHKKXJNsYxkfOt/v/We+LUSQxyygKR22SV7dSkeUnEez20y9kca
	 uNxWjH1+HBgBg==
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: xfs/folio splat with v6.14-rc1
Date: Fri,  7 Feb 2025 16:16:38 +0100
Message-ID: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7126; i=brauner@kernel.org; h=from:subject:message-id; bh=DQX8fJk82m6yQMREjF99LALmSyrnULFCflmQR/Z58UM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvU77+4eRXufP7o4XDFANLrTjPP+ZiPx/NVzdD4t/+F wfvXUy27ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIK0lGhpPF8lb79j16yLzz 4At+ry3XImPEK2472l05EinALf47fQMjw9ktixmvMUxlSfawN2Re8/GxrGZ5kZvH5Ks/H6jOYk7 9zgQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey,

I've seen the following splat running xfstests with:

#! /bin/bash

set -x

cd /var/lib/xfstests/
FIRST_DEV=/dev/nvme3n1
SECOND_DEV=/dev/nvme5n1
THIRD_DEV=/dev/nvme0n1p3
FOURTH_DEV=/dev/nvme0n1p4
FIFTH_DEV=/dev/nvme0n1p5

echo "Testing xfs"
sudo bash -c "cat <<EOF >local.config
FSTYP=xfs
export TEST_DEV=${FIRST_DEV}
export SCRATCH_DEV=${SECOND_DEV}
export LOGWRITES_DEV=${THIRD_DEV}
export TEST_LOGDEV=${FOURTH_DEV}
export TEST_RTDEV=${FIFTH_DEV}
export TEST_DIR=/mnt/test
export SCRATCH_MNT=/mnt/scratch
EOF"

sudo mkfs.xfs -f ${FIRST_DEV}
sudo mkfs.xfs -f ${SECOND_DEV}
sudo ./check -g quick -e generic/211

I've tried to reproduce it just doing

sudo ./check generic/437

but no luck so far it only triggered during a full -g quick run.
I suppose it might be combination of two tests.

[ 6162.659115] run fstests generic/436 at 2025-02-07 13:18:35
[ 6166.498531] XFS (nvme3n1): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
[ 6169.400697] XFS (nvme3n1): Unmounting Filesystem def8922c-2889-4223-8f28-ee373e9b2662
[ 6169.971457] XFS (nvme3n1): Mounting V5 Filesystem def8922c-2889-4223-8f28-ee373e9b2662
[ 6170.026461] XFS (nvme3n1): Ending clean mount
[ 6170.564391] run fstests generic/437 at 2025-02-07 13:18:42
[ 6176.844388] XFS (nvme3n1): EXPERIMENTAL online scrub feature enabled.  Use at your own risk!
[ 6177.031505] BUG: Bad rss-counter state mm:000000006ccec348 type:MM_FILEPAGES val:11
[ 6177.036114] BUG: Bad rss-counter state mm:000000006ccec348 type:MM_ANONPAGES val:1
[ 6179.807212] page: refcount:8 mapcount:0 mapping:00000000c63ffea0 index:0x0 pfn:0x18e6dc
[ 6179.810114] head: order:2 mapcount:3 entire_mapcount:0 nr_pages_mapped:3 pincount:0
[ 6179.812116] memcg:ffff8881a1d86000
[ 6179.812988] aops:xfs_address_space_operations [xfs] ino:302
[ 6179.814500] flags: 0x17ffe000000016d(locked|referenced|uptodate|lru|active|head|node=0|zone=2|lastcpupid=0x3fff)
[ 6179.818259] raw: 017ffe000000016d ffffea000698dac8 ffffea000a26da08 ffff88818bca4008
[ 6179.819814] raw: 0000000000000000 0000000000000000 00000008ffffffff ffff8881a1d86000
[ 6179.821390] head: 017ffe000000016d ffffea000698dac8 ffffea000a26da08 ffff88818bca4008
[ 6179.822956] head: 0000000000000000 0000000000000000 00000008ffffffff ffff8881a1d86000
[ 6179.824522] head: 017ffe0000000202 ffffea000639b701 ffffffff00000002 0000000000000003
[ 6179.826093] head: 0000000700000004 0000000000000000 0000000000000000 0000000000000000
[ 6179.827629] page dumped because: VM_BUG_ON_FOLIO(folio_mapped(folio))
[ 6179.828946] ------------[ cut here ]------------
[ 6179.829862] kernel BUG at mm/filemap.c:154!
[ 6179.830727] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[ 6179.831889] CPU: 29 UID: 0 PID: 432263 Comm: umount Not tainted 6.14.0-rc1-g37d11cfc6360 #20
[ 6179.833562] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown 2/2/2022
[ 6179.835273] RIP: 0010:filemap_unaccount_folio+0x4a1/0x810
[ 6179.836391] Code: e0 07 83 c0 03 38 d0 7d 45 8b 43 50 83 c0 01 48 8d 6b 30 85 c0 0f 8e 28 fc ff ff 48 c7 c6 80 85 74 86 48 89 df e8 4f 27 0d 00 <0f> 0b 48 c7 c6 60 7f 74 86 48 89 df e8 3e 27 0d 00 0f 0b 48 c7 c6
[ 6179.840080] RSP: 0018:ffffc9002ecc7708 EFLAGS: 00010086
[ 6179.841130] RAX: 0000000000000039 RBX: ffffea000639b700 RCX: 0000000000000000
[ 6179.842548] RDX: 0000000000000039 RSI: 0000000000000004 RDI: fffff52005d98ed3
[ 6179.843956] RBP: ffffea000639b730 R08: 0000000000000001 R09: ffffed107acd5161
[ 6179.845371] R10: ffff8883d66a8b0b R11: 0000000000000001 R12: ffffea000639b708
[ 6179.848233] R13: ffff88818bca4008 R14: 0000000000000001 R15: ffffc9002ecc7a20
[ 6179.849658] FS:  00007fdea0f30800(0000) GS:ffff8883d6680000(0000) knlGS:0000000000000000
[ 6179.851255] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6179.852408] CR2: 00007fdea11ed1a0 CR3: 00000001cb2bc002 CR4: 0000000000770ef0
[ 6179.853804] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 6179.855212] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 6179.856629] PKRU: 55555554
[ 6179.857180] Call Trace:
[ 6179.857667]  <TASK>
[ 6179.858095]  ? __die_body.cold+0x19/0x1f
[ 6179.858890]  ? die+0x2e/0x50
[ 6179.859479]  ? do_trap+0x1e4/0x2c0
[ 6179.860164]  ? filemap_unaccount_folio+0x4a1/0x810
[ 6179.861113]  ? do_error_trap+0xa3/0x170
[ 6179.861870]  ? filemap_unaccount_folio+0x4a1/0x810
[ 6179.862811]  ? handle_invalid_op+0x2c/0x30
[ 6179.863613]  ? filemap_unaccount_folio+0x4a1/0x810
[ 6179.864548]  ? exc_invalid_op+0x2d/0x40
[ 6179.865322]  ? asm_exc_invalid_op+0x1a/0x20
[ 6179.866166]  ? filemap_unaccount_folio+0x4a1/0x810
[ 6179.867094]  ? filemap_unaccount_folio+0x4a1/0x810
[ 6179.868027]  delete_from_page_cache_batch+0x1a1/0x9f0
[ 6179.869013]  ? lockdep_hardirqs_on+0x78/0x100
[ 6179.869861]  ? filemap_remove_folio+0x1e0/0x1e0
[ 6179.870749]  ? kfree+0x140/0x4b0
[ 6179.871393]  ? truncate_cleanup_folio+0x1f4/0x470
[ 6179.872314]  truncate_inode_pages_range+0x1f0/0xc60
[ 6179.873269]  ? truncate_inode_partial_folio+0x560/0x560
[ 6179.874282]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[ 6179.875274]  ? print_usage_bug.part.0+0x690/0x690
[ 6179.876206]  ? mark_held_locks+0x94/0xe0
[ 6179.876972]  ? _raw_spin_unlock_irq+0x28/0x50
[ 6179.878856]  ? lockdep_hardirqs_on+0x78/0x100
[ 6179.879730]  evict+0x6a9/0x840
[ 6179.880335]  ? destroy_inode+0x190/0x190
[ 6179.881100]  ? reacquire_held_locks+0x4d0/0x4d0
[ 6179.881969]  ? do_raw_spin_unlock+0x58/0x210
[ 6179.882800]  ? _raw_spin_unlock+0x2d/0x50
[ 6179.883577]  dispose_list+0xf0/0x1b0
[ 6179.884274]  evict_inodes+0x2e2/0x3e0
[ 6179.884989]  ? dispose_list+0x1b0/0x1b0
[ 6179.885731]  ? sync_filesystem+0x169/0x200
[ 6179.886526]  ? xfs_fs_sync_fs+0x15c/0x2c0 [xfs]
[ 6179.887645]  generic_shutdown_super+0xb9/0x4c0
[ 6179.888494]  kill_block_super+0x3b/0x90
[ 6179.889234]  xfs_kill_sb+0x12/0x50 [xfs]
[ 6179.890237]  deactivate_locked_super+0xa2/0x160
[ 6179.891104]  cleanup_mnt+0x1e2/0x3e0
[ 6179.891788]  task_work_run+0x116/0x200
[ 6179.892500]  ? task_work_cancel+0x30/0x30
[ 6179.893261]  ? __x64_sys_umount+0x116/0x140
[ 6179.894045]  syscall_exit_to_user_mode+0x2d8/0x2e0
[ 6179.895037]  do_syscall_64+0x80/0x190
[ 6179.895738]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 6179.896710] RIP: 0033:0x7fdea1177637
[ 6179.897407] Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b9 57 0d 00 f7 d8 64 89 02 b8
[ 6179.900868] RSP: 002b:00007ffc934c4e28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[ 6179.902297] RAX: 0000000000000000 RBX: 0000564ae10a3b58 RCX: 00007fdea1177637
[ 6179.903635] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000564ae10a9500
[ 6179.904963] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
[ 6179.906281] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdea12d0244
[ 6179.907609] R13: 0000564ae10a9500 R14: 0000564ae10a3e60 R15: 0000564ae10a3a50
[ 6179.909968]  </TASK>

