Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31F2163CD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 06:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgBSF5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 00:57:45 -0500
Received: from mx06.melco.co.jp ([192.218.140.146]:52926 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgBSF5o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 00:57:44 -0500
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id 151DE3A34B9;
        Wed, 19 Feb 2020 14:57:42 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 48Mn7V05j2zRjx3;
        Wed, 19 Feb 2020 14:57:42 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr06.melco.co.jp (Postfix) with ESMTP id 48Mn7T6vD5zRjsk;
        Wed, 19 Feb 2020 14:57:41 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 48Mn7V01r7zRkG2;
        Wed, 19 Feb 2020 14:57:42 +0900 (JST)
Received: from tux532.tad.melco.co.jp (unknown [133.141.243.226])
        by mf04.melco.co.jp (Postfix) with ESMTP id 48Mn7T6ScJzRkFt;
        Wed, 19 Feb 2020 14:57:41 +0900 (JST)
Received:  from tux532.tad.melco.co.jp
        by tux532.tad.melco.co.jp (unknown) with ESMTP id 01J5vfcO013950;
        Wed, 19 Feb 2020 14:57:41 +0900
Received: from tux390.tad.melco.co.jp (tux390.tad.melco.co.jp [127.0.0.1])
        by postfix.imss70 (Postfix) with ESMTP id A026617E075;
        Wed, 19 Feb 2020 14:57:41 +0900 (JST)
Received: from tux554.tad.melco.co.jp (tadpost1.tad.melco.co.jp [10.168.7.223])
        by tux390.tad.melco.co.jp (Postfix) with ESMTP id 938A717E073;
        Wed, 19 Feb 2020 14:57:41 +0900 (JST)
Received: from tux554.tad.melco.co.jp
        by tux554.tad.melco.co.jp (unknown) with ESMTP id 01J5vfbi017445;
        Wed, 19 Feb 2020 14:57:41 +0900
From:   Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] staging: exfat: remove symlink feature.
Date:   Wed, 19 Feb 2020 14:57:27 +0900
Message-Id: <20200219055727.12867-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove symlink feature completely.

Becouse
-Uses reserved areas(defined in the Microsoft exfat specification), causing future incompatibilities.
-Not described in Microsoft exfat specifications or SD standards.
-For REMOVABLE media, causes incompatibility with other implementations.
-Not supported by other major exfat drivers.
-Not implemented symlink feature in linux FAT/VFAT.

