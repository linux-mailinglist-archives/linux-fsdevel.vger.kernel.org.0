Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FC528EDD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgJOHkh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:40:37 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35124 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728036AbgJOHkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:40:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC4rANt_1602747632;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UC4rANt_1602747632)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 15:40:32 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [v2 1/2] block: disable iopoll for split bio
Date:   Thu, 15 Oct 2020 15:40:30 +0800
Message-Id: <20201015074031.91380-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
References: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

IOpoll is initially for small size, latency sensitive IO.

It doesn't work well for big IO, especially when it needs to be split to
multiple bios. When it comes to bio split, the returned cookie of
__submit_bio_noacct_mq() is indeed the cookie of the last split bio. The
completion of *this* last split bio done by iopoll doesn't mean the whole
original bio has completed. Callers of iopoll still need to wait for
completion of other split bios.

Besides bio splitting may cause more trouble for iopoll which isn't
supposed to be used in case of big IO.

IOpoll for split bio may cause potential race if CPU migration happens
during bio submission. Since the returned cookie is that of the last
split bio of, polling on the corresponding hardware queue doesn't help
complete other split bios, if these split bios are enqueued into
different hardware queues. Since interrupts are disabled for polling
queues, the completion of these other split bios depends on timeout
mechanism, thus causing a potential IO hang.

IOpoll for split bio may also cause hang for sync polling. Currently
both the blkdev and iomap-based fs (ext4/xfs, etc) support sync polling
in direct IO routine. These routines will submit bio without REQ_NOWAIT
flag set, and then start sync polling in current process context. The
process may hang in blk_mq_get_tag() if the submitted bio has to be
split into multiple bios and can rapidly exhaust the queue depth. The
process are waiting for the completion of the previously allocated
requests, which should be done by the following polling, and thus causing
a deadlock.

To avoid these subtle trouble described above, just disable iopoll for
split bio.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 block/blk-merge.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bcf5e4580603..dafd5ec65545 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -279,6 +279,22 @@ static struct bio *blk_bio_segment_split(struct request_queue *q,
 	return NULL;
 split:
 	*segs = nsegs;
+
+	/*
+	 * IOpoll is initially for small size, latency sensitive IO.
+	 *
+	 * It doesn't work well for big IO, especially when it needs to be split to
+	 * multiple bios. When it comes to bio split, the returned cookie of
+	 * __submit_bio_noacct_mq() is indeed the cookie of the last split bio. The
+	 * completion of *this* last split bio done by polling doesn't mean the whole
+	 * original bio has completed. Callers of polling still need to wait for
+	 * completion of other split bios.
+	 *
+	 * Besides bio splitting may cause more trouble for iopoll which isn't supposed
+	 * to be used in case of big IO.
+	 */
+	bio->bi_opf &= ~REQ_HIPRI;
+
 	return bio_split(bio, sectors, GFP_NOIO, bs);
 }
 
-- 
2.27.0

