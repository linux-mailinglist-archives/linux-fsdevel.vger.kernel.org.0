Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5D321925A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 23:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGHVTv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 17:19:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHVTu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:19:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A659EAC91;
        Wed,  8 Jul 2020 21:19:49 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page invalidation fails
Date:   Wed,  8 Jul 2020 16:19:22 -0500
Message-Id: <20200708211926.7706-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708211926.7706-1-rgoldwyn@suse.de>
References: <20200708211926.7706-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
that if the page invalidation fails, return back control to the
filesystem so it may fallback to buffered mode.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c  |  8 +++++++-
 include/linux/iomap.h | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 2753b7022403..66becf935865 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -484,8 +484,14 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	 */
 	ret = invalidate_inode_pages2_range(mapping,
 			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
-	if (ret)
+	if (ret) {
+		if (dio_flags & IOMAP_DIO_RWF_NO_STALE_PAGECACHE) {
+			if (ret == -EBUSY)
+				ret = 0;
+			goto out_free_dio;
+		}
 		dio_warn_stale_pagecache(iocb->ki_filp);
+	}
 	ret = 0;
 
 	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 80cd5f524124..a68705369a2c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -262,7 +262,21 @@ struct iomap_dio_ops {
 /*
  * Wait for completion of DIO
  */
+
 #define IOMAP_DIO_RWF_SYNCIO			(1 << 0)
+/*
+ * Direct IO will attempt to keep the page cache coherent by
+ * invalidating the inode's page cache over the range of the DIO.
+ * That can fail if something else is actively using the page cache.
+ * If this happens and the DIO continues, the data in the page
+ * cache will become stale.
+ *
+ * Set this flag if you want the DIO to abort without issuing any IO
+ * or error if it fails to invalidate the page cache successfully.
+ * This allows the IO submitter to fallback to buffered IO to resubmit
+ * IO
+ */
+#define IOMAP_DIO_RWF_NO_STALE_PAGECACHE	(1 << 1)
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-- 
2.26.2

