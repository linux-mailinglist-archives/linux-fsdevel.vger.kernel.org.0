Return-Path: <linux-fsdevel+bounces-65755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD062C10380
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAE114F95AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80985331A66;
	Mon, 27 Oct 2025 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dq4TigHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D7C3203BB;
	Mon, 27 Oct 2025 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590792; cv=none; b=FNw6Q4SUCu442mfL+MkDYHEVQJdEEnWu20KSW4kENh9/3mBFHgsthif/tdUtNkfPl8QbEKMEU6BkxIvWNzg+ACKAr/8p6C18GgVpTdPdqp+YjXoZzwEp/p8xUUE8rkdrEZSHa6foM0d8g/GNW0M3OJ5lR0ICmFoLfFB4OavMVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590792; c=relaxed/simple;
	bh=UKMGjClOgAU/LO8E115T72BMrvKr0YodzRBUjOhnLYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXExjq4OaLYMI3LAIfIBHCRfUs8uXfrZQQWloSKSpTTyvYYCK0SccoMPILNuc07g513D58km5iAohkaipe3P4Y1lsqJasjrgn1pRLTwVMsB/HVnpvNCJgcUKNiiCyPWpKZ2narqFyX3WrOJ8SULTH5VovUOI/lQBinxg60dAdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dq4TigHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B816BC4CEF1;
	Mon, 27 Oct 2025 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761590792;
	bh=UKMGjClOgAU/LO8E115T72BMrvKr0YodzRBUjOhnLYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dq4TigHOi7yZu/M6MqPozH7zUk2Z/pfL5TWQk1Lq2+FMCcv0K8L7VLntyJHfAjD66
	 6dUvXAlBDHTXReHvkjgmAkeFj7hm+yqX9+nUZSQruR4yX0MyK7PkPCox/8AoucgXj4
	 ngs+/bUG5+jjWCJv7N6208d/NXBOaeS+uF47WeQo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 177/224] hfsplus: fix KMSAN uninit-value issue in hfsplus_delete_cat()
Date: Mon, 27 Oct 2025 19:35:23 +0100
Message-ID: <20251027183513.614536196@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 9b3d15a758910bb98ba8feb4109d99cc67450ee4 ]

The syzbot reported issue in hfsplus_delete_cat():

