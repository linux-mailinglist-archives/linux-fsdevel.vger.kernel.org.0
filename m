Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F59F86A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 03:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKLCKh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 21:10:37 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45676 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726923AbfKLCKg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:36 -0500
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AWfI028331
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:32 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2ARq4015365
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:32 -0500
Received: by mail-qt1-f198.google.com with SMTP id g13so2681885qtq.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q0RKMB9XNqWlYXWrkkpD7fVYoK/xzcKEF6ie+DJVzbs=;
        b=FKCTRmXtYYbXnKXeoGB+CLbKDykZCeBoJTUO08HZcDT4co2Ug5ZPUlnGdRk051NTN3
         wLkTTtPYBxRtUhgb+CpL+EIhArzjz2rar9Y3wShAHFH3Fc52sQi39cBA53jAjZQXW+Zj
         Th06W7Db1NYbuhLqYfz99u+Lin8pryDIALDurg3DF04eVwmRGZUDNCs/moFDhgJUK6g6
         ZJjJP6V8wfgB5+5GoS7/4donVLrUzBKZBElL+3OmWqEKdqUf2MBhDDeeqBbpnLjA6FNX
         65/p25mrJP/+nNl14J0w8okwmqVNtGq4nKpkgzN1avEK2UP19UWnwJDZn1Gkfz8DITLb
         KLqA==
X-Gm-Message-State: APjAAAXgLOTJnOFDKs3rxWF+Q6d8P7vUzZBVjjzksrJcxts1b/jSllZg
        v91gWZhm7p7EWIWgcVdYp9jrJ0bC3NiBEMOuXhSPftG4BCshwIVyGWwsMWCGaHEfva7mbBoHPDk
        Awl2msMtTLvxta5UE7Fc00j9BqDWYyp3l16ly
X-Received: by 2002:a05:620a:1011:: with SMTP id z17mr13413473qkj.39.1573524626546;
        Mon, 11 Nov 2019 18:10:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzu0QPaIh8sxg9xRUgzBV9Sb+3/dRYEN5FNW/GqmnaSuXeVI2k2GVwwyigHsyfezCA+vDfuWg==
X-Received: by 2002:a05:620a:1011:: with SMTP id z17mr13413431qkj.39.1573524625596;
        Mon, 11 Nov 2019 18:10:25 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:24 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] staging: exfat: Clean up return codes - FFS_MEDIAERR
Date:   Mon, 11 Nov 2019 21:09:50 -0500
Message-Id: <20191112021000.42091-3-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert FFS_MEDIAERR to (mostly) -ENOENT and -EIO.  Some additional code surgery
needed to propogate correct error codes upwards.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h        |   1 -
 drivers/staging/exfat/exfat_blkdev.c |  18 ++---
 drivers/staging/exfat/exfat_core.c   |  80 +++++++++----------
 drivers/staging/exfat/exfat_super.c  | 115 ++++++++++++++-------------
 4 files changed, 107 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 4f9ba235d967..286605262345 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -210,7 +210,6 @@ static inline u16 get_row_index(u16 i)
 
 /* return values */
 #define FFS_SUCCESS             0
-#define FFS_MEDIAERR            1
 #define FFS_MOUNTED             3
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 81d20e6241c6..0abae041f632 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -40,11 +40,11 @@ int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
-		return FFS_MEDIAERR;
+		return -EIO;
 #endif /* CONFIG_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
-		return FFS_MEDIAERR;
+		return -ENODEV;
 
 	if (*bh)
 		__brelse(*bh);
