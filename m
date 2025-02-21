Return-Path: <linux-fsdevel+bounces-42274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BEBA3FCFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E25864B6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5F32475DD;
	Fri, 21 Feb 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GsIGacZU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2482451D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157379; cv=none; b=tcHAgxkbyZyk1DK/5oIYPoMVw4jqoViHczpeO1Bx4WEG/IJZMLsplb5gXxsI/2bk+Z7bkC1I/I9gXMQ6USLnLiID3icdjIPw7epmeZ5w6S+WWtnrPrUEVgueAZDccE/ge6ZONyGXrWp57d/WLVCWthij2OxtAUsfdadBSCiSzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157379; c=relaxed/simple;
	bh=BU6AW4/vup2PJvui7d1Yi4h+wWiPT28WpwmUEqadV9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRYwTG63mXmKGVXQDOKWq6CSVqT+YNUw7INNUHCmaGc9HjQRLOZG2AGsoyLSDvKsHkbt+BVtL3uJXdng/1IfFhLyHwjznyIcNjDOd14qa3MsA1Do4uMJJ2+0das4QOw/3cFoetviKqXLmpQzeHKeqsU8/HCjM7v4wS5RbkAA9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GsIGacZU; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so372104866b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 09:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740157375; x=1740762175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn1EUFdCkok2nb6WPUbBFw+Pz8YpsWovy+Wa/6/aDDA=;
        b=GsIGacZUhWyroON8yKlVcWzP9BQ6wKkOcSNHjIIRrv6Xi0hc9xf4H8/BxFfHaKC3Vd
         Aaf1NI+9ChJ+2fuOckNfRHKI2hNoFFDUEDcME36HRdBdTkHvLUzqRrWFUovnfzRoxS7b
         1izwrONAxg1T+80Lt/OHm8Fu3hUfK8enNJUKZd7SyvrzF70uANT+a//1v2pS3+FIl0qF
         9SYz/+YelyDq6fzY2pO2oKZ1BNESW6uxw2+FEJv9NLmz87ZmGz0m0Jk4qM0DX5SGlBgu
         SF9m/H+733hmKZb3pDm9BXnNL4Y6TjQjKgqw+y1dvc40nA1ErF5TDu6BZB20TGmevqQk
         AH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157375; x=1740762175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn1EUFdCkok2nb6WPUbBFw+Pz8YpsWovy+Wa/6/aDDA=;
        b=O4puOXgsKq+mDUd45sV35zfZlE0bSw+qVyxi7w0OeUDs7Zo7x55217JrZamjfiomOC
         F8Xqx2IGw23wh741ERyGwsyos7rqp2M94Nhyqu5wWwzhIdoxqixBp/n7ZwRoURi92dN4
         qXO7jpeZsGbQKQk9sZAmRhtTl0x7hejrtvNcCYDvUn6JVL7+hP9oBb1sWIfJXJaC52kc
         G8KtwDqdN/nTpPSKC0wGew1SiylZ2G8yqBOWhkQkxTVLfkzw0IAxz4xOj9vbUfz2SxYC
         MHaGTkw9wbspXcFhr2Um2PROuhVoDM6VhmwwweIbJc53uCCd5EY2tQ8Y3gKYCreJr1nt
         Bpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXn9/RP56bTxhUdGybtESUnbNcBW/ZjeX9eq2IS0KXKVBgpo/1MWjIsZ9c5A6VzO4+OrLTITB18etEZvcC7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn3BfFS0Jn+ENpRYsQ3RpqgKg3rm9G2njLH1a/phFbt3hgm4k0
	sqAQs3tRyOGUGS2r+se1Ja0PeqtEZe0QEuDkHVGO4fpeGJKGBl6ZexnD4llUdU0=
X-Gm-Gg: ASbGnct+o5bv4V60IVQ+79TnRTKM1VC1GfHgO4yImumrRt1YW3IiHORDpga4LYnXtc1
	+urGsMllE+w0ctib5/I13fqGYCnNvoMtBfxboW8yOembnyN7piN6X19mogciXW5zcwdSRBdOo4b
	Je0K7f0fa6E/xaGcchOpScGDYzaK3WgqlEVdWYDzHzmrAPS3ajl9yK/O5aol4K8YowL1o4VIbcA
	5eZOb9IrOGEfzUwc3HLgDLAApBSxY+AT5IY6jSZk0tZNTC3y8fMgSBSMCc3K20EeqvDl3SE5cSx
	gjVNW8dsdLQWtzYmlxhmiTth78qS
