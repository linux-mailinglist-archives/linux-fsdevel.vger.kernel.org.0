Return-Path: <linux-fsdevel+bounces-48866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F273CAB5234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8EF1892C30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE628C5D9;
	Tue, 13 May 2025 10:08:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3F248880;
	Tue, 13 May 2025 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130892; cv=none; b=in1/23ix0oya6xk55XYwL5MrMJk2S/ao0YeKbeZT08MerbxpFZMMrfXVxed/QeOXKBwgsLu2Dodo4HuDXsM5uYm/Eq/0H1pPPOwnqMsBMz5r6oplaiMs+J21uVVe03363Y2wvuVRDKL870OcXcDgLDZToOWXXg0HGdnN8/uHl3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130892; c=relaxed/simple;
	bh=YIhasWAI2DFiyLXsGvo/xd87ErP0zWnVDexTxa/J6wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PkxqcOiYkADb5j09SB6vAmP9upg0q+fQ96z2V3gLQUHwWRR9/38v0rVFKf75PjHS+AZmNJHV12N0gu7gcVvfkubhMQVBffWKOU7cCtjse+iOerLZIr4BxwcvoAHAwEqe0z+8xQIG4mWYuFlDgArh4ugRoWsDidgkPLHtqc1t+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-be-682319f1c0cb
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
Subject: [PATCH v15 32/43] dept: assign dept map to mmu notifier invalidation synchronization
Date: Tue, 13 May 2025 19:07:19 +0900
Message-Id: <20250513100730.12664-33-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfb6/uzq+zo0vGTozWyiZeP7AGOa7mY1h5tdy6Tt3U7GLEjPF
	5Ue5VjiR4rrsSncqFxOVpUhp6iRXbnXq/Jh0lVV3SifuMv88e+39PM/r+edhcMkrchajjD0m
	qGLl0TJKRIj6AvRLBmfOVyy1VfiDa/giATklJgosxUYEpofJGPS83ARtbieCsTfNOGRpLQjy
	ujtxeFhnR1BVeJaCd58nQ6trgIIGbRoF5/JLKHjb68Gg4/oVDIzmLfDR8JWAxgw9Blk9FNzK
	Ood5yzcMRg1FNBiSFoCjMJsGT3cYNNitJFTZFsHN2x0UVFY1EFBX7sDg3dMcCuymPyQ01tUT
	4E4PBEumhoT7/XoKet0GHAyuARpaqnUY1OmmQ6naKzw/NE7CK001BufvPsCg9UMFgmcXuzAw
	m6wU1LqcGJSZtTj8KniJwJHeR0PK5VEabiWnI0hLuU6AuiMcxka8l3OHwyD5TikB939b0drV
	vOm2CfG1zgGcV5cl8L9c7ym+yq0j+Nd6jn+S3Unz6mc2mteZj/NlhcF8fmUPxucNukjeXHSJ
	4s2DV2g+ta8V4/ubmuits/eIVkUJ0cp4QRW65oBIkd/1Ax1tW3nih+c7mYTsS1KRH8OxyznH
	8E8yFTET/GkkwRdT7EKuvX0U97GUnceVab56R0QMzlr9ubbcD8jXmMbu5/S2/Akm2AXc6FAz
	6WMxu4Kz5NnJf/65nLG0ekLk581/FzQRPpaw4VyGzkj4pBx71Y+zt2RT/xZmcs8L24kMJNah
	SUVIooyNj5Ero5eHKBJjlSdCDh6JMSPvexlOe/aWo0HL9hrEMkgWIK7vCVJISHl8XGJMDeIY
	XCYVJz/2RuIoeeJJQXUkQnU8WoirQYEMIZshXuZOiJKwh+THhMOCcFRQ/e9ijN+sJJQ3J8Z5
	qDvJOelUbWD3I4q9Fr5BKr33p35svmTu7I8vIkPX73hzYF+4I2B3hKv5y3hne8S0yPXrtOma
	zZc7pyqz1z3/snX6rrQWS1eqeuPOxcGnDud62gwhCb2abcU5eytvjqRIjRfUGlKfqbWOV4xP
	tmk+x/ffqF8d5F/eAlPSzmTKiDiFPCwYV8XJ/wJyrz64WgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRzF+933VsuLjbwVvVZSmD2ErG8UIkH5IygiCEmoXHVpwzllS80g
	0NQoy2GRSZq5acyl8zXtneIDTXuoNVMznbWiskwr3eiWPabQP4cP58A5/xyO9L9Bz+e0+mOi
	Qa/WqRg5Jd+1OW31t3nLNOsuNa8Fz8QZCq5W2hnoqihDYK9NJWC4JQJ6vSMIfj3tJCE3pwuB
	5c0gCbWtLgR1tlMMON/Nhm7PGAPtOecYSCuuZODZ50kCBi5fJKDMsROGrO8peJxdREDuMAP5
	uWmETz4SIFlLWbCmBILblsfC5JsQaHf10NBc0E5DXf8quHJtgIEHde0UtN5xE+C8d5UBl/0v
	DY9b2yjwmhZA14UsGspHixj47LWSYPWMsfC8wUxAq3kuVKX7Wk+P/6HhYVYDAaevVxPQ/fI+
	gvozrwlw2HsYaPaMEFDjyCHhZ0kLArfpCwsZ5yUW8lNNCM5lXKYgfSAUfv3wLRdMhEBqYRUF
	5b97UHgYtl+zI9w8Mkbi9Jok/NPzgsF1XjOFHxUJ+G7eIIvT6/tZbHYk4BpbEC5+MExgy3cP
	jR2lZxns+H6RxZlfugk82tHB7l4YJd9yRNRpE0XD2rBouab49VcU37vx+NfJT3QKcq3ORBwn
	8OuFtz+SMpGMY/gVQl+fRE6xkl8i1GS9pzORnCP5nplCb8FLNBXM4fcLRf3F00zxgYI03klP
	sYLfIHRZXNMs8IuFsqqG6SKZz/9d0kFNsT8fKmSby6hsJDejGaVIqdUnxqq1utA1xhhNsl57
	fM3huFgH8h3IenLywh004YxoQjyHVLMUbcNLNf60OtGYHNuEBI5UKRWpt32W4og6+YRoiDto
	SNCJxia0gKNUAYodkWK0P39UfUyMEcV40fA/JTjZ/BS058rsmfG2PuXy/G1RWPJwZ/PjbkgJ
	B+etfxqntJjCnffHwxbt1e8KW6Re2XRTu6nCz/whwBTU6H0FkeHOS/X7DtTHR1/fJA0d2nc4
	2C/AUmFTEuYZGY3B1e5OUuveGqmIsO+RuvMqn8u4Z7rtMbcqcgtnFcqkJ7GWZFSVFJ2goowa
	dUgQaTCq/wFtpqPwPAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Resolved the following false positive by introducing explicit dept map
