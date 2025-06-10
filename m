Return-Path: <linux-fsdevel+bounces-51209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BA4AD468C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 01:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9EB3189D2C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F16826E718;
	Tue, 10 Jun 2025 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="aZQy6jDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042C2D5414
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597392; cv=none; b=sDRKl05vYQcXMRovbzgUCb37RccimJfjRjIZfuMveLb+a+Y1fWv7yxzwq9wXcC38zF9oFJMW27QkXlQQfl+tKACtI6kFysSbNP2lRLScFljWmyLbG4IqKLg6Hyhinr0f35zim5SUtFLJZZzXd1YP5XjmcoCk1yhYUTc2z9lVr3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597392; c=relaxed/simple;
	bh=uOU7KxGNLQT/FiRfU4IQjiEbytmp1ddCwE58hE09E2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uG/Ui31dgbrQyLQW3fVkwAV5Wxfn1wTDv5j5tcJRMa3EoAlEXk9C0nMniM/gaFbT4KzZbfz/KjO1oNcuKhVjrgECYjwAA2iJyDb40AIGHfVTSET0+JfvmSPmWZHuDYRRF405Cg06Sox+urhqlVpNL+GqfnX9V3MjnXCwl1yb0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=aZQy6jDL; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-73502b47f24so3772084a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749597389; x=1750202189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta6ftOnI6cHrgVvfJMJmrJH1r36Wq8vbaSS4r0GOCa0=;
        b=aZQy6jDLP24oN0D9K9TOqlCCPS/8aiRWt77nCY/zCKEHzH4Gj3bkHON6TTrFh1p0a0
         XMbU0wHdewpK4zdcULFht7qrlLmJhs5t4e+HvNBFjF/DSXzw7JMMO4JUSRxMbcyQGRrN
         WDpN0NdYjtuM2iNrv3uiZll5IKeQtgXde/lkIll8Y3fYkFbaJjjwb6Ch66TSG5pS0Uay
         4DJmOPOSEX6mhyVkXv/pCALyMBEXJ9d/ei4y6zKogAd2P2Za2rDwKFJCweD+yOYsxFOE
         gLz5wkQqcx+t/1SZtYcxSEUV471LwkOtz6EGJ1yQcy3GwYhWcpGhIHylZcC0LzLh2Hai
         0tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749597389; x=1750202189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ta6ftOnI6cHrgVvfJMJmrJH1r36Wq8vbaSS4r0GOCa0=;
        b=UeYtv9ZpYndnCxb9elNgtnS3OWbYS53k4wi1BTdDiAABfrk5t/STe2yWPBA/BHmsCb
         hkDhuh6igeqa9xCNwuma2bG7MzeRl3EQJjwafdmJVjiFqD55dmlKlLtYnvdalr29o6hf
         nC8PgkmPdHmSrPFpbKBrepb3B4dSzD8br2RQfLUGCAXtXQnmaookFOYrNoFjdZnIdlS4
         P1M1EedmfS1bXZbUmynk0vLqdBDy66EVzIllojawGSmz3YhoKEh1saPLwhQ4JVRVtGsa
         z7b1VXNYVJNsaWvN+9vwaTBcHvJ/9KWipVPNrijrlKNVticpx5bostyNw5ztw6KCv6fu
         cTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUItZnS6AexjCgCEZYUrwAlio9+7kfWQ7te4ZL2xkQrUu9H7lJsBFVHSCBDE/1/vgzRqdJiloNnl4tav48@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTEiP5OkXSAlmc1I4Yjd8K7Lz5ajnQz2YEGHw2Njt4sAydxwo
	eC8h/rVaGq4bmL+/DWwoCNfXV9UBenLLgATakw39KNd1vAZa90ZioD8ptmoz0I0IVwA=
