Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D832246806
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgHQOKA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:10:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728910AbgHQOJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=hIFyaPZvMHjVeqORMTUHU+96lxgfjim2o5HDKXDYjqs=;
        b=ff5CXecgNivyae+CAR5/pzC8I/ZQ9R3YG5Dsk+5DaVvg64S0SD3B8oBJ/Z3m01M02Qewgn
        Owg7gwouElHi2sRsVgxjKGF0FH/DZ/v+jV+zHvEr5ITGbhaOdmNPnM7ZBgjZOvWxFLufzw
        vIm2culDjJ6ZGB1FZenQSUqXXapPUJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-WvjdVa5iN6mxQ3yFLskmxw-1; Mon, 17 Aug 2020 10:09:53 -0400
X-MC-Unique: WvjdVa5iN6mxQ3yFLskmxw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B503A801AC3;
        Mon, 17 Aug 2020 14:09:51 +0000 (UTC)
Received: from llong.com (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6E9A21E90;
        Mon, 17 Aug 2020 14:09:49 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 2/8] memcg, mm: Return ENOMEM or delay if memcg_over_limit
Date:   Mon, 17 Aug 2020 10:08:25 -0400
Message-Id: <20200817140831.30260-3-longman@redhat.com>
In-Reply-To: <20200817140831.30260-1-longman@redhat.com>
References: <20200817140831.30260-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The brk(), mmap(), mlock(), mlockall() and mprotect() syscalls are
modified to check the memcg_over_limit flag and return ENOMEM when it
is set and memory control action is PR_MEMACT_ENOMEM.

In case the action is PR_MEMACT_SLOWDOWN, an artificial delay of 20ms
will be added to slow down the memory allocation syscalls.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h | 16 ++++++++++++++++
 kernel/fork.c         |  1 +
 mm/memcontrol.c       | 25 +++++++++++++++++++++++--
 mm/mlock.c            |  6 ++++++
 mm/mmap.c             | 12 ++++++++++++
 mm/mprotect.c         |  3 +++
 6 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c79d606d27ab..9ec1bd072334 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1477,6 +1477,22 @@ static inline char task_state_to_char(struct task_struct *tsk)
 	return task_index_to_char(task_state_index(tsk));
 }
 
+#ifdef CONFIG_MEMCG
+extern bool mem_cgroup_check_over_limit(void);
+
+static inline bool mem_over_memcg_limit(void)
+{
+	if (READ_ONCE(current->memcg_over_limit))
+		return mem_cgroup_check_over_limit();
+	return false;
+}
+#else
+static inline bool mem_over_memcg_limit(void)
+{
+	return false;
+}
+#endif
+
 /**
  * is_global_init - check if a task structure is init. Since init
  * is free to have sub-threads we need to check tgid.
diff --git a/kernel/fork.c b/kernel/fork.c
index 4d32190861bd..61f9a9e5f857 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -940,6 +940,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
+	tsk->memcg_over_limit = false;
 #endif
 	return tsk;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1106dac024ac..5cad7bb26d13 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2646,7 +2646,9 @@ static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action)
 	if (!mm)
 		return true;	/* No more check is needed */
 
-	current->memcg_over_limit = false;
+	if (READ_ONCE(current->memcg_over_limit))
+		WRITE_ONCE(current->memcg_over_limit, false);
+
 	if ((action == PR_MEMACT_SIGNAL) && !signal)
 		goto out;
 
@@ -2660,7 +2662,11 @@ static bool __mem_cgroup_over_high_action(struct mem_cgroup *memcg, u8 action)
 		WRITE_ONCE(current->memcg_over_limit, true);
 		break;
 	case PR_MEMACT_SLOWDOWN:
-		/* Slow down by yielding the cpu */
+		/*
+		 * Slow down by yielding the cpu & adding delay to
+		 * memory allocation syscalls.
+		 */
+		WRITE_ONCE(current->memcg_over_limit, true);
 		set_tsk_need_resched(current);
 		set_preempt_need_resched();
 		break;
@@ -2694,6 +2700,21 @@ static inline bool mem_cgroup_over_high_action(struct mem_cgroup *memcg)
 	return __mem_cgroup_over_high_action(memcg, action);
 }
 
+/*
+ * Called from memory allocation syscalls.
+ * Return true if ENOMEM should be returned, false otherwise.
+ */
+bool mem_cgroup_check_over_limit(void)
+{
+	u8 action = READ_ONCE(current->memcg_over_high_action);
+
+	if (action == PR_MEMACT_ENOMEM)
+		return true;
+	if (action == PR_MEMACT_SLOWDOWN)
+		msleep(20);	/* Artificial delay of 20ms */
+	return false;
+}
+
 static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		      unsigned int nr_pages)
 {
diff --git a/mm/mlock.c b/mm/mlock.c
index 93ca2bf30b4f..130d4b3fa0f5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -678,6 +678,9 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	if (!can_do_mlock())
 		return -EPERM;
 
+	if (mem_over_memcg_limit())
+		return -ENOMEM;
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
@@ -807,6 +810,9 @@ SYSCALL_DEFINE1(mlockall, int, flags)
 	if (!can_do_mlock())
 		return -EPERM;
 
+	if (mem_over_memcg_limit())
+		return -ENOMEM;
+
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 40248d84ad5f..873ccf2560a6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -198,6 +198,10 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded = false;
 	LIST_HEAD(uf);
 
+	/* Too much memory used? */
+	if (mem_over_memcg_limit())
+		return -ENOMEM;
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -1407,6 +1411,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
+	/* Too much memory used? */
+	if (mem_over_memcg_limit())
+		return -ENOMEM;
+
 	/* Obtain the address to map to. we verify (or select) it and ensure
 	 * that it represents a valid section of the address space.
 	 */
@@ -1557,6 +1565,10 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 	struct file *file = NULL;
 	unsigned long retval;
 
+	/* Too much memory used? */
+	if (mem_over_memcg_limit())
+		return -ENOMEM;
+
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ce8b8a5eacbb..b2c0f50bb0a0 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -519,6 +519,9 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	const bool rier = (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 
+	if (mem_over_memcg_limit())
+		return -ENOMEM;
+
 	start = untagged_addr(start);
 
 	prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
-- 
2.18.1

