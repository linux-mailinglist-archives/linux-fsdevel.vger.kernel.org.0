Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56581942CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 16:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCZPOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 11:14:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54470 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCZPOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 11:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GVjghs+73ZE0uoY0nOO84b8I5PL35VFkKJplU/sVVw0=; b=cy/p8RH1L2SmDh9MJqPe9pTxDo
        Q4ED8ivsoc1BySyZpWyCIAliqL3AaYDZ0+zfoSoAPk9ROW2LT2JDu505PqTBAx+aivcLDJxCmhhJo
        cW7HTYCPIOa2UFyr2WQG6r1oCIWt6HQ53zTpceN6srjRYtJogZeXVw9+eZySoj8GcbaqLd0+7XJD2
        WWto6AO4lHncvxE8JqgfX/73ZX/scAiAZBxKiQFtQeaB8LFO+VDWSHe3ZTxJg4ac7XRWomiPd1JY0
        TKyeIGDidIiTBGatkh8vvcrF+vCfSF60B6Z2r8YdBzp7FOFPw1ucu1aksbrz6Daufo/3Iw+VqmEHW
        63uB7yTg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHUD6-0007BD-13; Thu, 26 Mar 2020 15:14:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] ipc: Convert ipcs_idr to XArray
Date:   Thu, 26 Mar 2020 08:14:18 -0700
Message-Id: <20200326151418.27545-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The XArray has better loops than the IDR has, removing the need to
open-code them.  We also don't need to call idr_destroy() any more.
Allocating the ID is a little tricky due to needing to get 'seq'
correct.  Open-code a variant of __xa_alloc() which lets us set the
ID and the seq before depositing the pointer in the array.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/linux/ipc_namespace.h |  10 +-
 include/linux/xarray.h        |   1 +
 ipc/ipc_sysctl.c              |  14 +--
 ipc/msg.c                     |   1 -
 ipc/namespace.c               |  13 +--
 ipc/sem.c                     |   1 -
 ipc/shm.c                     |  60 +++++------
 ipc/util.c                    | 181 +++++++++++++++++-----------------
 ipc/util.h                    |   4 +-
 lib/xarray.c                  |   2 +-
 10 files changed, 135 insertions(+), 152 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index c309f43bde45..bdc39cc4d1dc 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -3,13 +3,13 @@
 #define __IPC_NAMESPACE_H__
 
 #include <linux/err.h>
-#include <linux/idr.h>
-#include <linux/rwsem.h>
 #include <linux/notifier.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
+#include <linux/rwsem.h>
+#include <linux/xarray.h>
 
 struct user_namespace;
 
@@ -17,11 +17,11 @@ struct ipc_ids {
 	int in_use;
 	unsigned short seq;
 	struct rw_semaphore rwsem;
-	struct idr ipcs_idr;
+	struct xarray ipcs;
 	int max_idx;
-	int last_idx;	/* For wrap around detection */
+	int next_idx;
 #ifdef CONFIG_CHECKPOINT_RESTORE
-	int next_id;
+	int restore_id;
 #endif
 	struct rhashtable key_ht;
 };
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 14c893433139..d79b8e3aa08d 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1501,6 +1501,7 @@ void *xas_find_marked(struct xa_state *, unsigned long max, xa_mark_t);
 void xas_init_marks(const struct xa_state *);
 
 bool xas_nomem(struct xa_state *, gfp_t);
+bool __xas_nomem(struct xa_state *, gfp_t);
 void xas_pause(struct xa_state *);
 
 void xas_create_range(struct xa_state *);
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index affd66537e87..a2df5d0e27f6 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -115,7 +115,7 @@ static int proc_ipc_sem_dointvec(struct ctl_table *table, int write,
 
 int ipc_mni = IPCMNI;
 int ipc_mni_shift = IPCMNI_SHIFT;
-int ipc_min_cycle = RADIX_TREE_MAP_SIZE;
+int ipc_min_cycle = XA_CHUNK_SIZE;
 
 static struct ctl_table ipc_kern_table[] = {
 	{
@@ -196,8 +196,8 @@ static struct ctl_table ipc_kern_table[] = {
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	{
 		.procname	= "sem_next_id",
-		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
+		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].restore_id,
+		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].restore_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
@@ -205,8 +205,8 @@ static struct ctl_table ipc_kern_table[] = {
 	},
 	{
 		.procname	= "msg_next_id",
-		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
+		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].restore_id,
+		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].restore_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
@@ -214,8 +214,8 @@ static struct ctl_table ipc_kern_table[] = {
 	},
 	{
 		.procname	= "shm_next_id",
-		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
-		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
+		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].restore_id,
+		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].restore_id),
 		.mode		= 0644,
 		.proc_handler	= proc_ipc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
