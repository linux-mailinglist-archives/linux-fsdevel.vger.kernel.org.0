Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7667DB99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 02:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjA0Bu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 20:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjA0Btz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:49:55 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E32574A54
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jan 2023 17:49:43 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 27 Jan 2023 10:19:42 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: max.byungchul.park@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 27 Jan 2023 10:19:42 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: max.byungchul.park@gmail.com
From:   Byungchul Park <max.byungchul.park@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com
Subject: [PATCH v8 13/25] dept: Distinguish each work from another
Date:   Fri, 27 Jan 2023 10:19:06 +0900
Message-Id: <1674782358-25542-14-git-send-email-max.byungchul.park@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1674782358-25542-1-git-send-email-max.byungchul.park@gmail.com>
References: <1674782358-25542-1-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=unavailable autolearn_force=no
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

Signed-off-by: Byungchul Park <max.byungchul.park@gmail.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 41768cc..88cb5ab 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -515,6 +515,7 @@ struct dept_task {
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -565,6 +566,7 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index edca697..711bd86 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1954,6 +1954,16 @@ void dept_hardirqs_off(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(dept_hardirqs_off);
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 void dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07895de..69c4f46 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -51,6 +51,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2199,6 +2200,8 @@ static void process_one_work(struct worker *worker, struct work_struct *work)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
1.9.1

