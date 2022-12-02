Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C450640BEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 18:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbiLBRSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiLBRSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:18:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E166E51E4
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Dec 2022 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670001381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLnLNVhg+V2QM+5uaqJbdcO5eHog3WerK+Tm3KrAKi4=;
        b=eIHROJdcmHFaoi3boaR0M/7yPg2yY5yTVrunSxMH77htVvOHyj2cr/D0AjkDggT4HWCuTP
        DRewggEz9JfEnoo9jcwFKw0Nyqlvt2SnaSnrKxPccisBntsOs3Nvgj0z0xc5r9ktpQHfMH
        If5M5iBfFGbBbkgLSVM3Oq3todZhGFQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-uXxH9e1cPB2HTGHGtZO37g-1; Fri, 02 Dec 2022 12:16:17 -0500
X-MC-Unique: uXxH9e1cPB2HTGHGtZO37g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F09FC882828;
        Fri,  2 Dec 2022 17:16:15 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA86140C94AA;
        Fri,  2 Dec 2022 17:16:15 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ikent@redhat.com, onestero@redhat.com, willy@infradead.org,
        ebiederm@redhat.com
Subject: [PATCH v3 3/5] pid: switch pid_namespace from idr to xarray
Date:   Fri,  2 Dec 2022 12:16:18 -0500
Message-Id: <20221202171620.509140-4-bfoster@redhat.com>
In-Reply-To: <20221202171620.509140-1-bfoster@redhat.com>
References: <20221202171620.509140-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch struct pid[_namespace] management over to use the xarray api
directly instead of the idr. The underlying data structures used by
both interfaces is the same. The difference is that the idr api
relies on the old, idr-custom radix-tree implementation for things
like efficient tracking/allocation of free ids. The xarray already
supports this, so most of this is a direct switchover from the old
api to the new.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 include/linux/pid_namespace.h |  8 ++--
 include/linux/threads.h       |  2 +-
 init/main.c                   |  3 +-
 kernel/pid.c                  | 78 ++++++++++++++++-------------------
 kernel/pid_namespace.c        | 19 ++++-----
 5 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 82c72482019d..e4f5979b482b 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -9,7 +9,7 @@
 #include <linux/threads.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 
 /* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
 #define MAX_PID_NS_LEVEL 32
@@ -17,7 +17,7 @@
 struct fs_pin;
 
 struct pid_namespace {
-	struct idr idr;
+	struct xarray xa;
 	unsigned int pid_next;
 	struct rcu_head rcu;
 	unsigned int pid_allocated;
@@ -38,6 +38,8 @@ extern struct pid_namespace init_pid_ns;
 
 #define PIDNS_ADDING (1U << 31)
 
+#define PID_XA_FLAGS	(XA_FLAGS_TRACK_FREE | XA_FLAGS_LOCK_IRQ)
+
 #ifdef CONFIG_PID_NS
 static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 {
@@ -85,7 +87,7 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
-void pid_idr_init(void);
+void pid_init(void);
 
 static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
 {
diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f1..37e4391ee89f 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -38,7 +38,7 @@
  * Define a minimum number of pids per cpu.  Heuristically based
  * on original pid max of 32k for 32 cpus.  Also, increase the
  * minimum settable value for pid_max on the running system based
- * on similar defaults.  See kernel/pid.c:pid_idr_init() for details.
+ * on similar defaults.  See kernel/pid.c:pid_init() for details.
  */
 #define PIDS_PER_CPU_DEFAULT	1024
 #define PIDS_PER_CPU_MIN	8
diff --git a/init/main.c b/init/main.c
index aa21add5f7c5..7dd8888036c7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -74,7 +74,6 @@
 #include <linux/sched.h>
 #include <linux/sched/init.h>
 #include <linux/signal.h>
-#include <linux/idr.h>
 #include <linux/kgdb.h>
 #include <linux/ftrace.h>
 #include <linux/async.h>
@@ -1108,7 +1107,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 		late_time_init();
 	sched_clock_init();
 	calibrate_delay();
-	pid_idr_init();
+	pid_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
diff --git a/kernel/pid.c b/kernel/pid.c
index 2e2d33273c8e..53db06f9882d 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -41,7 +41,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 
@@ -66,15 +66,9 @@ int pid_max = PID_MAX_DEFAULT;
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
 
