Return-Path: <linux-fsdevel+bounces-13713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BE28731CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E601F23521
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A764CC0;
	Wed,  6 Mar 2024 08:55:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266E60DD6;
	Wed,  6 Mar 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715346; cv=none; b=NCMfy2KVusQuPJ9GiruymgiBeLj0tbogfYC34AmQbM/LG/UXUcF9vU6dDLoF616GMyyyhRrH2pZgAsRKTLpRRampiGLfclE0hc4a/i0yoDnoUGph1p6Wi1Ai2raB2Hi+G5comXah5kTBDNzjEGfgTxo9iu7js3pyUAfG7yOpjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715346; c=relaxed/simple;
	bh=LIy0pGzgh1KfCx3V9I4vVrDFzUkgQh3CEYezt1V8iYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=p+8aLvSXbX1Hcf3zFC2ZAh291uYySIgyvgaW1ntk08FAvO6Pk5xSRmzitu7QSAr8rSX8Bl+5GECwNd7fnEg7MNDDwqBKr/DlhwN8Dn7LvNFbaoetxXFKvuB6z7qIZ10kb76GCRpOZPuM2/MheZ40N5dCSRHdIox1aTfp6wN4lw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-28-65e82f7e8870
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
Subject: [PATCH v13 16/27] dept: Track timeout waits separately with a new Kconfig
Date: Wed,  6 Mar 2024 17:55:02 +0900
Message-Id: <20240306085513.41482-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0wTaRiG/f+Z+Weo1oxV44gXaxoNiUQEj59ZNcaLdZJV16h4ARpo7ESq
	gKTVKroaDpW4KAeJ2BUQKZJaAQGnCB5AKwpyiFilKioQJUSpFEjQEgpEBdSbL0/e981z9XGU
	Smb8OV3sYUkfq4lWEwWt6J9hWXpqWa8UnJS1As6fCwbv1zM05JWXEnCWlSAorUzE4K7fDK+H
	PQjGnj6jwJztRGD50ElBZUMXglpbEoG2npng8g4SaMo+SyD5ajmB533jGDouZmEokbdCS2Yh
	BofvEw1mN4FcczKeOL0YfNZiFqwJi6HblsPC+IcQaOp6xUDt20C4lN9BoKa2iYaG290Y2u7m
	Eegq/c5AS0MjDc7zaQzcGCgk0DdspcDqHWThhaMAQ4VpQpTy5RsDT9IcGFKKbmJwvbmH4P6Z
	9xjk0lcEHnk9GOxyNgWj1+oRdKf3s3D6nI+F3MR0BGdPX6TB1LEKxkbyyMa14iPPICWa7EfF
	2uECWmwuFMQ7OZ2saLr/lhUL5COi3bZEvFrjxqJlyMuIcvF/RJSHslgxtd+FxYHWVlZs/H+M
	FntcZrzdP0yxTitF64ySftmGSEVUfZ+dxPVGHjO7uQR0a0sq8uMEfqWQX12Gf/P1RB8zyYQP
	ENrbfdQkz+EXCva0j1M5xXsUQlHrX6mI42bzO4TOd4bJmOYXC1W+qqmJkl8tFOUWMT+Vfwgl
	FY4pjd9EnjGQQSZZxa8SniZbyM/Nd04YSf+1ny88tLXTmUhZgKYVI5Uu1hij0UWvDIqKj9Ud
	C9p3KEZGE59kPTkefhsNOXfWIZ5D6hnKjX6fJBWjMRriY+qQwFHqOcp/R3sklVKriT8u6Q9F
	6I9ES4Y6tICj1fOUy4ePalX8fs1h6aAkxUn63y3m/PwTUODuCFTnPzd0kXHbG9OzHTWv3YPB
	jSFf/34QpHG93J2ZHVaxJzT8zwVZEZXLN7w4kTQrI7BMG9BcXe152X88wDZ79HHUrrbuODlo
	zV152/TPzaEpCXth03pH2LVFGVbT+JMLzBdjXw1qqQo2XXY1hX90FltC9Vf+ORDgGzJoOx7n
	jKhpQ5QmZAmlN2h+AO/k9ZdFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRiA+87lO8fV6rSkDoZUi1C6uISMtwtRZHmICokiqh8565AjNdnM
	shvaTLyX1lzlBS9jzbtuWXaZiebSIrO0i6WiIuXSJpmTllqp0Z+Xh+d9eX69LCnT0R6sKjxS
	VIcrQ+VYQkn2btKuuaQYENfW5HpAespacI4mUJBdUYqhtbwEQendWALsjQHwfmwIwfjLVyTo
	da0I8nu7SLhr60ZgNV3G0NY/F9qdwxiadckYtIUVGF4PThDQmZlBQIl5D7y4VkBAnesLBXo7
	hiy9lpgaAwS4jMUMGGNWQJ/pNgMTvb7Q3P2OhoacZhqsH1fBrdxODI+tzRTYavoIaHuYjaG7
	9A8NL2xNFLSmp9JQ5ijAMDhmJMHoHGbgTV0eAZVxU7X4H79peJZaR0C8oYqA9o5HCGoTeggw
	l77D0OAcIsBi1pHw604jgr60bwxcSXExkBWbhiD5SiYFcZ1+MP4zG2/dKDQMDZNCnOWMYB3L
	o4TnBbzw4HYXI8TVfmSEPPNpwWJaKRQ+thNC/oiTFszFiVgwj2QwQtK3dkJwtLQwQtPNcUro
	b9cTgYsPSzYfF0NVUaJasSVIEtI4aMERA0Fn9XY2BlXvTkJuLM+t44tiXfQ0Y86L//DBRU6z
	O7eUt6R+nvEkNyThDS07kxDLLuD28V2fNNOa4lbw91z3Zk6k3HrekGWg/yWX8CWVdTMZtyl/
	1XEVT7OM8+NfavPxNSTJQ7OKkbsqPCpMqQr189GcDIkOV531OXYqzIymnsV4cSK9Bo22BdQj
	jkXyOdKtbl9EGa2M0kSH1SOeJeXu0gu/+kWZ9Lgy+pyoPnVUfTpU1NSjxSwlXyTddVAMknEn
	lJHiSVGMENX/twTr5hGDFtiu1wTmN02aDpXceeu5wTRfgaM37YKvktH73eere6qr2hQW72D0
	PN1nY6185+qFByIzv3vNcSzbnjiv2PPSjidF/jt6AvYvD7T1d+QkKzr8a4Ojgi9Ycx9NGirL
	rdt6g2c7tPE6+820I94VBU+lD6W9VSmZtOJ7ubTzxpLGMueInNKEKH1XkmqN8i+cS3f6KAMA
	AA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

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
index ca1a34be4127..0280e45cc2af 100644
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
@@ -453,6 +458,7 @@ struct dept_task {
 	bool				stage_sched_map;
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
+	bool				stage_timeout;
 
 	/*
 	 * the number of missing ecxts
@@ -490,6 +496,7 @@ struct dept_task {
 	.stage_sched_map = false,				\
 	.stage_w_fn = NULL,					\
 	.stage_ip = 0UL,					\
+	.stage_timeout = false,					\
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
 	.softirqs_enabled = false,				\
@@ -507,8 +514,8 @@ extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, con
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 
-extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l);
-extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn);
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
+extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
 extern void dept_request_event_wait_commit(void);
 extern void dept_clean_stage(void);
 extern void dept_stage_event(struct task_struct *t, unsigned long ip);
@@ -558,8 +565,8 @@ struct dept_task { };
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
index 8ca46ad98e10..1b8fa9f69d73 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -739,6 +739,8 @@ static void print_diagram(struct dept_dep *d)
 	if (!irqf) {
 		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
 		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		if (w->timeout)
+			print_spc(spc, "--------------- >8 timeout ---------------\n");
 		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
 	}
 }
@@ -792,6 +794,24 @@ static void print_dep(struct dept_dep *d)
 
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
@@ -814,10 +834,14 @@ static void print_circle(struct dept_class *c)
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
@@ -1563,7 +1587,8 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 static atomic_t wgen = ATOMIC_INIT(1);
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep)
+		     const char *w_fn, int sub_l, bool sched_sleep,
+		     bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1583,6 +1608,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
+	w->timeout = timeout;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -2294,7 +2320,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
  */
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
 			unsigned long ip, const char *w_fn, int sub_l,
-			bool sched_sleep, bool sched_map)
+			bool sched_sleep, bool sched_map, bool timeout)
 {
 	int e;
 
@@ -2317,7 +2343,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
@@ -2354,14 +2380,23 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
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
 
@@ -2370,21 +2405,30 @@ void dept_wait(struct dept_map *m, unsigned long w_f,
 
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
 
@@ -2430,6 +2474,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
 
 	dt->stage_w_fn = w_fn;
 	dt->stage_ip = ip;
+	dt->stage_timeout = timeout;
 exit:
 	dept_exit_recursive(flags);
 }
@@ -2441,6 +2486,7 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
+	dt->stage_timeout = false;
 }
 
 void dept_clean_stage(void)
@@ -2471,6 +2517,7 @@ void dept_request_event_wait_commit(void)
 	unsigned long ip;
 	const char *w_fn;
 	bool sched_map;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2493,6 +2540,7 @@ void dept_request_event_wait_commit(void)
 	w_fn = dt->stage_w_fn;
 	ip = dt->stage_ip;
 	sched_map = dt->stage_sched_map;
+	timeout = dt->stage_timeout;
 
 	/*
 	 * Avoid zero wgen.
@@ -2500,7 +2548,7 @@ void dept_request_event_wait_commit(void)
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 	WRITE_ONCE(dt->stage_m.wgen, wg);
 
-	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
 exit:
 	dept_exit(flags);
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9602f41ad8e8..0ec3addef504 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1312,6 +1312,16 @@ config DEPT
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