X-Gm-Gg: ASbGnct6975zFKWzxE4gFzGH8NU6HR/VRp5CN6cjnmWrL9k5Xb0VnMbLTAGqbd2BA2t
	wqS+0YJ/SKsJdJCNDk5lswksazMUKPug0DfyybDSTZEku5Lk2/xYxtFE4pRnI9GtlqV5xwlZ4dy
	T9D5j6tWr+qlkHiFu5biuYpEd32UymlmDd6A42K9rs2ch0Zpp1G0REl99woEy/zsCBGCJ6AJXCs
	4o3knXINvmw6fSHxAU8bY6DanGYlc7wviU7dumXrSfBYSdiRFl8kgvjzlXj9Givg76bO+Dz769O
	eTdw20SuCeZnXK6Oqz8Pn9K5UOsssPJ5BCICROHKjnrwPOgY0bjeo8BqMe50l5EeRPuoLGck2Q=
	=
X-Google-Smtp-Source: AGHT+IGQcKXR3NbE6P1PpHMHPMga+8/urTDF9JVNJhzwpEmCqC5JRd2v9QHL26PVeS3OpJo4vhuV8w==
X-Received: by 2002:a9d:605a:0:b0:72c:320c:d898 with SMTP id 46e09a7af769-73a05d0dbb6mr934213a34.22.1749597389170;
        Tue, 10 Jun 2025 16:16:29 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f52d:c775:68cb:d422])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a0729c543sm108463a34.69.2025.06.10.16.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 16:16:28 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: add logic of correcting a next unused CNID
Date: Tue, 10 Jun 2025 16:16:09 -0700
Message-Id: <20250610231609.551930-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic/736 xfstest fails for HFS case:

BEGIN TEST default (1 test): hfs Mon May 5 03:18:32 UTC 2025
DEVICE: /dev/vdb
HFS_MKFS_OPTIONS:
MOUNT_OPTIONS: MOUNT_OPTIONS
FSTYP -- hfs
PLATFORM -- Linux/x86_64 kvm-xfstests 6.15.0-rc4-xfstests-g00b827f0cffa #1 SMP PREEMPT_DYNAMIC Fri May 25
MKFS_OPTIONS -- /dev/vdc
MOUNT_OPTIONS -- /dev/vdc /vdc

generic/736 [03:18:33][ 3.510255] run fstests generic/736 at 2025-05-05 03:18:33
_check_generic_filesystem: filesystem on /dev/vdb is inconsistent
(see /results/hfs/results-default/generic/736.full for details)
Ran: generic/736
Failures: generic/736
Failed 1 of 1 tests

The HFS volume becomes corrupted after the test run:

sudo fsck.hfs -d /dev/loop50
** /dev/loop50
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
invalid MDB drNxtCNID
Master Directory Block needs minor repair
(1, 0)
Verify Status: VIStat = 0x8000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking HFS volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The main reason of the issue is the absence of logic that
corrects mdb->drNxtCNID/HFS_SB(sb)->next_id (next unused
CNID) after deleting a record in Catalog File. This patch
introduces a hfs_correct_next_unused_CNID() method that
implements the necessary logic. In the case of Catalog File's
record delete operation, the function logic checks that
(deleted_CNID + 1) == next_unused_CNID and it finds/sets the new
value of next_unused_CNID.

sudo ./check generic/736
FSTYP -- hfs
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0+ #6 SMP PREEMPT_DYNAMIC Tue Jun 10 15:02:48 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/736 33s
Ran: generic/736
Passed all 1 tests

sudo fsck.hfs -d /dev/loop50
** /dev/loop50
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking HFS volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled appears to be OK

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/catalog.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfs/hfs_fs.h  |   6 +--
 fs/hfs/inode.c   |  21 ++++++--
 fs/hfs/mdb.c     |  18 ++++---
 fs/hfs/super.c   |   4 ++
 5 files changed, 158 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index d63880e7d9d6..b6b18ee68135 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -211,6 +211,124 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
 	return hfs_brec_find(fd);
 }
 
