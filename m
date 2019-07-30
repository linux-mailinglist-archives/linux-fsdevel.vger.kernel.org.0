Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39B979DE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfG3BVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:21:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfG3BVI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:21:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U18kSh012339;
        Tue, 30 Jul 2019 01:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Os5IwwItgnQLKg0Xy/oNX8iCTAfTP7WjLMQIUeCU+4A=;
 b=5Z8rYioqZF3lpq++8Nu1eETPxDd1RSPZ3iI+HhxtMAc0zU2VjKjkD1T771etJ0cX1oeA
 sBcnidPDkHb8zDptl2pnLihcsEBnDF9d5ZauaC+ETN/ZNbW1gSwfP0zstIXq/u7sb6TL
 09zPgxGBTvs/iHVYjQMJN/Wb8oojHYpEw+L8Ove5qwMEQ6IYU9VaaDgpo4hg5CFObUDJ
 tByfHFJlkiUCAxdf9L6l1N3gWyNuOuc/M2nLcY6Ma/9Mmme2mfYMB6MO1lCZv/hy4XIP
 ZmGEUpoemErmhXb5+z8+6VeLduoiDBGAMroCLvuSutHXZJOrw7CmwmDwupcPhFaiWwLN gA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2u0e1tk5nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U1IP4G008348;
        Tue, 30 Jul 2019 01:18:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2u0xv7ufc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 01:18:54 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U1Isgw017353;
        Tue, 30 Jul 2019 01:18:54 GMT
Received: from localhost (/10.159.132.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 18:18:54 -0700
Subject: [PATCH 2/5] xfs: turn io_append_trans into an io_private void
 pointer
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien.LeMoal@wdc.com, Christoph Hellwig <hch@lst.de>,
        agruenba@redhat.com
Date:   Mon, 29 Jul 2019 18:18:53 -0700
Message-ID: <156444953370.2682520.16687269798277531218.stgit@magnolia>
In-Reply-To: <156444951713.2682520.8109813555788585092.stgit@magnolia>
References: <156444951713.2682520.8109813555788585092.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300010
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

In preparation for moving the ioend structure to common code we need
to get rid of the xfs-specific xfs_trans type.  Just make it a file
system private void pointer instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c |   26 +++++++++++++-------------
 fs/xfs/xfs_aops.h |    2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)


diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 8a1cd562a358..12f42922251c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -150,7 +150,7 @@ xfs_setfilesize_trans_alloc(
 	if (error)
 		return error;
 
-	ioend->io_append_trans = tp;
+	ioend->io_private = tp;
 
 	/*
 	 * We may pass freeze protection with a transaction.  So tell lockdep
@@ -217,7 +217,7 @@ xfs_setfilesize_ioend(
 	int			error)
 {
 	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-	struct xfs_trans	*tp = ioend->io_append_trans;
+	struct xfs_trans	*tp = ioend->io_private;
 
 	/*
 	 * The transaction may have been allocated in the I/O submission thread,
@@ -282,10 +282,10 @@ xfs_end_ioend(
 	else if (ioend->io_type == IOMAP_UNWRITTEN)
 		error = xfs_iomap_write_unwritten(ip, offset, size, false);
 	else
-		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_append_trans);
+		ASSERT(!xfs_ioend_is_append(ioend) || ioend->io_private);
 
 done:
-	if (ioend->io_append_trans)
+	if (ioend->io_private)
 		error = xfs_setfilesize_ioend(ioend, error);
 	xfs_destroy_ioends(ioend, error);
 	memalloc_nofs_restore(nofs_flag);
@@ -318,13 +318,13 @@ xfs_ioend_can_merge(
  * as it is guaranteed to be clean.
  */
 static void
-xfs_ioend_merge_append_transactions(
+xfs_ioend_merge_private(
 	struct xfs_ioend	*ioend,
 	struct xfs_ioend	*next)
 {
-	if (!ioend->io_append_trans) {
-		ioend->io_append_trans = next->io_append_trans;
-		next->io_append_trans = NULL;
+	if (!ioend->io_private) {
+		ioend->io_private = next->io_private;
+		next->io_private = NULL;
 	} else {
 		xfs_setfilesize_ioend(next, -ECANCELED);
 	}
@@ -346,8 +346,8 @@ xfs_ioend_try_merge(
 			break;
 		list_move_tail(&next->io_list, &ioend->io_list);
 		ioend->io_size += next->io_size;
-		if (next->io_append_trans)
-			xfs_ioend_merge_append_transactions(ioend, next);
+		if (next->io_private)
+			xfs_ioend_merge_private(ioend, next);
 	}
 }
 
@@ -410,7 +410,7 @@ xfs_end_bio(
 
 	if (ioend->io_fork == XFS_COW_FORK ||
 	    ioend->io_type == IOMAP_UNWRITTEN ||
-	    ioend->io_append_trans != NULL) {
+	    ioend->io_private) {
 		spin_lock_irqsave(&ip->i_ioend_lock, flags);
 		if (list_empty(&ip->i_ioend_list))
 			WARN_ON_ONCE(!queue_work(mp->m_unwritten_workqueue,
@@ -675,7 +675,7 @@ xfs_submit_ioend(
 	    (ioend->io_fork == XFS_COW_FORK ||
 	     ioend->io_type != IOMAP_UNWRITTEN) &&
 	    xfs_ioend_is_append(ioend) &&
-	    !ioend->io_append_trans)
+	    !ioend->io_private)
 		status = xfs_setfilesize_trans_alloc(ioend);
 
 	memalloc_nofs_restore(nofs_flag);
@@ -724,7 +724,7 @@ xfs_alloc_ioend(
 	ioend->io_inode = inode;
 	ioend->io_size = 0;
 	ioend->io_offset = offset;
-	ioend->io_append_trans = NULL;
+	ioend->io_private = NULL;
 	ioend->io_bio = bio;
 	return ioend;
 }
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index 4af8ec0115cd..6a45d675dcba 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -18,7 +18,7 @@ struct xfs_ioend {
 	struct inode		*io_inode;	/* file being written to */
 	size_t			io_size;	/* size of the extent */
 	xfs_off_t		io_offset;	/* offset in the file */
-	struct xfs_trans	*io_append_trans;/* xact. for size update */
+	void			*io_private;	/* file system private data */
 	struct bio		*io_bio;	/* bio being built */
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };

