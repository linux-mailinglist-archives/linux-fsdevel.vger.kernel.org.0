Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E74F194
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 01:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFUX5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 19:57:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfFUX5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:57:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNsDBv059188;
        Fri, 21 Jun 2019 23:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9PJTGN9x6qjEBTUeY0pgpFP+vfVwXojpN3x10y/+n0w=;
 b=rweOK5t5+YVB40qJyhz9haoKaxJ6RnYnO9aOtyQw3HPILQ5hqR24EjOrIoVciD62u7Sq
 HnRptwFU2LetTGRkerU4u8S+38OWrM4vNzzWSComZlmtAnEkluk9t0eAucSMd4RrcUKP
 996AjhnZ7CMQq3Z+EJ+SismdSC3n8svWj5kjNbTCsuXcUy9o2Iu1Bs/S7F540p8p1iFD
 6Wo6GqGDnWYIeRi5E7lG1T2c0ojxDFBJR+vukFP0vkmU0Jko+Wl22oCzxQDhRvQfJgXX
 +NnfTYD3NtjU6nxPXLLMyBG5ojp6oOdPvkEFYUqgPMSq9CkCjAxO0mm8ZrfbqJAVzYxS 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t7809rque-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:56:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNuaM5036245;
        Fri, 21 Jun 2019 23:56:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 2t77yq6u76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 23:56:36 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5LNuZLJ036227;
        Fri, 21 Jun 2019 23:56:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t77yq6u6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:56:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5LNuWif018901;
        Fri, 21 Jun 2019 23:56:32 GMT
Received: from localhost (/10.159.131.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 23:56:32 +0000
Subject: [PATCH 2/4] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
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
Date:   Fri, 21 Jun 2019 16:56:29 -0700
Message-ID: <156116138952.1664814.16552129914959122837.stgit@magnolia>
In-Reply-To: <156116136742.1664814.17093419199766834123.stgit@magnolia>
References: <156116136742.1664814.17093419199766834123.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Create a generic checking function for the incoming FS_IOC_FSSETXATTR
fsxattr values so that we can standardize some of the implementation
behaviors.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/ioctl.c   |   21 +++++++++-------
 fs/ext4/ioctl.c    |   27 ++++++++++++++------
 fs/f2fs/file.c     |   26 ++++++++++++++-----
 fs/inode.c         |   17 +++++++++++++
 fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++++++++++----------------------
 include/linux/fs.h |    3 ++
 6 files changed, 111 insertions(+), 53 deletions(-)


diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f408aa93b0cf..7ddda5b4b6a6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -366,6 +366,13 @@ static int check_xflags(unsigned int flags)
 	return 0;
 }
 
+static void __btrfs_ioctl_fsgetxattr(struct btrfs_inode *binode,
+				     struct fsxattr *fa)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
+}
+
 /*
  * Set the xflags from the internal inode flags. The remaining items of fsxattr
  * are zeroed.
@@ -375,8 +382,7 @@ static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
 	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
 	struct fsxattr fa;
 
-	memset(&fa, 0, sizeof(fa));
-	fa.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
+	__btrfs_ioctl_fsgetxattr(binode, &fa);
 
 	if (copy_to_user(arg, &fa, sizeof(fa)))
 		return -EFAULT;
@@ -390,7 +396,7 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	struct btrfs_inode *binode = BTRFS_I(inode);
 	struct btrfs_root *root = binode->root;
 	struct btrfs_trans_handle *trans;
-	struct fsxattr fa;
+	struct fsxattr fa, old_fa;
 	unsigned old_flags;
 	unsigned old_i_flags;
 	int ret = 0;
@@ -421,13 +427,10 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	old_flags = binode->flags;
 	old_i_flags = inode->i_flags;
 
-	/* We need the capabilities to change append-only or immutable inode */
-	if (((old_flags & (BTRFS_INODE_APPEND | BTRFS_INODE_IMMUTABLE)) ||
-	     (fa.fsx_xflags & (FS_XFLAG_APPEND | FS_XFLAG_IMMUTABLE))) &&
-	    !capable(CAP_LINUX_IMMUTABLE)) {
-		ret = -EPERM;
+	__btrfs_ioctl_fsgetxattr(binode, &old_fa);
+	ret = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
+	if (ret)
 		goto out_unlock;
-	}
 
 	if (fa.fsx_xflags & FS_XFLAG_SYNC)
 		binode->flags |= BTRFS_INODE_SYNC;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 5126ee351a84..c2f48c90ca45 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -721,6 +721,19 @@ static int ext4_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
 	return 0;
 }
 
