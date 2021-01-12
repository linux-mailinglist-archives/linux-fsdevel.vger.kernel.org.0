Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE12F35C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 17:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392553AbhALQ3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 11:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbhALQ3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:29:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011EC06179F;
        Tue, 12 Jan 2021 08:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=H5Kv9GFu92dBZshU/odIxv1jiQpPK3aeEAKOZWn8gXs=; b=HPQieJT2BSxfeNwOPPGdYQAHLp
        qqai5xG6lRXecVwxG7It/LJBBzgBC9M5unmXpNBcqZTuu2ypKWlPdTpfyJ6EjDqSWovdJhx7V67OA
        H2mlFRH8qEQl3OMgTxABr7wew6mRbMoEKWRlmqGmRSSXhAhikb7BHR8P19NNTFaNwdkCzNklWjH97
        eKu3qd0tiET9vtUo9uyuC2hWlYsam5ujc60rYqqttkaAHNR356JtKysu1Mqs+4NvbAMbtlLW8gbOp
        RaAKYYZoZLycCW4fLqwPgXrVWylxYdc2yeuzZnzE8kYISOvwSGrRW80nzUpk1/7bIiit2MzQ7q4lL
        jePOcPWg==;
Received: from [2001:4bb8:19b:e528:5ff5:c533:abbf:c8ac] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzMWb-0052Dx-6q; Tue, 12 Jan 2021 16:28:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com
Subject: [PATCH 06/10] xfs: improve the reflink_bounce_dio_write tracepoint
Date:   Tue, 12 Jan 2021 17:26:12 +0100
Message-Id: <20210112162616.2003366-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112162616.2003366-1-hch@lst.de>
References: <20210112162616.2003366-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a more suitable event class.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_trace.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index aa64e78fc3c467..a696bd34f71d21 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -560,7 +560,7 @@ xfs_file_dio_write(
 		 * files yet, as we can't unshare a partial block.
 		 */
 		if (xfs_is_cow_inode(ip)) {
-			trace_xfs_reflink_bounce_dio_write(ip, iocb->ki_pos, count);
+			trace_xfs_reflink_bounce_dio_write(iocb, from);
 			return -ENOTBLK;
 		}
 		iolock = XFS_IOLOCK_EXCL;
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index a6d04d860a565e..0cfd65cd67c190 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1321,6 +1321,8 @@ DEFINE_RW_EVENT(xfs_file_dax_read);
 DEFINE_RW_EVENT(xfs_file_buffered_write);
 DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
+DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
+
 
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
@@ -3294,8 +3296,6 @@ DEFINE_INODE_IREC_EVENT(xfs_reflink_cow_found);
 DEFINE_INODE_IREC_EVENT(xfs_reflink_cow_enospc);
 DEFINE_INODE_IREC_EVENT(xfs_reflink_convert_cow);
 
-DEFINE_SIMPLE_IO_EVENT(xfs_reflink_bounce_dio_write);
-
 DEFINE_SIMPLE_IO_EVENT(xfs_reflink_cancel_cow_range);
 DEFINE_SIMPLE_IO_EVENT(xfs_reflink_end_cow);
 DEFINE_INODE_IREC_EVENT(xfs_reflink_cow_remap);
-- 
2.29.2

