Return-Path: <linux-fsdevel+bounces-13721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD1E8731FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939B928B069
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC070CB1;
	Wed,  6 Mar 2024 08:55:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5C657CC;
	Wed,  6 Mar 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715351; cv=none; b=WXMcqkBngTZO/7ZNjx7PIv827mFcrIE2Y5NVaD1sC7oQlsfjfyCIYqcX0FMa5PiSWbeuIn0YzJ4Bnn6NeKqRnOvnz5JPgXUFmh5NfmqRbBATMSeAbn63t5MhgUdB42HcbPn5r5hcSdKRvlew/1kZ0IKzq9ItwzSNpwBLB5uWb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715351; c=relaxed/simple;
	bh=ul/wiSzDZit7bOUs1eKkFyN45Ghg8m4Ni94/4VNQ6UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Bor5lK60N+eg1CjJDfn8UtweFWmFPLrHtFTSRdo3Iuo2FpzgdDchBWTl3YG9X44XGRggqAlCHkD0SN0yShN+g1SPyZkPZKrIQioewShhW3X4xfjYcu0yvPiyFxjvGrjJ3gDXraAlSRfrTMFuRk8Q7PCiaMzr0HL0Pwt80zwnRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-ba-65e82f7fca0c
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
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v13 25/27] dept: Print event context requestor's stacktrace on report
Date: Wed,  6 Mar 2024 17:55:11 +0900
Message-Id: <20240306085513.41482-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pc9/n7jh7nPDIH9lt5Mf6wcSHmTVbPLMx8+sPxrnpoZvr
	yl0/zY+40xQhlqjkKk6ro7qaUh0JqShRiKWp9cNxlVV3pBZ1+Oez197v195/fcSUvETkKVZr
	IwSdVqVRECkt7ZuW7RPn90XwL+0hkHzeH5zDZ2nIKLAQaLqXj8BScgqD/dlGeO9yIBhteEVB
	akoTgqyOTxSU1LQjsOWeJtDcNR1anAME6lLOETDkFBB4/W0MQ9vVyxjyrZvhxaVsDFUjvTSk
	2gmkpxrwxPmCYcScx4A5bgF05qYxMNaxDOra34nA9nEpXM9sI1Bpq6OhpqwTQ3N5BoF2y28R
	vKippaEpOUkEd/uzCXxzmSkwOwcYeFNlwlBonBiKHxoXwfOkKgzxt4owtHyoQPDw7GcMVss7
	Ak+cDgzF1hQKft15hqDzQh8DZ86PMJB+6gKCc2eu0mBsC4DRnxkkcDX/xDFA8cbiaN7mMtF8
	fTbHP0j7xPDGhx8Z3mSN5Itzl/A5lXbMZw06Rbw1L4Hw1sHLDJ/Y14L5/sZGhq+9NkrzXS2p
	eKvnbunaYEGjjhJ0fuv2S0PqbvRR4QlBMd32SjoOXVuViCRijl3BDT1Pp/5zb4VBNMmE9eZa
	W0fcuQc7nytO6nHnFOuQcrcaN0zyTHYnl1BRQCaZZhdwifXdbl/GruQMPa5/m15cfmGVmyUT
	+cX+i25fzgZwDYYs8tf5KebsXX5/eS73OLeVvoRkJjQlD8nV2qhQlVqzwjckVquO8T0QFmpF
	E79kPj62pwwNNm2vRqwYKabJAiW9glykitLHhlYjTkwpPGTHfnUJclmwKvaooAtT6iI1gr4a
	zRPTijmy5a7oYDl7SBUhHBaEcEH3v8ViiWccMi3cx5XfXDz7lY/+ypaA5tLruPvE1+316+cr
	j+w1fZ6h9PSOd8BbbsOx5T/ktck246HdLyWPC99oQ55K/C23X3Y8Uo6v9x6eGhOJfnzXbFq4
	JsJrypCqE4K8dkmGV31X7uotWjfwdFFQbdis+yk7DmaOB5a8PpmTmeZR7hP9QbOt/LeC1oeo
	li2hdHrVH4vOInFHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSSUxTcRjE/b+1bay+FBIfclBrjIlGEEL1E5dwUZ9r9KBGPGiFF6mUxVYQ
	jAtYVBYB0WCRxRTQSgAtFhJUKCEslSKrFNygCkGxoYCirUKJChgvk19mJnMaAS7RkksFisiz
	vCpSrpRSIkK0f7Nm3WXfL/z6JtdayLqxHpw/kgnIN5RT0PW4DEF5VSIG9uad8NrlQOBu78RB
	m92FoHBwAIcqsw2BqeQKBT3Di8DqnKDAkp1GgabYQEH36AwG/XduYVBm3AcvbxZhUD81QoDW
	TkGeVoPNyhcMpvSlNOgTVsFQSS4NM4N+YLH1kdBYYCHB9G4t3L3XT0GtyUKA+ekQBj3P8ymw
	lf8h4aW5hYCurHQSHo0XUTDq0uOgd07Q8Kpeh0FF0uzate+/SXiRXo/BtftPMLC+rUFQl/wR
	A2N5HwWNTgcGlcZsHKYfNiMYyhij4eqNKRryEjMQpF29Q0BSvwzcv/KpoECu0TGBc0mV5ziT
	S0dwrUUs9yx3gOaS6t7RnM4Yw1WWrOGKa+0YVzjpJDljaQrFGSdv0VzqmBXjxjs6aK4lx01w
	w1YtdsA7WLQllFcqYnmV77YTojBLwRgenbI97pO9lkhAORtTkVDAMgHsSI2GnGOKWc2+eTOF
	z7Ens5ytTP887+OMQ8Te79gxxx7MITalxkDNMcGsYlNbP833xcwGVvPZhf/bXMaWVdTPs3DW
	zxzPnO9LGBnbrimkbiKRDi0oRZ6KyNgIuUIp81GHh8VHKuJ8QqIijGj2LvqLM1lP0Y+enQ2I
	ESDpQnGQcISXkPJYdXxEA2IFuNRTfGF6mJeIQ+Xx53lV1HFVjJJXNyBvASFdIt59hD8hYU7J
	z/LhPB/Nq/6nmEC4NAHlfRAevP3+1++wFkPjsa293dWt02mDm93mgDYv2UWl1NL0nnVEZB7O
	KVYNGTbpHwSHvy4O1nV69IaMnPy4ovq4vzvZP2P3pZ/L9qyMeqg0k19XmM4EDOive5n0L0b3
	2LoX37MG2rbv7Tn99hjf5qeVdRlyd9m3HP1WpEKpktJY0XkpoQ6T+63BVWr5XwZeymEqAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Currently, print nothing in place of [S] in report, which means
