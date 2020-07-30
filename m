Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433C6233156
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgG3L7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 07:59:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:56444 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727922AbgG3L7j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:59:39 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17DW-0002vq-Ki; Thu, 30 Jul 2020 14:59:22 +0300
Subject: [PATCH 03/23] ipc: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 14:59:36 +0300
Message-ID: <159611037654.535980.11569207616830163621.stgit@localhost.localdomain>
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

Convert uts namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/ipc_namespace.h |    3 +--
 ipc/msgutil.c                 |    2 +-
 ipc/namespace.c               |    4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index a06a78c67f19..05e22770af51 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -27,7 +27,6 @@ struct ipc_ids {
 };
 
 struct ipc_namespace {
-	refcount_t	count;
 	struct ipc_ids	ids[3];
 
 	int		sem_ctls[4];
@@ -128,7 +127,7 @@ extern struct ipc_namespace *copy_ipcs(unsigned long flags,
 static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 {
 	if (ns)
-		refcount_inc(&ns->count);
+		refcount_inc(&ns->ns.count);
 	return ns;
 }
 
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 3149b4a379de..d0a0e877cadd 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -26,7 +26,7 @@ DEFINE_SPINLOCK(mq_lock);
  * and not CONFIG_IPC_NS.
  */
 struct ipc_namespace init_ipc_ns = {
-	.count		= REFCOUNT_INIT(1),
+	.ns.count = REFCOUNT_INIT(1),
 	.user_ns = &init_user_ns,
 	.ns.inum = PROC_IPC_INIT_INO,
 #ifdef CONFIG_IPC_NS
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 24e7b45320f7..7bd0766ddc3b 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -51,7 +51,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 		goto fail_free;
 	ns->ns.ops = &ipcns_operations;
 
-	refcount_set(&ns->count, 1);
+	refcount_set(&ns->ns.count, 1);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
@@ -164,7 +164,7 @@ static DECLARE_WORK(free_ipc_work, free_ipc);
  */
 void put_ipc_ns(struct ipc_namespace *ns)
 {
-	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
+	if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
 


