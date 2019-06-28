Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46555A3D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 20:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF1Sf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 14:35:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39038 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfF1SfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:35:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYTuK114669;
        Fri, 28 Jun 2019 18:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RJo9HRMvrhDC3/z4MR2nW8aji8vHUz97eCXxdDfB7Qw=;
 b=zfsBPq4VIgYQNsYJJLrQACmJUX2r4WH3O24sII7d3G3YpAp2BPvIaItNZuKFgX8DhxfW
 vXdtmCxGUQAsSnZqhsjZ7kHOL3QYXAeRSerILJ9orq99UK4YmM56dP18DZpACbCT3wN2
 V0UDcy16W4vhh0jil3d+yfPReca3dIRCwA0TQNssA4D+W/GOgk6nez66Cf6ykSiEYYmD
 8T4iOAs7QMyYZCEXLJJXiFCrdLDL866nH1zyubZnV2zumrYW5Op10XIew14erNhQP/4t
 HbOBURZkWTQNo7pA/qgq/oaCbtYUv9E36D5xwci4Dq8czAcUUDO1LB1hSPwSLDRKwbk3 5g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqxyh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:34:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIXemV001136;
        Fri, 28 Jun 2019 18:34:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 2tat7e3g5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jun 2019 18:34:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5SIYS8N002532;
        Fri, 28 Jun 2019 18:34:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tat7e3g5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:34:28 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SIYQeU021679;
        Fri, 28 Jun 2019 18:34:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 11:34:26 -0700
Subject: [PATCH 4/5] vfs: teach vfs_ioc_fssetxattr_check to check extent
 size hints
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
Date:   Fri, 28 Jun 2019 11:34:23 -0700
Message-ID: <156174686376.1557318.5574192602758705361.stgit@magnolia>
In-Reply-To: <156174682897.1557318.14418894077683701275.stgit@magnolia>
References: <156174682897.1557318.14418894077683701275.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=980 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280210
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move the extent size hint checks that aren't xfs-specific to the vfs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c         |   18 +++++++++++++
 fs/xfs/xfs_ioctl.c |   70 ++++++++++++++++++++++------------------------------
 2 files changed, 47 insertions(+), 41 deletions(-)


diff --git a/fs/inode.c b/fs/inode.c
index c4f8fb16f633..670d5408d022 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2247,6 +2247,24 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 			return -EINVAL;
 	}
 
+	/* Check extent size hints. */
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (fa->fsx_extsize == 0)
+		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (fa->fsx_cowextsize == 0)
+		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index f494c01342c6..fe29aa61293c 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1200,39 +1200,31 @@ xfs_ioctl_setattr_check_extsize(
 	struct fsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(VFS_I(ip)->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-	    !S_ISDIR(VFS_I(ip)->i_mode))
-		return -EINVAL;
+	xfs_extlen_t		size;
+	xfs_fsblock_t		extsize_fsb;
 
 	if (S_ISREG(VFS_I(ip)->i_mode) && ip->i_d.di_nextents &&
 	    ((ip->i_d.di_extsize << mp->m_sb.sb_blocklog) != fa->fsx_extsize))
 		return -EINVAL;
 
-	if (fa->fsx_extsize != 0) {
-		xfs_extlen_t    size;
-		xfs_fsblock_t   extsize_fsb;
-
-		extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
-		if (extsize_fsb > MAXEXTLEN)
-			return -EINVAL;
+	if (fa->fsx_extsize == 0)
+		return 0;
 
-		if (XFS_IS_REALTIME_INODE(ip) ||
-		    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
-			size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
-		} else {
-			size = mp->m_sb.sb_blocksize;
-			if (extsize_fsb > mp->m_sb.sb_agblocks / 2)
-				return -EINVAL;
-		}
+	extsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_extsize);
+	if (extsize_fsb > MAXEXTLEN)
+		return -EINVAL;
 
-		if (fa->fsx_extsize % size)
+	if (XFS_IS_REALTIME_INODE(ip) ||
+	    (fa->fsx_xflags & FS_XFLAG_REALTIME)) {
+		size = mp->m_sb.sb_rextsize << mp->m_sb.sb_blocklog;
+	} else {
+		size = mp->m_sb.sb_blocksize;
+		if (extsize_fsb > mp->m_sb.sb_agblocks / 2)
 			return -EINVAL;
-	} else
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	}
+
+	if (fa->fsx_extsize % size)
+		return -EINVAL;
 
 	return 0;
 }
@@ -1258,6 +1250,8 @@ xfs_ioctl_setattr_check_cowextsize(
 	struct fsxattr		*fa)
 {
 	struct xfs_mount	*mp = ip->i_mount;
+	xfs_extlen_t		size;
+	xfs_fsblock_t		cowextsize_fsb;
 
 	if (!(fa->fsx_xflags & FS_XFLAG_COWEXTSIZE))
 		return 0;
@@ -1266,25 +1260,19 @@ xfs_ioctl_setattr_check_cowextsize(
 	    ip->i_d.di_version != 3)
 		return -EINVAL;
 
-	if (!S_ISREG(VFS_I(ip)->i_mode) && !S_ISDIR(VFS_I(ip)->i_mode))
-		return -EINVAL;
-
-	if (fa->fsx_cowextsize != 0) {
-		xfs_extlen_t    size;
-		xfs_fsblock_t   cowextsize_fsb;
+	if (fa->fsx_cowextsize == 0)
+		return 0;
 
-		cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
-		if (cowextsize_fsb > MAXEXTLEN)
-			return -EINVAL;
+	cowextsize_fsb = XFS_B_TO_FSB(mp, fa->fsx_cowextsize);
+	if (cowextsize_fsb > MAXEXTLEN)
+		return -EINVAL;
 
-		size = mp->m_sb.sb_blocksize;
-		if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
-			return -EINVAL;
+	size = mp->m_sb.sb_blocksize;
+	if (cowextsize_fsb > mp->m_sb.sb_agblocks / 2)
+		return -EINVAL;
 
-		if (fa->fsx_cowextsize % size)
-			return -EINVAL;
-	} else
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+	if (fa->fsx_cowextsize % size)
+		return -EINVAL;
 
 	return 0;
 }