stacktrace of event context's start if the event is not an unlock thing
by typical lock but general event because it's not easy to specify the
point in a general way, where the event context has started from.

However, unfortunately it makes hard to interpret dept's report in that
case. So made it print the event requestor's stacktrace instead of the
event context's start, in place of [S] in report.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 13 +++++++
 kernel/dependency/dept.c | 83 ++++++++++++++++++++++++++++++++--------
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index dea53ad5b356..6db23d77905e 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -145,6 +145,11 @@ struct dept_map {
 	 */
 	unsigned int			wgen;
 
+	/*
+	 * requestor for the event context to run
+	 */
+	struct dept_stack		*req_stack;
+
 	/*
 	 * whether this map should be going to be checked or not
 	 */
@@ -486,7 +491,15 @@ struct dept_task {
  * for subsystems that requires compact use of memory e.g. struct page
  */
 struct dept_ext_wgen{
+	/*
+	 * wait timestamp associated to this map
+	 */
 	unsigned int wgen;
+
+	/*
+	 * requestor for the event context to run
+	 */
+	struct dept_stack		*req_stack;
 };
 
 #define DEPT_TASK_INITIALIZER(t)				\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index fb33c3758c25..abf1cdab0615 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -129,6 +129,7 @@ static int dept_per_cpu_ready;
 #define DEPT_INFO(s...)		pr_warn("DEPT_INFO: " s)
 
 static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t dept_req_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 static arch_spinlock_t dept_pool_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 /*
@@ -1669,7 +1670,8 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 
 static bool add_ecxt(struct dept_map *m, struct dept_class *c,
 		     unsigned long ip, const char *c_fn,
-		     const char *e_fn, int sub_l)
+		     const char *e_fn, int sub_l,
+		     struct dept_stack *req_stack)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_ecxt_held *eh;
@@ -1700,10 +1702,16 @@ static bool add_ecxt(struct dept_map *m, struct dept_class *c,
 
 	e->class = get_class(c);
 	e->ecxt_ip = ip;
-	e->ecxt_stack = ip && rich_stack ? get_current_stack() : NULL;
 	e->event_fn = e_fn;
 	e->ecxt_fn = c_fn;
 
+	if (req_stack)
+		e->ecxt_stack = get_stack(req_stack);
+	else if (ip && rich_stack)
+		e->ecxt_stack = get_current_stack();
+	else
+		e->ecxt_stack = NULL;
+
 	eh = dt->ecxt_held + (dt->ecxt_held_pos++);
 	eh->ecxt = get_ecxt(e);
 	eh->map = m;
@@ -2147,6 +2155,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u,
 	m->sub_u = sub_u;
 	m->name = n;
 	m->wgen = 0U;
+	m->req_stack = NULL;
 	m->nocheck = !valid_key(k);
 
 	dept_exit_recursive(flags);
@@ -2181,6 +2190,7 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
 		m->name = n;
 
 	m->wgen = 0U;
+	m->req_stack = NULL;
 
 	dept_exit_recursive(flags);
 }
@@ -2189,6 +2199,7 @@ EXPORT_SYMBOL_GPL(dept_map_reinit);
 void dept_ext_wgen_init(struct dept_ext_wgen *ewg)
 {
 	ewg->wgen = 0U;
+	ewg->req_stack = NULL;
 }
 
 void dept_map_copy(struct dept_map *to, struct dept_map *from)
@@ -2376,7 +2387,8 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, unsigned long e_f,
 			 unsigned long ip, const char *e_fn,
-			 bool sched_map, unsigned int wg)
+			 bool sched_map, unsigned int wg,
+			 struct dept_stack *req_stack)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2397,7 +2409,7 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
-	if (c && add_ecxt(m, c, 0UL, NULL, e_fn, 0)) {
+	if (c && add_ecxt(m, c, 0UL, "(event requestor)", e_fn, 0, req_stack)) {
 		do_event(m, c, wg, ip);
 		pop_ecxt(m, c);
 	}
@@ -2506,6 +2518,8 @@ EXPORT_SYMBOL_GPL(dept_stage_wait);
 
 static void __dept_clean_stage(struct dept_task *dt)
 {
+	if (dt->stage_m.req_stack)
+		put_stack(dt->stage_m.req_stack);
 	memset(&dt->stage_m, 0x0, sizeof(struct dept_map));
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
@@ -2571,6 +2585,7 @@ void dept_request_event_wait_commit(void)
 	 */
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 	WRITE_ONCE(dt->stage_m.wgen, wg);
+	dt->stage_m.req_stack = get_current_stack();
 
 	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
 exit:
@@ -2602,6 +2617,8 @@ void dept_stage_event(struct task_struct *requestor, unsigned long ip)
 	 */
 	m = dt_req->stage_m;
 	sched_map = dt_req->stage_sched_map;
+	if (m.req_stack)
+		get_stack(m.req_stack);
 	__dept_clean_stage(dt_req);
 
 	/*
@@ -2611,8 +2628,12 @@ void dept_stage_event(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
+	__dept_event(&m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen,
+		     m.req_stack);
 exit:
+	if (m.req_stack)
+		put_stack(m.req_stack);
+
 	dept_exit(flags);
 }
 
@@ -2692,7 +2713,7 @@ void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, new_e), m->name, false);
 
-	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l))
+	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l, NULL))
 		goto exit;
 
 	/*
@@ -2744,7 +2765,7 @@ void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, false);
 
-	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l))
+	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l, NULL))
 		goto exit;
 missing_ecxt:
 	dt->missing_ecxt++;
@@ -2792,9 +2813,11 @@ EXPORT_SYMBOL_GPL(dept_ecxt_holding);
 
 void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 {
+	struct dept_task *dt = dept_task();
 	unsigned long flags;
 	unsigned int wg;
 	unsigned int *wg_p;
+	struct dept_stack **req_stack_p;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2802,12 +2825,18 @@ void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 	if (m->nocheck)
 		return;
 
-	/*
-	 * Allow recursive entrance.
-	 */
-	flags = dept_enter_recursive();
+	if (dt->recursive)
+		return;
 
-	wg_p = ewg ? &ewg->wgen : &m->wgen;
+	flags = dept_enter();
+
+	if (ewg) {
+		wg_p = &ewg->wgen;
+		req_stack_p = &ewg->req_stack;
+	} else {
+		wg_p = &m->wgen;
+		req_stack_p = &m->req_stack;
+	}
 
 	/*
 	 * Avoid zero wgen.
@@ -2815,7 +2844,13 @@ void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 	WRITE_ONCE(*wg_p, wg);
 
-	dept_exit_recursive(flags);
+	arch_spin_lock(&dept_req_spin);
+	if (*req_stack_p)
+		put_stack(*req_stack_p);
+	*req_stack_p = get_current_stack();
+	arch_spin_unlock(&dept_req_spin);
+
+	dept_exit(flags);
 }
 EXPORT_SYMBOL_GPL(dept_request_event);
 
@@ -2826,6 +2861,8 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
 	unsigned int *wg_p;
+	struct dept_stack **req_stack_p;
+	struct dept_stack *req_stack;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2833,7 +2870,18 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 	if (m->nocheck)
 		return;
 
-	wg_p = ewg ? &ewg->wgen : &m->wgen;
+	if (ewg) {
+		wg_p = &ewg->wgen;
+		req_stack_p = &ewg->req_stack;
+	} else {
+		wg_p = &m->wgen;
+		req_stack_p = &m->req_stack;
+	}
+
+	arch_spin_lock(&dept_req_spin);
+	req_stack = *req_stack_p;
+	*req_stack_p = NULL;
+	arch_spin_unlock(&dept_req_spin);
 
 	if (dt->recursive) {
 		/*
@@ -2842,17 +2890,20 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 		 * handling the event. Disable it until the next.
 		 */
 		WRITE_ONCE(*wg_p, 0U);
+		if (req_stack)
+			put_stack(req_stack);
 		return;
 	}
 
 	flags = dept_enter();
-
-	__dept_event(m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
+	__dept_event(m, e_f, ip, e_fn, false, READ_ONCE(*wg_p), req_stack);
 
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
 	WRITE_ONCE(*wg_p, 0U);
+	if (req_stack)
+		put_stack(req_stack);
 
 	dept_exit(flags);
 }
-- 
2.17.1


