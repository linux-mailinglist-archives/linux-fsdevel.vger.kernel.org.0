Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A964F203
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 01:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFUX7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 19:59:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50420 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfFUX7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:59:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNtGUN052800;
        Fri, 21 Jun 2019 23:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=oCZE7gxsELn4jhNNrd+diMXq2+uBOFyKuKlNVnTY4+E=;
 b=aHrzmxSgg/Cnd67OxWPjvhnH1Q6G6xNR2JN6AcUxhGeZWGntWftewhtDLB9O/NSuozVc
 D9zvsW5EsKId3h02b2Ss8/jGoSmiyN5GQRBPS1Ha0jopYgas//fbLY8chPXq3GrDUtJF
 JttFCscY3EZS3XejPxus7Aau0r30X5FA+zgbcBjx53Ut5HIjgJEIqaOTZxEEfoBdsjcY
 HG4vqNbmGsOucM6gAWhOxhX+mBZalbwvTdwZcxv48aTC3GVnbxwFEyl+QiQwCL6/wrLi
 ucWHjlk8DbdpaXawZWUiuxEsWgmbnLsx9OE4z1JSNPVmFAbyQq+jXTk+uDlCsDF2MC38 /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2t7809rt0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:58:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNtLY5105687;
        Fri, 21 Jun 2019 23:56:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2t77ypet09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 23:56:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5LNuSHU107137;
        Fri, 21 Jun 2019 23:56:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t77ypet04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:56:28 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LNuOhH020341;
        Fri, 21 Jun 2019 23:56:24 GMT
