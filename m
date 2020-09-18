Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F5270746
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgIRUph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 16:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgIRUph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:45:37 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A36C0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2020 13:45:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJNGB-001GeS-It
        for linux-fsdevel@vger.kernel.org; Fri, 18 Sep 2020 20:45:35 +0000
Date:   Fri, 18 Sep 2020 21:45:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] reduce boilerplate in fsid handling
Message-ID: <20200918204535.GA3421308@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Get rid of boilerplate in most of ->statfs()
instances...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 74df32be4c6a..124855b3324d 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -258,8 +258,7 @@ static int v9fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 			buf->f_bavail = rs.bavail;
 			buf->f_files = rs.files;
 			buf->f_ffree = rs.ffree;
-			buf->f_fsid.val[0] = rs.fsid & 0xFFFFFFFFUL;
-			buf->f_fsid.val[1] = (rs.fsid >> 32) & 0xFFFFFFFFUL;
+			buf->f_fsid = u64_to_fsid(rs.fsid);
 			buf->f_namelen = rs.namelen;
 		}
 		if (res != -ENOSYS)
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index d553bb5bc17a..bdbd26e571ed 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -210,8 +210,7 @@ static int adfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = sbi->s_namelen;
 	buf->f_bsize   = sb->s_blocksize;
 	buf->f_ffree   = (long)(buf->f_bfree * buf->f_files) / (long)buf->f_blocks;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 47107c6712a6..890b44874f0f 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -620,8 +620,7 @@ affs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks  = AFFS_SB(sb)->s_partition_size - AFFS_SB(sb)->s_reserved;
 	buf->f_bfree   = free;
 	buf->f_bavail  = free;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 	buf->f_namelen = AFFSNAMEMAX;
 	return 0;
 }
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 2482032021ca..c1ba13d19024 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -963,8 +963,7 @@ befs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = buf->f_bfree;
 	buf->f_files = 0;	/* UNKNOWN */
 	buf->f_ffree = 0;	/* UNKNOWN */
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = BEFS_NAME_LEN;
 
 	befs_debug(sb, "<--- %s", __func__);
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index f8ce1368218b..3ac7611ef7ce 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -229,8 +229,7 @@ static int bfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bfree = buf->f_bavail = info->si_freeb;
 	buf->f_files = info->si_lasti + 1 - BFS_ROOT_INO;
 	buf->f_ffree = info->si_freei;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = BFS_NAMELEN;
 	return 0;
 }
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7ec0e6d03d10..cafb252a9d98 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -104,8 +104,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	       le64_to_cpu(*((__le64 *)&monc->monmap->fsid + 1));
 	mutex_unlock(&monc->mutex);
 
-	buf->f_fsid.val[0] = fsid & 0xffffffff;
-	buf->f_fsid.val[1] = fsid >> 32;
+	buf->f_fsid = u64_to_fsid(fsid);
 
 	return 0;
 }
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 912308600d39..4b90cfd1ec36 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -690,8 +690,7 @@ static int cramfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = 0;
 	buf->f_files = CRAMFS_SB(sb)->files;
 	buf->f_ffree = 0;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = CRAMFS_MAXPATHLEN;
 	return 0;
 }
diff --git a/fs/efs/super.c b/fs/efs/super.c
index a4a945d0ac6a..62b155b9366b 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -342,8 +342,7 @@ static int efs_statfs(struct dentry *dentry, struct kstatfs *buf) {
 			sbi->inode_blocks *
 			(EFS_BLOCKSIZE / sizeof(struct efs_dinode));
 	buf->f_ffree   = sbi->inode_free;	/* free inodes */
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 	buf->f_namelen = EFS_MAXNAMELEN;	/* max filename length */
 
 	return 0;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ddaa516c008a..744089ab134c 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -563,8 +563,7 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_namelen = EROFS_NAME_LEN;
 
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 	return 0;
 }
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 3b6a1659892f..ea17e8ed5067 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -89,8 +89,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = sbi->num_clusters - 2; /* clu 0 & 1 */
 	buf->f_bfree = buf->f_blocks - sbi->used_clusters;
 	buf->f_bavail = buf->f_bfree;
