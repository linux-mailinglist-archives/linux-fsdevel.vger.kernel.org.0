Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21358233EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 07:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgGaF6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 01:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGaF6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:58:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760AC061574;
        Thu, 30 Jul 2020 22:58:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d1so16404038plr.8;
        Thu, 30 Jul 2020 22:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZzFLuCVPzlle1jrEWbCNmXDRNwYYDUlotjiTA7eDoI=;
        b=gqbhEdWrzdaVKReunP51i1hEfexT8r20a0jx3jX164EM/aG6WwWHS8SdiYWEa6Ad1w
         IeIsJWjPJdVrVnLmW+scmIWWdo4a7YhYCwIiLJQuddqHIBn7mOZWW83XSDf7f/SeA8vr
         kmYlrplOBlxXyQfKRY7BedyBl/dvLnJGJmUKBYNKmqpTgNsIyCXLUzr4clf8Hc9vTlNR
         HEeBGxD9HJTasT+AsFi91dYeZXSjYi9OqI0ZmSMvAUtJly8PsMbZVJxbAkiKCe0HP/wt
         W2NL7DtJCILhR1QE/SWwlBHhe/oMQbCJ1JBmgrhfwwQW2TewaHCea9vymJNyGHtXAngX
         hSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QZzFLuCVPzlle1jrEWbCNmXDRNwYYDUlotjiTA7eDoI=;
        b=LOPmN8rCDh9tg4b5uCvzio7SlzCD5pxb75RULHUEqN3X5W73eSYz2vxR63h3GHTsG/
         k48L+Gmwh0G0pd+Mg3PqhoX17CCqqpOfymZivDWfYE8wknLz/zCtywKBVWnvxeH2Mn+1
         2Ox/4ThRG1cRP4N1DsS7mE1Op8Jpo5KMELjvtTyGy0zP8TEro7pVVJSmZwErKYE/30e8
         4efIozWmDk67oHDJ26tLg5g6Zs0gCllprdgW/76FFGos7aTf/JCttx03XSX7mGWyntZr
         modlodWUDP7HZhIL6ZWSeNHvAA98rdHMuzPQOCEsacX9rJF+AxZkQc+zAU+myDGWs/vD
         5Ziw==
X-Gm-Message-State: AOAM531KCjqKN5vkcNFl+j1It5AlXE3XPi4UYvqSdnbnIntPEEkeTlUV
        qAOaeXYmMIoQZWErI/kcfqUjlK59+QA=
X-Google-Smtp-Source: ABdhPJxsLPmeszAHgyrm9QeqOR9I6OaTd0IAWbAilgTSpqcG7O2pxFP0SyIj2g5wjzToWAnZ3Cr3JA==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr2163499pgm.253.1596175132269;
        Thu, 30 Jul 2020 22:58:52 -0700 (PDT)
Received: from dc803.localdomain (flh2-125-196-131-224.osk.mesh.ad.jp. [125.196.131.224])
        by smtp.gmail.com with ESMTPSA id d22sm8442353pfd.42.2020.07.30.22.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 22:58:51 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] exfat: retain 'VolumeFlags' properly
Date:   Fri, 31 Jul 2020 14:58:26 +0900
Message-Id: <20200731055827.493-1-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Retain ActiveFat, MediaFailure and ClearToZero fields.
And, never clear VolumeDirty, if it is dirty at mount.

In '3.1.13.3 Media Failure Field' of exfat specification says ...
 If, upon mounting a volume, the value of this field is 1, implementations
 which scan the entire volume for media failures and record all failures as
 "bad" clusters in the FAT (or otherwise resolve media failures) may clear
 the value of this field to 0.
Therefore, should not clear MediaFailure without scanning volume.

In '8.1 Recommended Write Ordering' of exfat specification says ...
 Clear the value of the VolumeDirty field to 0, if its value prior to the
 first step was 0
Therefore, should not clear VolumeDirty when mounted.