and annotations for dealing with this case:

   *** DEADLOCK ***
   context A
       [S] (unknown)(<sched>:0)
       [W] lock(&mm->mmap_lock:0)
       [E] try_to_wake_up(<sched>:0)

   context B
       [S] lock(&mm->mmap_lock:0)
       [W] mmu_interval_read_begin(<sched>:0)
       [E] unlock(&mm->mmap_lock:0)

   [S]: start of the event context
   [W]: the wait blocked
   [E]: the event not reachable

dept already tracks dependencies between scheduler sleep and ttwu based
on internal timestamp called wgen.  However, in case that more than one
event contexts are overwrapped, dept has chance to wrongly guess the
start of the event context like the following:

   <before this patch>

   context A: lock L
   context A: mmu_notifier_invalidate_range_start()

   context B: lock L'
   context B: mmu_interval_read_begin() : wait
   <- here is the start of the event context of C.
   context B: unlock L'

   context C: lock L''
   context C: mmu_notifier_invalidate_range_start()

   context A: mmu_notifier_invalidate_range_end()
   context A: unlock L

   context C: mmu_notifier_invalidate_range_end() : ttwu
   <- here is the end of the event context of C.  dept observes a wait,
      lock L'' within the event context of C.  Which causes a false
      positive dept report.

   context C: unlock L''

