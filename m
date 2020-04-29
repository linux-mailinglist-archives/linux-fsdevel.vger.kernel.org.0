Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6081BD29D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgD2CrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:47:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49830 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgD2Cq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2he7u073293;
        Wed, 29 Apr 2020 02:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3YiNEmjLje5pTnDILa7dhgmHUAljMFp/iVyWS1P2I/g=;
 b=Hs5zWGvTMi0OHn9FGpU7UweyHoVAVJbr8twbMI+ygQ6INGnmugUcZYCkTsiGNPoyDU8i
 zIVID11kvhqEQ6S6mtSP6jfRhTIOoFgoQKwo2OA4zZoedISk4Byv6x0mUITHaTaJhASA
 1GnfVfK1V2cxJaWr7YKrKW3P7v1+uIqi2ipP4zWggJNapZQVDKh/+53s+GWZqJPgJ1j9
 sUAlPp75JiwqM7kZlW5kwIcBG6cCw/7UN2auIMBf4dJg+NzVNdIodl2PZvkCSDKXfmBs
 UbZ2lNpsovNAicpDeFQndffb0d2cT/40xgGOQra6dmKN+KpYP6c3V7AtW+meGqUEIreu Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg39s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2ggFX071513;
        Wed, 29 Apr 2020 02:44:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30mxphp247-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2it6S022586;
        Wed, 29 Apr 2020 02:44:55 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:44:55 -0700
Subject: [PATCH 06/18] xfs: create a log incompat flag for atomic extent
 swapping
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:44:52 -0700
Message-ID: <158812829237.168506.10231967263101202625.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=1
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=1 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Create a log incompat flag so that we only attempt to process swap
extent log items if the filesystem supports it.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_format.h |   11 ++++++++++-
 fs/xfs/libxfs/xfs_fs.h     |    1 +
 fs/xfs/libxfs/xfs_sb.c     |    2 ++
 fs/xfs/xfs_super.c         |    4 ++++
 4 files changed, 17 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index 34babf402e14..63ed62a92c9c 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -500,7 +500,10 @@ xfs_sb_has_incompat_feature(
 	return (sbp->sb_features_incompat & feature) != 0;
 }
 
-#define XFS_SB_FEAT_INCOMPAT_LOG_ALL 0
+#define XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP (1 << 0)
+#define XFS_SB_FEAT_INCOMPAT_LOG_ALL \
+		(XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP)
+
 #define XFS_SB_FEAT_INCOMPAT_LOG_UNKNOWN	~XFS_SB_FEAT_INCOMPAT_LOG_ALL
 static inline bool
 xfs_sb_has_incompat_log_feature(
@@ -614,6 +617,12 @@ static inline bool xfs_sb_version_hasrtrmapbt(struct xfs_sb *sbp)
 	       xfs_sb_version_hasrmapbt(sbp);
 }
 
+static inline bool xfs_sb_version_hasatomicswap(struct xfs_sb *sbp)
+{
+	return XFS_SB_VERSION_NUM(sbp) == XFS_SB_VERSION_5 &&
+		(sbp->sb_features_log_incompat & XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP);
+}
+
 /*
  * end of superblock version macros
  */
diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index c5b75082b9db..d278ca5731e4 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -251,6 +251,7 @@ typedef struct xfs_fsop_resblks {
 #define XFS_FSOP_GEOM_FLAGS_RMAPBT	(1 << 19) /* reverse mapping btree */
 #define XFS_FSOP_GEOM_FLAGS_REFLINK	(1 << 20) /* files can share blocks */
 #define XFS_FSOP_GEOM_FLAGS_BIGTIME	(1 << 21) /* 64-bit nsec timestamps */
+#define XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP	(1 << 22) /* atomic swapext */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index c50f589824f0..16094fd1a75e 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1205,6 +1205,8 @@ xfs_fs_geometry(
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_REFLINK;
 	if (xfs_sb_version_hasbigtime(sbp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_BIGTIME;
+	if (xfs_sb_version_hasatomicswap(sbp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_ATOMIC_SWAP;
 	if (xfs_sb_version_hassector(sbp))
 		geo->logsectsize = sbp->sb_logsectsize;
 	else
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index a17e824c6084..42d82c9d2a1d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1647,6 +1647,10 @@ xfs_fc_fill_super(
 		xfs_warn(mp,
  "EXPERIMENTAL inode btree counters feature in use. Use at your own risk!");
 
+	if (xfs_sb_version_hasatomicswap(&mp->m_sb))
+		xfs_warn(mp,
+ "EXPERIMENTAL atomic file range swap feature in use. Use at your own risk!");
+
 	error = xfs_mountfs(mp);
 	if (error)
 		goto out_filestream_unmount;