+static inline
+void hfs_set_next_unused_CNID(struct super_block *sb,
+				u32 deleted_cnid, u32 found_cnid)
+{
+	if (found_cnid < HFS_FIRSTUSER_CNID) {
+		atomic64_cmpxchg(&HFS_SB(sb)->next_id,
+				 deleted_cnid + 1, HFS_FIRSTUSER_CNID);
+	} else {
+		atomic64_cmpxchg(&HFS_SB(sb)->next_id,
+				 deleted_cnid + 1, found_cnid + 1);
+	}
+}
+
+/*
+ * hfs_correct_next_unused_CNID()
+ *
+ * Correct the next unused CNID of Catalog Tree.
+ */
+static
+int hfs_correct_next_unused_CNID(struct super_block *sb, u32 cnid)
+{
+	struct hfs_btree *cat_tree;
+	struct hfs_bnode *node;
+	s64 leaf_head;
+	s64 leaf_tail;
+	s64 node_id;
+
+	hfs_dbg(CAT_MOD, "correct next unused CNID: cnid %u, next_id %lld\n",
+		cnid, atomic64_read(&HFS_SB(sb)->next_id));
+
+	if ((cnid + 1) < atomic64_read(&HFS_SB(sb)->next_id)) {
+		/* next ID should be unchanged */
+		return 0;
+	}
+
+	cat_tree = HFS_SB(sb)->cat_tree;
+	leaf_head = cat_tree->leaf_head;
+	leaf_tail = cat_tree->leaf_tail;
+
+	if (leaf_head > leaf_tail) {
+		pr_err("node is corrupted: leaf_head %lld, leaf_tail %lld\n",
+			leaf_head, leaf_tail);
+		return -ERANGE;
+	}
+
+	node = hfs_bnode_find(cat_tree, leaf_tail);
+	if (IS_ERR(node)) {
+		pr_err("fail to find leaf node: node ID %lld\n",
+			leaf_tail);
+		return -ENOENT;
+	}
+
+	node_id = leaf_tail;
+
+	do {
+		int i;
+
+		if (node_id != leaf_tail) {
+			node = hfs_bnode_find(cat_tree, node_id);
+			if (IS_ERR(node))
+				return -ENOENT;
+		}
+
+		hfs_dbg(CAT_MOD, "node_id %lld, leaf_tail %lld, leaf_head %lld\n",
+			node_id, leaf_tail, leaf_head);
+
+		hfs_bnode_dump(node);
+
+		for (i = node->num_recs - 1; i >= 0; i--) {
+			hfs_cat_rec rec;
+			u16 off, len, keylen;
+			int entryoffset;
+			int entrylength;
+			u32 found_cnid;
+
+			len = hfs_brec_lenoff(node, i, &off);
+			keylen = hfs_brec_keylen(node, i);
+			if (keylen == 0) {
+				pr_err("fail to get the keylen: "
+					"node_id %lld, record index %d\n",
+					node_id, i);
+				return -EINVAL;
+			}
+
+			entryoffset = off + keylen;
+			entrylength = len - keylen;
+
+			if (entrylength > sizeof(rec)) {
+				pr_err("unexpected record length: "
+					"entrylength %d\n",
+					entrylength);
+				return -EINVAL;
+			}
+
+			hfs_bnode_read(node, &rec, entryoffset, entrylength);
+
+			if (rec.type == HFS_CDR_DIR) {
+				found_cnid = be32_to_cpu(rec.dir.DirID);
+				hfs_dbg(CAT_MOD, "found_cnid %u\n", found_cnid);
+				hfs_set_next_unused_CNID(sb, cnid, found_cnid);
+				hfs_bnode_put(node);
+				return 0;
+			} else if (rec.type == HFS_CDR_FIL) {
+				found_cnid = be32_to_cpu(rec.file.FlNum);
+				hfs_dbg(CAT_MOD, "found_cnid %u\n", found_cnid);
+				hfs_set_next_unused_CNID(sb, cnid, found_cnid);
+				hfs_bnode_put(node);
+				return 0;
+			}
+		}
+
+		hfs_bnode_put(node);
+
+		node_id = node->prev;
+	} while (node_id >= leaf_head);
+
+	return -ENOENT;
+}
 
 /*
  * hfs_cat_delete()
@@ -271,6 +389,11 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 	dir->i_size--;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
+
+	res = hfs_correct_next_unused_CNID(sb, cnid);
+	if (res)
+		goto out;
+
 	res = 0;
 out:
 	hfs_find_exit(&fd);
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index a0c7cb0f79fc..0bb53461252b 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -112,13 +112,13 @@ struct hfs_sb_info {
 						   the extents b-tree */
 	struct hfs_btree *cat_tree;			/* Information about
 						   the catalog b-tree */