@@ -62,7 +62,7 @@ int bdev_read(struct super_block *sb, sector_t secno, struct buffer_head **bh,
 	WARN(!p_fs->dev_ejected,
 	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
-	return FFS_MEDIAERR;
+	return -EIO;
 }
 
 int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
@@ -77,11 +77,11 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
-		return FFS_MEDIAERR;
+		return -EIO;
 #endif /* CONFIG_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
-		return FFS_MEDIAERR;
+		return -ENODEV;
 
 	if (secno == bh->b_blocknr) {
 		lock_buffer(bh);
@@ -89,7 +89,7 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		if (sync && (sync_dirty_buffer(bh) != 0))
-			return FFS_MEDIAERR;
+			return -EIO;
 	} else {
 		count = num_secs << p_bd->sector_size_bits;
 
@@ -115,7 +115,7 @@ int bdev_write(struct super_block *sb, sector_t secno, struct buffer_head *bh,
 	WARN(!p_fs->dev_ejected,
 	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
-	return FFS_MEDIAERR;
+	return -EIO;
 }
 
 int bdev_sync(struct super_block *sb)
@@ -126,11 +126,11 @@ int bdev_sync(struct super_block *sb)
 	long flags = sbi->debug_flags;
 
 	if (flags & EXFAT_DEBUGFLAGS_ERROR_RW)
-		return FFS_MEDIAERR;
+		return -EIO;
 #endif /* CONFIG_EXFAT_KERNEL_DEBUG */
 
 	if (!p_bd->opened)
-		return FFS_MEDIAERR;
+		return -ENODEV;
 
 	return sync_blockdev(sb->s_bdev);
 }
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index e90b54a17150..2f6e9d724625 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -252,13 +252,13 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 		}
 
 		if (set_alloc_bitmap(sb, new_clu - 2) != FFS_SUCCESS)
-			return -1;
+			return -EIO;
 
 		num_clusters++;
 
 		if (p_chain->flags == 0x01) {
 			if (FAT_write(sb, new_clu, CLUSTER_32(~0)) < 0)
-				return -1;
+				return -EIO;
 		}
 
 		if (p_chain->dir == CLUSTER_32(~0)) {
@@ -266,7 +266,7 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 		} else {
 			if (p_chain->flags == 0x01) {
 				if (FAT_write(sb, last_clu, new_clu) < 0)
-					return -1;
+					return -EIO;
 			}
 		}
 		last_clu = new_clu;
@@ -526,7 +526,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			ep = (struct bmap_dentry_t *)get_entry_in_dir(sb, &clu,
 								      i, NULL);
 			if (!ep)
-				return FFS_MEDIAERR;
+				return -ENOENT;
 
 			type = p_fs->fs_func->get_entry_type((struct dentry_t *)ep);
 
@@ -570,7 +570,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 		}
 
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return FFS_MEDIAERR;
+			return -EIO;
 	}
 
 	return -EFSCORRUPTED;
@@ -856,14 +856,14 @@ s32 load_upcase_table(struct super_block *sb)
 	clu.flags = 0x01;
 
 	if (p_fs->dev_ejected)
-		return FFS_MEDIAERR;
+		return -EIO;
 
 	while (clu.dir != CLUSTER_32(~0)) {
 		for (i = 0; i < p_fs->dentries_per_clu; i++) {
 			ep = (struct case_dentry_t *)get_entry_in_dir(sb, &clu,
 								      i, NULL);
 			if (!ep)
-				return FFS_MEDIAERR;
+				return -ENOENT;
 
 			type = p_fs->fs_func->get_entry_type((struct dentry_t *)ep);
 
@@ -883,7 +883,7 @@ s32 load_upcase_table(struct super_block *sb)
 			return FFS_SUCCESS;
 		}
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return FFS_MEDIAERR;
+			return -EIO;
 	}
 	/* load default upcase table */
 	return __load_default_upcase_table(sb);
@@ -1246,7 +1246,7 @@ s32 fat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir, s32 entry,
 	dos_ep = (struct dos_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
 							 &sector);
 	if (!dos_ep)
-		return FFS_MEDIAERR;
+		return -EIO;
 
 	init_dos_entry(dos_ep, type, start_clu);
 	buf_modify(sb, sector);
@@ -1268,12 +1268,12 @@ s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	file_ep = (struct file_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
 							   &sector);
 	if (!file_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	strm_ep = (struct strm_dentry_t *)get_entry_in_dir(sb, p_dir, entry + 1,
 							   &sector);
 	if (!strm_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	init_file_entry(file_ep, type);
 	buf_modify(sb, sector);
@@ -1299,7 +1299,7 @@ static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	dos_ep = (struct dos_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
 							 &sector);
 	if (!dos_ep)
-		return FFS_MEDIAERR;
+		return -EIO;
 
 	dos_ep->lcase = p_dosname->name_case;
 	memcpy(dos_ep->name, p_dosname->name, DOS_NAME_LENGTH);
@@ -1315,7 +1315,7 @@ static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 									 entry - i,
 									 &sector);
 			if (!ext_ep)
-				return FFS_MEDIAERR;
+				return -EIO;
 
 			init_ext_entry(ext_ep, i, chksum, uniname);
 			buf_modify(sb, sector);
@@ -1326,7 +1326,7 @@ static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 								 entry - i,
 								 &sector);
 		if (!ext_ep)
