Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA6930FA7E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbhBDR7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 12:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238586AbhBDRtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612460865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ve0tDEMfrp0MWMavBCa77kLxFtfycUxlvNLYbkW5wPA=;
        b=Z9bgCknc2BzOqh8ugOp+Z07CGtS8exgJ0qO7nclLXQ/pe/L0xiWX4AKxnlC8EcEf8hOhqG
        utx0o7RqjAO/c1PfiKENrDKksbKwjsQTcfwmjBH0z0RPPInspXVdhKjZ2ziVdbGFqlMI2r
        JFqjOFEqFbY9uHcScfnYApSLme6GVcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-b2slzYHfNGSQ4FUTvUg60Q-1; Thu, 04 Feb 2021 12:47:44 -0500
X-MC-Unique: b2slzYHfNGSQ4FUTvUg60Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E449107ACE3;
        Thu,  4 Feb 2021 17:47:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-115-23.rdu2.redhat.com [10.10.115.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67DC663C3F;
        Thu,  4 Feb 2021 17:47:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] Add namespace tags that can be used for matching without
 pinning a ns
From:   David Howells <dhowells@redhat.com>
To:     sprabhu@redhat.com
Cc:     dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        christian@brauner.io, selinux@vger.kernel.org,
        keyrings@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Date:   Thu, 04 Feb 2021 17:47:39 +0000
Message-ID: <161246085966.1990927.2555272056564793056.stgit@warthog.procyon.org.uk>
In-Reply-To: <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
References: <161246085160.1990927.13137391845549674518.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a ns tag struct that consists of just a refcount.  It's address can be
used to compare namespaces without the need to pin a namespace.  Just the
tag needs pinning.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/namespace.c            |   18 ++++++++----------
 include/linux/ns_common.h |   23 +++++++++++++++++++++++
 include/linux/proc_ns.h   |   38 +++++++++++++++++++++++++++++++++++---
 init/version.c            |    9 ++++++++-
 ipc/msgutil.c             |    7 ++++++-
 ipc/namespace.c           |    8 +++-----
 kernel/cgroup/cgroup.c    |    5 +++++
 kernel/cgroup/namespace.c |    6 +++---
 kernel/pid.c              |    5 +++++
 kernel/pid_namespace.c    |   18 +++++++++---------
 kernel/time/namespace.c   |   13 +++++--------
 kernel/user.c             |    5 +++++
 kernel/user_namespace.c   |    7 +++----
 kernel/utsname.c          |   24 +++++++++++++-----------
 net/core/net_namespace.c  |   38 +++++++++++++++-----------------------
 15 files changed, 146 insertions(+), 78 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9d33909d0f9e..f8da9be8c6f7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3238,10 +3238,9 @@ static void dec_mnt_namespaces(struct ucounts *ucounts)
 
 static void free_mnt_ns(struct mnt_namespace *ns)
 {
-	if (!is_anon_ns(ns))
-		ns_free_inum(&ns->ns);
 	dec_mnt_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
+	destroy_ns_common(&ns->ns);
 	kfree(ns);
 }
 
@@ -3269,18 +3268,17 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(-ENOMEM);
 	}
