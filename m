Return-Path: <linux-fsdevel+bounces-49365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172BABB933
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983107AE3A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71028002E;
	Mon, 19 May 2025 09:19:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9752777F5;
	Mon, 19 May 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646340; cv=none; b=qLEZofsRZnRjJ6DmZ7EPVbrxMRpyaA+eRdt2B8YM7oEo33tvTmVnz+khCsRFTzv+av1hCWkaKz8ES+Et+YxOZpWpY+VBO4oLw3ZCawAuLkpqRI9BVz4GUr0Dbt+xc8w6iK/cNv+1xXz0efMY9ZIS3a1skHmyc6L7GRM0wlJZpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646340; c=relaxed/simple;
	bh=zw9buFd2EHMbKRLJjS8zYwIdV1jL6Jp00aCB8bfg1j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JfqCPeZ0lMxq69DSOKBardXUbHq3ojP7DBqbAYXIq/OUsjC09i8qKq8KFz/ljIetzRQqQRiAIqnfy9xC1oWtAMjZ8fQWM8f+mLhpMeZhYUjOLZULtW0VwG7Zi8Wf5KFXkWbERZq0k7yYD6j8JOCixHKojQpVv04OFpYSGKTch3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4f-682af76fff2b
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v16 24/42] dept: make dept able to work with an external wgen
Date: Mon, 19 May 2025 18:18:08 +0900
Message-Id: <20250519091826.19752-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSXUwTeRTF/c/8OzOt1EyqWUYkWdOIH+i6y4rujaLBFx2N+Ak+qFGrTLaN
	ULAVBBMVtBAFIUpSiKhYKFZCq9TWBwSLLCzdBSOya6UFAYW4KAEkQVrBgtpi9uXm5Jx7fvfl
	MqTMKQpjVOpTgkatSJJTEiwZDSn/KeVTpPIXnXkVeCcuYbhZY6Gg474ZgeVhNgFDLVvB7RtB
	4H/2nIQSfQeC8v5eEh46+xA4qi5Q8OLtPHB5xyho1edTcNFYQ8E/w9ME9BQXEWC2xcFr0yCG
	p1crCCgZouBGyUUiMN4TMGWqpsGUFQEDVaU0TPdHQWtfpwgc3SvhelkPBY8drRictQMEvKi7
	SUGf5asInjr/xuArXAQd1wpEcO9DBQXDPhMJJu8YDf82GghwGn4Aqy4AzP34RQR/FTQSkFv5
	gABXVz2ChktvCLBZOilo9o4QYLfpSfh8twXBQOEoDTlXpmi4kV2IID+nGIOuZy34JwOXb01E
	QfZtK4Z7M50odiNvKbMgvnlkjOR19tP8Z+9Linf4DJhvq+D4R6W9NK9r6KZ5gy2Nt1dF8sbH
	QwRfPu4V8bbqyxRvGy+i+bxRF8F/aG+nd4cfkMQkCkmqdEHz86ajEmWRtx6nNsVmOJ6/wlno
	UXQeEjMcG829G3SL8hAzqyfacdCm2GWcxzNFBvUCdjFnLxgMrEgYku2cy7lvdaFgMJ+N44yv
	RumgxmwE9+eEmw5ypOw6zvhy33f8j5zZ2jjLEQfs7vzm2aqMXcu5zGU4yOTY22Ju2viJ/F5Y
	yP1R5cFXkdSA5lQjmUqdnqxQJUWvVmaqVRmrj6ck21Dgu0xnpw/WovGOfU2IZZA8RGp1rFDK
	RIp0bWZyE+IYUr5AWm1frpRJExWZZwRNyhFNWpKgbUKLGCwPlf7qO50oY39XnBJOCEKqoPk/
	JRhxWBYyrSjZiQ+viZtsi97Qv2R7TM1M7OaluUfePqEaEvQ9fr06KiLcE3sntBL8Mqbl0JK9
	tfvl6wvTtJc3x8S7DmzxCDXxYwkni55khe8Jy3MM/zbT9i6n+FyO7r+p8+e7GRR6Ylt47a66
	UvsO3ySIn1X4e0MMHyvXWa5lWN1rNlmOqeRYq1RERZIareIbCm5zg1kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxjF9773L52dN5XoFXQuTYjKAo4E9DEaw/zCu00XFz84zYx048Y2
	/E2raE2MINVoEaIsyAApBZbK2jpraxSUS7BFZjFDFCxSAZUsZEQqibRVlKmtyb6cnJyT53e+
	PDylameSeF3RAUlfpClQswpa8f2mirTiV6nar1r9SyESPkXDhctOFgb/dCBwXi3HMH07B0ai
	Mwje/n2PgrraQQQtz8YpuNo3gUBuP87C0D+fwXBklgV/bSULFW2XWbj/fAHD2PkaDA73dnhi
	m6Lh7tlWDHXTLDTWVeCY/Ith3mbnwFaWApPtDRwsPMsA/0SAAV+TnwE5+CXUW8ZY6JL9NPR1
	TGIYunGBhQnnewbu9t2hIVqdDIPnqhi49KKVhedRGwW2yCwHD3qsGPqsS8FlilFPzr1j4K+q
	Hgwnf7+CYXj0JoLuU08xuJ0BFnyRGQwedy0Fby7eRjBZHeLgxJl5DhrLqxFUnjhPg2ksC96+
	ji03hTOgvNlFw6X/Aih7C3FanIj4ZmYpYvIcIm8iD1kiR6006W8VSWfDOEdM3UGOWN0Hiac9
	lbR1TWPS8jLCELf9NEvcL2s4Yg4NY/JiYIDbsXKPYnOeVKArlfTrtuQqtDWRm3SJN/uwfO8x
	XYY6M82I50UhUwwP0GaUwLPCavHRo3kq7hOFL0RP1RRjRgqeEgKfiiNNoyheLBG2i22PQ1zc
	00KK2Bse4eIcpbBebHu4Mx6LwirR4er5yEmIxcFK38dTlZAlDjss9FmksKJP7ChRV1RaqNEV
	ZKUb8rXGIt3h9F+KC90o9j+2owvnOlB4KMeLBB6pFyld8lqtitGUGoyFXiTylDpRafes0aqU
	eRrjEUlfvE9/sEAyeFEyT6uXKb/dJeWqhP2aA1K+JJVI+v9bzCcklaHKueVrtmoHS/gzu24l
	TTUv+2b3hj1dwd/WTfN/3P+J3PKFNA3jUtXnuVZyozmlY23mlY32TvOrvf3bwpZjI+LPSXJg
	66glPWw25igTX/8gK6/j7t6NvUFm7sh+U8biih+f9LvSfs1f0ln/tSNkzWvxfvd+8Z13ZddW
	yCvSqCg2PlDTBq0mI5XSGzQfAAmSBF07AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

