Return-Path: <linux-fsdevel+bounces-8746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591483A92F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E8A1F2338C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192076DD02;
	Wed, 24 Jan 2024 12:00:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42B67747;
	Wed, 24 Jan 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097618; cv=none; b=ewRHgfm0PRB2BecFnIph+vjDN/NEivDhyPqsqLbkXcf/nEgzusgQLz0fhayRXoGVJ90m0g2+zAxWh1K+N6cPhFkLIR0MwRm/dn9C2tvArV41wcJ0/SuaDpvFzStVKVoP6vwSqzircG9AlWSSYbEKpTlIhvYdXCM/ckMQqtWJDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097618; c=relaxed/simple;
	bh=Zg3dPmxAeZfdPCpe0eFW6kAfwZet+/NUlIS50hmLxGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bhxDkRfYIcsEEdz4VjJhdsngxj+QcHP9/cQKOOhRyE4wMHERr9XCg+7PTMZeqM3bAC2eAP8rbIxLNgN12uOBM0HgbcTSKUxGyU6HnLNcrXCCNLRa6GvmRTmbMzstFw6nKsDcCqHvnlsmefjuElP2Id2+gLeK7P913flqw4Jxh14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a6-65b0fbb7d9da
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
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v11 23/26] dept: Make Dept able to work with an external wgen
Date: Wed, 24 Jan 2024 20:59:34 +0900
Message-Id: <20240124115938.80132-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe573NlfLl3V7MqJYiGCkJhmHCJOieguMoA9FGTXyRYe62bwH
	gaV20UwT1rpITI21pqltoyybTUdeKmvlLBMVNamkmWVNtFmmVl8OP/7n/H+fjoSS1zMBEpU6
	VdSqlYkKVkpLRxaUrbvvqxXDSj5shksXwsD74xwNpTVVLLiqKxFU2U5hGH6yE96OexD42l9S
	oNe5EJQN9FJga+5DYDedZqFjaCG4vaMstOkKWMipqGHh1ecpDD2XSzBUWqLhWXE5BsfkRxr0
	wyxc1+fgmfEJw6TRzIExOxAGTdc4mBpYD219bxiwd6+Fqzd6WHhkb6OhuW4QQ8fDUhb6qqYZ
	eNbcSoPrUiEDd76Us/B53EiB0TvKwWuHAUNt7ozozPffDLQUOjCcuXkXg/tdPYKGc/0YLFVv
	WHB6PRisFh0FP289QTB4cYSDvAuTHFw/dRFBQd5lGl7+amEgtycCfBOlbNQmwekZpYRca4Zg
	HzfQwtNyIjy41ssJuQ3dnGCwpAlWU7BQ8WgYC2VjXkawmM+zgmWshBPyR9xY+PLiBSe0XvHR
	wpBbj/euOCjdHCsmqtJFbWjkUWm87VMnlZy/JdNWfJvKRp7wfOQnIfwGMtI6wf5nd8XbOWb5
	INLVNUnN8mJ+NbEWfmDykVRC8WfnE9PX9rmjRXw0sXY+RrNM84GkNKdyriDjN5K6e9X/pKtI
	Za1jLvebye9c7aZnWc5HkH5zETcrJXyOH+mcqGf+FpaTRlMXXYxkBjTPjOQqdXqSUpW4ISQ+
	S63KDDmmSbKgmZcynpw6VIfGXPuaEC9BigWyKHONKGeU6SlZSU2ISCjFYlnX8mpRLotVZp0Q
	tZoj2rREMaUJrZDQimWy8PGMWDkfp0wVE0QxWdT+32KJX0A2mne6oP0wCVa6ArO0g4HTmrrt
	xq21/RkhPvy+R91aFB0eE9WY+c23csku+3TM3qP3B55r9uh0OxLMRfzA7tD9+7c6DqQ6ncdG
	TftiP0oNcYvOE3/9keQk5/GHQ4reVZqigKiDfXv8rwTnpccFmXsjb/uvMaxb2r67wxNpu9u5
	bYwo6JR45fpgSpui/ANk+Ha5TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5+7q9VhCZ1KqFYiGJVWyxeMkvrgITAkiC4EOfKQKzdlM9NA
	sNS11Jkz1C4rvLF02rRtlOYlm+U1L+WyJU7LpJQ0w5xk2kWNvjz8eJ73fT49DC65S65jFKo4
	Qa2SR0spESE6HJyy7fFclRAwbdgChswA8EzrCDBWVlDQYylHUGG/jMHYi1B4OzOOYK6zG4f8
	3B4EhR/cONibBxHUl16hoHdkJTg9kxS05WZQkFJcScGrL/MYDOTlYFBuDYOO7CIMGmc/E5A/
	RsGd/BRsQUYxmDWZaTAl+8Jw6W0a5j8EQttgHwlNd9tIqO/fCrfuDVBQV99GQHP1MAa9T4wU
	DFb8IaGjuZWAHoOehAdfiyj4MmPCweSZpOF1YwEGVakLbdrvv0lo0TdioC15iIHzXS2CBt17
	DKwVfRQ0ecYxsFlzcfh5/wWC4awJGtIyZ2m4czkLQUZaHgHdv1pISB2QwdwPIxUSzDeNT+J8
	qu0iXz9TQPDtRRxfc9tN86kN/TRfYL3A20r9+eK6MYwvnPKQvNV8jeKtUzk0nz7hxPivXV00
	33pzjuBHnPlYuM9J0d5IIVoRL6h37IsQRdlH3+Cx6fsT7NlleDIa35mOvBiO3c05i99Si0yx
	fpzLNYsvsje7kbPpP5HpSMTg7NXlXOm3zqWj1WwYZ3vzFC0ywfpyxpTypQcxu4erfmSh/pVu
	4MqrGpd8rwX/wa1+YpElrIx7b75OZyNRAVpmRt4KVbxSroiWbdecj0pUKRK2n4lRWtHCaExJ
	84ZqNN0b6kAsg6QrxCHmSkFCyuM1iUoH4hhc6i12rbUIEnGkPPGSoI45rb4QLWgcaD1DSNeI
	Dx0TIiTsWXmccF4QYgX1/xRjvNYlo1NhSqnFflW2NjyvpmRT0EHtK+U5iaU29PsRvGSgy91t
	aWD89h9sv3gkyOD2PeqIK/70s2zXgSHXy5hVkqP6ZzVBKGQiq2My0aXXuZJy7OpCFxf/o0au
	VWU0bdZ2tu416q4cKjpwQ5bl2Bl+fPRjhPvbUP+JLrpveHOLz3PdpjIpoYmSB/rjao38L2WF
	VicwAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

