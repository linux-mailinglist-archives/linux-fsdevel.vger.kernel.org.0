Return-Path: <linux-fsdevel+bounces-49369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CDABB956
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFBE16DDDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9FF283C87;
	Mon, 19 May 2025 09:19:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35C27978F;
	Mon, 19 May 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646343; cv=none; b=UByRoWvLk3FNL1mkvQ8czrvNuRFfn/JnRpBgOg1WnTkPQOXMNqwt77fPtabPK+wCtrlr5Du8zeKvHAX2wiXvoqjdbbhnehZIYClBnYS6SvXtm9nyM5HdrWwNOjpWaHNBOOZsVVEivNmAlbLQ4xsD3SewunDJhYchBP2o91WYUPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646343; c=relaxed/simple;
	bh=xIkkCdiOJcy9hW8Y2iXba7Lek3wWMYXG6Tsggjp1lwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UiTr2w0vnqXS4T+fkqekX6OzD9qifsQe0F77r36Hio/DdDcWnfCJXKVpSzVLxrASINWrqhrMss3x2Ge8DYIC8ALAmjcZo84S47EYhl0AfaBnz6oMSIvYwvgRGu/zFQ7Fc6tDz0jxfZe2cKrOSjpKX3L/v3khQs+mp4Tn5B93GbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-6d-682af76fcbf6
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
Subject: [PATCH v16 26/42] dept: print staged wait's stacktrace on report
Date: Mon, 19 May 2025 18:18:10 +0900
Message-Id: <20250519091826.19752-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PXc5+O08/DxtuDJk4U/vMMH/xs7EZ/sGGm35zt564cso0
	pTtyKcnqSHI97LQ6yl2jcKR0VB6ic04qdWvNcdXk7qiO3GX++ey1z3vv1+efD4NLWsj5jDIh
	WVAlyOOklIgQDU0vXZ34M0KxdlgD4PNmEVBcY6Kg4041AlNdBgbulm3wwe9BMPHqDQ76gg4E
	pf09ONTZehFYK89S0DkwA+y+EQpaC7IpyCyvoeDttwAG3YX5GFSbd8Jn4yAB7XllGOjdFFzX
	Z2LB8QWDMWMVDcb0ZeCqLKIh0C+D1l4HCdauVXCtpJuCR9ZWAmz1Lgw6HxRT0GuaJKHd9oIA
	f+4C6LicQ8Lt4TIKvvmNOBh9IzS8azRgYDPMgVpNUHjuxx8Snuc0YnCu4i4G9o8PETzO6sPA
	bHJQ0OzzYGAxF+AwfqsFgSt3iAbtxTEarmfkIsjWFhKg6Y6CiV/Byze8Msi4WUvA7d8OtGUT
	byoxIb7ZM4LzGstJftz3nuKtfgPBt5VxfENRD81rHnfRvMF8grdURvDlj9wYXzrqI3lz1QWK
	N4/m07xuyI7xw69f07sW7hdtjBHilGpBtWbzYZHi86/IY4FNKYVXHVQ6cst0iGE4dj1nz0rT
	obAp/DRup0NMscs5p3MMD/EsdjFnyRkkdUjE4KwjnPtw4yMKBTPZ7ZxrsI0IMcEu4y6PGYmQ
	U8xGcw23kv85F3HVtY1TnrDguiu7eaoqYaM4e3UJEXJyrD6Msw5r8X+FedzTSieRh8QGNK0K
	SZQJ6ni5Mm59pCI1QZkSeSQx3oyCz2VMCxyoR6Mde5oQyyDpdHGtdaVCQsrVSanxTYhjcOks
	cZVlhUIijpGnnhJUiYdUJ+KEpCa0gCGkc8Xr/CdjJOxRebIQKwjHBNX/FGPC5qejK09o0IVf
	io0+/rx8zTr1+dJ7rp179x3cm/WmDTIPomfftV/72rVHd79MexfrWeEpKO+Jygj3Gtys7X6y
	d1AWrt41MbD7ZdHSyTt5WvvDDQONzmKVtK+e5KIrLJ2srCXAjM6uOW3Z+jOtv6d4x+TWM0sk
	em+Ks8xEFr5/1ZwvlRJJCrksAlclyf8CoBHhQ1gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe47ZddcK5k3srmlppmigiRUz+JGtpjo4+LbN+O+jCo3tgKt
	aSmKiQlIFYVBxKSAL3QVTCVtFXarUdFqhYgWYkWpVRgvSgyxAmIcrQLVrbjsy8kv55/zO1/+
	HKlsphdzekOhZDJo81WMglJsXVe2yvg+Tbe6rWIpRKeOUXC2xcNAzyU3As/lUgIidzfC09g4
	gtkHD0mos/UgOPdikITLnUMIfM2HGeh9OR9C0UkGArZKBsqaWhh4NBYnYKD2JAFueQsMO0cp
	6D7RSEBdhIEzdWVEYrwiYNrpYsFZooaR5tMsxF9kQmAoTENHQ4AGX/8KOGUfYOCmL0BB57UR
	AnrbzjIw5PmHhu7O+xTEqlOhp6aKhotvGhkYizlJcEYnWXjsdxDQ6fgSWq0J69G/P9Fwr8pP
	wNHzfxIQ6ruB4Nax5wTInjADHdFxAryyjYSZC3cRjFRPsHDk92kWzpRWI6g8UkuBdUADsx8S
	nxumMqH0j1YKLn4Mo5+yscfuQbhjfJLEVu9+PBN9wmBfzEHhrkYRXz89yGLrrX4WO2QL9jan
	4aabEQKfexelsew6zmD53UkWV0yECPwmGGS3f/2r4odcKV9fJJkysnMUuuEP6fviPx6orQ8z
	JSiSWYGSOFHIEv+aCbFzzAjfic+eTZNznCJ8K3qrRukKpOBIIZwsPm3oQ3PBQmGTODLaRc0x
	JajFmmlngjmOF9aI1y8U/uf8RnS3+j97khLr/sqOz6dKQSOG3HbqBFI40DwXStEbigq0+nxN
	ujlPV2zQH0jfbSyQUaI/zkPxmmtoqndjOxI4pPqCb/Ut1ylpbZG5uKAdiRypSuFd3mU6JZ+r
	LT4omYy/mSz5krkdpXKUahH/yw4pRyns0RZKeZK0TzL9nxJc0uISZKS/X2JNNt97vEF/iTbi
	25p40rpByy5ejsiGzV/ZlntTr+TyeU1tszumdCst6p/XB5bVl9Pr+UOvx67Oy2Da9ua8dde7
	Xqvtlfbhj6uS8ZLsterG9xMLNNuO70zh/d2x8g2n+g4Hs7LuUJ8iFPcqzbXJL5cLLVEbEQgG
	71tUlFmnzUwjTWbtv94ReEw7AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Currently, print nothing about what event wakes up in report.  However,