Also, rename ERR_MEDIUM to MEDIA_FAILURE.

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
Changes in v2
 - Add exfat_set_volume_dirty() & exfat_clear_volume_dirty()
 - Rename vol_flags_noclear to vol_flags_persistent
 - Rename MED_FAILURE to MEDIA_FAILURE
 - Rename VOL_DIRTY to VOLUME_DIRTY
 - Remove VOL_CLEAN

 fs/exfat/exfat_fs.h  |  6 ++++--
 fs/exfat/exfat_raw.h |  5 ++---
 fs/exfat/file.c      |  4 ++--
 fs/exfat/inode.c     |  4 ++--
 fs/exfat/namei.c     | 20 ++++++++++----------
 fs/exfat/super.c     | 36 +++++++++++++++++++++++++++---------
 6 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index cb51d6e83199..95d717f8620c 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -224,7 +224,8 @@ struct exfat_sb_info {
 	unsigned int num_FAT_sectors; /* num of FAT sectors */
 	unsigned int root_dir; /* root dir cluster */
 	unsigned int dentries_per_clu; /* num of dentries per cluster */
-	unsigned int vol_flag; /* volume dirty flag */
+	unsigned int vol_flags; /* volume flags */
+	unsigned int vol_flags_persistent; /* volume flags to retain */
 	struct buffer_head *boot_bh; /* buffer_head of BOOT sector */
 
 	unsigned int map_clu; /* allocation bitmap start cluster */
@@ -380,7 +381,8 @@ static inline int exfat_sector_to_cluster(struct exfat_sb_info *sbi,
 }
 
 /* super.c */
-int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag);
+int exfat_set_volume_dirty(struct super_block *sb);
+int exfat_clear_volume_dirty(struct super_block *sb);
 
 /* fatent.c */
 #define exfat_get_next_cluster(sb, pclu) exfat_ent_get(sb, *(pclu), pclu)
diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
index 350ce59cc324..6aec6288e1f2 100644
--- a/fs/exfat/exfat_raw.h
+++ b/fs/exfat/exfat_raw.h
@@ -14,9 +14,8 @@
 
 #define EXFAT_MAX_FILE_LEN	255
 
-#define VOL_CLEAN		0x0000
-#define VOL_DIRTY		0x0002
-#define ERR_MEDIUM		0x0004
+#define VOLUME_DIRTY		0x0002
+#define MEDIA_FAILURE		0x0004
 
 #define EXFAT_EOF_CLUSTER	0xFFFFFFFFu
 #define EXFAT_BAD_CLUSTER	0xFFFFFFF7u
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6bdabfd4b134..f41f523a58ad 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -106,7 +106,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	if (ei->type != TYPE_FILE && ei->type != TYPE_DIR)
 		return -EPERM;
 
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 
 	num_clusters_new = EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi);
 	num_clusters_phys =
@@ -220,7 +220,7 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
 	if (exfat_free_cluster(inode, &clu))
 		return -EIO;
 
-	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_clear_volume_dirty(sb);
 
 	return 0;
 }
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f0160a7892a8..7f90204adef5 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -39,7 +39,7 @@ static int __exfat_write_inode(struct inode *inode, int sync)
 	if (is_dir && ei->dir.dir == sbi->root_dir && ei->entry == -1)
 		return 0;
 
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 
 	/* get the directory entry of given file or directory */
 	es = exfat_get_dentry_set(sb, &(ei->dir), ei->entry, ES_ALL_ENTRIES);