-	buf->f_fsid.val[0] = (unsigned int)id;
-	buf->f_fsid.val[1] = (unsigned int)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	/* Unicode utf16 255 characters */
 	buf->f_namelen = EXFAT_MAX_FILE_LEN * NLS_MAX_CHARSET_SIZE;
 	return 0;
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index dda860562ca3..4911c59679bb 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1455,8 +1455,7 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 	buf->f_namelen = EXT2_NAME_LEN;
 	fsid = le64_to_cpup((void *)es->s_uuid) ^
 	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
-	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
-	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
+	buf->f_fsid = u64_to_fsid(fsid);
 	spin_unlock(&sbi->s_lock);
 	return 0;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0907f907c47d..eef0a7d81e0d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5787,8 +5787,7 @@ static int ext4_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_namelen = EXT4_NAME_LEN;
 	fsid = le64_to_cpup((void *)es->s_uuid) ^
 	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
-	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
-	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
+	buf->f_fsid = u64_to_fsid(fsid);
 
 #ifdef CONFIG_QUOTA
 	if (ext4_test_inode_flag(dentry->d_inode, EXT4_INODE_PROJINHERIT) &&
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dfa072fa8081..088872f4e568 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1422,8 +1422,7 @@ static int f2fs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 
 	buf->f_namelen = F2FS_NAME_LEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 
 #ifdef CONFIG_QUOTA
 	if (is_inode_flag_set(dentry->d_inode, FI_PROJ_INHERIT) &&
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a0cf99debb1e..bab9b202b496 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -836,8 +836,7 @@ static int fat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = sbi->max_cluster - FAT_START_ENT;
 	buf->f_bfree = sbi->free_clusters;
 	buf->f_bavail = sbi->free_clusters;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen =
 		(sbi->options.isvfat ? FAT_LFN_LEN : 12) * NLS_MAX_CHARSET_SIZE;
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index c33324686d89..44d07c9e3a7f 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -104,8 +104,7 @@ static int hfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = buf->f_bfree;
 	buf->f_files = HFS_SB(sb)->fs_ablocks;
 	buf->f_ffree = HFS_SB(sb)->free_ablocks;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = HFS_NAMELEN;
 
 	return 0;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 129dca3f4b78..807119ae5adf 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -320,8 +320,7 @@ static int hfsplus_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = buf->f_bfree;
 	buf->f_files = 0xFFFFFFFF;
 	buf->f_ffree = 0xFFFFFFFF - sbi->next_cnid;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = HFSPLUS_MAX_STRLEN;
 
 	return 0;
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 0a677a9aaf34..a7dbfc892022 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -192,8 +192,7 @@ static int hpfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = sbi->sb_n_free;
 	buf->f_files = sbi->sb_dirband_size / 4;
 	buf->f_ffree = hpfs_get_free_dnodes(s);
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = 254;
 
 	hpfs_unlock(s);
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 78f5c96c76f3..ec90773527ee 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1038,8 +1038,7 @@ static int isofs_statfs (struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail = 0;
 	buf->f_files = ISOFS_SB(sb)->s_ninodes;
 	buf->f_ffree = 0;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	buf->f_namelen = NAME_MAX;
 	return 0;
 }
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 7b09a9158e40..34f546404aa1 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -383,8 +383,7 @@ static int minix_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = sbi->s_ninodes;
 	buf->f_ffree = minix_count_free_inodes(sb);
 	buf->f_namelen = sbi->s_namelen;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 2eee5fb1a882..4abd928b0bc8 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -651,8 +651,7 @@ static int nilfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = nmaxinodes;
 	buf->f_ffree = nfreeinodes;
 	buf->f_namelen = NILFS_NAME_LEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 7dc3bc604f78..0d7e948cb29c 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2643,8 +2643,7 @@ static int ntfs_statfs(struct dentry *dentry, struct kstatfs *sfs)
 	 * the least significant 32-bits in f_fsid[0] and the most significant
 	 * 32-bits in f_fsid[1].
 	 */
-	sfs->f_fsid.val[0] = vol->serial_no & 0xffffffff;
-	sfs->f_fsid.val[1] = (vol->serial_no >> 32) & 0xffffffff;
+	sfs->f_fsid = u64_to_fsid(vol->serial_no);
 	/* Maximum length of filenames. */
 	sfs->f_namelen	   = NTFS_MAX_NAME_LEN;
 	return 0;
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index b76ec6b88ded..68aa38a48308 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -282,8 +282,7 @@ static int omfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = sbi->s_num_blocks;
 	buf->f_files = sbi->s_num_blocks;
 	buf->f_namelen = OMFS_NAMELEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 
 	buf->f_bfree = buf->f_bavail = buf->f_ffree =
 		omfs_count_free(s);
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9..3fb7fc819b4f 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -137,8 +137,7 @@ static int qnx4_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bfree   = qnx4_count_free_blocks(sb);
 	buf->f_bavail  = buf->f_bfree;
 	buf->f_namelen = QNX4_NAME_MAX;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 755293c8c71a..61191f7bdf62 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -166,8 +166,7 @@ static int qnx6_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree   = fs32_to_cpu(sbi, sbi->sb->sb_free_inodes);
 	buf->f_bavail  = buf->f_bfree;
 	buf->f_namelen = QNX6_LONG_NAME_MAX;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid    = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792..d69c8e4f4973 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -415,8 +415,7 @@ static int romfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bfree = buf->f_bavail = buf->f_ffree;
 	buf->f_blocks =
 		(romfs_maxsize(dentry->d_sb) + ROMBSIZE - 1) >> ROMBSBITS;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	return 0;
 }
 
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 0cc4ceec0562..d6c6593ec169 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -380,8 +380,7 @@ static int squashfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = msblk->inodes;
 	buf->f_ffree = 0;
 	buf->f_namelen = SQUASHFS_NAME_LEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
index 02b1d9d0c182..be47263b8605 100644
--- a/fs/sysv/inode.c
+++ b/fs/sysv/inode.c
@@ -98,8 +98,7 @@ static int sysv_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_files = sbi->s_ninodes;
 	buf->f_ffree = sysv_count_free_inodes(sb);
 	buf->f_namelen = SYSV_NAMELEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 	return 0;
 }
 
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..d40ecaf3c2c2 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -2411,8 +2411,7 @@ static int udf_statfs(struct dentry *dentry, struct kstatfs *buf)
 			+ buf->f_bfree;
 	buf->f_ffree = buf->f_bfree;
 	buf->f_namelen = UDF_NAME_LEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 
 	return 0;
 }
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index e3b69fb280e8..983558b572c7 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1431,8 +1431,7 @@ static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		? (buf->f_bfree - uspi->s_root_blocks) : 0;
 	buf->f_files = uspi->s_ncg * uspi->s_ipg;
 	buf->f_namelen = UFS_MAXNAMLEN;
