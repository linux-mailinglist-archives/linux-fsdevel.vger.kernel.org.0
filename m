Return-Path: <linux-fsdevel+bounces-50199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F8CAC8B2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB023A1449
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861D2288F7;
	Fri, 30 May 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YUmSbtk+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56923226D11
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597784; cv=none; b=iSyV3DOJ1kHERN3+Jd73Is3JZ2DcSDljnRqRUCLeYPf5/TXiMe12jPkNNFhGA8045shUIrLGwM9vQi4sYo5m86e5er+mBqhY++FXTOwXjeJ2hYIiquglyhjQU5rBfFAO1Zzm03eKQvafbMyGDx3Ei8R0WvNIJGhJI1r4eXVEt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597784; c=relaxed/simple;
	bh=ALYzXLguj2KAo7eUQpHRTBkt+ax6Jk2hscWpGu5UIaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AwDgB3vBHQ0bm8g6PyBHItGc7AW00wwkYFX2KxicQz9oB36LjQ2dQkW8uv8cHGkl4+0mpgS/MItOcIxxlmN6oNS60pwascFGsd4hs1VNZZSjHCssitfHz4bzt5nP/bYbyi8tai1GYSU7aK0mZYBrsJcGk0/aRA/DmsCoYpOR8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YUmSbtk+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231e98e46c0so18068285ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597781; x=1749202581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcEpV4r+zMsMwJgdzkjWqZN5teRn9qhnk6f0JAPvEA0=;
        b=YUmSbtk+S1jrOLRy9s9/X4wpHMB+n75vTpe5rrwsUM9VdT2Q9FmLk3Ww7r6U6iE+ZZ
         m6NNM+8p4Zb88ynkQTfns8oWZ9g6Nh2VbA6poFf0frPIumbN5ZnjTAMln5Q5730uDC5n
         s/gPN2nkG4m5mmijf7oslKxgnz+aF93fN8MHtlqq2pG+LA4ycmC2rKybxXj7YM73zo6x
         FlevlE2ChxhvQyq0ze6ce1YwOK7rZHevQ8AoE4D8YmS2PWzOcmpKVDMh5yZCJD7I8lDQ
         evgcwWlw8aKXWinQAsjEUsXeRvvhSuq1uZr5PWRhRFDZd4NGIIdcfbJBbAfNJWB0e1Kk
         2n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597781; x=1749202581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcEpV4r+zMsMwJgdzkjWqZN5teRn9qhnk6f0JAPvEA0=;
        b=EWdZd9ueOJVaVM4Or3H4uTp/bxazajAG1H4aoIWDSXDe+q5C8SzGDOfwDIU6nmaT8m
         ZyAX5zlhgj0SZfXXK8IaF/LMz/nDGOwVxLga+X+kuJOsY9meXKm6e3gm+nz7XYeUl0zw
         e2wqtLtAnj9/S2es1lCZG60qA3e7IYFYngoKVCVWrwuR2uqjj4BXQFghLSqS+NP6fg10
         5sDxZkq6c++uU7MHtg4bPThLVoa8GiV8By6HQYyQaDH/1WHr8Gpe0D/uQ3/0fxBZdnrj
         4EC/vYhs3rPk0slaOt3Ta+cTqvMSq/EX/8CM3lOOKjQU8GzO31Lym/nJHQmNDQs365Bp
         R6ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaDrIgk4xXVKKKoNL/HmTOUqUTiQIrJzI7zjvhmEufCDG7HBC6u3q+B1oLGQwZA7BuyKxdjQgT1dxBMqlU@vger.kernel.org
X-Gm-Message-State: AOJu0YzUt/remTfKBLKJrZlPs1wSsZayA9yDtw+xiMCTG9qnK+UYnrcO
	/h227s7p7+St2mSOYS3SxXMbWvmhceIujax4fZgGCB0657Gsb4uZAaJke9m46BhSfmM=
