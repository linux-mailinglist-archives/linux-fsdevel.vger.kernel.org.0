Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 978E212DB7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLaTvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 14:51:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60283 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727447AbfLaTvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577821873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:in-reply-to:
         references:references:references;
        bh=fJ1/6iGw9Bx+R6mUxApOeSsh7fRZu93l3CQRR+DchOE=;
        b=M3hwqtBx3zWqXQdiUt4HF5rclfFSMY30bj1h4BaNbAji3UYIiB3m1k4cfEiOcnzAUEX71a
        uEhisArVTb9jdM+Dz1l0Mierf2AUQQriRktJbUG6yEDz+65D9jHa+l1/i+FowfLUzVSiFV
        v3y68BAv4uy3TIs1k6Ri/DGz7aOow60=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-dEcso7M-M_yddAmEaTRcfw-1; Tue, 31 Dec 2019 14:51:11 -0500
X-MC-Unique: dEcso7M-M_yddAmEaTRcfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57A3A10054E3;
        Tue, 31 Dec 2019 19:51:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CFCF67673;
        Tue, 31 Dec 2019 19:50:56 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        nhorman@tuxdriver.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak90 V8 11/16] audit: add support for containerid to network namespaces
Date:   Tue, 31 Dec 2019 14:48:24 -0500
Message-Id: <2954ed671a7622ddf3abdb8854dbba2ad13e9f33.1577736799.git.rgb@redhat.com>
In-Reply-To: <cover.1577736799.git.rgb@redhat.com>
References: <cover.1577736799.git.rgb@redhat.com>
In-Reply-To: <cover.1577736799.git.rgb@redhat.com>
References: <cover.1577736799.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This also adds support to qualify NETFILTER_PKT records.

Audit events could happen in a network namespace outside of a task
context due to packets received from the net that trigger an auditing
rule prior to being associated with a running task.  The network
namespace could be in use by multiple containers by association to the
tasks in that network namespace.  We still want a way to attribute
these events to any potential containers.  Keep a list per network
namespace to track these audit container identifiiers.

Add/increment the audit container identifier on:
- initial setting of the audit container identifier via /proc
- clone/fork call that inherits an audit container identifier
- unshare call that inherits an audit container identifier
- setns call that inherits an audit container identifier
Delete/decrement the audit container identifier on:
- an inherited audit container identifier dropped when child set
- process exit
- unshare call that drops a net namespace
- setns call that drops a net namespace

Add audit container identifier auxiliary record(s) to NETFILTER_PKT
event standalone records.  Iterate through all potential audit container
identifiers associated with a network namespace.

Please see the github audit kernel issue for contid net support:
  https://github.com/linux-audit/audit-kernel/issues/92
Please see the github audit testsuiite issue for the test case:
  https://github.com/linux-audit/audit-testsuite/issues/64
Please see the github audit wiki for the feature overview:
  https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/audit.h    |  24 +++++++++
 kernel/audit.c           | 132 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/nsproxy.c         |   4 ++
 net/netfilter/nft_log.c  |  11 +++-
 net/netfilter/xt_AUDIT.c |  11 +++-
 5 files changed, 176 insertions(+), 6 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 5531d37a4226..ed8d5b74758d 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <uapi/linux/audit.h>
+#include <linux/refcount.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -121,6 +122,13 @@ struct audit_task_info {
 
 extern struct audit_task_info init_struct_audit;
 
+struct audit_contobj_netns {
+	struct list_head	list;
+	u64			id;
+	refcount_t		refcount;
+	struct rcu_head		rcu;
+};
+
 extern int is_audit_feature_set(int which);
 
 extern int __init audit_register_class(int class, unsigned *list);
@@ -225,6 +233,12 @@ static inline u64 audit_get_contid(struct task_struct *tsk)
 }
 
 extern void audit_log_container_id(struct audit_context *context, u64 contid);
+extern void audit_netns_contid_add(struct net *net, u64 contid);
+extern void audit_netns_contid_del(struct net *net, u64 contid);
+extern void audit_switch_task_namespaces(struct nsproxy *ns,
+					 struct task_struct *p);
+extern void audit_log_netns_contid_list(struct net *net,
+					struct audit_context *context);
 
 extern u32 audit_enabled;
 
@@ -297,6 +311,16 @@ static inline u64 audit_get_contid(struct task_struct *tsk)
 
 static inline void audit_log_container_id(struct audit_context *context, u64 contid)
 { }
+static inline void audit_netns_contid_add(struct net *net, u64 contid)
+{ }
+static inline void audit_netns_contid_del(struct net *net, u64 contid)
+{ }
+static inline void audit_switch_task_namespaces(struct nsproxy *ns,
+						struct task_struct *p)
+{ }
+static inline void audit_log_netns_contid_list(struct net *net,
+					       struct audit_context *context)
+{ }
 
 #define audit_enabled AUDIT_OFF
 
