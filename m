Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E80A2FAAA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437160AbhARTwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437648AbhARTwZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:52:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085EEC061575;
        Mon, 18 Jan 2021 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GFU7XYjfNerPPKIUP8QqhZ90IIH25bwdEuMGLrzjIrs=; b=moPv6CKiPo/0j/9fZ1CO+NV+QW
        J515yjKvjtjkNQ+o2dEJP0yAx5okvL1jpkwxtrMhrJvK8RJ0lnSPwDrs1Z2U7XmTCY0f9TTZGSMkq
        0vdEiAcV91+cyT4CMCh7tJbzAC0WWAJ+oqyLEflCVSfQMm/fA5RxPWXHTbhUjFSsCbuRwqZsS3RDv
        WJZ8aSUUV9ecADad6BLsCUHUe6gvgX6JHrxXU/M7zc18+HgA1iYWt3rB8YKHUkcPJK0cEzoFYM2x8
        EQdjvnnem31tu+arERmMxikaIcd+JL79JW+TRQ0yVwdOSwS66tz9GNTPAqmEo4TC7kppotX19JPt8
        opFOloNw==;
Received: from 089144206130.atnat0015.highway.bob.at ([89.144.206.130] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l1aYt-00DJxA-7s; Mon, 18 Jan 2021 19:51:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, avi@scylladb.com,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 06/11] xfs: improve the reflink_bounce_dio_write tracepoint
Date:   Mon, 18 Jan 2021 20:35:11 +0100
Message-Id: <20210118193516.2915706-7-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118193516.2915706-1-hch@lst.de>
References: <20210118193516.2915706-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use a more suitable event class.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
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

