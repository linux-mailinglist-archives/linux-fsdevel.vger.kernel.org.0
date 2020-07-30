Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4823316F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgG3MAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:56868 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbgG3MAd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:33 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17EO-0002yI-Is; Thu, 30 Jul 2020 15:00:16 +0300
Subject: [PATCH 13/23] user: Add user namespaces into ns_idr
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:30 +0300
Message-ID: <159611043002.535980.3019217992777905831.stgit@localhost.localdomain>
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
 kernel/user_namespace.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 367a942bb484..bbfd7f0f9e7c 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -137,7 +137,13 @@ int create_user_ns(struct cred *new)
 		goto fail_keyring;
 
 	set_cred_user_ns(new, ns);
+
+	if (ns_idr_register(&ns->ns))
+		goto fail_sysctl;
+
 	return 0;
+fail_sysctl:
+	retire_userns_sysctls(ns);
 fail_keyring:
 #ifdef CONFIG_PERSISTENT_KEYRINGS
 	key_put(ns->persistent_keyring_register);
@@ -186,6 +192,7 @@ static void free_user_ns(struct work_struct *work)
 	do {
 		struct ucounts *ucounts = ns->ucounts;
 		parent = ns->parent;
+		ns_idr_unregister(&ns->ns);
 		if (ns->gid_map.nr_extents > UID_GID_MAP_MAX_BASE_EXTENTS) {
 			kfree(ns->gid_map.forward);
 			kfree(ns->gid_map.reverse);
@@ -1327,6 +1334,7 @@ const struct proc_ns_operations userns_operations = {
 static __init int user_namespaces_init(void)
 {
 	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC);
-	return 0;
+
+	return ns_idr_register(&init_user_ns.ns);
 }
 subsys_initcall(user_namespaces_init);


