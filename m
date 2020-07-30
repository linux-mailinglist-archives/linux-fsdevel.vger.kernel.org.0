Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E50423316D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgG3MAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:56830 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728005AbgG3MA1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:27 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17EI-0002y6-PL; Thu, 30 Jul 2020 15:00:10 +0300
Subject: [PATCH 12/23] user: Free user_ns one RCU grace period after final
 counter put
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:24 +0300
Message-ID: <159611042455.535980.12021168777274312453.stgit@localhost.localdomain>
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

This is needed to link user_ns into ns_idr in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/user_namespace.h |    5 ++++-
 kernel/user_namespace.c        |    9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 64cf8ebdc4ec..58fede304201 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -79,7 +79,10 @@ struct user_namespace {
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	struct key		*persistent_keyring_register;
 #endif
-	struct work_struct	work;
+	union {
+		struct work_struct	work;
+		struct rcu_head		rcu;
+	};
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_set	set;
 	struct ctl_table_header *sysctls;
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 7c2bbe8f3e45..367a942bb484 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -171,6 +171,13 @@ int unshare_userns(unsigned long unshare_flags, struct cred **new_cred)
 	return err;
 }
 
+static void free_user_ns_rcu(struct rcu_head *head)
+{
+	struct user_namespace *ns = container_of(head, struct user_namespace,
+						 rcu);
+	kmem_cache_free(user_ns_cachep, ns);
+}
+
 static void free_user_ns(struct work_struct *work)
 {
 	struct user_namespace *parent, *ns =
@@ -194,7 +201,7 @@ static void free_user_ns(struct work_struct *work)
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
-		kmem_cache_free(user_ns_cachep, ns);
+		call_rcu(&ns->rcu, free_user_ns_rcu);
 		dec_user_namespaces(ucounts);
 		ns = parent;
 	} while (refcount_dec_and_test(&parent->ns.count));