Remove this feature completely because of serious media compatibility issues.
(Can't enable even with CONFIG)

If you have any questions about this patch, please let me know.

Reviewed-by: Takahiro Mori <Mori.Takahiro@ab.MitsubishiElectric.co.jp>
Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
---
 drivers/staging/exfat/exfat_super.c | 450 ----------------------------
 1 file changed, 450 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index b398114c2604..c7bc07e91c45 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -660,375 +660,6 @@ static int ffsCreateFile(struct inode *inode, char *path, u8 mode,
 	return ret;
 }
 
-static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
-		       u64 count, u64 *rcount)
-{
-	s32 offset, sec_offset, clu_offset;
-	u32 clu;
-	int ret = 0;
-	sector_t LogSector;
-	u64 oneblkread, read_bytes;
-	struct buffer_head *tmp_bh = NULL;
-	struct super_block *sb = inode->i_sb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	/* check the validity of the given file id */
-	if (!fid)
-		return -EINVAL;
-
-	/* check the validity of pointer parameters */
-	if (!buffer)
-		return -EINVAL;
-
-	/* acquire the lock for file system critical section */
-	mutex_lock(&p_fs->v_mutex);
-
-	/* check if the given file ID is opened */
-	if (fid->type != TYPE_FILE) {
-		ret = -EPERM;
-		goto out;
-	}
-
-	if (fid->rwoffset > fid->size)
-		fid->rwoffset = fid->size;
-
-	if (count > (fid->size - fid->rwoffset))
-		count = fid->size - fid->rwoffset;
-
-	if (count == 0) {
-		if (rcount)
-			*rcount = 0;
-		ret = 0;
-		goto out;
-	}
-
-	read_bytes = 0;
-
-	while (count > 0) {
-		clu_offset = (s32)(fid->rwoffset >> p_fs->cluster_size_bits);
-		clu = fid->start_clu;
-
-		if (fid->flags == 0x03) {
-			clu += clu_offset;
-		} else {
-			/* hint information */
-			if ((clu_offset > 0) && (fid->hint_last_off > 0) &&
-			    (clu_offset >= fid->hint_last_off)) {
-				clu_offset -= fid->hint_last_off;
-				clu = fid->hint_last_clu;
-			}
-
-			while (clu_offset > 0) {
-				/* clu = exfat_fat_read(sb, clu); */
-				if (exfat_fat_read(sb, clu, &clu) == -1) {
-					ret = -EIO;
-					goto out;
-				}
-
-				clu_offset--;
-			}
-		}
-
-		/* hint information */
-		fid->hint_last_off = (s32)(fid->rwoffset >>
-					   p_fs->cluster_size_bits);
-		fid->hint_last_clu = clu;
-
-		/* byte offset in cluster */
-		offset = (s32)(fid->rwoffset & (p_fs->cluster_size - 1));
-
-		/* sector offset in cluster */
-		sec_offset = offset >> p_bd->sector_size_bits;
-
-		/* byte offset in sector */
-		offset &= p_bd->sector_size_mask;
-
-		LogSector = START_SECTOR(clu) + sec_offset;
-
-		oneblkread = (u64)(p_bd->sector_size - offset);
-		if (oneblkread > count)
-			oneblkread = count;
-
-		if ((offset == 0) && (oneblkread == p_bd->sector_size)) {
-			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
-			    0)
-				goto err_out;
-			memcpy((char *)buffer + read_bytes,
-			       (char *)tmp_bh->b_data, (s32)oneblkread);
-		} else {
-			if (sector_read(sb, LogSector, &tmp_bh, 1) !=
-			    0)
-				goto err_out;
-			memcpy((char *)buffer + read_bytes,
-			       (char *)tmp_bh->b_data + offset,
-			       (s32)oneblkread);
-		}
-		count -= oneblkread;
-		read_bytes += oneblkread;
-		fid->rwoffset += oneblkread;
-	}
-	brelse(tmp_bh);
-
-/* How did this ever work and not leak a brlse()?? */
-err_out:
-	/* set the size of read bytes */
-	if (rcount)
-		*rcount = read_bytes;
-
-	if (p_fs->dev_ejected)
-		ret = -EIO;
-
-out:
-	/* release the lock for file system critical section */
-	mutex_unlock(&p_fs->v_mutex);
-
-	return ret;
-}
-
-static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
-			void *buffer, u64 count, u64 *wcount)
-{
-	bool modified = false;
-	s32 offset, sec_offset, clu_offset;
-	s32 num_clusters, num_alloc, num_alloced = (s32)~0;
-	int ret = 0;
-	u32 clu, last_clu;
-	sector_t LogSector;
-	u64 oneblkwrite, write_bytes;
-	struct chain_t new_clu;
-	struct timestamp_t tm;
-	struct dentry_t *ep, *ep2;
-	struct entry_set_cache_t *es = NULL;
-	struct buffer_head *tmp_bh = NULL;
-	struct super_block *sb = inode->i_sb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	/* check the validity of the given file id */
-	if (!fid)
-		return -EINVAL;
-
-	/* check the validity of pointer parameters */
-	if (!buffer)
-		return -EINVAL;
-
-	/* acquire the lock for file system critical section */
-	mutex_lock(&p_fs->v_mutex);
-
-	/* check if the given file ID is opened */
-	if (fid->type != TYPE_FILE) {
-		ret = -EPERM;
-		goto out;
-	}
-
-	if (fid->rwoffset > fid->size)
-		fid->rwoffset = fid->size;
-
-	if (count == 0) {
-		if (wcount)
-			*wcount = 0;
-		ret = 0;
-		goto out;
-	}
-
-	fs_set_vol_flags(sb, VOL_DIRTY);
-
-	if (fid->size == 0)
-		num_clusters = 0;
-	else
-		num_clusters = (s32)((fid->size - 1) >>
-				     p_fs->cluster_size_bits) + 1;
-
-	write_bytes = 0;
-
-	while (count > 0) {
-		clu_offset = (s32)(fid->rwoffset >> p_fs->cluster_size_bits);
-		clu = fid->start_clu;
-		last_clu = fid->start_clu;
-
-		if (fid->flags == 0x03) {
-			if ((clu_offset > 0) && (clu != CLUSTER_32(~0))) {
-				last_clu += clu_offset - 1;
-
-				if (clu_offset == num_clusters)
-					clu = CLUSTER_32(~0);
-				else
-					clu += clu_offset;
-			}
-		} else {
-			/* hint information */
-			if ((clu_offset > 0) && (fid->hint_last_off > 0) &&
-			    (clu_offset >= fid->hint_last_off)) {
-				clu_offset -= fid->hint_last_off;
-				clu = fid->hint_last_clu;
-			}
-
-			while ((clu_offset > 0) && (clu != CLUSTER_32(~0))) {
-				last_clu = clu;
-				/* clu = exfat_fat_read(sb, clu); */
-				if (exfat_fat_read(sb, clu, &clu) == -1) {
-					ret = -EIO;
-					goto out;
-				}
-				clu_offset--;
-			}
-		}
-
-		if (clu == CLUSTER_32(~0)) {
-			num_alloc = (s32)((count - 1) >>
-					  p_fs->cluster_size_bits) + 1;
-			new_clu.dir = (last_clu == CLUSTER_32(~0)) ?
-					CLUSTER_32(~0) : last_clu + 1;
-			new_clu.size = 0;
-			new_clu.flags = fid->flags;
-
-			/* (1) allocate a chain of clusters */
-			num_alloced = exfat_alloc_cluster(sb,
-							  num_alloc,
-							  &new_clu);
-			if (num_alloced == 0)
-				break;
-			if (num_alloced < 0) {
-				ret = num_alloced;
-				goto out;
-			}
-
-			/* (2) append to the FAT chain */
-			if (last_clu == CLUSTER_32(~0)) {
-				if (new_clu.flags == 0x01)
-					fid->flags = 0x01;
-				fid->start_clu = new_clu.dir;
-				modified = true;
-			} else {
-				if (new_clu.flags != fid->flags) {
-					exfat_chain_cont_cluster(sb,
-								 fid->start_clu,
-								 num_clusters);
-					fid->flags = 0x01;
-					modified = true;
-				}
-				if (new_clu.flags == 0x01)
-					exfat_fat_write(sb, last_clu, new_clu.dir);
-			}
-
-			num_clusters += num_alloced;
-			clu = new_clu.dir;
-		}
-
-		/* hint information */
-		fid->hint_last_off = (s32)(fid->rwoffset >>
-					   p_fs->cluster_size_bits);
-		fid->hint_last_clu = clu;
-
-		/* byte offset in cluster   */
-		offset = (s32)(fid->rwoffset & (p_fs->cluster_size - 1));
-
-		/* sector offset in cluster */
-		sec_offset = offset >> p_bd->sector_size_bits;
-
-		/* byte offset in sector    */
-		offset &= p_bd->sector_size_mask;
-
-		LogSector = START_SECTOR(clu) + sec_offset;
-
-		oneblkwrite = (u64)(p_bd->sector_size - offset);
-		if (oneblkwrite > count)
-			oneblkwrite = count;
-
-		if ((offset == 0) && (oneblkwrite == p_bd->sector_size)) {
-			if (sector_read(sb, LogSector, &tmp_bh, 0) !=
-			    0)
-				goto err_out;
-			memcpy((char *)tmp_bh->b_data,
-			       (char *)buffer + write_bytes, (s32)oneblkwrite);
-			if (sector_write(sb, LogSector, tmp_bh, 0) !=
-			    0) {
-				brelse(tmp_bh);
-				goto err_out;
-			}
-		} else {
-			if ((offset > 0) ||
-			    ((fid->rwoffset + oneblkwrite) < fid->size)) {
-				if (sector_read(sb, LogSector, &tmp_bh, 1) !=
-				    0)
-					goto err_out;
-			} else {
-				if (sector_read(sb, LogSector, &tmp_bh, 0) !=
-				    0)
-					goto err_out;
-			}
-
-			memcpy((char *)tmp_bh->b_data + offset,
-			       (char *)buffer + write_bytes, (s32)oneblkwrite);
-			if (sector_write(sb, LogSector, tmp_bh, 0) !=
-			    0) {
-				brelse(tmp_bh);
-				goto err_out;
-			}
-		}
-
-		count -= oneblkwrite;
-		write_bytes += oneblkwrite;
-		fid->rwoffset += oneblkwrite;
-
-		fid->attr |= ATTR_ARCHIVE;
-
-		if (fid->size < fid->rwoffset) {
-			fid->size = fid->rwoffset;
-			modified = true;
-		}
-	}
-
-	brelse(tmp_bh);
-
-	/* (3) update the direcoty entry */
-	es = get_entry_set_in_dir(sb, &fid->dir, fid->entry,
-				  ES_ALL_ENTRIES, &ep);
-	if (!es)
-		goto err_out;
-	ep2 = ep + 1;
-
-	exfat_set_entry_time(ep, tm_current(&tm), TM_MODIFY);
-	exfat_set_entry_attr(ep, fid->attr);
-
-	if (modified) {
-		if (exfat_get_entry_flag(ep2) != fid->flags)
-			exfat_set_entry_flag(ep2, fid->flags);
-
-		if (exfat_get_entry_size(ep2) != fid->size)
-			exfat_set_entry_size(ep2, fid->size);
-
-		if (exfat_get_entry_clu0(ep2) != fid->start_clu)
-			exfat_set_entry_clu0(ep2, fid->start_clu);
-	}
-
-	update_dir_checksum_with_entry_set(sb, es);
-	release_entry_set(es);
-
-#ifndef CONFIG_STAGING_EXFAT_DELAYED_SYNC
-	fs_sync(sb, true);
-	fs_set_vol_flags(sb, VOL_CLEAN);
-#endif
-
-err_out:
-	/* set the size of written bytes */
-	if (wcount)
-		*wcount = write_bytes;
-
-	if (num_alloced == 0)
-		ret = -ENOSPC;
-
-	else if (p_fs->dev_ejected)
-		ret = -EIO;
-
-out:
-	/* release the lock for file system critical section */
-	mutex_unlock(&p_fs->v_mutex);
-
-	return ret;
-}
-
 static int ffsTruncateFile(struct inode *inode, u64 old_size, u64 new_size)
 {
 	s32 num_clusters;
@@ -2273,7 +1904,6 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 	int err;
 	struct file_id_t fid;
 	loff_t i_pos;
-	u64 ret;
 	mode_t i_mode;
 
 	__lock_super(sb);
@@ -2295,18 +1925,6 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
 	}
 
 	i_mode = inode->i_mode;
