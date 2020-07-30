Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9329D23317C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgG3MBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:01:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:57218 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbgG3MBR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:01:17 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17F5-00030I-Fo; Thu, 30 Jul 2020 15:00:59 +0300
Subject: [PATCH 21/23] mnt: Add mount namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:01:13 +0300
Message-ID: <159611047332.535980.13828558388565780541.stgit@localhost.localdomain>
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

Now they are exposed in /proc/namespace/ directory.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/mount.h     |    1 +
 fs/namespace.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/mount.h b/fs/mount.h
index f296862032ec..cde7f7bed8ec 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -23,6 +23,7 @@ struct mnt_namespace {
 	u64 event;
 	unsigned int		mounts; /* # of mounts in the namespace */
 	unsigned int		pending_mounts;
+	struct rcu_head		rcu;
 } __randomize_layout;
 
 struct mnt_pcp {
diff --git a/fs/namespace.c b/fs/namespace.c
index 8c39810e6ec3..756e43fd21f3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3258,7 +3258,7 @@ static void free_mnt_ns(struct mnt_namespace *ns)
 		ns_free_inum(&ns->ns);
 	dec_mnt_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
-	kfree(ns);
+	kfree_rcu(ns, rcu);
 }
 
 /*
@@ -3382,6 +3382,12 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (pwdmnt)
 		mntput(pwdmnt);
 
+	if (ns_idr_register(&new_ns->ns) < 0) {
+		drop_collected_mounts(&new_ns->root->mnt);
+		free_mnt_ns(new_ns);
+		new_ns = ERR_PTR(-ENOMEM);
+	}
+
 	return new_ns;
 }
 
@@ -3824,6 +3830,7 @@ static void __init init_mount_tree(void)
 	list_add(&m->mnt_list, &ns->list);
 	init_task.nsproxy->mnt_ns = ns;
 	get_mnt_ns(ns);
+	WARN_ON(ns_idr_register(&ns->ns) < 0);
 
 	root.mnt = mnt;
 	root.dentry = mnt->mnt_root;
@@ -3872,6 +3879,7 @@ void put_mnt_ns(struct mnt_namespace *ns)
 {
 	if (!refcount_dec_and_test(&ns->ns.count))
 		return;
+	ns_idr_unregister(&ns->ns);
 	drop_collected_mounts(&ns->root->mnt);
 	free_mnt_ns(ns);
 }


