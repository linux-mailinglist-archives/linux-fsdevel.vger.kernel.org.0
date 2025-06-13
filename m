Return-Path: <linux-fsdevel+bounces-51585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FBAD899C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 12:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6207A6E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E852C15B9;
	Fri, 13 Jun 2025 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="WYh8dlbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837062989BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811183; cv=none; b=m30Yg+wzuSsDq76baooW+Ylbf1Iuifw46btD3WbHzF7yOCegtmu3u6FYD+OE3SJFwF9oaKFjck4e3PjCyvp1XutZbprdVDODw1x4PNj44C1yh4htSGAM6A+nF8z+r4YbyonKYw52muK+QPYPdxy8v14hGgN198C3hL7TeqQDF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811183; c=relaxed/simple;
	bh=GdG45ltDZykJUQKnvKB+ZZW2TcGSo4XsURWL4yl9R44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsTN2OaV1x5kybXZYPGtnA8sHM976CVSoBF2tg9ydJsO/UnM0DYY+0wHOdEQIV5pqeuqQna246ogP3Ng4lJwUEmawVKAgO+Ebda0E+ywlcC2FfTW/dBwmk08f3OjdE4HIB0lT3ruGpL74u7h5uvpap4jA+N1PH/ygLg1KZgXjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=WYh8dlbT; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1749811180; x=1781347180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V45lmQGziXq1E8wWEd5i1/SVdFp7OOAVEhPnblWcVok=;
  b=WYh8dlbT66URZWKUW3z77CLV1saoJ6zj52+Z6DIjJ3YK0dzm5xPB/FHh
   4GJinSq67miYUsQJ78m3q++Kv9xSyk3qGPz8QKT2TodgB/Uh0ArpS05Lh
   fEVM26qYRKol3/zsP7auVlil2YazgaCmTKYwA76tItCFSTylNAi7O9zyq
   hdKvS1RRgjijwWhoo1zn0LHitqUjajZgSM7kn52G/JgG3gR7ODWe0niKs
   ah9lqq7GD7HYZT5cChu24VWvOYuaaJslD8uP+WSA2HnpxprtDQ1ARreOZ
   kNNU43v+0ECvL8XDxSagb1cB8i6jzHBuRmq77K8Lp5Fd+4La82eyM7/Sc
   A==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 19:39:33 +0900
X-IronPort-AV: E=Sophos;i="6.16,233,1744038000"; 
   d="scan'208";a="541540877"
Received: from unknown (HELO cscsh-7000014390.ap.sony.com) ([43.82.111.225])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 13 Jun 2025 19:39:33 +0900
From: Yuezhang Mo <Yuezhang.Mo@sony.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v1] exfat: add cluster chain loop check for dir
Date: Fri, 13 Jun 2025 18:38:03 +0800
Message-ID: <20250613103802.619272-2-Yuezhang.Mo@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An infinite loop may occur if the following conditions occur due to
file system corruption.

(1) Condition for exfat_count_dir_entries() to loop infinitely.
    - The cluster chain includes a loop.
    - There is no UNUSED entry in the cluster chain.

(2) Condition for exfat_create_upcase_table() to loop infinitely.
    - The cluster chain of the root directory includes a loop.
    - There are no UNUSED entry and up-case table entry in the cluster
      chain of the root directory.

(3) Condition for exfat_load_bitmap() to loop infinitely.
    - The cluster chain of the root directory includes a loop.
    - There are no UNUSED entry and bitmap entry in the cluster chain
      of the root directory.