diff --git a/ipc/msg.c b/ipc/msg.c
index caca67368cb5..0c4fdc2f5c08 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1308,7 +1308,6 @@ void msg_init_ns(struct ipc_namespace *ns)
 void msg_exit_ns(struct ipc_namespace *ns)
 {
 	free_ipcs(ns, &msg_ids(ns), freeque);
-	idr_destroy(&ns->ids[IPC_MSG_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_MSG_IDS].key_ht);
 }
 #endif
diff --git a/ipc/namespace.c b/ipc/namespace.c
index b3ca1476ca51..e8567c3d32e9 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -96,22 +96,17 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
 	       void (*free)(struct ipc_namespace *, struct kern_ipc_perm *))
 {
 	struct kern_ipc_perm *perm;
-	int next_id;
-	int total, in_use;
+	unsigned long index;
 
 	down_write(&ids->rwsem);
 
-	in_use = ids->in_use;
-
-	for (total = 0, next_id = 0; total < in_use; next_id++) {
-		perm = idr_find(&ids->ipcs_idr, next_id);
-		if (perm == NULL)
-			continue;
+	xa_for_each(&ids->ipcs, index, perm) {
 		rcu_read_lock();
 		ipc_lock_object(perm);
 		free(ns, perm);
-		total++;
 	}
+	BUG_ON(!xa_empty(&ids->ipcs));
+
 	up_write(&ids->rwsem);
 }
 
diff --git a/ipc/sem.c b/ipc/sem.c
index 3687b71151b3..8d6550ac035a 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -258,7 +258,6 @@ void sem_init_ns(struct ipc_namespace *ns)
 void sem_exit_ns(struct ipc_namespace *ns)
 {
 	free_ipcs(ns, &sem_ids(ns), freeary);
-	idr_destroy(&ns->ids[IPC_SEM_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_SEM_IDS].key_ht);
 }
 #endif
diff --git a/ipc/shm.c b/ipc/shm.c
index ce1ca9f7c6e9..49a8e088e0de 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -129,7 +129,6 @@ static void do_shm_rmid(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
 void shm_exit_ns(struct ipc_namespace *ns)
 {
 	free_ipcs(ns, &shm_ids(ns), do_shm_rmid);
-	idr_destroy(&ns->ids[IPC_SHM_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_SHM_IDS].key_ht);
 }
 #endif
@@ -348,34 +347,30 @@ static void shm_close(struct vm_area_struct *vma)
 	up_write(&shm_ids(ns).rwsem);
 }
 
-/* Called with ns->shm_ids(ns).rwsem locked */
-static int shm_try_destroy_orphaned(int id, void *p, void *data)
+void shm_destroy_orphaned(struct ipc_namespace *ns)
 {
-	struct ipc_namespace *ns = data;
-	struct kern_ipc_perm *ipcp = p;
-	struct shmid_kernel *shp = container_of(ipcp, struct shmid_kernel, shm_perm);
+	struct kern_ipc_perm *ipcp;
+	unsigned long index;
 
-	/*
-	 * We want to destroy segments without users and with already
-	 * exit'ed originating process.
-	 *
-	 * As shp->* are changed under rwsem, it's safe to skip shp locking.
-	 */
-	if (shp->shm_creator != NULL)
-		return 0;
+	down_write(&shm_ids(ns).rwsem);
+	xa_for_each(&shm_ids(ns).ipcs, index, ipcp) {
+		struct shmid_kernel *shp;
 
-	if (shm_may_destroy(ns, shp)) {
-		shm_lock_by_ptr(shp);
-		shm_destroy(ns, shp);
-	}
-	return 0;
-}
+		shp = container_of(ipcp, struct shmid_kernel, shm_perm);
 
-void shm_destroy_orphaned(struct ipc_namespace *ns)
-{
-	down_write(&shm_ids(ns).rwsem);
-	if (shm_ids(ns).in_use)
-		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
+		/*
+		 * We want to destroy segments without users and with already
+		 * exit'ed originating process.  As shp->* are changed under
+		 * rwsem, it's safe to skip shp locking.
+		 */
+		if (shp->shm_creator != NULL)
+			continue;
+
+		if (shm_may_destroy(ns, shp)) {
+			shm_lock_by_ptr(shp);
+			shm_destroy(ns, shp);
+		}
+	}
 	up_write(&shm_ids(ns).rwsem);
 }
 
@@ -860,26 +855,17 @@ static void shm_add_rss_swap(struct shmid_kernel *shp,
 static void shm_get_stat(struct ipc_namespace *ns, unsigned long *rss,
 		unsigned long *swp)
 {
-	int next_id;
-	int total, in_use;
+	struct kern_ipc_perm *ipc;
+	unsigned long index;
 
 	*rss = 0;
 	*swp = 0;
 
-	in_use = shm_ids(ns).in_use;
-
-	for (total = 0, next_id = 0; total < in_use; next_id++) {
-		struct kern_ipc_perm *ipc;
+	xa_for_each(&shm_ids(ns).ipcs, index, ipc) {
 		struct shmid_kernel *shp;
 
-		ipc = idr_find(&shm_ids(ns).ipcs_idr, next_id);
-		if (ipc == NULL)
-			continue;
 		shp = container_of(ipc, struct shmid_kernel, shm_perm);
-
 		shm_add_rss_swap(shp, rss, swp);
-
-		total++;
 	}
 }
 
diff --git a/ipc/util.c b/ipc/util.c
index 7acccfded7cb..723dc4b05208 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -104,12 +104,20 @@ static const struct rhashtable_params ipc_kht_params = {
 	.automatic_shrinking	= true,
 };
 
+#ifdef CONFIG_CHECKPOINT_RESTORE
+#define set_restore_id(ids, x)	ids->restore_id = x
+#define get_restore_id(ids)	ids->restore_id
+#else
+#define set_restore_id(ids, x)	do { } while (0)
+#define get_restore_id(ids)	(-1)
+#endif
+
 /**
  * ipc_init_ids	- initialise ipc identifiers
  * @ids: ipc identifier set
  *
  * Set up the sequence range to use for the ipc identifier range (limited
- * below ipc_mni) then initialise the keys hashtable and ids idr.
+ * below ipc_mni) then initialise the keys hashtable and ids xarray.
  */
 void ipc_init_ids(struct ipc_ids *ids)
 {
@@ -117,12 +125,10 @@ void ipc_init_ids(struct ipc_ids *ids)
 	ids->seq = 0;
 	init_rwsem(&ids->rwsem);
 	rhashtable_init(&ids->key_ht, &ipc_kht_params);
-	idr_init(&ids->ipcs_idr);
+	xa_init_flags(&ids->ipcs, XA_FLAGS_ALLOC);
 	ids->max_idx = -1;
-	ids->last_idx = -1;
-#ifdef CONFIG_CHECKPOINT_RESTORE
-	ids->next_id = -1;
-#endif
+	ids->next_idx = 0;
+	set_restore_id(ids, -1);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -183,12 +189,12 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 }
 
 /*
- * Insert new IPC object into idr tree, and set sequence number and id
+ * Insert new IPC object into xarray, and set sequence number and id
  * in the correct order.
  * Especially:
- * - the sequence number must be set before inserting the object into the idr,
- *   because the sequence number is accessed without a lock.
- * - the id can/must be set after inserting the object into the idr.
+ * - the sequence number must be set before inserting the object into the
+ *   xarray, because the sequence number is accessed without a lock.
+ * - the id can/must be set after inserting the object into the xarray.
  *   All accesses must be done after getting kern_ipc_perm.lock.
  *
  * The caller must own kern_ipc_perm.lock.of the new object.
@@ -198,64 +204,60 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
  * the sequence number is incremented only when the returned ID is less than
  * the last one.
  */
-static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
+static inline int ipc_id_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
-	int idx, next_id = -1;
+	u32 idx;
+	int err;
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
-	next_id = ids->next_id;
-	ids->next_id = -1;
-#endif
+	if (get_restore_id(ids) < 0) {
+		XA_STATE(xas, &ids->ipcs, 0);
+		int min_idx, max_idx;
 
-	/*
-	 * As soon as a new object is inserted into the idr,
-	 * ipc_obtain_object_idr() or ipc_obtain_object_check() can find it,
-	 * and the lockless preparations for ipc operations can start.
-	 * This means especially: permission checks, audit calls, allocation
-	 * of undo structures, ...
-	 *
-	 * Thus the object must be fully initialized, and if something fails,
-	 * then the full tear-down sequence must be followed.
-	 * (i.e.: set new->deleted, reduce refcount, call_rcu())
-	 */
+		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
+		max_idx = min(max_idx, ipc_mni) - 1;
 
-	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
-		int max_idx;
+		xas_lock(&xas);
 
-		max_idx = max(ids->in_use*3/2, ipc_min_cycle);
-		max_idx = min(max_idx, ipc_mni);
-
-		/* allocate the idx, with a NULL struct kern_ipc_perm */
-		idx = idr_alloc_cyclic(&ids->ipcs_idr, NULL, 0, max_idx,
-					GFP_NOWAIT);
-
-		if (idx >= 0) {
-			/*
-			 * idx got allocated successfully.
-			 * Now calculate the sequence number and set the
-			 * pointer for real.
-			 */
-			if (idx <= ids->last_idx) {
+		min_idx = ids->next_idx;
+		new->seq = ids->seq;
+
+		/* Modified version of __xa_alloc */
+		do {
+			xas.xa_index = min_idx;
+			xas_find_marked(&xas, max_idx, XA_FREE_MARK);
+			if (xas.xa_node == XAS_RESTART && min_idx > 0) {
 				ids->seq++;
 				if (ids->seq >= ipcid_seq_max())
 					ids->seq = 0;
+				new->seq = ids->seq;
+				xas.xa_index = 0;
+				min_idx = 0;
+				xas_find_marked(&xas, max_idx, XA_FREE_MARK);
 			}
-			ids->last_idx = idx;
-
-			new->seq = ids->seq;
-			/* no need for smp_wmb(), this is done
-			 * inside idr_replace, as part of
-			 * rcu_assign_pointer
-			 */
-			idr_replace(&ids->ipcs_idr, new, idx);
-		}
+			if (xas.xa_node == XAS_RESTART)
+				xas_set_err(&xas, -ENOSPC);
+			else
+				new->id = (new->seq << ipcmni_seq_shift()) +
+					xas.xa_index;
+			xas_store(&xas, new);
+			xas_clear_mark(&xas, XA_FREE_MARK);
+		} while (__xas_nomem(&xas, GFP_KERNEL));
+
+		xas_unlock(&xas);
+		err = xas_error(&xas);
+		idx = xas.xa_index;
 	} else {
-		new->seq = ipcid_to_seqx(next_id);
-		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-				0, GFP_NOWAIT);
+		new->id = get_restore_id(ids);
+		new->seq = ipcid_to_seqx(new->id);
+		idx = ipcid_to_idx(new->id);
+		err = xa_insert(&ids->ipcs, idx, new, GFP_KERNEL);
+		if (err == -EBUSY)
+			err = -ENOSPC;
+		set_restore_id(ids, -1);
 	}
-	if (idx >= 0)
-		new->id = (new->seq << ipcmni_seq_shift()) + idx;
+
+	if (err < 0)
+		return err;
 	return idx;
 }
 
@@ -278,7 +280,7 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 {
 	kuid_t euid;
 	kgid_t egid;
-	int idx, err;
+	int idx;
 
 	/* 1) Initialize the refcount so that ipc_rcu_putref works */
 	refcount_set(&new->refcount, 1);
@@ -289,29 +291,42 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (ids->in_use >= limit)
 		return -ENOSPC;
 
-	idr_preload(GFP_KERNEL);
-
+	/*
+	 * 2) Hold the spinlock so that nobody else can access the object
+	 * once they can find it
+	 */
 	spin_lock_init(&new->lock);
-	rcu_read_lock();
 	spin_lock(&new->lock);
-
 	current_euid_egid(&euid, &egid);
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
-
 	new->deleted = false;
 
-	idx = ipc_idr_alloc(ids, new);
-	idr_preload_end();
+	idx = ipc_id_alloc(ids, new);
+
+	rcu_read_lock();
+
+	/*
+	 * As soon as a new object is inserted into the XArray,
+	 * ipc_obtain_object_idr() or ipc_obtain_object_check() can find it,
+	 * and the lockless preparations for ipc operations can start.
+	 * This means especially: permission checks, audit calls, allocation
+	 * of undo structures, ...
+	 *
+	 * Thus the object must be fully initialized, and if something fails,
+	 * then the full tear-down sequence must be followed.
+	 * (i.e.: set new->deleted, reduce refcount, call_rcu())
+	 */
 
 	if (idx >= 0 && new->key != IPC_PRIVATE) {
-		err = rhashtable_insert_fast(&ids->key_ht, &new->khtnode,
+		int err = rhashtable_insert_fast(&ids->key_ht, &new->khtnode,
 					     ipc_kht_params);
 		if (err < 0) {
-			idr_remove(&ids->ipcs_idr, idx);
+			xa_erase(&ids->ipcs, idx);
 			idx = err;
 		}
 	}
+
 	if (idx < 0) {
 		new->deleted = true;
 		spin_unlock(&new->lock);
@@ -462,7 +477,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 {
 	int idx = ipcid_to_idx(ipcp->id);
 
-	idr_remove(&ids->ipcs_idr, idx);
+	xa_erase(&ids->ipcs, idx);
 	ipc_kht_remove(ids, ipcp);
 	ids->in_use--;
 	ipcp->deleted = true;
@@ -472,7 +487,7 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 			idx--;
 			if (idx == -1)
 				break;
-		} while (!idr_find(&ids->ipcs_idr, idx));
+		} while (!xa_load(&ids->ipcs, idx));
 		ids->max_idx = idx;
 	}
 }
@@ -595,7 +610,7 @@ struct kern_ipc_perm *ipc_obtain_object_idr(struct ipc_ids *ids, int id)
 	struct kern_ipc_perm *out;
 	int idx = ipcid_to_idx(id);
 
-	out = idr_find(&ids->ipcs_idr, idx);
+	out = xa_load(&ids->ipcs, idx);
 	if (!out)
 		return ERR_PTR(-EINVAL);
 
@@ -754,31 +769,19 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
+	unsigned long index = pos;
 	struct kern_ipc_perm *ipc;
-	int total, id;
-
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
 
 	*new_pos = pos + 1;
-	if (total >= ids->in_use)
+	rcu_read_lock();
+	ipc = xa_find(&ids->ipcs, &index, ULONG_MAX, XA_PRESENT);
+	if (!ipc) {
+		rcu_read_unlock();
 		return NULL;
-
-	for (; pos < ipc_mni; pos++) {
-		ipc = idr_find(&ids->ipcs_idr, pos);
-		if (ipc != NULL) {
-			rcu_read_lock();
-			ipc_lock_object(ipc);
-			return ipc;
-		}
 	}
 
-	/* Out of range - return NULL to terminate iteration */
-	return NULL;
+	ipc_lock_object(ipc);
+	return ipc;
 }
 
 static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
diff --git a/ipc/util.h b/ipc/util.h
index 5766c61aed0e..04d49db4cefa 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -27,7 +27,7 @@
  */
 #define IPCMNI_SHIFT		15
 #define IPCMNI_EXTEND_SHIFT	24
-#define IPCMNI_EXTEND_MIN_CYCLE	(RADIX_TREE_MAP_SIZE * RADIX_TREE_MAP_SIZE)
+#define IPCMNI_EXTEND_MIN_CYCLE	(XA_CHUNK_SIZE * XA_CHUNK_SIZE)
 #define IPCMNI			(1 << IPCMNI_SHIFT)
 #define IPCMNI_EXTEND		(1 << IPCMNI_EXTEND_SHIFT)
 
@@ -42,7 +42,7 @@ extern int ipc_min_cycle;
 #else /* CONFIG_SYSVIPC_SYSCTL */
 
 #define ipc_mni			IPCMNI
-#define ipc_min_cycle		((int)RADIX_TREE_MAP_SIZE)
+#define ipc_min_cycle		((int)XA_CHUNK_SIZE)
 #define ipcmni_seq_shift()	IPCMNI_SHIFT
 #define IPCMNI_IDX_MASK		((1 << IPCMNI_SHIFT) - 1)
 #endif /* CONFIG_SYSVIPC_SYSCTL */
diff --git a/lib/xarray.c b/lib/xarray.c
index e9e641d3c0c3..8488fb4eff2e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -319,7 +319,7 @@ EXPORT_SYMBOL_GPL(xas_nomem);
  *
  * Return: true if memory was needed, and was successfully allocated.
  */
-static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
+bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 	__must_hold(xas->xa->xa_lock)
 {
 	unsigned int lock_type = xa_lock_type(xas->xa);

base-commit: 5149100c3aebe5e640d6ff68e0b5e5a7eb8638e0
-- 
2.25.1

