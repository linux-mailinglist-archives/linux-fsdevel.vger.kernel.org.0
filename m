Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307A174590F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGCJuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGCJtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:55 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E881B12C;
        Mon,  3 Jul 2023 02:49:51 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-e9-64a299b3ea2e
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 17/25] dept: Track timeout waits separately with a new Kconfig
Date:   Mon,  3 Jul 2023 18:47:44 +0900
Message-Id: <20230703094752.79269-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0yTdxjG9/9/x1a7fOkwfmqMrgtZhplnlzdGF8Mu9l24hMSLLfMCO/pZ
        qqWQIig6I9jioQoqWhAh0lKtlcPE0gs2qaFVTlahKiKaUtfGqYRCXbc2YrsDZePmzS/Pk+d3
        9bKE/Ba1lNXo9ol6nVKroKWkdGqh9XNXfbNqbWCYg3On10L8zxMkNN5oo8H/UyuCNlcFhone
        r+FpIoIg+WCYgDqzH4E1NE6Aqy+IwO04SsPjlx/CSDxKw6D5FA0G2w0aHk6mMARqazC0Or8B
        39lmDD0zr0mom6Choc6AZ88bDDP2Fgbs5ZkQdlxiIBVaB4PBUQrcz1dB/eUADd3uQRL6usIY
        Hv/SSEOw7R8KfH0DJPjPVVHQPt1Mw2TCToA9HmXgUY8FQ4dxVnTsj78p6K/qwXDsyk0MI89u
        Ibh94lcMzrZRGu7EIxg6nWYC3l/rRRCunmKg8vQMAw0V1QhOVdaSMPxXPwXGwCZIvmukt20W
        7kSihGDs3C+4ExZSuNfMCz9fGmcE4+3njGBxlgidjizB1j2BBWssTgnOlpO04IzVMIJpagQL
        00NDjDBwMUkKL0fqcM6y76VbVKJWUyrq13y5S5rfPm4kimK7Dnh7r+Jy5NluQhKW5zbyqUkr
        M8+2yvdkmmnuU35sbIZIcwa3ku+sekWZkJQluOMLeMfbB3S6+Ij7gW8d7Z4bkFwm31FrptIs
        477gfYYa6j/pCr61o2dOJJnNf3tXjdIs5zbxgfognZby3HkJb0vG/x8s4T2OMfIsklnQBy1I
        rtGVFig12o2r88t0mgOr8woLnGj2peyHUzu7UMy/w4s4FikWysYOWVVySllaXFbgRTxLKDJk
        hlCTSi5TKcsOivrCXH2JViz2omUsqVgsW5/Yr5JzauU+ca8oFon6+RazkqXl6Kur30XyXJ4n
        o0xTqKhxc9Fyj7rw+CKf2/Tkk+i39/y7g9lo/Pd+t7r0vuXuZ1vJrS4De+ZVuMswVBCLXtgb
        fJE3dcZz8nqFy6dNGvtqSw5fyx2I/FhydMFlU8A2dJ05sjy8bcOeVXrJtD+lVmdLDppX6jJN
        GYmQt4H6OHt9ziMFWZyvXJdF6IuV/wJlNwa9TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxjG933nnO8c6rqcVDJPnMtMF2OikUti8Y0as5CpXxYxms2waKKt
        9kQ6oGirDDQuYAs6bgESqChMKNo1gAqtGi+gDOTSEQSFAJLSDHRT7ku1xALTUZf98+aX58nz
        ++sVGFUFt1IwGE/IJqMuSU0UrGL3FssGd5ldH9Xh00BRXhQE3pxnofxGHYHe67UI6m5mYhhv
        2wmDc1MIFrp7GLCV9CKoGh1h4Ga7D0GT8yyBvhefQH9gloCnJJeApfoGgSeTixi8pcUYal1x
        0FVox9AcfMmCbZzAJZsFL51XGIKOGh4cGWtgzHmRh8XRaPD4BjhorfBw0DS8Hsp+8RJobPKw
        0H5nDEPfvXICvrr3HHS1d7LQW5TPwbUZO4HJOQcDjsAsD0+bKzHUW5ds2a/fcdCR34wh+0oD
        hv5n9xE8OP8HBlfdAIHWwBQGt6uEgflf2xCMFUzzkJUX5OFSZgGC3KxSFnr+6eDA6tXAwtty
        8tUW2jo1y1Cr+0faNFfJ0t/tEr17cYSn1gfDPK10naRu5zpa3TiOaZU/wFFXzc+EuvzFPM2Z
        7sd05vFjnnZeWGDpi34b3rNqv2KrXk4ypMqmyG1aRcK1EStzzK9Na2m7ijPQb7tyUJggiRul
        6qx5NsREXCsNDQWZEIeLqyV3/l9cDlIIjHhumeT8u5uEiuXiYal2oPHDgBXXSPWlJVyIlWKM
        1GUp5v6TfiHV1jd/EIUt5X++LUAhVokayVvmI4VIUYk+qkHhBmNqss6QpIkwJyakGw1pEUdS
        kl1o6WkcZxaL7qA3fTtbkCgg9cfKodNVehWnSzWnJ7cgSWDU4UrL6GW9SqnXpZ+STSmHTCeT
        ZHML+kxg1SuU38TLWpV4VHdCTpTlY7Lp/xYLYSszUGzULU3etpw0c8Vt/TO72uccSTyifd3z
        ufUHf/yjr89m5jbk71qMHds3eXTe/2SPZyFih/bL+DgyLNimJ+jE8TNR6slVE4WJl7O3f7oJ
        DX7bp4iEzZGtBwV+uyOWPvcyir3fLRu6ih5+H3elIfzchL77/YWY3bbggbWpm4wzP+0fVLPm
        BF30OsZk1v0LT6YcmDADAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Waits with valid timeouts don't actually cause deadlocks. However, Dept