-	if (S_ISLNK(i_mode) && !EXFAT_I(inode)->target) {
-		EXFAT_I(inode)->target = kmalloc(i_size_read(inode) + 1,
-						 GFP_KERNEL);
-		if (!EXFAT_I(inode)->target) {
-			err = -ENOMEM;
-			goto error;
-		}
-		ffsReadFile(dir, &fid, EXFAT_I(inode)->target,
-			    i_size_read(inode), &ret);
-		*(EXFAT_I(inode)->target + i_size_read(inode)) = '\0';
-	}
-
 	alias = d_find_alias(inode);
 	if (alias && !exfat_d_anon_disconn(alias)) {
 		BUG_ON(d_unhashed(alias));
@@ -2398,73 +2016,6 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_symlink(struct inode *dir, struct dentry *dentry,
-			 const char *target)
-{
-	struct super_block *sb = dir->i_sb;
-	struct timespec64 curtime;
-	struct inode *inode;
-	struct file_id_t fid;
-	loff_t i_pos;
-	int err;
-	u64 len = (u64)strlen(target);
-	u64 ret;
-
-	__lock_super(sb);
-
-	pr_debug("%s entered\n", __func__);
-
-	err = ffsCreateFile(dir, (u8 *)dentry->d_name.name, FM_SYMLINK, &fid);
-	if (err)
-		goto out;
-
-
-	err = ffsWriteFile(dir, &fid, (char *)target, len, &ret);
-
-	if (err) {
-		ffsRemoveFile(dir, &fid);
-		goto out;
-	}
-
-	INC_IVERSION(dir);
-	curtime = current_time(dir);
-	dir->i_ctime = curtime;
-	dir->i_mtime = curtime;
-	dir->i_atime = curtime;
-	if (IS_DIRSYNC(dir))
-		(void)exfat_sync_inode(dir);
-	else
-		mark_inode_dirty(dir);
-
-	i_pos = ((loff_t)fid.dir.dir << 32) | (fid.entry & 0xffffffff);
-
-	inode = exfat_build_inode(sb, &fid, i_pos);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		goto out;
-	}
-	INC_IVERSION(inode);
-	curtime = current_time(inode);
-	inode->i_mtime = curtime;
-	inode->i_atime = curtime;
-	inode->i_ctime = curtime;
-	/* timestamp is already written, so mark_inode_dirty() is unneeded. */
-
-	EXFAT_I(inode)->target = kmemdup(target, len + 1, GFP_KERNEL);
-	if (!EXFAT_I(inode)->target) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	dentry->d_time = GET_IVERSION(dentry->d_parent->d_inode);
-	d_instantiate(dentry, inode);
-
-out:
-	__unlock_super(sb);
-	pr_debug("%s exited\n", __func__);
-	return err;
-}
-
 static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
@@ -2838,7 +2389,6 @@ static const struct inode_operations exfat_dir_inode_operations = {
 	.create        = exfat_create,
 	.lookup        = exfat_lookup,
 	.unlink        = exfat_unlink,
-	.symlink       = exfat_symlink,
 	.mkdir         = exfat_mkdir,
 	.rmdir         = exfat_rmdir,
 	.rename        = exfat_rename,
-- 
2.25.0