There is a case where total maps for its wait/event is so large in size.
For instance, struct page for PG_locked and PG_writeback is the case.
The additional memory size for the maps would be 'the # of pages *
sizeof(struct dept_map)' if each struct page keeps its map all the way,
which might be too big to accept.

It'd be better to keep the minimum data in the case, which is timestamp
called 'wgen' that Dept makes use of. So made Dept able to work with an
external wgen when needed.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 18 ++++++++++++++----
 include/linux/dept_sdt.h |  4 ++--
 kernel/dependency/dept.c | 30 +++++++++++++++++++++---------
 3 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 0280e45cc2af..dea53ad5b356 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -482,6 +482,13 @@ struct dept_task {
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
@@ -512,6 +519,7 @@ extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
@@ -521,8 +529,8 @@ extern void dept_clean_stage(void);
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
@@ -551,6 +559,7 @@ extern void dept_hardirqs_off(void);
 struct dept_key  { };
 struct dept_map  { };
 struct dept_task { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 #define DEPT_TASK_INITIALIZER(t)   { }
@@ -563,6 +572,7 @@ struct dept_task { };
 #define dept_free_range(s, sz)				do { } while (0)
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
@@ -572,8 +582,8 @@ struct dept_task { };
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
index 21fce525f031..8cdac7982036 100644
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
index 5c996f11abd5..fb33c3758c25 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2186,6 +2186,11 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
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
@@ -2371,7 +2376,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, unsigned long e_f,
 			 unsigned long ip, const char *e_fn,
-			 bool sched_map)
+			 bool sched_map, unsigned int wg)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2393,7 +2398,7 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c && add_ecxt(m, c, 0UL, NULL, e_fn, 0)) {
-		do_event(m, c, READ_ONCE(m->wgen), ip);
+		do_event(m, c, wg, ip);
 		pop_ecxt(m, c);
 	}
 }
@@ -2606,7 +2611,7 @@ void dept_stage_event(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map);
+	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
 exit:
 	dept_exit(flags);
 }
@@ -2785,10 +2790,11 @@ bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
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
@@ -2801,21 +2807,25 @@ void dept_request_event(struct dept_map *m)
 	 */
 	flags = dept_enter_recursive();
 
+	wg_p = ewg ? &ewg->wgen : &m->wgen;
+
 	/*
 	 * Avoid zero wgen.
 	 */
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
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
@@ -2823,24 +2833,26 @@ void dept_event(struct dept_map *m, unsigned long e_f,
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
 
-	__dept_event(m, e_f, ip, e_fn, false);
+	__dept_event(m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
 
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
-	WRITE_ONCE(m->wgen, 0U);
+	WRITE_ONCE(*wg_p, 0U);
 
 	dept_exit(flags);
 }
-- 
2.17.1


