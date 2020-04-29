Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB61BD26E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD2CpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgD2CpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2heRf155902;
        Wed, 29 Apr 2020 02:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3NGGvaTRiwIXeQdhdZrFy56v/hlQDcYPEPi410TXjt8=;
 b=jyEeKjorPnoeW418VDA+kvMoaixo50QphkNr6CH78K20Ub1kkMKZEhEDkS8jcgq4+npI
 wKuKAMZW+6NhdnG6W07h2MvkfvnALb8bZKRXAXByPpGSuiFZ71vM6w3Oj/0izMBnOa4b
 hvWoCaQRTQIYSyy3cPAYRI1nEAzRh7mTLDyK4ZiOytDwcdwdZ3uUGrjAXgLOMsbQRjkK
 mx2y6IuLIHWAz9W8yyH1c7/tp+HOsXmRsUcgn760GQtp5pO9ay37l6ZBnERBTh0Neqbw
 cGu1FHGUhmXKTr4qJcNLZ+gUbebnpdXJreY31yh2B9zV8xa+oJbtcJ2ZxkOnUu/o8ZuM 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30p01nstje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2gNSW096583;
        Wed, 29 Apr 2020 02:45:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30pvcytdh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:22 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2jLFL003624;
        Wed, 29 Apr 2020 02:45:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:20 -0700
