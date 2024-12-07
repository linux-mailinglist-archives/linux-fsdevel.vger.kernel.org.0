Return-Path: <linux-fsdevel+bounces-36692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A80B9E7FD0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 13:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861C8281FCF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64582146A71;
	Sat,  7 Dec 2024 12:17:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C60A10E0;
	Sat,  7 Dec 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733573867; cv=none; b=QW3BdxPV7VCkBfGFpWoGwGACrtDSCmBmTbouyMchKMIYOPIalH7F0R/O1deZeLKN6Q/gqqrTC8pFXCvC2imBZgJcW9PRJfnvE1naapByZf90N9IensbqwxxqxvPdBCvUDOC41wB7z8YBUHqDErD461NSycWfdRNjvOiFSPjVMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733573867; c=relaxed/simple;
	bh=GH7HC58QseC4em9A+U4vEUvrdptTywLuZbfwFW3y17g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/kn41FMDCp+waUAfs4/tF0HZjos3A3umeYpZNRHcZvrSWIPnBefIxVuUY8BVOOTpItG+fV2exIp/t7Ay51RNTlN7S77wJQ7/3/NOP2GCgqjDpbK3Ne81UMaERnIoBb6jGeNFeDZwMdXP2j/ba+CJzuBt3ZS4FWfwHN5bDVvf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 6C7B423386;
	Sat,  7 Dec 2024 15:17:33 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kovalev@altlinux.org,
	lvc-project@linuxtesting.org,
	syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Date: Sat,  7 Dec 2024 15:17:26 +0300
Message-Id: <20241207121726.1058037-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an issue in hfs subsystem:

BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
 memcpy_from_page include/linux/highmem.h:423 [inline]
 hfs_bnode_read fs/hfs/bnode.c:35 [inline]
 hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
 hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
 hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
 hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdir fs/namei.c:4300 [inline]
 __se_sys_mkdir fs/namei.c:4298 [inline]
 __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbdd6057a99

Add validation for key length in hfs_bnode_read_key to prevent
out-of-bounds memory access. Invalid key lengths, likely caused
by corrupted file system images (potentially due to malformed
data during image generation), now result in clearing the key
buffer, enhancing stability and reliability.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
v2: add more information to the commit message regarding the purpose of the patch.
---
 fs/hfs/bnode.c     | 6 ++++++
 fs/hfsplus/bnode.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 6add6ebfef8967..cb823a8a6ba960 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 1;
 
+	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfs_btree_key));
+		pr_err("hfs: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 87974d5e679156..079ea80534f7de 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 2;
 
+	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
+		memset(key, 0, sizeof(hfsplus_btree_key));
+		pr_err("hfsplus: Invalid key length: %d\n", key_len);
+		return;
+	}
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
-- 
2.33.8


