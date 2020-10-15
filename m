Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC428EDD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgJOHki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:40:38 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51410 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbgJOHki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:40:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC4gbiG_1602747632;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UC4gbiG_1602747632)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 15:40:32 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [v2 2/2] block,iomap: disable iopoll when split needed
Date:   Thu, 15 Oct 2020 15:40:31 +0800
Message-Id: <20201015074031.91380-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
References: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both blkdev fs and iomap-based fs (ext4, xfs, etc.) currently support
sync iopoll. One single bio can contain at most BIO_MAX_PAGES, i.e. 256
bio_vec. If the input iov_iter contains more than 256 segments, then
the IO request described by this iov_iter will be split into multiple
bios, which may cause potential deadlock for sync iopoll.

When it comes to sync iopoll, the bio is submitted without REQ_NOWAIT
flag set and the process may hang in blk_mq_get_tag() if the input
iov_iter has to be split into multiple bios and thus rapidly exhausts
the queue depth. The process has to wait for the completion of the
previously allocated requests, which should be done by the following
sync polling, and thus causing a deadlock.

Actually there's subtle difference between the behaviour of handling
HIPRI IO of blkdev and iomap, when the input iov_iter need to split
into multiple bios. blkdev will set REQ_HIPRI for only the last split
bio, leaving the previous bio queued into normal hardware queues, which
will not cause the trouble described above though. iomap will set
REQ_HIPRI for all bios split from one iov_iter, and thus may cause the
potential deadlock decribed above.

Disable iopoll when one request need to be split into multiple bios.
Though blkdev may not suffer the problem, still it may not make much
sense to iopoll for big IO, since iopoll is initially for small size,
latency sensitive IO.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/block_dev.c       | 7 +++++++
 fs/iomap/direct-io.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..a8a52cab15ab 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -491,6 +491,13 @@ blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
 		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
 
+	/*
+	 * IOpoll is initially for small size, latency sensitive IO.
+	 * Disable iopoll if split needed.
+	 */
+	if (nr_pages > BIO_MAX_PAGES)
+		iocb->ki_flags &= ~IOCB_HIPRI;
+
 	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
 }
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..1628f9ff311a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -249,10 +249,17 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	orig_count = iov_iter_count(dio->submit.iter);
 	iov_iter_truncate(dio->submit.iter, length);
 
-	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES + 1);
 	if (nr_pages <= 0) {
 		ret = nr_pages;
 		goto out;
+	} else if (nr_pages > BIO_MAX_PAGES) {
+		/*
+		 * IOpoll is initially for small size, latency sensitive IO.
+		 * Disable iopoll if split needed.
+		 */
+		nr_pages = BIO_MAX_PAGES;
+		dio->iocb->ki_flags &= ~IOCB_HIPRI;
 	}
 
 	if (need_zeroout) {
-- 
2.27.0

