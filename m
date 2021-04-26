Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B536AC0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 08:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhDZGOf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 02:14:35 -0400
Received: from mx05.melco.co.jp ([192.218.140.145]:47296 "EHLO
        mx05.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDZGOe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:14:34 -0400
X-Greylist: delayed 810 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Apr 2021 02:14:34 EDT
Received: from mr05.melco.co.jp (mr05 [133.141.98.165])
        by mx05.melco.co.jp (Postfix) with ESMTP id 4FTDkx1TYLzMwCYp;
        Mon, 26 Apr 2021 15:00:09 +0900 (JST)
Received: from mr05.melco.co.jp (unknown [127.0.0.1])
        by mr05.imss (Postfix) with ESMTP id 4FTDkx12R4zMqtkg;
        Mon, 26 Apr 2021 15:00:09 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr05.melco.co.jp (Postfix) with ESMTP id 4FTDkx0kLNzMqtkS;
        Mon, 26 Apr 2021 15:00:09 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 4FTDkx0h4dzMs8jQ;
        Mon, 26 Apr 2021 15:00:09 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 4FTDkx06WrzMs8jL;
        Mon, 26 Apr 2021 15:00:09 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 13Q608pd007995;
        Mon, 26 Apr 2021 15:00:08 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id BAF2317E07A;
        Mon, 26 Apr 2021 15:00:08 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tadpost1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id A505A17E019;
        Mon, 26 Apr 2021 15:00:08 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 13Q608e9027561;
        Mon, 26 Apr 2021 15:00:08 +0900
From:   Tetsuhiro Kohada <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
To:     linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp
Subject: [PATCH] fat: Mark dirty just before updating metadata
Date:   Mon, 26 Apr 2021 21:56:12 +0900
Message-Id: <20210426125612.62396-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of marking dirty-state on mount, do it just before updating
the metadata.
Therefore, if no write operation is performed, the boot sector will
not be updated.
This eliminates unnecessary dirty mark / unmark and reduces the risk
of boot sector corruption.
Also, keep boot-sec bh in sb to suppress errors when updating dirty.

Signed-off-by: Tetsuhiro Kohada <kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
---
 fs/fat/dir.c         |   2 +
 fs/fat/fat.h         |   4 ++
 fs/fat/fatent.c      |   8 +++-
 fs/fat/file.c        |   1 +
 fs/fat/inode.c       | 100 +++++++++++++++++++++++--------------------
 fs/fat/misc.c        |   1 +
 fs/fat/namei_msdos.c |   1 +
 fs/fat/namei_vfat.c  |   1 +
 8 files changed, 70 insertions(+), 48 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index c4a274285858..d0236908dfc5 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -1033,6 +1033,7 @@ int fat_remove_entries(struct inode *dir, struct fat_slot_info *sinfo)
 	struct buffer_head *bh;
 	int err = 0, nr_slots;
 
+	fat_set_state(sb, true);
 	/*
 	 * First stage: Remove the shortname. By this, the directory
 	 * entry is removed.
@@ -1327,6 +1328,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	}
 
 found:
+	fat_set_state(sb, true);
 	err = 0;
 	pos -= free_slots * sizeof(*de);
 	nr_slots -= free_slots;
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 02d4d4234956..c254f0beea15 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -76,6 +76,7 @@ struct msdos_sb_info {
 	struct mutex fat_lock;
 	struct mutex nfs_build_inode_lock;
 	struct mutex s_lock;
+	struct mutex bootsec_lock;
 	unsigned int prev_free;      /* previously allocated cluster number */
 	unsigned int free_clusters;  /* -1 if undefined */
 	unsigned int free_clus_valid; /* is free_clusters valid? */
@@ -101,6 +102,8 @@ struct msdos_sb_info {
 	struct hlist_head dir_hashtable[FAT_HASH_SIZE];
 
 	unsigned int dirty;           /* fs state before mount */
+	u8 state;			/* current fs state */
+	struct buffer_head *boot_bh;
 	struct rcu_head rcu;
 };
 
@@ -425,6 +428,7 @@ static inline unsigned long fat_dir_hash(int logstart)
 	return hash_32(logstart, FAT_HASH_BITS);
 }
 extern int fat_add_cluster(struct inode *inode);
+extern void fat_set_state(struct super_block *sb, bool dirty);
 
 /* fat/misc.c */
 extern __printf(3, 4) __cold
diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index f7e3304b7802..5c4cebfdf337 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -472,6 +472,7 @@ int fat_alloc_clusters(struct inode *inode, int *cluster, int nr_cluster)
 
 	BUG_ON(nr_cluster > (MAX_BUF_PER_PAGE / 2));	/* fixed limit */
 
