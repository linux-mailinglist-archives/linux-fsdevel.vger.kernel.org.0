Return-Path: <linux-fsdevel+bounces-8647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20A9839EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519C928B9BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59AF9C6;
	Wed, 24 Jan 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxsjPae0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF85187F;
	Wed, 24 Jan 2024 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062925; cv=none; b=eGuyYiUDzvo7yazdv/dbbsLbnA/S4zlPmBQTKcX24i7RBQE/AVJhsNGWWbDV3K4DRe9qgC2oye/tMk7UeP/NQZW5mxbU1t0luKxcim/5KNT98Ojqj/UQxqUowwFrwc8XaRyIpp3Do3EOA6RO8Lpspgq5pN8RK8FpzfAA+ImaeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062925; c=relaxed/simple;
	bh=BIYwrvLXEHZ5pCqSeAPkLGLs/4VvGL92kZOGseA7g7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O038Lkze5ugmcc/sQPeQI+WMYyzzb4qI1RiC9dhrb1b+ZP4oVqEYr3H/U48eWbdR58aX/DZNY51VzcAbKcJ0bGIA27Bm+nfKcn2JkO6gjm5yVXBzuLYyxSopYIKQ7660KE9GlCgF+vGx5mNK0AIU/mtDgLeiRI8nIAvh3eowL4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxsjPae0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F90C433F1;
	Wed, 24 Jan 2024 02:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062925;
	bh=BIYwrvLXEHZ5pCqSeAPkLGLs/4VvGL92kZOGseA7g7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XxsjPae07npMnRJ6Ai65ra/+uyRQyHJMCdh2w7+x0OMwQxZPLEa7Md2xehuJMlGZ/
	 qvix8hiXxkF8DyQZICl1p8J58Gg91EkT3BcNs+VRiYAq/CK3I3tl8L5h/qnwoNAAVi
	 5gOLxIrE4J1EooAOMyp50/ApJEupKPsomecPTbhfUgujiu+lnaNmmBJDjDuKIPNgjX
	 YGslS4UC25sfwVYRXkE5ZB7NtDcRGIQYsNENBN12R59MixYJhmkanW6kDK9PqSE8G0
	 AhzZ2J27lP73m2xca+1RHUwJFmEevqFl+J4ldjjUcl0xFox1MRWHA4Mgdzw/mlcSqr
	 Wyxevf1WB9uuA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 09/30] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
Date: Tue, 23 Jan 2024 18:21:06 -0800
Message-Id: <20240124022127.2379740-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on upstream discussion ([0]), rework existing
bpf_prog_alloc_security LSM hook. Rename it to bpf_prog_load and instead
of passing bpf_prog_aux, pass proper bpf_prog pointer for a full BPF
program struct. Also, we pass bpf_attr union with all the user-provided
arguments for BPF_PROG_LOAD command.  This will give LSMs as much
information as we can basically provide.

The hook is also BPF token-aware now, and optional bpf_token struct is
passed as a third argument. bpf_prog_load LSM hook is called after
a bunch of sanity checks were performed, bpf_prog and bpf_prog_aux were
allocated and filled out, but right before performing full-fledged BPF
verification step.

bpf_prog_free LSM hook is now accepting struct bpf_prog argument, for
consistency. SELinux code is adjusted to all new names, types, and
signatures.

Note, given that bpf_prog_load (previously bpf_prog_alloc) hook can be
used by some LSMs to allocate extra security blob, but also by other
LSMs to reject BPF program loading, we need to make sure that
bpf_prog_free LSM hook is called after bpf_prog_load/bpf_prog_alloc one
*even* if the hook itself returned error. If we don't do that, we run
the risk of leaking memory. This seems to be possible today when
combining SELinux and BPF LSM, as one example, depending on their
relative ordering.

