Return-Path: <linux-fsdevel+bounces-48854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7331AB51D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ABA9825A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DCE27703A;
	Tue, 13 May 2025 10:08:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9227024BD02;
	Tue, 13 May 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130883; cv=none; b=EYE4C0Z5xY5sLKk3MZyie4v0jueOSGeR0Pivvvyv6MEenDQjmatGraw/xy/Vuwxlsn7VTKBY1FunA3CCW4bEN/PfEvg9slAgZaBbfsvxfFofc1QlDlzjs2ELb127OYlLr2j3oOY/lafAC9UI/LVRFuvErLJ53ujhQMzMfXzFDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130883; c=relaxed/simple;
	bh=tLuuN6RyLYtBAfkN4cOg2ymc7qjSoDifZjv2z6JCU54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lwjpMge0AitUrenOTEFQolgoTlMxEWFk2Ab6d/M4M5iUWvZxMSyMsp/h4fTF0D9bpd4DssMAEBeuKI9kWsMwF3J9MRVpE8WgUGy1w9X9QA9bM4qWtDaRnCTFzpb77Py1mfxvnHipXdx8vOh2f5A2SrI9OFg8NdKhX50b7ZHyakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-dc-682319ef9228
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
Subject: [PATCH v15 18/43] dept: track timeout waits separately with a new Kconfig
Date: Tue, 13 May 2025 19:07:05 +0900
Message-Id: <20250513100730.12664-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfZ73SqXmTXX6KiZsdV7CMhVvO5l4yb7sSYzGbPs0WGYjb9ZO
	QFMErbfQUYhyE9iwXlALuNq0ZbJCBDdLWAmlqCAKVmqwQmNQFOiCtFsRL63GLye//P45//Pl
	8JTCwyziNVn7JW2WKkPJymjZeHzt5/8uXKJe/Sw8G0JTx2movmJnofcPGwJ7kx7DaMfXcD88
	huBl920KjFW9CGqGH1LQ5PYjcFp+YaHv8RzoDwVZ6KoqZiG/7goLd57PYBg8VYnB5tgOj8wj
	NNwsr8VgHGXhnDEfR8dTDBGzlQNz3lIIWM5yMDOcDF1+LwPOB5/BmQuDLFx3dtHgbglg6Pur
	mgW//Q0DN90eGsJlCdBbUcpA/UQtC8/DZgrMoSAHd9tMGNym+dBgiBYWvnjNQGdpG4bCS39i
	6Pf9jaD1+BAGh93LQntoDEOjo4qC6csdCAJl4xwUlEQ4OKcvQ1BccIoGw+B6ePl/9PL5qWTQ
	X2ygof6VF23dROwX7Ii0jwUpYmg8QKZD91jiDJtocqNWJNfOPuSIofUBR0yOHNJoSSJ110cx
	qZkMMcRhPcESx2QlR4rG+zGZ6Onhdi7+XpaSLmVociXtqs27ZOpKwwtuX/Hug15fJ85DnTuK
	UBwvCuvE4F0r+4E9VeNMjFlhuTgwEKFiPE/4WGwsHYl6GU8J3tni/fM+FAvmCt+Izd1tXIxp
	YanoHDHiGMuFDWKfzUO/L00UbQ1t74riov7V5Z53XiGsF8tNNjpWKgon48Si4SHm/cJC8R/L
	AF2O5CY0y4oUmqzcTJUmY91KtS5Lc3Dl7r2ZDhT9L/PRmdQWNNn7rQsJPFLGyz2jn6gVjCo3
	W5fpQiJPKefJ9c1RJU9X6Q5J2r0/anMypGwXSuBp5QL5mvCBdIXwk2q/tEeS9knaDynm4xbl
	IdvmYGDImaOom55a+2n94ZIjE4n9l5ZVJ3xZ4db+umVb3Re3LGlp259ohY6vrs7kNf+255FU
	2Gr06Qq+07Tf+GFb2o5u/kkkdNrfaanYmu/+qCS+wapekeK787NaH0ipUR4Lp7YkDm1Mcq2W
	i03E9d+9tdObri339y0rH7Cm/h7RPVPS2WpVchKlzVa9Bf6O3gdbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRiGe9/vNFerD5P6Mjot7GBYGRkPFdKf6KVIOvyIgsiRH215iq08
	RIHmKss0M5bkoabGkm2mbUZmLmyWujyWNjXU0lI0tUG5oWWHrejPw8V1w33/eSSUv5EJlKji
	TovqOEWMnJXS0ohtaSGuRSuVG7ObN4J7Mp2GgnIzC+0PTAjMlakYRl/ugi7POIIfLW0U5Ora
	ERQN9FFQWd+PwFZ6gYWOT3Oh0+1iwaHLYCGtpJyF12MzGHpv5WAwWfbCe8MwDU3ZxRhyR1nI
	z03D3jOCYdpg5MCQEgSDpXkczAyEgqPfyUBdoYMB27t1cPtOLws1NgcN9VWDGDqqC1joN/9m
	oKm+kQZP1mJov5HJQNmXYhbGPAYKDG4XB29q9Rjq9QugQuttvfTtFwMNmbUYLt17iKGz5ymC
	Z+kfMFjMThbq3OMYrBYdBd/vv0QwmDXBwcVr0xzkp2YhyLh4iwZtbxj8mPIuF06GQurdChrK
	fjrRjnBivmNGpG7cRRGtNZF8d79lic2jp8mrYoE8yevjiPbZO47oLWeItTSYlNSMYlL01c0Q
	i/EKSyxfczhydaITky+trdy+JUek26PEGFWCqN4QHilV5mi/cacyjic5expwCmqIuIr8JAK/
	WWjUTTA+ZvnVQnf3NOXjAH65YM0c9nqphOKds4Wuwh7kC+bzB4THLbWcj2k+SLAN52Ify/gt
	Qoepkf5XukwwVdT+LfLz+p/3W/96fz5MyNab6Gwk1aNZRhSgikuIVahiwtZropXJcaqk9cfj
	Yy3I+0GG8zM3qtBkxy474iVIPkfWOLpC6c8oEjTJsXYkSCh5gCz1sVfJohTJZ0V1/DH1mRhR
	Y0eLJbR8oWz3ITHSnz+hOC1Gi+IpUf0/xRK/wBQkbB3PsxU8H9pvL8b2nWMRawNl027SP1az
	9jxa5Vqmkvek4cSgremZctPsvirZwYEpm8Nx+XB41s3gy+iccaptFtu86rPnYH71o0QqiSm/
	3hVi361cOsJb0YbuNyc/Hr1btie87P0chS5eOhTw1DHvxb5H+eWri9bQyxdd2KRZIqc1SkVo
	MKXWKP4AYsnRDT0DAAA=
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
index 138106869494..58362bd2c4ad 100644
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
@@ -376,8 +381,8 @@ extern void dept_free_range(void *start, unsigned int sz);
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
@@ -424,8 +429,8 @@ struct dept_map { };
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
index 93d772c71905..b92bc8c988c9 100644
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
@@ -37,13 +38,13 @@
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
@@ -53,7 +54,9 @@
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
index 211bafffc980..75fe64f86ee5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -756,6 +756,8 @@ static void print_diagram(struct dept_dep *d)
 	if (!irqf) {
 		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
 		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		if (w->timeout)
+			print_spc(spc, "--------------- >8 timeout ---------------\n");
 		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
 	}
 }
