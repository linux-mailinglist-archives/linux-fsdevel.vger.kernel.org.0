Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E755EB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 04:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFZCdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 22:33:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53466 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZCdo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:33:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2T29e026332;
        Wed, 26 Jun 2019 02:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=py6qq4AeIRMcAOWockiXCJTubKN10bFS+2siX9cFCeQ=;
 b=Hv5R8eSKsxzeZJ3b2H4iAHuiVvATZV2tOhJ/acui/4nfLOPN31wrwFEXc5OalQDho58v
 OVdXYRbxetq/KY474M/PMQ03HZsWnfQZAYTgAUNDwTn232rXn78E1N7Kwy4+oi1RlYth
 ZBNxmo0OBEl+ygs+ZttbPSB7sXe+E8IwkJU6ibShujqv5lHXYTnRwuZtiJYK7KOmkBqX
 6sxabYGv9uTib9Stei8yYC/ERqqSSxqXp234Q3uNHyYv2FBY83XSZsmkRURTfbShlm3Y
 kWLWutdrK8wsuMGdNJ1/zJFthfYHMnBl/LU9SA/J1ibOEj4aLDqlZQm7+PBhfmTRFdD1 SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2t9c9pqjft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 02:32:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q2VPC7077128;
        Wed, 26 Jun 2019 02:32:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2tat7cjnnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jun 2019 02:32:24 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5Q2WOaG079407;
        Wed, 26 Jun 2019 02:32:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2tat7cjnmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 02:32:24 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5Q2WLTe020729;
        Wed, 26 Jun 2019 02:32:21 GMT
Received: from localhost (/10.159.230.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Jun 2019 19:32:20 -0700
Subject: [PATCH 2/5] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, hch@infradead.org,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk
Cc:     cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, Jan Kara <jack@suse.cz>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Date:   Tue, 25 Jun 2019 19:32:18 -0700
Message-ID: <156151633829.2283456.834142172527987802.stgit@magnolia>
In-Reply-To: <156151632209.2283456.3592379873620132456.stgit@magnolia>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260027
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
 fs/btrfs/ioctl.c   |   18 ++++++-------
 fs/ext4/ioctl.c    |   27 +++++++++++++-------
 fs/f2fs/file.c     |   28 ++++++++++++++-------
 fs/inode.c         |   23 +++++++++++++++++
 fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++++++++++----------------------
 include/linux/fs.h |    3 ++
 6 files changed, 112 insertions(+), 57 deletions(-)


diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d3d9b4abb09b..0f5af7c5f66b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -373,10 +373,9 @@ static int check_xflags(unsigned int flags)
 static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
 {
 	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
-	struct fsxattr fa;
-
-	memset(&fa, 0, sizeof(fa));
-	fa.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags);
+	struct fsxattr fa = {
+		.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags),
+	};
 
 	if (copy_to_user(arg, &fa, sizeof(fa)))
 		return -EFAULT;
@@ -391,6 +390,9 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	struct btrfs_root *root = binode->root;
 	struct btrfs_trans_handle *trans;
 	struct fsxattr fa;
+	struct fsxattr old_fa = {
+		.fsx_xflags = btrfs_inode_flags_to_xflags(binode->flags),
+	};
 	unsigned old_flags;
 	unsigned old_i_flags;
 	int ret = 0;
@@ -421,13 +423,9 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	old_flags = binode->flags;
 	old_i_flags = inode->i_flags;
 
-	/* We need the capabilities to change append-only or immutable inode */
-	if (((old_flags & (BTRFS_INODE_APPEND | BTRFS_INODE_IMMUTABLE)) ||
-	     (fa.fsx_xflags & (FS_XFLAG_APPEND | FS_XFLAG_IMMUTABLE))) &&
-	    !capable(CAP_LINUX_IMMUTABLE)) {
-		ret = -EPERM;
+	ret = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
+	if (ret)
 		goto out_unlock;
-	}
 
 	if (fa.fsx_xflags & FS_XFLAG_SYNC)
 		binode->flags |= BTRFS_INODE_SYNC;
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 272b6e44191b..ebcc173d1e7d 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -721,6 +721,17 @@ static int ext4_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
 	return 0;
 }
 
