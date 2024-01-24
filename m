Return-Path: <linux-fsdevel+bounces-8743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64D83A929
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EDA28C32B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820166D1B8;
	Wed, 24 Jan 2024 12:00:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCBF679E0;
	Wed, 24 Jan 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097617; cv=none; b=Y0QWtLoiHyP8Rg+njGDdTkgX55aiLXlMfiO4PqcMXZhba3QC/63j78Qj/B7Y6+oqDAROSDfzuIGBQfs5LXVTtw6hfw0ZgPsEAQpZBgQSVrd7ph5xS/m03DDc1m9tVeB6CqEHWbp8VuvMiawkue56X+Uq0s8dPP0JDoV2ot5nn4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097617; c=relaxed/simple;
	bh=ul/wiSzDZit7bOUs1eKkFyN45Ghg8m4Ni94/4VNQ6UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kDjEdRtZoatvx19SN2Nxm2WdjcBTfM+AfGJUAb1SH/oSbjTbNmRZpe2AC79B63Ivf/8AC/+/2U78zVtmAcBiJ6Z7b11epdGu6ALxD9OhS7+6aO38WNY7DJvDntiNU/hc3Dei0TOQ9/px4yaqxKuzszQqsbqWtRDYOPmMJpLwy4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-c4-65b0fbb78df2
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
Subject: [PATCH v11 25/26] dept: Print event context requestor's stacktrace on report
Date: Wed, 24 Jan 2024 20:59:36 +0900
Message-Id: <20240124115938.80132-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwHcN/v7+nuOH6OzU9nww1tHkPymRn9wfwwY2v9wx/c9KOb67SL
	iNnCXURXihxJ6rJzu1LnKosenKKTlNAqqVQeW12XuFunPNx5+Oez1z6fvd9/fUSErIIKEqk0
	hwStRqlW0BJS4pqUt6R8zCaE2G5MgfSUEPB8O0tCdnEhDc1FBQgKS09i6H+8Cdq8gwjGGp8T
	YMxsRpDX20VAaV03girLKRpevZ8MLR43DfWZ52k4nV9Mw4uBcQydlzMwFNi3QcMFEwaH7xMJ
	xn4arhlPY//4jMFntjJgTpwPfZYsBsZ7l0N9dysFVR2L4GpOJw2VVfUk1JX3YXh1P5uG7sJf
	FDTUPSGhOd1Awe0hEw0DXjMBZo+bgZeOXAw2nb8o6etPCpwGB4akm3cwtLyuQFB9tgeDvbCV
	hlrPIIYSeyYB3289RtCX6mJAn+Jj4NrJVATn9ZdJeP7DSYGucxWMjWbT4Wv42kE3wetKjvBV
	3lySf2ri+HtZXQyvq+5g+Fz7Yb7EspDPr+zHfN6Ih+Lt1mSat49kMPw5Vwvmh5qaGP7JlTGS
	f99ixDvkOyVrowS1Kl7QLlu3RxJdf91FxCZvPPqhv5JMRFdWn0NiEceGcm09Tvq/kxobqYBp
	Nphrb/cRAU9n53Alho/+vUREsGcmcpbhxj+BaWwkV/HdigIm2fnc5+QyHLCUDeN+/hgl/pbO
	5gpsjj8W+/e3r3aQAcvYVVyPNY0JlHLsGTF36Y3pX2Am99DSTl5A0lw0wYpkKk18jFKlDl0a
	naBRHV2692CMHflfynxifFc5GmmOqEGsCCkmScOtxYKMUsbHJcTUIE5EKKZL22cWCTJplDLh
	mKA9uFt7WC3E1SC5iFTMkK7wHomSsfuVh4QDghAraP9fsUgclIgy0uXbf2kj3Hf3nBj+kqbb
	4ujKUd9ym4TNOYa1rfu+bhmVl0XFq4+vFq9XOEszL3ZtdLRtjTbNnZhhdmVNDntg2/ARR/pM
	QbO6PzljFw8tNsxL8RaF7DTKFXpV1oCljk7KdzwKn/rFHrktIVijL4p5d0mdtmDlh7epevAM
	Bj8LU5Bx0crlCwltnPI3HTPhU04DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwHcN/v7+k6zn67Mj9h7CZWppLiY4w2o9/ayNbMZjNu/OhWnXZX
	EWNRUjiVrZI6Ttlpd13ljnkqWlGd1gMl1Sqc0NGDua7n4o7557PX3u/t/ddHREi1lLdIoYwX
	VEp5jIwWk+I9W1LWPZquEALHv2+A7KuB4BxNJ6GwvJSG1jIjgtIH5zHYX4XB+7FBBNNNLQTk
	5bQiuPOpl4AHdX0Iqkou0NDWvxDanSM0WHOu0JBSXE7Dmx8zGHpyr2MwmndDY1YRhurJbyTk
	2WkoyEvBrjOAYVJvYECf7AO2kpsMzHxaD9a+DgpqtVYKqrrXQv6tHhoqq6wk1D22YWh7WkhD
	X+lvChrrGkhozdZQYBououHHmJ4AvXOEgbfVOgwVqa61NMccBfWaagxpd+9jaO96huB5+kcM
	5tIOGmqdgxgs5hwCpu69QmC7NsTAxauTDBScv4bgysVcElpm6ylI7QmB6YlCOnQLXzs4QvCp
	lpN81ZiO5F8XcfyTm70Mn/q8m+F15gTeUuLHF1faMX/nl5PizYYMmjf/us7wl4faMT/c3Mzw
	DTemSb6/PQ/vXXZAvPWoEKNIFFQB2w6Lo6zaISIuY+epL/ZKMhnd2HQZeYg4NphLa2qi3KbZ
	NVxn5yThthe7krNovrpysYhgL83nSn420e7Ck93HPZsyILdJ1ocbyHiI3ZawG7m52Qni3+gK
	zlhR/dcertyU3026LWVDuI+GTCYLiXVongF5KZSJsXJFTIi/OjoqSak45X/kRKwZuZ5Gf3Ym
	+zEabQurQawIyRZIQg3lgpSSJ6qTYmsQJyJkXpLOJWWCVHJUnnRaUJ04pEqIEdQ1aKmIlC2W
	hO8XDkvZ4/J4IVoQ4gTV/xaLPLyT0Ysg28aXxdmtIbe4d8v0Lf6ftfYkv4QvUw6m/GBBwO4P
	jf2Ou6FBDxc5Vs9ZO7YzcT4LJo6ZvPcc2zGh0/pHBhoHI74F+J2hO8YH8jURMGDbHNyzQ7K8
	dyq8K6VgaPl45+gcudWhfnLbyPn4Rq4K9/yZucLyeVea5pxpW8VST1+TjFRHydf7ESq1/A9P
	xOmEMAMAAA==
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


