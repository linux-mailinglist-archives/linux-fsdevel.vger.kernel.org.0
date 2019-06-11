Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8753C310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 06:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbfFKEs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 00:48:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34088 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391084AbfFKEs5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:48:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4hfbc168964;
        Tue, 11 Jun 2019 04:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KoYxxjggj5x4WhXdh863IYDbk9GIrg8l6m8wlKcb9v8=;
 b=XoiBcOFr1tMD21szwFu2J47CnO5JIPUoYLQx+1CCrAITm3MewoqORI/DRKyQpHBGYJHj
 X3QatzkHma6PQ6X8FWcD1lkVY4hv1pZbFNEhJUhJ1/0FNOJJDyvrzPtyIEbOvj3I30sr
 ZCGNP8g08LgUfU298HD27gI6UV6bCePAWkH2jofALibkjAMC8eIyshzIRoPVBWcWusGp
 pyM1cQ+s/v8K9/8ejmPly1qcOj0wR57O4S3q8YFWRbUvtOEhG4LG4bCrXg2P6EWePYAb
 HI4iH9wHh502NFFGbwOaLPtcfVoVSh1oIApEY3bicPx/82SnB3j9mb6remphRoQ1awRC 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t05nqjha5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 04:48:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4j7Qh120658;
        Tue, 11 Jun 2019 04:46:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2t04hy506k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 04:46:02 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5B4k2TO122188;
        Tue, 11 Jun 2019 04:46:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t04hy506e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 04:46:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B4k0Gs022829;
        Tue, 11 Jun 2019 04:46:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 21:45:59 -0700
Subject: [PATCH 3/4] fs: teach vfs_ioc_fssetxattr_check to check project id
 info
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk
Cc:     cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Date:   Mon, 10 Jun 2019 21:45:57 -0700
Message-ID: <156022835712.3227089.13380623784109583024.stgit@magnolia>
In-Reply-To: <156022833285.3227089.11990489625041926920.stgit@magnolia>
References: <156022833285.3227089.11990489625041926920.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Standardize the project id checks for FSSETXATTR.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/ext4/ioctl.c    |   27 ---------------------------
 fs/f2fs/file.c     |   27 ---------------------------
 fs/inode.c         |   13 +++++++++++++
 fs/xfs/xfs_ioctl.c |   15 ---------------
 4 files changed, 13 insertions(+), 69 deletions(-)


diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index c2f48c90ca45..6aa1df1918f7 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -697,30 +697,6 @@ static long ext4_ioctl_group_add(struct file *file,
 	return err;
 }
 
-static int ext4_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
-{
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() == &init_user_ns)
-		return 0;
-
-	if (__kprojid_val(EXT4_I(inode)->i_projid) != fa->fsx_projid)
-		return -EINVAL;
-
-	if (ext4_test_inode_flag(inode, EXT4_INODE_PROJINHERIT)) {
-		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
-			return -EINVAL;
-	} else {
-		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void ext4_fsgetxattr(struct inode *inode, struct fsxattr *fa)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -1135,9 +1111,6 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		inode_lock(inode);
 		ext4_fsgetxattr(inode, &old_fa);
-		err = ext4_ioctl_check_project(inode, &fa);
-		if (err)
-			goto out;
 		err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
 		if (err)
 			goto out;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f707de6bd4a8..183ed1ac60e1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2799,30 +2799,6 @@ static int f2fs_ioc_fsgetxattr(struct file *filp, unsigned long arg)
 	return 0;
 }
 
-static int f2fs_ioctl_check_project(struct inode *inode, struct fsxattr *fa)
-{
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() == &init_user_ns)
-		return 0;
-
-	if (__kprojid_val(F2FS_I(inode)->i_projid) != fa->fsx_projid)
-		return -EINVAL;
-
-	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL) {
-		if (!(fa->fsx_xflags & FS_XFLAG_PROJINHERIT))
-			return -EINVAL;
-	} else {
-		if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -2850,9 +2826,6 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 		return err;
 
 	inode_lock(inode);
-	err = f2fs_ioctl_check_project(inode, &fa);
-	if (err)
-		goto out;
 
 	__f2fs_ioc_fsgetxattr(inode, &old_fa);
 	err = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
diff --git a/fs/inode.c b/fs/inode.c
index 026955258a47..40ecd3a6a188 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2201,6 +2201,19 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() != &init_user_ns) {
+		if (old_fa->fsx_projid != fa->fsx_projid)
+			return -EINVAL;
+		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
+				FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 08c24f2f55c3..82961de98900 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1299,21 +1299,6 @@ xfs_ioctl_setattr_check_projid(
 	if (fa->fsx_projid > (uint16_t)-1 &&
 	    !xfs_sb_version_hasprojid32bit(&ip->i_mount->m_sb))
 		return -EINVAL;
-
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() == &init_user_ns)
-		return 0;
-
-	if (xfs_get_projid(ip) != fa->fsx_projid)
-		return -EINVAL;
-	if ((fa->fsx_xflags & FS_XFLAG_PROJINHERIT) !=
-	    (ip->i_d.di_flags & XFS_DIFLAG_PROJINHERIT))
-		return -EINVAL;
-
 	return 0;
 }
 

