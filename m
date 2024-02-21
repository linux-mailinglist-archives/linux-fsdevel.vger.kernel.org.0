Return-Path: <linux-fsdevel+bounces-12239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7360B85D4A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA311F209A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17644DA03;
	Wed, 21 Feb 2024 09:50:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE85845C0C;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509004; cv=none; b=CemIBb5F1cuIk3l43vvl+KBGd+bBS2OnU/MgZSHPUOqxZ+YAoxjlqyc3W+yABWi7WBT5yOup5NLS39uUjmwaioRvGqyeB5aW4YTRg1uNT0Fk5ZVbYsqZuiEe6H/YkBToqbShpoq3ja3U52O+bf7ULgwEc0ogZb7KCVMrf7AXv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509004; c=relaxed/simple;
	bh=LIy0pGzgh1KfCx3V9I4vVrDFzUkgQh3CEYezt1V8iYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e2xIYjDdONc4uzKs5CGjNM3N7MM51TS3KPKY7MNWSa46BaupJ2eW7EyAfExIU03zACHgIeQe7rpAt0wgIWFMOAL84MnefMht9xqRC5d83xoP8gLLBgwzTfbvIgEPlIABeUB+sQ6ekU+dchAsCSSgjDMbVGzSiLx/i7COSOs78pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-88-65d5c73aa802
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
Subject: [PATCH v12 16/27] dept: Track timeout waits separately with a new Kconfig
Date: Wed, 21 Feb 2024 18:49:22 +0900
Message-Id: <20240221094933.36348-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PXZ39djI/GdptMZqklX0Wmc3wI20eNn+w4dRvOupqd+nB
	SClKyVSri2u5i86pKHceS62rVWLl0pWkB7U8pKuIa1Lkjvnns9fe78/n9deHwSVPSA9GrogR
	lApZhJQSEaIxN92awOZOwfdzlRdkX/IF+/d0Agoryimw3C1DUH4/GYORxu3wesqGYKb1JQ7q
	PAsC3WAfDveb+hHUGM5R0DE8H6z2CQpa8jIpSLlRQUH76CwGvfk5GJQZQ+DFlWIM6qY/EqAe
	oUCjTsEc4xMG0/pSGvRJXjBkuEbD7OA6aOnvIqGmxxuuFvVS8LSmhYCmx0MYdFQVUtBfPkfC
	i6ZnBFiys0i4M15MweiUHge9fYKGV3VaDCpTHaIL336T0JxVh8GFm/cwsL6pRlCb/g4DY3kX
	BQ12GwYmYx4OP281Ihi6PEbD+UvTNGiSLyPIPJ9PwMtfzSSk9gbAzI9CanMg32CbwPlUUxxf
	M6Ul+OfFHP/kWh/Np9b20LzWeJI3GVbzN56OYLxu0k7yxtKLFG+czKH5jDErxo+3tdH8s4IZ
	gh+2qrHdSw6INoYJEfJYQbl20xFReOOoiYr+dCRePcIkoQe7MpALw7H+XO7sZ/o/69W//zLF
	ruS6u6dxJ7uznpwp6wOZgUQMzqa5coYvrZSzWMDu5R6WfEVOJlgvTjuQ61hiGDG7nntbvfef
	czlXVln31+PiiG9rbKSTJWwA19n+AHc6OTbNhTNfLyH/HSzmzIZu4goSa9G8UiSRK2IjZfII
	f5/wBIU83ic0KtKIHA+lPzN78DGatOyrRyyDpG7i8EdWQULKYlUJkfWIY3Cpu5iIc0TiMFnC
	KUEZdVh5MkJQ1aMlDCFdJPabiguTsMdkMcIJQYgWlP9bjHHxSEJeGzwPZMTgX2o95mceCmXu
	Bfvd+TlawMJ+v2Dd9rjOoB89UfFL17BRO2+bG5uSh+ZslhyzYYVmLlEhL/LsC9qyQ1FveT94
	tkLnvXZbSFlvWtuH+NMlJnuKeRWjMa36mDKwLPBotmstaXFvzW1bmPj1u6r0+Os9N7M8CePW
	Tem33KSEKly2bjWuVMn+AKGT6FJMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/P83yfp+Ps2dXmWdeGm8ay8mPiM2GM8czyY/nD5sd09NCt
	69idUsaUQkoIdbhwwjl1JXdFqbPUKvlV6cqPfqAZWpEfXZMSd8w/n732fr/3+uvDUQoT489p
	dLslvU6tVREZLVsdlhI8v75Vmll2Vg5Zx2aCeyCNhtybNgJNRQUIbCXJGHpqV8DzwT4Ew08a
	KTBmNyG4/LaTgpK6LgRO60ECLe/Gg8vdT6AhO4NAypWbBJp7RzB05JzCUGBfBY9O5mGoGvpA
	g7GHgMmYgj3nI4YhSz4LlqRA6LaeZ2Hk7Sxo6GpjoOZCAwPOV9Ph3MUOApXOBhrqyroxtNzN
	JdBl+83Ao7oHNDRlZTJQ+DmPQO+ghQKLu5+FZ1VmDMWpHtvh76MM1GdWYTh89RYG18sKBPfS
	3mCw29oI1Lj7MDjs2RT8vF6LoPv4JxYOHRtiwZR8HEHGoRwaGn/VM5DaEQrDP3LJ4jCxpq+f
	ElMde0TnoJkWH+YJYvn5TlZMvfeKFc32ONFhDRKvVPZg8fI3NyPa848S0f7tFCumf3Jh8fPT
	p6z44OwwLb5zGfHagA2yBVGSVhMv6WcsipRF1/Y6yK6PkQnGHi4JlYanIx9O4OcIFuMo62XC
	TxVevBiivOzHTxIcme+ZdCTjKP7IWMH65QnxFr58hHD72lfkZZoPFMyvT3tGHCfn5wrtFRH/
	nBOFguKqvx4fT3zD1Md4WcGHCq3NpdRJJDOjMfnIT6OLj1VrtKEhhpjoRJ0mIWTbzlg78ryM
	Zf9IVhkaaFlRjXgOqcbJo++4JAWjjjckxlYjgaNUfnJ6jyeSR6kT90r6nVv0cVrJUI2UHK2a
	IF+5XopU8DvUu6UYSdol6f+3mPPxT0JBZyTby7WGon3hG5ltAckV98eZfQ809k7J22xVNH+4
	yoaHOEuLNJvLlwS0LaUy1kyvKRiJC99u9jtXaWLbC8/cvaR8fOdZzhzfeZtkMKojeNVjFVZm
	K2OUR1PSll0r1gaOnVZe/jD2xPbKiK07/PNdEycvms0tXx68buEYi2/rwGwVbYhWzwqi9Ab1
	H6pm6TUuAwAA
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