+	fat_set_state(sb, true);
 	lock_fat(sbi);
 	if (sbi->free_clusters != -1 && sbi->free_clus_valid &&
 	    sbi->free_clusters < nr_cluster) {
@@ -559,6 +560,7 @@ int fat_free_clusters(struct inode *inode, int cluster)
 	int i, err, nr_bhs;
 	int first_cl = cluster, dirty_fsinfo = 0;
 
+	fat_set_state(sb, true);
 	nr_bhs = 0;
 	fatent_init(&fatent);
 	lock_fat(sbi);
@@ -741,9 +743,11 @@ int fat_count_free_clusters(struct super_block *sb)
 		} while (fat_ent_next(sbi, &fatent));
 		cond_resched();
 	}
-	sbi->free_clusters = free;
 	sbi->free_clus_valid = 1;
-	mark_fsinfo_dirty(sb);
+	if (sbi->free_clusters != free) {
+		sbi->free_clusters = free;
+		mark_fsinfo_dirty(sb);
+	}
 	fatent_brelse(&fatent);
 out:
 	unlock_fat(sbi);
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 13855ba49cd9..8fbaa48a6b93 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -314,6 +314,7 @@ static int fat_free(struct inode *inode, int skip)
 	if (MSDOS_I(inode)->i_start == 0)
 		return 0;
 
+	fat_set_state(sb, true);
 	fat_cache_inval_inode(inode);
 
 	wait = IS_DIRSYNC(inode);
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index bab9b202b496..cb7b50746b9b 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -662,52 +662,45 @@ static void fat_evict_inode(struct inode *inode)
 	fat_detach(inode);
 }
 
-static void fat_set_state(struct super_block *sb,
-			unsigned int set, unsigned int force)
+void fat_set_state(struct super_block *sb, bool dirty)
 {
-	struct buffer_head *bh;
 	struct fat_boot_sector *b;
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+	u8 newstate;
 
 	/* do not change any thing if mounted read only */
-	if (sb_rdonly(sb) && !force)
+	if (sb_rdonly(sb))
 		return;
 
 	/* do not change state if fs was dirty */
-	if (sbi->dirty) {
-		/* warn only on set (mount). */
-		if (set)
-			fat_msg(sb, KERN_WARNING, "Volume was not properly "
-				"unmounted. Some data may be corrupt. "
-				"Please run fsck.");
+	if (sbi->dirty)
 		return;
-	}
-
-	bh = sb_bread(sb, 0);
-	if (bh == NULL) {
-		fat_msg(sb, KERN_ERR, "unable to read boot sector "
-			"to mark fs as dirty");
-		return;
-	}
 
-	b = (struct fat_boot_sector *) bh->b_data;
+	if (dirty)
+		newstate = sbi->state | FAT_STATE_DIRTY;
+	else
+		newstate = sbi->state & ~FAT_STATE_DIRTY;
 
-	if (is_fat32(sbi)) {
-		if (set)
-			b->fat32.state |= FAT_STATE_DIRTY;
-		else
-			b->fat32.state &= ~FAT_STATE_DIRTY;
-	} else /* fat 16 and 12 */ {
-		if (set)
-			b->fat16.state |= FAT_STATE_DIRTY;
-		else
-			b->fat16.state &= ~FAT_STATE_DIRTY;
-	}
+	/* do nothing if state is same */
+	if (newstate == sbi->state)
+		return;
+	mutex_lock(&sbi->bootsec_lock);
+	if (newstate == READ_ONCE(sbi->state))
+		goto unlock;
 
-	mark_buffer_dirty(bh);
-	sync_dirty_buffer(bh);
-	brelse(bh);
+	b = (struct fat_boot_sector *) sbi->boot_bh->b_data;
+	if (is_fat32(sbi))
+		b->fat32.state = newstate;
+	else /* fat 16 and 12 */
+		b->fat16.state = newstate;
+
+	mark_buffer_dirty(sbi->boot_bh);
+	sync_dirty_buffer(sbi->boot_bh);
+	sbi->state = newstate;
+unlock:
+	mutex_unlock(&sbi->bootsec_lock);
 }
