Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD0E1BD269
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2CpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:45:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51158 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgD2CpD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:45:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2hc3B155889;
        Wed, 29 Apr 2020 02:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=HzxgoLgrQNxMCxmiaUI1HbQLBUqMyDyOBwJ0LWxYPCQ=;
 b=WcTrs97Vho/OLOXwhVU+K24oByfK1javS281zht/FuMmIHNsUnW1XQiJEystvt4f+09+
 T2dleHBsltlycpqAOTHqF5Qb95F8rNtW1VwS+ubqtptmhlFOMZcNVZMTNO93ZSwJOslD
 F6A57x1KhQmzD6T6Ghtd7YE5w2d3C2pUEBrrm7B5Y+n1BSA0fYThoQMiLMIDfVmdC5Du
 d/WlI9PJpns4t5If8mvPu+/mVyy40JtnJgoSVU+x0HSSdsh9Stvw55n13ZB0ju++vqfY
 h78dZCBPz2gOQJGnfFRONReDXiTP4+9DL32aaffZuDdKu+WBw03uifoWF2FaAo6U2R2k aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30p01nsthf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03T2g3wB039228;
        Wed, 29 Apr 2020 02:45:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30mxru049u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 02:45:02 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03T2j1vJ015858;
        Wed, 29 Apr 2020 02:45:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 19:45:01 -0700
Subject: [PATCH 07/18] xfs: allow deferred ops items to put themselves at
 the end of the pending queue
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Tue, 28 Apr 2020 19:45:00 -0700
Message-ID: <158812830045.168506.2200063100219298803.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
References: <158812825316.168506.932540609191384366.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=3
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501 mlxscore=0
 suspectscore=3 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004290020
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Allow individual deferred op ->finish_item functions to decide that they
want to yield to all other deferred ops that might need processing.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/libxfs/xfs_defer.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 1cab95cef399..f53e3ce858eb 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -69,10 +69,10 @@
  *   - For each work item attached to the log intent item,
  *     * Perform the described action.
  *     * Attach the work item to the log done item.
- *     * If the result of doing the work was -EAGAIN, ->finish work
- *       wants a new transaction.  See the "Requesting a Fresh
- *       Transaction while Finishing Deferred Work" section below for
- *       details.
+ *     * If the result of doing the work was -EAGAIN or -EMULTIHOP,
+ *       ->finish work wants a new transaction.  See the "Requesting a
+ *       Fresh Transaction while Finishing Deferred Work" section below
+ *       for details.
  *
  * The key here is that we must log an intent item for all pending
  * work items every time we roll the transaction, and that we must log
@@ -108,6 +108,13 @@
  * required that ->finish_item must be careful to leave enough
  * transaction reservation to fit the new log intent item.
  *
+ * If ->finish_item returns -EMULTIHOP, defer_finish will log the new
+ * intent item with the remaining work items but it will move the
+ * xfs_defer_pending item to a separate queue.  The separate queue
+ * will be put back into the pending list at the very end of processing
+ * after all other pending items (including ones that were created as
+ * part of finishing other items) have been processed.
+ *
  * This is an example of remapping the extent (E, E+B) into file X at
  * offset A and dealing with the extent (C, C+B) already being mapped
  * there:
@@ -365,12 +372,14 @@ xfs_defer_finish_noroll(
 	int				error = 0;
 	const struct xfs_defer_op_type	*ops;
 	LIST_HEAD(dop_pending);
+	LIST_HEAD(dop_endofline);
 
 	ASSERT((*tp)->t_flags & XFS_TRANS_PERM_LOG_RES);
 
 	trace_xfs_defer_finish(*tp, _RET_IP_);
 
 	/* Until we run out of pending work to finish... */
+again:
 	while (!list_empty(&dop_pending) || !list_empty(&(*tp)->t_dfops)) {
 		/* log intents and pull in intake items */
 		xfs_defer_create_intents(*tp);
@@ -398,7 +407,7 @@ xfs_defer_finish_noroll(
 			dfp->dfp_count--;
 			error = ops->finish_item(*tp, li, dfp->dfp_done,
 					&state);
-			if (error == -EAGAIN) {
+			if (error == -EAGAIN || error == -EMULTIHOP) {
 				/*
 				 * Caller wants a fresh transaction;
 				 * put the work item back on the list
@@ -418,7 +427,7 @@ xfs_defer_finish_noroll(
 				goto out;
 			}
 		}
-		if (error == -EAGAIN) {
+		if (error == -EAGAIN || error == -EMULTIHOP) {
 			/*
 			 * Caller wants a fresh transaction, so log a
 			 * new log intent item to replace the old one
@@ -431,6 +440,8 @@ xfs_defer_finish_noroll(
 			dfp->dfp_done = NULL;
 			list_for_each(li, &dfp->dfp_work)
 				ops->log_item(*tp, dfp->dfp_intent, li);
+			if (error == -EMULTIHOP)
+				list_move_tail(&dfp->dfp_list, &dop_endofline);
 		} else {
 			/* Done with the dfp, free it. */
 			list_del(&dfp->dfp_list);
@@ -441,8 +452,14 @@ xfs_defer_finish_noroll(
 			ops->finish_cleanup(*tp, state, error);
 	}
 
+	if (!list_empty(&dop_endofline)) {
+		list_splice_tail_init(&dop_endofline, &dop_pending);
+		goto again;
+	}
+
 out:
 	if (error) {
+		list_splice_tail_init(&dop_endofline, &dop_pending);
 		xfs_defer_trans_abort(*tp, &dop_pending);
 		xfs_force_shutdown((*tp)->t_mountp, SHUTDOWN_CORRUPT_INCORE);
 		trace_xfs_defer_finish_error(*tp, error);