-	if (!anon) {
-		ret = ns_alloc_inum(&new_ns->ns);
-		if (ret) {
-			kfree(new_ns);
-			dec_mnt_namespaces(ucounts);
-			return ERR_PTR(ret);
-		}
+
+	ret = init_ns_common(&new_ns->ns, anon);
+	if (ret) {
+		destroy_ns_common(&new_ns->ns);
+		kfree(new_ns);
+		dec_mnt_namespaces(ucounts);
+		return ERR_PTR(ret);
 	}
 	new_ns->ns.ops = &mntns_operations;
 	if (!anon)
 		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
-	refcount_set(&new_ns->ns.count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
 	spin_lock_init(&new_ns->ns_lock);
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..45174ad8a435 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -3,14 +3,37 @@
 #define _LINUX_NS_COMMON_H
 
 #include <linux/refcount.h>
+#include <linux/slab.h>
 
 struct proc_ns_operations;
 
+/*
+ * Comparable tag for namespaces so that namespaces don't have to be pinned by
+ * something that wishes to detect if a namespace matches a criterion.
+ */
+struct ns_tag {
+	refcount_t	usage;
+};
+
 struct ns_common {
 	atomic_long_t stashed;
 	const struct proc_ns_operations *ops;
+	struct ns_tag *tag;
 	unsigned int inum;
 	refcount_t count;
 };
 
+static inline struct ns_tag *get_ns_tag(struct ns_tag *tag)
+{
+	if (tag)
+		refcount_inc(&tag->usage);
+	return tag;
+}
+
+static inline void put_ns_tag(struct ns_tag *tag)
+{
+	if (tag && refcount_dec_and_test(&tag->usage))
+		kfree(tag);
+}
+
 #endif
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 75807ecef880..9fb7eb403923 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -64,13 +64,45 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 #endif /* CONFIG_PROC_FS */
 
-static inline int ns_alloc_inum(struct ns_common *ns)
+/**
+ * init_ns_common - Initialise the common part of a namespace
+ * @ns: The namespace to initialise
+ * @anon: The namespace will be anonymous
+ *
+ * Set up the common part of a namespace, assigning an inode number and
+ * creating a tag.  Returns 0 on success and a negative error code on failure.
+ * On failure, the caller must call destroy_ns_common().
+ */
+static inline int init_ns_common(struct ns_common *ns, bool anon)
 {
+	struct ns_tag *tag;
+
+	tag = kzalloc(sizeof(*tag), GFP_KERNEL);
+	if (!tag)
+		return -ENOMEM;
+
+	refcount_set(&tag->usage, 1);
+	ns->tag = tag;
+	ns->inum = 0;
 	atomic_long_set(&ns->stashed, 0);
-	return proc_alloc_inum(&ns->inum);
+	refcount_set(&ns->count, 1);
+
+	return anon ? 0 : proc_alloc_inum(&ns->inum);
 }
 
-#define ns_free_inum(ns) proc_free_inum((ns)->inum)
+/**
+ * destroy_ns_common - Clean up the common part of a namespace
+ * @ns: The namespace to clean up
+ */
+static inline void destroy_ns_common(struct ns_common *ns)
+{
+	put_ns_tag(ns->tag);
+	ns->tag = NULL;
+	if (ns->inum) {
+		proc_free_inum(ns->inum);
+		ns->inum = 0;
+	}
+}
 
 extern struct file *proc_ns_fget(int fd);
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
diff --git a/init/version.c b/init/version.c
index 80d2b7566b39..3c867b6c4aa4 100644
--- a/init/version.c
+++ b/init/version.c
@@ -24,8 +24,15 @@ extern int version_string(LINUX_VERSION_CODE);
 int version_string(LINUX_VERSION_CODE);
 #endif
 
+static struct ns_tag init_uts_ns_tag = {
+	.usage		= REFCOUNT_INIT(1),
+};
+
 struct uts_namespace init_uts_ns = {
-	.ns.count = REFCOUNT_INIT(2),
+	.ns = {
+		.count		= REFCOUNT_INIT(2),
+		.tag		= &init_uts_ns_tag,
+	},
 	.name = {
 		.sysname	= UTS_SYSNAME,
 		.nodename	= UTS_NODENAME,
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index d0a0e877cadd..62bf194c38c6 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -20,13 +20,18 @@
 
 DEFINE_SPINLOCK(mq_lock);
 
+static struct ns_tag init_ipc_ns_tag = {
+	.usage		= REFCOUNT_INIT(1),
+};
+
 /*
  * The next 2 defines are here bc this is the only file
  * compiled when either CONFIG_SYSVIPC and CONFIG_POSIX_MQUEUE
  * and not CONFIG_IPC_NS.
  */
 struct ipc_namespace init_ipc_ns = {
-	.ns.count = REFCOUNT_INIT(1),
+	.ns.tag	= &init_ipc_ns_tag,
+	.ns.count = REFCOUNT_INIT(2),
 	.user_ns = &init_user_ns,
 	.ns.inum = PROC_IPC_INIT_INO,
 #ifdef CONFIG_IPC_NS
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 7bd0766ddc3b..06c0829ab866 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -46,12 +46,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (ns == NULL)
 		goto fail_dec;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = init_ns_common(&ns->ns, false);
 	if (err)
 		goto fail_free;
 	ns->ns.ops = &ipcns_operations;
-
-	refcount_set(&ns->ns.count, 1);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
@@ -67,8 +65,8 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 fail_put:
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
 fail_free:
+	destroy_ns_common(&ns->ns);
 	kfree(ns);
 fail_dec:
 	dec_ipc_namespaces(ucounts);
@@ -127,7 +125,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 
 	dec_ipc_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	destroy_ns_common(&ns->ns);
 	kfree(ns);
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 613845769103..fb397fa2386f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -197,8 +197,13 @@ static u16 have_exit_callback __read_mostly;
 static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
+static struct ns_tag init_cgroup_ns_tag = {
+	.usage		= REFCOUNT_INIT(1),
+};
+
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
+	.ns.tag		= &init_cgroup_ns_tag,
 	.ns.count	= REFCOUNT_INIT(2),
 	.user_ns	= &init_user_ns,
 	.ns.ops		= &cgroupns_operations,
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index f5e8828c109c..7c8c0ccd1feb 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -27,12 +27,12 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL);
 	if (!new_ns)
 		return ERR_PTR(-ENOMEM);
-	ret = ns_alloc_inum(&new_ns->ns);
+	ret = init_ns_common(&new_ns->ns, false);
 	if (ret) {
+		destroy_ns_common(&new_ns->ns);
 		kfree(new_ns);
 		return ERR_PTR(ret);
 	}
-	refcount_set(&new_ns->ns.count, 1);
 	new_ns->ns.ops = &cgroupns_operations;
 	return new_ns;
 }
@@ -42,7 +42,7 @@ void free_cgroup_ns(struct cgroup_namespace *ns)
 	put_css_set(ns->root_cset);
 	dec_cgroup_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	destroy_ns_common(&ns->ns);
 	kfree(ns);
 }
 EXPORT_SYMBOL(free_cgroup_ns);
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..65015c5b26db 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -66,6 +66,10 @@ int pid_max = PID_MAX_DEFAULT;
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
 
+static struct ns_tag init_pid_ns_tag = {
+	.usage		= REFCOUNT_INIT(1),
+};
+
 /*
  * PID-map pages start out as NULL, they get allocated upon
  * first use and are never deallocated. This way a low pid_max
@@ -73,6 +77,7 @@ int pid_max_max = PID_MAX_LIMIT;
  * the scheme scales to up to 4 million PIDs, runtime.
  */
 struct pid_namespace init_pid_ns = {
+	.ns.tag = &init_pid_ns_tag,
 	.ns.count = REFCOUNT_INIT(2),
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index ca43239a255a..a562071e52e1 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -93,16 +93,15 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 
 	idr_init(&ns->idr);
 
-	ns->pid_cachep = create_pid_cachep(level);
-	if (ns->pid_cachep == NULL)
-		goto out_free_idr;
-
-	err = ns_alloc_inum(&ns->ns);
+	err = init_ns_common(&ns->ns, false);
 	if (err)
-		goto out_free_idr;
+		goto out_free;
 	ns->ns.ops = &pidns_operations;
 
-	refcount_set(&ns->ns.count, 1);
+	ns->pid_cachep = create_pid_cachep(level);
+	if (ns->pid_cachep == NULL)
+		goto out_free;
+
 	ns->level = level;
 	ns->parent = get_pid_ns(parent_pid_ns);
 	ns->user_ns = get_user_ns(user_ns);
@@ -111,8 +110,9 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 
 	return ns;
 
-out_free_idr:
+out_free:
 	idr_destroy(&ns->idr);
+	destroy_ns_common(&ns->ns);
 	kmem_cache_free(pid_ns_cachep, ns);
 out_dec:
 	dec_pid_namespaces(ucounts);
@@ -132,7 +132,7 @@ static void delayed_free_pidns(struct rcu_head *p)
 
 static void destroy_pid_namespace(struct pid_namespace *ns)
 {
-	ns_free_inum(&ns->ns);
+	destroy_ns_common(&ns->ns);
 
 	idr_destroy(&ns->idr);
 	call_rcu(&ns->rcu, delayed_free_pidns);
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 6ca625f5e554..5c5847048900 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -92,16 +92,14 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
-	refcount_set(&ns->ns.count, 1);
+	err = init_ns_common(&ns->ns, false);
+	if (err)
+		goto fail_free;
 
 	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!ns->vvar_page)
 		goto fail_free;
 
-	err = ns_alloc_inum(&ns->ns);
-	if (err)
-		goto fail_free_page;
-
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
@@ -109,9 +107,8 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->frozen_offsets = false;
 	return ns;
 
-fail_free_page:
-	__free_page(ns->vvar_page);
 fail_free:
+	destroy_ns_common(&ns->ns);
 	kfree(ns);
 fail_dec:
 	dec_time_namespaces(ucounts);
@@ -230,7 +227,7 @@ void free_time_ns(struct time_namespace *ns)
 {
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	destroy_ns_common(&ns->ns);
 	__free_page(ns->vvar_page);
 	kfree(ns);
 }
diff --git a/kernel/user.c b/kernel/user.c
index a2478cddf536..78ee75f4cd21 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -20,6 +20,10 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 
+static struct ns_tag init_user_ns_tag = {
+	.usage	= REFCOUNT_INIT(1),
+};
+
 /*
  * userns count is 1 for root user, 1 for init_uts_ns,
  * and 1 for... ?
@@ -55,6 +59,7 @@ struct user_namespace init_user_ns = {
 			},
 		},
 	},
+	.ns.tag	= &init_user_ns_tag,
 	.ns.count = REFCOUNT_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index af612945a4d0..f60cf7b5973c 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -106,12 +106,11 @@ int create_user_ns(struct cred *new)
 	if (!ns)
 		goto fail_dec;
 
-	ret = ns_alloc_inum(&ns->ns);
+	ret = init_ns_common(&ns->ns, false);
 	if (ret)
 		goto fail_free;
 	ns->ns.ops = &userns_operations;
 
-	refcount_set(&ns->ns.count, 1);
 	/* Leave the new->user_ns reference with the new user namespace. */
 	ns->parent = parent_ns;
 	ns->level = parent_ns->level + 1;
@@ -142,8 +141,8 @@ int create_user_ns(struct cred *new)
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
 #endif
-	ns_free_inum(&ns->ns);
 fail_free:
+	destroy_ns_common(&ns->ns);
 	kmem_cache_free(user_ns_cachep, ns);
 fail_dec:
 	dec_user_namespaces(ucounts);
@@ -193,7 +192,7 @@ static void free_user_ns(struct work_struct *work)
 		}
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
-		ns_free_inum(&ns->ns);
+		destroy_ns_common(&ns->ns);
 		kmem_cache_free(user_ns_cachep, ns);
 		dec_user_namespaces(ucounts);
 		ns = parent;
diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..4755f007199f 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -30,10 +30,17 @@ static void dec_uts_namespaces(struct ucounts *ucounts)
 static struct uts_namespace *create_uts_ns(void)
 {
 	struct uts_namespace *uts_ns;
+	int err;
 
 	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
-	if (uts_ns)
-		refcount_set(&uts_ns->ns.count, 1);
+	if (uts_ns) {
+		err = init_ns_common(&uts_ns->ns, false);
+		if (err < 0) {
+			destroy_ns_common(&uts_ns->ns);
+			kmem_cache_free(uts_ns_cache, uts_ns);
+			return ERR_PTR(err);
+		}
+	}
 	return uts_ns;
 }
 
@@ -54,14 +61,11 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	if (!ucounts)
 		goto fail;
 
-	err = -ENOMEM;
 	ns = create_uts_ns();
-	if (!ns)
+	if (IS_ERR(ns)) {
+		err = PTR_ERR(ns);
 		goto fail_dec;
-
-	err = ns_alloc_inum(&ns->ns);
-	if (err)
-		goto fail_free;
+	}
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &utsns_operations;
@@ -72,8 +76,6 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	up_read(&uts_sem);
 	return ns;
 
-fail_free:
-	kmem_cache_free(uts_ns_cache, ns);
 fail_dec:
 	dec_uts_namespaces(ucounts);
 fail:
@@ -107,7 +109,7 @@ void free_uts_ns(struct uts_namespace *ns)
 {
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	ns_free_inum(&ns->ns);
+	destroy_ns_common(&ns->ns);
 	kmem_cache_free(uts_ns_cache, ns);
 }
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 2ef3b4557f40..f53f7ddec553 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -44,8 +44,14 @@ EXPORT_SYMBOL_GPL(net_rwsem);
 static struct key_tag init_net_key_domain = { .usage = REFCOUNT_INIT(1) };
 #endif
 
+static struct ns_tag init_net_tag = {
+	.usage		= REFCOUNT_INIT(1),
+};
+
 struct net init_net = {
-	.ns.count	= REFCOUNT_INIT(1),
+	.ns.tag		= &init_net_tag,
+	.ns.count	= REFCOUNT_INIT(2),
+	.ns.ops		= &netns_operations,
 	.dev_base_head	= LIST_HEAD_INIT(init_net.dev_base_head),
 #ifdef CONFIG_KEYS
 	.key_domain	= &init_net_key_domain,
@@ -329,7 +335,6 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	int error = 0;
 	LIST_HEAD(net_exit_list);
 
-	refcount_set(&net->ns.count, 1);
 	refcount_set(&net->passive, 1);
 	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;
@@ -419,6 +424,10 @@ static struct net *net_alloc(void)
 	if (!net)
 		goto out_free;
 
+	if (init_ns_common(&net->ns, false) < 0)
+		goto out_free_2;
+	net->ns.ops = &netns_operations;
+
 #ifdef CONFIG_KEYS
 	net->key_domain = kzalloc(sizeof(struct key_tag), GFP_KERNEL);
 	if (!net->key_domain)
@@ -432,6 +441,7 @@ static struct net *net_alloc(void)
 
 #ifdef CONFIG_KEYS
 out_free_2:
+	destroy_ns_common(&net->ns);
 	kmem_cache_free(net_cachep, net);
 	net = NULL;
 #endif
@@ -443,6 +453,7 @@ static struct net *net_alloc(void)
 static void net_free(struct net *net)
 {
 	kfree(rcu_access_pointer(net->gen));
+	destroy_ns_common(&net->ns);
 	kmem_cache_free(net_cachep, net);
 }
 
@@ -700,24 +711,6 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
-static __net_init int net_ns_net_init(struct net *net)
-{
-#ifdef CONFIG_NET_NS
-	net->ns.ops = &netns_operations;
-#endif
-	return ns_alloc_inum(&net->ns);
-}
-
-static __net_exit void net_ns_net_exit(struct net *net)
-{
-	ns_free_inum(&net->ns);
-}
-
-static struct pernet_operations __net_initdata net_ns_ops = {
-	.init = net_ns_net_init,
-	.exit = net_ns_net_exit,
-};
-
 static const struct nla_policy rtnl_net_policy[NETNSA_MAX + 1] = {
 	[NETNSA_NONE]		= { .type = NLA_UNSPEC },
 	[NETNSA_NSID]		= { .type = NLA_S32 },
@@ -1097,6 +1090,8 @@ static int __init net_ns_init(void)
 		panic("Could not create netns workq");
 #endif
 
+	proc_alloc_inum(&init_net.ns.inum);
+
 	ng = net_alloc_generic();
 	if (!ng)
 		panic("Could not allocate generic netns");
@@ -1114,9 +1109,6 @@ static int __init net_ns_init(void)
 	init_net_initialized = true;
 	up_write(&pernet_ops_rwsem);
 
-	if (register_pernet_subsys(&net_ns_ops))
-		panic("Could not register network namespace subsystems");
-
 	rtnl_register(PF_UNSPEC, RTM_NEWNSID, rtnl_net_newid, NULL,
 		      RTNL_FLAG_DOIT_UNLOCKED);
 	rtnl_register(PF_UNSPEC, RTM_GETNSID, rtnl_net_getid, rtnl_net_dumpid,


