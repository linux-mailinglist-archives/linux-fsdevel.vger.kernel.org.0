Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62638203ABF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgFVPZW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:25:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbgFVPZU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:25:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60F27C19F;
        Mon, 22 Jun 2020 15:25:18 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, dsterba@suse.cz, jthumshirn@suse.de,
        fdmanana@gmail.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/6] iomap: IOMAP_DIOF_PGINVALID_FAIL return if page invalidation fails
Date:   Mon, 22 Jun 2020 10:24:53 -0500
Message-Id: <20200622152457.7118-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622152457.7118-1-rgoldwyn@suse.de>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The flag indicates that if the page invalidation fails, it should return
back control to the filesystem so it may fallback to buffered mode.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c  | 8 +++++++-
 include/linux/iomap.h | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 7ed857196a39..20c4370e6b1b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -484,8 +484,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	ret = invalidate_inode_pages2_range(mapping,
 			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	if (ret)
+	if (ret) {
+		if (dio_flags & IOMAP_DIOF_PGINVALID_FAIL) {
+			if (ret == -EBUSY)
+				ret = 0;
+			goto out_free_dio;
+		}
 		dio_warn_stale_pagecache(iocb->ki_filp);
+	}
 	ret = 0;
 
 	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index f6230446b08d..95024e28dec5 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -261,6 +261,11 @@ struct iomap_dio_ops {
 
 /* Wait for completion of DIO */
 #define IOMAP_DIOF_WAIT_FOR_COMPLETION 		0x1
+/*
+ * Return zero if page invalidation fails, so caller filesystem may fallback
+ * to buffered I/O
+ */
+#define IOMAP_DIOF_PGINVALID_FAIL		0x2
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-- 
2.25.0

