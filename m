Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388BB29210F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 04:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgJSCGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 22:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbgJSCGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:06:18 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B386C061755;
        Sun, 18 Oct 2020 19:06:18 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y14so5063359pfp.13;
        Sun, 18 Oct 2020 19:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fulAg3HacMYpHqU3AUpU9bJOB3xzlkdFEZ4DjbRagsM=;
        b=MXw9NQNuf57v0INhYfkmdSR+jhA1FUXDj2a9o+E16/sBM0JI7D1Xz86P1cl1ONFsLX
         yQs6Yk2iHFvhOXUamPUv9NOF8/ZZtWi7H+o7ftSa0pLM9bILbMUXXkRAvr2zKzVnFKov
         FGuP/xbDagJrjbCqbzpQN8DsWK/CxAPwR0EAQUtz9nbtie/OkyVMmN9hNQAPVSZz651T
         9xgw6vfplPhq6IQh/4Rc6CCJmq8kdZP7QEUEp4S3Wsf3xnteP1JENT4znRN2KZlXgEWP
         RUvEOS2sXsVNJJcWwuOvPmfLR3VbH3u5ZrnDIpn54gYTmrPn6S6L9IDo9Z1b2fnT6egY
         mBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fulAg3HacMYpHqU3AUpU9bJOB3xzlkdFEZ4DjbRagsM=;
        b=tM8NqnS9ykns3d0B255YByo9uZEwrsuIhp57lEQSh3X5MB4VaxKhFooaILmpV+S/cs
         vmgHOgYa4z4GHRQLQpXc6qx9e05bKi7RueSNVABCjBsf06DN9G+ShIp0wOIFo7LwnQS8
         lFRyMvZwxiz0Df/DkXEM9wyybmngUw6AhxLFsdOC+TyjID2i7FomHCRyxJiLZ0pIP0rp
         6hIqZgNKCQ5fKx7NTYeoCfrTsqR91oJl73pXTPOZZnJk79Y84onPygZYZ9Ud9s/XySqi
         Gn8LnQ1bIvs+Q5j6sM91GTSlBTPTzfAhi4Q1HVDX9IidQqeC5LKTX03hLXWJ0ZcklXro
         pHQw==
X-Gm-Message-State: AOAM533lwRlhzEOcLPk4kFgXr8IvlgY9S0MssjhPpjDjaOZmM4P2/xCO
        oJlGe1lo/iB45LgNUPp5I8A=
X-Google-Smtp-Source: ABdhPJxhyxV8AyO1y9aGEOqSZluX0ozH7x1kyvD+8tw1iim0qUeDL5V8mVahRMeTJdHeOWWcRqiVSQ==
X-Received: by 2002:aa7:82ce:0:b029:142:2501:35cb with SMTP id f14-20020aa782ce0000b0290142250135cbmr14788946pfn.43.1603073178025;
        Sun, 18 Oct 2020 19:06:18 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-190-108.hyg.mesh.ad.jp. [111.169.190.108])
        by smtp.gmail.com with ESMTPSA id a15sm10018959pgi.69.2020.10.18.19.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 19:06:17 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        kernel test robot <lkp@intel.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] exfat: aggregate dir-entry updates into __exfat_write_inode().
Date:   Mon, 19 Oct 2020 11:06:13 +0900
Message-Id: <20201019020614.28688-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following function writes the updated inode information as dir-entry
by themselves.
 - __exfat_truncate()
 - exfat_map_cluster()
 - exfat_find_empty_entry()
Aggregate these writes into __exfat_write_inode().

In exfat_map_cluster(), the value obtained from i_size_read() is set to
stream.valid_size and stream.size.
However, in the context of get_block(), inode->i_size has not been set yet,
so the same value as current will be set, which is a meaningless update.
Furthermore, if it is called with previous size=0, the newly allocated
cluster number will be set to stream.start_clu, and stream.valid_size/size
will be 0, which is illegal.
Update stream.valid_size/size and stream.start_clu when __exfat_write_inode
is called after i_size is set, to prevent meaningless/illegal updates.

Others:
 - Remove double inode-update in __exfat_truncate() and exfat_truncate().
 - In __exfat_write_inode(), rename 'on_disk_size' to 'filesize' and
   add adjustment when filesize is 0.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v4
 - Remove debug message
Changes in v3
 - Remove update_inode() in exfat_map_cluster()/exfat_truncate()
 - Update commit-message