@@ -167,7 +167,7 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 	}
 
 	if (*clu == EXFAT_EOF_CLUSTER) {
-		exfat_set_vol_flags(sb, VOL_DIRTY);
+		exfat_set_volume_dirty(sb);
 
 		new_clu.dir = (last_clu == EXFAT_EOF_CLUSTER) ?
 				EXFAT_EOF_CLUSTER : last_clu + 1;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 126ed3ba8f47..e73f20f66cb2 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -562,10 +562,10 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	int err;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 	err = exfat_add_entry(dir, dentry->d_name.name, &cdir, TYPE_FILE,
 		&info);
-	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_clear_volume_dirty(sb);
 	if (err)
 		goto unlock;
 
@@ -834,7 +834,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	num_entries++;
 	brelse(bh);
 
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 	/* update the directory entry */
 	if (exfat_remove_entries(dir, &cdir, entry, 0, num_entries)) {
 		err = -EIO;
@@ -843,7 +843,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	/* This doesn't modify ei */
 	ei->dir.dir = DIR_DELETED;
-	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_clear_volume_dirty(sb);
 
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_atime = current_time(dir);
@@ -873,10 +873,10 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	int err;
 
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 	err = exfat_add_entry(dir, dentry->d_name.name, &cdir, TYPE_DIR,
 		&info);
-	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_clear_volume_dirty(sb);
 	if (err)
 		goto unlock;
 
@@ -1001,14 +1001,14 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	num_entries++;
 	brelse(bh);
 
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 	err = exfat_remove_entries(dir, &cdir, entry, 0, num_entries);
 	if (err) {
 		exfat_err(sb, "failed to exfat_remove_entries : err(%d)", err);
 		goto unlock;
 	}
 	ei->dir.dir = DIR_DELETED;
-	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_clear_volume_dirty(sb);
 
 	inode_inc_iversion(dir);
 	dir->i_mtime = dir->i_atime = current_time(dir);
@@ -1300,7 +1300,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 	if (ret)
 		goto out;
 
-	exfat_set_vol_flags(sb, VOL_DIRTY);
+	exfat_set_volume_dirty(sb);
 
 	if (olddir.dir == newdir.dir)
 		ret = exfat_rename_file(new_parent_inode, &olddir, dentry,
@@ -1355,7 +1355,7 @@ static int __exfat_rename(struct inode *old_parent_inode,
 		 */
 		new_ei->dir.dir = DIR_DELETED;
 	}
-	exfat_set_vol_flags(sb, VOL_CLEAN);
+	exfat_clear_volume_dirty(sb);
 out:
 	return ret;
 }
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index b5bf6dedbe11..3b6a1659892f 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -63,7 +63,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	/* If there are some dirty buffers in the bdev inode */
 	mutex_lock(&sbi->s_lock);
 	sync_blockdev(sb->s_bdev);
-	if (exfat_set_vol_flags(sb, VOL_CLEAN))
+	if (exfat_clear_volume_dirty(sb))
 		err = -EIO;
 	mutex_unlock(&sbi->s_lock);
 	return err;
@@ -96,17 +96,20 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
+static int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flags)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct boot_sector *p_boot = (struct boot_sector *)sbi->boot_bh->b_data;
 	bool sync;
 
+	/* retain persistent-flags */
+	new_flags |= sbi->vol_flags_persistent;
+
 	/* flags are not changed */
-	if (sbi->vol_flag == new_flag)
+	if (sbi->vol_flags == new_flags)
 		return 0;
 
-	sbi->vol_flag = new_flag;
+	sbi->vol_flags = new_flags;
 
 	/* skip updating volume dirty flag,
 	 * if this volume has been mounted with read-only
@@ -114,9 +117,9 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	if (sb_rdonly(sb))
 		return 0;
 
-	p_boot->vol_flags = cpu_to_le16(new_flag);
+	p_boot->vol_flags = cpu_to_le16(new_flags);
 
-	if (new_flag == VOL_DIRTY && !buffer_dirty(sbi->boot_bh))
+	if ((new_flags & VOLUME_DIRTY) && !buffer_dirty(sbi->boot_bh))
 		sync = true;
 	else
 		sync = false;
@@ -129,6 +132,20 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
 	return 0;
 }
 
+int exfat_set_volume_dirty(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	return exfat_set_vol_flags(sb, sbi->vol_flags | VOLUME_DIRTY);
+}
+
+int exfat_clear_volume_dirty(struct super_block *sb)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+
+	return exfat_set_vol_flags(sb, sbi->vol_flags & ~VOLUME_DIRTY);
+}
+
 static int exfat_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct super_block *sb = root->d_sb;
@@ -457,7 +474,8 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	sbi->dentries_per_clu = 1 <<
 		(sbi->cluster_size_bits - DENTRY_SIZE_BITS);
 
-	sbi->vol_flag = le16_to_cpu(p_boot->vol_flags);
+	sbi->vol_flags = le16_to_cpu(p_boot->vol_flags);
+	sbi->vol_flags_persistent = sbi->vol_flags & (VOLUME_DIRTY | MEDIA_FAILURE);
 	sbi->clu_srch_ptr = EXFAT_FIRST_CLUSTER;
 	sbi->used_clusters = EXFAT_CLUSTERS_UNTRACKED;
 
@@ -472,9 +490,9 @@ static int exfat_read_boot_sector(struct super_block *sb)
 		exfat_err(sb, "bogus data start sector");
 		return -EINVAL;
 	}
-	if (sbi->vol_flag & VOL_DIRTY)
+	if (sbi->vol_flags & VOLUME_DIRTY)
 		exfat_warn(sb, "Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
-	if (sbi->vol_flag & ERR_MEDIUM)
+	if (sbi->vol_flags & MEDIA_FAILURE)
 		exfat_warn(sb, "Medium has reported failures. Some data may be lost.");
 
 	/* exFAT file size is limited by a disk volume size */
-- 
2.25.1

