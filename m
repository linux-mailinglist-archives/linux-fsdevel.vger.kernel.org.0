Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5779233161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgG3L7w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 07:59:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:56520 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbgG3L7u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:59:50 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Dh-0002wF-Am; Thu, 30 Jul 2020 14:59:33 +0300
Subject: [PATCH 05/23] user: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 14:59:47 +0300
Message-ID: <159611038719.535980.13960315152927389105.stgit@localhost.localdomain>
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

Convert user namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/user_namespace.h |    5 ++---
 kernel/user.c                  |    2 +-
 kernel/user_namespace.c        |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6ef1c7109fc4..64cf8ebdc4ec 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -57,7 +57,6 @@ struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
 	struct uid_gid_map	projid_map;
-	atomic_t		count;
 	struct user_namespace	*parent;
 	int			level;
 	kuid_t			owner;
@@ -109,7 +108,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type);
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 {
 	if (ns)
-		atomic_inc(&ns->count);
+		refcount_inc(&ns->ns.count);
 	return ns;
 }
 
@@ -119,7 +118,7 @@ extern void __put_user_ns(struct user_namespace *ns);
 
 static inline void put_user_ns(struct user_namespace *ns)
 {
-	if (ns && atomic_dec_and_test(&ns->count))
+	if (ns && refcount_dec_and_test(&ns->ns.count))
 		__put_user_ns(ns);
 }
 
diff --git a/kernel/user.c b/kernel/user.c
index b1635d94a1f2..a2478cddf536 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -55,7 +55,7 @@ struct user_namespace init_user_ns = {
 			},
 		},
 	},
-	.count = ATOMIC_INIT(3),
+	.ns.count = REFCOUNT_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = PROC_USER_INIT_INO,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..7c2bbe8f3e45 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -111,7 +111,7 @@ int create_user_ns(struct cred *new)
 		goto fail_free;
 	ns->ns.ops = &userns_operations;
 
-	atomic_set(&ns->count, 1);
+	refcount_set(&ns->ns.count, 1);
 	/* Leave the new->user_ns reference with the new user namespace. */
 	ns->parent = parent_ns;
 	ns->level = parent_ns->level + 1;
@@ -197,7 +197,7 @@ static void free_user_ns(struct work_struct *work)
 		kmem_cache_free(user_ns_cachep, ns);
 		dec_user_namespaces(ucounts);
 		ns = parent;
-	} while (atomic_dec_and_test(&parent->count));
+	} while (refcount_dec_and_test(&parent->ns.count));
 }
 
 void __put_user_ns(struct user_namespace *ns)


