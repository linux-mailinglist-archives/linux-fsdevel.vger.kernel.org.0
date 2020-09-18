Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C5426EF38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 04:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgIRCd4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgIRCdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:33:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23EC06174A;
        Thu, 17 Sep 2020 19:33:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so2534911pgo.13;
        Thu, 17 Sep 2020 19:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suK0G2trm9D602pCdUsLsVHojuwWM7nIh79zVPBNDl4=;
        b=mYBjjf3sRIy05H7e2G2FiL/eiE5LV7m6M9LRP+S7mGaqsnGAvis7g5l1lzJxezibpL
         kAuWyEi6OtlFMAlCvvvtAIm/sC1G9mgr9VUVhKvCXNIKavrLtMKT5gLeB1jF6fFw/xLK
         SK/UKu55QB6tdmKQ4qmy5e2hPkOB+9SBGYOEY13PrJetYoUcQuBNXzT2fzYarHJwuriL
         /725h72htgOLolN7TJeAvetm091FB2N+jxJi1N8rJn+jJuFoU6D21zu2R+3NJn64Bn3Y
         UMDKfDwa0mjtCWkce8Bq36YvCeSiQ+0Urp0dFg/FQwNECJ30eEAKXukJOsF1fQ4obzXe
         AZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=suK0G2trm9D602pCdUsLsVHojuwWM7nIh79zVPBNDl4=;
        b=l05xQR61+ZahQZgyaREeTvnnY+8+Bb7UpyQqOzZVyAUMDRHkfwhHlL0l0xJa7fGDOM
         VH5jdtR3smJsLtzFfydFwfBYERSjbUJa3VMHeT1Kcz2dQHvUKZxfK7KnsN3iyxvwU1Pd
         v1vVpcC5rF9H/MRRlca07COh62GnklbWY/tOwnz4MD1fBb2FKgUIKNc1/sstCOo1N5VH
         fjdBO7AvNPkaDYgTo2uqb1+sKGwvlwN6M0MXg2xylXofsVEyXJyqQS4J/Y/6AVuP2ZE3
         +4iH48+uOixor/LCw/Y/aNqAAO5fbcIF3hesH/uJHgymMoXvZ6IjJL1eOB5SQf8QnTSv
         3dSw==
X-Gm-Message-State: AOAM533RtqaPpJZRjJRlLBI6Ro6Ty4vBCnE9TEcJQIzQR4iluflk3Nme
        unOJKbodHl0gauQ65bGI1KE=
X-Google-Smtp-Source: ABdhPJzaY4AS6NArJaCofEldBXMt9oWuanAO7TZ1eWFUL090/Hs9+8fA4UgUwdbccBYh00IRYqpOWA==
X-Received: by 2002:a05:6a00:84e:b029:142:2501:35e1 with SMTP id q14-20020a056a00084eb0290142250135e1mr13985494pfk.65.1600396424193;
        Thu, 17 Sep 2020 19:33:44 -0700 (PDT)
Received: from dc803.localdomain (FL1-111-169-191-163.hyg.mesh.ad.jp. [111.169.191.163])
        by smtp.gmail.com with ESMTPSA id i9sm1027248pfq.53.2020.09.17.19.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:33:43 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] exfat: aggregate dir-entry updates into __exfat_write_inode().
Date:   Fri, 18 Sep 2020 11:33:38 +0900
Message-Id: <20200918023339.17597-1-kohada.t2@gmail.com>
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

Also, in __exfat_write_inode(), rename 'on_disk_size' to 'filesize' and
add adjustment when filesize is 0.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/file.c  | 49 +++++-------------------------------------------
 fs/exfat/inode.c | 42 +++++++++++------------------------------
 fs/exfat/namei.c | 26 +++++--------------------
 3 files changed, 21 insertions(+), 96 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index dcc99349b816..d5b026183387 100644
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
+	inode->i_mtime = current_time(inode);
+	ret = exfat_update_inode(inode);
+	if (ret)
+		return ret;
 
 	/* cut off from the FAT chain */
 	if (ei->flags == ALLOC_FAT_CHAIN && last_clu != EXFAT_FREE_CLUSTER &&
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f307019afe88..3df80740529d 100644
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
+	ep2->dentry.stream.start_clu = filesize ? ei->start_clu : EXFAT_FREE_CLUSTER;
 
 	exfat_update_dir_chksum_with_entry_set(es);
 	return exfat_free_dentry_set(es, sync);
@@ -223,32 +224,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
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
+		if (modified) {
+			ret = exfat_update_inode(inode);
+			if (ret)
+				return ret;
+		}
 
 		inode->i_blocks +=
 			num_to_be_allocated << sbi->sect_per_clus_bits;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 4febff3541a9..903ad6ca53a2 100644
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
@@ -375,31 +373,17 @@ static int exfat_find_empty_entry(struct inode *inode,
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

