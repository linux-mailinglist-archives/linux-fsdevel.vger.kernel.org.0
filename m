Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165DD7784BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 03:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHKBFb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 21:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHKBFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:05:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD18F270F;
        Thu, 10 Aug 2023 18:05:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.29])
        by gateway (Coremail) with SMTP id _____8CxtPDviNVkOy8VAA--.45923S3;
        Fri, 11 Aug 2023 09:03:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.29])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDCPPiNVksBdUAA--.60067S3;
        Fri, 11 Aug 2023 09:03:39 +0800 (CST)
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Steve French <stfrench@microsoft.com>,
        Jens Axboe <axboe@kernel.dk>, David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v5 2/2] pipe: use __pipe_{lock,unlock} instead of spinlock
Date:   Fri, 11 Aug 2023 09:03:09 +0800
Message-Id: <20230811010309.20196-2-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230811010309.20196-1-zhanghongchen@loongson.cn>
References: <20230811010309.20196-1-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDCPPiNVksBdUAA--.60067S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAAB2TUY7EKdQABsa
X-Coremail-Antispam: 1Uk129KBj93XoW3JF4kWr45Cw1fKFyrZr4rXrc_yoW3GFW7pF
        WftrsrWrWUAr10g3yxGrsrur1Sg395WF4UJrW8GF40vF1DGryYgFZ2kFyakr4rJrs29a4Y
        vF4jqa4FvryUA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
        xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use spinlock in pipe_{read,write} cost too much time,IMO
pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
On the other hand, we can use __pipe_{lock,unlock} to protect
the pipe->{head,tail} in pipe_resize_ring and
post_one_notification.

The post_one_notification used in watch queue is in rcu lock and
spin lock,so we do some work to move the post_one_notification
out of rcu_read_lock and spin_lock_bh.The *disadvantage* of doing
so is that we can not use post_watch_notification in bottom half.

Reminded by Matthew, I tested this patch using UnixBench's pipe
test case on a x86_64 machine,and get the following data:
1) before this patch
System Benchmarks Partial Index  BASELINE       RESULT    INDEX
Pipe Throughput                   12440.0     493023.3    396.3
                                                        ========
System Benchmarks Index Score (Partial Only)              396.3

2) after this patch
System Benchmarks Partial Index  BASELINE       RESULT    INDEX
Pipe Throughput                   12440.0     507551.4    408.0
                                                        ========
System Benchmarks Index Score (Partial Only)              408.0

so we get ~3% speedup.

Reminded by Andrew, I tested this patch with the test code in
Linus's commit
commit 0ddad21d3e99 ("pipe: use exclusive waits when reading or writing")
and get following result:
1) before this patch
         13,136.54 msec task-clock           #    3.870 CPUs utilized
         1,186,779      context-switches     #   90.342 K/sec
           668,867      cpu-migrations       #   50.917 K/sec
               895      page-faults          #   68.131 /sec
    29,875,711,543      cycles               #    2.274 GHz
    12,372,397,462      instructions         #    0.41  insn per cycle
     2,480,235,723      branches             #  188.804 M/sec
        47,191,943      branch-misses        #    1.90% of all branches

       3.394806886 seconds time elapsed

       0.037869000 seconds user
       0.189346000 seconds sys

2) after this patch

         12,395.63 msec task-clock          #    4.138 CPUs utilized
         1,193,381      context-switches    #   96.274 K/sec
           585,543      cpu-migrations      #   47.238 K/sec
             1,063      page-faults         #   85.756 /sec
    27,691,587,226      cycles              #    2.234 GHz
    11,738,307,999      instructions        #    0.42  insn per cycle
     2,351,299,522      branches            #  189.688 M/sec
        45,404,526      branch-misses       #    1.93% of all branches

       2.995280878 seconds time elapsed

       0.010615000 seconds user
       0.206999000 seconds sys
After adding this patch, the time used on this test program becomes less.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>

v5:
  - fixes the error that use __pipe_lock in RCU lock + spin lock by
    moving the post_one_notification out of spin lock and unlock RCU
    before __pipe_lock.
v4:
  - fixes a typo in changelog when reviewed by Sedat.
v3:
  - fixes the error reported by kernel test robot <oliver.sang@intel.com>
    Link: https://lore.kernel.org/oe-lkp/202301061340.c954d61f-oliver.sang@intel.com
  - add perf stat data for the test code in Linus's 0ddad21d3e99 in
    commit message.
v2:
  - add UnixBench test data in commit message
  - fixes the test error reported by kernel test robot <lkp@intel.com>
    by adding the missing fs.h header file.
---
 fs/pipe.c                 | 22 +---------------------
 include/linux/pipe_fs_i.h | 12 ++++++++++++
 kernel/watch_queue.c      |  6 +++---
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 5c6b3daed938..ffbe05a26a0b 100644
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
@@ -507,16 +494,13 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -1268,14 +1252,12 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	if (unlikely(!bufs))
 		return -ENOMEM;
 
-	spin_lock_irq(&pipe->rd_wait.lock);
 	mask = pipe->ring_size - 1;
 	head = pipe->head;
 	tail = pipe->tail;
 
 	n = pipe_occupancy(head, tail);
 	if (nr_slots < n) {
-		spin_unlock_irq(&pipe->rd_wait.lock);
 		kfree(bufs);
 		return -EBUSY;
 	}
@@ -1311,8 +1293,6 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 	pipe->tail = tail;
 	pipe->head = head;
 
-	spin_unlock_irq(&pipe->rd_wait.lock);
-
 	/* This might have made more room for writers */
 	wake_up_interruptible(&pipe->wr_wait);
 	return 0;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index d2c3f16cf6b1..e97ff26216f3 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_PIPE_FS_I_H
 #define _LINUX_PIPE_FS_I_H
 
+#include <linux/fs.h>
+
 #define PIPE_DEF_BUFFERS	16
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
@@ -243,6 +245,16 @@ static inline void pipe_discard_from(struct pipe_inode_info *pipe,
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
index bd14f054ffb8..fb451c0dddf1 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -125,7 +125,7 @@ static bool post_one_notification(struct watch *watch,
 
 	rcu_read_unlock();
 
-	spin_lock_irq(&pipe->rd_wait.lock);
+	__pipe_lock(pipe);
 
 	mask = pipe->ring_size - 1;
 	head = pipe->head;
@@ -155,14 +155,14 @@ static bool post_one_notification(struct watch *watch,
 	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
 
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
 	do {
 		state = wqueue->state;
 	} while (cmpxchg(&wqueue->state, state, state - 1) != state);
-- 
2.33.0