Received: from localhost (/10.159.131.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 16:56:24 -0700
Subject: [PATCH 1/4] vfs: create a generic checking function for
 FS_IOC_SETFLAGS
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk
Cc:     cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Date:   Fri, 21 Jun 2019 16:56:21 -0700
Message-ID: <156116138140.1664814.9610454726122206157.stgit@magnolia>
In-Reply-To: <156116136742.1664814.17093419199766834123.stgit@magnolia>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Create a generic checking function for the incoming FS_IOC_SETFLAGS flag
values so that we can standardize the implementations that follow ext4's
flag values.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/ioctl.c    |   13 +++++--------
 fs/efivarfs/file.c  |   18 +++++++++++++-----
 fs/ext2/ioctl.c     |   16 ++++------------
 fs/ext4/ioctl.c     |   13 +++----------
 fs/f2fs/file.c      |    7 ++++---
 fs/gfs2/file.c      |   42 +++++++++++++++++++++++++++++-------------
 fs/hfsplus/ioctl.c  |   21 ++++++++++++---------
 fs/inode.c          |   17 +++++++++++++++++
 fs/jfs/ioctl.c      |   22 +++++++---------------
 fs/nilfs2/ioctl.c   |    9 ++-------
 fs/ocfs2/ioctl.c    |   13 +++----------
 fs/reiserfs/ioctl.c |   10 ++++------
 fs/ubifs/ioctl.c    |   13 +++----------
 include/linux/fs.h  |    2 ++
 14 files changed, 108 insertions(+), 108 deletions(-)


diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..f408aa93b0cf 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -187,7 +187,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	struct btrfs_inode *binode = BTRFS_I(inode);
 	struct btrfs_root *root = binode->root;
 	struct btrfs_trans_handle *trans;
-	unsigned int fsflags;
+	unsigned int fsflags, old_fsflags;
 	int ret;
 	const char *comp = NULL;
 	u32 binode_flags = binode->flags;
@@ -212,13 +212,10 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	inode_lock(inode);
 
 	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
-	if ((fsflags ^ btrfs_inode_flags_to_fsflags(binode->flags)) &
-	    (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
-		if (!capable(CAP_LINUX_IMMUTABLE)) {
-			ret = -EPERM;
-			goto out_unlock;
-		}
-	}
+	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
+	ret = vfs_ioc_setflags_check(inode, old_fsflags, fsflags);
+	if (ret)
+		goto out_unlock;
 
 	if (fsflags & FS_SYNC_FL)
 		binode_flags |= BTRFS_INODE_SYNC;
diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index 8e568428c88b..f4f6c1bec132 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -110,16 +110,22 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	return size;
 }
 
-static int
-efivarfs_ioc_getxflags(struct file *file, void __user *arg)
+static inline unsigned int efivarfs_getflags(struct inode *inode)
 {
-	struct inode *inode = file->f_mapping->host;
 	unsigned int i_flags;
 	unsigned int flags = 0;
 
 	i_flags = inode->i_flags;
 	if (i_flags & S_IMMUTABLE)
 		flags |= FS_IMMUTABLE_FL;
+	return flags;
+}
+
+static int
+efivarfs_ioc_getxflags(struct file *file, void __user *arg)
+{
+	struct inode *inode = file->f_mapping->host;
+	unsigned int flags = efivarfs_getflags(inode);
 
 	if (copy_to_user(arg, &flags, sizeof(flags)))
 		return -EFAULT;
@@ -132,6 +138,7 @@ efivarfs_ioc_setxflags(struct file *file, void __user *arg)
 	struct inode *inode = file->f_mapping->host;
 	unsigned int flags;
 	unsigned int i_flags = 0;
+	unsigned int oldflags = efivarfs_getflags(inode);
 	int error;
 
 	if (!inode_owner_or_capable(inode))
@@ -143,8 +150,9 @@ efivarfs_ioc_setxflags(struct file *file, void __user *arg)
 	if (flags & ~FS_IMMUTABLE_FL)
 		return -EOPNOTSUPP;
 
-	if (!capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
+	error = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (error)
+		return error;
 
 	if (flags & FS_IMMUTABLE_FL)
 		i_flags |= S_IMMUTABLE;
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 0367c0039e68..88b3b9720023 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -60,18 +60,10 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		oldflags = ei->i_flags;
 
-		/*
-		 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-		 * the relevant capability.
-		 *
-		 * This test looks nicer. Thanks to Pauline Middelink
-		 */
-		if ((flags ^ oldflags) & (EXT2_APPEND_FL | EXT2_IMMUTABLE_FL)) {
-			if (!capable(CAP_LINUX_IMMUTABLE)) {
-				inode_unlock(inode);
-				ret = -EPERM;
-				goto setflags_out;
-			}
+		ret = vfs_ioc_setflags_check(inode, oldflags, flags);
+		if (ret) {
+			inode_unlock(inode);
+			goto setflags_out;
 		}
 
 		flags = flags & EXT2_FL_USER_MODIFIABLE;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index e486e49b31ed..5126ee351a84 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -289,16 +289,9 @@ static int ext4_ioctl_setflags(struct inode *inode,
 	/* The JOURNAL_DATA flag is modifiable only by root */
 	jflag = flags & EXT4_JOURNAL_DATA_FL;
 
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 *
-	 * This test looks nicer. Thanks to Pauline Middelink
-	 */
-	if ((flags ^ oldflags) & (EXT4_APPEND_FL | EXT4_IMMUTABLE_FL)) {
-		if (!capable(CAP_LINUX_IMMUTABLE))
-			goto flags_out;
-	}
+	err = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (err)
+		goto flags_out;
 
 	/*
 	 * The JOURNAL_DATA flag can only be changed by
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 45b45f37d347..a969d5497e03 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1670,6 +1670,7 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	unsigned int oldflags;
+	int err;
 
 	/* Is it quota file? Do not allow user to mess with it */
 	if (IS_NOQUOTA(inode))
@@ -1679,9 +1680,9 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 
 	oldflags = fi->i_flags;
 
-	if ((flags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
-		if (!capable(CAP_LINUX_IMMUTABLE))
-			return -EPERM;
+	err = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (err)
+		return err;
 
 	flags = flags & F2FS_FL_USER_MODIFIABLE;
 	flags |= oldflags & ~F2FS_FL_USER_MODIFIABLE;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index d174b1f8fd08..99f53cf699c6 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -136,27 +136,36 @@ static struct {
 	{FS_JOURNAL_DATA_FL, GFS2_DIF_JDATA | GFS2_DIF_INHERIT_JDATA},
 };
 
+static inline u32 gfs2_gfsflags_to_fsflags(struct inode *inode, u32 gfsflags)
+{
+	int i;
+	u32 fsflags = 0;
+
+	if (S_ISDIR(inode->i_mode))
+		gfsflags &= ~GFS2_DIF_JDATA;
+	else
+		gfsflags &= ~GFS2_DIF_INHERIT_JDATA;
+
+	for (i = 0; i < ARRAY_SIZE(fsflag_gfs2flag); i++)
+		if (gfsflags & fsflag_gfs2flag[i].gfsflag)
+			fsflags |= fsflag_gfs2flag[i].fsflag;
+	return fsflags;
+}
+
 static int gfs2_get_flags(struct file *filp, u32 __user *ptr)
 {
 	struct inode *inode = file_inode(filp);
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
-	int i, error;
-	u32 gfsflags, fsflags = 0;
+	int error;
+	u32 fsflags;
 
 	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	error = gfs2_glock_nq(&gh);
 	if (error)
 		goto out_uninit;
 
-	gfsflags = ip->i_diskflags;
-	if (S_ISDIR(inode->i_mode))
-		gfsflags &= ~GFS2_DIF_JDATA;
-	else
-		gfsflags &= ~GFS2_DIF_INHERIT_JDATA;
-	for (i = 0; i < ARRAY_SIZE(fsflag_gfs2flag); i++)
-		if (gfsflags & fsflag_gfs2flag[i].gfsflag)
-			fsflags |= fsflag_gfs2flag[i].fsflag;
+	fsflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
 
 	if (put_user(fsflags, ptr))
 		error = -EFAULT;
@@ -200,9 +209,11 @@ void gfs2_set_inode_flags(struct inode *inode)
  * @filp: file pointer
  * @reqflags: The flags to set
  * @mask: Indicates which flags are valid
+ * @fsflags: The FS_* inode flags passed in
  *
  */
-static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask)
+static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
+			     const u32 fsflags)
 {
 	struct inode *inode = file_inode(filp);
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -210,7 +221,7 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask)
 	struct buffer_head *bh;
 	struct gfs2_holder gh;
 	int error;
-	u32 new_flags, flags;
+	u32 new_flags, flags, oldflags;
 
 	error = mnt_want_write_file(filp);
 	if (error)
@@ -220,6 +231,11 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask)
 	if (error)
 		goto out_drop_write;
 
+	oldflags = gfs2_gfsflags_to_fsflags(inode, ip->i_diskflags);
+	error = vfs_ioc_setflags_check(inode, oldflags, fsflags);
+	if (error)
+		goto out;
+
 	error = -EACCES;
 	if (!inode_owner_or_capable(inode))
 		goto out;
@@ -308,7 +324,7 @@ static int gfs2_set_flags(struct file *filp, u32 __user *ptr)
 		mask &= ~(GFS2_DIF_TOPDIR | GFS2_DIF_INHERIT_JDATA);
 	}
 
-	return do_gfs2_set_flags(filp, gfsflags, mask);
+	return do_gfs2_set_flags(filp, gfsflags, mask, fsflags);
 }
 
 static int gfs2_getlabel(struct file *filp, char __user *label)
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index 5e6502ef7415..862a3c9481d7 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -57,9 +57,8 @@ static int hfsplus_ioctl_bless(struct file *file, int __user *user_flags)
 	return 0;
 }
 
-static int hfsplus_ioctl_getflags(struct file *file, int __user *user_flags)
+static inline unsigned int hfsplus_getflags(struct inode *inode)
 {
-	struct inode *inode = file_inode(file);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	unsigned int flags = 0;
 
@@ -69,6 +68,13 @@ static int hfsplus_ioctl_getflags(struct file *file, int __user *user_flags)
 		flags |= FS_APPEND_FL;
 	if (hip->userflags & HFSPLUS_FLG_NODUMP)
 		flags |= FS_NODUMP_FL;
+	return flags;
+}
+
+static int hfsplus_ioctl_getflags(struct file *file, int __user *user_flags)
+{
+	struct inode *inode = file_inode(file);
+	unsigned int flags = hfsplus_getflags(inode);
 
 	return put_user(flags, user_flags);
 }
@@ -78,6 +84,7 @@ static int hfsplus_ioctl_setflags(struct file *file, int __user *user_flags)
 	struct inode *inode = file_inode(file);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
 	unsigned int flags, new_fl = 0;
+	unsigned int oldflags = hfsplus_getflags(inode);
 	int err = 0;
 
 	err = mnt_want_write_file(file);
@@ -96,13 +103,9 @@ static int hfsplus_ioctl_setflags(struct file *file, int __user *user_flags)
 
 	inode_lock(inode);
 
-	if ((flags & (FS_IMMUTABLE_FL|FS_APPEND_FL)) ||
-	    inode->i_flags & (S_IMMUTABLE|S_APPEND)) {
-		if (!capable(CAP_LINUX_IMMUTABLE)) {
-			err = -EPERM;
-			goto out_unlock_inode;
-		}
-	}
+	err = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (err)
+		goto out_unlock_inode;
 
 	/* don't silently ignore unsupported ext2 flags */
 	if (flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL)) {
diff --git a/fs/inode.c b/fs/inode.c
index 4348cfb14562..403ddbb81335 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2190,3 +2190,20 @@ struct timespec64 current_time(struct inode *inode)
 	return timespec64_trunc(now, inode->i_sb->s_time_gran);
 }
 EXPORT_SYMBOL(current_time);
+
+/* Generic function to check FS_IOC_SETFLAGS values. */
+int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags)
+{
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+	 * the relevant capability.
+	 *
+	 * This test looks nicer. Thanks to Pauline Middelink
+	 */
+	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	return 0;
+}
+EXPORT_SYMBOL(vfs_ioc_setflags_check);
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index ba34dae8bd9f..b485c2d7620f 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -98,24 +98,16 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		/* Lock against other parallel changes of flags */
 		inode_lock(inode);
 