+static void ext4_fsgetxattr(struct inode *inode, struct fsxattr *fa)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	memset(fa, 0, sizeof(struct fsxattr));
+	fa->fsx_xflags = ext4_iflags_to_xflags(ei->i_flags & EXT4_FL_USER_VISIBLE);
+
+	if (ext4_has_feature_project(inode->i_sb)) {
+		fa->fsx_projid = (__u32)from_kprojid(&init_user_ns,
+				ei->i_projid);
+	}
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1089,13 +1102,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	{
 		struct fsxattr fa;
 
-		memset(&fa, 0, sizeof(struct fsxattr));
-		fa.fsx_xflags = ext4_iflags_to_xflags(ei->i_flags & EXT4_FL_USER_VISIBLE);
-
-		if (ext4_has_feature_project(inode->i_sb)) {
-			fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
-				EXT4_I(inode)->i_projid);
-		}
+		ext4_fsgetxattr(inode, &fa);
 
 		if (copy_to_user((struct fsxattr __user *)arg,
 				 &fa, sizeof(fa)))
@@ -1104,7 +1111,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 	case EXT4_IOC_FSSETXATTR:
 	{
-		struct fsxattr fa;
+		struct fsxattr fa, old_fa;
 		int err;
 
 		if (copy_from_user(&fa, (struct fsxattr __user *)arg,
@@ -1127,7 +1134,11 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return err;
 
 		inode_lock(inode);
+		ext4_fsgetxattr(inode, &old_fa);
 		err = ext4_ioctl_check_project(inode, &fa);
+		if (err)
+			goto out;
+		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 		if (err)
 			goto out;
 		flags = (ei->i_flags & ~EXT4_FL_XFLAG_VISIBLE) |
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a969d5497e03..f707de6bd4a8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2773,19 +2773,26 @@ static inline unsigned long f2fs_xflags_to_iflags(__u32 xflags)
 	return iflags;
 }
 
-static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
+static void __f2fs_ioc_fsgetxattr(struct inode *inode,
+				  struct fsxattr *fa)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct fsxattr fa;
 
-	memset(&fa, 0, sizeof(struct fsxattr));
-	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
+	memset(fa, 0, sizeof(struct fsxattr));
+	fa->fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
 				F2FS_FL_USER_VISIBLE);
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
-		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
+		fa->fsx_projid = (__u32)from_kprojid(&init_user_ns,
 							fi->i_projid);
+}
+
+static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct fsxattr fa;
+
+	__f2fs_ioc_fsgetxattr(inode, &fa);
 
 	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
 		return -EFAULT;
@@ -2820,7 +2827,7 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct fsxattr fa;
+	struct fsxattr fa, old_fa;
 	unsigned int flags;
 	int err;
 
@@ -2844,6 +2851,11 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 	err = f2fs_ioctl_check_project(inode, &fa);
+	if (err)
+		goto out;
+
+	__f2fs_ioc_fsgetxattr(inode, &old_fa);
+	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 	if (err)
 		goto out;
 	flags = (fi->i_flags & ~F2FS_FL_XFLAG_VISIBLE) |
