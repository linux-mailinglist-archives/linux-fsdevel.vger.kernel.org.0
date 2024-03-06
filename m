Return-Path: <linux-fsdevel+bounces-13720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D430A8731F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A31F21986
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00AE6F525;
	Wed,  6 Mar 2024 08:55:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE73651AE;
	Wed,  6 Mar 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715351; cv=none; b=i56enNiM2f2+P/XVvs8gu+XI2hGXxqCB1rk/Zm65IkAZ9HcggZS1dSszrrxdh7t221dpeHcXRD09ckB1QAVPUJ+fltwOxNJ/t8ke07d2Jq+/C4zmXptcAU9+V3T2YrvEWgqejjRduQKAh+f/VyLOo73/iXIKvSciQfGqqfh9R5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715351; c=relaxed/simple;
	bh=Zg3dPmxAeZfdPCpe0eFW6kAfwZet+/NUlIS50hmLxGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dnbg2ZHmel5f68OUa1sYXotktR+yPXCylc7QkpHqAl8k8pkhCFuqavNiXWnaGPHhJeR0rNIBXaB1HlN9jw6882WK5OKc4gx87WMMuTB4H5V2qcyElJHRmJajC/KnR6js+Y70SfM9jzH6JOqNfhm/ZlojcLGug+QS/0syvzLa7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-9a-65e82f7f922e
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
Subject: [PATCH v13 23/27] dept: Make Dept able to work with an external wgen
Date: Wed,  6 Mar 2024 17:55:09 +0900
Message-Id: <20240306085513.41482-24-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUiTaxgH8O77eXW5eFrGebKiGkSHDplJ6hVESVDdEEUUfbGido4PbRxd
	Madmr5bLaqapoetFSletpTtpc4dTp+Yxw5WZtso6Zmolkg7nBG3Lpb1sRV8uflwv/08XTyn+
	ZqJ5jVYv6bSqVCUro2VDkeZFhxcPSLGuslgoPhUL/g8naCivsbHgvlGNwOY4gsHTtBb+D3gR
	jLc+ocBU6kZQ+a6bAoerB4HTepSF531ToN0/zEJzaT4LuZdrWHg6OIGhq6wEQ7V9PbQUmTE0
	BPtpMHlYuGDKxaEygCFoqeLAkjMfeq3nOZh4twSae14y4Oz8Dc5d7GLhrrOZBtetXgzP/y1n
	ocf2lYEW10Ma3MUFDPzlM7MwGLBQYPEPc/CsoQJDrSEUlDf6hYEHBQ0Y8q7cxND+6g6C+hNv
	MdhtL1m47/diqLOXUvDpWhOC3sIhDo6dCnJw4UghgvxjZTQYuuJhfKycTVpG7nuHKWKoyyLO
	QAVNHplFcvt8N0cM9Z0cqbBnkDrrQnL5rgeTyhE/Q+xVJ1liHynhiHGoHRNfWxtHHp4dp0lf
	uwlvjE6WLU+RUjWZkm7xip0ytWPgBbXHuHKvo+g6lYO8cUYUwYvCUnHM8Bn/tL3/Nhc2KywQ
	OzqCVNhRwlyxruA9EzYleGXilbY1YU8T1otNwePf92lhvnjm8T902HIhQXR2VjM/MueI1bUN
	33MiQv3TvtNs2AohXmzNrQxZFtoZ48WnXUbqx8EM8Z61gy5C8go0qQopNNrMNJUmdWmMOlur
	2Rvzx+40Owo9k+XgxNZbaMS9uREJPFJGypMi+iUFo8pMz05rRCJPKaPkBz71SQp5iip7n6Tb
	vUOXkSqlN6KZPK38RR4XyEpRCLtUeulPSdoj6X5OMR8RnYOSc4v+u+rN02fzm0Y33LwmLHOo
	hzOmv1/ncTviR1bsPLSq0rbNZ9QWxPzuUX9c3Zr1q8zsSvQNNtou3ggkKgrJVEP968w78aML
	kvKTZick1h7aOv0Ns2VecbewMfmAPnHy1JIPLbN8HyOf1FxKeBA3KU+vf7Y90G9dO08ftX+a
	3kSUdLpatWQhpUtXfQPnzjBMSAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0iTYRQH8J7nvc3V4m0JvWWQDCzo4qUyDt0/5VNg2ZeEPpQzX3I0Z2yl
	GUWmy0yztJpTs/LGMme3d4MynY2Zll1M00pNLUVScSlUk9akckVfDj/O//D/dGSU0swskml0
	R0S9Tq1VsXJavnND5qpTYaNieE9/IBScDwfP92waSu/WstB+x4qg1n4aw1hzFLyfciPwvXpN
	gdnUjqB8sJ8Ce8sAAkd1Bgudw3OhyzPJQqspl4XMyrssdIxPY+grvITBKkXDi/wKDE7vCA3m
	MRaumjPxzBjF4LXUcGBJD4Gh6hIOpgcjoHXgHQNN11oZcPSugOLrfSw0OFppaHk4hKHzUSkL
	A7W/GXjR8oyG9oI8Bm5PVLAwPmWhwOKZ5OCNswzDPeNMW9a3Xww8zXNiyKq6j6Grpx5BY/Yn
	DFLtOxaaPG4MNslEwc+bzQiGLnzh4Mx5LwdXT19AkHumkAZjXyT4fpSyW9eTJvckRYy2VOKY
	KqPJ8wqB1JX0c8TY2MuRMukosVUvJ5UNY5iUf/UwRKo5xxLp6yWO5HzpwmSirY0jz4p8NBnu
	MuOYoL3yjQmiVpMi6sM2x8kT7aNvqcM5W47Z829R6ci9OgcFyAR+rSCN1HF+s/wyobvbS/kd
	yAcLtrzPjN8U75YLVW3b/J7PRwvN3rN/72k+RLj88gHtt4JfJzh6rcy/ziWC9Z7zb0/AzP7i
	xEXWbyUfKbzKLGfzkbwMzapBgRpdSpJao40MNRxKTNNpjoUeSE6S0My7WE5OFzxE3zujXIiX
	IdUcxdaAEVHJqFMMaUkuJMgoVaDixM9hUalIUKcdF/XJ+/VHtaLBhYJktGqBYkesGKfkD6qP
	iIdE8bCo/59iWcCidBSyMvFWzHHjqfg18bkCLnFZi/YNNmm5KxkdcXOC19z4ZcrSp1Ul58Ym
	3aw22z6ERsQWKsNXxJhuj0vbNAnu6E17dvLEt/rgvCsPOsK2Pym5tvhjvWtg3+zdPkVxccrS
	4Pye1PWPM87pzjo3bhpcFTS+wz5WV1Rq139qjA/PXtgftUtFGxLVEcspvUH9B2NIzsIqAwAA
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


