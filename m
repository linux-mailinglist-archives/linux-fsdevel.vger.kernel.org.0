Return-Path: <linux-fsdevel+bounces-49377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1EEABB98F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D358A3BF83A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB78288531;
	Mon, 19 May 2025 09:19:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847B2820A9;
	Mon, 19 May 2025 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646348; cv=none; b=DZR7UlHSJp+ROEoGhs1mjIejmJ0oQ42w1eKM4VIuujS0xoc92Uty29KRdz1N+Oe4Ly+eBzhyRcgQM8WK0QcEkxUWagpKNDxq68RvBQ4m+ecGnXZJaA0/n4yocng5+ej3QRf0qDcHPhHfcBzne7Q/SyW8TvVIdHbJtumtVIbyykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646348; c=relaxed/simple;
	bh=314TpUAkZxMvbV2pk3wlciVKMbaC2tgJL1bvCZ48Y0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cyRSs2pwTg+85vKrHC+sL5YtCdWtBEbioQJRBrcBGJ0bY6gq/ZK6CATwiGVqR2LWgYJQOGRCyXh1Gcl6pMScbyrvfnufpLj3lc1ZAynZ0T1EnsX+hcMVEmTu/ehECMR9sCaM7sWOPrBoehAE/DTjQSj+cRmOxLB2DfMoHJNPznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-16-682af77048c5
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
Subject: [PATCH v16 37/42] completion, dept: introduce init_completion_dmap() API
Date: Mon, 19 May 2025 18:18:21 +0900
Message-Id: <20250519091826.19752-38-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe885O+dsOTmtsJNW1shKpYvR4ulKlw+90L0Iogs58tBGOm2a
	l0LQsjBNs4VKamtqLXEz11ah5cI0VxaZ6TITs5KyTM3QtvLSZXb58vDj9+f5P18elpQ5RL6s
	WhMjaDXKcDktoSR9XoXzDn8LUi1s++ADrq+pFBSUm2lovGZCYL6RTEB33Xp44e5FMPLkKQm5
	2Y0ICt++IuGGowOBveQ4Dc3vvMHp6qehPjudhhPF5TQ86xkloD1HR4DJugleG7soeJxVREBu
	Nw35uScIz/hIwJCxlAFjUgB0luQxMPo2BOo7WkRgbwuGC/p2Gqrs9RQ4KjoJaL5dQEOH+ZcI
	HjseUuDO9IPGcxkiKPtcREOP20iC0dXPQFO1gQCHwQcsKZ7CU4M/RfAgo5qAU5evE+B8eQfB
	3dQ3BFjNLTTUunoJsFmzSRi+WoegM7OPgZNnhhjIT85EkH4yh4KUdgWMfPdcvvg1BJIvWSgo
	+9GCVq/EZr0Z4drefhKn2OLwsOs5je1uA4UfFfG4Mu8Vg1PutjHYYD2CbSVBuLiqm8CFAy4R
	tpaeprF1QMfgtD4ngT83NDBbp+6WrAgTwtWxgnbBqlCJ6kp5Ph1lD4y/P5iFktCwfxoSszy3
	mB+4lkf9Z1NlqmiMaW4O39o6RI7xJG4Gb8vo8ngJS3It4/kXF1+isWAit43P0ek8yyxLcQF8
	j8lrTEu5Jfxt/Wn0t9OfN1mq//SIPb4tvfaPl3EK3mnS/7t7VszXVe36y1P4eyWtVBaSGtC4
	UiRTa2IjlOrwxfNVCRp1/PwDkRFW5PkuY+Longo00LijBnEskntJLfZAlUykjI1OiKhBPEvK
	J0lLbXNVMmmYMuGooI3crz0SLkTXID+Wkk+WLnLHhcm4g8oY4ZAgRAna/ynBin2TkP6sr8/2
	9lWD5yyB09+LM6bN3Fk9PX62aoJC8aFrKDDqVpN2JKBh3Vw/ZV7y0n365jlXavc/27O1c/yy
	pooy+FTMb8z1W375B716YqK3OtLZcNMeszlxb1Rc0d7Q4coNMWmInPWlUJO2pXXteTb9mDpI
	F/yNPMTjsHmHxcGhcaFVa+RUtEoZEkRqo5W/ARfZoblZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0zMcRzHfX//O85+O43fksVtSA014jOa5ZEv5t8jhs0dftzpOrc7RTbW
	VSylnKwa6Vx/nOqOzl2MuNY6ylXSP0U7oZlpRZYuSuFinnz23uu9vd5PPhwpq6BDOLX2hKjX
	KjVyRkJJtq9PW677HqGK8llXgX80g4LrVXYG2u7YENirjQQMPN0EPWNDCH4+f0FCQV4bguL3
	b0iobuhD4C5PZaDzw2zo8g8z4M3LYiCttIqB9sFJAnz5uQTYnNvgrfUjBc2mEgIKBhgoLEgj
	AucTAePWShasKYuhv/waC5Pvo8Hb102Dp8hLg7s3Eq6afQw8dnspaHjQT0BnzXUG+uy/aWhu
	eEbBWM58aLucTcPtLyUMDI5ZSbD6h1noqLMQ0GCZC470gPX8t180NGbXEXC+7C4BXa8fIajN
	eEeA097NgMc/RIDLmUfCxK2nCPpzPrNw7uI4C4XGHARZ5/IpSPfFwM8fgeWi0Wgw3nBQcHuq
	G8VtwHazHWHP0DCJ010n8YT/JYPdYxYKN5UI+OG1NyxOr+1lscWZiF3lEbj08QCBi0f8NHZW
	XmCwcySXxZmfuwj8pbWV3blgryT2sKhRJ4n6lRsUEtXNqkJG51526sk3E0pBE2GZKIgT+NWC
	7WEGPZ0Zfqnw6tU4OZ2D+YWCK/tjgEs4ku+eKfQUvUbTxRx+l5Cfm0tlIo6j+MXCoG3WNJby
	a4Qa8wX0zxkm2Bx1fz1BAd6b5fnLZXyM0GUzUyYksaAZlShYrU1KUKo1MSsM8apkrfrUikPH
	E5wo8EDWM5OXH6DRzk31iOeQfJbU4V6mktHKJENyQj0SOFIeLK10hatk0sPK5NOi/vgBfaJG
	NNSj+RwlnyfdsltUyPijyhNivCjqRP3/luCCQlJQ2b7SGphqrFiEOgbV65q3tmjDr2hE0XO2
	lPuti/TG3glODe+Ldigs8b4zvT0m3TrDCD958P69WNmxrwomairsSH5L56PGNOmc0EvhVR0f
	Nu4PzdLQSxJj98SZsGJXddOh2vaOirJ3+5ZEOs1iamjSji21xgN29ea9ce0hxpNr5ZRBpYyO
	IPUG5R/iiH4zPAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Currently, dept uses dept's map embedded in task_struct to track
