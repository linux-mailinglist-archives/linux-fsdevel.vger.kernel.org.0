Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9018C2C01A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 09:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgKWIpi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 03:45:38 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33001 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727874AbgKWIpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:45:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UGEGdki_1606121126;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UGEGdki_1606121126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Nov 2020 16:45:35 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v3] iomap: set REQ_NOWAIT according to IOCB_NOWAIT in Direct IO
Date:   Mon, 23 Nov 2020 16:45:26 +0800
Message-Id: <1606121126-216843-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, IOCB_NOWAIT is ignored in Direct IO, REQ_NOWAIT is only set
when IOCB_HIPRI is set. But REQ_NOWAIT should be set as well when
IOCB_NOWAIT is set.

Suggested-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---

Hi all,
I tested fio io_uring direct read for a file on ext4 filesystem on a
nvme ssd. I found that IOCB_NOWAIT is ignored in iomap layer, which
means REQ_NOWAIT is not set in bio->bi_opf. This makes nowait IO a
normal IO. Since I'm new to iomap and block layer, I sincerely ask
yours opinions in case I misunderstand the code which is very likely
to happen.:)

I found that Konstantin found this issue before in May
2020 (https://www.spinics.net/lists/linux-block/msg53275.html), here add
his signature, add Jeffle's as well since he gave me some help.

v1->v2:
* add same logic in __blkdev_direct_IO_simple()
v2->v3:
* add same logic in do_blockdev_direct_IO()

 fs/block_dev.c       | 7 +++++++
 fs/direct-io.c       | 6 ++++--
 fs/iomap/direct-io.c | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..f3e9e13a9a9f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -263,6 +263,10 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 		bio.bi_opf = dio_bio_write_op(iocb);
 		task_io_account_write(ret);
 	}
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio.bi_opf |= REQ_NOWAIT;
+
 	if (iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(&bio, iocb);
 
@@ -424,6 +428,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 		if (!nr_pages) {
 			bool polled = false;
 
+			if (iocb->ki_flags & IOCB_NOWAIT)
+				bio->bi_opf |= REQ_NOWAIT;
+
 			if (iocb->ki_flags & IOCB_HIPRI) {
 				bio_set_polled(bio, iocb);
 				polled = true;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index d53fa92a1ab6..b221ed351c1c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1206,11 +1206,13 @@ static inline int drop_refcount(struct dio *dio)
 	if (iov_iter_rw(iter) == WRITE) {
 		dio->op = REQ_OP_WRITE;
 		dio->op_flags = REQ_SYNC | REQ_IDLE;
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			dio->op_flags |= REQ_NOWAIT;
 	} else {
 		dio->op = REQ_OP_READ;
 	}
+
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		dio->op_flags |= REQ_NOWAIT;
+
 	if (iocb->ki_flags & IOCB_HIPRI)
 		dio->op_flags |= REQ_HIPRI;
 
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..2e897688ed6d 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -64,6 +64,9 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 {
 	atomic_inc(&dio->ref);
 
+	if (dio->iocb->ki_flags & IOCB_NOWAIT)
+		bio->bi_opf |= REQ_NOWAIT;
+
 	if (dio->iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(bio, dio->iocb);
 
-- 
1.8.3.1