has been reporting the cases as well because it's worth informing the
circular dependency for some cases where, for example, timeout is used
to avoid a deadlock but not meant to be expired.

However, yes, there are also a lot of, even more, cases where timeout
is used for its clear purpose and meant to be expired.

Let Dept report these as an information rather than shouting DEADLOCK.
Plus, introduced CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT Kconfig to make it
optional so that any reports involving waits with timeouts can be turned
on/off depending on the purpose.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 15 ++++++---
 include/linux/dept_ldt.h |  6 ++--
 include/linux/dept_sdt.h | 12 +++++---
 kernel/dependency/dept.c | 66 ++++++++++++++++++++++++++++++++++------
 lib/Kconfig.debug        | 10 ++++++
 5 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 583e8fe2dd7b..0aa8d90558a9 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -270,6 +270,11 @@ struct dept_wait {
 			 * whether this wait is for commit in scheduler
 			 */
 			bool		sched_sleep;
+
+			/*
+			 * whether a timeout is set
+			 */
+			bool				timeout;
 		};
 	};
 };
@@ -458,6 +463,7 @@ struct dept_task {
 	bool				stage_sched_map;
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
+	bool				stage_timeout;
 
 	/*
 	 * the number of missing ecxts
@@ -496,6 +502,7 @@ struct dept_task {
 	.stage_sched_map = false,				\
 	.stage_w_fn = NULL,					\
 	.stage_ip = 0UL,					\
+	.stage_timeout = false,					\
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
 	.softirqs_enabled = false,				\
@@ -513,8 +520,8 @@ extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, con
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 
-extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l);
-extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn);
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
+extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
 extern void dept_request_event_wait_commit(void);
 extern void dept_clean_stage(void);
 extern void dept_stage_event(struct task_struct *t, unsigned long ip);
@@ -566,8 +573,8 @@ struct dept_task { };
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 
-#define dept_wait(m, w_f, ip, w_fn, sl)			do { (void)(w_fn); } while (0)
-#define dept_stage_wait(m, k, ip, w_fn)			do { (void)(k); (void)(w_fn); } while (0)
+#define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
+#define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
 #define dept_request_event_wait_commit()		do { } while (0)
 #define dept_clean_stage()				do { } while (0)
 #define dept_stage_event(t, ip)				do { } while (0)
diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
index 062613e89fc3..8adf298dfcb8 100644
--- a/include/linux/dept_ldt.h
+++ b/include/linux/dept_ldt.h
@@ -27,7 +27,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
 		else {							\
-			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl, false);	\
 			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
 		}							\
 	} while (0)
@@ -39,7 +39,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
 		else {							\
-			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl, false);\
 			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
 		}							\
 	} while (0)
@@ -51,7 +51,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
 		else {							\
-			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl, false);\
 			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
 		}							\
 	} while (0)
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 12a793b90c7e..21fce525f031 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -22,11 +22,12 @@
 
 #define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
 
-#define sdt_wait(m)							\
+#define sdt_wait_timeout(m, t)						\
 	do {								\
 		dept_request_event(m);					\
-		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0, t);		\
 	} while (0)
+#define sdt_wait(m) sdt_wait_timeout(m, -1L)
 
 /*
  * sdt_might_sleep() and its family will be committed in __schedule()
@@ -37,12 +38,13 @@
 /*
  * Use the code location as the class key if an explicit map is not used.
  */
-#define sdt_might_sleep_start(m)					\
+#define sdt_might_sleep_start_timeout(m, t)				\
 	do {								\
 		struct dept_map *__m = m;				\
 		static struct dept_key __key;				\
-		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
 	} while (0)
+#define sdt_might_sleep_start(m) sdt_might_sleep_start_timeout(m, -1L)
 
 #define sdt_might_sleep_end()		dept_clean_stage()
 
@@ -52,7 +54,9 @@
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait_timeout(m, t)		do { } while (0)
 #define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start_timeout(m, t) do { } while (0)
 #define sdt_might_sleep_start(m)	do { } while (0)
 #define sdt_might_sleep_end()		do { } while (0)
 #define sdt_ecxt_enter(m)		do { } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 8454f0a14d67..52537c099b68 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -740,6 +740,8 @@ static void print_diagram(struct dept_dep *d)
 	if (!irqf) {
 		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
 		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		if (w->timeout)
+			print_spc(spc, "--------------- >8 timeout ---------------\n");
 		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
 	}
 }
