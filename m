Return-Path: <linux-fsdevel+bounces-61902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 287D7B7EB38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78031C03A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC235A28B;
	Wed, 17 Sep 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFcXr37r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E52F7AA3;
	Wed, 17 Sep 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104925; cv=none; b=X0Kvj5dyi12d69muDHRDN0YaiIt21NzlcaR1cxGr9PmZeHIoWUxgTr3IPFamzFtPzqmakabS+OV7tE5gF69ZnE7PbchTPw/N8sT9ecl04gtrsg5cIQOritWfbOjp8IS7HDDVNGIezsH6MuSoNv44D0FaSPHRGY0YoDewadowmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104925; c=relaxed/simple;
	bh=7IxtHM+V3qkSMuMxxb4C83WRBdh/pZ/dABcbRzXFT34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XdOKHQF1Xo5MPhCwRtKbZz3pmn8BV+AE3Ur/TMwU1mJlAW7sfDmnEKGO1Fe9bfEyoAcg5gedYVHzMhs8aemVa/gtrvhlp8JhB6dr1ima8J7GVKZldk9hp+y57lp6mJyOlWr6caXulPiOtgdEfaHXBjWFqVBh8n1EslRe+wIOlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFcXr37r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D57C4CEF0;
	Wed, 17 Sep 2025 10:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104925;
	bh=7IxtHM+V3qkSMuMxxb4C83WRBdh/pZ/dABcbRzXFT34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eFcXr37r1T0tT6dV8/G6uX5BzrUt2GqahU0oGcnr4ruxc/2fx2aAXCMEFio8J5RQw
	 NmYhg1HCaePjwCxkQgEuFQYYIxn3C/coDPVXPbFrUv6+KV3ru+5hMik1L+vreVM6Wi
	 XHBFvXdQsw1ObtTIWNexbtiVXmmxvGxG6MeZ4UTz6/VMPfY0Us0MxBnLFLroU080sA
	 ggtWoXKbt4AOMqQIfXTV+THaDwIYfawzu2Kd7L5UuLap1UJf+WUlJRuoSla0EGLT6i
	 /MJnNjXRrDMz32DLR0AcFJoGbwrnwAMhVBMLqOTyEFvGShbU/L5/Et69TQZw4UMzgE
	 Ae8qlhPT9Ad8A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 17 Sep 2025 12:28:01 +0200
Subject: [PATCH 2/9] mnt: expose pointer to init_mnt_ns
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-work-namespace-ns_common-v1-2-1b3bda8ef8f2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7IxtHM+V3qkSMuMxxb4C83WRBdh/pZ/dABcbRzXFT34=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc6vXlmKRy+EeWkvjnmoDPT7qZ2HjebcmWLLtx7+05m
 eNvEmt9O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyT5Phr/S1bQxyHLXsVTW7
 bO7s9b1ewVptt5d5GSfXnzq18mdrLjD84UzzUgiXbgzT7N6pYerfuSoh84TJBJ21flkPt5vec3b
 mAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's various scenarios where we need to know whether we are in the
initial set of namespaces or not to e.g., shortcut permission checking.
All namespaces expose that information. Let's do that too.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c                | 2 ++
 include/linux/mnt_namespace.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index a68998449698..c8251545d57e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -81,6 +81,7 @@ static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static struct mnt_namespace *emptied_ns; /* protected by namespace_sem */
+struct mnt_namespace *init_mnt_ns;
 
 #ifdef CONFIG_FSNOTIFY
 LIST_HEAD(notify_list); /* protected by namespace_sem */
@@ -6037,6 +6038,7 @@ static void __init init_mount_tree(void)
 	set_fs_root(current->fs, &root);
 
 	ns_tree_add(ns);
+	init_mnt_ns = ns;
 }
 
 void __init mnt_init(void)
diff --git a/include/linux/mnt_namespace.h b/include/linux/mnt_namespace.h
index 70b366b64816..7e23c8364a9c 100644
--- a/include/linux/mnt_namespace.h
+++ b/include/linux/mnt_namespace.h
@@ -11,6 +11,8 @@ struct fs_struct;
 struct user_namespace;
 struct ns_common;
 
+extern struct mnt_namespace *init_mnt_ns;
+
 extern struct mnt_namespace *copy_mnt_ns(unsigned long, struct mnt_namespace *,
 		struct user_namespace *, struct fs_struct *);
 extern void put_mnt_ns(struct mnt_namespace *ns);

-- 
2.47.3