Changes in v2
 - Fix endian issue

 fs/exfat/file.c  | 52 +++++-------------------------------------------
 fs/exfat/inode.c | 42 +++++++-------------------------------
 fs/exfat/namei.c | 26 +++++-------------------
 3 files changed, 17 insertions(+), 103 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index e510b95dbf77..211fb947747a 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -100,7 +100,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	int evict = (ei->dir.dir == DIR_DELETED) ? 1 : 0;
+	int ret;
 
 	/* check if the given file ID is opened */
 	if (ei->type != TYPE_FILE && ei->type != TYPE_DIR)
@@ -150,49 +150,10 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 		ei->attr |= ATTR_ARCHIVE;
 
 	/* update the directory entry */
-	if (!evict) {
-		struct timespec64 ts;
-		struct exfat_dentry *ep, *ep2;
-		struct exfat_entry_set_cache *es;
-		int err;
-
-		es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
-				ES_ALL_ENTRIES);
-		if (!es)
-			return -EIO;
-		ep = exfat_get_dentry_cached(es, 0);
-		ep2 = exfat_get_dentry_cached(es, 1);
-
-		ts = current_time(inode);
-		exfat_set_entry_time(sbi, &ts,
-				&ep->dentry.file.modify_tz,
-				&ep->dentry.file.modify_time,
-				&ep->dentry.file.modify_date,
-				&ep->dentry.file.modify_time_cs);
-		ep->dentry.file.attr = cpu_to_le16(ei->attr);
-
-		/* File size should be zero if there is no cluster allocated */
-		if (ei->start_clu == EXFAT_EOF_CLUSTER) {
-			ep2->dentry.stream.valid_size = 0;
-			ep2->dentry.stream.size = 0;
-		} else {
-			ep2->dentry.stream.valid_size = cpu_to_le64(new_size);
-			ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
-		}
-
-		if (new_size == 0) {
-			/* Any directory can not be truncated to zero */
-			WARN_ON(ei->type != TYPE_FILE);
-
-			ep2->dentry.stream.flags = ALLOC_FAT_CHAIN;
-			ep2->dentry.stream.start_clu = EXFAT_FREE_CLUSTER;
-		}
-
-		exfat_update_dir_chksum_with_entry_set(es);
-		err = exfat_free_dentry_set(es, inode_needs_sync(inode));
-		if (err)
-			return err;
-	}
+	inode->i_ctime = inode->i_mtime = current_time(inode);
+	ret = exfat_update_inode(inode);
+	if (ret)
+		return ret;
 
 	/* cut off from the FAT chain */
 	if (ei->flags == ALLOC_FAT_CHAIN && last_clu != EXFAT_FREE_CLUSTER &&
@@ -244,9 +205,6 @@ void exfat_truncate(struct inode *inode, loff_t size)
 	if (err)
 		goto write_size;
 
-	inode->i_ctime = inode->i_mtime = current_time(inode);
-	exfat_update_inode(inode);
-
 	inode->i_blocks = ((i_size_read(inode) + (sbi->cluster_size - 1)) &
 			~(sbi->cluster_size - 1)) >> inode->i_blkbits;
 write_size:
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 5a55303e1f65..3870f5a1d8cd 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -19,7 +19,7 @@
 
 static int __exfat_write_inode(struct inode *inode, int sync)
 {
-	unsigned long long on_disk_size;
+	unsigned long long filesize;
 	struct exfat_dentry *ep, *ep2;
 	struct exfat_entry_set_cache *es = NULL;
 	struct super_block *sb = inode->i_sb;
@@ -68,13 +68,14 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 			NULL);
 
 	/* File size should be zero if there is no cluster allocated */
-	on_disk_size = i_size_read(inode);
-
+	filesize = i_size_read(inode);
 	if (ei->start_clu == EXFAT_EOF_CLUSTER)
-		on_disk_size = 0;
+		filesize = 0;
 
-	ep2->dentry.stream.valid_size = cpu_to_le64(on_disk_size);
+	ep2->dentry.stream.valid_size = cpu_to_le64(filesize);
 	ep2->dentry.stream.size = ep2->dentry.stream.valid_size;
+	ep2->dentry.stream.flags = filesize ? ei->flags : ALLOC_FAT_CHAIN;
+	ep2->dentry.stream.start_clu = cpu_to_le32(filesize ? ei->start_clu : EXFAT_FREE_CLUSTER);
 
 	exfat_update_dir_chksum_with_entry_set(es);
 	return exfat_free_dentry_set(es, sync);
@@ -110,7 +111,7 @@ int exfat_update_inode(struct inode *inode)
 static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		unsigned int *clu, int create)
 {
-	int ret, modified = false;
+	int ret;
 	unsigned int last_clu;
 	struct exfat_chain new_clu;
 	struct super_block *sb = inode->i_sb;
@@ -201,7 +202,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			if (new_clu.flags == ALLOC_FAT_CHAIN)
 				ei->flags = ALLOC_FAT_CHAIN;
 			ei->start_clu = new_clu.dir;
-			modified = true;
 		} else {
 			if (new_clu.flags != ei->flags) {
 				/* no-fat-chain bit is disabled,
@@ -211,7 +211,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				exfat_chain_cont_cluster(sb, ei->start_clu,
 					num_clusters);
 				ei->flags = ALLOC_FAT_CHAIN;
-				modified = true;
 			}
 			if (new_clu.flags == ALLOC_FAT_CHAIN)
 				if (exfat_ent_set(sb, last_clu, new_clu.dir))
@@ -221,33 +220,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 		num_clusters += num_to_be_allocated;
 		*clu = new_clu.dir;
 
-		if (ei->dir.dir != DIR_DELETED && modified) {
-			struct exfat_dentry *ep;
-			struct exfat_entry_set_cache *es;
-			int err;
-
-			es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry,
-				ES_ALL_ENTRIES);
-			if (!es)
-				return -EIO;
-			/* get stream entry */
-			ep = exfat_get_dentry_cached(es, 1);
-
-			/* update directory entry */
-			ep->dentry.stream.flags = ei->flags;
-			ep->dentry.stream.start_clu =
-				cpu_to_le32(ei->start_clu);
-			ep->dentry.stream.valid_size =
-				cpu_to_le64(i_size_read(inode));
-			ep->dentry.stream.size =
-				ep->dentry.stream.valid_size;
-
-			exfat_update_dir_chksum_with_entry_set(es);
-			err = exfat_free_dentry_set(es, inode_needs_sync(inode));
-			if (err)
-				return err;
-		} /* end of if != DIR_DELETED */
-
 		inode->i_blocks +=
 			num_to_be_allocated << sbi->sect_per_clus_bits;
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 1f5f72eb5baf..d57ad68e301e 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -306,10 +306,8 @@ static int exfat_find_empty_entry(struct inode *inode,
 {
 	int dentry;
 	unsigned int ret, last_clu;
-	sector_t sector;
 	loff_t size = 0;
 	struct exfat_chain clu;
-	struct exfat_dentry *ep = NULL;
 	struct super_block *sb = inode->i_sb;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
@@ -374,31 +372,17 @@ static int exfat_find_empty_entry(struct inode *inode,
 		p_dir->size++;
 		size = EXFAT_CLU_TO_B(p_dir->size, sbi);
 
-		/* update the directory entry */
-		if (p_dir->dir != sbi->root_dir) {
-			struct buffer_head *bh;
-
-			ep = exfat_get_dentry(sb,
-				&(ei->dir), ei->entry + 1, &bh, &sector);
-			if (!ep)
-				return -EIO;
-
-			ep->dentry.stream.valid_size = cpu_to_le64(size);
-			ep->dentry.stream.size = ep->dentry.stream.valid_size;
-			ep->dentry.stream.flags = p_dir->flags;
-			exfat_update_bh(bh, IS_DIRSYNC(inode));
-			brelse(bh);
-			if (exfat_update_dir_chksum(inode, &(ei->dir),
-			    ei->entry))
-				return -EIO;
-		}
-
 		/* directory inode should be updated in here */
 		i_size_write(inode, size);
 		EXFAT_I(inode)->i_size_ondisk += sbi->cluster_size;
 		EXFAT_I(inode)->i_size_aligned += sbi->cluster_size;
 		EXFAT_I(inode)->flags = p_dir->flags;
 		inode->i_blocks += 1 << sbi->sect_per_clus_bits;
+
+		/* update the directory entry */
+		ret = exfat_update_inode(inode);
+		if (ret)
+			return ret;
 	}
 
 	return dentry;
-- 
2.25.1