Also, for BPF LSM setup, add bpf_prog_load and bpf_prog_free to
sleepable LSM hooks list, as they are both executed in sleepable
context. Also drop bpf_prog_load hook from untrusted, as there is no
issue with refcount or anything else anymore, that originally forced us
to add it to untrusted list in c0c852dd1876 ("bpf: Do not mark certain LSM
hook arguments as trusted"). We now trigger this hook much later and it
should not be an issue anymore.

  [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com/

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h |  5 +++--
 include/linux/security.h      | 12 +++++++-----
 kernel/bpf/bpf_lsm.c          |  5 +++--
 kernel/bpf/syscall.c          | 25 +++++++++++++------------
 security/security.c           | 25 +++++++++++++++----------
 security/selinux/hooks.c      | 15 ++++++++-------
 6 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..370181aa685b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -406,8 +406,9 @@ LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
-LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
-LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *aux)
+LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
+	 struct bpf_token *token)
+LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..cb2932fce448 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2064,15 +2064,16 @@ static inline void securityfs_remove(struct dentry *dentry)
 union bpf_attr;
 struct bpf_map;
 struct bpf_prog;
-struct bpf_prog_aux;
+struct bpf_token;
 #ifdef CONFIG_SECURITY
 extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
 extern int security_bpf_map_alloc(struct bpf_map *map);
 extern void security_bpf_map_free(struct bpf_map *map);
-extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
-extern void security_bpf_prog_free(struct bpf_prog_aux *aux);
+extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+				  struct bpf_token *token);
+extern void security_bpf_prog_free(struct bpf_prog *prog);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2098,12 +2099,13 @@ static inline int security_bpf_map_alloc(struct bpf_map *map)
 static inline void security_bpf_map_free(struct bpf_map *map)
 { }
 
-static inline int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
+static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+					 struct bpf_token *token)
 {
 	return 0;
 }
 
-static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
+static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index e8e910395bf6..7ee0dd011de4 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -263,6 +263,8 @@ BTF_ID(func, bpf_lsm_bpf_map)
 BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
 BTF_ID(func, bpf_lsm_bpf_prog)
+BTF_ID(func, bpf_lsm_bpf_prog_load)
+BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_bprm_check_security)
 BTF_ID(func, bpf_lsm_bprm_committed_creds)
 BTF_ID(func, bpf_lsm_bprm_committing_creds)
@@ -358,8 +360,7 @@ BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
-BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
-BTF_ID(func, bpf_lsm_bpf_prog_free_security)
+BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b05d5a8f5e6b..6e64c81d591f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2180,7 +2180,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
 	free_uid(aux->user);
-	security_bpf_prog_free(aux);
+	security_bpf_prog_free(aux->prog);
 	bpf_prog_free(aux->prog);
 }
 
@@ -2772,10 +2772,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	prog->aux->token = token;
 	token = NULL;
 
-	err = security_bpf_prog_alloc(prog->aux);
-	if (err)
-		goto free_prog;
-
 	prog->aux->user = get_current_user();
 	prog->len = attr->insn_cnt;
 
@@ -2783,12 +2779,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (copy_from_bpfptr(prog->insns,
 			     make_bpfptr(attr->insns, uattr.is_kernel),
 			     bpf_prog_insn_size(prog)) != 0)
-		goto free_prog_sec;
+		goto free_prog;
 	/* copy eBPF program license from user space */
 	if (strncpy_from_bpfptr(license,
 				make_bpfptr(attr->license, uattr.is_kernel),
 				sizeof(license) - 1) < 0)
-		goto free_prog_sec;
+		goto free_prog;
 	license[sizeof(license) - 1] = 0;
 
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
@@ -2802,14 +2798,14 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err = bpf_prog_dev_bound_init(prog, attr);
 		if (err)
-			goto free_prog_sec;
+			goto free_prog;
 	}
 
 	if (type == BPF_PROG_TYPE_EXT && dst_prog &&
 	    bpf_prog_is_dev_bound(dst_prog->aux)) {
 		err = bpf_prog_dev_bound_inherit(prog, dst_prog);
 		if (err)
-			goto free_prog_sec;
+			goto free_prog;
 	}
 
 	/*
@@ -2831,12 +2827,16 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	/* find program type: socket_filter vs tracing_filter */
 	err = find_prog_type(type, prog);
 	if (err < 0)
