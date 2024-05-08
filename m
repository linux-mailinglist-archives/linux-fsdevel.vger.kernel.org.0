Return-Path: <linux-fsdevel+bounces-19068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C38BFA88
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F972817FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C889127B57;
	Wed,  8 May 2024 10:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FEA7E563;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162586; cv=none; b=rrPKyARsiK2b4ZvTZyX97dwZ/EyacFNMv3bckEzx9FvTr6/8jg8rkn5yAErhFA7Ilcl4l98HBmY2HloLxPHSojOp0lXOxEEEj0EHLDMgrNyWpy36u2Hu1DLJ0IN4DCaM0Uc9944HscNG8/dmHYzcQEpIv7h7yaZn8BsrgnAfeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162586; c=relaxed/simple;
	bh=DetjHz1GQxaPNALJ8Dks1FUieVl0UuRtCd7xVumYWkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QFGqxuFtip2eLzDQHSqs0AA4YzKqh9Ox67T9THvS72xCOIm0nqt45rGM57yN2+X1lFaocO9Dl6lZcFKf2CUjJUbtCpSkuXSGhVFattJYDfgdrbqqIvldOBH4iZW9K265emo1hcqaAr3VPVvdECNelbroNYRP65n2l5p68uUnydk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-17-663b4a3a9eab
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
Subject: [PATCH v14 16/28] dept: Track timeout waits separately with a new Kconfig
Date: Wed,  8 May 2024 18:47:13 +0900
Message-Id: <20240508094726.35754-17-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfT7fn92cfR3mKzPcEPIjljx+zj/4zmipP2x+dtM33fRrl0oa
	K52QatWWI82qa6fdHeUuRN25ShHJoSW3hGaSrrK4W6fIHfPPs9ee5/1+/fWwhOwO5c8q40+I
	qnhFrJyWkJKhqeUrN+7aFB2UqQ2GwtwgcP24QEJptZEG+y0DAmNtJoaBlp3wxu1EMP78BQGa
	YjuC8o/vCKht7UVgqTpLw+tP06DTNUJDW/ElGrK01TS8HJzA0HO5CIPBtAeeFVRgsHn6SdAM
	0HBNk4W94wsGj07PgC5jMfRVlTAw8XENtPV2UWBxBMLV6z00NFjaSGit68Pw+kEpDb3GSQqe
	tT4hwV6YR8HN4QoaBt06AnSuEQZe2cow1Ki9ouzvvyl4nGfDkF15G0Pn23oE1gsfMJiMXTQ0
	u5wYzKZiAn7eaEHQlz/EwLlcDwPXMvMRXDp3mQR1zzoYHyult20Qmp0jhKA2pwoWdxkpPK3g
	hfsl7xhBbXUwQpkpWTBXLRe0DQNYKB91UYJJf5EWTKNFjJAz1ImF4Y4ORnhyZZwUPnVqcJj/
	fsnmKDFWmSKqVm+NlMS4rZN04pfIk9+M18kMdGd3DvJjeS6Yr/RkU/+5XtuOfUxzAXx3t4fw
	8UxuAW/O+/w3Q3BOCV/ZscPHM7hw/p6mmvExyS3mrzzMp30s5UL4R79t5D/nfN5QY/vr8fPu
	3/YPIx/LuHV8fVaJtyvxZiZZvne8iPlXmMM3VnWTBUhahqbokUwZnxKnUMYGr4pJi1eeXHU0
	Ic6EvM+kOz1xoA6N2iOaEMci+VSpbfbGaBmlSElKi2tCPEvIZ0pbzq+PlkmjFGmnRFXCEVVy
	rJjUhOaypHy2dK07NUrGHVOcEI+LYqKo+n/FrJ9/BjrkHHM7agKCAqxFC/cksEsNPzJ+Kbcn
	BNVqH6u4aTunh+U+eJ/e+D6zsLh9mXlvqNs8+DJw3uEztcbbHpWaPxDWfD99W2iB3eFYErhF
	X3escFG7dcWy3aFdQCobD9fcHWI/J0bUpaeunV4xIyfka9jg6vDkxoX2W7PG9i151XKQssjJ
	pBjFmuWEKknxBxNNdjZIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSf0yMcRzAcd/v8zzf5zrOnp3wKBs7M1t+dDbxmQx/+PHMr1kbxvzowZNu
	KtypnM304yL6sTJ1SSWVkzrKkybqcitFIlELLU3NqOnKr7s55eiYfz577fPZ3n99FJTazPgp
	dFHHJX2UGKEhSlq5JThx4fINwWHaK13+kJmqBef3ZBryKqwE2m+VI7Deiccw2LQeXrmGEIw+
	e06BOasdwdW+txTcae5FYCtNINDxfjJ0OkcItGSlEEgsriDw4tMYhp7sCxjK5c3QmlGEwe7+
	SIN5kMBlcyIeHwMY3JYyFixxc6G/NJeFsb7F0NLbxUBjfgsDtu75cKmgh0CdrYWG5pp+DB33
	8wj0Wn8z0Nr8mIb2zDQGbg4XEfjkslBgcY6w8NJeiKHSNF47883DwKM0O4YzJbcxdL6pRVCf
	/A6DbO0i0OgcwlAlZ1Hw83oTgv50BwtJqW4WLsenI0hJyqbB1BMEoz/yyOrlQuPQCCWYqmIF
	m6uQFp4U8cK93LesYKrvZoVCOVqoKg0QiusGsXD1q5MR5LJzRJC/XmCF845OLAy3tbHC45xR
	WnjfacZb/XcpVxyUInQxkj5wZagy3FX/mxwdCD3x2VpAx6HqTeeRj4LnlvC1xU+x14Sbx79+
	7aa89uVm81VpHxivKW5IyZe0rfN6ChfC3zVXsF7T3Fw+50E68VrFLeUfeuz0v+YsvrzS/rfj
	M75/83EYea3mgvjaxFw2AykL0YQy5KuLiokUdRFBiwyHw41RuhOLDhyJlNH4u1hOjWXWoO8d
	6xsQp0CaSap2EhymZsQYgzGyAfEKSuOrajq7LEytOigaT0r6I/v00RGSoQH5K2jNdNWGHVKo
	mjskHpcOS9JRSf//ihU+fnGocqczMPj5phuTj0UbOx6xp5NSVyWIA5zCZY2d6OHmeaDVsaY6
	P5md7bd62vZtM38t6NfvN3nkgpeBedrbV3aLdeHTr/tWf8lAci29a052QMmeqbo9TfeSYx/k
	ULa163KqHQuDcJ8jHtXsvHYxZG9CyIx33WWhRrfRR5ui2qhdoaEN4eLiAEpvEP8AEjmoSioD
	AAA=
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
index 2c0f30646652..5c996f11abd5 100644
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
@@ -1582,7 +1606,8 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 static atomic_t wgen = ATOMIC_INIT(1);
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep)
+		     const char *w_fn, int sub_l, bool sched_sleep,
+		     bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1602,6 +1627,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
+	w->timeout = timeout;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -2313,7 +2339,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
  */
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
 			unsigned long ip, const char *w_fn, int sub_l,