There is a case where the total map size of waits of a class is so large.
For instance, PG_locked is the case if every struct page embeds its
regular map for PG_locked.  The total size for the maps will be 'the #
of pages * sizeof(struct dept_map)', which is too big to accept.

Keep the minimum data in the case, timestamp called 'wgen', that dept
uses.  Make dept able to work with the wgen instead of whole regular map.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 18 ++++++++++++++----
 include/linux/dept_sdt.h |  6 +++---
 kernel/dependency/dept.c | 30 +++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 49f457390521..236e4f06e5c8 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -372,6 +372,13 @@ struct dept_wait_hist {
 	unsigned int			ctxt_id;
 };
 
+/*
+ * for subsystems that requires compact use of memory e.g. struct page
+ */
+struct dept_ext_wgen {
+	unsigned int wgen;
+};
+
 extern void dept_on(void);
 extern void dept_off(void);
 extern void dept_init(void);
@@ -381,6 +388,7 @@ extern void dept_free_range(void *start, unsigned int sz);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
 extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
@@ -389,8 +397,8 @@ extern void dept_clean_stage(void);
 extern void dept_ttwu_stage_wait(struct task_struct *t, unsigned long ip);
 extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
 extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
-extern void dept_request_event(struct dept_map *m);
-extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn, struct dept_ext_wgen *ewg);
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
@@ -417,6 +425,7 @@ extern void dept_hardirqs_off(void);
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
@@ -429,6 +438,7 @@ struct dept_map { };
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
 #define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
@@ -437,8 +447,8 @@ struct dept_map { };
 #define dept_ttwu_stage_wait(t, ip)			do { } while (0)
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
index 14917df0cc30..9cd70affaf35 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -25,7 +25,7 @@
 
 #define sdt_wait_timeout(m, t)						\
 	do {								\
-		dept_request_event(m);					\
+		dept_request_event(m, NULL);				\
 		dept_wait(m, 1UL, _THIS_IP_, __func__, 0, t);		\
 	} while (0)
 #define sdt_wait(m) sdt_wait_timeout(m, -1L)
@@ -49,9 +49,9 @@
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
-#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__, NULL)
 #define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
-#define sdt_request_event(m)		dept_request_event(m)
+#define sdt_request_event(m)		dept_request_event(m, NULL)
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index a6abba8f3a2c..79357a3a03bb 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2172,6 +2172,11 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
 }
 EXPORT_SYMBOL_GPL(dept_map_reinit);
 
+void dept_ext_wgen_init(struct dept_ext_wgen *ewg)
+{
+	ewg->wgen = 0U;
+}
+
 void dept_map_copy(struct dept_map *to, struct dept_map *from)
 {
 	if (unlikely(!dept_working())) {
@@ -2355,7 +2360,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 		unsigned long e_f, unsigned long ip, const char *e_fn,
-		bool sched_map)
+		bool sched_map, unsigned int wg)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2377,7 +2382,7 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c)
-		do_event(m, real_m, c, READ_ONCE(m->wgen), ip, e_fn);
+		do_event(m, real_m, c, wg, ip, e_fn);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2602,7 +2607,7 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map);
+	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
 exit:
 	dept_exit(flags);
 }
@@ -2781,10 +2786,11 @@ bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
 }
 EXPORT_SYMBOL_GPL(dept_ecxt_holding);
 
-void dept_request_event(struct dept_map *m)
+void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 {
 	unsigned long flags;
 	unsigned int wg;
+	unsigned int *wg_p;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2797,18 +2803,22 @@ void dept_request_event(struct dept_map *m)
 	 */
 	flags = dept_enter_recursive();
 
+	wg_p = ewg ? &ewg->wgen : &m->wgen;
+
 	wg = next_wgen();
-	WRITE_ONCE(m->wgen, wg);
+	WRITE_ONCE(*wg_p, wg);
 
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
+	unsigned int *wg_p;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2816,24 +2826,26 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 	if (m->nocheck)
 		return;
 
+	wg_p = ewg ? &ewg->wgen : &m->wgen;
+
 	if (dt->recursive) {
 		/*
 		 * Dept won't work with this even though an event
 		 * context has been asked. Don't make it confused at
 		 * handling the event. Disable it until the next.
 		 */
-		WRITE_ONCE(m->wgen, 0U);
+		WRITE_ONCE(*wg_p, 0U);
 		return;
 	}
 
 	flags = dept_enter();
 
-	__dept_event(m, m, e_f, ip, e_fn, false);
+	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
 
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
-	WRITE_ONCE(m->wgen, 0U);
+	WRITE_ONCE(*wg_p, 0U);
 
 	dept_exit(flags);
 }
-- 
2.17.1


