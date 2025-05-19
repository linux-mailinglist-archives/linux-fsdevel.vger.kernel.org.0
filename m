Return-Path: <linux-fsdevel+bounces-49379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED77ABB991
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845B71B61FDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1FD288CA7;
	Mon, 19 May 2025 09:19:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009D28315F;
	Mon, 19 May 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646348; cv=none; b=r8YpL9YR+bWVxBNHeBqHFloTLDcp/9BPd3Ga6WM+wbS/NxphHbqa3AUy1C729pfzfCl5s/qIBkw36vNwvm+gE2C/0UqumBGAaAdDtvF7OYIxsV5+lK6M4nYSqm1CV2IcrLv0SZpu0+RoEJXNDbW9AUIjZYcVufuJ0Ttpf3XFlY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646348; c=relaxed/simple;
	bh=5iNxUiZ0D3cUVfQSKToDeMBtYk+ALyH8lFAmQxiYpMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MC6sz3cfGOKeYHG963XWAW4hiu6NZUlDr8YGInvx3U1ev+n+++dYSraTlTjM/G3wRp+ov+J9kbDK+/BN9jAXF0vJcOWKtwmn9sgvoY5OUD9PYckFpKtwdn9/059OW0trwwlA/Pt38NMC0ON3jK4iJk58FzDZ2YOHy/wZlwoOuC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-44-682af771e118
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
Subject: [PATCH v16 40/42] dept: introduce event_site() to disable event tracking if it's recoverable
Date: Mon, 19 May 2025 18:18:24 +0900
Message-Id: <20250519091826.19752-41-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUwTdxgA8P3/d727FuuOyvB8yWaaGJVFBaPm+SAGEsVbsg0TkyXqFneR
	29oIRVtEmJoAIkE6iJpApwi2vNSmLVpbM0EoshIK6OZAWXkZolRlIiAGaRFEXYH45ckvz+uX
	hyEUrZLljFqTJmo1QrKSkpGysUWm9UemolTRN++vg8BkPgmXrtkp6LhqQ2C/kY1huGUXdAdH
	Ebz9628CDMUdCEyDDwm44R1A4LbkUPDg6WLoCoxT0F6sp+BU5TUKOkdmMfSXnMdgc34Dj8xD
	JNw9W4HBMExBqeEUDoXnGKbNVhrMWavBb7lIw+xgDLQP+CTg7vsSLpT3U9DgbifBW+vH8ODW
	JQoG7B8kcNfbRkKwaAV0nCuUQM3LCgpGgmYCzIFxGu43GTF4jZHgyA0tzHv9XgKthU0Y8qqu
	Y+jqrUfQmP8Yg9Puo6A5MIrB5SwmYOZKCwJ/0RgNp3+dpqE0uwiB/nQJCbn9W+Dtm9DlsskY
	yL7sIKHmnQ/FxfL2cjvim0fHCT7XdYyfCfxD8e6gkeTvVHB83cWHNJ/b2EfzRudR3mWJ4isb
	hjFvmghIeKf1DMU7J87TfMFYF+Zf3rtH7165T7YtSUxWp4vajdt/lKn+PVeFDj/5PCMnrwZn
	oWquAEkZjt3MDZnq0EfnzDyeN8Wu4Xp6pok5R7CrOFfhkKQAyRiC9YVx3WW9801LWJFz+Kbw
	nEl2Nfeu/hk1Zzm7lfNXdhILS7/gbI6meUtD+T598/ysgt3CddnKyYUeg5Trm/x+wcu4Pyw9
	5FkkN6JPrEih1qSnCOrkzRtUmRp1xoaDqSlOFHov88nZ/bVoomOPB7EMUi6SO9zrVAqJkK7L
	TPEgjiGUEXKra61KIU8SMn8RtakHtEeTRZ0HrWBI5VL5puCxJAX7s5AmHhLFw6L2YxUz0uVZ
	aFl4+d5Dv8d9NvKG/DQorR6s7pY6diT0xvu8utLiaE/S17u3e76a+lDLGO7Qi18FI4deTIYn
	7EjbJv3ptuVZzprO1CNl3/5ZcuKHpfq242HxpWZbQoU/MT/juyyb/bdG6wl9XFjsdWtllcEk
	1Mb/t5FdWRep6bwQmyrs2+mjNzUn5ilJnUqIiSK0OuF/EerFUloDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfT7fX3eXs+9O4yvz68ZUfrbJHmOG2XwxstnY/KOj79xRp+4q
	YqjrtPSLY2n0w1Wcdnfp3N0fyFkr4kSicymVOkQTbXSpU7gy/zx77f1+nvf7n0dEyMxUmEil
	ThY0akW8nJaQkp1rM5cl/YxUruzuCgH/UDYJJTVWGlpuWRBYnRkY+h9tgbbhAQS/nr8goKiw
	BUF5bxcBzsZuBK4qHQ2tH6aBxz9Ig7swl4bMyhoaXn4Zw9B5+SIGi30HvDP1kdB0oQJDUT8N
	xUWZODg+Yxg1mRkwpS8CX9VVBsZ6o8Dd7aWgodRNgatjCVwp66ThvstNQuMdH4bWeyU0dFv/
	UNDU+ISE4YLZ0GLIp6D6WwUNX4ZNBJj8gwy8qjNiaDTOAJs+mJr14zcFj/PrMGRdv43B016L
	4EF2Dwa71UtDg38Ag8NeSEDg5iMEvoKvDJzNG2WgOKMAQe7ZyyToO6Ph10iwuXQoCjKu2Uio
	HveiDet5a5kV8Q0DgwSvdxzjA/7XNO8aNpL80wqOv3u1i+H1DzoY3mhP4R1VkXzl/X7Ml3/3
	U7zdfI7m7d8vMnzOVw/mvzU3M7vm7JOsixPiVamCZsX6WInyreE6Snw/97guqxqnoxtcDhKL
	OHYVpwv0oAmm2cXcmzejxASHsvM5R34flYMkIoL1hnBtpe2TS9NZgbN5f+IJJtlF3HjtR3qC
	pexqzlf5kvgXOo+z2OomWRzUO3IbJm9lbDTnsZSRF5DEiKaYUahKnZqgUMVHL9ceUaapVceX
	HzyaYEfBDzKdGjPcQUOtW+oRK0LyqVKbK0IpoxSp2rSEesSJCHmo1OwIV8qkcYq0E4Lm6H5N
	SrygrUezRaR8pnTbXiFWxh5SJAtHBCFR0Px3sUgclo4SLb3TH37a7FmQadg7smNj8Xnxk/DT
	csq/oscXeJon3fWs79S6kllD+wf3OJ0rI0JeoXnGZ4bx5L6Tn03O+pEzsWJ3ufSSLqZ57r3A
	uTVhMYfb1oRv2rTQk1g7NvXK5tzftqW4IE5v+dO227wx+UDe4qRbj29uT8reoF6oyzJund+0
	VU5qlYqoSEKjVfwFKydO1T0DAAA=
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
index 25fdd324614a..0ac13129f308 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -487,6 +487,31 @@ extern void dept_task_exit(struct task_struct *t);
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
@@ -550,6 +575,11 @@ struct dept_event_site { };
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
index baa60bd0fb93..c65bb0c6dad2 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2573,6 +2573,23 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
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
@@ -2585,6 +2602,9 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	struct dept_key *k;
 	int e;
 
+	if (event_track_disabled())
+		return;
+
 	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
 
 	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
-- 
2.17.1