[   70.682285][ T9333] =====================================================
[   70.682943][ T9333] BUG: KMSAN: uninit-value in hfsplus_subfolders_dec+0x1d7/0x220
[   70.683640][ T9333]  hfsplus_subfolders_dec+0x1d7/0x220
[   70.684141][ T9333]  hfsplus_delete_cat+0x105d/0x12b0
[   70.684621][ T9333]  hfsplus_rmdir+0x13d/0x310
[   70.685048][ T9333]  vfs_rmdir+0x5ba/0x810
[   70.685447][ T9333]  do_rmdir+0x964/0xea0
[   70.685833][ T9333]  __x64_sys_rmdir+0x71/0xb0
[   70.686260][ T9333]  x64_sys_call+0xcd8/0x3cf0
[   70.686695][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.687119][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.687646][ T9333]
[   70.687856][ T9333] Uninit was stored to memory at:
[   70.688311][ T9333]  hfsplus_subfolders_inc+0x1c2/0x1d0
[   70.688779][ T9333]  hfsplus_create_cat+0x148e/0x1800
[   70.689231][ T9333]  hfsplus_mknod+0x27f/0x600
[   70.689730][ T9333]  hfsplus_mkdir+0x5a/0x70
[   70.690146][ T9333]  vfs_mkdir+0x483/0x7a0
[   70.690545][ T9333]  do_mkdirat+0x3f2/0xd30
[   70.690944][ T9333]  __x64_sys_mkdir+0x9a/0xf0
[   70.691380][ T9333]  x64_sys_call+0x2f89/0x3cf0
[   70.691816][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.692229][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.692773][ T9333]
[   70.692990][ T9333] Uninit was stored to memory at:
[   70.693469][ T9333]  hfsplus_subfolders_inc+0x1c2/0x1d0
[   70.693960][ T9333]  hfsplus_create_cat+0x148e/0x1800
[   70.694438][ T9333]  hfsplus_fill_super+0x21c1/0x2700
[   70.694911][ T9333]  mount_bdev+0x37b/0x530
[   70.695320][ T9333]  hfsplus_mount+0x4d/0x60
[   70.695729][ T9333]  legacy_get_tree+0x113/0x2c0
[   70.696167][ T9333]  vfs_get_tree+0xb3/0x5c0
[   70.696588][ T9333]  do_new_mount+0x73e/0x1630
[   70.697013][ T9333]  path_mount+0x6e3/0x1eb0
[   70.697425][ T9333]  __se_sys_mount+0x733/0x830
[   70.697857][ T9333]  __x64_sys_mount+0xe4/0x150
[   70.698269][ T9333]  x64_sys_call+0x2691/0x3cf0
[   70.698704][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.699117][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.699730][ T9333]
[   70.699946][ T9333] Uninit was created at:
[   70.700378][ T9333]  __alloc_pages_noprof+0x714/0xe60
[   70.700843][ T9333]  alloc_pages_mpol_noprof+0x2a2/0x9b0
[   70.701331][ T9333]  alloc_pages_noprof+0xf8/0x1f0
[   70.701774][ T9333]  allocate_slab+0x30e/0x1390
[   70.702194][ T9333]  ___slab_alloc+0x1049/0x33a0
[   70.702635][ T9333]  kmem_cache_alloc_lru_noprof+0x5ce/0xb20
[   70.703153][ T9333]  hfsplus_alloc_inode+0x5a/0xd0
[   70.703598][ T9333]  alloc_inode+0x82/0x490
[   70.703984][ T9333]  iget_locked+0x22e/0x1320
[   70.704428][ T9333]  hfsplus_iget+0x5c/0xba0
[   70.704827][ T9333]  hfsplus_btree_open+0x135/0x1dd0
[   70.705291][ T9333]  hfsplus_fill_super+0x1132/0x2700
[   70.705776][ T9333]  mount_bdev+0x37b/0x530
[   70.706171][ T9333]  hfsplus_mount+0x4d/0x60
[   70.706579][ T9333]  legacy_get_tree+0x113/0x2c0
[   70.707019][ T9333]  vfs_get_tree+0xb3/0x5c0
[   70.707444][ T9333]  do_new_mount+0x73e/0x1630
[   70.707865][ T9333]  path_mount+0x6e3/0x1eb0
[   70.708270][ T9333]  __se_sys_mount+0x733/0x830
[   70.708711][ T9333]  __x64_sys_mount+0xe4/0x150
[   70.709158][ T9333]  x64_sys_call+0x2691/0x3cf0
[   70.709630][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.710053][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.710611][ T9333]
[   70.710842][ T9333] CPU: 3 UID: 0 PID: 9333 Comm: repro Not tainted 6.12.0-rc6-dirty #17
[   70.711568][ T9333] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.712490][ T9333] =====================================================
[   70.713085][ T9333] Disabling lock debugging due to kernel taint
[   70.713618][ T9333] Kernel panic - not syncing: kmsan.panic set ...
[   70.714159][ T9333] CPU: 3 UID: 0 PID: 9333 Comm: repro Tainted: G    B              6.12.0-rc6-dirty #17
[   70.715007][ T9333] Tainted: [B]=BAD_PAGE
[   70.715365][ T9333] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   70.716311][ T9333] Call Trace:
[   70.716621][ T9333]  <TASK>
[   70.716899][ T9333]  dump_stack_lvl+0x1fd/0x2b0
[   70.717350][ T9333]  dump_stack+0x1e/0x30
[   70.717743][ T9333]  panic+0x502/0xca0
[   70.718116][ T9333]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.718611][ T9333]  kmsan_report+0x296/0x2a0
[   70.719038][ T9333]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.719859][ T9333]  ? __msan_warning+0x96/0x120
[   70.720345][ T9333]  ? hfsplus_subfolders_dec+0x1d7/0x220
[   70.720881][ T9333]  ? hfsplus_delete_cat+0x105d/0x12b0
[   70.721412][ T9333]  ? hfsplus_rmdir+0x13d/0x310
[   70.721880][ T9333]  ? vfs_rmdir+0x5ba/0x810
[   70.722458][ T9333]  ? do_rmdir+0x964/0xea0
[   70.722883][ T9333]  ? __x64_sys_rmdir+0x71/0xb0
[   70.723397][ T9333]  ? x64_sys_call+0xcd8/0x3cf0
[   70.723915][ T9333]  ? do_syscall_64+0xd9/0x1d0
[   70.724454][ T9333]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.725110][ T9333]  ? vprintk_emit+0xd1f/0xe60
[   70.725616][ T9333]  ? vprintk_default+0x3f/0x50
[   70.726175][ T9333]  ? vprintk+0xce/0xd0
[   70.726628][ T9333]  ? _printk+0x17e/0x1b0
[   70.727129][ T9333]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.727739][ T9333]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.728324][ T9333]  __msan_warning+0x96/0x120
[   70.728854][ T9333]  hfsplus_subfolders_dec+0x1d7/0x220
[   70.729479][ T9333]  hfsplus_delete_cat+0x105d/0x12b0
[   70.729984][ T9333]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.730646][ T9333]  ? __msan_metadata_ptr_for_load_4+0x24/0x40
[   70.731296][ T9333]  ? kmsan_get_metadata+0x13e/0x1c0
[   70.731863][ T9333]  hfsplus_rmdir+0x13d/0x310
[   70.732390][ T9333]  ? __pfx_hfsplus_rmdir+0x10/0x10
[   70.732919][ T9333]  vfs_rmdir+0x5ba/0x810
[   70.733416][ T9333]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   70.734044][ T9333]  do_rmdir+0x964/0xea0
[   70.734537][ T9333]  __x64_sys_rmdir+0x71/0xb0
[   70.735032][ T9333]  x64_sys_call+0xcd8/0x3cf0
[   70.735579][ T9333]  do_syscall_64+0xd9/0x1d0
[   70.736092][ T9333]  ? irqentry_exit+0x16/0x60
[   70.736637][ T9333]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   70.737269][ T9333] RIP: 0033:0x7fa9424eafc9
[   70.737775][ T9333] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
[   70.739844][ T9333] RSP: 002b:00007fff099cd8d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000054
[   70.740760][ T9333] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa9424eafc9
[   70.741642][ T9333] RDX: 006c6f72746e6f63 RSI: 000000000000000a RDI: 0000000020000100
[   70.742543][ T9333] RBP: 00007fff099cd8e0 R08: 00007fff099cd910 R09: 00007fff099cd910
[   70.743376][ T9333] R10: 0000000000000000 R11: 0000000000000202 R12: 0000565430642260
[   70.744247][ T9333] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   70.745082][ T9333]  </TASK>

