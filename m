Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686AF233175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgG3MAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:56990 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728234AbgG3MAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:50 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Ee-0002z4-HB; Thu, 30 Jul 2020 15:00:32 +0300
Subject: [PATCH 16/23] proc_ns_operations: Add can_get method
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:46 +0300
Message-ID: <159611044644.535980.6920767742450563865.stgit@localhost.localdomain>
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

This is a new method to prohibit some namespaces in intermediate state.
Currently, it's used to prohibit pid namespace, whose child reaper is not
created yet (similar to we have in /proc/[pid]/pid_for_children).

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/proc/namespaces.c    |    5 +++++
 include/linux/proc_ns.h |    1 +
 kernel/pid_namespace.c  |    1 +
 3 files changed, 7 insertions(+)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index ab47e1555619..70fc23295315 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -149,6 +149,11 @@ static const char *proc_namespaces_getlink(struct dentry *dentry,
 		ns = get_namespace_by_dentry(pid_ns, dentry);
 		if (!ns)
 			goto out;
+		ret = -ESRCH;
+		if (ns->ops->can_get && !ns->ops->can_get(ns)) {
+			ns->ops->put(ns);
+			goto out;
+		}
 
 		ret = __ns_get_path(&path, ns);
 		if (ret == -EAGAIN)
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 906e6ebb43e4..e44ec466711a 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -19,6 +19,7 @@ struct proc_ns_operations {
 	int type;
 	struct ns_common *(*get)(struct task_struct *task);
 	void (*put)(struct ns_common *ns);
+	bool (*can_get)(struct ns_common *ns);
 	int (*install)(struct nsset *nsset, struct ns_common *ns);
 	struct user_namespace *(*owner)(struct ns_common *ns);
 	struct ns_common *(*get_parent)(struct ns_common *ns);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 4a01328e8763..da8490390f51 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -452,6 +452,7 @@ const struct proc_ns_operations pidns_for_children_operations = {
 	.real_ns_name	= "pid",
 	.type		= CLONE_NEWPID,
 	.get		= pidns_for_children_get,
+	.can_get	= pidns_can_get,
 	.put		= pidns_put,
 	.install	= pidns_install,
 	.owner		= pidns_owner,


