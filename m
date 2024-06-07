Return-Path: <linux-fsdevel+bounces-21205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06747900657
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 677F8B23645
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6406194AD5;
	Fri,  7 Jun 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVQipCbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321251DFC5;
	Fri,  7 Jun 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770202; cv=none; b=lzMowhnOa4pSLMbhKOeuX8qs6B/naL0MfDHJmYUuG8sr5rH2kUhLwjcYBz/i2u68XsgGp/x3SEoCh9aeuAZlp3zdP6/S2NvPQ4G12tJcKf9zWz5DAzmXPOJGc6wY9iQ6zT1JSbLmPHSkmwNvrXTM/FhK/fvS2l8yBky3UW0Wph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770202; c=relaxed/simple;
	bh=jC5KdN3iR66YvPbVE6j7MiDgwoUQwI/b2jmyTOxWUZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=C3vVZ4o8s7LZwSjIX3kBvQ/gVcMaOAIYobk78LtKpCcSF24diBjlS5toP8LA7tEpD2I4THgReRSvEuOCFBs+I4h1V+2povW9tNMPvsAf5TTnI6AgaNM+GyWsO67Vy08zR8vtNqv1qtzMWVm07QpTsG49KQ9xMklXowxePhWcDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVQipCbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D01C3277B;
	Fri,  7 Jun 2024 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717770201;
	bh=jC5KdN3iR66YvPbVE6j7MiDgwoUQwI/b2jmyTOxWUZM=;
	h=From:To:Cc:Subject:Date:From;
	b=YVQipCbXj8ZWfuh9XDXy4PtL2n3Pwamllb20cQCA4OqNqNu/oeYyuYuHLVcvtk7hf
	 uHeNa9Evpd1XlA6IoPmKE+Ne7SwYP18IeJsYM2/0O9wSsoQU15xK/BmCM0+b0/K4T2
	 O6xK0wu51raZEzWmmWJySk1VIbdSN2rBMdBWfDKnaKKkVR0gGp9/WplYKZkmMThFBi
	 MT3w9tOSeJI+eS/ZnAZ3OoRXRF5SfuHTg0e15IPGi3j2tsWenpDMjJYaWvAAc3tJzM
	 nrShddaLoJ8yt39DTgrwbEbU4hUx1pIQy6fc2oBCDWleHgCAfI/0hOZQYs6wd+tqcp
	 P0I5X6H3uuOfQ==
From: Chao Yu <chao@kernel.org>
To: akpm@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com,
	=?UTF-8?q?Ernesto=20A=20=2E=20Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Subject: [PATCH] hfsplus: fix to avoid false alarm of circular locking
Date: Fri,  7 Jun 2024 22:23:04 +0800
Message-Id: <20240607142304.455441-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Syzbot report potential ABBA deadlock as below:

loop0: detected capacity change from 0 to 1024
======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-10323-g8f6a15f095a6 #0 Not tainted
------------------------------------------------------
syz-executor171/5344 is trying to acquire lock:
ffff88807cb980b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x811/0xb50 fs/hfsplus/extents.c:595

but task is already holding lock:
ffff88807a930108 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_file_truncate+0x2da/0xb50 fs/hfsplus/extents.c:576

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_extend+0x21b/0x1b70 fs/hfsplus/extents.c:457
       hfsplus_bmap_reserve+0x105/0x4e0 fs/hfsplus/btree.c:358
       hfsplus_rename_cat+0x1d0/0x1050 fs/hfsplus/catalog.c:456
       hfsplus_rename+0x12e/0x1c0 fs/hfsplus/dir.c:552
       vfs_rename+0xbdb/0xf00 fs/namei.c:4887
       do_renameat2+0xd94/0x13f0 fs/namei.c:5044
       __do_sys_rename fs/namei.c:5091 [inline]
       __se_sys_rename fs/namei.c:5089 [inline]
       __x64_sys_rename+0x86/0xa0 fs/namei.c:5089
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&tree->tree_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hfsplus_file_truncate+0x811/0xb50 fs/hfsplus/extents.c:595
       hfsplus_setattr+0x1ce/0x280 fs/hfsplus/inode.c:265
       notify_change+0xb9d/0xe70 fs/attr.c:497
       do_truncate+0x220/0x310 fs/open.c:65
       handle_truncate fs/namei.c:3308 [inline]
       do_open fs/namei.c:3654 [inline]
       path_openat+0x2a3d/0x3280 fs/namei.c:3807
       do_filp_open+0x235/0x490 fs/namei.c:3834
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_creat fs/open.c:1497 [inline]
       __se_sys_creat fs/open.c:1491 [inline]
       __x64_sys_creat+0x123/0x170 fs/open.c:1491
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&HFSPLUS_I(inode)->extents_lock);
                               lock(&tree->tree_lock);
                               lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&tree->tree_lock);

