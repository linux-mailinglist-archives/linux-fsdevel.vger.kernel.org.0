Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E771BD288
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD2CqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:46:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgD2CqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2hjcc121531;
        Wed, 29 Apr 2020 02:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gIeAZYkuVVDyweFavOri/H5uxFdFvLW4QIrNOv2+naM=;
 b=xc+PP61xi/bU+9667oXO9wieCTD0n7tfrhIMeBqPrGaZMc/SdD6nPvwqt+MXPb6LZSjw
 k5U6SEkwjpqc2+vihk2K+srxcb9AIedEL+LUDySVXfi3deNIgHClwIwFDkRMxSdwwftN
 kW2P0hO4mpyhw269M8sjBbIslT+DhYA10LM1jFXSJOSySSSRRJogJLx3TTfyXacNzJhh
 Vo39gBKykL3rhWUIfmKnJNm7tlft9qHpIPAvnQnHnXKvUIeICBOys0+Ehb+V1cCT296u
 wIDovXlyg/ycd7bWSN4crd+bBENVcdNmcl/7Dr8vUVeBiTGfvgvNUI2P8OzJeRYXmnh8 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30p2p08p49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2fu9K096183;
        Wed, 29 Apr 2020 02:46:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30pvcytegs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:46:14 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2kD1S004048;
        Wed, 29 Apr 2020 02:46:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:46:12 -0700
Subject: [PATCH 18/18] xfs: fix quota accounting in the old fork swap code
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:46:11 -0700
Message-ID: <158812837189.168506.4738302671249782594.stgit@magnolia>
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

The old fork swapping code doesn't change quota counts when it swaps
data forks.  Fix it to do that.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |   10 ++++++++++
 1 file changed, 10 insertions(+)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index df373107e782..de6d1747a3fa 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1386,6 +1386,7 @@ xfs_swap_extent_forks(
 	xfs_filblks_t		aforkblks = 0;
 	xfs_filblks_t		taforkblks = 0;
 	xfs_extnum_t		junk;
+	int64_t			temp_blks;
 	uint64_t		tmp;
 	unsigned int		state;
 	int			src_log_flags = XFS_ILOG_CORE;
@@ -1432,6 +1433,15 @@ xfs_swap_extent_forks(
 	 */
 	swap(ip->i_df, tip->i_df);
 
+	/* Update quota accounting. */
+	temp_blks = tip->i_d.di_nblocks - taforkblks + aforkblks;
+	xfs_trans_mod_dquot_byino(*tpp, ip, XFS_TRANS_DQ_BCOUNT,
+			temp_blks - ip->i_d.di_nblocks);
+
+	temp_blks = ip->i_d.di_nblocks + taforkblks - aforkblks;
+	xfs_trans_mod_dquot_byino(*tpp, tip, XFS_TRANS_DQ_BCOUNT,
+			temp_blks - tip->i_d.di_nblocks);
+
 	/*
 	 * Fix the on-disk inode values
 	 */

