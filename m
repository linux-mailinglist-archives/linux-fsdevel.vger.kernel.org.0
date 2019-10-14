Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08371D5D5E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 10:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbfJNI0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 04:26:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60204 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730350AbfJNI0M (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:26:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CBB3B43E;
        Mon, 14 Oct 2019 08:26:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B713F1E4A88; Mon, 14 Oct 2019 10:26:10 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, darrick.wong@oracle.com,
        <linux-xfs@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] xfs: Use iomap_dio_rw_wait()
Date:   Mon, 14 Oct 2019 10:26:03 +0200
Message-Id: <20191014082610.6298-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191014082418.13885-1-jack@suse.cz>
References: <20191014082418.13885-1-jack@suse.cz>
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