-/*
- * PID-map pages start out as NULL, they get allocated upon
- * first use and are never deallocated. This way a low pid_max
- * value does not cause lots of bitmaps to be allocated, but
- * the scheme scales to up to 4 million PIDs, runtime.
- */
 struct pid_namespace init_pid_ns = {
 	.ns.count = REFCOUNT_INIT(2),
-	.idr = IDR_INIT(init_pid_ns.idr),
+	.xa = XARRAY_INIT(init_pid_ns.xa, PID_XA_FLAGS),
 	.pid_next = 0,
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
@@ -118,7 +112,7 @@ void free_pid(struct pid *pid)
 		struct upid *upid = pid->numbers + i;
 		struct pid_namespace *ns = upid->ns;
 
-		xa_lock_irqsave(&ns->idr.idr_rt, flags);
+		xa_lock_irqsave(&ns->xa, flags);
 		switch (--ns->pid_allocated) {
 		case 2:
 		case 1:
@@ -135,8 +129,8 @@ void free_pid(struct pid *pid)
 			break;
 		}
 
-		idr_remove(&ns->idr, upid->nr);
-		xa_unlock_irqrestore(&ns->idr.idr_rt, flags);
+		__xa_erase(&ns->xa, upid->nr);
+		xa_unlock_irqrestore(&ns->xa, flags);
 	}
 
 	call_rcu(&pid->rcu, delayed_put_pid);
@@ -147,7 +141,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 {
 	struct pid *pid;
 	enum pid_type type;
-	int i, nr;
+	int i;
 	struct pid_namespace *tmp;
 	struct upid *upid;
 	int retval = -ENOMEM;
@@ -191,18 +185,17 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			set_tid_size--;
 		}
 
-		idr_preload(GFP_KERNEL);
-		xa_lock_irq(&tmp->idr.idr_rt);
+		xa_lock_irq(&tmp->xa);
 
 		if (tid) {
-			nr = idr_alloc(&tmp->idr, NULL, tid,
-				       tid + 1, GFP_ATOMIC);
+			retval = __xa_insert(&tmp->xa, tid, NULL, GFP_KERNEL);
+
 			/*
-			 * If ENOSPC is returned it means that the PID is
-			 * alreay in use. Return EEXIST in that case.
+			 * If EBUSY is returned it means that the PID is already
+			 * in use. Return EEXIST in that case.
 			 */
-			if (nr == -ENOSPC)
-				nr = -EEXIST;
+			if (retval == -EBUSY)
+				retval = -EEXIST;
 		} else {
 			int pid_min = 1;
 			/*
@@ -216,19 +209,18 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 * Store a null pointer so find_pid_ns does not find
 			 * a partially initialized PID (see below).
 			 */
-			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-					      pid_max, GFP_ATOMIC);
-			tmp->pid_next = nr + 1;
+			retval = __xa_alloc_cyclic(&tmp->xa, &tid, NULL,
+					XA_LIMIT(pid_min, pid_max),
+					&tmp->pid_next, GFP_KERNEL);
+			if (retval == -EBUSY)
+				retval = -EAGAIN;
 		}
-		xa_unlock_irq(&tmp->idr.idr_rt);
-		idr_preload_end();
+		xa_unlock_irq(&tmp->xa);
 
-		if (nr < 0) {
-			retval = (nr == -ENOSPC) ? -EAGAIN : nr;
+		if (retval < 0)
 			goto out_free;
-		}
 
-		pid->numbers[i].nr = nr;
+		pid->numbers[i].nr = tid;
 		pid->numbers[i].ns = tmp;
 		tmp = tmp->parent;
 	}
@@ -256,17 +248,17 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	for ( ; upid >= pid->numbers; --upid) {
 		tmp = upid->ns;
 
-		xa_lock_irq(&tmp->idr.idr_rt);
+		xa_lock_irq(&tmp->xa);
 		if (tmp == ns && !(tmp->pid_allocated & PIDNS_ADDING)) {
-			xa_unlock_irq(&tmp->idr.idr_rt);
+			xa_unlock_irq(&tmp->xa);
 			put_pid_ns(ns);
 			goto out_free;
 		}
 
 		/* Make the PID visible to find_pid_ns. */
-		idr_replace(&tmp->idr, pid, upid->nr);
+		__xa_store(&tmp->xa, upid->nr, pid, 0);
 		tmp->pid_allocated++;
-		xa_unlock_irq(&tmp->idr.idr_rt);
+		xa_unlock_irq(&tmp->xa);
 	}
 
 	return pid;
@@ -276,14 +268,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 		upid = pid->numbers + i;
 		tmp = upid->ns;
 