This commit adds checks in exfat_count_num_clusters() and
exfat_count_dir_entries() to see if the cluster chain includes a loop,
thus avoiding the above infinite loops.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/dir.c    | 33 +++++++++++++++++++++------------
 fs/exfat/fatent.c | 10 ++++++++++
 fs/exfat/super.c  | 32 +++++++++++++++++++++-----------
 3 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 3103b932b674..467271ad4d71 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1194,7 +1194,8 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 {
 	int i, count = 0;
 	int dentries_per_clu;
-	unsigned int entry_type;
+	unsigned int entry_type = TYPE_FILE;
+	unsigned int clu_count = 0;
 	struct exfat_chain clu;
 	struct exfat_dentry *ep;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -1205,18 +1206,26 @@ int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain *p_dir)
 	exfat_chain_dup(&clu, p_dir);
 
 	while (clu.dir != EXFAT_EOF_CLUSTER) {
-		for (i = 0; i < dentries_per_clu; i++) {
-			ep = exfat_get_dentry(sb, &clu, i, &bh);
-			if (!ep)
-				return -EIO;
-			entry_type = exfat_get_entry_type(ep);
-			brelse(bh);
+		clu_count++;
+		if (clu_count > sbi->used_clusters) {
+			exfat_fs_error(sb, "dir size or FAT or bitmap is corrupted");
+			return -EIO;
+		}
 
-			if (entry_type == TYPE_UNUSED)
-				return count;
-			if (entry_type != TYPE_DIR)
-				continue;
-			count++;
+		if (entry_type != TYPE_UNUSED) {
+			for (i = 0; i < dentries_per_clu; i++) {
+				ep = exfat_get_dentry(sb, &clu, i, &bh);
+				if (!ep)
+					return -EIO;
+				entry_type = exfat_get_entry_type(ep);
+				brelse(bh);
+
+				if (entry_type == TYPE_UNUSED)
+					break;
+				if (entry_type != TYPE_DIR)
+					continue;
+				count++;
+			}
 		}
 
 		if (clu.flags == ALLOC_NO_FAT_CHAIN) {
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 23065f948ae7..2a2615ca320f 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -490,5 +490,15 @@ int exfat_count_num_clusters(struct super_block *sb,
 	}
 
 	*ret_count = count;
+
+	/*
+	 * since exfat_count_used_clusters() is not called, sbi->used_clusters
+	 * cannot be used here.
+	 */
+	if (i == sbi->num_clusters) {
+		exfat_fs_error(sb, "The cluster chain has a loop");
+		return -EIO;
+	}
+
 	return 0;
 }
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7ed858937d45..3a9ec75ab452 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -341,13 +341,12 @@ static void exfat_hash_init(struct super_block *sb)
 		INIT_HLIST_HEAD(&sbi->inode_hashtable[i]);
 }
 
-static int exfat_read_root(struct inode *inode)
+static int exfat_read_root(struct inode *inode, struct exfat_chain *root_clu)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	struct exfat_chain cdir;
-	int num_subdirs, num_clu = 0;
+	int num_subdirs;
 
 	exfat_chain_set(&ei->dir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
 	ei->entry = -1;
@@ -360,12 +359,9 @@ static int exfat_read_root(struct inode *inode)
 	ei->hint_stat.clu = sbi->root_dir;
 	ei->hint_femp.eidx = EXFAT_HINT_NONE;
 
-	exfat_chain_set(&cdir, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
-	if (exfat_count_num_clusters(sb, &cdir, &num_clu))
-		return -EIO;
-	i_size_write(inode, num_clu << sbi->cluster_size_bits);
+	i_size_write(inode, EXFAT_CLU_TO_B(root_clu->size, sbi));
 
-	num_subdirs = exfat_count_dir_entries(sb, &cdir);
+	num_subdirs = exfat_count_dir_entries(sb, root_clu);
 	if (num_subdirs < 0)
 		return -EIO;
 	set_nlink(inode, num_subdirs + EXFAT_MIN_SUBDIR);
@@ -578,7 +574,8 @@ static int exfat_verify_boot_region(struct super_block *sb)
 }
 
 /* mount the file system volume */
-static int __exfat_fill_super(struct super_block *sb)
+static int __exfat_fill_super(struct super_block *sb,
+		struct exfat_chain *root_clu)
 {
 	int ret;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
@@ -595,6 +592,18 @@ static int __exfat_fill_super(struct super_block *sb)
 		goto free_bh;
 	}
 
+	/*
+	 * Call exfat_count_num_cluster() before searching for up-case and
+	 * bitmap directory entries to avoid infinite loop if they are missing
+	 * and the cluster chain includes a loop.
+	 */
+	exfat_chain_set(root_clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
+	ret = exfat_count_num_clusters(sb, root_clu, &root_clu->size);
+	if (ret) {
+		exfat_err(sb, "failed to count the number of clusters in root");
+		goto free_bh;
+	}
+
 	ret = exfat_create_upcase_table(sb);
 	if (ret) {
 		exfat_err(sb, "failed to load upcase table");
@@ -627,6 +636,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct exfat_sb_info *sbi = sb->s_fs_info;
 	struct exfat_mount_options *opts = &sbi->options;
 	struct inode *root_inode;
+	struct exfat_chain root_clu;
 	int err;
 
 	if (opts->allow_utime == (unsigned short)-1)
@@ -645,7 +655,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
 	sb->s_time_max = EXFAT_MAX_TIMESTAMP_SECS;
 
-	err = __exfat_fill_super(sb);
+	err = __exfat_fill_super(sb, &root_clu);
 	if (err) {
 		exfat_err(sb, "failed to recognize exfat type");
 		goto check_nls_io;
@@ -680,7 +690,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	root_inode->i_ino = EXFAT_ROOT_INO;
 	inode_set_iversion(root_inode, 1);
-	err = exfat_read_root(root_inode);
+	err = exfat_read_root(root_inode, &root_clu);
 	if (err) {
 		exfat_err(sb, "failed to initialize root inode");
 		goto put_inode;
-- 
2.43.0


