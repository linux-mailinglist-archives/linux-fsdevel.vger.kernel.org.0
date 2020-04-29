Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D791BD278
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD2Cpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38980 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgD2Cpm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2iHT1122030;
        Wed, 29 Apr 2020 02:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=IGWm8WxAfDQAWkPKnJp2FO4bKIMqTYnORrHj1EplwQw=;
 b=CMrdJfyB3AXeMOO3DF7o3r3vYe6KLDpIPmde+qg5/207GXhmjv65JsBDVbZfotWPTXZj
 5L+mr99Fm7wt5AglVQZlTYqtX/3ovJz1lAL+A8YAjFLocXcDYWJqRmaSxPHGwyG/exiv
 bHyUEegjD9Zs9HXS/m/FNv3QGragXQrBBFRdDKrpDelj/oT+xiFqEVYJR5C8hhH6cxeE
 GzYqOYjYoMrRY+910PUy1hChwzT+lKqdHTB0AnSY2r8qgrInPS+P3GVrUMBYVjEEv6qD
 OVC88DI2ejCtR4aJzmo4+YYQGA5qMQojSrPK3SXj7FVAWPqrd/TT/I/rcpcJD8QM2JQQ Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p08p36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2ggTE071521;
        Wed, 29 Apr 2020 02:45:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30mxphp42u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:41 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2jeK6003831;
        Wed, 29 Apr 2020 02:45:40 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:40 -0700
Subject: [PATCH 13/18] xfs: allow xfs_swap_range to use older extent swap
 algorithms
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:39 -0700
Message-ID: <158812833911.168506.9347356534527509263.stgit@magnolia>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

If userspace permits non-atomic swap operations, use the older code
paths to implement the same functionality.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |   42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index a8bd2627d76e..72aebf7ed42d 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -2063,9 +2063,6 @@ xfs_swap_range(
 	unsigned int		sxflags = 0;
 	int			error;
 
-	if (!xfs_sb_version_hasatomicswap(&mp->m_sb))
-		return -EOPNOTSUPP;
-
 	startoff1 = XFS_B_TO_FSBT(mp, fsr->file1_offset);
 	startoff2 = XFS_B_TO_FSBT(mp, fsr->file2_offset);
 
@@ -2135,12 +2132,45 @@ xfs_swap_range(
 	if (error)
 		goto out_trans_cancel;
 
-	/* Perform the file range swap. */
 	if (fsr->flags & FILE_SWAP_RANGE_TO_EOF)
 		sxflags |= XFS_SWAPEXT_SET_SIZES;
 
-	error = xfs_swapext_atomic(&tp, ip1, ip2, XFS_DATA_FORK, startoff1,
-			startoff2, blockcount, sxflags);
+	/* Perform the file range swap... */
+	if (xfs_sb_version_hasatomicswap(&mp->m_sb)) {
+		/* ...by using the atomic swap, since it's available. */
+		error = xfs_swapext_atomic(&tp, ip1, ip2, XFS_DATA_FORK,
+				startoff1, startoff2, blockcount, sxflags);
+	} else if ((fsr->flags & FILE_SWAP_RANGE_NONATOMIC) &&
+		   (xfs_sb_version_hasreflink(&mp->m_sb) ||
+		    xfs_sb_version_hasrmapbt(&mp->m_sb))) {
+		/*
+		 * ...by using deferred bmap operations, which are only
+		 * supported if userspace is ok with a non-atomic swap
+		 * (e.g. xfs_fsr) and the log supports deferred bmap.
+		 */
+		error = xfs_swapext_deferred_bmap(&tp, ip1, ip2, XFS_DATA_FORK,
+				startoff1, startoff2, blockcount, sxflags);
+	} else if ((fsr->flags & FILE_SWAP_RANGE_NONATOMIC) &&
+		   !(fsr->flags & FILE_SWAP_RANGE_TO_EOF) &&
+		   fsr->file1_offset == 0 && fsr->file2_offset == 0 &&
+		   fsr->length == ip1->i_d.di_size &&
+		   fsr->length == ip2->i_d.di_size) {
+		/*
+		 * ...by using the old bmap owner change code, if we're doing
+		 * a full file swap and we're ok with non-atomic mode.
+		 */
+		error = xfs_swap_extents_check_format(ip2, ip1);
+		if (error) {
+			xfs_notice(mp,
+		"%s: inode 0x%llx format is incompatible for exchanging.",
+					__func__, ip2->i_ino);
+			goto out_trans_cancel;
+		}
+		error = xfs_swap_extent_forks(&tp, ip2, ip1);
+	} else {
+		/* ...or not at all, because we cannot do it. */
+		error = -EOPNOTSUPP;
+	}
 	if (error)
 		goto out_trans_cancel;
 

