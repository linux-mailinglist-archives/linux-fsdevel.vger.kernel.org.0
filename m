Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C322234C08A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 02:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC2A2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 20:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC2A2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:28:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C0C061756;
        Sun, 28 Mar 2021 17:28:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d8so3578346plh.11;
        Sun, 28 Mar 2021 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgKxVXjRMDn6U9oyufU2icNCyhzGBqun91GJhg+iwTU=;
        b=BouNrqDwbL1WVpmQrpCdLG1/f3IyC7MjgEJbIjO6XQGKLoWf3D3E2zMJnR+5JUJ3zV
         sUFl0N/0VNw73iO73RDSwx5MtSdvLFaP8hvdlLg6ZuDRNyiVWS8wKzE7EAn5wRaufZxM
         aPtCp1xPKbmMSufE1yBcqAkS+kfUFk4dYlPWSMRYq7xcihNihIyBZPTFBCCFHq+q68BL
         WeQj+Q8WKRT6cH8eaP0HvCqKq2Ph8hEmzp0ieETo/7iU/S5Qx1DeAoiYu2/yCFrrSk5n
         z4i7n4F75kyBGgKbwb90F15EjLFXrahciAD5ob732hHL6sw1yGX7XRCWSt+ptfVuZieM
         0otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgKxVXjRMDn6U9oyufU2icNCyhzGBqun91GJhg+iwTU=;
        b=t9cjFG4N1Bw+7EA9aYdc9436E2siK6We7v90+4tQ86hajRkmBRAZ595qFZAzPW4B+8
         wTiQdC1lZAzJgGctJ+MgjtambVjrkfy1KDWTzAUvMdGSIHP+q8d5jFUTTr+b6GmxB7Pz
         /5L5Byxwp9+g4dikxGpb7cVVoEOFIhko/h8gq5LIYsDZHySos1Q2Fgf7gaPuYGJi1HLO
         wVyL7epwMxNYnRB3JMWj/VwdUC9pn/+Lc7VK0wZe6fK8aeFeNIodoDEJdORnH++3V+XV
         Ir9M+e+HEMB0iKrz2S8+ctZjPpD3n5rRJ8fHfvfdyzJoTDkoZHMfe27eseSkjTUhVSke
         eNXQ==
X-Gm-Message-State: AOAM531REBiIEuj14auiYDg63+qwysDBJOtYDz+riJK5ChUesDZ4HjoK
        /QyRKhQWWUnSwjFqITzmKaQ=
X-Google-Smtp-Source: ABdhPJwsEpImnob0BEnIx2/GespaklkSMHuSMdbBwPVhLKJbskYCsJCi+OE4aB8NY9wtk1FwflWf0Q==
X-Received: by 2002:a17:902:8497:b029:e6:f01d:9c9f with SMTP id c23-20020a1709028497b02900e6f01d9c9fmr26176034plo.7.1616977709920;
        Sun, 28 Mar 2021 17:28:29 -0700 (PDT)
Received: from localhost.localdomain ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id g28sm15387436pfr.120.2021.03.28.17.28.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Mar 2021 17:28:29 -0700 (PDT)
From:   Hyeongseok Kim <hyeongseok@gmail.com>
To:     namjae.jeon@samsung.com, sj1557.seo@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hyeongseok Kim <hyeongseok@gmail.com>
Subject: [PATCH] exfat: change i_pos based exfat hash to rb tree
Date:   Mon, 29 Mar 2021 09:28:18 +0900
Message-Id: <20210329002818.73178-1-hyeongseok@gmail.com>
X-Mailer: git-send-email 2.27.0.83.g0313f36
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hashtable for identifying inode by i_pos (cluster+dentry) have slow
search performance when there are lots of cached inode. The slowness
is from the limited count of slots showing that, in average,
(inode count / slots) times hlist traverse, and it becomes worse when
cached inode count increases by such as directory iteration.
To improve this, change from hash table to rb tree to minimize
searching/iterate time which enables O(logN) time complexity.

Test : "time ls -l"
 +--------+------------+------------+-----------+
 |        | file count | fresh read |   cached  |
 +--------+------------+------------+-----------+
 | Before |     50,000 |   0m06.59s |  0m01.58s |
 +--------+------------+------------+-----------+
 | After  |     50,000 |   0m05.20s |  0m00.98s |
 +--------+------------+------------+-----------+
 | Before |    300,000 |   1m28.97s |  0m31.69s |
 +--------+------------+------------+-----------+
 | After  |    300,000 |   0m33.11s |  0m06.21s |
 +--------+------------+------------+-----------+

Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
---
 fs/exfat/exfat_fs.h | 12 +++---
 fs/exfat/inode.c    | 91 +++++++++++++++++++++++++++++++--------------
 fs/exfat/namei.c    | 10 ++---
 fs/exfat/super.c    | 16 ++++----
 4 files changed, 82 insertions(+), 47 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1d6da61157c9..f8ad8cbf8499 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -243,8 +243,8 @@ struct exfat_sb_info {
 	struct nls_table *nls_io; /* Charset used for input and display */
 	struct ratelimit_state ratelimit;
 
-	spinlock_t inode_hash_lock;
-	struct hlist_head inode_hashtable[EXFAT_HASH_SIZE];
+	spinlock_t inode_tree_lock; /* lock for inode_tree structure */
+	struct rb_root inode_tree;
 
 	struct rcu_head rcu;
 };
