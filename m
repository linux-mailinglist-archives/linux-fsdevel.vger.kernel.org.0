Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92462280D47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 08:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJBGFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 02:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgJBGFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:05:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC18C0613D0;
        Thu,  1 Oct 2020 23:05:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so500178pfo.12;
        Thu, 01 Oct 2020 23:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvx0Llg7p9TD3h2VwOiQJIZ5oIceFBTqGXDCrZuwL+Y=;
        b=dNYNS18Mz3PVHoO6uGD4/bnhcwJKuDCmu6lr+BfZTCUfwst7i3yxoHQXTpQYDmXhHl
         kSnCFfQH0iTbHwCPhv98zq92Qz5IPuUvx3/J1gMiCE8gsIWLmW+XIvqwoMVoCZOGzbdy
         4QJbuZX1z+Qr9kquPP0oNPnFNykaH0AKhqU7CgDBtVYJvAYLsNbeqKnfle94T9W1852Q
         EZI2FySUVUvgszd+l6CwTZBS4H97maVTBhErQTLRQwMXsIEV4nvem2RzgBUi2iyQnS2V
         muX/WILLyP0Ch+EnGv8Td3a0eHhFkHa+zTbvYq6lrIxI4ImO47deGFzfOHYRr8wzqqJy
         2Yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hvx0Llg7p9TD3h2VwOiQJIZ5oIceFBTqGXDCrZuwL+Y=;
        b=dpr4aXia7luNImoo7cK4JgAvTFEOsnHTRAH5b04TkuQq0Hensz1IIU7ZwRwuERb0yw
         ntY3Ko4GgTyDeTsX9X1N1Aodhi4yJbIz4C4+52eOZlwNHG3TvnuNJE2im1OJtZrNmcDj
         crC2ZaQb0R23LWs+pkoHHIMAeoRjq69u3m8MyI+Z1mbGLD0Q5j2UMyUov+FgwKYYEap/
         RrCF6ni4ZptuCKBCiJUzfGIcTeFmwhaFOenIPlygBOJW6qa6Zjav0y8ZvesVX2WRMjRD
         edhsrMlnyl0zBTV9NoQOlLkbSv8KtH4H5/9rBaffhm81mnkRDFUEFpNsT5ceqhixPsE9
         iIOg==
X-Gm-Message-State: AOAM530kinH0VKZ/P3j8Sld+Ts362K/LeFuEaz0eERWUAlMmV/TPellW
        Awz1+1KDbwPFJJT8TCX/a6ZIoG0Spio/ow==
X-Google-Smtp-Source: ABdhPJxwjaFQUE59rY5Eh0yk0N/zWU3klKfTU9bKN8XUkdwChCL4C/USSRwvZ8ChzIfBkeHVTrQH3w==
X-Received: by 2002:a63:8c6:: with SMTP id 189mr587121pgi.207.1601618735172;
        Thu, 01 Oct 2020 23:05:35 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id gq14sm426040pjb.44.2020.10.01.23.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 23:05:34 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] exfat: aggregate dir-entry updates into __exfat_write_inode().
Date:   Fri,  2 Oct 2020 15:05:28 +0900
Message-Id: <20201002060528.27519-1-kohada.t2@gmail.com>
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

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v3
 - Remove update_inode() in exfat_map_cluster()/exfat_truncate()
 - Update commit-message
Changes in v2
 - Fix endian issue

 fs/exfat/file.c  | 52 +++++-------------------------------------------
 fs/exfat/inode.c | 47 +++++++++++--------------------------------
 fs/exfat/namei.c | 26 +++++-------------------
 3 files changed, 22 insertions(+), 103 deletions(-)

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
index 5a55303e1f65..cf29b14ce7f9 100644
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
@@ -184,6 +185,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			return -EIO;
 		}
 
+		exfat_warn(sb, "alloc[%lu]@map: %lld (%d - %08x)",
+			   inode->i_ino, i_size_read(inode),
+			   (clu_offset << sbi->sect_per_clus_bits) * 512,
+			   last_clu);
+
 		ret = exfat_alloc_cluster(inode, num_to_be_allocated, &new_clu);
 		if (ret)
 			return ret;
@@ -201,7 +207,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			if (new_clu.flags == ALLOC_FAT_CHAIN)
 				ei->flags = ALLOC_FAT_CHAIN;
 			ei->start_clu = new_clu.dir;
-			modified = true;
 		} else {
 			if (new_clu.flags != ei->flags) {
 				/* no-fat-chain bit is disabled,
@@ -211,7 +216,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				exfat_chain_cont_cluster(sb, ei->start_clu,
 					num_clusters);
 				ei->flags = ALLOC_FAT_CHAIN;
-				modified = true;
 			}
 			if (new_clu.flags == ALLOC_FAT_CHAIN)
 				if (exfat_ent_set(sb, last_clu, new_clu.dir))
@@ -221,33 +225,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
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
index 4eb7cb528e97..ef0ea031ed9e 100644
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

