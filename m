Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D41BD28F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgD2Cqb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:46:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49528 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgD2Cqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2h6cM072910;
        Wed, 29 Apr 2020 02:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0qxyctrjdQ6j6nuMWFNiHvvebUDRZj79SaRpQZaKPrg=;
 b=t0mjEXnZM1rKerwKQliovyKy9mMYRBrSYHAKjKmrPj+6JvNBcs2VsvT9x+LvDx1O1QJ9
 2vBWVJSA88qAw0G33ihNJCqfvRAP4WvJ7LbOTRPWmRqVI8vPJCpbyY1rd2CQi4mlC0le
 1RQ45aQfVo4JGO8mljPcqcNZ0V950lcgm7D2CQvAvrPedwpdXIvb7IVHT3WzzrEMQL0k
 tNdykI5XAlHZL1CMdn5ZAT28B4/nnlIvzum6wyLl5rQtumIDij2tjHnzjl+RjvFi7mZB
 IobDBduWunacnKtZ1Nx3R5YglS3DstzyCz9N9poD4OLEBXXrkCGISfZHmHs3ziSAQXws TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg39rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2gg0X071549;
        Wed, 29 Apr 2020 02:44:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30mxphp13m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:28 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2iSLr022423;
        Wed, 29 Apr 2020 02:44:28 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:44:27 -0700
Subject: [PATCH 02/18] xfs: fix xfs_reflink_remap_prep calling conventions
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:44:26 -0700
Message-ID: <158812826681.168506.8309047158870409011.stgit@magnolia>
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

Fix the return value of xfs_reflink_remap_prep so that its calling
conventions match the rest of xfs.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_file.c    |    2 +-
 fs/xfs/xfs_reflink.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 994fd3d59872..1759fbcbcd46 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1029,7 +1029,7 @@ xfs_file_remap_range(
 	/* Prepare and then clone file data. */
 	ret = xfs_reflink_remap_prep(file_in, pos_in, file_out, pos_out,
 			&len, remap_flags);
-	if (ret < 0 || len == 0)
+	if (ret || len == 0)
 		return ret;
 
 	trace_xfs_reflink_remap_range(src, pos_in, len, dest, pos_out);
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index d8c8b299cb1f..5e978d1f169d 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1375,7 +1375,7 @@ xfs_reflink_remap_prep(
 	struct inode		*inode_out = file_inode(file_out);
 	struct xfs_inode	*dest = XFS_I(inode_out);
 	bool			same_inode = (inode_in == inode_out);
-	ssize_t			ret;
+	int			ret;
 
 	/* Lock both files against IO */
 	ret = xfs_iolock_two_inodes_and_break_layout(inode_in, inode_out);
@@ -1399,7 +1399,7 @@ xfs_reflink_remap_prep(
 
 	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
 			len, remap_flags);
-	if (ret < 0 || *len == 0)
+	if (ret || *len == 0)
 		goto out_unlock;
 
 	/* Attach dquots to dest inode before changing block map */
@@ -1434,7 +1434,7 @@ xfs_reflink_remap_prep(
 	if (ret)
 		goto out_unlock;
 
-	return 1;
+	return 0;
 out_unlock:
 	xfs_reflink_remap_unlock(file_in, file_out);
 	return ret;

