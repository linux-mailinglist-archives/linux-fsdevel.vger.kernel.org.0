Return-Path: <linux-fsdevel+bounces-48875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3EAB526A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFD91B465CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0A293750;
	Tue, 13 May 2025 10:08:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE328B7EF;
	Tue, 13 May 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130897; cv=none; b=YggN7nFSnxsnZTXtW8G1bGn48mU+sWLjYdSwB+38aMdGdx3X1Qw+kGp3TqrmJ3dWm5YPKlT7yzoqFn0vGS25PBLpUgO2Cccva2McGSP2rKYZPOc3kL8uK1DwdFU+YyuCosuML0Gbj1gRJaU7aU1oJofsT+y13L8dsQDJzd+8tVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130897; c=relaxed/simple;
	bh=tQHWVNGGq5DZ2nAmsfnbBPxlhkvZFZVsn98qF7iS0Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Tm14gyLa69YXfiuDsEgSKpEpQJBVIYfsxwSc7+aONkii7pfyiBKRkAGx/87a9Wud8NCPBc1eXl9Qer3kS5CM1fHFd+Hy3QXT4I/UKAiuIoqXoYECm41gvaIcN1sLLgkU2Qj0YlmLsRFerP+23PVVHIo6RpN+t9v5kwk9Bg1sBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-4e-682319f31c84
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
Subject: [PATCH v15 41/43] dept: introduce event_site() to disable event tracking if it's recoverable
Date: Tue, 13 May 2025 19:07:28 +0900
Message-Id: <20250513100730.12664-42-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxjF97739t7bji6XzswXcbh1IUbmBxidz5JtIdkS3xk1S/bPpkZt
	7I1thKItIhiNVNCwMhjrVsn8wIK2NlCktGw6ZxFLrDAyhpMVqICCBodSSNA2ovhRuu2fJ7+c
	k3Oef47AqK7LFgh6Q75kNGhy1JyCVUSSapc9SnlPl1keToHo4zIWTja5Oeg534DA3WLGMH5t
	LfTFJhA8++NPBqptPQhqR4YYaAkOI/C7DnNw894b0Bud4qDTVs5ByZkmDm48nMUweMyKocG7
	AW47x1joqqrDUD3OwYnqEhw//2CYcdbz4CxOh1HXcR5mR7KgczgkA3/4ffipZpCDy/5OFoIX
	RzHcvHSSg2H3Sxl0BTtYiFWmQs/3FTJonKzj4GHMyYAzOsXDX212DEH7W+ApjRceffRCBtcr
	2jAcPduMoXfgNwStZXcweN0hDtqjExh8XhsDT89dQzBaGeHhyLczPJwwVyIoP3KMhdLB1fDs
	SfzzqcdZYD7tYaHxeQhlf0zdNW5E2yemGFrq20efRv/mqD9mZ+nvdYT+enyIp6WtYZ7avXup
	z5VBz1wex7R2Oiqj3vpvOOqdtvLUEunFdLK7m/9i4SbFR1opR18gGVd8sl2hC5dcYnffTSuM
	dJQxxchBLEgQiLiKdDVnW5A8gSNNIWaOOXEx6e+fSfA88R3iqxiTWZBCYMTQ66Tv1ACaM94U
	JfKi5UGCWTGdlHgciYBS/ICMBQ/z/5YuIg2etoQuj+vPz3Wzc6wSV5MqewM7V0rEH+TklsX6
	XyCFXHX1s1VIaUev1SOV3lCQq9HnrFquKzLoC5fvyMv1ovi8nAdnN19E0z1fBpAoIHWSsmP8
	XZ1KpikwFeUGEBEY9Tyl+UJcUmo1RfslY942494cyRRAqQKrnq9cGdunVYk7NfnSLknaLRn/
	d7EgX1CMFmZq021rDtXs+c7qup+2J3Nn2afrypsl7VL5CnPBorMrqx78yGccWk92eEN24kkO
	Ce6v/N2+sJWxrU3bNoRNmy98GIokK7NTJx0DlNmSbMG3HZ8bfmntWtKXH/Ql7Wrs2Bro/Xpd
	05NhW4Xis/af118ZK3w7sGmj1HzDkZdmPqBmTTpNVgZjNGleAQftGd9aAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRSH+9/XuZpcltjN6G1hRaFmaJwoovriJejFCgqll0vd2nDOsZVl
	IWhTMUsxQaUXbVlNczPXppSVZopLs8xyLR1qaWWtNEPdyprWNPpyeHh+nN/5ckS4tJwMEilU
	xwSNilfKKDEh3rZOFzI6d4l8Vd0oAe6xTAKuVJooaL9tRGCqSsXA1RQFbzyDCH4/f4FDYX47
	gmt9PThU2XoR1JadoaDjgz/Y3cMUtOSfo0B3vZKCl1+9GHQX5GFgtGyFt4YBAlpzSzAodFFw
	uVCH+cZnDMYN5TQYUoKhv+wSDd6+cGjpdZDQWNRCQq1zJVws7qbgYW0LAbZ7/Rh03L9CQa/p
	DwmttmYCPDnzoP1CNgkV30oo+Oox4GBwD9Pwql6PgU0fCOY0X2vG6CQJT7LrMci4cQcDe9cD
	BHWZ7zCwmBwUNLoHMbBa8nH4VdqEoD9niIb08+M0XE7NQXAuvYCAtO5I+P3Td7loLBxSr5oJ
	qJhwoI0bOFOxCXGNg8M4l2Y9wf1yv6a4Wo+e4J6WsFzNpR6aS6tz0pzecpyzlq3grj90Ydy1
	ETfJWcrPUpxlJI/msobsGPetrY3eMT9GvP6woFQkCpqwDQfFcqfuPqF+v+DkUHMmnoJuslnI
	T8QyEWxfpQOfYopZxnZ2jk9zALOItWYPkFlILMIZx0z2TVEXmgpmMwI7WfVlmgkmmNWZb04v
	SJg17IDtDP2vdCFrNNdPez+fnyhtI6ZYykSyuXojkYvEejSjHAUoVInxvEIZGaqNkyepFCdD
	DyXEW5DvgwzJ3gv30FhHVANiREg2S9LsWiyXknyiNim+AbEiXBYgSb3rU5LDfNIpQZNwQHNc
	KWgb0DwRIZsj2bJHOChljvLHhDhBUAua/ykm8gtKQXudF5VNMdGns6010tjlCUtCkPqI8a7p
	RVdYE7svPekRtqs6omc+b+oMq1mtWZQYFRhitxd4S9XS8Oi813G3tjz++OMZUT/HtRbt/LR/
	b8buyJrqQxtj/CNGNvc4k2Wb1GPf82M7mISz3qV89Z/hXUOqtYF9k9Fo+7pPwZZZE+lmGaGV
	8+ErcI2W/wtD0xxuPQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

