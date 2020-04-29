Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6E1BD259
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgD2CoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:44:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2CoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:44:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2hH0C121431;
        Wed, 29 Apr 2020 02:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=guhVmQ0pe2mThZ/0Ink7Hxjr6GB/qhtjtXsZIhi+oxk=;
 b=OVG7nKcuYHwbt7YU5WUTzUKQd39S2ORYVy2afxs55XR3nHaWKg2Z3Nqv4tUDuBhWrVlR
 zz21WR8ZgrJMk/ovdjLpoZ9mer4//n+aDlS1+e2PGeLXyFAnM8eNqzrzcPl6x0DBT1cc
 GJGosulBKZsYyU71J4Uu90T2VABThHRfafc07qCTMZU8p1QQAuWGt1orWEQUqPBSeWyY
 dfsvLjLAz9moeYF8FNwocFgS3+djt69qQ5I4z4wcstUDDlewAsoDdjF1EzovN7dvXkmt
 +Tz1lDtwgOYFOKFDyXpjyf+Ugs6D4eD9y977ZcA39iI8TiHC1vGnnfQ/FVBYgp91Hx5r ZA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30p2p08p0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2g6nL096345;
        Wed, 29 Apr 2020 02:44:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30pvcytckj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:44:22 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03T2iL6G022398;
        Wed, 29 Apr 2020 02:44:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:44:21 -0700
Subject: [PATCH 01/18] xfs: clean up the error handling in
 xfs_swap_extent_rmap
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:44:20 -0700
Message-ID: <158812826049.168506.1665433119534581837.stgit@magnolia>
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

Clean up the error handling and make sure we actually bail out if
there's something not right with either file's fork mappings or we
couldn't clear all the COW extents.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_bmap_util.c |   33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)


diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index cfd6e64661ba..746bb0c8271c 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -1393,8 +1393,16 @@ xfs_swap_extent_rmap(
 				&nimaps, 0);
 		if (error)
 			goto out;
-		ASSERT(nimaps == 1);
-		ASSERT(tirec.br_startblock != DELAYSTARTBLOCK);
+		if (nimaps != 1 || tirec.br_startblock == DELAYSTARTBLOCK) {
+			/*
+			 * We should never get no mapping or a delalloc extent
+			 * since the donor file should have been flushed by the
+			 * caller.
+			 */
+			ASSERT(0);
+			error = -EINVAL;
+			goto out;
+		}
 
 		trace_xfs_swap_extent_rmap_remap(tip, &tirec);
 		ilen = tirec.br_blockcount;
@@ -1411,8 +1419,17 @@ xfs_swap_extent_rmap(
 					&nimaps, 0);
 			if (error)
 				goto out;
-			ASSERT(nimaps == 1);
-			ASSERT(tirec.br_startoff == irec.br_startoff);
+			if (nimaps != 1 ||
+			    tirec.br_startoff != irec.br_startoff) {
+				/*
+				 * We should never get no mapping or a mapping
+				 * for another offset, but bail out if that
+				 * ever does.
+				 */
+				ASSERT(0);
+				error = -EFSCORRUPTED;
+				goto out;
+			}
 			trace_xfs_swap_extent_rmap_remap_piece(ip, &irec);
 
 			/* Trim the extent. */
@@ -1451,11 +1468,9 @@ xfs_swap_extent_rmap(
 		offset_fsb += ilen;
 	}
 
-	tip->i_d.di_flags2 = tip_flags2;
-	return 0;
-
 out:
-	trace_xfs_swap_extent_rmap_error(ip, error, _RET_IP_);
+	if (error)
+		trace_xfs_swap_extent_rmap_error(ip, error, _RET_IP_);
 	tip->i_d.di_flags2 = tip_flags2;
 	return error;
 }
@@ -1657,7 +1672,7 @@ xfs_swap_extents(
 	if (xfs_inode_has_cow_data(tip)) {
 		error = xfs_reflink_cancel_cow_range(tip, 0, NULLFILEOFF, true);
 		if (error)
-			return error;
+			goto out_unlock;
 	}
 
 	/*

