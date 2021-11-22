Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A190C458883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 04:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKVEC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Nov 2021 23:02:29 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31895 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhKVEC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Nov 2021 23:02:28 -0500
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HyD0t6jRrzcZxf;
        Mon, 22 Nov 2021 11:54:22 +0800 (CST)
Received: from kwepemm600019.china.huawei.com (7.193.23.64) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 11:59:21 +0800
Received: from localhost.localdomain (10.175.127.227) by
 kwepemm600019.china.huawei.com (7.193.23.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 11:59:21 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <dhowells@redhat.com>, <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] pipe: remove needless spin_lock in pipe_read/pipe_write
Date:   Mon, 22 Nov 2021 12:11:35 +0800
Message-ID: <20211122041135.2450220-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600019.china.huawei.com (7.193.23.64)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Once enable CONFIG_WATCH_QUEUE, we should protect pipe with
pipe->rd_wait.lock since post_one_notification may write pipe from
contexts where pipe->mutex cannot be token. But nowdays we will try
take it for anycase, it seems needless. Besides, pipe_write will break
once it's pipe with O_NOTIFICATION_PIPE, pipe->rd_wait.lock seems no
need at all. We make some change base on that, and it can help improve
performance for some case like pipe_pst1 in libMicro.

ARMv7 for our scene, before this patch:
  5483 nsecs/call
After this patch:
  4854 nsecs/call

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/pipe.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 6d4342bad9f1..e8ced0c50824 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -320,14 +320,18 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				spin_lock_irq(&pipe->rd_wait.lock);
 #ifdef CONFIG_WATCH_QUEUE
+				if (pipe->watch_queue)
+					spin_lock_irq(&pipe->rd_wait.lock);
 				if (buf->flags & PIPE_BUF_FLAG_LOSS)
 					pipe->note_loss = true;
 #endif
 				tail++;
 				pipe->tail = tail;
-				spin_unlock_irq(&pipe->rd_wait.lock);
+#ifdef CONFIG_WATCH_QUEUE
+				if (pipe->watch_queue)
+					spin_unlock_irq(&pipe->rd_wait.lock);
+#endif
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -504,16 +508,11 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * it, either the reader will consume it or it'll still
 			 * be there for the next write.
 			 */
-			spin_lock_irq(&pipe->rd_wait.lock);
-
 			head = pipe->head;
-			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
-				spin_unlock_irq(&pipe->rd_wait.lock);
+			if (pipe_full(head, pipe->tail, pipe->max_usage))
 				continue;
-			}
 
 			pipe->head = head + 1;
-			spin_unlock_irq(&pipe->rd_wait.lock);
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
-- 
2.31.1