This is a false alarm as tree_lock mutex are different, one is
from sbi->cat_tree, and another is from sbi->ext_tree:

Thread A			Thread B
- hfsplus_rename
 - hfsplus_rename_cat
  - hfs_find_init
   - mutext_lock(cat_tree->tree_lock)
				- hfsplus_setattr
				 - hfsplus_file_truncate
				  - mutex_lock(hip->extents_lock)
				  - hfs_find_init
				   - mutext_lock(ext_tree->tree_lock)
  - hfs_bmap_reserve
   - hfsplus_file_extend
    - mutex_lock(hip->extents_lock)

So, let's call mutex_lock_nested for tree_lock mutex lock, and pass
correct lock class for it.

Fixes: 31651c607151 ("hfsplus: avoid deadlock on file truncation")
Reported-by: syzbot+6030b3b1b9bf70e538c4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-fsdevel/000000000000e37a4005ef129563@google.com
Cc: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/hfsplus/bfind.c      | 15 ++-------------
 fs/hfsplus/extents.c    |  9 ++++++---
 fs/hfsplus/hfsplus_fs.h | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..901e83d65d20 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -25,19 +25,8 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->key = ptr + tree->max_key_len + 2;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
-	switch (tree->cnid) {
-	case HFSPLUS_CAT_CNID:
-		mutex_lock_nested(&tree->tree_lock, CATALOG_BTREE_MUTEX);
-		break;
-	case HFSPLUS_EXT_CNID:
-		mutex_lock_nested(&tree->tree_lock, EXTENTS_BTREE_MUTEX);
-		break;
-	case HFSPLUS_ATTR_CNID:
-		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
-		break;
-	default:
-		BUG();
-	}
+	mutex_lock_nested(&tree->tree_lock,
+			hfsplus_btree_lock_class(tree));
 	return 0;
 }
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 3c572e44f2ad..9c51867dddc5 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -430,7 +430,8 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		hfsplus_free_extents(sb, ext_entry, total_blocks - start,
 				     total_blocks);
 		total_blocks = start;
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+			hfsplus_btree_lock_class(fd.tree));
 	} while (total_blocks > blocks);
 	hfs_find_exit(&fd);
 
@@ -592,7 +593,8 @@ void hfsplus_file_truncate(struct inode *inode)
 					     alloc_cnt, alloc_cnt - blk_cnt);
 			hfsplus_dump_extent(hip->first_extents);
 			hip->first_blocks = blk_cnt;
-			mutex_lock(&fd.tree->tree_lock);
+			mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 			break;
 		}
 		res = __hfsplus_ext_cache_extent(&fd, inode, alloc_cnt);
@@ -606,7 +608,8 @@ void hfsplus_file_truncate(struct inode *inode)
 		hfsplus_free_extents(sb, hip->cached_extents,
 				     alloc_cnt - start, alloc_cnt - blk_cnt);
 		hfsplus_dump_extent(hip->cached_extents);
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 		if (blk_cnt > start) {
 			hip->extent_state |= HFSPLUS_EXT_DIRTY;
 			break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 012a3d003fbe..9e78f181c24f 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -553,6 +553,27 @@ static inline __be32 __hfsp_ut2mt(time64_t ut)
 	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
 }
 
+static inline enum hfsplus_btree_mutex_classes
+hfsplus_btree_lock_class(struct hfs_btree *tree)
+{
+	enum hfsplus_btree_mutex_classes class;
+
+	switch (tree->cnid) {
+	case HFSPLUS_CAT_CNID:
+		class = CATALOG_BTREE_MUTEX;
+		break;
+	case HFSPLUS_EXT_CNID:
+		class = EXTENTS_BTREE_MUTEX;
+		break;
+	case HFSPLUS_ATTR_CNID:
+		class = ATTR_BTREE_MUTEX;
+		break;
+	default:
+		BUG();
+	}
+	return class;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
-- 
2.40.1


