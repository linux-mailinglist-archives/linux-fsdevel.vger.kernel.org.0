Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F5233179
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgG3MBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:01:07 -0400
Received: from relay.sw.ru ([185.231.240.75]:57080 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728592AbgG3MBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:01:00 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Ep-0002zc-Ew; Thu, 30 Jul 2020 15:00:43 +0300
Subject: [PATCH 18/23] uts: Free uts namespace one RCU grace period after
 final counter put
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:57 +0300
Message-ID: <159611045706.535980.12888496197045005870.stgit@localhost.localdomain>
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

This is needed to link uts_ns into ns_idr in next patch.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/utsname.h |    1 +
 kernel/utsname.c        |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 2b1737c9b244..b783d0fe6ca4 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -25,6 +25,7 @@ struct uts_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 	struct ns_common ns;
+	struct rcu_head rcu;
 } __randomize_layout;
 extern struct uts_namespace init_uts_ns;
 
diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..aebf4df5f592 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -103,12 +103,20 @@ struct uts_namespace *copy_utsname(unsigned long flags,
 	return new_ns;
 }
 
+static void free_uts_ns_rcu(struct rcu_head *head)
+{
+	struct uts_namespace *ns;
+
+	ns = container_of(head, struct uts_namespace, rcu);
+	kmem_cache_free(uts_ns_cache, ns);
+}
+
 void free_uts_ns(struct uts_namespace *ns)
 {
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-	kmem_cache_free(uts_ns_cache, ns);
+	call_rcu(&ns->rcu, free_uts_ns_rcu);
 }
 
 static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)


