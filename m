Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96AD9E8496
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2019 10:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfJ2JlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Oct 2019 05:41:00 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:38503 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728575AbfJ2JlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:41:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tgcc4Gu_1572342047;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tgcc4Gu_1572342047)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Oct 2019 17:40:48 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] fs/iomap: remove redundant check in iomap_dio_rw()
Date:   Tue, 29 Oct 2019 17:40:47 +0800
Message-Id: <1572342047-99933-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We've already check if it is READ iov_iter, no need check again.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2..9712648 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -430,7 +430,7 @@ static void iomap_dio_bio_end_io(struct bio *bio)
 		if (pos >= dio->i_size)
 			goto out_free_dio;
 
-		if (iter_is_iovec(iter) && iov_iter_rw(iter) == READ)
+		if (iter_is_iovec(iter))
 			dio->flags |= IOMAP_DIO_DIRTY;
 	} else {
 		flags |= IOMAP_WRITE;
-- 
1.8.3.1

