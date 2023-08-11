Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4557784B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 03:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjHKBDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 21:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHKBDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:03:40 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12BDE270C;
        Thu, 10 Aug 2023 18:03:36 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.29])
        by gateway (Coremail) with SMTP id _____8BxJvHniNVkLi8VAA--.45854S3;
        Fri, 11 Aug 2023 09:03:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.180.13.29])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDCPPiNVksBdUAA--.60067S2;
        Fri, 11 Aug 2023 09:03:33 +0800 (CST)
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
Subject: [PATCH v5 1/2] watch_queue: refactor post_one_notification
Date:   Fri, 11 Aug 2023 09:03:08 +0800
Message-Id: <20230811010309.20196-1-zhanghongchen@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDCPPiNVksBdUAA--.60067S2
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAAB2TUY7EKdAAAsa
X-Coremail-Antispam: 1Uk129KBj93XoWxJw48ZryUXF1kur47Gw1fXwc_yoWrtryrp3
        yDKFy8ua18Zr429rW3Jw1UuwnIgryrXFW7JryxG34fAr1qgr1Fgr4vk34Y9r1rGrZ5Cr45
        Xr1jgFsY9rWUZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
        6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
        AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
        0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
        v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
        xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor post_one_notification so that we can lock pipe using
sleepable lock.

Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
---
 fs/pipe.c                   |  5 +++-
 include/linux/watch_queue.h | 14 ++++++++++-
 kernel/watch_queue.c        | 47 +++++++++++++++++++++++++++----------
 3 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 2d88f73f585a..5c6b3daed938 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -834,8 +834,11 @@ void free_pipe_info(struct pipe_inode_info *pipe)
 	unsigned int i;
 
 #ifdef CONFIG_WATCH_QUEUE
-	if (pipe->watch_queue)
+	if (pipe->watch_queue) {
 		watch_queue_clear(pipe->watch_queue);
+		smp_cond_load_relaxed(&pipe->watch_queue->state,
+				(VAL & WATCH_QUEUE_POST_CNT_MASK) == 0);
+	}
 #endif
 
 	(void) account_pipe_buffers(pipe->user, pipe->nr_accounted, 0);
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index fc6bba20273b..1db3eee2137a 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -35,6 +35,7 @@ struct watch_filter {
 	struct watch_type_filter filters[];
 };
 
+#define WATCH_QUEUE_POST_CNT_MASK GENMASK(30, 0)
 struct watch_queue {
 	struct rcu_head		rcu;
 	struct watch_filter __rcu *filter;
@@ -46,7 +47,18 @@ struct watch_queue {
 	spinlock_t		lock;
 	unsigned int		nr_notes;	/* Number of notes */
 	unsigned int		nr_pages;	/* Number of pages in notes[] */
-	bool			defunct;	/* T when queues closed */
+	union {
+		struct {
+#ifdef __LITTLE_ENDIAN
+			u32	post_cnt:31;	/* How many threads are posting notification */
+			u32	defunct:1;	/* T when queues closed */
+#else
+			u32	defunct:1;	/* T when queues closed */
+			u32	post_cnt:31;	/* How many threads are posting notification */
+#endif
+		};
+		u32	state;
+	};
 };
 
 /*
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index e91cb4c2833f..bd14f054ffb8 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -33,6 +33,8 @@ MODULE_AUTHOR("Red Hat, Inc.");
 #define WATCH_QUEUE_NOTE_SIZE 128
 #define WATCH_QUEUE_NOTES_PER_PAGE (PAGE_SIZE / WATCH_QUEUE_NOTE_SIZE)
 
+static void put_watch(struct watch *watch);
+
 /*
  * This must be called under the RCU read-lock, which makes
  * sure that the wqueue still exists. It can then take the lock,
@@ -88,24 +90,40 @@ static const struct pipe_buf_operations watch_queue_pipe_buf_ops = {
 };
 
 /*
- * Post a notification to a watch queue.
- *
- * Must be called with the RCU lock for reading, and the
- * watch_queue lock held, which guarantees that the pipe
- * hasn't been released.
+ * Post a notification to a watch queue with RCU lock held.
  */
-static bool post_one_notification(struct watch_queue *wqueue,
+static bool post_one_notification(struct watch *watch,
 				  struct watch_notification *n)
 {
 	void *p;
-	struct pipe_inode_info *pipe = wqueue->pipe;
+	struct watch_queue *wqueue;
+	struct pipe_inode_info *pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
 	unsigned int head, tail, mask, note, offset, len;
 	bool done = false;
+	u32 state;
+
+	if (!kref_get_unless_zero(&watch->usage))
+		return false;
+	wqueue = rcu_dereference(watch->queue);
+
+	pipe = wqueue->pipe;
 
-	if (!pipe)
+	if (!pipe) {
+		put_watch(watch);
 		return false;
+	}
+
+	do {
+		if (wqueue->defunct) {
+			put_watch(watch);
+			return false;
+		}
+		state = wqueue->state;
+	} while (cmpxchg(&wqueue->state, state, state + 1) != state);
+
+	rcu_read_unlock();
 
 	spin_lock_irq(&pipe->rd_wait.lock);
 
@@ -145,6 +163,12 @@ static bool post_one_notification(struct watch_queue *wqueue,
 
 out:
 	spin_unlock_irq(&pipe->rd_wait.lock);
+	do {
+		state = wqueue->state;
+	} while (cmpxchg(&wqueue->state, state, state - 1) != state);
+
+	rcu_read_lock();
+	put_watch(watch);
 	if (done)
 		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	return done;
@@ -224,10 +248,7 @@ void __post_watch_notification(struct watch_list *wlist,
 		if (security_post_notification(watch->cred, cred, n) < 0)
 			continue;
 
-		if (lock_wqueue(wqueue)) {
-			post_one_notification(wqueue, n);
-			unlock_wqueue(wqueue);
-		}
+		post_one_notification(watch, n);
 	}
 
 	rcu_read_unlock();
@@ -560,8 +581,8 @@ int remove_watch_from_object(struct watch_list *wlist, struct watch_queue *wq,
 
 	wqueue = rcu_dereference(watch->queue);
 
+	post_one_notification(watch, &n.watch);
 	if (lock_wqueue(wqueue)) {
-		post_one_notification(wqueue, &n.watch);
 
 		if (!hlist_unhashed(&watch->queue_node)) {
 			hlist_del_init_rcu(&watch->queue_node);

base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
-- 
2.33.0