By explicitly annotating the interesting event context range, make dept
work with more precise information like:

   <after this patch>

   context A: lock L
   context A: mmu_notifier_invalidate_range_start()

   context B: lock L'
   context B: mmu_interval_read_begin() : wait
   context B: unlock L'

   context C: lock L''
   context C: mmu_notifier_invalidate_range_start()
   <- here is the start of the event context of C.

   context A: mmu_notifier_invalidate_range_end()
   context A: unlock L

   context C: mmu_notifier_invalidate_range_end() : ttwu
   <- here is the end of the event context of C.  dept doesn't observe
      the wait, lock L'' within the event context of C.  context C is
      responsible only for the range delimited by
      mmu_notifier_invalidate_range_{start,end}().

   context C: unlock L''

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mmu_notifier.h | 26 ++++++++++++++++++++++++++
 mm/mmu_notifier.c            | 31 +++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index bc2402a45741..1e256f5305b7 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -428,6 +428,14 @@ static inline int mmu_notifier_test_young(struct mm_struct *mm,
 	return 0;
 }
 
+#ifdef CONFIG_DEPT
+void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range);
+void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range);
+#else
+static inline void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range) {}
+static inline void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range) {}
+#endif
+
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
@@ -439,6 +447,12 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 		__mmu_notifier_invalidate_range_start(range);
 	}
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	/*
+	 * From now on, waiters could be there by this start until
+	 * mmu_notifier_invalidate_range_end().
+	 */
+	mmu_notifier_invalidate_dept_ecxt_start(range);
 }
 
 /*
@@ -459,6 +473,12 @@ mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 		ret = __mmu_notifier_invalidate_range_start(range);
 	}
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	/*
+	 * From now on, waiters could be there by this start until
+	 * mmu_notifier_invalidate_range_end().
+	 */
+	mmu_notifier_invalidate_dept_ecxt_start(range);
 	return ret;
 }
 
@@ -470,6 +490,12 @@ mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range)
 
 	if (mm_has_notifiers(range->mm))
 		__mmu_notifier_invalidate_range_end(range);
+
+	/*
+	 * The event context that has been started by
+	 * mmu_notifier_invalidate_range_start() ends.
+	 */
+	mmu_notifier_invalidate_dept_ecxt_end(range);
 }
 
 static inline void mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index fc18fe274505..850d75952f98 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -46,6 +46,7 @@ struct mmu_notifier_subscriptions {
 	unsigned long active_invalidate_ranges;
 	struct rb_root_cached itree;
 	wait_queue_head_t wq;
+	struct dept_map dmap;
 	struct hlist_head deferred_list;
 };
 
@@ -165,6 +166,25 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 	wake_up_all(&subscriptions->wq);
 }
 
+#ifdef CONFIG_DEPT
+void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+		range->mm->notifier_subscriptions;
+
+	if (subscriptions)
+		sdt_ecxt_enter(&subscriptions->dmap);
+}
+void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+		range->mm->notifier_subscriptions;
+
+	if (subscriptions)
+		sdt_ecxt_exit(&subscriptions->dmap);
+}
+#endif
+
 /**
  * mmu_interval_read_begin - Begin a read side critical section against a VA
  *                           range
@@ -246,9 +266,12 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (is_invalidating)
+	if (is_invalidating) {
+		sdt_might_sleep_start(&subscriptions->dmap);
 		wait_event(subscriptions->wq,
 			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+		sdt_might_sleep_end();
+	}
 
 	/*
 	 * Notice that mmu_interval_read_retry() can already be true at this
@@ -625,6 +648,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 
 		INIT_HLIST_HEAD(&subscriptions->list);
 		spin_lock_init(&subscriptions->lock);
+		sdt_map_init(&subscriptions->dmap);
 		subscriptions->invalidate_seq = 2;
 		subscriptions->itree = RB_ROOT_CACHED;
 		init_waitqueue_head(&subscriptions->wq);
@@ -1070,9 +1094,12 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (seq)
+	if (seq) {
+		sdt_might_sleep_start(&subscriptions->dmap);
 		wait_event(subscriptions->wq,
 			   mmu_interval_seq_released(subscriptions, seq));
+		sdt_might_sleep_end();
+	}
 
 	/* pairs with mmgrab in mmu_interval_notifier_insert() */
 	mmdrop(mm);
-- 
2.17.1