-			bool sched_sleep, bool sched_map)
+			bool sched_sleep, bool sched_map, bool timeout)
 {
 	int e;
 
@@ -2336,7 +2362,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
@@ -2373,14 +2399,23 @@ static void __dept_event(struct dept_map *m, unsigned long e_f,
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
 
@@ -2389,21 +2424,30 @@ void dept_wait(struct dept_map *m, unsigned long w_f,
 
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
 
@@ -2449,6 +2493,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
 
 	dt->stage_w_fn = w_fn;
 	dt->stage_ip = ip;
+	dt->stage_timeout = timeout;
 exit:
 	dept_exit_recursive(flags);
 }
@@ -2460,6 +2505,7 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
+	dt->stage_timeout = false;
 }
 
 void dept_clean_stage(void)
@@ -2490,6 +2536,7 @@ void dept_request_event_wait_commit(void)
 	unsigned long ip;
 	const char *w_fn;
 	bool sched_map;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2512,6 +2559,7 @@ void dept_request_event_wait_commit(void)
 	w_fn = dt->stage_w_fn;
 	ip = dt->stage_ip;
 	sched_map = dt->stage_sched_map;
+	timeout = dt->stage_timeout;
 
 	/*
 	 * Avoid zero wgen.
@@ -2519,7 +2567,7 @@ void dept_request_event_wait_commit(void)
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 	WRITE_ONCE(dt->stage_m.wgen, wg);
 
-	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
 exit:
 	dept_exit(flags);
 }
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d366acacffec..b0351667a771 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1319,6 +1319,16 @@ config DEPT
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