diff --git a/fs/inode.c b/fs/inode.c
index 403ddbb81335..ddfe60679b53 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2207,3 +2207,20 @@ int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags)
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_check);
+
+/* Generic function to check FS_IOC_FSSETXATTR values. */
+int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
+			     struct fsxattr *fa)
+{
+	/*
+	 * Can't modify an immutable/append-only file unless we have
+	 * appropriate permission.
+	 */
+	if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
+			(FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	return 0;
+}
+EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d7dfc13f30f5..08c24f2f55c3 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -879,37 +879,45 @@ xfs_di2lxflags(
 	return flags;
 }
 
-STATIC int
-xfs_ioc_fsgetxattr(
-	xfs_inode_t		*ip,
-	int			attr,
-	void			__user *arg)
+static void
+__xfs_ioc_fsgetxattr(
+	struct xfs_inode	*ip,
+	bool			attr,
+	struct fsxattr		*fa)
 {
-	struct fsxattr		fa;
-
-	memset(&fa, 0, sizeof(struct fsxattr));
-
-	xfs_ilock(ip, XFS_ILOCK_SHARED);
-	fa.fsx_xflags = xfs_ip2xflags(ip);
-	fa.fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
-	fa.fsx_cowextsize = ip->i_d.di_cowextsize <<
+	memset(fa, 0, sizeof(struct fsxattr));
+	fa->fsx_xflags = xfs_ip2xflags(ip);
+	fa->fsx_extsize = ip->i_d.di_extsize << ip->i_mount->m_sb.sb_blocklog;
+	fa->fsx_cowextsize = ip->i_d.di_cowextsize <<
 			ip->i_mount->m_sb.sb_blocklog;
-	fa.fsx_projid = xfs_get_projid(ip);
+	fa->fsx_projid = xfs_get_projid(ip);
 
 	if (attr) {
 		if (ip->i_afp) {
 			if (ip->i_afp->if_flags & XFS_IFEXTENTS)
-				fa.fsx_nextents = xfs_iext_count(ip->i_afp);
+				fa->fsx_nextents = xfs_iext_count(ip->i_afp);
 			else
-				fa.fsx_nextents = ip->i_d.di_anextents;
+				fa->fsx_nextents = ip->i_d.di_anextents;
 		} else
-			fa.fsx_nextents = 0;
+			fa->fsx_nextents = 0;
 	} else {
 		if (ip->i_df.if_flags & XFS_IFEXTENTS)
-			fa.fsx_nextents = xfs_iext_count(&ip->i_df);
+			fa->fsx_nextents = xfs_iext_count(&ip->i_df);
 		else
-			fa.fsx_nextents = ip->i_d.di_nextents;
+			fa->fsx_nextents = ip->i_d.di_nextents;
 	}
+}
+
+STATIC int
+xfs_ioc_fsgetxattr(
+	xfs_inode_t		*ip,
+	int			attr,
+	void			__user *arg)
+{
+	struct fsxattr		fa;
+
+	xfs_ilock(ip, XFS_ILOCK_SHARED);
+	__xfs_ioc_fsgetxattr(ip, attr, &fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
 	if (copy_to_user(arg, &fa, sizeof(fa)))
@@ -1035,15 +1043,6 @@ xfs_ioctl_setattr_xflags(
 	if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
 		return -EINVAL;
 
-	/*
-	 * Can't modify an immutable/append-only file unless
-	 * we have appropriate permission.
-	 */
-	if (((ip->i_d.di_flags & (XFS_DIFLAG_IMMUTABLE | XFS_DIFLAG_APPEND)) ||
-	     (fa->fsx_xflags & (FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND))) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
 	/* diflags2 only valid for v3 inodes. */
 	di_flags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
 	if (di_flags2 && ip->i_d.di_version < 3)
@@ -1323,6 +1322,7 @@ xfs_ioctl_setattr(
 	xfs_inode_t		*ip,
 	struct fsxattr		*fa)
 {
+	struct fsxattr		old_fa;
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
 	struct xfs_dquot	*udqp = NULL;
@@ -1370,7 +1370,6 @@ xfs_ioctl_setattr(
 		goto error_free_dquots;
 	}
 
-
 	if (XFS_IS_QUOTA_RUNNING(mp) && XFS_IS_PQUOTA_ON(mp) &&
 	    xfs_get_projid(ip) != fa->fsx_projid) {
 		code = xfs_qm_vop_chown_reserve(tp, ip, udqp, NULL, pdqp,
@@ -1379,6 +1378,11 @@ xfs_ioctl_setattr(
 			goto error_trans_cancel;
 	}
 
+	__xfs_ioc_fsgetxattr(ip, false, &old_fa);
+	code = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, fa);
+	if (code)
+		goto error_trans_cancel;
+
 	code = xfs_ioctl_setattr_check_extsize(ip, fa);
 	if (code)
 		goto error_trans_cancel;
@@ -1489,6 +1493,7 @@ xfs_ioc_setxflags(
 {
 	struct xfs_trans	*tp;
 	struct fsxattr		fa;
+	struct fsxattr		old_fa;
 	unsigned int		flags;
 	int			join_flags = 0;
 	int			error;
@@ -1524,6 +1529,13 @@ xfs_ioc_setxflags(
 		goto out_drop_write;
 	}
 
+	__xfs_ioc_fsgetxattr(ip, false, &old_fa);
+	error = vfs_ioc_fssetxattr_check(VFS_I(ip), &old_fa, &fa);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_drop_write;
+	}
+
 	error = xfs_ioctl_setattr_xflags(tp, ip, &fa);
 	if (error) {
 		xfs_trans_cancel(tp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4d6feee18778..0c3ef24afe22 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3557,4 +3557,7 @@ static inline struct sock *io_uring_get_socket(struct file *file)
 
 int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags);
 
+int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
+			     struct fsxattr *fa);
+
 #endif /* _LINUX_FS_H */

