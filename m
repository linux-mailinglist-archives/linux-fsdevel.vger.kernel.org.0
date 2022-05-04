Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF38519AC8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347353AbiEDIzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346738AbiEDIxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:24 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2602F24F12
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:49:21 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 4 May 2022 17:19:20 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 4 May 2022 17:19:20 +0900
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
Subject: [PATCH RFC v6 06/21] dept: Apply Dept to wait_for_completion()/complete()
Date:   Wed,  4 May 2022 17:17:34 +0900
Message-Id: <1651652269-15342-7-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by
wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h | 44 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/completion.c  | 12 ++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 51d9ab0..358c656 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -26,14 +26,45 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
+#ifdef CONFIG_DEPT
+#define dept_wfc_nocheck(m)			dept_map_nocheck(m)
+#define dept_wfc_init(m, k, s, n)		dept_map_init(m, k, s, n)
+#define dept_wfc_reinit(m)			dept_map_reinit(m)
+#define dept_wfc_wait(m, ip)						\
+do {									\
+	dept_ask_event(m);						\
+	dept_wait(m, 1UL, ip, __func__, 0);				\
+} while (0)
+#define dept_wfc_complete(m, ip)		dept_event(m, 1UL, ip, __func__)
+#define dept_wfc_enter(m, ip)			dept_ecxt_enter(m, 1UL, ip, "completion_context_enter", "complete", 0)
+#define dept_wfc_exit(m, ip)			dept_ecxt_exit(m, 1UL, ip)
+#else
+#define dept_wfc_nocheck(m)			do { } while (0)
+#define dept_wfc_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_wfc_reinit(m)			do { } while (0)
+#define dept_wfc_wait(m, ip)			do { } while (0)
+#define dept_wfc_complete(m, ip)		do { } while (0)
+#define dept_wfc_enter(m, ip)			do { } while (0)
+#define dept_wfc_exit(m, ip)			do { } while (0)
+#endif
+
+#define init_completion_nocheck(x) __init_completion(x, NULL, #x, false)
+#define init_completion(x)					\
+	do {							\
+		static struct dept_key __dkey;			\
+		__init_completion(x, &__dkey, #x, true);	\
+	} while (0)
+
 #define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	  .dmap = DEPT_MAP_INITIALIZER(work) }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -81,9 +112,17 @@ static inline void complete_release(struct completion *x) {}
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x,
+				     struct dept_key *dkey,
+				     const char *name, bool check)
 {
 	x->done = 0;
+
+	if (check)
+		dept_wfc_init(&x->dmap, dkey, 0, name);
+	else
+		dept_wfc_nocheck(&x->dmap);
+
 	init_swait_queue_head(&x->wait);
 }
 
@@ -97,6 +136,7 @@ static inline void init_completion(struct completion *x)
 static inline void reinit_completion(struct completion *x)
 {
 	x->done = 0;
+	dept_wfc_reinit(&x->dmap);
 }
 
 extern void wait_for_completion(struct completion *);
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 35f15c2..4cf0cfe 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -29,6 +29,7 @@ void complete(struct completion *x)
 {
 	unsigned long flags;
 
+	dept_wfc_complete(&x->dmap, _RET_IP_);
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 
 	if (x->done != UINT_MAX)
@@ -58,6 +59,7 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
+	dept_wfc_complete(&x->dmap, _RET_IP_);
 	lockdep_assert_RT_in_threaded_ctx();
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
@@ -112,17 +114,23 @@ void complete_all(struct completion *x)
 }
 
 static long __sched
-wait_for_common(struct completion *x, long timeout, int state)
+_wait_for_common(struct completion *x, long timeout, int state)
 {
 	return __wait_for_common(x, schedule_timeout, timeout, state);
 }
 
 static long __sched
-wait_for_common_io(struct completion *x, long timeout, int state)
+_wait_for_common_io(struct completion *x, long timeout, int state)
 {
 	return __wait_for_common(x, io_schedule_timeout, timeout, state);
 }
 
+#define wait_for_common(x, t, s)					\
+({ dept_wfc_wait(&(x)->dmap, _RET_IP_); _wait_for_common(x, t, s); })
+
+#define wait_for_common_io(x, t, s)					\
+({ dept_wfc_wait(&(x)->dmap, _RET_IP_); _wait_for_common_io(x, t, s); })
+
 /**
  * wait_for_completion: - waits for completion of a task
  * @x:  holds the state of this particular completion
-- 
1.9.1