diff --git a/kernel/audit.c b/kernel/audit.c
index d4e6eafe5644..f7a8d3288ca0 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -59,6 +59,7 @@
 #include <linux/freezer.h>
 #include <linux/pid_namespace.h>
 #include <net/netns/generic.h>
+#include <net/net_namespace.h>
 
 #include "audit.h"
 
@@ -86,9 +87,13 @@
 /**
  * struct audit_net - audit private network namespace data
  * @sk: communication socket
+ * @contid_list: audit container identifier list
+ * @contid_list_lock audit container identifier list lock
  */
 struct audit_net {
 	struct sock *sk;
+	struct list_head contid_list;
+	spinlock_t contid_list_lock;
 };
 
 /**
@@ -305,8 +310,11 @@ struct audit_task_info init_struct_audit = {
 void audit_free(struct task_struct *tsk)
 {
 	struct audit_task_info *info = tsk->audit;
+	struct nsproxy *ns = tsk->nsproxy;
 
 	audit_free_syscall(tsk);
+	if (ns)
+		audit_netns_contid_del(ns->net_ns, audit_get_contid(tsk));
 	/* Freeing the audit_task_info struct must be performed after
 	 * audit_log_exit() due to need for loginuid and sessionid.
 	 */
@@ -409,6 +417,120 @@ static struct sock *audit_get_sk(const struct net *net)
 	return aunet->sk;
 }
 
+void audit_netns_contid_add(struct net *net, u64 contid)
+{
+	struct audit_net *aunet;
+	struct list_head *contid_list;
+	struct audit_contobj_netns *cont;
+
+	if (!net)
+		return;
+	if (!audit_contid_valid(contid))
+		return;
+	aunet = net_generic(net, audit_net_id);
+	if (!aunet)
+		return;
+	contid_list = &aunet->contid_list;
+	rcu_read_lock();
+	list_for_each_entry_rcu(cont, contid_list, list)
+		if (cont->id == contid) {
+			spin_lock(&aunet->contid_list_lock);
+			refcount_inc(&cont->refcount);
+			spin_unlock(&aunet->contid_list_lock);
+			goto out;
+		}
+	cont = kmalloc(sizeof(*cont), GFP_ATOMIC);
+	if (cont) {
+		INIT_LIST_HEAD(&cont->list);
+		cont->id = contid;
+		refcount_set(&cont->refcount, 1);
+		spin_lock(&aunet->contid_list_lock);
+		list_add_rcu(&cont->list, contid_list);
+		spin_unlock(&aunet->contid_list_lock);
+	}
+out:
+	rcu_read_unlock();
+}
+
+void audit_netns_contid_del(struct net *net, u64 contid)
+{
+	struct audit_net *aunet;
+	struct list_head *contid_list;
+	struct audit_contobj_netns *cont = NULL;
+
+	if (!net)
+		return;
+	if (!audit_contid_valid(contid))
+		return;
+	aunet = net_generic(net, audit_net_id);
+	if (!aunet)
+		return;
+	contid_list = &aunet->contid_list;
+	rcu_read_lock();
+	list_for_each_entry_rcu(cont, contid_list, list)
+		if (cont->id == contid) {
+			spin_lock(&aunet->contid_list_lock);
+			if (refcount_dec_and_test(&cont->refcount)) {
+				list_del_rcu(&cont->list);
+				kfree_rcu(cont, rcu);
+			}
+			spin_unlock(&aunet->contid_list_lock);
+			break;
+		}
+	rcu_read_unlock();
+}
+
+void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
+{
+	u64 contid = audit_get_contid(p);
+	struct nsproxy *new = p->nsproxy;
+
+	if (!audit_contid_valid(contid))
+		return;
+	audit_netns_contid_del(ns->net_ns, contid);
+	if (new)
+		audit_netns_contid_add(new->net_ns, contid);
+}
+
+/**
+ * audit_log_netns_contid_list - List contids for the given network namespace
+ * @net: the network namespace of interest
+ * @context: the audit context to use
+ *
+ * Description:
+ * Issues a CONTAINER_ID record with a CSV list of contids associated
+ * with a network namespace to accompany a NETFILTER_PKT record.
+ */
+void audit_log_netns_contid_list(struct net *net, struct audit_context *context)
+{
+	struct audit_buffer *ab = NULL;
+	struct audit_contobj_netns *cont;
+	struct audit_net *aunet;
+
+	/* Generate AUDIT_CONTAINER_ID record with container ID CSV list */
+	rcu_read_lock();
+	aunet = net_generic(net, audit_net_id);
+	if (!aunet)
+		goto out;
+	list_for_each_entry_rcu(cont, &aunet->contid_list, list) {
+		if (!ab) {
+			ab = audit_log_start(context, GFP_ATOMIC,
+					     AUDIT_CONTAINER_ID);
+			if (!ab) {
+				audit_log_lost("out of memory in audit_log_netns_contid_list");
+				goto out;
+			}
+			audit_log_format(ab, "contid=");
+		} else
+			audit_log_format(ab, ",");
+		audit_log_format(ab, "%llu", cont->id);
+	}
+	audit_log_end(ab);
+out:
+	rcu_read_unlock();
+}
+EXPORT_SYMBOL(audit_log_netns_contid_list);
+
 void audit_panic(const char *message)
 {
 	switch (audit_failure) {
@@ -1677,7 +1799,6 @@ static int __net_init audit_net_init(struct net *net)
 		.flags	= NL_CFG_F_NONROOT_RECV,
 		.groups	= AUDIT_NLGRP_MAX,
 	};
-
 	struct audit_net *aunet = net_generic(net, audit_net_id);
 
 	aunet->sk = netlink_kernel_create(net, NETLINK_AUDIT, &cfg);
@@ -1686,7 +1807,8 @@ static int __net_init audit_net_init(struct net *net)
 		return -ENOMEM;
 	}
 	aunet->sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