X-Gm-Gg: ASbGncuqUOqgX7SUfL/eRC9lJ980/D0LE9TQe5KNMeVPGHHOPMGuXZCvhcZH4XVIzpN
	1lHKxI/oUeFdnxgoXsBRdWEwUhDhj1akAs7aq73du9d5tVRqHUAoadgyQdohtAfHuDKD3F9UKul
	Hy/cpsXdy1Z1FslxzpT7qHaiirvRzaJV147W5x8TOYt90WF+/56AdCqLoR9M1Bnj2TDbHbZDBO4
	J3FQP7pueVthknatXiIaOcrOD8EXoOXBU/3Hv8YBZKulhWGdp/dCy623YqGO50UXqxxG/GUsqZZ
	d5fFoD2JyUZ6qvIfp5R+VGnJCUlD0aS3/qNprEt3BC6+gS7/56IZTcHacWR+loSaz9OPuuc2PpF
	gTv0c6Z5ARdHvliCNrwpm
X-Google-Smtp-Source: AGHT+IG0dsH4ruc0ZVKtNevc7/fyUjoj6Kve3iAa9r38GSH3v9kXrPKHP05YVx3+W/n5pyeS7YOYMA==
X-Received: by 2002:a17:90b:55c6:b0:311:df4b:4b82 with SMTP id 98e67ed59e1d1-3124150e360mr4147264a91.4.1748597781411;
        Fri, 30 May 2025 02:36:21 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.36.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:36:21 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 31/35] RPAL: add receiver waker
Date: Fri, 30 May 2025 17:27:59 +0800
Message-Id: <198278a03d91ab7e0e17d782c657da85cff741bb.1748594841.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In an RPAL call, the receiver thread is in the TASK_INTERRUPTIBLE state
and cannot be awakened, which may lead to missed wakeups. For example, if
no kernel event occurs during the entire RPAL call, the receiver thread
will remain in the TASK_INTERRUPTIBLE state after the RPAL call completes.

To address this issue, RPAL adds a flag to the receiver whenever it
encounters an unawakened state and introduces a "waker" work. The waker
work runs automatically on every tick to check for receiver threads that
have missed wakeups. If any are found, it wakes them up. For epoll, the
waker also checks for pending user mode events and wakes the receiver
thread if such events exist.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/internal.h |  4 ++
 arch/x86/rpal/service.c  | 98 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/rpal/thread.c   |  3 ++
 include/linux/rpal.h     | 11 +++++
 kernel/sched/core.c      |  3 ++
 5 files changed, 119 insertions(+)

diff --git a/arch/x86/rpal/internal.h b/arch/x86/rpal/internal.h
index e03f8a90619d..117357dabdec 100644
--- a/arch/x86/rpal/internal.h
+++ b/arch/x86/rpal/internal.h
@@ -22,6 +22,10 @@ int rpal_enable_service(unsigned long arg);
 int rpal_disable_service(void);
 int rpal_request_service(unsigned long arg);
 int rpal_release_service(u64 key);
+void rpal_insert_wake_list(struct rpal_service *rs,
+			   struct rpal_receiver_data *rrd);
+void rpal_remove_wake_list(struct rpal_service *rs,
+			   struct rpal_receiver_data *rrd);
 
 /* mm.c */
 static inline struct rpal_shared_page *
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 9fd568fa9a29..6fefb7a7729c 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -143,6 +143,99 @@ static void delete_service(struct rpal_service *rs)
 	spin_unlock_irqrestore(&hash_table_lock, flags);
 }
 