-			return FFS_MEDIAERR;
+			return -EIO;
 
 		init_ext_entry(ext_ep, i + 0x40, chksum, uniname);
 		buf_modify(sb, sector);
@@ -1350,7 +1350,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	file_ep = (struct file_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
 							   &sector);
 	if (!file_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	file_ep->num_ext = (u8)(num_entries - 1);
 	buf_modify(sb, sector);
@@ -1358,7 +1358,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 	strm_ep = (struct strm_dentry_t *)get_entry_in_dir(sb, p_dir, entry + 1,
 							   &sector);
 	if (!strm_ep)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	strm_ep->name_len = p_uniname->name_len;
 	SET16_A(strm_ep->name_hash, p_uniname->name_hash);
@@ -1369,7 +1369,7 @@ static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 								   entry + i,
 								   &sector);
 		if (!name_ep)
-			return FFS_MEDIAERR;
+			return -ENOENT;
 
 		init_name_entry(name_ep, uniname);
 		buf_modify(sb, sector);
@@ -1592,7 +1592,7 @@ static s32 _walk_fat_chain(struct super_block *sb, struct chain_t *p_dir,
 	} else {
 		while (clu_offset > 0) {
 			if (FAT_read(sb, cur_clu, &cur_clu) == -1)
-				return FFS_MEDIAERR;
+				return -EIO;
 			clu_offset--;
 		}
 	}
@@ -2084,10 +2084,10 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 		/* (1) allocate a cluster */
 		ret = p_fs->fs_func->alloc_cluster(sb, 1, &clu);
 		if (ret < 1)
-			return -1;
+			return -EIO;
 
 		if (clear_cluster(sb, clu.dir) != FFS_SUCCESS)
-			return -1;
+			return -EIO;
 
 		/* (2) append to the FAT chain */
 		if (clu.flags != p_dir->flags) {
@@ -2097,7 +2097,7 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 		}
 		if (clu.flags == 0x01)
 			if (FAT_write(sb, last_clu, clu.dir) < 0)