@@ -289,8 +289,8 @@ struct exfat_inode_info {
 	loff_t i_size_aligned;
 	/* on-disk position of directory entry or 0 */
 	loff_t i_pos;
-	/* hash by i_location */
-	struct hlist_node i_hash_fat;
+	/* tree by i_location */
+	struct rb_node rbnode;
 	/* protect bmap against truncate */
 	struct rw_semaphore truncate_lock;
 	struct inode vfs_inode;
@@ -476,8 +476,8 @@ extern const struct inode_operations exfat_file_inode_operations;
 void exfat_sync_inode(struct inode *inode);
 struct inode *exfat_build_inode(struct super_block *sb,
 		struct exfat_dir_entry *info, loff_t i_pos);
-void exfat_hash_inode(struct inode *inode, loff_t i_pos);
-void exfat_unhash_inode(struct inode *inode);
+void exfat_inode_tree_insert(struct inode *inode, loff_t i_pos);
+void exfat_inode_tree_erase(struct inode *inode);
 struct inode *exfat_iget(struct super_block *sb, loff_t i_pos);
 int exfat_write_inode(struct inode *inode, struct writeback_control *wbc);
 void exfat_evict_inode(struct inode *inode);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 1803ef3220fd..740a34f528ae 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -501,50 +501,87 @@ static const struct address_space_operations exfat_aops = {
 	.bmap		= exfat_aop_bmap
 };
 
-static inline unsigned long exfat_hash(loff_t i_pos)
+static struct exfat_inode_info *exfat_inode_tree_find(struct super_block *sb,
+						      loff_t i_pos)
 {
-	return hash_32(i_pos, EXFAT_HASH_BITS);
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct rb_node *node = sbi->inode_tree.rb_node;
+	struct exfat_inode_info *info;
+
+	spin_lock(&sbi->inode_tree_lock);
+	while (node) {
+		info = rb_entry(node, struct exfat_inode_info, rbnode);
+		WARN_ON(info->vfs_inode.i_sb != sb);
+
+		if (i_pos == info->i_pos) {
+			spin_unlock(&sbi->inode_tree_lock);
+			return info;
+		}
+
+		if (i_pos < info->i_pos)
+			node = node->rb_left;
+		else /* i_pos > info->i_pos */
+			node = node->rb_right;
+	}
+	spin_unlock(&sbi->inode_tree_lock);
+	return NULL;
 }
 
-void exfat_hash_inode(struct inode *inode, loff_t i_pos)
+void exfat_inode_tree_insert(struct inode *inode, loff_t i_pos)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
-	struct hlist_head *head = sbi->inode_hashtable + exfat_hash(i_pos);
+	struct exfat_inode_info *info, *ei = EXFAT_I(inode);
+	struct rb_root *root = &sbi->inode_tree;
+	struct rb_node **rb_ptr = &root->rb_node;
+	struct rb_node *parent = NULL;
+
+	spin_lock(&sbi->inode_tree_lock);
+	ei->i_pos = i_pos;
+	while (*rb_ptr) {
+		parent = *rb_ptr;
+		info = rb_entry(*rb_ptr, struct exfat_inode_info, rbnode);
+		if (i_pos == info->i_pos) {
+			/* already exists */
+			rb_replace_node(*rb_ptr, &ei->rbnode, &sbi->inode_tree);
+			RB_CLEAR_NODE(*rb_ptr);
+			spin_unlock(&sbi->inode_tree_lock);
+			return;
+		}
 
-	spin_lock(&sbi->inode_hash_lock);
-	EXFAT_I(inode)->i_pos = i_pos;
-	hlist_add_head(&EXFAT_I(inode)->i_hash_fat, head);
-	spin_unlock(&sbi->inode_hash_lock);
+		if (i_pos < info->i_pos)
+			rb_ptr = &(*rb_ptr)->rb_left;
+		else /* (i_pos > info->i_pos) */
+			rb_ptr = &(*rb_ptr)->rb_right;
+	}
+
+	rb_link_node(&ei->rbnode, parent, rb_ptr);
+	rb_insert_color(&ei->rbnode, root);
+	spin_unlock(&sbi->inode_tree_lock);
 }
 
-void exfat_unhash_inode(struct inode *inode)
+void exfat_inode_tree_erase(struct inode *inode)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(inode->i_sb);
+	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct rb_root *root = &sbi->inode_tree;
 