@@ -809,6 +811,24 @@ static void print_dep(struct dept_dep *d)
 
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
@@ -831,10 +851,14 @@ static void print_circle(struct dept_class *c)
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
@@ -1578,7 +1602,8 @@ static int next_wgen(void)
 }
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep)
+		     const char *w_fn, int sub_l, bool sched_sleep,
+		     bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1598,6 +1623,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
+	w->timeout = timeout;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -2298,7 +2324,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
  */
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
 			unsigned long ip, const char *w_fn, int sub_l,
-			bool sched_sleep, bool sched_map)
+			bool sched_sleep, bool sched_map, bool timeout)
 {
 	int e;
 
@@ -2321,7 +2347,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
@@ -2356,14 +2382,23 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
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
 
@@ -2372,21 +2407,30 @@ void dept_wait(struct dept_map *m, unsigned long w_f,
 
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
 
@@ -2435,6 +2479,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
 
 	dt->stage_w_fn = w_fn;
 	dt->stage_ip = ip;
+	dt->stage_timeout = timeout;
 	arch_spin_unlock(&dt->stage_lock);
 exit:
 	dept_exit_recursive(flags);
@@ -2448,6 +2493,7 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
+	dt->stage_timeout = false;
 }
 
 void dept_clean_stage(void)
@@ -2480,6 +2526,7 @@ void dept_request_event_wait_commit(void)
 	unsigned long ip;
 	const char *w_fn;
 	bool sched_map;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2506,12 +2553,13 @@ void dept_request_event_wait_commit(void)
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
index a626631f6bec..7c74f92e4cc2 100644
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


