Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9230D4281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfJKOOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 10:14:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbfJKOOh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:14:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 825AEAF4C;
        Fri, 11 Oct 2019 14:14:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9E3E81E3F02; Fri, 11 Oct 2019 16:14:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, <linux-xfs@vger.kernel.org>,
        darrick.wong@oracle.com, Dave Chinner <david@fromorbit.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] xfs: Use iomap_dio_rw_wait()
Date:   Fri, 11 Oct 2019 16:14:32 +0200
Message-Id: <20191011141433.18354-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191011125520.11697-1-jack@suse.cz>
References: <20191011125520.11697-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use iomap_dio_rw() to wait for unaligned direct IO instead of opencoding
the wait.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/xfs/xfs_file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 0739ba72a82e..c0620135a279 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -547,16 +547,12 @@ xfs_file_dio_aio_write(
 	}
 
 	trace_xfs_file_direct_write(ip, count, iocb->ki_pos);
-	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
-			   is_sync_kiocb(iocb));
-
 	/*
-	 * If unaligned, this is the only IO in-flight. If it has not yet
-	 * completed, wait on it before we release the iolock to prevent
-	 * subsequent overlapping IO.
+	 * If unaligned, this is the only IO in-flight. Wait on it before we
+	 * release the iolock to prevent subsequent overlapping IO.
 	 */
-	if (ret == -EIOCBQUEUED && unaligned_io)
-		inode_dio_wait(inode);
+	ret = iomap_dio_rw(iocb, from, &xfs_iomap_ops, &xfs_dio_write_ops,
+			   is_sync_kiocb(iocb) || unaligned_io);
 out:
 	xfs_iunlock(ip, iolock);
 
-- 
2.16.4

