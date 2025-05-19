Return-Path: <linux-fsdevel+bounces-49362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5FABB926
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A221883BE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9727F732;
	Mon, 19 May 2025 09:19:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69332749E8;
	Mon, 19 May 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646339; cv=none; b=U2/lW4yMeufnOpoPQSP3Ad6eWkSodidrS+Q/ncban9rVauITNxA7gh4cy1g2JTpGL06+aQrG2IwGM9yOQH5rxy1iowgkqLglNXSgfl1SP5u3bE/XG1R2u/xHCdd0s3pjlBnGMVDx7SrVLomagluVsdPDZUrPF01CrE2MVllkZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646339; c=relaxed/simple;
	bh=q58Uga80B34rBaKlkqZqhMJuk4jxvsWlEkIvfJAN07I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P1oxQRcXegIU4ZvMYe7b2NjX4jxCbOclztJThv69Qsb8Vv1d4zlwChgrhgVcyoS8gQ1dFHlJMmK/4reK6ZyrfgdBbA5vnLp2BmDtN0+wfsahb2VJ0xoyiIiQPcvalCbtqafh5bSQ7Z5hVKu1MtebfB+MHzxaeKp9zw3ozutB780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-f5-682af76ed623
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
Subject: [PATCH v16 18/42] dept: track timeout waits separately with a new Kconfig
Date: Mon, 19 May 2025 18:18:02 +0900
Message-Id: <20250519091826.19752-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxSH97739t7bzs5rMXqn+zBN2LRGGQaX4zI3s+zjjVHjx5YlanSN
	3K2NUExREDMSOiu6ljIkQQS0FDS1KVVZaxQdNQijHX4AzkqhoUirITJAMrCdILq1mP1z8uR3
	znnOP4ejFH7JIk6r2y/qdeosJSOjZWNz6lbk/KPSfGC6S0Hs6TEaTl10MdB9oQGB65IBw3D7
	VxCMjyJ4fqeLgsqKbgR1kTAFl3wDCLyOnxi49+gNCMTGGeioMDNw+MxFBu6OzGDoP1GOocG9
	ER7Yh2i4VVaPoXKYgZrKwzhRHmOYsjtZsBelQtRRzcJMJB06Bnok4A0thyprPwPN3g4afE1R
	DPeunWJgwPWvBG75/qAhXroYuo9bJHD+ST0DI3E7BfbYOAt/ttgw+GwLoNGYEBZPvpSA39KC
	ofjsrxgCfb8huH5sEIPb1cNAW2wUg8ddQcH0uXYE0dIxFo6UTLFQYyhFYD5yggZj/2p4/ixx
	+fTTdDDUNtJw/kUPWreWuKwuRNpGxyli9OST6dh9hnjjNprcrBfI1eowS4zXQyyxuQ8Qj0NF
	zjQPY1I3EZMQt/NnhrgnylliGgtg8qSzk9381nbZx5liljZP1Kd98p1Mc9YTpvaZ9xwMnSvH
	Rci/yYQ4TuAzhDabxoSks1g8YERJZvj3hd7eKSrJ8/klgscyJDEhGUfxPa8LwdN9s0Mp/FbB
	2hRmkkzzqYIj4sdJlvMfCsbaFvRK+q7Q0NgyK5Im8pC5bTZX8KuFQIOVTkoF/hepYO0aYl8t
	vCnccPTSZUhuQ685kUKry8tWa7MyVmoKdNqDK/fkZLtR4r3shTM7mtBE97ZWxHNIOUfe6F2m
	UUjUebkF2a1I4CjlfLnTs1SjkGeqCw6J+pzd+gNZYm4rWszRyoXyVfH8TAX/g3q/uFcU94n6
	/7uYky4qQimffhH4/nYtSb3SsUEatdSnBJd9O/fv8JpBQ/WLB7agZ4H+5NvGaJlnZl0k40Jh
	pCS45fM8+uiKXZc3+B7hkyHZ707tl7qUrx+rsv9aMvhs066PqmrMnXOPrt+s6upKC7X7Pzsu
	/Jje12kpmy4ZyXmPmjRM7nxY5U9rLnqncMj/Tf48JZ2rUaerKH2u+j+pjWXuWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHfZ736mrxsqTeiqhGka2LSSkHsgv1oQe7EEUEFdSqlzZyszaz
	DAJtr8s0rQQVr02NKXPV2vpgl8VSctlNa8vK1NJCkiyhnOWlyzT6cvjx/x9+58vhKZWDmcnr
	jSmSyahNUrMKWrF1lWWp8YdGt3y0QQOhwSwayq47WWi9VofAeTMDQ9+DjfBqqB/B6NMWCooK
	WhFUdndScLOpC4G39gwLgY9TIBgaYKG5IIcFS/V1Fp5/HsPQUZiPoc69Bd7Ze2l4fLEKQ1Ef
	C6VFFhwenzAM2x0c2NMXQE9tCQdj3bHQ3NXGQGN5MwPe9sVQXNHBwl1vMw1N9T0YArfLWOhy
	/mHgcdNDGobyZkHrpVwGrn6tYuHzkJ0Ce2iAgxc+G4Ym2zRwyWGr9ftvBvy5PgzWKzcwBN/c
	QXAv6z0Gt7ONhcZQPwaPu4CCkZoHCHryvnCQeX6Yg9KMPAQ5mYU0yB1xMPozfLl8MBYyLrto
	uPqrDa1bQ5wVTkQa+wcoIntOkJHQS5Z4h2w0eVQlklslnRyR77VzxOY+Tjy1GlJ9tw+Tym8h
	hrgd51ji/pbPkewvQUy+PnvGbZu9W5FwSErSp0qmmDX7Fbornk7qaM7Bk+01+Tgd+bdmo0he
	FFaK1i4ZjTMrLBRfvx6mxjlKmCt6cnuZbKTgKaFtkviq/M3E0lRhu1hR38mOMy0sEGu7/Xic
	lUK8KF/2oX/SOWKdyzchigzn7TmNE7lKiBODdRX0RaSwoQgHitIbUw1afVLcMvMRXZpRf3LZ
	wWSDG4U/yH567FI9GgxsbEACj9STlS7vIp2K0aaa0wwNSOQpdZTS4YnWqZSHtGmnJFPyPtPx
	JMncgGbxtHq6MnGXtF8lHNamSEck6ahk+t9iPnJmOsKh+T9/H14SQSV37Jm3qT9w/4naKFgu
	eGMCttU18WeR357gX7dj/YrgZoel3uxfmDZ1btEBQ/Va8rFlOD3gaPkzY+eInCnrnprKbvn2
	mpevYFoTPhw7bYjWPI+9EH17g1Uz9lZt6nUVxwzkb68yFCTyq+SIlKyHpZ/0KzOt8S1q2qzT
	xmook1n7F2kEE989AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Waits with valid timeouts don't actually cause deadlocks.  However, dept
