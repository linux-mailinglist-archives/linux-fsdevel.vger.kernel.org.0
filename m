Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F655519AB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347232AbiEDIyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346828AbiEDIxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:45 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A112725C5F
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:49:23 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 4 May 2022 17:19:21 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 4 May 2022 17:19:21 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: [PATCH RFC v6 13/21] dept: Apply SDT to wait(waitqueue)
Date:   Wed,  4 May 2022 17:17:41 +0900
Message-Id: <1651652269-15342-14-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes SDT able to track dependencies by wait(waitqueue).

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/wait.h |  6 +++++-
 kernel/sched/wait.c  | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 851e07d..e637585 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -7,6 +7,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/dept_sdt.h>
 
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
@@ -37,6 +38,7 @@ struct wait_queue_entry {
 struct wait_queue_head {
 	spinlock_t		lock;
 	struct list_head	head;
+	struct dept_map		dmap;
 };
 typedef struct wait_queue_head wait_queue_head_t;
 
@@ -56,7 +58,8 @@ struct wait_queue_head {
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {					\
 	.lock		= __SPIN_LOCK_UNLOCKED(name.lock),			\
-	.head		= LIST_HEAD_INIT(name.head) }
+	.head		= LIST_HEAD_INIT(name.head),				\
+	.dmap		= DEPT_MAP_INITIALIZER(name) }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
 	struct wait_queue_head name = __WAIT_QUEUE_HEAD_INITIALIZER(name)
@@ -67,6 +70,7 @@ struct wait_queue_head {
 	do {									\
 		static struct lock_class_key __key;				\
 										\
+		sdt_map_init(&(wq_head)->dmap);					\
 		__init_waitqueue_head((wq_head), #wq_head, &__key);		\
 	} while (0)
 
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 9860bb9..d67d0dc4 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -104,6 +104,7 @@ static int __wake_up_common(struct wait_queue_head *wq_head, unsigned int mode,
 		if (flags & WQ_FLAG_BOOKMARK)
 			continue;
 
+		sdt_event(&wq_head->dmap);
 		ret = curr->func(curr, mode, wake_flags, key);
 		if (ret < 0)
 			break;
@@ -267,6 +268,9 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head)
 		__add_wait_queue(wq_head, wq_entry);
 	set_current_state(state);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
+
+	if (state & TASK_NORMAL)
+		sdt_wait_prepare(&wq_head->dmap);
 }
 EXPORT_SYMBOL(prepare_to_wait);
 
@@ -285,6 +289,10 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head)
 	}
 	set_current_state(state);
 	spin_unlock_irqrestore(&wq_head->lock, flags);
+
+	if (state & TASK_NORMAL)
+		sdt_wait_prepare(&wq_head->dmap);
+
 	return was_empty;
 }
 EXPORT_SYMBOL(prepare_to_wait_exclusive);
@@ -330,6 +338,9 @@ long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_en
 	}
 	spin_unlock_irqrestore(&wq_head->lock, flags);
 
+	if (!ret && state & TASK_NORMAL)
+		sdt_wait_prepare(&wq_head->dmap);
+
 	return ret;
 }
 EXPORT_SYMBOL(prepare_to_wait_event);
@@ -351,7 +362,9 @@ int do_wait_intr(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 		return -ERESTARTSYS;
 
 	spin_unlock(&wq->lock);
+	sdt_wait_prepare(&wq->dmap);
 	schedule();
+	sdt_wait_finish();
 	spin_lock(&wq->lock);
 
 	return 0;
@@ -368,7 +381,9 @@ int do_wait_intr_irq(wait_queue_head_t *wq, wait_queue_entry_t *wait)
 		return -ERESTARTSYS;
 
 	spin_unlock_irq(&wq->lock);
+	sdt_wait_prepare(&wq->dmap);
 	schedule();
+	sdt_wait_finish();
 	spin_lock_irq(&wq->lock);
 
 	return 0;
@@ -388,6 +403,7 @@ void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_en
 {
 	unsigned long flags;
 
+	sdt_wait_finish();
 	__set_current_state(TASK_RUNNING);
 	/*
 	 * We can check for list emptiness outside the lock
-- 
1.9.1

