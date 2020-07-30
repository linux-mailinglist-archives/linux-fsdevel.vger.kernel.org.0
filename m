Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AAE233167
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgG3MAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:56686 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728141AbgG3MAM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:12 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17E2-0002xD-Pn; Thu, 30 Jul 2020 14:59:54 +0300
Subject: [PATCH 09/23] ns: Introduce ns_idr to be able to iterate all
 allocated namespaces in the system
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:08 +0300
Message-ID: <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new IDR and functions to add/remove and iterate
registered namespaces in the system. It will be used to list namespaces
in /proc/namespaces/... in next patches.

The IDR is protected by ns_idr, and it's choosen to be a spinlock (not
mutex) to allow calling ns_idr_unregister() from put_xxx_ns() methods,
which may be called from (say) softirq context. Spinlock allows us
to avoid introduction of kwork on top of put_xxx_ns() to call mutex_lock().

We introduce a new IDR, because there is no appropriate items to reuse
instead of this. The closest proc_inum_ida does not fit our goals:
it is IDA and its convertation to IDR will bring a big overhead by proc
entries, which are not interested in IDR functionality (pointers).

Read access to ns_idr is made lockless (see ns_get_next()). This is made
for better parallelism and better performance from start. One new requirement
to do this is that namespace memory must be freed one RCU grace period
after ns_idr_unregister(). Some namespaces types already does this (say, net),
the rest will be converted to use kfree_rcu()/etc, where they become
linked to the IDR. See next patches in this series for the details.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/nsfs.c                 |   76 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ns_common.h |   10 ++++++
 include/linux/proc_ns.h   |   11 ++++---
 3 files changed, 92 insertions(+), 5 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 800c1d0eb0d0..ee4be67d3a0b 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -11,10 +11,13 @@
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <linux/idr.h>
 
 #include "internal.h"
 
 static struct vfsmount *nsfs_mnt;
+static DEFINE_SPINLOCK(ns_lock);
+static DEFINE_IDR(ns_idr);
 
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg);
@@ -304,3 +307,76 @@ void __init nsfs_init(void)
 		panic("can't set nsfs up\n");
 	nsfs_mnt->mnt_sb->s_flags &= ~SB_NOUSER;
 }
+
+/*
+ * Add a newly created ns to ns_idr. The ns must be fully
+ * initialized since it becomes available for ns_get_next()
+ * right after we exit this function.
+ */
+int ns_idr_register(struct ns_common *ns)
+{
+	int ret, id = ns->inum - PROC_NS_MIN_INO;
+
+	if (WARN_ON(id < 0))
+		return -EINVAL;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock_irq(&ns_lock);
+	ret = idr_alloc(&ns_idr, ns, id, id + 1, GFP_ATOMIC);
+	spin_unlock_irq(&ns_lock);
+	idr_preload_end();
+
+	return ret < 0 ? ret : 0;
+}
+
+/*
+ * Remove a dead ns from ns_idr. Note, that ns memory must
+ * be freed not earlier then one RCU grace period after
+ * this function, since ns_get_next() uses RCU to iterate the IDR.
+ */
+void ns_idr_unregister(struct ns_common *ns)
+{
+	int id = ns->inum - PROC_NS_MIN_INO;
+	unsigned long flags;
+
+	if (WARN_ON(id < 0))
+		return;
+
+	spin_lock_irqsave(&ns_lock, flags);
+	idr_remove(&ns_idr, id);
+	spin_unlock_irqrestore(&ns_lock, flags);
+}
+
+/*
+ * This returns ns with inum greater than @id or NULL.
+ * @id is updated to refer the ns inum.
+ */
+struct ns_common *ns_get_next(unsigned int *id)
+{
+	struct ns_common *ns;
+
+	if (*id < PROC_NS_MIN_INO - 1)
+		*id = PROC_NS_MIN_INO - 1;
+
+	*id += 1;
+	*id -= PROC_NS_MIN_INO;
+
+	rcu_read_lock();
+	do {
+		ns = idr_get_next(&ns_idr, id);
+		if (!ns)
+			break;
+		if (!refcount_inc_not_zero(&ns->count)) {
+			ns = NULL;
+			*id += 1;
+		}
+	} while (!ns);
+	rcu_read_unlock();
+
+	if (ns) {
+		*id += PROC_NS_MIN_INO;
+		WARN_ON(*id != ns->inum);
+	}
+
+	return ns;
+}
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 27db02ebdf36..5f460e97151a 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -4,6 +4,12 @@
 
 struct proc_ns_operations;
 
+/*
+ * Common part of all namespaces. Note, that we link namespaces
+ * into IDR, and they are dereferenced via RCU. So, a namespace
+ * memory is allowed to be freed one RCU grace period after final
+ * .count put. See ns_get_next() for the details.
+ */
 struct ns_common {
 	atomic_long_t stashed;
 	const struct proc_ns_operations *ops;
@@ -11,4 +17,8 @@ struct ns_common {
 	refcount_t count;
 };
 
+extern int ns_idr_register(struct ns_common *ns);
+extern void ns_idr_unregister(struct ns_common *ns);
+extern struct ns_common *ns_get_next(unsigned int *id);
+
 #endif
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880..906e6ebb43e4 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -40,12 +40,13 @@ extern const struct proc_ns_operations timens_for_children_operations;
  */
 enum {
 	PROC_ROOT_INO		= 1,
-	PROC_IPC_INIT_INO	= 0xEFFFFFFFU,
-	PROC_UTS_INIT_INO	= 0xEFFFFFFEU,
-	PROC_USER_INIT_INO	= 0xEFFFFFFDU,
-	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
-	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
 	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
+	PROC_NS_MIN_INO		= PROC_TIME_INIT_INO,
+	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
+	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
+	PROC_USER_INIT_INO	= 0xEFFFFFFDU,
+	PROC_UTS_INIT_INO	= 0xEFFFFFFEU,
+	PROC_IPC_INIT_INO	= 0xEFFFFFFFU,
 };
 
 #ifdef CONFIG_PROC_FS