X-Google-Smtp-Source: AGHT+IE/yZlQr7iCF2u/T2HPOCo0tOM65vbURSlGqazWvG/FhMHwesKZAxDLWtGvDrLMvON4IhYF0w==
X-Received: by 2002:a17:906:6a0a:b0:ab7:e1d5:d0c3 with SMTP id a640c23a62f3a-abc09c28bf6mr433317766b.51.1740157374605;
        Fri, 21 Feb 2025 09:02:54 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm1105668766b.161.2025.02.21.09.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:02:53 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 1/2] Revert "pid: allow pid_max to be set per pid namespace"
Date: Fri, 21 Feb 2025 18:02:48 +0100
Message-ID: <20250221170249.890014-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170249.890014-1-mkoutny@suse.com>
References: <20250221170249.890014-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 7863dcc72d0f4b13a641065670426435448b3d80.

It is already difficult for users to troubleshoot which of multiple pid
limits restricts their workload. I'm afraid making pid_max
per-(hierarchical-)NS will contribute to confusion.
Also, the implementation copies the limit upon creation from
parent, this pattern showed cumbersome with some attributes in legacy
cgroup controllers -- it's subject to race condition between parent's
limit modification and children creation and once copied it must be
changed in the descendant.

This is very similar to what pids.max of a cgroup (already) does that
can be used as an alternative.

Link: https://lore.kernel.org/r/bnxhqrq7tip6jl2hu6jsvxxogdfii7ugmafbhgsogovrchxfyp@kagotkztqurt/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/pid.h               |   3 +
 include/linux/pid_namespace.h     |  10 +--
 kernel/pid.c                      | 125 ++----------------------------
 kernel/pid_namespace.c            |  43 +++-------
 kernel/sysctl.c                   |   9 +++
 kernel/trace/pid_list.c           |   2 +-
 kernel/trace/trace.h              |   2 +
 kernel/trace/trace_sched_switch.c |   2 +-
 8 files changed, 35 insertions(+), 161 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 98837a1ff0f33..fe575fcdb4afa 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -108,6 +108,9 @@ extern void exchange_tids(struct task_struct *task, struct task_struct *old);
 extern void transfer_pid(struct task_struct *old, struct task_struct *new,
 			 enum pid_type);
 
