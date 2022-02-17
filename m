Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAA64B9E35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 12:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbiBQK65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 05:58:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiBQK6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:58:44 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD27A140C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Feb 2022 02:58:01 -0800 (PST)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 17 Feb 2022 19:58:00 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 17 Feb 2022 19:58:00 +0900
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
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH 13/16] dept: Apply SDT to swait
Date:   Thu, 17 Feb 2022 19:57:49 +0900
Message-Id: <1645095472-26530-14-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
References: <1645095472-26530-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes SDT able to track dependencies by swait.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/swait.h |  4 ++++
 kernel/sched/swait.c  | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index 6a8c22b..dbdf2ce 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -6,6 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 #include <asm/current.h>
 
 /*
@@ -43,6 +44,7 @@
 struct swait_queue_head {
 	raw_spinlock_t		lock;
 	struct list_head	task_list;
+	struct dept_map		dmap;
 };
 
 struct swait_queue {
@@ -61,6 +63,7 @@ struct swait_queue {
 #define __SWAIT_QUEUE_HEAD_INITIALIZER(name) {				\
 	.lock		= __RAW_SPIN_LOCK_UNLOCKED(name.lock),		\
 	.task_list	= LIST_HEAD_INIT((name).task_list),		\
+	.dmap		= DEPT_SDT_MAP_INIT(name),			\
 }
 
 #define DECLARE_SWAIT_QUEUE_HEAD(name)					\
@@ -72,6 +75,7 @@ extern void __init_swait_queue_head(struct swait_queue_head *q, const char *name
 #define init_swait_queue_head(q)				\
 	do {							\
 		static struct lock_class_key __key;		\
+		sdt_map_init(&(q)->dmap);			\
 		__init_swait_queue_head((q), #q, &__key);	\
 	} while (0)
 
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e1c655f..4ca7d6e 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -27,6 +27,7 @@ void swake_up_locked(struct swait_queue_head *q)
 		return;
 
 	curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
+	sdt_event(&q->dmap);
 	wake_up_process(curr->task);
 	list_del_init(&curr->task_list);
 }
@@ -69,6 +70,7 @@ void swake_up_all(struct swait_queue_head *q)
 	while (!list_empty(&tmp)) {
 		curr = list_first_entry(&tmp, typeof(*curr), task_list);
 
+		sdt_event(&q->dmap);
 		wake_up_state(curr->task, TASK_NORMAL);
 		list_del_init(&curr->task_list);
 
@@ -97,6 +99,9 @@ void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *
 	__prepare_to_swait(q, wait);
 	set_current_state(state);
 	raw_spin_unlock_irqrestore(&q->lock, flags);
+
+	if (state & TASK_NORMAL)
+		sdt_wait_prepare(&q->dmap);
 }
 EXPORT_SYMBOL(prepare_to_swait_exclusive);
 
@@ -119,12 +124,16 @@ long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait
 	}
 	raw_spin_unlock_irqrestore(&q->lock, flags);
 
+	if (!ret && state & TASK_NORMAL)
+		sdt_wait_prepare(&q->dmap);
+
 	return ret;
 }
 EXPORT_SYMBOL(prepare_to_swait_event);
 
 void __finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
+	sdt_wait_finish();
 	__set_current_state(TASK_RUNNING);
 	if (!list_empty(&wait->task_list))
 		list_del_init(&wait->task_list);
@@ -134,6 +143,7 @@ void finish_swait(struct swait_queue_head *q, struct swait_queue *wait)
 {
 	unsigned long flags;
 
+	sdt_wait_finish();
 	__set_current_state(TASK_RUNNING);
 
 	if (!list_empty_careful(&wait->task_list)) {
-- 
1.9.1