+void rpal_insert_wake_list(struct rpal_service *rs,
+			   struct rpal_receiver_data *rrd)
+{
+	unsigned long flags;
+	struct rpal_waker_struct *waker = &rs->waker;
+
+	spin_lock_irqsave(&waker->lock, flags);
+	list_add_tail(&rrd->wake_list, &waker->wake_head);
+	spin_unlock_irqrestore(&waker->lock, flags);
+	pr_debug("rpal debug: [%d] insert wake list\n", current->pid);
+}
+
+void rpal_remove_wake_list(struct rpal_service *rs,
+			   struct rpal_receiver_data *rrd)
+{
+	unsigned long flags;
+	struct rpal_waker_struct *waker = &rs->waker;
+
+	spin_lock_irqsave(&waker->lock, flags);
+	list_del(&rrd->wake_list);
+	spin_unlock_irqrestore(&waker->lock, flags);
+	pr_debug("rpal debug: [%d] remove wake list\n", current->pid);
+}
+
+/* waker->lock must be hold */
+static inline void rpal_wake_all(struct rpal_waker_struct *waker)
+{
+	struct task_struct *wake_list[RPAL_MAX_RECEIVER_NUM];
+	struct list_head *list;
+	unsigned long flags;
+	int i, cnt = 0;
+
+	spin_lock_irqsave(&waker->lock, flags);
+	list_for_each(list, &waker->wake_head) {
+		struct task_struct *task;
+		struct rpal_receiver_call_context *rcc;
+		struct rpal_receiver_data *rrd;
+		int pending;
+
+		rrd = list_entry(list, struct rpal_receiver_data, wake_list);
+		task = rrd->rcd.bp_task;
+		rcc = rrd->rcc;
+
+		pending = atomic_read(&rcc->ep_pending) & RPAL_USER_PENDING;
+
+		if (rpal_test_task_thread_flag(task, RPAL_WAKE_BIT) ||
+		    (pending && atomic_cmpxchg(&rcc->receiver_state,
+					       RPAL_RECEIVER_STATE_WAIT,
+					       RPAL_RECEIVER_STATE_RUNNING) ==
+					RPAL_RECEIVER_STATE_WAIT)) {
+			wake_list[cnt] = task;
+			cnt++;
+		}
+	}
+	spin_unlock_irqrestore(&waker->lock, flags);
+
+	for (i = 0; i < cnt; i++)
+		wake_up_process(wake_list[i]);
+}
+
+static void rpal_wake_callback(struct work_struct *work)
+{
+	struct rpal_waker_struct *waker =
+		container_of(work, struct rpal_waker_struct, waker_work.work);
+
+	rpal_wake_all(waker);
+	/* We check it every ticks */
+	schedule_delayed_work(&waker->waker_work, 1);
+}
+
+static void rpal_enable_waker(struct rpal_waker_struct *waker)
+{
+	INIT_DELAYED_WORK(&waker->waker_work, rpal_wake_callback);
+	schedule_delayed_work(&waker->waker_work, 1);
+	pr_debug("rpal debug: [%d] enable waker\n", current->pid);
+}
+
+static void rpal_disable_waker(struct rpal_waker_struct *waker)
+{
+	unsigned long flags;
+	struct list_head *p, *n;
+
+	cancel_delayed_work_sync(&waker->waker_work);
+	rpal_wake_all(waker);
+	spin_lock_irqsave(&waker->lock, flags);
+	list_for_each_safe(p, n, &waker->wake_head) {
+		list_del_init(p);
+	}
+	INIT_LIST_HEAD(&waker->wake_head);
+	spin_unlock_irqrestore(&waker->lock, flags);
+	pr_debug("rpal debug: [%d] disable waker\n", current->pid);
+}
+
 static inline unsigned long calculate_base_address(int id)
 {
 	return RPAL_ADDRESS_SPACE_LOW + RPAL_ADDR_SPACE_SIZE * id;
@@ -213,6 +306,10 @@ struct rpal_service *rpal_register_service(void)
 	rs->pku_on = PKU_ON_FALSE;
 	rpal_service_pku_init();
 #endif
+	spin_lock_init(&rs->waker.lock);
+	INIT_LIST_HEAD(&rs->waker.wake_head);
+	/* receiver may miss wake up if in lazy switch, try to wake it later */
+	rpal_enable_waker(&rs->waker);
 
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
@@ -257,6 +354,7 @@ void rpal_unregister_service(struct rpal_service *rs)
 		schedule();
 
 	delete_service(rs);
+	rpal_disable_waker(&rs->waker);
 
 	pr_debug("rpal: unregister service, id: %d, tgid: %d\n", rs->id,
 		 rs->group_leader->tgid);
diff --git a/arch/x86/rpal/thread.c b/arch/x86/rpal/thread.c
index fcc592baaac0..51c9eec639cb 100644
--- a/arch/x86/rpal/thread.c
+++ b/arch/x86/rpal/thread.c
@@ -186,6 +186,8 @@ int rpal_register_receiver(unsigned long addr)
 	current->rpal_rd = rrd;
 	rpal_set_current_thread_flag(RPAL_RECEIVER_BIT);
 
+	rpal_insert_wake_list(cur, rrd);
+
 	atomic_inc(&cur->thread_cnt);
 
 	return 0;
@@ -214,6 +216,7 @@ int rpal_unregister_receiver(void)
 	clear_fs_tsk_map();
 
 	rpal_put_shared_page(rrd->rsp);
+	rpal_remove_wake_list(cur, rrd);
 	rpal_clear_current_thread_flag(RPAL_RECEIVER_BIT);
 	rpal_free_thread_pending(&rrd->rcd);
 	kfree(rrd);
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 16a3c80383f7..1d8c1bdc90f2 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -116,6 +116,7 @@ enum rpal_task_flag_bits {
 	RPAL_RECEIVER_BIT,
 	RPAL_CPU_LOCKED_BIT,
 	RPAL_LAZY_SWITCHED_BIT,
+	RPAL_WAKE_BIT,
 };
 
 enum rpal_receiver_state {
@@ -189,6 +190,12 @@ struct rpal_fsbase_tsk_map {
 	struct task_struct *tsk;
 };
 
+struct rpal_waker_struct {
+	spinlock_t lock;
+	struct list_head wake_head;
+	struct delayed_work waker_work;
+};
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -255,6 +262,9 @@ struct rpal_service {
 	int pkey;
 #endif
 
+	/* receiver thread waker */
+	struct rpal_waker_struct waker;
+
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
 
@@ -347,6 +357,7 @@ struct rpal_receiver_data {
 	struct fd f;
 	struct hrtimer_sleeper ep_sleeper;
 	wait_queue_entry_t ep_wait;
+	struct list_head wake_list;
 };
 
 struct rpal_sender_data {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 486d59bdd3fc..c219ada29d34 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3943,6 +3943,7 @@ static bool rpal_check_state(struct task_struct *p)
 		struct rpal_receiver_call_context *rcc = p->rpal_rd->rcc;
 		int state;
 
+		rpal_clear_task_thread_flag(p, RPAL_WAKE_BIT);
 retry:
 		state = atomic_read(&rcc->receiver_state) & RPAL_RECEIVER_STATE_MASK;
 		switch (state) {
@@ -3957,6 +3958,7 @@ static bool rpal_check_state(struct task_struct *p)
 		case RPAL_RECEIVER_STATE_RUNNING:
 			break;
 		case RPAL_RECEIVER_STATE_CALL:
+			rpal_set_task_thread_flag(p, RPAL_WAKE_BIT);
 			ret = false;
 			break;
 		default:
@@ -4522,6 +4524,7 @@ int rpal_try_to_wake_up(struct task_struct *p)
 
 	BUG_ON(READ_ONCE(p->__state) == TASK_RUNNING);
 
+	rpal_clear_task_thread_flag(p, RPAL_WAKE_BIT);
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
 		smp_mb__after_spinlock();
 		if (!ttwu_state_match(p, TASK_NORMAL, &success))
-- 
2.20.1