-				return -1;
+				return -EIO;
 
 		if (p_fs->hint_uentry.entry == -1) {
 			p_fs->hint_uentry.dir = p_dir->dir;
@@ -2118,7 +2118,7 @@ s32 find_empty_entry(struct inode *inode, struct chain_t *p_dir, s32 num_entries
 				ep = get_entry_in_dir(sb, &fid->dir,
 						      fid->entry + 1, &sector);
 				if (!ep)
-					return -1;
+					return -ENOENT;
 				p_fs->fs_func->set_entry_size(ep, size);
 				p_fs->fs_func->set_entry_flag(ep, p_dir->flags);
 				buf_modify(sb, sector);
@@ -2464,7 +2464,7 @@ s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 		for (i = 0; i < dentries_per_clu; i++) {
 			ep = get_entry_in_dir(sb, &clu, i, NULL);
 			if (!ep)
-				return -1;
+				return -ENOENT;
 
 			entry_type = p_fs->fs_func->get_entry_type(ep);
 
@@ -2488,7 +2488,7 @@ s32 count_dos_name_entries(struct super_block *sb, struct chain_t *p_dir,
 				clu.dir = CLUSTER_32(~0);
 		} else {
 			if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-				return -1;
+				return -EIO;
 		}
 	}
 
@@ -2772,7 +2772,7 @@ s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			ep = (struct dos_dentry_t *)get_entry_in_dir(sb, &clu,
 								     i, NULL);
 			if (!ep)
-				return FFS_MEDIAERR;
+				return -ENOENT;
 
 			type = p_fs->fs_func->get_entry_type((struct dentry_t *)
 							     ep);
@@ -2811,7 +2811,7 @@ s32 fat_generate_dos_name(struct super_block *sb, struct chain_t *p_dir,
 			break; /* FAT16 root_dir */
 
 		if (FAT_read(sb, clu.dir, &clu.dir) != 0)
-			return FFS_MEDIAERR;
+			return -EIO;
 	}
 
 	count = 0;
@@ -3226,7 +3226,7 @@ s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	/* (1) allocate a cluster */
 	ret = fs_func->alloc_cluster(sb, 1, &clu);
 	if (ret < 0)
-		return FFS_MEDIAERR;
+		return ret;
 	else if (ret == 0)
 		return -ENOSPC;
 
@@ -3395,7 +3395,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 
 	epold = get_entry_in_dir(sb, p_dir, oldentry, &sector_old);
 	if (!epold)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	buf_lock(sb, sector_old);
 
@@ -3404,7 +3404,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 						     epold);
 	if (num_old_entries < 0) {
 		buf_unlock(sb, sector_old);
-		return FFS_MEDIAERR;
+		return -ENOENT;
 	}
 	num_old_entries++;
 
@@ -3425,7 +3425,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 		epnew = get_entry_in_dir(sb, p_dir, newentry, &sector_new);
 		if (!epnew) {
 			buf_unlock(sb, sector_old);
-			return FFS_MEDIAERR;
+			return -ENOENT;
 		}
 
 		memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
@@ -3447,7 +3447,7 @@ s32 rename_file(struct inode *inode, struct chain_t *p_dir, s32 oldentry,
 
 			if (!epold || !epnew) {
 				buf_unlock(sb, sector_old);
-				return FFS_MEDIAERR;
+				return -ENOENT;
 			}
 
 			memcpy((void *)epnew, (void *)epold, DENTRY_SIZE);
@@ -3502,7 +3502,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 
 	epmov = get_entry_in_dir(sb, p_olddir, oldentry, &sector_mov);
 	if (!epmov)
-		return FFS_MEDIAERR;
+		return -ENOENT;
 
 	/* check if the source and target directory is the same */
 	if (fs_func->get_entry_type(epmov) == TYPE_DIR &&
@@ -3516,7 +3516,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 						     epmov);
 	if (num_old_entries < 0) {
 		buf_unlock(sb, sector_mov);
-		return FFS_MEDIAERR;
+		return -ENOENT;
 	}
 	num_old_entries++;
 
@@ -3536,7 +3536,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 	epnew = get_entry_in_dir(sb, p_newdir, newentry, &sector_new);
 	if (!epnew) {
 		buf_unlock(sb, sector_mov);
-		return FFS_MEDIAERR;
+		return -ENOENT;
 	}
 
 	memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
@@ -3556,7 +3556,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 					 &sector_new);
 		if (!epmov || !epnew) {
 			buf_unlock(sb, sector_mov);
-			return FFS_MEDIAERR;
+			return -ENOENT;
 		}
 
 		memcpy((void *)epnew, (void *)epmov, DENTRY_SIZE);
@@ -3569,7 +3569,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 
 		epnew = get_entry_in_dir(sb, &clu, 1, &sector_new);
 		if (!epnew)
-			return FFS_MEDIAERR;
+			return -ENOENT;
 
 		if (p_newdir->dir == p_fs->root_dir)
 			fs_func->set_entry_clu0(epnew, CLUSTER_32(0));
@@ -3601,7 +3601,7 @@ s32 move_file(struct inode *inode, struct chain_t *p_olddir, s32 oldentry,
 int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 		bool read)
 {
-	s32 ret = FFS_MEDIAERR;
+	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if ((sec >= (p_fs->PBR_sector + p_fs->num_sectors)) &&
@@ -3624,7 +3624,7 @@ int sector_read(struct super_block *sb, sector_t sec, struct buffer_head **bh,
 int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 		 bool sync)
 {
-	s32 ret = FFS_MEDIAERR;
+	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if (sec >= (p_fs->PBR_sector + p_fs->num_sectors) &&
@@ -3653,7 +3653,7 @@ int sector_write(struct super_block *sb, sector_t sec, struct buffer_head *bh,
 int multi_sector_read(struct super_block *sb, sector_t sec,
 		      struct buffer_head **bh, s32 num_secs, bool read)
 {
-	s32 ret = FFS_MEDIAERR;
+	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if (((sec + num_secs) > (p_fs->PBR_sector + p_fs->num_sectors)) &&
@@ -3676,7 +3676,7 @@ int multi_sector_read(struct super_block *sb, sector_t sec,
 int multi_sector_write(struct super_block *sb, sector_t sec,
 		       struct buffer_head *bh, s32 num_secs, bool sync)
 {
-	s32 ret = FFS_MEDIAERR;
+	s32 ret = -EIO;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 
 	if ((sec + num_secs) > (p_fs->PBR_sector + p_fs->num_sectors) &&
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index e0c4a3ab8458..d6d5f0fd47fd 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -364,7 +364,9 @@ static int ffsMountVol(struct super_block *sb)
 	bdev_open(sb);
 
 	if (p_bd->sector_size < sb->s_blocksize) {
-		ret = FFS_MEDIAERR;
+		printk(KERN_INFO "EXFAT: maont failed - sector size %d less than blocksize %ld\n",
+			p_bd->sector_size,  sb->s_blocksize);
+		ret = -EINVAL;
 		goto out;
 	}
 	if (p_bd->sector_size > sb->s_blocksize)
@@ -372,7 +374,7 @@ static int ffsMountVol(struct super_block *sb)
 
 	/* read Sector 0 */
 	if (sector_read(sb, 0, &tmp_bh, 1) != FFS_SUCCESS) {
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 		goto out;
 	}
 
@@ -435,7 +437,7 @@ static int ffsMountVol(struct super_block *sb)
 			free_alloc_bitmap(sb);
 		}
 		bdev_close(sb);
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 		goto out;
 	}
 
@@ -475,7 +477,7 @@ static int ffsUmountVol(struct super_block *sb)
 
 	if (p_fs->dev_ejected) {
 		pr_info("[EXFAT] unmounted with media errors. Device is already ejected.\n");
-		err = FFS_MEDIAERR;
+		err = -EIO;
 	}
 
 	buf_shutdown(sb);
@@ -511,7 +513,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	info->FreeClusters = info->NumClusters - info->UsedClusters;
 
 	if (p_fs->dev_ejected)
-		err = FFS_MEDIAERR;
+		err = -EIO;
 
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -532,7 +534,7 @@ static int ffsSyncVol(struct super_block *sb, bool do_sync)
 	fs_set_vol_flags(sb, VOL_CLEAN);
 
 	if (p_fs->dev_ejected)
-		err = FFS_MEDIAERR;
+		err = -EIO;
 
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -601,14 +603,14 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 			es = get_entry_set_in_dir(sb, &dir, dentry,
 						  ES_2_ENTRIES, &ep);
 			if (!es) {
-				ret =  FFS_MEDIAERR;
+				ret =  -ENOENT;
 				goto out;
 			}
 			ep2 = ep + 1;
 		} else {
 			ep = get_entry_in_dir(sb, &dir, dentry, NULL);
 			if (!ep) {
-				ret =  FFS_MEDIAERR;
+				ret =  -ENOENT;
 				goto out;
 			}
 			ep2 = ep;
@@ -633,7 +635,7 @@ static int ffsLookupFile(struct inode *inode, char *path, struct file_id_t *fid)
 	}
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -673,7 +675,7 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -744,7 +746,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 			while (clu_offset > 0) {
 				/* clu = FAT_read(sb, clu); */
 				if (FAT_read(sb, clu, &clu) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 
@@ -799,7 +801,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 		*rcount = read_bytes;
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -890,7 +892,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 				last_clu = clu;
 				/* clu = FAT_read(sb, clu); */
 				if (FAT_read(sb, clu, &clu) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 				clu_offset--;
@@ -912,7 +914,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 			if (num_alloced == 0)
 				break;
 			if (num_alloced < 0) {
-				ret = FFS_MEDIAERR;
+				ret = num_alloced;
 				goto out;
 			}
 
@@ -1057,7 +1059,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 		ret = -ENOSPC;
 
 	else if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1118,7 +1120,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 			while (num_clusters > 0) {
 				last_clu = clu.dir;
 				if (FAT_read(sb, clu.dir, &clu.dir) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 				num_clusters--;
@@ -1140,14 +1142,14 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 			}
 		ep2 = ep + 1;
 	} else {
 		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep;
@@ -1189,7 +1191,7 @@ static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	pr_debug("%s exited (%d)\n", __func__, ret);
@@ -1262,7 +1264,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	ep = get_entry_in_dir(sb, &olddir, dentry, NULL);
 	if (!ep) {
-		ret = FFS_MEDIAERR;
+		ret = -ENOENT;
 		goto out2;
 	}
 
@@ -1275,7 +1277,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 	if (new_inode) {
 		u32 entry_type;
 
-		ret = FFS_MEDIAERR;
+		ret = -ENOENT;
 		new_fid = &EXFAT_I(new_inode)->fid;
 
 		update_parent_info(new_fid, new_parent_inode);
@@ -1337,7 +1339,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out2:
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -1369,7 +1371,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 	ep = get_entry_in_dir(sb, &dir, dentry, NULL);
 	if (!ep) {
-		ret = FFS_MEDIAERR;
+		ret = -ENOENT;
 		goto out;
 	}
 
@@ -1399,7 +1401,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -1423,7 +1425,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 
 	if (fid->attr == attr) {
 		if (p_fs->dev_ejected)
-			return FFS_MEDIAERR;
+			return -EIO;
 		return FFS_SUCCESS;
 	}
 
@@ -1431,7 +1433,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		if ((fid->dir.dir == p_fs->root_dir) &&
 		    (fid->entry == -1)) {
 			if (p_fs->dev_ejected)
-				return FFS_MEDIAERR;
+				return -EIO;
 			return FFS_SUCCESS;
 		}
 	}
@@ -1444,13 +1446,13 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 	} else {
 		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 	}
@@ -1460,7 +1462,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 	if (((type == TYPE_FILE) && (attr & ATTR_SUBDIR)) ||
 	    ((type == TYPE_DIR) && (!(attr & ATTR_SUBDIR)))) {
 		if (p_fs->dev_ejected)
-			ret = FFS_MEDIAERR;
+			ret = -EIO;
 		else
 			ret = FFS_ERROR;
 
@@ -1488,7 +1490,7 @@ static int ffsSetAttr(struct inode *inode, u32 attr)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -1544,13 +1546,13 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 			count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 			if (count < 0) {
-				ret = FFS_MEDIAERR;
+				ret = count; /* propogate error upward */
 				goto out;
 			}
 			info->NumSubdirs = count;
 
 			if (p_fs->dev_ejected)
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 			goto out;
 		}
 	}
@@ -1560,14 +1562,14 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_2_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep + 1;
 	} else {
 		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep;
@@ -1633,14 +1635,14 @@ static int ffsReadStat(struct inode *inode, struct dir_entry_t *info)
 
 		count = count_dos_name_entries(sb, &dir, TYPE_DIR);
 		if (count < 0) {
-			ret = FFS_MEDIAERR;
+			ret = count; /* propogate error upward */
 			goto out;
 		}
 		info->NumSubdirs += count;
 	}
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1671,7 +1673,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		if ((fid->dir.dir == p_fs->root_dir) &&
 		    (fid->entry == -1)) {
 			if (p_fs->dev_ejected)
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 			ret = FFS_SUCCESS;
 			goto out;
 		}
@@ -1684,7 +1686,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 					  ES_ALL_ENTRIES, &ep);
 		if (!es) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep + 1;
@@ -1692,7 +1694,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 		/* for other than exfat */
 		ep = get_entry_in_dir(sb, &fid->dir, fid->entry, &sector);
 		if (!ep) {
-			ret = FFS_MEDIAERR;
+			ret = -ENOENT;
 			goto out;
 		}
 		ep2 = ep;
@@ -1727,7 +1729,7 @@ static int ffsWriteStat(struct inode *inode, struct dir_entry_t *info)
 	}
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1789,7 +1791,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		while ((clu_offset > 0) && (*clu != CLUSTER_32(~0))) {
 			last_clu = *clu;
 			if (FAT_read(sb, *clu, clu) == -1) {
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 				goto out;
 			}
 			clu_offset--;
@@ -1807,7 +1809,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 		/* (1) allocate a cluster */
 		num_alloced = p_fs->fs_func->alloc_cluster(sb, 1, &new_clu);
 		if (num_alloced < 0) {
-			ret = FFS_MEDIAERR;
+			ret = -EIO;
 			goto out;
 		} else if (num_alloced == 0) {
 			ret = -ENOSPC;
@@ -1838,7 +1840,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 			es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
 						  ES_ALL_ENTRIES, &ep);
 			if (!es) {
-				ret = FFS_MEDIAERR;
+				ret = -ENOENT;
 				goto out;
 			}
 			/* get stream entry */
@@ -1851,7 +1853,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 				ep = get_entry_in_dir(sb, &fid->dir,
 						      fid->entry, &sector);
 				if (!ep) {
-					ret = FFS_MEDIAERR;
+					ret = -ENOENT;
 					goto out;
 				}
 			}
@@ -1881,7 +1883,7 @@ static int ffsMapCluster(struct inode *inode, s32 clu_offset, u32 *clu)
 	fid->hint_last_clu = *clu;
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -1926,7 +1928,7 @@ static int ffsCreateDir(struct inode *inode, char *path, struct file_id_t *fid)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 out:
 	/* release the lock for file system critical section */
 	mutex_unlock(&p_fs->v_mutex);
@@ -1956,7 +1958,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 
 	/* check if the given file ID is opened */
 	if (fid->type != TYPE_DIR)
-		return -EPERM;
+		return -ENOTDIR;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -2006,7 +2008,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			while (clu_offset > 0) {
 				/* clu.dir = FAT_read(sb, clu.dir); */
 				if (FAT_read(sb, clu.dir, &clu.dir) == -1) {
-					ret = FFS_MEDIAERR;
+					ret = -EIO;
 					goto out;
 				}
 				clu_offset--;
@@ -2026,7 +2028,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		for ( ; i < dentries_per_clu; i++, dentry++) {
 			ep = get_entry_in_dir(sb, &clu, i, &sector);
 			if (!ep) {
-				ret = FFS_MEDIAERR;
+				ret = -ENOENT;
 				goto out;
 			}
 			type = fs_func->get_entry_type(ep);
@@ -2074,7 +2076,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			if (p_fs->vol_type == EXFAT) {
 				ep = get_entry_in_dir(sb, &clu, i + 1, NULL);
 				if (!ep) {
-					ret = FFS_MEDIAERR;
+					ret = -ENOENT;
 					goto out;
 				}
 			} else {
@@ -2098,7 +2100,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 			fid->rwoffset = (s64)(++dentry);
 
 			if (p_fs->dev_ejected)
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 			goto out;
 		}
 
@@ -2113,7 +2115,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 		} else {
 			/* clu.dir = FAT_read(sb, clu.dir); */
 			if (FAT_read(sb, clu.dir, &clu.dir) == -1) {
-				ret = FFS_MEDIAERR;
+				ret = -EIO;
 				goto out;
 			}
 		}
@@ -2124,7 +2126,7 @@ static int ffsReadDir(struct inode *inode, struct dir_entry_t *dir_entry)
 	fid->rwoffset = (s64)(++dentry);
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -2187,7 +2189,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 #endif
 
 	if (p_fs->dev_ejected)
-		ret = FFS_MEDIAERR;
+		ret = -EIO;
 
 out:
 	/* release the lock for file system critical section */
@@ -2247,12 +2249,11 @@ static int exfat_readdir(struct file *filp, struct dir_context *ctx)
 		/* at least we tried to read a sector
 		 * move cpos to next sector position (should be aligned)
 		 */
-		if (err == FFS_MEDIAERR) {
+		if (err == -EIO) {
 			cpos += 1 << p_bd->sector_size_bits;
 			cpos &= ~((1 << p_bd->sector_size_bits) - 1);
 		}
 
-		err = -EIO;
 		goto end_of_dir;
 	}
 
@@ -3550,7 +3551,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct vol_info_t info;
 
 	if (p_fs->used_clusters == UINT_MAX) {
-		if (ffsGetVolInfo(sb, &info) == FFS_MEDIAERR)
+		if (ffsGetVolInfo(sb, &info) == -EIO)
 			return -EIO;
 
 	} else {
-- 
2.24.0