dependencies related to wait_for_completion() and its family.  So it
doesn't need an explicit map basically.

However, for those who want to set the maps with customized class or
key, introduce a new API to use external maps.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 40 +++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 4d8fb1d95c0a..e50f7d9b4b97 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -27,17 +27,15 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map *dmap;
 };
 
-#define init_completion(x)				\
-do {							\
-	__init_completion(x);				\
-} while (0)
+#define init_completion(x) init_completion_dmap(x, NULL)
 
 /*
- * XXX: No use cases for now. Fill the body when needed.
+ * XXX: This usage using lockdep's map should be deprecated.
  */
-#define init_completion_map(x, m) init_completion(x)
+#define init_completion_map(x, m) init_completion_dmap(x, NULL)
 
 static inline void complete_acquire(struct completion *x, long timeout)
 {
@@ -48,8 +46,11 @@ static inline void complete_release(struct completion *x)
 }
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), .dmap = NULL, }
 
+/*
+ * XXX: This usage using lockdep's map should be deprecated.
+ */
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
 
@@ -90,15 +91,18 @@ static inline void complete_release(struct completion *x)
 #endif
 
 /**
- * __init_completion - Initialize a dynamically allocated completion
+ * init_completion_dmap - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
+ * @dmap:  pointer to external dept's map to be used as a separated map
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void init_completion_dmap(struct completion *x,
+		struct dept_map *dmap)
 {
 	x->done = 0;
+	x->dmap = dmap;
 	init_swait_queue_head(&x->wait);
 }
 
@@ -136,13 +140,13 @@ extern void complete_all(struct completion *);
 
 #define wait_for_completion(x)						\
 ({									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__wait_for_completion(x);					\
 	sdt_might_sleep_end();						\
 })
 #define wait_for_completion_io(x)					\
 ({									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__wait_for_completion_io(x);					\
 	sdt_might_sleep_end();						\
 })
@@ -150,7 +154,7 @@ extern void complete_all(struct completion *);
 ({									\
 	int __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__ret = __wait_for_completion_interruptible(x);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -159,7 +163,7 @@ extern void complete_all(struct completion *);
 ({									\
 	int __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__ret = __wait_for_completion_killable(x);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -168,7 +172,7 @@ extern void complete_all(struct completion *);
 ({									\
 	int __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__ret = __wait_for_completion_state(x, s);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -177,7 +181,7 @@ extern void complete_all(struct completion *);
 ({									\
 	unsigned long __ret;						\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_timeout(x, t);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -186,7 +190,7 @@ extern void complete_all(struct completion *);
 ({									\
 	unsigned long __ret;						\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_io_timeout(x, t);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -195,7 +199,7 @@ extern void complete_all(struct completion *);
 ({									\
 	long __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_interruptible_timeout(x, t);	\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -204,7 +208,7 @@ extern void complete_all(struct completion *);
 ({									\
 	long __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_killable_timeout(x, t);		\
 	sdt_might_sleep_end();						\
 	__ret;								\
-- 
2.17.1