Subject: [PATCH 10/18] xfs: refactor locking and unlocking two inodes
 against userspace IO
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:20 -0700
Message-ID: <158812831991.168506.927297614049035671.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=1 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=1 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Refactor the two functions that we use to lock and unlock two inodes to
block userspace from initiating IO against a file, whether via system
calls or mmap activity.  Move them to xfs_inode.c since this functionality
won't be specific to reflink for much longer.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_file.c    |    2 +
 fs/xfs/xfs_inode.c   |   93 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h   |    3 ++
 fs/xfs/xfs_reflink.c |   85 +---------------------------------------------
 fs/xfs/xfs_reflink.h |    2 -
 5 files changed, 99 insertions(+), 86 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1759fbcbcd46..9bce98323ca6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1059,7 +1059,7 @@ xfs_file_remap_range(
 	if (mp->m_flags & XFS_MOUNT_WSYNC)
 		xfs_log_force_inode(dest);
 out_unlock:
-	xfs_reflink_remap_unlock(file_in, file_out);
+	xfs_iunlock_two_io(src, dest);
 	if (ret)
 		trace_xfs_reflink_remap_range_error(dest, ret, _RET_IP_);
 	return remapped > 0 ? remapped : ret;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a0db7f47826f..080c8838fba5 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3112,3 +3112,96 @@ xfs_is_always_cow_inode(
 	return ip->i_mount->m_always_cow &&
 		xfs_sb_version_hasreflink(&ip->i_mount->m_sb);
 }
+
+/*
+ * Grab the exclusive iolock for a data copy from src to dest, making sure to
+ * abide vfs locking order (lowest pointer value goes first) and breaking the
+ * layout leases before proceeding.  The loop is needed because we cannot call
+ * the blocking break_layout() with the iolocks held, and therefore have to
+ * back out both locks.
+ */
+static int
+xfs_iolock_two_inodes_and_break_layout(
+	struct inode		*src,
+	struct inode		*dest)
+{
+	int			error;
+
+	if (src > dest)
+		swap(src, dest);
+
+retry:
+	/* Wait to break both inodes' layouts before we start locking. */
+	error = break_layout(src, true);
+	if (error)
+		return error;
+	if (src != dest) {
+		error = break_layout(dest, true);
+		if (error)
+			return error;
+	}
+
+	/* Lock one inode and make sure nobody got in and leased it. */
+	inode_lock(src);
+	error = break_layout(src, false);
+	if (error) {
+		inode_unlock(src);
+		if (error == -EWOULDBLOCK)
+			goto retry;
+		return error;
+	}
+
+	if (src == dest)
+		return 0;
+
+	/* Lock the other inode and make sure nobody got in and leased it. */
+	inode_lock_nested(dest, I_MUTEX_NONDIR2);
+	error = break_layout(dest, false);
+	if (error) {
+		inode_unlock(src);
+		inode_unlock(dest);
+		if (error == -EWOULDBLOCK)
+			goto retry;
+		return error;
+	}
+
+	return 0;
+}
+
+/*
+ * Lock two files so that userspace cannot initiate I/O via file syscalls or
+ * mmap activity.
+ */
+int
+xfs_ilock_two_io(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	int			ret;
+
+	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
+	if (ret)
+		return ret;
+	if (ip1 == ip2)
+		xfs_ilock(ip1, XFS_MMAPLOCK_EXCL);
+	else
+		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
+				    ip2, XFS_MMAPLOCK_EXCL);
+	return 0;
+}
+
+/* Unlock both files to allow IO and mmap activity. */
+void
+xfs_iunlock_two_io(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	bool			same_inode = (ip1 == ip2);
+
+	xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
+	if (!same_inode)
+		xfs_iunlock(ip1, XFS_MMAPLOCK_EXCL);
+	inode_unlock(VFS_I(ip2));
+	if (!same_inode)
+		inode_unlock(VFS_I(ip1));
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index df5021cf5d0f..d8cb7bed4dd9 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -509,4 +509,7 @@ void xfs_inode_inactivation_cleanup(struct xfs_inode *ip);
 
 void xfs_end_io(struct work_struct *work);
 
+int xfs_ilock_two_io(struct xfs_inode *ip1, struct xfs_inode *ip2);
+void xfs_iunlock_two_io(struct xfs_inode *ip1, struct xfs_inode *ip2);
+
 #endif	/* __XFS_INODE_H__ */
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f206f6637daf..566a3dee2815 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1237,81 +1237,6 @@ xfs_reflink_remap_blocks(
 	return error;
 }
 
-/*
- * Grab the exclusive iolock for a data copy from src to dest, making sure to
- * abide vfs locking order (lowest pointer value goes first) and breaking the
- * layout leases before proceeding.  The loop is needed because we cannot call
- * the blocking break_layout() with the iolocks held, and therefore have to
- * back out both locks.
- */
-static int
-xfs_iolock_two_inodes_and_break_layout(
-	struct inode		*src,
-	struct inode		*dest)
-{
-	int			error;
-
-	if (src > dest)
-		swap(src, dest);
-
-retry:
-	/* Wait to break both inodes' layouts before we start locking. */
-	error = break_layout(src, true);
-	if (error)
-		return error;
-	if (src != dest) {
-		error = break_layout(dest, true);
-		if (error)
-			return error;
-	}
-
-	/* Lock one inode and make sure nobody got in and leased it. */
-	inode_lock(src);
-	error = break_layout(src, false);
-	if (error) {
-		inode_unlock(src);
-		if (error == -EWOULDBLOCK)
-			goto retry;
-		return error;
-	}
-
-	if (src == dest)
-		return 0;
-
-	/* Lock the other inode and make sure nobody got in and leased it. */
-	inode_lock_nested(dest, I_MUTEX_NONDIR2);
-	error = break_layout(dest, false);
-	if (error) {
-		inode_unlock(src);
-		inode_unlock(dest);
-		if (error == -EWOULDBLOCK)
-			goto retry;
-		return error;
-	}
-
-	return 0;
-}
-
-/* Unlock both inodes after they've been prepped for a range clone. */
-void
-xfs_reflink_remap_unlock(
-	struct file		*file_in,
-	struct file		*file_out)
-{
-	struct inode		*inode_in = file_inode(file_in);
-	struct xfs_inode	*src = XFS_I(inode_in);
-	struct inode		*inode_out = file_inode(file_out);
-	struct xfs_inode	*dest = XFS_I(inode_out);
-	bool			same_inode = (inode_in == inode_out);
-
-	xfs_iunlock(dest, XFS_MMAPLOCK_EXCL);
-	if (!same_inode)
-		xfs_iunlock(src, XFS_MMAPLOCK_EXCL);
-	inode_unlock(inode_out);
-	if (!same_inode)
-		inode_unlock(inode_in);
-}
-
 /*
  * If we're reflinking to a point past the destination file's EOF, we must
  * zero any speculative post-EOF preallocations that sit between the old EOF
@@ -1374,18 +1299,12 @@ xfs_reflink_remap_prep(
 	struct xfs_inode	*src = XFS_I(inode_in);
 	struct inode		*inode_out = file_inode(file_out);
 	struct xfs_inode	*dest = XFS_I(inode_out);
-	bool			same_inode = (inode_in == inode_out);
 	int			ret;
 
 	/* Lock both files against IO */
-	ret = xfs_iolock_two_inodes_and_break_layout(inode_in, inode_out);
+	ret = xfs_ilock_two_io(src, dest);
 	if (ret)
 		return ret;
-	if (same_inode)
-		xfs_ilock(src, XFS_MMAPLOCK_EXCL);
-	else
-		xfs_lock_two_inodes(src, XFS_MMAPLOCK_EXCL, dest,
-				XFS_MMAPLOCK_EXCL);
 
 	/* Check file eligibility and prepare for block sharing. */
 	ret = -EINVAL;
@@ -1436,7 +1355,7 @@ xfs_reflink_remap_prep(
 
 	return 0;
 out_unlock:
-	xfs_reflink_remap_unlock(file_in, file_out);
+	xfs_iunlock_two_io(src, dest);
 	return ret;
 }
 
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 0879d2e71e11..8ddf1300a982 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -50,7 +50,5 @@ extern int xfs_reflink_remap_blocks(struct xfs_inode *src, loff_t pos_in,
 		loff_t *remapped);
 extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
 		xfs_extlen_t cowextsize, unsigned int remap_flags);
-extern void xfs_reflink_remap_unlock(struct file *file_in,
-		struct file *file_out);
 
 #endif /* __XFS_REFLINK_H */

