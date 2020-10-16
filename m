Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46762901B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405448AbgJPJS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 05:18:56 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60455 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406076AbgJPJSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:18:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBA.FS_1602839932;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UCBA.FS_1602839932)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 17:18:52 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH v3 2/2] block,iomap: disable iopoll when split needed
Date:   Fri, 16 Oct 2020 17:18:51 +0800
Message-Id: <20201016091851.93728-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201016091851.93728-1-jefflexu@linux.alibaba.com>
References: <20201016091851.93728-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Both blkdev fs and iomap-based fs (ext4, xfs, etc.) currently support
sync iopoll. One single bio can contain at most BIO_MAX_PAGES, i.e. 256
bio_vec. If the input iov_iter contains more than 256 segments, then
one dio will be split into multiple bios, which may cause potential
deadlock for sync iopoll.

When it comes to sync iopoll, the bio is submitted without REQ_NOWAIT
flag set and the process may hang in blk_mq_get_tag() if the dio needs
to be split into multiple bios and thus can rapidly exhausts the queue
depth. The process has to wait for the completion of the previously
allocated requests, which should be reaped by the following sync
polling, and thus causing a deadlock.

In fact there's a subtle difference of handling of HIPRI IO between
blkdev fs and iomap-based fs, when dio need to be split into multiple
bios. blkdev fs will set REQ_HIPRI for only the last split bio, leaving
the previous bios queued into normal hardware queues, and not causing
the trouble described above. iomap-based fs will set REQ_HIPRI for all
split bios, and thus may cause the potential deadlock decribed above.

Thus disable iopoll when one dio need to be split into multiple bios.
Though blkdev fs may not suffer this issue, still it may not make much
sense to iopoll for big IO, since iopoll is initially for small size,
latency sensitive IO.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/block_dev.c       | 7 +++++++
 fs/iomap/direct-io.c | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..1b56b39e35b5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -436,6 +436,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			break;
 		}
 
+		/*
+		 * The current dio need to be split into multiple bios here.
+		 * iopoll is initially for small size, latency sensitive IO,
+		 * and thus disable iopoll if split needed.
+		 */
+		iocb->ki_flags &= ~IOCB_HIPRI;
+
 		if (!dio->multi_bio) {
 			/*
 			 * AIO needs an extra reference to ensure the dio
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c1aafb2ab990..46668cceefd2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -308,6 +308,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		/*
+		 * The current dio need to be split into multiple bios here.
+		 * iopoll is initially for small size, latency sensitive IO,
+		 * and thus disable iopoll if split needed.
+		 */
+		if (nr_pages)
+			dio->iocb->ki_flags &= ~IOCB_HIPRI;
+
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
 	} while (nr_pages);
-- 
2.27.0

