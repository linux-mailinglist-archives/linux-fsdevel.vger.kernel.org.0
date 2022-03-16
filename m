Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F6E4DA846
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353254AbiCPCaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353136AbiCPC3N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:29:13 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0C115F256
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:27:13 -0700 (PDT)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 16 Mar 2022 11:27:11 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 16 Mar 2022 11:27:11 +0900
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
        hamohammed.sa@gmail.com
Subject: [PATCH RFC v5 17/21] dept: Distinguish each work from another
Date:   Wed, 16 Mar 2022 11:26:29 +0900
Message-Id: <1647397593-16747-18-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
References: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Workqueue already provides concurrency control. By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let Dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 672a762..3d24a52 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -491,6 +491,7 @@ struct dept_task {
 extern void dept_event_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *e_fn);
 extern void dept_ask_event_split_map(struct dept_map_each *me, struct dept_map_common *mc);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -535,6 +536,7 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 #define dept_event_split_map(me, mc, ip, e_fn)		do { } while (0)
 #define dept_ask_event_split_map(me, mc)		do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 8d8d8eb..10801783 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1886,6 +1886,16 @@ void dept_disable_hardirq(unsigned long ip)
 	dept_exit(flags);
 }
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += (1UL << DEPT_CXTS_NR);
+}
+
 void dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106..f5d762c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -51,6 +51,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2217,6 +2218,8 @@ static void process_one_work(struct worker *worker, struct work_struct *work)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
1.9.1