+EXPORT_SYMBOL_GPL(fat_set_state);
 
 static void fat_reset_iocharset(struct fat_mount_options *opts)
 {
@@ -731,7 +724,8 @@ static void fat_put_super(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 
-	fat_set_state(sb, 0, 0);
+	fat_set_state(sb, false);
+	brelse(sbi->boot_bh);
 
 	iput(sbi->fsinfo_inode);
 	iput(sbi->fat_inode);
@@ -799,6 +793,15 @@ static void __exit fat_destroy_inodecache(void)
 	kmem_cache_destroy(fat_inode_cachep);
 }
 
+static void fat_warn_volume_dirty(struct super_block *sb)
+{
+	struct msdos_sb_info *sbi = MSDOS_SB(sb);
+
+	if (sbi->dirty)
+		fat_msg(sb, KERN_WARNING,
+			"Volume was not properly unmounted. Some data may be corrupt. Please run fsck.");
+}
+
 static int fat_remount(struct super_block *sb, int *flags, char *data)
 {
 	bool new_rdonly;
@@ -811,9 +814,9 @@ static int fat_remount(struct super_block *sb, int *flags, char *data)
 	new_rdonly = *flags & SB_RDONLY;
 	if (new_rdonly != sb_rdonly(sb)) {
 		if (new_rdonly)
-			fat_set_state(sb, 0, 0);
+			fat_set_state(sb, false);
 		else
-			fat_set_state(sb, 1, 1);
+			fat_warn_volume_dirty(sb);
 	}
 	return 0;
 }
@@ -856,6 +859,7 @@ static int __fat_write_inode(struct inode *inode, int wait)
 	if (inode->i_ino == MSDOS_ROOT_INO)
 		return 0;
 
+	fat_set_state(sb, true);
 retry:
 	i_pos = fat_i_pos_read(sbi, inode);
 	if (!i_pos)
@@ -1604,7 +1608,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 {
 	struct inode *root_inode = NULL, *fat_inode = NULL;
 	struct inode *fsinfo_inode = NULL;
-	struct buffer_head *bh;
+	struct buffer_head *bh = NULL;
 	struct fat_bios_param_block bpb;
 	struct msdos_sb_info *sbi;
 	u16 logical_sector_size;
@@ -1657,7 +1661,6 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	if (error == -EINVAL && sbi->options.dos1xfloppy)
 		error = fat_read_static_bpb(sb,
 			(struct fat_boot_sector *)bh->b_data, silent, &bpb);
-	brelse(bh);
 
 	if (error == -EINVAL)
 		goto out_invalid;
@@ -1675,8 +1678,8 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	}
 
 	if (logical_sector_size > sb->s_blocksize) {
-		struct buffer_head *bh_resize;
-
+		brelse(bh);
+		bh = NULL;
 		if (!sb_set_blocksize(sb, logical_sector_size)) {
 			fat_msg(sb, KERN_ERR, "unable to set blocksize %u",
 			       logical_sector_size);
@@ -1684,15 +1687,15 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 		}
 
 		/* Verify that the larger boot sector is fully readable */
-		bh_resize = sb_bread(sb, 0);
-		if (bh_resize == NULL) {
+		bh = sb_bread(sb, 0);
+		if (bh == NULL) {
 			fat_msg(sb, KERN_ERR, "unable to read boot sector"
 			       " (logical sector size = %lu)",
 			       sb->s_blocksize);
 			goto out_fail;
 		}
-		brelse(bh_resize);
 	}
+	sbi->boot_bh = bh;
 
 	mutex_init(&sbi->s_lock);
 	sbi->cluster_size = sb->s_blocksize * sbi->sec_per_clus;
@@ -1783,9 +1786,11 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 
 	/* some OSes set FAT_STATE_DIRTY and clean it on unmount. */
 	if (is_fat32(sbi))
-		sbi->dirty = bpb.fat32_state & FAT_STATE_DIRTY;
+		sbi->state = bpb.fat32_state;
 	else /* fat 16 or 12 */
-		sbi->dirty = bpb.fat16_state & FAT_STATE_DIRTY;
+		sbi->state = bpb.fat16_state;
+	sbi->dirty = sbi->state & FAT_STATE_DIRTY;
+	mutex_init(&sbi->bootsec_lock);
 
 	/* check that FAT table does not overflow */
 	fat_clusters = calc_fat_clusters(sb);
@@ -1881,7 +1886,9 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 					"the device does not support discard");
 	}
 
-	fat_set_state(sb, 1, 0);
+	if (!sb_rdonly(sb))
+		fat_warn_volume_dirty(sb);
+
 	return 0;
 
 out_invalid:
@@ -1897,6 +1904,7 @@ int fat_fill_super(struct super_block *sb, void *data, int silent, int isvfat,
 	unload_nls(sbi->nls_io);
 	unload_nls(sbi->nls_disk);
 	fat_reset_iocharset(&sbi->options);
+	brelse(bh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
 	return error;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index 18a50a46b57f..497f78484902 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -83,6 +83,7 @@ int fat_clusters_flush(struct super_block *sb)
 		       le32_to_cpu(fsinfo->signature2),
 		       sbi->fsinfo_sector);
 	} else {
+		fat_set_state(sb, true);
 		if (sbi->free_clusters != -1)
 			fsinfo->free_clusters = cpu_to_le32(sbi->free_clusters);
 		if (sbi->prev_free != -1)
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index efba301d68ae..ae84e2114802 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -509,6 +509,7 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 	}
 	inode_inc_iversion(new_dir);
 
+	fat_set_state(new_dir->i_sb, true);
 	fat_detach(old_inode);
 	fat_attach(old_inode, new_i_pos);
 	if (is_hid)
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5369d82e0bfb..966f43d48bf5 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -944,6 +944,7 @@ static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	}
 	inode_inc_iversion(new_dir);
 
+	fat_set_state(sb, true);
 	fat_detach(old_inode);
 	fat_attach(old_inode, new_i_pos);
 	if (IS_DIRSYNC(new_dir)) {
-- 
2.31.1