@@ -793,6 +795,24 @@ static void print_dep(struct dept_dep *d)
 
 static void save_current_stack(int skip);
 
+static bool is_timeout_wait_circle(struct dept_class *c)
+{
+	struct dept_class *fc = c->bfs_parent;
+	struct dept_class *tc = c;
+
+	do {
+		struct dept_dep *d = lookup_dep(fc, tc);
+
+		if (d->wait->timeout)
+			return true;
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	return false;
+}
+
 /*
  * Print all classes in a circle.
  */
@@ -815,10 +835,14 @@ static void print_circle(struct dept_class *c)
 	pr_warn("summary\n");
 	pr_warn("---------------------------------------------------\n");
 
-	if (fc == tc)
+	if (is_timeout_wait_circle(c)) {
+		pr_warn("NOT A DEADLOCK BUT A CIRCULAR DEPENDENCY\n");
+		pr_warn("CHECK IF THE TIMEOUT IS INTENDED\n\n");
+	} else if (fc == tc) {
 		pr_warn("*** AA DEADLOCK ***\n\n");
-	else
+	} else {
 		pr_warn("*** DEADLOCK ***\n\n");
+	}
 
 	i = 0;
 	do {
@@ -1564,7 +1588,8 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 static atomic_t wgen = ATOMIC_INIT(1);
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep)
+		     const char *w_fn, int sub_l, bool sched_sleep,
+		     bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1584,6 +1609,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
+	w->timeout = timeout;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -2338,7 +2364,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
  */
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
 			unsigned long ip, const char *w_fn, int sub_l,
-			bool sched_sleep, bool sched_map)
+			bool sched_sleep, bool sched_map, bool timeout)
 {
 	int e;
 
@@ -2361,7 +2387,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
@@ -2403,14 +2429,23 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
-	       unsigned long ip, const char *w_fn, int sub_l)
+	       unsigned long ip, const char *w_fn, int sub_l,
+	       long timeoutval)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
 
+	timeout = timeoutval > 0 && timeoutval < MAX_SCHEDULE_TIMEOUT;
+
+#if !defined(CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT)
+	if (timeout)
+		return;
+#endif
+
 	if (dt->recursive)
 		return;
 
@@ -2419,21 +2454,30 @@ void dept_wait(struct dept_map *m, unsigned long w_f,
 
 	flags = dept_enter();
 
-	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false);
+	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false, timeout);
 
 	dept_exit(flags);
 }
 EXPORT_SYMBOL_GPL(dept_wait);
 
 void dept_stage_wait(struct dept_map *m, struct dept_key *k,
-		     unsigned long ip, const char *w_fn)
+		     unsigned long ip, const char *w_fn,
+		     long timeoutval)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
 
+	timeout = timeoutval > 0 && timeoutval < MAX_SCHEDULE_TIMEOUT;
+
+#if !defined(CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT)
+	if (timeout)
+		return;
+#endif
+
 	if (m && m->nocheck)
 		return;
 
@@ -2481,6 +2525,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
 
 	dt->stage_w_fn = w_fn;
 	dt->stage_ip = ip;
+	dt->stage_timeout = timeout;
 unlock:
 	arch_spin_unlock(&stage_spin);
 
@@ -2506,6 +2551,7 @@ void dept_clean_stage(void)
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
+	dt->stage_timeout = false;
 	arch_spin_unlock(&stage_spin);
 
 	dept_exit_recursive(flags);
@@ -2523,6 +2569,7 @@ void dept_request_event_wait_commit(void)
 	unsigned long ip;
 	const char *w_fn;
 	bool sched_map;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2545,6 +2592,7 @@ void dept_request_event_wait_commit(void)
 	w_fn = dt->stage_w_fn;
 	ip = dt->stage_ip;
 	sched_map = dt->stage_sched_map;
+	timeout = dt->stage_timeout;
 
 	/*
 	 * Avoid zero wgen.
@@ -2552,7 +2600,7 @@ void dept_request_event_wait_commit(void)
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 	WRITE_ONCE(dt->stage_m.wgen, wg);
 
-	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
 exit:
 	dept_exit(flags);
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index aa62caa4dc14..f78b3d721a2b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1234,6 +1234,16 @@ config DEPT
 	  noting, to mitigate the impact by the false positives, multi
 	  reporting has been supported.
 
+config DEPT_AGGRESSIVE_TIMEOUT_WAIT
+	bool "Aggressively track even timeout waits"
+	depends on DEPT
+	default n
+	help
+	  Timeout wait doesn't contribute to a deadlock. However,
+	  informing a circular dependency might be helpful for cases
+	  that timeout is used to avoid a deadlock. Say N if you'd like
+	  to avoid verbose reports.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.17.1