it makes hard to interpret dept's report.

Make it print wait's stacktrace that the event wakes up.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  5 ++++
 include/linux/sched.h    |  2 ++
 kernel/dependency/dept.c | 59 ++++++++++++++++++++++++++++++++++------
 3 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 236e4f06e5c8..b6dc4ff19537 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -227,6 +227,11 @@ struct dept_ecxt {
 			 */
 			unsigned long	event_ip;
 			struct dept_stack *event_stack;
+
+			/*
+			 * wait that this event ttwu
+			 */
+			struct dept_stack *ewait_stack;
 		};
 	};
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 541ddacdc3d0..43927e61921b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -865,6 +865,7 @@ struct dept_task {
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
 	bool				stage_timeout;
+	struct dept_stack		*stage_wait_stack;
 	arch_spinlock_t			stage_lock;
 
 	/*
@@ -906,6 +907,7 @@ struct dept_task {
 	.stage_w_fn = NULL,					\
 	.stage_ip = 0UL,					\
 	.stage_timeout = false,					\
+	.stage_wait_stack = NULL,				\
 	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 79357a3a03bb..dc3effabfab4 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -523,6 +523,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 	e->enirqf = 0UL;
 	e->event_ip = 0UL;
 	e->event_stack = NULL;
+	e->ewait_stack = NULL;
 }
 SET_CONSTRUCTOR(ecxt, initialize_ecxt);
 
@@ -578,6 +579,8 @@ static void destroy_ecxt(struct dept_ecxt *e)
 		put_stack(e->ecxt_stack);
 	if (e->event_stack)
 		put_stack(e->event_stack);
+	if (e->ewait_stack)
+		put_stack(e->ewait_stack);
 }
 SET_DESTRUCTOR(ecxt, destroy_ecxt);
 
@@ -794,6 +797,11 @@ static void print_dep(struct dept_dep *d)
 
 		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
 		print_ip_stack(e->event_ip, e->event_stack);
+
+		if (valid_stack(e->ewait_stack)) {
+			pr_warn("(wait to wake up)\n");
+			print_ip_stack(0, e->ewait_stack);
+		}
 	}
 
 	if (!irqf) {
@@ -807,6 +815,11 @@ static void print_dep(struct dept_dep *d)
 
 		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
 		print_ip_stack(e->event_ip, e->event_stack);
+
+		if (valid_stack(e->ewait_stack)) {
+			pr_warn("(wait to wake up)\n");
+			print_ip_stack(0, e->ewait_stack);
+		}
 	}
 }
 
@@ -1657,7 +1670,8 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 
 static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 		struct dept_class *c, unsigned long ip, const char *c_fn,
-		const char *e_fn, int sub_l)
+		const char *e_fn, int sub_l,
+		struct dept_stack *ewait_stack)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_ecxt_held *eh;
@@ -1691,6 +1705,7 @@ static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 	e->class = get_class(c);
 	e->ecxt_ip = ip;
 	e->ecxt_stack = ip ? get_current_stack() : NULL;
+	e->ewait_stack = ewait_stack ? get_stack(ewait_stack) : NULL;
 	e->event_fn = e_fn;
 	e->ecxt_fn = c_fn;
 
@@ -1797,7 +1812,7 @@ static int find_hist_pos(unsigned int wg)
 
 static void do_event(struct dept_map *m, struct dept_map *real_m,
 		struct dept_class *c, unsigned int wg, unsigned long ip,
-		const char *e_fn)
+		const char *e_fn, struct dept_stack *ewait_stack)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait_hist *wh;
@@ -1825,7 +1840,7 @@ static void do_event(struct dept_map *m, struct dept_map *real_m,
 	 */
 	if (find_ecxt_pos(real_m, c, false) != -1)
 		return;
-	eh = add_ecxt(m, c, 0UL, NULL, e_fn, 0);
+	eh = add_ecxt(m, c, 0UL, NULL, e_fn, 0, ewait_stack);
 
 	if (!eh)
 		return;
@@ -2360,7 +2375,8 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 		unsigned long e_f, unsigned long ip, const char *e_fn,
-		bool sched_map, unsigned int wg)
+		bool sched_map, unsigned int wg,
+		struct dept_stack *ewait_stack)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2382,7 +2398,7 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c)
-		do_event(m, real_m, c, wg, ip, e_fn);
+		do_event(m, real_m, c, wg, ip, e_fn, ewait_stack);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2498,6 +2514,9 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
 	dt->stage_timeout = false;