-
+	INIT_LIST_HEAD(&aunet->contid_list);
+	spin_lock_init(&aunet->contid_list_lock);
 	return 0;
 }
 
@@ -2470,6 +2592,7 @@ int audit_set_contid(struct task_struct *task, u64 contid)
 	u64 oldcontid;
 	int rc = 0;
 	struct audit_buffer *ab;
+	struct net *net = task->nsproxy->net_ns;
 
 	task_lock(task);
 	/* Can't set if audit disabled */
@@ -2540,6 +2663,11 @@ int audit_set_contid(struct task_struct *task, u64 contid)
 conterror:
 		rcu_read_unlock();
 	}
+	if (!rc) {
+		if (audit_contid_valid(oldcontid))
+			audit_netns_contid_del(net, oldcontid);
+		audit_netns_contid_add(net, contid);
+	}
 	task_unlock(task);
 
 	if (!audit_enabled)
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index c815f58e6bc0..bbdb5bbf5446 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -23,6 +23,7 @@
 #include <linux/syscalls.h>
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
+#include <linux/audit.h>
 
 static struct kmem_cache *nsproxy_cachep;
 
@@ -136,6 +137,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
+	u64 contid = audit_get_contid(tsk);
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
@@ -163,6 +165,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 		return  PTR_ERR(new_ns);
 
 	tsk->nsproxy = new_ns;
+	audit_netns_contid_add(new_ns->net_ns, contid);
 	return 0;
 }
 
@@ -220,6 +223,7 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 	ns = p->nsproxy;
 	p->nsproxy = new;
 	task_unlock(p);
+	audit_switch_task_namespaces(ns, p);
 
 	if (ns && atomic_dec_and_test(&ns->count))
 		free_nsproxy(ns);
diff --git a/net/netfilter/nft_log.c b/net/netfilter/nft_log.c
index fe4831f2258f..98d1e7e1a83c 100644
--- a/net/netfilter/nft_log.c
+++ b/net/netfilter/nft_log.c
@@ -66,13 +66,16 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
 	struct sk_buff *skb = pkt->skb;
 	struct audit_buffer *ab;
 	int fam = -1;
+	struct audit_context *context;
+	struct net *net;
 
 	if (!audit_enabled)
 		return;
 
-	ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
+	context = audit_alloc_local(GFP_ATOMIC);
+	ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
 	if (!ab)
-		return;
+		goto errout;
 
 	audit_log_format(ab, "mark=%#x", skb->mark);
 
@@ -99,6 +102,10 @@ static void nft_log_eval_audit(const struct nft_pktinfo *pkt)
 		audit_log_format(ab, " saddr=? daddr=? proto=-1");
 
 	audit_log_end(ab);
+	net = xt_net(&pkt->xt);
+	audit_log_netns_contid_list(net, context);
+errout:
+	audit_free_context(context);
 }
 
 static void nft_log_eval(const struct nft_expr *expr,
diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
index 9cdc16b0d0d8..ecf868a1abde 100644
--- a/net/netfilter/xt_AUDIT.c
+++ b/net/netfilter/xt_AUDIT.c
@@ -68,10 +68,13 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 {
 	struct audit_buffer *ab;
 	int fam = -1;
+	struct audit_context *context;
+	struct net *net;
 
 	if (audit_enabled == AUDIT_OFF)
-		goto errout;
-	ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
+		goto out;
+	context = audit_alloc_local(GFP_ATOMIC);
+	ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
 	if (ab == NULL)
 		goto errout;
 
@@ -101,7 +104,11 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
 
 	audit_log_end(ab);
 
+	net = xt_net(par);
+	audit_log_netns_contid_list(net, context);
 errout:
+	audit_free_context(context);
+out:
 	return XT_CONTINUE;
 }
 
-- 
1.8.3.1