With multi event sites for a single wait, dept allows to skip tracking
an event that is recoverable by other recover paths.

Introduce an API, event_site(), to skip tracking the event in the case.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 30 ++++++++++++++++++++++++++++++
 include/linux/sched.h    |  6 ++++++
 kernel/dependency/dept.c | 20 ++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index a97f34d62468..b2292587c1cc 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -492,6 +492,31 @@ extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_mark_event_site_used(void *start, void *end);
 
+extern void disable_event_track(void);
+extern void enable_event_track(void);
+
+#define event_site(es, evt_func, ...)					\
+do {									\
+	unsigned long _flags;						\
+	bool _disable;							\
+									\
+	local_irq_save(_flags);						\
+	dept_event_site_used(es);					\
+	/*								\
+	 * If !list_empty(&(es)->dept_head), the event site can be	\
+	 * recovered by others.  Do not track event dependency if so.	\
+	 */								\
+	_disable = !list_empty(&(es)->dep_head);			\
+	if (_disable)							\
+		disable_event_track();					\
+									\
+	evt_func(__VA_ARGS__);						\
+									\
+	if (_disable)							\
+		enable_event_track();					\
+	local_irq_restore(_flags);					\
+} while (0)
+
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
@@ -555,6 +580,11 @@ struct dept_event_site { };
 #define dept_task_exit(t)				do { } while (0)
 #define dept_free_range(s, sz)				do { } while (0)
 #define dept_mark_event_site_used(s, e)			do { } while (0)
+#define event_site(es, evt_func, ...)					\
+do {									\
+	(void)(es);							\
+	evt_func(__VA_ARGS__);						\
+} while (0)
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 43927e61921b..44a77b7116b7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -873,6 +873,11 @@ struct dept_task {
 	 */
 	int				missing_ecxt;
 
+	/*
+	 * not to track events
+	 */
+	int				disable_event_track_cnt;
+
 	/*
 	 * for tracking IRQ-enable state
 	 */
@@ -910,6 +915,7 @@ struct dept_task {
 	.stage_wait_stack = NULL,				\
 	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
 	.missing_ecxt = 0,					\
+	.disable_event_track_cnt = 0,				\
 	.hardirqs_enabled = false,				\
 	.softirqs_enabled = false,				\
 	.task_exit = false,					\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index bd46c2ce84eb..03d6c057cdc5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2585,6 +2585,23 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 	}
 }
 
+void disable_event_track(void)
+{
+	dept_task()->disable_event_track_cnt++;
+}
+EXPORT_SYMBOL_GPL(disable_event_track);
+
+void enable_event_track(void)
+{
+	dept_task()->disable_event_track_cnt--;
+}
+EXPORT_SYMBOL_GPL(enable_event_track);
+
+static bool event_track_disabled(void)
+{
+	return !!dept_task()->disable_event_track_cnt;
+}
+
 /*
  * Called between dept_enter() and dept_exit().
  */
@@ -2597,6 +2614,9 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	struct dept_key *k;
 	int e;
 
+	if (event_track_disabled())
+		return;
+
 	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
 
 	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
-- 
2.17.1


