Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279D682718
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjAaInc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 03:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjAaImE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:42:04 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 401DA47EEF
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 00:40:10 -0800 (PST)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 31 Jan 2023 17:40:03 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: max.byungchul.park@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.127 with ESMTP; 31 Jan 2023 17:40:02 +0900
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
Subject: [PATCH v9 24/25] dept: Make Dept able to work with an external wgen
Date:   Tue, 31 Jan 2023 17:39:53 +0900
Message-Id: <1675154394-25598-25-git-send-email-max.byungchul.park@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1675154394-25598-1-git-send-email-max.byungchul.park@gmail.com>
References: <1675154394-25598-1-git-send-email-max.byungchul.park@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a case where total maps for its wait/event is so large in size.
For instance, struct page for PG_locked and PG_writeback is the case.
The additional memory size for the maps would be 'the # of pages *
sizeof(struct dept_map)' if each struct page keeps its map all the way,
which might be too big to accept.

It'd be better to keep the minimum data in the case, which is timestamp
called 'wgen' that Dept makes use of. So made Dept able to work with an
external wgen when needed.

Signed-off-by: Byungchul Park <max.byungchul.park@gmail.com>
---
 include/linux/dept.h     | 18 ++++++++++++++----
 include/linux/dept_sdt.h |  4 ++--
 kernel/dependency/dept.c | 30 +++++++++++++++++++++---------
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 0aa8d90..ad32ea7 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -487,6 +487,13 @@ struct dept_task {
 	bool				in_sched;
 };
 
+/*
+ * for subsystems that requires compact use of memory e.g. struct page
+ */
+struct dept_ext_wgen{
+	unsigned int wgen;
+};
+
 #define DEPT_TASK_INITIALIZER(t)				\
 {								\
 	.wait_hist = { { .wait = NULL, } },			\
@@ -518,6 +525,7 @@ struct dept_task {
 extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
@@ -527,8 +535,8 @@ struct dept_task {
 extern void dept_stage_event(struct task_struct *t, unsigned long ip);
 extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
 extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
-extern void dept_request_event(struct dept_map *m);
-extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn, struct dept_ext_wgen *ewg);
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
@@ -559,6 +567,7 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 struct dept_key  { };
 struct dept_map  { };
 struct dept_task { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 #define DEPT_TASK_INITIALIZER(t)   { }
@@ -571,6 +580,7 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 #define dept_free_range(s, sz)				do { } while (0)
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
@@ -580,8 +590,8 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 #define dept_stage_event(t, ip)				do { } while (0)
 #define dept_ecxt_enter(m, e_f, ip, c_fn, e_fn, sl)	do { (void)(c_fn); (void)(e_fn); } while (0)
 #define dept_ecxt_holding(m, e_f)			false
-#define dept_request_event(m)				do { } while (0)
-#define dept_event(m, e_f, ip, e_fn)			do { (void)(e_fn); } while (0)
+#define dept_request_event(m, wg)			do { } while (0)
+#define dept_event(m, e_f, ip, e_fn, wg)		do { (void)(e_fn); } while (0)
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 21fce52..8cdac79 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -24,7 +24,7 @@
 
 #define sdt_wait_timeout(m, t)						\
 	do {								\
-		dept_request_event(m);					\
+		dept_request_event(m, NULL);				\
 		dept_wait(m, 1UL, _THIS_IP_, __func__, 0, t);		\
 	} while (0)
 #define sdt_wait(m) sdt_wait_timeout(m, -1L)
@@ -49,7 +49,7 @@
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
-#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__, NULL)
 #define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 2887858..bce3dc8 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2230,6 +2230,11 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
 }
 EXPORT_SYMBOL_GPL(dept_map_reinit);
 
+void dept_ext_wgen_init(struct dept_ext_wgen *ewg)
+{
+	WRITE_ONCE(ewg->wgen, 0U);
+}
+
 void dept_map_copy(struct dept_map *to, struct dept_map *from)
 {
 	if (unlikely(!dept_working())) {
@@ -2415,7 +2420,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, unsigned long e_f,
 			 unsigned long ip, const char *e_fn,
-			 bool sched_map)
+			 bool sched_map, unsigned int *wgp)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2437,14 +2442,14 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c && add_ecxt(m, c, 0UL, NULL, e_fn, 0)) {
-		do_event(m, c, READ_ONCE(m->wgen), ip);
+		do_event(m, c, READ_ONCE(*wgp), ip);
 		pop_ecxt(m, c);
 	}
 exit:
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
-	WRITE_ONCE(m->wgen, 0U);
+	WRITE_ONCE(*wgp, 0U);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2654,7 +2659,7 @@ void dept_stage_event(struct task_struct *t, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map);
+	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map, &m.wgen);
 exit:
 	dept_exit(flags);
 }
@@ -2833,10 +2838,11 @@ bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
 }
 EXPORT_SYMBOL_GPL(dept_ecxt_holding);
 
-void dept_request_event(struct dept_map *m)
+void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 {
 	unsigned long flags;
 	unsigned int wg;
+	unsigned int *wgp;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2849,32 +2855,38 @@ void dept_request_event(struct dept_map *m)
 	 */
 	flags = dept_enter_recursive();
 
+	wgp = ewg ? &ewg->wgen : &m->wgen;
+
 	/*
 	 * Avoid zero wgen.
 	 */
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
-	WRITE_ONCE(m->wgen, wg);
+	WRITE_ONCE(*wgp, wg);
 
 	dept_exit_recursive(flags);
 }
 EXPORT_SYMBOL_GPL(dept_request_event);
 
 void dept_event(struct dept_map *m, unsigned long e_f,
-		unsigned long ip, const char *e_fn)
+		unsigned long ip, const char *e_fn,
+		struct dept_ext_wgen *ewg)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	unsigned int *wgp;
 
 	if (unlikely(!dept_working()))
 		return;
 
+	wgp = ewg ? &ewg->wgen : &m->wgen;
+
 	if (dt->recursive) {
 		/*
 		 * Dept won't work with this even though an event
 		 * context has been asked. Don't make it confused at
 		 * handling the event. Disable it until the next.
 		 */
-		WRITE_ONCE(m->wgen, 0U);
+		WRITE_ONCE(*wgp, 0U);
 		return;
 	}
 
@@ -2883,7 +2895,7 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 
 	flags = dept_enter();
 
-	__dept_event(m, e_f, ip, e_fn, false);
+	__dept_event(m, e_f, ip, e_fn, false, wgp);
 
 	dept_exit(flags);
 }
-- 
1.9.1