-	u32 file_count;				/* The number of
+	atomic64_t file_count;			/* The number of
 						   regular files in
 						   the filesystem */
-	u32 folder_count;			/* The number of
+	atomic64_t folder_count;		/* The number of
 						   directories in the
 						   filesystem */
-	u32 next_id;				/* The next available
+	atomic64_t next_id;			/* The next available
 						   file id number */
 	u32 clumpablks;				/* The number of allocation
 						   blocks to try to add when
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index a81ce7a740b9..9c92802b73c2 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -183,6 +183,10 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = new_inode(sb);
+	s64 next_id;
+	s64 file_count;
+	s64 folder_count;
+
 	if (!inode)
 		return NULL;
 
@@ -190,7 +194,9 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
-	inode->i_ino = HFS_SB(sb)->next_id++;
+	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
+	BUG_ON(next_id > U32_MAX);
+	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
@@ -202,7 +208,8 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
-		HFS_SB(sb)->folder_count++;
+		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
+		BUG_ON(folder_count > U32_MAX);
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -211,7 +218,8 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 		inode->i_mode &= ~HFS_SB(inode->i_sb)->s_dir_umask;
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
-		HFS_SB(sb)->file_count++;
+		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
+		BUG_ON(file_count > U32_MAX);
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -243,14 +251,17 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg(INODE, "delete_inode: %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		HFS_SB(sb)->folder_count--;
+		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
+		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
 		set_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags);
 		hfs_mark_mdb_dirty(sb);
 		return;
 	}
-	HFS_SB(sb)->file_count--;
+
+	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
+	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
 	if (S_ISREG(inode->i_mode)) {
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 8082eb01127c..55afd9154b04 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -150,11 +150,11 @@ int hfs_mdb_get(struct super_block *sb)
 
 	/* These parameters are read from and written to the MDB */
 	HFS_SB(sb)->free_ablocks = be16_to_cpu(mdb->drFreeBks);
-	HFS_SB(sb)->next_id = be32_to_cpu(mdb->drNxtCNID);
+	atomic64_set(&HFS_SB(sb)->next_id, be32_to_cpu(mdb->drNxtCNID));
 	HFS_SB(sb)->root_files = be16_to_cpu(mdb->drNmFls);
 	HFS_SB(sb)->root_dirs = be16_to_cpu(mdb->drNmRtDirs);
-	HFS_SB(sb)->file_count = be32_to_cpu(mdb->drFilCnt);
-	HFS_SB(sb)->folder_count = be32_to_cpu(mdb->drDirCnt);
+	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
+	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
 
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
@@ -273,11 +273,17 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		mdb->drNxtCNID = cpu_to_be32(HFS_SB(sb)->next_id);
+		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
+		mdb->drNxtCNID =
+			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		mdb->drFilCnt = cpu_to_be32(HFS_SB(sb)->file_count);
-		mdb->drDirCnt = cpu_to_be32(HFS_SB(sb)->folder_count);
+		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
+		mdb->drFilCnt =
+			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
+		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
+		mdb->drDirCnt =
+			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
 		/* write MDB to disk */
 		mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index fe09c2093a93..6f11c5a3b897 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -319,6 +319,10 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	int res;
 
+	atomic64_set(&sbi->file_count, 0);
+	atomic64_set(&sbi->folder_count, 0);
+	atomic64_set(&sbi->next_id, 0);
+
 	/* load_nls_default does not fail */
 	if (sbi->nls_disk && !sbi->nls_io)
 		sbi->nls_io = load_nls_default();
-- 
2.43.0