-		goto free_prog_sec;
+		goto free_prog;
 
 	prog->aux->load_time = ktime_get_boottime_ns();
 	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
 			       sizeof(attr->prog_name));
 	if (err < 0)
+		goto free_prog;
+
+	err = security_bpf_prog_load(prog, attr, token);
+	if (err)
 		goto free_prog_sec;
 
 	/* run eBPF verifier */
@@ -2882,10 +2882,11 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	 */
 	__bpf_prog_put_noref(prog, prog->aux->real_func_cnt);
 	return err;
+
 free_prog_sec:
-	free_uid(prog->aux->user);
-	security_bpf_prog_free(prog->aux);
+	security_bpf_prog_free(prog);
 free_prog:
+	free_uid(prog->aux->user);
 	if (prog->aux->attach_btf)
 		btf_put(prog->aux->attach_btf);
 	bpf_prog_free(prog);
diff --git a/security/security.c b/security/security.c
index 0144a98d3712..eb159da4b146 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5423,16 +5423,21 @@ int security_bpf_map_alloc(struct bpf_map *map)
 }
 
 /**
- * security_bpf_prog_alloc() - Allocate a bpf program LSM blob
- * @aux: bpf program aux info struct
+ * security_bpf_prog_load() - Check if loading of BPF program is allowed
+ * @prog: BPF program object
+ * @attr: BPF syscall attributes used to create BPF program
+ * @token: BPF token used to grant user access to BPF subsystem
  *
- * Initialize the security field inside bpf program.
+ * Perform an access control check when the kernel loads a BPF program and
+ * allocates associated BPF program object. This hook is also responsible for
+ * allocating any required LSM state for the BPF program.
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
+int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+			   struct bpf_token *token)
 {
-	return call_int_hook(bpf_prog_alloc_security, 0, aux);
+	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 }
 
 /**
@@ -5447,14 +5452,14 @@ void security_bpf_map_free(struct bpf_map *map)
 }
 
 /**
- * security_bpf_prog_free() - Free a bpf program's LSM blob
- * @aux: bpf program aux info struct
+ * security_bpf_prog_free() - Free a BPF program's LSM blob
+ * @prog: BPF program struct
  *
- * Clean up the security information stored inside bpf prog.
+ * Clean up the security information stored inside BPF program.
  */
-void security_bpf_prog_free(struct bpf_prog_aux *aux)
+void security_bpf_prog_free(struct bpf_prog *prog)
 {
-	call_void_hook(bpf_prog_free_security, aux);
+	call_void_hook(bpf_prog_free, prog);
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..6d64fb189b1b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6942,7 +6942,8 @@ static void selinux_bpf_map_free(struct bpf_map *map)
 	kfree(bpfsec);
 }
 
-static int selinux_bpf_prog_alloc(struct bpf_prog_aux *aux)
+static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
+				 struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
 
@@ -6951,16 +6952,16 @@ static int selinux_bpf_prog_alloc(struct bpf_prog_aux *aux)
 		return -ENOMEM;
 
 	bpfsec->sid = current_sid();
-	aux->security = bpfsec;
+	prog->aux->security = bpfsec;
 
 	return 0;
 }
 
-static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
+static void selinux_bpf_prog_free(struct bpf_prog *prog)
 {
-	struct bpf_security_struct *bpfsec = aux->security;
+	struct bpf_security_struct *bpfsec = prog->aux->security;
 
-	aux->security = NULL;
+	prog->aux->security = NULL;
 	kfree(bpfsec);
 }
 #endif
@@ -7325,7 +7326,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
-	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
 #endif
 
 #ifdef CONFIG_PERF_EVENTS
@@ -7383,7 +7384,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 #endif
 #ifdef CONFIG_BPF_SYSCALL
 	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
-- 
2.34.1