-		xa_lock_irq(&tmp->idr.idr_rt);
+		xa_lock_irq(&tmp->xa);
 
 		/* On failure to allocate the first pid, reset the state */
 		if (tmp == ns && tmp->pid_allocated == PIDNS_ADDING)
 			ns->pid_next = 0;
 
-		idr_remove(&tmp->idr, upid->nr);
-		xa_unlock_irq(&tmp->idr.idr_rt);
+		__xa_erase(&tmp->xa, upid->nr);
+		xa_unlock_irq(&tmp->xa);
 	}
 
 	kmem_cache_free(ns->pid_cachep, pid);
@@ -292,14 +284,14 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 void disable_pid_allocation(struct pid_namespace *ns)
 {
-	xa_lock_irq(&ns->idr.idr_rt);
+	xa_lock_irq(&ns->xa);
 	ns->pid_allocated &= ~PIDNS_ADDING;
-	xa_unlock_irq(&ns->idr.idr_rt);
+	xa_unlock_irq(&ns->xa);
 }
 
 struct pid *find_pid_ns(int nr, struct pid_namespace *ns)
 {
-	return idr_find(&ns->idr, nr);
+	return xa_load(&ns->xa, nr);
 }
 EXPORT_SYMBOL_GPL(find_pid_ns);
 
@@ -508,7 +500,9 @@ EXPORT_SYMBOL_GPL(task_active_pid_ns);
  */
 struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
 {
-	return idr_get_next(&ns->idr, &nr);
+	unsigned long index = nr;
+
+	return xa_find(&ns->xa, &index, ULONG_MAX, XA_PRESENT);
 }
 EXPORT_SYMBOL_GPL(find_ge_pid);
 
@@ -650,7 +644,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
  * take it we can leave the interrupts enabled.  For now it is easier to be safe
  * than to prove it can't happen.
  */
-void __init pid_idr_init(void)
+void __init pid_init(void)
 {
 	/* Verify no one has done anything silly: */
 	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
@@ -662,8 +656,6 @@ void __init pid_idr_init(void)
 				PIDS_PER_CPU_MIN * num_possible_cpus());
 	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
 
-	idr_init(&init_pid_ns.idr);
-
 	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 }
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a53d20c5c85e..8561e01e2d01 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -22,7 +22,7 @@
 #include <linux/export.h>
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 
 static DEFINE_MUTEX(pid_caches_mutex);
 static struct kmem_cache *pid_ns_cachep;
@@ -92,15 +92,15 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	if (ns == NULL)
 		goto out_dec;
 
-	idr_init(&ns->idr);
+	xa_init_flags(&ns->xa, PID_XA_FLAGS);
 
 	ns->pid_cachep = create_pid_cachep(level);
 	if (ns->pid_cachep == NULL)
-		goto out_free_idr;
+		goto out_free_xa;
 
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto out_free_idr;
+		goto out_free_xa;
 	ns->ns.ops = &pidns_operations;
 
 	refcount_set(&ns->ns.count, 1);
@@ -112,8 +112,8 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 
 	return ns;
 
-out_free_idr:
-	idr_destroy(&ns->idr);
+out_free_xa:
+	xa_destroy(&ns->xa);
 	kmem_cache_free(pid_ns_cachep, ns);
 out_dec:
 	dec_pid_namespaces(ucounts);
@@ -135,7 +135,7 @@ static void destroy_pid_namespace(struct pid_namespace *ns)
 {
 	ns_free_inum(&ns->ns);
 
-	idr_destroy(&ns->idr);
+	xa_destroy(&ns->xa);
 	call_rcu(&ns->rcu, delayed_free_pidns);
 }
 
@@ -165,7 +165,7 @@ EXPORT_SYMBOL_GPL(put_pid_ns);
 
 void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 {
-	int nr;
+	long nr;
 	int rc;
 	struct task_struct *task, *me = current;
 	int init_pids = thread_group_leader(me) ? 1 : 2;
@@ -198,8 +198,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 */
 	rcu_read_lock();
 	read_lock(&tasklist_lock);
-	nr = 2;
-	idr_for_each_entry_continue(&pid_ns->idr, pid, nr) {
+	xa_for_each_range(&pid_ns->xa, nr, pid, 2, ULONG_MAX) {
 		task = pid_task(pid, PIDTYPE_PID);
 		if (task && !__fatal_signal_pending(task))
 			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
-- 
2.37.3