-	buf->f_fsid.val[0] = (u32)id;
-	buf->f_fsid.val[1] = (u32)(id >> 32);
+	buf->f_fsid = u64_to_fsid(id);
 
 	mutex_unlock(&UFS_SB(sb)->s_lock);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 71ac6c1cdc36..2e04dfc373c1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -794,8 +794,7 @@ xfs_fs_statfs(
 	statp->f_namelen = MAXNAMELEN - 1;
 
 	id = huge_encode_dev(mp->m_ddev_targp->bt_dev);
-	statp->f_fsid.val[0] = (u32)id;
-	statp->f_fsid.val[1] = (u32)(id >> 32);
+	statp->f_fsid = u64_to_fsid(id);
 
 	icount = percpu_counter_sum(&mp->m_icount);
 	ifree = percpu_counter_sum(&mp->m_ifree);
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8ec7c8f109d7..763f48541c68 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -932,8 +932,7 @@ static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	fsid = le64_to_cpup((void *)sbi->s_uuid.b) ^
 		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));
-	buf->f_fsid.val[0] = (u32)fsid;
-	buf->f_fsid.val[1] = (u32)(fsid >> 32);
+	buf->f_fsid = u64_to_fsid(fsid);
 
 	return 0;
 }
diff --git a/include/linux/statfs.h b/include/linux/statfs.h
index fac4356ea1bf..20f695b90aab 100644
--- a/include/linux/statfs.h
+++ b/include/linux/statfs.h
@@ -45,4 +45,9 @@ struct kstatfs {
 struct dentry;
 extern int vfs_get_fsid(struct dentry *dentry, __kernel_fsid_t *fsid);
 
+static inline __kernel_fsid_t u64_to_fsid(u64 v)
+{
+	return (__kernel_fsid_t){.val = {(u32)v, (u32)(v>>32)}};
+}
+
 #endif