The main reason of the issue that struct hfsplus_inode_info
has not been properly initialized for the case of root folder.
In the case of root folder, hfsplus_fill_super() calls
the hfsplus_iget() that implements only partial initialization of
struct hfsplus_inode_info and subfolders field is not
initialized by hfsplus_iget() logic.

This patch implements complete initialization of
struct hfsplus_inode_info in the hfsplus_iget() logic with
the goal to prevent likewise issues for the case of
root folder.

Reported-by: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250825225103.326401-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/super.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 29a39afe26535..d744fde416804 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -67,13 +67,26 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	if (!(inode->i_state & I_NEW))
 		return inode;
 
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
-	mutex_init(&HFSPLUS_I(inode)->extents_lock);
-	HFSPLUS_I(inode)->flags = 0;
+	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->first_blocks = 0;
+	HFSPLUS_I(inode)->clump_blocks = 0;
+	HFSPLUS_I(inode)->alloc_blocks = 0;
+	HFSPLUS_I(inode)->cached_start = U32_MAX;
+	HFSPLUS_I(inode)->cached_blocks = 0;
+	memset(HFSPLUS_I(inode)->first_extents, 0, sizeof(hfsplus_extent_rec));
+	memset(HFSPLUS_I(inode)->cached_extents, 0, sizeof(hfsplus_extent_rec));
 	HFSPLUS_I(inode)->extent_state = 0;
+	mutex_init(&HFSPLUS_I(inode)->extents_lock);
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
-	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
+	HFSPLUS_I(inode)->create_date = 0;
+	HFSPLUS_I(inode)->linkid = 0;
+	HFSPLUS_I(inode)->flags = 0;
+	HFSPLUS_I(inode)->fs_blocks = 0;
+	HFSPLUS_I(inode)->userflags = 0;
+	HFSPLUS_I(inode)->subfolders = 0;
+	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
+	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
+	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
 	    inode->i_ino == HFSPLUS_ROOT_CNID) {
-- 
2.51.0




