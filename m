Return-Path: <linux-fsdevel+bounces-61903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E7B7D9FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1FFD1C02DEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDA635E4CA;
	Wed, 17 Sep 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjqlbDTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8A31B806;
	Wed, 17 Sep 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104930; cv=none; b=pXf3UrDh6RY1QoDog57Qp0CulsXKIXCnfocpmOYInWNiYcsWOMMdL5Wr/zdU5NXjkwO/1W1xJvMwJV27s6vegPK0FiWRH4v4DXCDCuFXE9ld1i8RSrYvPiqXd9KywZk2Mbb0KkzNuOviVDPp3BjWkfPDDJVq+QmsjdnmL8lmmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104930; c=relaxed/simple;
	bh=6UhKFWFtlZyAnCDgJbep43ULSJMkO6/IpQ3ovrb6i44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpEb19f1cj3CkvtujRMZz2/sbX4qzMlXW2/degCzHZKWBbGC9a7T8EwU8FHAUHwIV3GX1B9DAhJJJTMT9A7t5rAj+10jaESVJXdwFMsGSlFIm+gERPHxba5rLM20kdobFcDmvfl2Cn6E/PsgxuLuIFrji6J+zsA9PTuTzIwMtvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjqlbDTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC46AC4CEF5;
	Wed, 17 Sep 2025 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104930;
	bh=6UhKFWFtlZyAnCDgJbep43ULSJMkO6/IpQ3ovrb6i44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MjqlbDTTNbFAkM8xvkV7B7RB2lOo21kwFAgRHzG6Y0ACouQmuQl17HFL/vp5XRVNc
	 bjTcCIqv8eg7k3FubNZtEAx/7GBr2KUq/F55sZ2FrKrhAgd5jyH4lmyJEeG/WSwPdR
	 wIWvYdSCgR7mOV45Osan3R+L9lu47BMCifkC7UIhkHscX9gustpLp1tReqGskrK9w2
	 B3ZFmUik85psi4Yputs0MVeqf9FeZMsMAZJ2NtA0W90/NSmGJufi0zEfFD3MQzft4l
	 b/OyxU8svycSvCIVNj5iaSfJ1Rq/rhdpoTo44SjhM47X/HIEAyzghM74FCwkHKeA2a
	 8lK2yXmX/xNIA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:02 +0200
Subject: [PATCH 3/9] nscommon: move to separate file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-3-1b3bda8ef8f2@kernel.org>
References: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
In-Reply-To: <20250917-work-namespace-ns_common-v1-0-1b3bda8ef8f2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=2942; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6UhKFWFtlZyAnCDgJbep43ULSJMkO6/IpQ3ovrb6i44=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vVr+DWv1W0x86HzK9Y/uWt/7g+jIIP8zou3Fq9I/
 /9CV6r0ZkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETp1nZNjg3x0X0iDwccJZ
 YYP9orXf3kzX/cRzIEtd83OG5iK3NymMDAul5kQ+CJxXwXfmmEfIrKMT0988rbLpUT+gWbriTMc
 nNQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's really awkward spilling the ns common infrastructure into multiple
headers. Move it to a separate file.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/ns_common.h |  3 +++
 include/linux/proc_ns.h   | 19 -------------------
 kernel/Makefile           |  2 +-
 kernel/nscommon.c         | 21 +++++++++++++++++++++
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 7224072cccc5..78b17fe80b62 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -31,6 +31,9 @@ struct ns_common {
 	};
 };
 
+int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
+		   bool alloc_inum);
+
 #define to_ns_common(__ns)                              \
 	_Generic((__ns),                                \
 		struct cgroup_namespace *: &(__ns)->ns, \
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 7f89f0829e60..9f21670b5824 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -66,25 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 #endif /* CONFIG_PROC_FS */
 
-static inline int ns_common_init(struct ns_common *ns,
-				 const struct proc_ns_operations *ops,
-				 bool alloc_inum)
-{
-	if (alloc_inum) {
-		int ret;
-		ret = proc_alloc_inum(&ns->inum);
-		if (ret)
-			return ret;
-	}
-	refcount_set(&ns->count, 1);
-	ns->stashed = NULL;
-	ns->ops = ops;
-	ns->ns_id = 0;
-	RB_CLEAR_NODE(&ns->ns_tree_node);
-	INIT_LIST_HEAD(&ns->ns_list_node);
-	return 0;
-}
-
 #define ns_free_inum(ns) proc_free_inum((ns)->inum)
 
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
diff --git a/kernel/Makefile b/kernel/Makefile
index b807516a1b43..1f48f7cd2d7b 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -8,7 +8,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 	    sysctl.o capability.o ptrace.o user.o \
 	    signal.o sys.o umh.o workqueue.o pid.o task_work.o \
 	    extable.o params.o \
-	    kthread.o sys_ni.o nsproxy.o nstree.o \
+	    kthread.o sys_ni.o nsproxy.o nstree.o nscommon.o \
 	    notifier.o ksysfs.o cred.o reboot.o \
 	    async.o range.o smpboot.o ucount.o regset.o ksyms_common.o
 
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
new file mode 100644
index 000000000000..ebf4783d0505
--- /dev/null
+++ b/kernel/nscommon.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ns_common.h>
+
+int ns_common_init(struct ns_common *ns, const struct proc_ns_operations *ops,
+		   bool alloc_inum)
+{
+	if (alloc_inum) {
+		int ret;
+		ret = proc_alloc_inum(&ns->inum);
+		if (ret)
+			return ret;
+	}
+	refcount_set(&ns->count, 1);
+	ns->stashed = NULL;
+	ns->ops = ops;
+	ns->ns_id = 0;
+	RB_CLEAR_NODE(&ns->ns_tree_node);
+	INIT_LIST_HEAD(&ns->ns_list_node);
+	return 0;
+}

-- 
2.47.3


