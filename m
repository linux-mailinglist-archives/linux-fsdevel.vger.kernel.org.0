Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2982B777F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 08:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKRHwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 02:52:23 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:32923 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbgKRHwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:52:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=haoxu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UFn7O05_1605685931;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:haoxu@linux.alibaba.com fp:SMTPD_---0UFn7O05_1605685931)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Nov 2020 15:52:18 +0800
From:   Hao Xu <haoxu@linux.alibaba.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC] iomap: set REQ_NOWAIT according to IOCB_NOWAIT in Direct IO
Date:   Wed, 18 Nov 2020 15:52:11 +0800
Message-Id: <1605685931-207023-1-git-send-email-haoxu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, IOCB_NOWAIT is ignored in direct io, REQ_NOWAIT is only set
when IOCB_HIPRI is set. But REQ_NOWAIT should be set as well when
IOCB_NOWAIT is set.

Signed-off-by: Hao Xu <haoxu@linux.alibaba.com>
---

Hi all,
I tested fio io_uring direct read for a file on ext4 filesystem on a
nvme ssd. I found that IOCB_NOWAIT is ignored in iomap layer, which
means REQ_NOWAIT is not set in bio->bi_opf. This makes nowait IO a
normal IO. Since I'm new to iomap and block layer, I sincerely ask
yours opinions in case I misunderstand the code which is very likely
to happen.:)

 fs/block_dev.c       | 3 +++
 fs/iomap/direct-io.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b94..b7db3b7e2ba1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -424,6 +424,9 @@ static void blkdev_bio_end_io(struct bio *bio)
 		if (!nr_pages) {
 			bool polled = false;
 
+			if ((iocb->ki_flags & IOCB_NOWAIT) && !is_sync)
+				bio->bi_opf |= REQ_NOWAIT;
+
 			if (iocb->ki_flags & IOCB_HIPRI) {
 				bio_set_polled(bio, iocb);
 				polled = true;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..22f7488bf5e5 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -64,6 +64,9 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 {
 	atomic_inc(&dio->ref);
 
+	if ((dio->iocb->ki_flags & IOCB_NOWAIT) && !is_sync_kiocb(dio->iocb))
+		bio->bi_opf |= REQ_NOWAIT;
+
 	if (dio->iocb->ki_flags & IOCB_HIPRI)
 		bio_set_polled(bio, dio->iocb);
 
-- 
1.8.3.1

