Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E12233173
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgG3MAt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 08:00:49 -0400
Received: from relay.sw.ru ([185.231.240.75]:56960 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbgG3MAp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:00:45 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17EZ-0002yn-7t; Thu, 30 Jul 2020 15:00:27 +0300
Subject: [PATCH 15/23] pid: Eextract child_reaper check from
 pidns_for_children_get()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 15:00:41 +0300
Message-ID: <159611044115.535980.10236831314879436296.stgit@localhost.localdomain>
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

This check if for prohibiting access to /proc/[pid]/ns/pid_for_children
before first task of the pid namespace is created.

/proc/namespaces/ code will use this check too, so we move it into
a separate function.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 kernel/pid_namespace.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index d02dc1696edf..4a01328e8763 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -343,6 +343,21 @@ static struct ns_common *pidns_get(struct task_struct *task)
 	return ns ? &ns->ns : NULL;
 }
 
+static bool pidns_can_get(struct ns_common *ns)
+{
+	struct pid_namespace *pid_ns;
+	bool ret = true;
+
+	pid_ns = container_of(ns, struct pid_namespace, ns);
+
+	read_lock(&tasklist_lock);
+	if (!pid_ns->child_reaper)
+		ret = false;
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+
 static struct ns_common *pidns_for_children_get(struct task_struct *task)
 {
 	struct pid_namespace *ns = NULL;
@@ -354,13 +369,9 @@ static struct ns_common *pidns_for_children_get(struct task_struct *task)
 	}
 	task_unlock(task);
 
-	if (ns) {
-		read_lock(&tasklist_lock);
-		if (!ns->child_reaper) {
-			put_pid_ns(ns);
-			ns = NULL;
-		}
-		read_unlock(&tasklist_lock);
+	if (ns && !pidns_can_get(&ns->ns)) {
+		put_pid_ns(ns);
+		ns = NULL;
 	}
 
 	return ns ? &ns->ns : NULL;