+extern int pid_max;
+extern int pid_max_min, pid_max_max;
+
 /*
  * look up a PID in the hash table. Must be called with the tasklist_lock
  * or rcu_read_lock() held.
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c67a58111998..f9f9931e02d6a 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -30,7 +30,6 @@ struct pid_namespace {
 	struct task_struct *child_reaper;
 	struct kmem_cache *pid_cachep;
 	unsigned int level;
-	int pid_max;
 	struct pid_namespace *parent;
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
@@ -39,14 +38,9 @@ struct pid_namespace {
 	struct ucounts *ucounts;
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
-	struct work_struct	work;
-#ifdef CONFIG_SYSCTL
-	struct ctl_table_set	set;
-	struct ctl_table_header *sysctls;
-#if defined(CONFIG_MEMFD_CREATE)
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	int memfd_noexec_scope;
 #endif
-#endif
 } __randomize_layout;
 
 extern struct pid_namespace init_pid_ns;
@@ -123,8 +117,6 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
 void pidhash_init(void);
 void pid_idr_init(void);
-int register_pidns_sysctls(struct pid_namespace *pidns);
-void unregister_pidns_sysctls(struct pid_namespace *pidns);
 
 static inline bool task_is_in_init_pid_ns(struct task_struct *tsk)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 924084713be8b..aa2a7d4da4555 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -61,8 +61,10 @@ struct pid init_struct_pid = {
 	}, }
 };
 
-static int pid_max_min = RESERVED_PIDS + 1;
-static int pid_max_max = PID_MAX_LIMIT;
+int pid_max = PID_MAX_DEFAULT;
+
+int pid_max_min = RESERVED_PIDS + 1;
+int pid_max_max = PID_MAX_LIMIT;
 
 /*
  * PID-map pages start out as NULL, they get allocated upon
@@ -81,7 +83,6 @@ struct pid_namespace init_pid_ns = {
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
-	.pid_max = PID_MAX_DEFAULT,
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	.memfd_noexec_scope = MEMFD_NOEXEC_SCOPE_EXEC,
 #endif
@@ -190,7 +191,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	for (i = ns->level; i >= 0; i--) {
 		int tid = 0;
-		int pid_max = READ_ONCE(tmp->pid_max);
 
 		if (set_tid_size) {
 			tid = set_tid[ns->level - i];
@@ -644,118 +644,17 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	return fd;
 }
 
-#ifdef CONFIG_SYSCTL
-static struct ctl_table_set *pid_table_root_lookup(struct ctl_table_root *root)
-{
-	return &task_active_pid_ns(current)->set;
-}
-
-static int set_is_seen(struct ctl_table_set *set)
-{
-	return &task_active_pid_ns(current)->set == set;
-}
-
-static int pid_table_root_permissions(struct ctl_table_header *head,
-				      const struct ctl_table *table)
-{
-	struct pid_namespace *pidns =
-		container_of(head->set, struct pid_namespace, set);
-	int mode = table->mode;
-
-	if (ns_capable(pidns->user_ns, CAP_SYS_ADMIN) ||
-	    uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)))
-		mode = (mode & S_IRWXU) >> 6;
-	else if (in_egroup_p(make_kgid(pidns->user_ns, 0)))
-		mode = (mode & S_IRWXG) >> 3;
-	else
-		mode = mode & S_IROTH;
-	return (mode << 6) | (mode << 3) | mode;
-}
-
-static void pid_table_root_set_ownership(struct ctl_table_header *head,
-					 kuid_t *uid, kgid_t *gid)
-{
-	struct pid_namespace *pidns =
-		container_of(head->set, struct pid_namespace, set);
-	kuid_t ns_root_uid;
-	kgid_t ns_root_gid;
-
-	ns_root_uid = make_kuid(pidns->user_ns, 0);
-	if (uid_valid(ns_root_uid))
-		*uid = ns_root_uid;
-
-	ns_root_gid = make_kgid(pidns->user_ns, 0);
-	if (gid_valid(ns_root_gid))
-		*gid = ns_root_gid;
-}
-
-static struct ctl_table_root pid_table_root = {
-	.lookup		= pid_table_root_lookup,
-	.permissions	= pid_table_root_permissions,
-	.set_ownership	= pid_table_root_set_ownership,
-};
-
-static const struct ctl_table pid_table[] = {
-	{
-		.procname	= "pid_max",
-		.data		= &init_pid_ns.pid_max,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &pid_max_min,
-		.extra2		= &pid_max_max,
-	},
-};
-#endif
-
-int register_pidns_sysctls(struct pid_namespace *pidns)
-{
-#ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
-
-	setup_sysctl_set(&pidns->set, &pid_table_root, set_is_seen);
-
-	tbl = kmemdup(pid_table, sizeof(pid_table), GFP_KERNEL);
-	if (!tbl)
-		return -ENOMEM;
-	tbl->data = &pidns->pid_max;
-	pidns->pid_max = min(pid_max_max, max_t(int, pidns->pid_max,
-			     PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
-
-	pidns->sysctls = __register_sysctl_table(&pidns->set, "kernel", tbl,
-						 ARRAY_SIZE(pid_table));
-	if (!pidns->sysctls) {
-		kfree(tbl);
-		retire_sysctl_set(&pidns->set);
-		return -ENOMEM;
-	}
-#endif
-	return 0;
-}
-
-void unregister_pidns_sysctls(struct pid_namespace *pidns)
-{
-#ifdef CONFIG_SYSCTL
-	const struct ctl_table *tbl;
-
-	tbl = pidns->sysctls->ctl_table_arg;
-	unregister_sysctl_table(pidns->sysctls);
-	retire_sysctl_set(&pidns->set);
-	kfree(tbl);
-#endif
-}
-
 void __init pid_idr_init(void)
 {
 	/* Verify no one has done anything silly: */
 	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
 
 	/* bump default and minimum pid_max based on number of cpus */
