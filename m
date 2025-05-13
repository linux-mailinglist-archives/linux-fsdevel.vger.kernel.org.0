Return-Path: <linux-fsdevel+bounces-48872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E3AB5245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE13716B7C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D328E581;
	Tue, 13 May 2025 10:08:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B6928B7EA;
	Tue, 13 May 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130896; cv=none; b=lWYWPM5piMVNXJiLekfmachphGYQ8MX6mPymLDoxKJq8aJMGyySPkpizdljnqOyQOY6H/JmxDCZvL4uXl6KCeV9h5OVzsNDe7mouQx31GSXn1v66EgxWbktF8Zyx16ciEElnQnbADsohuoL/R8ijr4c4MTzZs8Zp3CAkDijCkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130896; c=relaxed/simple;
	bh=314TpUAkZxMvbV2pk3wlciVKMbaC2tgJL1bvCZ48Y0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BeRSUqCWqQUSBXFtSdWvjiPewnGbMz0MLeAdoEdJk8PdLxSyysstM2X4uOjHdVP/PV4FJTQB0pvwwMIcBEBGTBrroB0JwdlPCCnN+qPiOLOst4yT0efEfNhInBi5tcu1WDkDUU4mH7X9y5aDYbf1glhS375EcRFc8DON42sspx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-1e-682319f26b45
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
Subject: [PATCH v15 38/43] completion, dept: introduce init_completion_dmap() API
Date: Tue, 13 May 2025 19:07:25 +0900
Message-Id: <20250513100730.12664-39-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRiH+59zds5xuTjMqKMF1souRpbdeIluHwIPhKB0+VBRrTy00Vyx
	mWkQzZpm2sQUk9RqzpyXzbQZZJctc7m00FbZNDNLqWjlJaZb6eyyFX15efj9eJ/3y0vj4lZB
	BC1XpvAqpVQhIYWEcDi0fPlY+ALZSvtm8I5nE1BWbybBecOEwHwrAwN3axx0+4YQ+Due4VBc
	5ERQPvAWh1uOfgTW6jMkvPwwA7q8oyS0F+WScLainoTnX6cw6LtUgIHJEg/vjJ8IeJpvwKDY
	TUJp8VksMD5jMGGspcCoiYLB6hIKpgZiob3fJQBr7zK4fLWPhPvWdgIcTYMYvLxbRkK/+bcA
	njraCPDlzQHnRZ0A6kYMJHz1GXEwekcpeNGsx8ChnwUN2oAwa+yXAB7rmjHIun4Tg67X9xDY
	st9jYDG7SLB7hzBotBThMFnVimAwb5iCzAsTFJRm5CHIzbxEgLZvLfh/BC5fGY+FjGsNBNT9
	dKEtGznzVTPi7EOjOKdtPMFNel+RnNWnJ7gnBpa7U/KW4rS2XorTW45zjdXRXMV9N8aVe7wC
	zlJ7nuQsngKKyxnuwriRzk4qYe5u4YYkXiFP5VUrNh0QyirrS8lj1qVpj8bykQZNRuagEJpl
	1rD2mxUoB9F/ebxnfTAmmcVsT88EHuSZzDy2UfdJkIOENM64prPdV16jYBHGJLLtlVNUkAkm
	ir1m+0IEPSJmHav7fvqfPpI1NTT/9YQE4p9VnUSQxcxaNl9vIoJOlikMYTve5KF/C+Hsw+oe
	Ih+J9GhaLRLLlanJUrliTYwsXSlPizl0NNmCAs9lPDW1pwl5nNtbEEMjSaiozT1fJhZIU9Xp
	yS2IpXHJTFHG7UAkSpKmn+RVR/erjit4dQuaQxOS2aJVvhNJYuawNIU/wvPHeNX/FqNDIjSo
	7IHNs3jXt22/2aKUvSKnf0lHYfySTn/cHnvX97tLKzP98SlKtfbjAl2uOFVxxJRYlWC7Ufdw
	Z/TY89XT00yyibCGkiw3Tmxl9Oc+RGyo8xpqeg2e+A5fPZ1ow12nT+1IGHF0uzVbS28/aorU
	7FtYmB12Z796eNG60CTpQazGISHUMmlsNK5SS/8AUlSKS1gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PHcfP1fipkc4aMg9tss+IGRvf2ZiHNuaPOPrN3VTsjsg0
	pUOiWyGhp6s4rS6Xq608XFrldJrEpdIqatacUlvdHZ0Ldzb/fPba67293/98OFJWTgdzqsRT
	ojpRES9nJJRk14b0lRMLlijX9N4JA5czg4ICk5GBjkeVCIy1aQQ4Xm6Hbvcogl9v3pKQl9uB
	oGSwn4Ra6wACS/lFBuxfZkOna5wBW+41BtLLTAy8G/ES0Hf7BgGV5p3wyTBMQVt2KQF5Dgby
	89IJ3/lKwJShggVDajgMld9jwTsYCbaBLhqaC200WHpXwN2iPgaeW2wUWOuHCLA/LWBgwPiH
	hjZrKwVuXQh05GTRUDVWysCI20CCwTXOwvtGPQFW/Tyo1vpaL0/+puFVViMBl+8/JqDz4zME
	DRmfCTAbuxhodo0SUGPOJcHz8CWCId13Fi5dn2IhP02H4Nql2xRo+6Lg10/fcqEzEtKKqymo
	mu5CmzdhY5ER4ebRcRJra85gj+sDgy1uPYVflwr4yb1+FmsbelmsN5/GNeURuOy5g8AlEy4a
	myuuMtg8cYPFmd87CTzW3s7uXnhQEh0nxquSRPXqTYclygemfOakZfnZlslslIo8oZmI4wR+
	reDsWZ+JAjiGXyr09EyRfg7iFws1WcN0JpJwJN81U+gu/Ij8QSC/R7A98LJ+pvhwobjhG+Xv
	kfLrhKwfF/xa4EOFyurGfz0BPj39sJ3ys4yPErL1lVQ2kujRjAoUpEpMSlCo4qNWaY4rkxNV
	Z1cdPZFgRr7/MaR4c+qR0769CfEcks+StjrClDJakaRJTmhCAkfKg6RpdT4ljVMknxPVJw6p
	T8eLmiYUwlHy+dId+8XDMv6Y4pR4XBRPiur/KcEFBKcifk2Z1XNzsa5+7Ixs+MoO5uhIlDfs
	ae67IndoRorHkJNxaG5LccyLwPcH+BKTIWb6oj3Y/mr2TMetulmLApe9aBmKiwhp+9M9ke7s
	aKyl3lSEx0ajW5PwE5vm3FnfGtNzPrSueN8ztSe6fzB225GtHzYGXXXpe7e4E9ZtTNmr03bK
	KY1SERlBqjWKvz/l+6A7AwAA
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


