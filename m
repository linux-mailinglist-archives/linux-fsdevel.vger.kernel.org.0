Return-Path: <linux-fsdevel+bounces-48858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA353AB51C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7963D4A64E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453EA27C158;
	Tue, 13 May 2025 10:08:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C126D4CA;
	Tue, 13 May 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130886; cv=none; b=KdbXPWe3x5t26pnK4mmd85CC6Cs0ve4kTTLrGYaeck4pbh6rSl160OjsR4ccPK/q9YVu1FgZWCF/eY7dwlIDlPdMeW2rgiypYgKklCnAwJj6z8mXJduRwz3n8PC0oZpNUhWaVulvqYc1tm4I99yhPQuscaErOrS94kss3hYQR2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130886; c=relaxed/simple;
	bh=LO9R/1OiSZjbabE34wPUvkoIfLujUBBhnvS1gS9s3lM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SPC+MKnl9Ht2ugmTmckxr+v2bqYPorz21/fZW5C75NI1DjOnvQupwATnLw1XHDjt4B6tK8M+VmE8fvrELuWakK7tgSrqyD7paqmXbBapJmjCpvoHVoRiy6qz4zfWmY12fkoUSPYYLQ9Ap/B5BcIEABj/3FWKktnYoJmwBGPObXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3c-682319f0bee8
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
Subject: [PATCH v15 24/43] dept: make dept able to work with an external wgen
Date: Tue, 13 May 2025 19:07:11 +0900
Message-Id: <20250513100730.12664-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfd9z+p5DR+GkEnYUF7ELMbqow1TyJDrDPhhOVBITtw9OE23k
	bK2WiuVSMdPQUYmrQBgLosilIBYClUsxETbqEEO5BagTsSDCwNsIN1NsN6S4FTa/PPnl/8/z
	e748LCV3StazGl2KqNeptAoipaWzweXb3qz7VP25rWw3eN9epqG43kbAVVeLwHbHiGGqIw6e
	+GYQLPUNUFBY4EJQPvGMgjvOMQSO6h8IPHoRAoPeeQLdBVcIZN6sJ/Bw2o9h9Go+hlp7PIxb
	X9HQm1eBoXCKwI3CTBwYf2JYtNYwYM2IgsnqIgb8E9HQPTYkAcfIZ3C9dJRAq6ObBmfzJIZH
	vxQTGLP9I4FeZxcNvtwIcP2UI4HbcxUEpn1WCqzeeQZ+b7NgcFrCocEUEGYtvJdAZ04bhqzK
	RgyDw78iuHf5Dwx22xCBB94ZDE32AgreVXUgmMydZeBS9iIDN4y5CK5cukqDaXQXLP0duFzy
	NhqMZQ003F4eQrFfCLZSGxIezMxTgqnJILzzPiaCw2ehhZ4KXmgpesYIpnsjjGCxpwpN1VuF
	m61TWCj3eCWCveZHItg9+Yxgnh3Ewlx/P3NowzfSPQmiVpMm6nfsPSFVL1iOJbXHnpt7uURn
	oBalGQWxPKfkp3uyyQc2jlvpFSbcZt7tXqRWOIyL5JtyXknMSMpS3NBH/JOSYWRGLLuWi+fv
	v1710FwUX9XpwSss42L4jLLl/50b+dqGtlVPUCBfrupf9cu5XXyepZZecfLcz0H8w/du9N/C
	Ov5+tZvOQzILWlOD5BpdWqJKo1VuV6frNOe2nzyTaEeB77Je8B9tRh7X4XbEsUgRLOua2qSW
	S1RpyemJ7YhnKUWYzHg3EMkSVOnnRf2Z4/pUrZjcjiJYWvGxbKfPkCDnvlOliKdFMUnUf2gx
	G7Q+A+luXRt53KgdPpu/P7vz6wil7Pu4jnJXZPFu/yfPvWf9fXAxZiIpdZ89lZO3hu/bJjVN
	9nXEXXt6aoYYgpvdf2UeyjvwWoXpLUdkvuPKyg17B6QxX2Xl9I62bukJrWfIRF3JwfAWMbay
	bqDI0/hlisHA3A0ZXzgR6jDHfPvbQrZJQSerVdFbKX2y6l/jpQvDWQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x05nv6XxoyWuNSaiTXw21rLZ+gnN2BhrdNOPu/WAu0qx
	tjvlKUqxnKe4wpXuKHeZQqSb45hE6UmiRhynrLo4PXBl/vnstfd7n9fnnw9L+JRSM1llUrKo
	SpInyGgJKYlenrnwx4xAxWKjRgauwaMkXCw30dBw04jAVKnF4HgcCS1DTgTDL14SoCtoQFDU
	9Y6ASlsngprSgzQ0fpwCTa4+GuwFx2nIvFJOw6tvIxg6zpzCYDSvg/eGHhKe5xVj0DlouKDL
	xJ7xBYPbUMaAQRME3aXnGRjpCgV7ZzMF1kI7BTXtwXDuUgcN92vsJNiqujE03r1IQ6fpDwXP
	bU9JGMr1g4b8HApu9BbT8G3IQIDB1cfA61o9Bpt+GlRkeayHB8YoeJJTi+Hw1VsYmtruIXhw
	9AMGs6mZBqvLicFiLiDgd8ljBN253xk4dMLNwAVtLoLjh86QkNURBsO/PJcLB0NBe7mChBuj
	zSgiXDBdMiHB6uwjhCzLPuG36w0t1AzpSeFZMS9Un3/HCFkP2hlBb04RLKXzhSv3HVgo6ndR
	grnsGC2Y+08xQvb3Jiz01tcz6/23SlbEiQnKVFG1KDxWohjQx+ypi0jr/TRMalD1kmzkxfLc
	El773kCOM83N5Vtb3cQ4+3KzeUtOD5WNJCzBNU/mWwrbUDZi2ancOv7R54ldkgviS57043GW
	ckt5zeVR+p8zgDdW1E54vDz5aEn9hN+HC+Pz9EYyD0n0aFIZ8lUmpSbKlQlhIep4RXqSMi1k
	x+5EM/L8jyFjJL8KDTZG1iGORTJv6VPHHIUPJU9VpyfWIZ4lZL5S7R1PJI2Tp+8XVbu3q1IS
	RHUd8mNJ2XRp1GYx1ofbJU8W40Vxj6j632LWa6YGHTCcDrd4fU2ztlUfGbRAFJ46/OjO7cqg
	kJiVPzUfwV2++tx196qRs30x88KqVkRleOuutWacdG6ZNXv6WHRrhsO6rGTNm4i9ge0BwWuT
	C1bt9AtyPuyI3rajRSpZ+nZX+Kz4ziqqJ3DDRvuCX3Fvv2z6fDDSv31At7xnS4pvkaLLFiAj
	1Qp56HxCpZb/BVRCAJE7AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