+	if (dt->stage_wait_stack)
+		put_stack(dt->stage_wait_stack);
+	dt->stage_wait_stack = NULL;
 }
 
 void dept_clean_stage(void)
@@ -2561,6 +2580,14 @@ void dept_request_event_wait_commit(void)
 
 	wg = next_wgen();
 	WRITE_ONCE(dt->stage_m.wgen, wg);
+
+	/*
+	 * __schedule() can be hit multiple times between
+	 * dept_stage_wait() and dept_clean_stage().  In that case,
+	 * keep the first stacktrace only.  That's enough.
+	 */
+	if (!dt->stage_wait_stack)
+		dt->stage_wait_stack = get_current_stack();
 	arch_spin_unlock(&dt->stage_lock);
 
 	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
@@ -2579,6 +2606,7 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	struct dept_map m;
 	struct dept_map *real_m;
 	bool sched_map;
+	struct dept_stack *ewait_stack;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2597,6 +2625,10 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	m = dt_req->stage_m;
 	sched_map = dt_req->stage_sched_map;
 	real_m = dt_req->stage_real_m;
+	ewait_stack = dt_req->stage_wait_stack;
+	if (ewait_stack)
+		get_stack(ewait_stack);
+
 	__dept_clean_stage(dt_req);
 	arch_spin_unlock(&dt_req->stage_lock);
 
@@ -2607,8 +2639,12 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
+	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map,
+			m.wgen, ewait_stack);
 exit:
+	if (ewait_stack)
+		put_stack(ewait_stack);
+
 	dept_exit(flags);
 }
 
@@ -2688,7 +2724,7 @@ void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, new_e), m->name, false);
 
-	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l))
+	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l, NULL))
 		goto exit;
 
 	/*
@@ -2740,7 +2776,7 @@ void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
 	k = m->keys ?: &m->map_key;
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, false);
 
-	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l))
+	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l, NULL))
 		goto exit;
 missing_ecxt:
 	dt->missing_ecxt++;
@@ -2840,7 +2876,7 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 
 	flags = dept_enter();
 
-	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
+	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p), NULL);
 
 	/*
 	 * Keep the map diabled until the next sleep.
@@ -2912,6 +2948,11 @@ void dept_task_exit(struct task_struct *t)
 		dt->stack = NULL;
 	}
 
+	if (dt->stage_wait_stack) {
+		put_stack(dt->stage_wait_stack);
+		dt->stage_wait_stack = NULL;
+	}
+
 	for (i = 0; i < dt->ecxt_held_pos; i++) {
 		if (dt->ecxt_held[i].class) {
 			put_class(dt->ecxt_held[i].class);
-- 
2.17.1