+static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	fa->fsx_xflags = ext4_iflags_to_xflags(ei->i_flags &
+					       EXT4_FL_USER_VISIBLE);
+
+	if (ext4_has_feature_project(inode->i_sb))
+		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
+}
+
 long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -1087,15 +1098,9 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case EXT4_IOC_FSGETXATTR:
 	{
-		struct fsxattr fa;
-
-		memset(&fa, 0, sizeof(struct fsxattr));
-		fa.fsx_xflags = ext4_iflags_to_xflags(ei->i_flags & EXT4_FL_USER_VISIBLE);
+		struct fsxattr fa = { 0 };
 
-		if (ext4_has_feature_project(inode->i_sb)) {
-			fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
-				EXT4_I(inode)->i_projid);
-		}
+		ext4_fill_fsxattr(inode, &fa);
 
 		if (copy_to_user((struct fsxattr __user *)arg,
 				 &fa, sizeof(fa)))
@@ -1104,7 +1109,7 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 	case EXT4_IOC_FSSETXATTR:
 	{
-		struct fsxattr fa;
+		struct fsxattr fa, old_fa = { 0 };
 		int err;
 
 		if (copy_from_user(&fa, (struct fsxattr __user *)arg,
@@ -1127,7 +1132,11 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return err;
 
 		inode_lock(inode);
+		ext4_fill_fsxattr(inode, &old_fa);
 		err = ext4_ioctl_check_project(inode, &fa);
+		if (err)
+			goto out;
+		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 		if (err)
 			goto out;
 		flags = (ei->i_flags & ~EXT4_FL_XFLAG_VISIBLE) |
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 845ae6f43ebc..555b970f7945 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2773,19 +2773,24 @@ static inline unsigned long f2fs_xflags_to_iflags(__u32 xflags)
 	return iflags;
 }
 
-static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
+static void f2fs_fill_fsxattr(struct inode *inode,
+				  struct fsxattr *fa)
 {
-	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct fsxattr fa;
 
-	memset(&fa, 0, sizeof(struct fsxattr));
-	fa.fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
-				F2FS_FL_USER_VISIBLE);
+	fa->fsx_xflags = f2fs_iflags_to_xflags(fi->i_flags &
+					       F2FS_FL_USER_VISIBLE);
 
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
-		fa.fsx_projid = (__u32)from_kprojid(&init_user_ns,
-							fi->i_projid);
+		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
+}
+
+static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct fsxattr fa = { 0 };
+
+	f2fs_fill_fsxattr(inode, &fa);
 
 	if (copy_to_user((struct fsxattr __user *)arg, &fa, sizeof(fa)))
 		return -EFAULT;
@@ -2820,7 +2825,7 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	struct fsxattr fa;
+	struct fsxattr fa, old_fa = { 0 };
 	unsigned int flags;
 	int err;
 
@@ -2844,6 +2849,11 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 	err = f2fs_ioctl_check_project(inode, &fa);
+	if (err)
+		goto out;
+
+	f2fs_fill_fsxattr(inode, &old_fa);
+	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 	if (err)
 		goto out;
 	flags = (fi->i_flags & ~F2FS_FL_XFLAG_VISIBLE) |
diff --git a/fs/inode.c b/fs/inode.c
index 9cd1b6501e97..fdd6c5d3e48d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2214,3 +2214,26 @@ int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
+
+/*
+ * Generic function to check FS_IOC_FSSETXATTR values and reject any invalid
+ * configurations.
+ *
+ * Note: the caller should be holding i_mutex, or else be sure that they have
+ * exclusive access to the inode structure.
+ */
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
index d7dfc13f30f5..08ec1e458865 100644
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
+xfs_fill_fsxattr(
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
+	xfs_fill_fsxattr(ip, attr, &fa);
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
 
+	xfs_fill_fsxattr(ip, false, &old_fa);
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
 
+	xfs_fill_fsxattr(ip, false, &old_fa);
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
index 3f74066d3f44..48322bfd7299 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3558,4 +3558,7 @@ static inline struct sock *io_uring_get_socket(struct file *file)
 int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
 			     unsigned int flags);
 
+int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
+			     struct fsxattr *fa);
+
 #endif /* _LINUX_FS_H */