-		oldflags = jfs_inode->mode2;
-
-		/*
-		 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-		 * the relevant capability.
-		 */
-		if ((oldflags & JFS_IMMUTABLE_FL) ||
-			((flags ^ oldflags) &
-			(JFS_APPEND_FL | JFS_IMMUTABLE_FL))) {
-			if (!capable(CAP_LINUX_IMMUTABLE)) {
-				inode_unlock(inode);
-				err = -EPERM;
-				goto setflags_out;
-			}
+		oldflags = jfs_map_ext2(jfs_inode->mode2 & JFS_FL_USER_VISIBLE,
+					0);
+		err = vfs_ioc_setflags_check(inode, oldflags, flags);
+		if (err) {
+			inode_unlock(inode);
+			goto setflags_out;
 		}
 
 		flags = flags & JFS_FL_USER_MODIFIABLE;
-		flags |= oldflags & ~JFS_FL_USER_MODIFIABLE;
+		flags |= jfs_inode->mode2 & ~JFS_FL_USER_MODIFIABLE;
 		jfs_inode->mode2 = flags;
 
 		jfs_set_inode_flags(inode);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 9b96d79eea6c..0632336d2515 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -148,13 +148,8 @@ static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
 
 	oldflags = NILFS_I(inode)->i_flags;
 
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by the
-	 * relevant capability.
-	 */
-	ret = -EPERM;
-	if (((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
+	ret = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (ret)
 		goto out;
 
 	ret = nilfs_transaction_begin(inode->i_sb, &ti, 0);
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 994726ada857..467a2faf0305 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -106,16 +106,9 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 	flags = flags & mask;
 	flags |= oldflags & ~mask;
 
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 */
-	status = -EPERM;
-	if ((oldflags & OCFS2_IMMUTABLE_FL) || ((flags ^ oldflags) &
-		(OCFS2_APPEND_FL | OCFS2_IMMUTABLE_FL))) {
-		if (!capable(CAP_LINUX_IMMUTABLE))
-			goto bail_unlock;
-	}
+	status = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (status)
+		goto bail_unlock;
 
 	handle = ocfs2_start_trans(osb, OCFS2_INODE_UPDATE_CREDITS);
 	if (IS_ERR(handle)) {
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index acbbaf7a0bb2..92bcb1ecd994 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -74,13 +74,11 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				err = -EPERM;
 				goto setflags_out;
 			}
-			if (((flags ^ REISERFS_I(inode)->
-			      i_attrs) & (REISERFS_IMMUTABLE_FL |
-					  REISERFS_APPEND_FL))
-			    && !capable(CAP_LINUX_IMMUTABLE)) {
-				err = -EPERM;
+			err = vfs_ioc_setflags_check(inode,
+						     REISERFS_I(inode)->i_attrs,
+						     flags);
+			if (err)
 				goto setflags_out;
-			}
 			if ((flags & REISERFS_NOTAIL_FL) &&
 			    S_ISREG(inode->i_mode)) {
 				int result;
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 4f1a397fda69..bdea836fc38b 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -107,18 +107,11 @@ static int setflags(struct inode *inode, int flags)
 	if (err)
 		return err;
 
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 */
 	mutex_lock(&ui->ui_mutex);
 	oldflags = ubifs2ioctl(ui->flags);
-	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
-		if (!capable(CAP_LINUX_IMMUTABLE)) {
-			err = -EPERM;
-			goto out_unlock;
-		}
-	}
+	err = vfs_ioc_setflags_check(inode, oldflags, flags);
+	if (err)
+		goto out_unlock;
 
 	ui->flags = ioctl2ubifs(flags);
 	ubifs_set_inode_flags(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 79ffa2958bd8..4d6feee18778 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3555,4 +3555,6 @@ static inline struct sock *io_uring_get_socket(struct file *file)
 }
 #endif
 
+int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags);
+
 #endif /* _LINUX_FS_H */