-	spin_lock(&sbi->inode_hash_lock);
-	hlist_del_init(&EXFAT_I(inode)->i_hash_fat);
-	EXFAT_I(inode)->i_pos = 0;
-	spin_unlock(&sbi->inode_hash_lock);
+	spin_lock(&sbi->inode_tree_lock);
+	if (!RB_EMPTY_NODE(&ei->rbnode)) {
+		rb_erase(&ei->rbnode, root);
+		RB_CLEAR_NODE(&ei->rbnode);
+	}
+	spin_unlock(&sbi->inode_tree_lock);
 }
 
 struct inode *exfat_iget(struct super_block *sb, loff_t i_pos)
 {
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *info;
-	struct hlist_head *head = sbi->inode_hashtable + exfat_hash(i_pos);
 	struct inode *inode = NULL;
 
-	spin_lock(&sbi->inode_hash_lock);
-	hlist_for_each_entry(info, head, i_hash_fat) {
-		WARN_ON(info->vfs_inode.i_sb != sb);
-
-		if (i_pos != info->i_pos)
-			continue;
+	info = exfat_inode_tree_find(sb, i_pos);
+	if (info)
 		inode = igrab(&info->vfs_inode);
-		if (inode)
-			break;
-	}
-	spin_unlock(&sbi->inode_hash_lock);
+
 	return inode;
 }
 
@@ -634,7 +671,7 @@ struct inode *exfat_build_inode(struct super_block *sb,
 		inode = ERR_PTR(err);
 		goto out;
 	}
-	exfat_hash_inode(inode, i_pos);
+	exfat_inode_tree_insert(inode, i_pos);
 	insert_inode_hash(inode);
 out:
 	return inode;
@@ -654,5 +691,5 @@ void exfat_evict_inode(struct inode *inode)
 	invalidate_inode_buffers(inode);
 	clear_inode(inode);
 	exfat_cache_inval_inode(inode);
-	exfat_unhash_inode(inode);
+	exfat_inode_tree_erase(inode);
 }
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 24b41103d1cc..10ed9b35fd86 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -827,7 +827,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = current_time(inode);
 	exfat_truncate_atime(&inode->i_atime);
-	exfat_unhash_inode(inode);
+	exfat_inode_tree_erase(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
 	mutex_unlock(&EXFAT_SB(sb)->s_lock);
@@ -993,7 +993,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	clear_nlink(inode);
 	inode->i_mtime = inode->i_atime = current_time(inode);
 	exfat_truncate_atime(&inode->i_atime);
-	exfat_unhash_inode(inode);
+	exfat_inode_tree_erase(inode);
 	exfat_d_version_set(dentry, inode_query_iversion(dir));
 unlock:
 	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
@@ -1363,8 +1363,8 @@ static int exfat_rename(struct user_namespace *mnt_userns,
 
 	i_pos = ((loff_t)EXFAT_I(old_inode)->dir.dir << 32) |
 		(EXFAT_I(old_inode)->entry & 0xffffffff);
-	exfat_unhash_inode(old_inode);
-	exfat_hash_inode(old_inode, i_pos);
+	exfat_inode_tree_erase(old_inode);
+	exfat_inode_tree_insert(old_inode, i_pos);
 	if (IS_DIRSYNC(new_dir))
 		exfat_sync_inode(old_inode);
 	else
@@ -1384,7 +1384,7 @@ static int exfat_rename(struct user_namespace *mnt_userns,
 		mark_inode_dirty(old_dir);
 
 	if (new_inode) {
-		exfat_unhash_inode(new_inode);
+		exfat_inode_tree_erase(new_inode);
 
 		/* skip drop_nlink if new_inode already has been dropped */
 		if (new_inode->i_nlink) {
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index d38d17a77e76..8f197432c57b 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -317,14 +317,12 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static void exfat_hash_init(struct super_block *sb)
+static void exfat_inode_tree_init(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	int i;
 
-	spin_lock_init(&sbi->inode_hash_lock);
-	for (i = 0; i < EXFAT_HASH_SIZE; i++)
-		INIT_HLIST_HEAD(&sbi->inode_hashtable[i]);
+	spin_lock_init(&sbi->inode_tree_lock);
+	sbi->inode_tree = RB_ROOT;
 }
 
 static int exfat_read_root(struct inode *inode)
@@ -648,8 +646,8 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto check_nls_io;
 	}
 
-	/* set up enough so that it can read an inode */
-	exfat_hash_init(sb);
+	/* set up exfat inode tree */
+	exfat_inode_tree_init(sb);
 
 	if (!strcmp(sbi->options.iocharset, "utf8"))
 		opts->utf8 = 1;
@@ -683,7 +681,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto put_inode;
 	}
 
-	exfat_hash_inode(root_inode, EXFAT_I(root_inode)->i_pos);
+	exfat_inode_tree_insert(root_inode, EXFAT_I(root_inode)->i_pos);
 	insert_inode_hash(root_inode);
 
 	sb->s_root = d_make_root(root_inode);
@@ -786,7 +784,7 @@ static void exfat_inode_init_once(void *foo)
 	ei->nr_caches = 0;
 	ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
 	INIT_LIST_HEAD(&ei->cache_lru);
-	INIT_HLIST_NODE(&ei->i_hash_fat);
+	RB_CLEAR_NODE(&ei->rbnode);
 	inode_init_once(&ei->vfs_inode);
 }
 
-- 
2.27.0.83.g0313f36