There is a case where the total map size of waits of a class is so large.
For instance, PG_locked is the case if every struct page embeds its
regular map for PG_locked.  The total size for the maps will be 'the #
of pages * sizeof(struct dept_map)', which is too big to accept.

Keep the minimum data in the case, timestamp called 'wgen', that dept
uses.  Make dept able to work with the wgen instead of whole regular map.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 18 ++++++++++++++----
 include/linux/dept_sdt.h |  6 +++---
 kernel/dependency/dept.c | 30 +++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 58362bd2c4ad..10536418ab41 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -371,6 +371,13 @@ struct dept_wait_hist {
 	unsigned int			ctxt_id;
 };
 
+/*
+ * for subsystems that requires compact use of memory e.g. struct page
+ */
+struct dept_ext_wgen {
+	unsigned int wgen;
+};
+
 extern void dept_on(void);
 extern void dept_off(void);
 extern void dept_init(void);
@@ -380,6 +387,7 @@ extern void dept_free_range(void *start, unsigned int sz);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
 extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
@@ -388,8 +396,8 @@ extern void dept_clean_stage(void);
 extern void dept_ttwu_stage_wait(struct task_struct *t, unsigned long ip);
 extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
 extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
-extern void dept_request_event(struct dept_map *m);
-extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn, struct dept_ext_wgen *ewg);
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
@@ -416,6 +424,7 @@ extern void dept_hardirqs_off(void);
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
@@ -428,6 +437,7 @@ struct dept_map { };
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
 #define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
@@ -436,8 +446,8 @@ struct dept_map { };
 #define dept_ttwu_stage_wait(t, ip)			do { } while (0)
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
index b92bc8c988c9..b7b0f358646f 100644
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
@@ -48,9 +48,9 @@
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
-#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__, NULL)
 #define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
-#define sdt_request_event(m)		dept_request_event(m)
+#define sdt_request_event(m)		dept_request_event(m, NULL)
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 75fe64f86ee5..27ca8f723ccc 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2171,6 +2171,11 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
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
@@ -2356,7 +2361,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 		unsigned long e_f, unsigned long ip, const char *e_fn,
-		bool sched_map)
+		bool sched_map, unsigned int wg)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2378,7 +2383,7 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c)
-		do_event(m, real_m, c, READ_ONCE(m->wgen), ip, e_fn);
+		do_event(m, real_m, c, wg, ip, e_fn);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2603,7 +2608,7 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map);
+	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
 exit:
 	dept_exit(flags);
 }
@@ -2782,10 +2787,11 @@ bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
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
@@ -2798,18 +2804,22 @@ void dept_request_event(struct dept_map *m)
 	 */
 	flags = dept_enter_recursive();
 
+	wg_p = ewg ? &ewg->wgen : &m->wgen;
+
 	wg = next_wgen();
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
@@ -2817,24 +2827,26 @@ void dept_event(struct dept_map *m, unsigned long e_f,
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
 
-	__dept_event(m, m, e_f, ip, e_fn, false);
+	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
 
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
-	WRITE_ONCE(m->wgen, 0U);
+	WRITE_ONCE(*wg_p, 0U);
 
 	dept_exit(flags);
 }
-- 
2.17.1


