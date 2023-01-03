Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AA965B985
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 04:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjACDEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 22:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACDEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 22:04:49 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B172F2733;
        Mon,  2 Jan 2023 19:04:46 -0800 (PST)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8AxhfBMm7NjCgsKAA--.21955S3;
        Tue, 03 Jan 2023 11:04:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+RFm7NjxKASAA--.59017S2;
        Tue, 03 Jan 2023 11:04:43 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pipe: use __pipe_{lock,unlock} instead of spinlock
Date:   Tue,  3 Jan 2023 11:03:29 +0800
Message-Id: <20230103030329.20252-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxb+RFm7NjxKASAA--.59017S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFW3Zw4xWw43AFyrGF45ZFb_yoW7Jw43pa
        13KFW7WrW8Ar18WrW8GwsxZr13W395Wa17JrWxGF1FvFnrGrySqFsFkFyakwn5JrZ7Zr90
        vF4jq3WFyr1UArJanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bS8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4U
        YxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use spinlock in pipe_read/write cost too much time,IMO
pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
On the other hand, we can use __pipe_{lock,unlock} to protect
the pipe->{head,tail} in pipe_resize_ring and
post_one_notification.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 fs/pipe.c                 | 24 ++++--------------------
 include/linux/pipe_fs_i.h | 10 ++++++++++
 kernel/watch_queue.c      |  8 ++++----
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..cf449779bf71 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -98,16 +98,6 @@ void pipe_unlock(struct pipe_inode_info *pipe)
 }
 EXPORT_SYMBOL(pipe_unlock);
 
-static inline void __pipe_lock(struct pipe_inode_info *pipe)
-{
-	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
-}
-
-static inline void __pipe_unlock(struct pipe_inode_info *pipe)
-{
-	mutex_unlock(&pipe->mutex);
-}
-
 void pipe_double_lock(struct pipe_inode_info *pipe1,
 		      struct pipe_inode_info *pipe2)
 {
@@ -253,8 +243,7 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	 */
 	was_full = pipe_full(pipe->head, pipe->tail, pipe->max_usage);
 	for (;;) {
-		/* Read ->head with a barrier vs post_one_notification() */
-		unsigned int head = smp_load_acquire(&pipe->head);
+		unsigned int head = pipe->head;
 		unsigned int tail = pipe->tail;
 		unsigned int mask = pipe->ring_size - 1;
 
@@ -322,14 +311,12 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 
 			if (!buf->len) {
 				pipe_buf_release(pipe, buf);
-				spin_lock_irq(&pipe->rd_wait.lock);
 #ifdef CONFIG_WATCH_QUEUE
 				if (buf->flags & PIPE_BUF_FLAG_LOSS)
 					pipe->note_loss = true;
 #endif
 				tail++;
 				pipe->tail = tail;
-				spin_unlock_irq(&pipe->rd_wait.lock);
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -506,16 +493,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 			 * it, either the reader will consume it or it'll still
 			 * be there for the next write.
 			 */
-			spin_lock_irq(&pipe->rd_wait.lock);
 
 			head = pipe->head;
 			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
-				spin_unlock_irq(&pipe->rd_wait.lock);
 				continue;
 			}
 
 			pipe->head = head + 1;
-			spin_unlock_irq(&pipe->rd_wait.lock);
 
 			/* Insert it into the buffer array */
 			buf = &pipe->bufs[head & mask];
@@ -1260,14 +1244,14 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	if (unlikely(!bufs))
 		return -ENOMEM;
 
-	spin_lock_irq(&pipe->rd_wait.lock);
+	__pipe_lock(pipe);
 	mask = pipe->ring_size - 1;
 	head = pipe->head;
 	tail = pipe->tail;
 
 	n = pipe_occupancy(head, tail);
 	if (nr_slots < n) {
-		spin_unlock_irq(&pipe->rd_wait.lock);
+		__pipe_unlock(pipe);
 		kfree(bufs);
 		return -EBUSY;
 	}
@@ -1303,7 +1287,7 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
-	spin_unlock_irq(&pipe->rd_wait.lock);
+	__pipe_unlock(pipe);
 
 	/* This might have made more room for writers */
 	wake_up_interruptible(&pipe->wr_wait);
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 6cb65df3e3ba..baae3d062422 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -223,6 +223,16 @@ static inline void pipe_discard_from(struct pipe_inode_info *pipe,
 #define PIPE_SIZE		PAGE_SIZE
 
 /* Pipe lock and unlock operations */
+static inline void __pipe_lock(struct pipe_inode_info *pipe)
+{
+	mutex_lock_nested(&pipe->mutex, I_MUTEX_PARENT);
+}
+
+static inline void __pipe_unlock(struct pipe_inode_info *pipe)
+{
+	mutex_unlock(&pipe->mutex);
+}
+
 void pipe_lock(struct pipe_inode_info *);
 void pipe_unlock(struct pipe_inode_info *);
 void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index a6f9bdd956c3..92e46cfe9419 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -108,7 +108,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (!pipe)
 		return false;
 
-	spin_lock_irq(&pipe->rd_wait.lock);
+	__pipe_lock(pipe);
 
 	mask = pipe->ring_size - 1;
 	head = pipe->head;
@@ -135,17 +135,17 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->offset = offset;
 	buf->len = len;
 	buf->flags = PIPE_BUF_FLAG_WHOLE;
-	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
+	pipe->head = head + 1;
 
 	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
-		spin_unlock_irq(&pipe->rd_wait.lock);
+		__pipe_unlock(pipe);
 		BUG();
 	}
 	wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	done = true;
 
 out:
-	spin_unlock_irq(&pipe->rd_wait.lock);
+	__pipe_unlock(pipe);
 	if (done)
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	return done;

base-commit: c8451c141e07a8d05693f6c8d0e418fbb4b68bb7
-- 
2.31.1

