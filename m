Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EA21BD281
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD2CqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:46:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49306 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgD2CqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2he7s073293;
        Wed, 29 Apr 2020 02:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EPCmgnSkWHytMY4lHYcCnHjXuq/7Jt5u158xA5I6pVg=;
 b=WCvV237kF3cm/jODqLiOdP1wSGz//u+KrNhMTTrF5tz7BH6q6hHFfy4Ti28SZLIMOhgL
 fzLB8LGDJ2ash7SDZtfY7efePzuiVTTEAW00yftpNku3dfvCC7wjPXdh7G4NOjjiQfSz
 a8rsJSEtc6fcE0CJ7Eqx6q5cLUvdFrggGySevknGBnTB/G1Fl+EX0ih2SE1z2FpejbAy
 VHW83o5QRddO6w6PiPqI26rq/yMk0W/O2cWOk4zWXAccxDv0d5pbFE1gs00hBprkmf4H
 oIac4d164mGSAPMOCp7DjJD24toR4d7lVTsULHisJqbyFwQogjbyyhWku9//Y9/Bfg8M lA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30nucg39qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2ggoW071530;
        Wed, 29 Apr 2020 02:46:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30mxphp4st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03T2k0CS016247;
        Wed, 29 Apr 2020 02:46:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:46:00 -0700
Subject: [PATCH 16/18] xfs: refactor reflink flag handling in
 xfs_swap_extent_forks
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:59 -0700
Message-ID: <158812835926.168506.1546972667821869337.stgit@magnolia>
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

Refactor the old data fork swap function to use the new reflink flag
helpers to propagate reflink flags between the two files.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |   34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 1767f1586c46..639b42b1d568 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1404,10 +1404,14 @@ xfs_swap_extent_forks(
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
 	uint64_t		tmp;
+	unsigned int		state;
 	int			src_log_flags = XFS_ILOG_CORE;
 	int			target_log_flags = XFS_ILOG_CORE;
 	int			error;
 
+	state = xfs_swapext_reflink_prep(ip, tip, XFS_DATA_FORK, 0, 0,
+			XFS_B_TO_FSB(ip->i_mount, i_size_read(VFS_I(ip))));
+
 	/*
 	 * Count the number of extended attribute blocks
 	 */
@@ -1490,35 +1494,7 @@ xfs_swap_extent_forks(
 		break;
 	}
 
-	/* Do we have to swap reflink flags? */
-	if ((ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK) ^
-	    (tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK)) {
-		uint64_t	f;
-
-		f = ip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		ip->i_d.di_flags2 |= tip->i_d.di_flags2 & XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 &= ~XFS_DIFLAG2_REFLINK;
-		tip->i_d.di_flags2 |= f & XFS_DIFLAG2_REFLINK;
-	}
-
-	/* Swap the cow forks. */
-	if (xfs_sb_version_hasreflink(&ip->i_mount->m_sb)) {
-		ASSERT(ip->i_cformat == XFS_DINODE_FMT_EXTENTS);
-		ASSERT(tip->i_cformat == XFS_DINODE_FMT_EXTENTS);
-
-		swap(ip->i_cnextents, tip->i_cnextents);
-		swap(ip->i_cowfp, tip->i_cowfp);
-
-		if (ip->i_cowfp && ip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(ip);
-		else
-			xfs_inode_clear_cowblocks_tag(ip);
-		if (tip->i_cowfp && tip->i_cowfp->if_bytes)
-			xfs_inode_set_cowblocks_tag(tip);
-		else
-			xfs_inode_clear_cowblocks_tag(tip);
-	}
+	xfs_swapext_reflink_finish(*tpp, ip, tip, state);
 
 	xfs_trans_log_inode(*tpp, ip,  src_log_flags);
 	xfs_trans_log_inode(*tpp, tip, target_log_flags);