has been reporting the cases as well because it's worth informing the
circular dependency for some cases where, for example, timeout is used
to avoid a deadlock.

However, yes, there are also a lot of, even more, cases where timeout
is used for its clear purpose and meant to be expired.

Report these as an information rather than warning DEADLOCK.  Plus,
introduce CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT Kconfig to make it
optional so that any reports involving waits with timeouts can be turned
on/off depending on the purpose.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 13 +++++---
 include/linux/dept_ldt.h |  6 ++--
 include/linux/dept_sdt.h | 13 +++++---
 include/linux/sched.h    |  2 ++
 kernel/dependency/dept.c | 66 ++++++++++++++++++++++++++++++++++------
 lib/Kconfig.debug        | 10 ++++++
 6 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index cb1b1beea077..49f457390521 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -271,6 +271,11 @@ struct dept_wait {
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
@@ -377,8 +382,8 @@ extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
-extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l);
-extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn);
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
+extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
 extern void dept_request_event_wait_commit(void);
 extern void dept_clean_stage(void);
 extern void dept_ttwu_stage_wait(struct task_struct *t, unsigned long ip);
@@ -425,8 +430,8 @@ struct dept_map { };
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
-#define dept_wait(m, w_f, ip, w_fn, sl)			do { (void)(w_fn); } while (0)
-#define dept_stage_wait(m, k, ip, w_fn)			do { (void)(k); (void)(w_fn); } while (0)
+#define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
+#define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
 #define dept_request_event_wait_commit()		do { } while (0)
 #define dept_clean_stage()				do { } while (0)
 #define dept_ttwu_stage_wait(t, ip)			do { } while (0)
diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
index 8047d0a531f1..730af2517ecd 100644
--- a/include/linux/dept_ldt.h
+++ b/include/linux/dept_ldt.h
@@ -28,7 +28,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
 		else {							\
-			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl, false);	\
 			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
 		}							\
 	} while (0)
@@ -40,7 +40,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
 		else {							\
-			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl, false);\
 			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
 		}							\
 	} while (0)
@@ -52,7 +52,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
 		else {							\
-			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl, false);\
 			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
 		}							\
 	} while (0)
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 0535f763b21b..14917df0cc30 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -23,11 +23,12 @@
 
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
@@ -38,13 +39,13 @@
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
-
+#define sdt_might_sleep_start(m)	sdt_might_sleep_start_timeout(m, -1L)
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
@@ -54,7 +55,9 @@
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait_timeout(m, t)		do { } while (0)
 #define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start_timeout(m, t) do { } while (0)
 #define sdt_might_sleep_start(m)	do { } while (0)
 #define sdt_might_sleep_end()		do { } while (0)
 #define sdt_ecxt_enter(m)		do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 802fca4d99b3..541ddacdc3d0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -864,6 +864,7 @@ struct dept_task {
 	bool				stage_sched_map;
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
+	bool				stage_timeout;
 	arch_spinlock_t			stage_lock;
 
 	/*
@@ -904,6 +905,7 @@ struct dept_task {
 	.stage_sched_map = false,				\
 	.stage_w_fn = NULL,					\
 	.stage_ip = 0UL,					\
+	.stage_timeout = false,					\
 	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index a2384f3148c5..a6abba8f3a2c 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -757,6 +757,8 @@ static void print_diagram(struct dept_dep *d)
 	if (!irqf) {
 		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
 		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		if (w->timeout)
+			print_spc(spc, "--------------- >8 timeout ---------------\n");
 		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
 	}
 }
@@ -810,6 +812,24 @@ static void print_dep(struct dept_dep *d)
 
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
@@ -832,10 +852,14 @@ static void print_circle(struct dept_class *c)
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
@@ -1579,7 +1603,8 @@ static int next_wgen(void)
 }
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep)
+		     const char *w_fn, int sub_l, bool sched_sleep,
+		     bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1599,6 +1624,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
+	w->timeout = timeout;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -2297,7 +2323,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
  */
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
 			unsigned long ip, const char *w_fn, int sub_l,
-			bool sched_sleep, bool sched_map)
+			bool sched_sleep, bool sched_map, bool timeout)
 {
 	int e;
 
@@ -2320,7 +2346,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
@@ -2355,14 +2381,23 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
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
 
@@ -2371,21 +2406,30 @@ void dept_wait(struct dept_map *m, unsigned long w_f,
 
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
 
@@ -2434,6 +2478,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
 
 	dt->stage_w_fn = w_fn;
 	dt->stage_ip = ip;
+	dt->stage_timeout = timeout;
 	arch_spin_unlock(&dt->stage_lock);
 exit:
 	dept_exit_recursive(flags);
@@ -2447,6 +2492,7 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
+	dt->stage_timeout = false;
 }
 
 void dept_clean_stage(void)
@@ -2479,6 +2525,7 @@ void dept_request_event_wait_commit(void)
 	unsigned long ip;
 	const char *w_fn;
 	bool sched_map;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2505,12 +2552,13 @@ void dept_request_event_wait_commit(void)
 	w_fn = dt->stage_w_fn;
 	ip = dt->stage_ip;
 	sched_map = dt->stage_sched_map;
+	timeout = dt->stage_timeout;
 
 	wg = next_wgen();
 	WRITE_ONCE(dt->stage_m.wgen, wg);
 	arch_spin_unlock(&dt->stage_lock);
 
-	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
 exit:
 	dept_exit(flags);
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 195c11b92bcf..ec840c672846 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1394,6 +1394,16 @@ config DEPT
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


