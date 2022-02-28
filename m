Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFD94C667E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiB1J6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 04:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiB1J6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:58:23 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9CC22A256
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 01:57:22 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 28 Feb 2022 18:57:20 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 28 Feb 2022 18:57:20 +0900
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
Subject: [PATCH v3 18/21] dept: Distinguish each work from another
Date:   Mon, 28 Feb 2022 18:56:57 +0900
Message-Id: <1646042220-28952-19-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
References: <1646042220-28952-1-git-send-email-byungchul.park@lge.com>
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
index 1a1c307..55c5ed5 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -486,6 +486,7 @@ struct dept_task {
 extern void dept_event_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *e_fn);
 extern void dept_ask_event_split_map(struct dept_map_each *me, struct dept_map_common *mc);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 /*
  * for users who want to manage external keys
@@ -527,6 +528,7 @@ struct dept_task {
 #define dept_event_split_map(me, mc, ip, e_fn)		do { } while (0)
 #define dept_ask_event_split_map(me, mc)		do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
 #endif
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 8f962ae..5d4efc3 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1873,6 +1873,16 @@ void dept_disable_hardirq(unsigned long ip)
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