-	init_pid_ns.pid_max = min(pid_max_max, max_t(int, init_pid_ns.pid_max,
-				  PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
+	pid_max = min(pid_max_max, max_t(int, pid_max,
+				PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
 	pid_max_min = max_t(int, pid_max_min,
 				PIDS_PER_CPU_MIN * num_possible_cpus());
-	pr_info("pid_max: default: %u minimum: %u\n", init_pid_ns.pid_max, pid_max_min);
+	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
 
 	idr_init(&init_pid_ns.idr);
 
@@ -766,16 +665,6 @@ void __init pid_idr_init(void)
 			NULL);
 }
 
-static __init int pid_namespace_sysctl_init(void)
-{
-#ifdef CONFIG_SYSCTL
-	/* "kernel" directory will have already been initialized. */
-	BUG_ON(register_pidns_sysctls(&init_pid_ns));
-#endif
-	return 0;
-}
-subsys_initcall(pid_namespace_sysctl_init);
-
 static struct file *__pidfd_fget(struct task_struct *task, int fd)
 {
 	struct file *file;
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 8f6cfec87555a..0f23285be4f92 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -70,8 +70,6 @@ static void dec_pid_namespaces(struct ucounts *ucounts)
 	dec_ucount(ucounts, UCOUNT_PID_NAMESPACES);
 }
 
-static void destroy_pid_namespace_work(struct work_struct *work);
-
 static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns,
 	struct pid_namespace *parent_pid_ns)
 {
@@ -107,27 +105,17 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 		goto out_free_idr;
 	ns->ns.ops = &pidns_operations;
 
-	ns->pid_max = parent_pid_ns->pid_max;
-	err = register_pidns_sysctls(ns);
-	if (err)
-		goto out_free_inum;
-
 	refcount_set(&ns->ns.count, 1);
 	ns->level = level;
 	ns->parent = get_pid_ns(parent_pid_ns);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
-	INIT_WORK(&ns->work, destroy_pid_namespace_work);
-
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
 #endif
-
 	return ns;
 
-out_free_inum:
-	ns_free_inum(&ns->ns);
 out_free_idr:
 	idr_destroy(&ns->idr);
 	kmem_cache_free(pid_ns_cachep, ns);
@@ -149,28 +137,12 @@ static void delayed_free_pidns(struct rcu_head *p)
 
 static void destroy_pid_namespace(struct pid_namespace *ns)
 {
-	unregister_pidns_sysctls(ns);
-
 	ns_free_inum(&ns->ns);
 
 	idr_destroy(&ns->idr);
 	call_rcu(&ns->rcu, delayed_free_pidns);
 }
 
-static void destroy_pid_namespace_work(struct work_struct *work)
-{
-	struct pid_namespace *ns =
-		container_of(work, struct pid_namespace, work);
-
-	do {
-		struct pid_namespace *parent;
-
-		parent = ns->parent;
-		destroy_pid_namespace(ns);
-		ns = parent;
-	} while (ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count));
-}
-
 struct pid_namespace *copy_pid_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct pid_namespace *old_ns)
 {
@@ -183,8 +155,15 @@ struct pid_namespace *copy_pid_ns(unsigned long flags,
 
 void put_pid_ns(struct pid_namespace *ns)
 {
-	if (ns && ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count))
-		schedule_work(&ns->work);
+	struct pid_namespace *parent;
+
+	while (ns != &init_pid_ns) {
+		parent = ns->parent;
+		if (!refcount_dec_and_test(&ns->ns.count))
+			break;
+		destroy_pid_namespace(ns);
+		ns = parent;
+	}
 }
 EXPORT_SYMBOL_GPL(put_pid_ns);
 
@@ -295,7 +274,6 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 	next = idr_get_cursor(&pid_ns->idr) - 1;
 
 	tmp.data = &next;
-	tmp.extra2 = &pid_ns->pid_max;
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	if (!ret && write)
 		idr_set_cursor(&pid_ns->idr, next + 1);
@@ -303,6 +281,7 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
+extern int pid_max;
 static const struct ctl_table pid_ns_ctl_table[] = {
 	{
 		.procname = "ns_last_pid",
@@ -310,7 +289,7 @@ static const struct ctl_table pid_ns_ctl_table[] = {
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
 		.extra1 = SYSCTL_ZERO,
-		.extra2 = &init_pid_ns.pid_max,
+		.extra2 = &pid_max,
 	},
 };
 #endif	/* CONFIG_CHECKPOINT_RESTORE */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cb57da499ebb1..bb739608680f2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1803,6 +1803,15 @@ static const struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
+	{
+		.procname	= "pid_max",
+		.data		= &pid_max,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &pid_max_min,
+		.extra2		= &pid_max_max,
+	},
 	{
 		.procname	= "panic_on_oops",
 		.data		= &panic_on_oops,
diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index c62b9b3cfb3d8..4966e6bbdf6f3 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -414,7 +414,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 	int i;
 
 	/* According to linux/thread.h, pids can be no bigger that 30 bits */
-	WARN_ON_ONCE(init_pid_ns.pid_max > (1 << 30));
+	WARN_ON_ONCE(pid_max > (1 << 30));
 
 	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
 	if (!pid_list)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af6..46c65402ad7e5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -732,6 +732,8 @@ extern unsigned long tracing_thresh;
 
 /* PID filtering */
 
+extern int pid_max;
+
 bool trace_find_filtered_pid(struct trace_pid_list *filtered_pids,
 			     pid_t search_pid);
 bool trace_ignore_this_task(struct trace_pid_list *filtered_pids,
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc80..573b5d8e8a28e 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -442,7 +442,7 @@ int trace_alloc_tgid_map(void)
 	if (tgid_map)
 		return 0;
 
-	tgid_map_max = init_pid_ns.pid_max;
+	tgid_map_max = pid_max;
 	map = kvcalloc(tgid_map_max + 1, sizeof(*tgid_map),
 		       GFP_KERNEL);
 	if (!map)
-- 
2.48.1


