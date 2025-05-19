Return-Path: <linux-fsdevel+bounces-49371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBF7ABB959
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3282189FC2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310C2284695;
	Mon, 19 May 2025 09:19:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B13627AC37;
	Mon, 19 May 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646344; cv=none; b=aHlM6o4CsqVjhI2nJC/o5yRgL+IAuMBqcT1G0LUJL8m5kqSBLuK4wErNbcxYwiBg4MHOTN2nah/wpdevsxrS1yYu5UriqapDBZzsqcCXx4CnKBVDbzKht52MHEV2ecmng73N/BthE02b/nRW4JCo6Ircc5B+BTOOtLCEQaeiQQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646344; c=relaxed/simple;
	bh=YIhasWAI2DFiyLXsGvo/xd87ErP0zWnVDexTxa/J6wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fNKmTGygENd3ji5ff2pbd9Rr4xYYSYTZx9nYiYBxlu7Lf/m2NDgAEfaeZWy2FYyEsC16ZSBe0bqKQ+7ONCx6Urs/VDmzZOkP+7imU2936Go+6CfRVUxUjcp4XDd6HcMZ23KUnvFC0jbwhCCdOhJIHavTtl3lnyyqi4o08rNqwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-b9-682af770961a
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
Subject: [PATCH v16 31/42] dept: assign dept map to mmu notifier invalidation synchronization
Date: Mon, 19 May 2025 18:18:15 +0900
Message-Id: <20250519091826.19752-32-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfd47lZrXjuijYGaaEDdMFYzY88EZk2l8YrLMxMREjbpuvLGN
	LWKLCCbLQBGVSoMiMG9YQEtD66itiZdZglQLaERQpEgQsSpZJ7dh2w1FXUH9cvLL+Z/zO1+O
	QCta2fmCLjNbMmZq9EpOxsiG46tVWf+maFPf2NQQCR9h4GyDk4OOPxwInFcKKAjdWQeB6BCC
	d/cf0FBZ3oGg+vlTGq74+xF47Qc4ePRyFnRFRjloKzdzcLC2gYPO15MU9FWcoMDh/gGe2QYZ
	uFdaQ0FliIMzlQepWPmLgglbPQ+2/GQI2k/zMPk8Ddr6u1nw9i6GU1V9HNz0tjHgvxak4NGN
	sxz0Oz+ycM/fykDUkggdx0tYuDRSw8HrqI0GW2SUh4dNVgr81jngKowJi958YKGlpImCoguX
	Keh68ieCxiMDFLid3Rz4IkMUeNzlNLytu4MgaBnm4dCxCR7OFFgQmA9VMFDYlw7v/otdPhdO
	g4LzLgYuve9Gq78jzionIr6hUZoUevaRt5HHHPFGrQy5W4PJ9dNPeVLY2MsTq3sv8dhTSO3N
	EEWqxyMscdcf5Yh7/ARPioe7KDLS3s5vSNoiW5kh6XU5knHpqp9k2tqBMZQVUOeOTf7N5qN+
	VTGKE7C4HD8Mt1Bf+J+TL6aZExfhnp4JeooTxIXYUzLIFiOZQIvdM3Hg3BM0FXwlbsPvexqn
	mRGT8cvyID/FcnEFtlSHPku/xg5X07QoLtbvNfum5xViOu5yVDFTUiyWxWHnhIX7tDAP37L3
	MKVIbkUz6pFCl5lj0Oj0y5do8zJ1uUt+2W1wo9h/2X6d3HoNjXdsbEaigJTxcpf3W62C1eSY
	8gzNCAu0MkFe7/lGq5BnaPL2S8bdO4x79ZKpGSUKjHKufFl0X4ZC3KnJlnZJUpZk/JJSQtz8
	fJQtpeJjnSrf7c7AesgvYneWPUZXRxrC5kFYIWTnOlLjfbWdJ0/pAy0H7qevPRosTUxX5+GK
	7c+2JiSNLuM572GVuXl/HTNzU3z7QOXGV78ZdgUO3yrIKFk1Vqa/vfmj4XuiDq3ZHjLZk3+W
	1y1QXdyj/j3UmlzlZ11JYfTjbCVj0mrSUmijSfM/8QQ2DVsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/p+s4fjuN34qxMyRT2hwfY3nY6Dvk4R+MmW75zZ0ed3dS
	zFZKo3SLqTyVq+y0u4vrzoa4pDiOSZRKUoqZdOShi3Lhyvzz2Wuf92evzz9vCSU3M0ESTaJe
	1Caq4hWslJZuXJa5IPlHqHqhpzEAvAPHaLhw1cpC4xULAuu1DAy996OgddCD4NeTpxQUFTQi
	KO1+TcE1VycCZ8URFpreTYRmbz8L7oJcFjLLr7LwrM+HoaPwFAaLPRq6TO9peJxfhqGol4Xz
	RZnYPz5gGDKZOTClz4aeinMc+LojwN3ZwkB9sZsBZ/t8OFvSwcJtp5sG140eDE3VF1jotP5h
	4LHrIQ2DhmBoPJnHQOXnMhb6Bk0UmLz9HDyvNWJwGaeALctvzf7+m4EHebUYsi9VYWh+eQtB
	zbE3GOzWFhbqvR4MDnsBBcOX7yPoMXzi4OiJIQ7OZxgQ5B4tpCGrQwm/fvo/Fw9EQMZFGw2V
	Iy1oZSSxllgRqff0UyTLcYAMe1+wxDlopMmjMoHcPPeaI1k17Rwx2vcTR0UoKb/di0npNy9D
	7ObjLLF/O8WRnE/NmHxuaOA2T98hXb5HjNekiNrwyBipuvzNF5TcuiT1i+8jk446F+SgAInA
	LxK+nn6LR5nl5wptbUPUKAfyMwVH3nsmB0klFN8yXmgtfolGg8n8LmGkrWaMaX628K6ghxtl
	Gb9YMJT24n/SGYLFVjsmCvDv23Prx+7lvFJotpTQ+UhqROPMKFCTmJKg0sQrw3Rx6rRETWpY
	bFKCHfkbZDrsO3kDDTRF1SFeghQTZDbnPLWcUaXo0hLqkCChFIEysyNELZftUaUdFLVJu7X7
	40VdHQqW0IqpsnXbxBg5v1elF+NEMVnU/k+xJCAoHc1Syyb6fDGXZbp74UsMO+92BYfFXp+q
	Lt8effbtNoIyHu17vrrK69Gv6ftTTc95kW+SrjqyN3B9Q/vWV6UrTgwob0Zmb+Ydu1zdXfq4
	YVg61xM+LarK/SCkmlg3rtWzkcIhRYVpfVDXmexN0TXKSVs2hMpi19g+WHTW8KTCOyOpClqn
	VkWEUlqd6i9J66ZnPQMAAA==
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


