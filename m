Return-Path: <linux-fsdevel+bounces-7286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51B8237CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63992B239DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD481EB33;
	Wed,  3 Jan 2024 22:21:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14292208BE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GiIgp027336
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:21:15 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcxn2pp0j-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:21:15 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:21:06 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 3947D3DF9EACA; Wed,  3 Jan 2024 14:20:54 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 09/29] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free LSM hooks
Date: Wed, 3 Jan 2024 14:20:14 -0800
Message-ID: <20240103222034.2582628-10-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: kc9Bb-LFhZdxYO3zasGWofU6G1nfp2Jk
X-Proofpoint-GUID: kc9Bb-LFhZdxYO3zasGWofU6G1nfp2Jk
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

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

  [0] https://lore.kernel.org/bpf/9fe88aef7deabbe87d3fc38c4aea3c69.paul@pau=
l-moore.com/

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
index ff217a5ce552..41ec4a7c070e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -400,8 +400,9 @@ LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t =
fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
 LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
 LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
-LSM_HOOK(int, 0, bpf_prog_alloc_security, struct bpf_prog_aux *aux)
-LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free_security, struct bpf_prog_aux *=
aux)
+LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *att=
r,
+	 struct bpf_token *token)
+LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
 #endif /* CONFIG_BPF_SYSCALL */
=20
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1d1df326c881..65467eef6678 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2020,15 +2020,16 @@ static inline void securityfs_remove(struct dentry =
*dentry)
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
+extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *a=
ttr,
+				  struct bpf_token *token);
+extern void security_bpf_prog_free(struct bpf_prog *prog);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2054,12 +2055,13 @@ static inline int security_bpf_map_alloc(struct bpf=
_map *map)
 static inline void security_bpf_map_free(struct bpf_map *map)
 { }
=20
-static inline int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
+static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_=
attr *attr,
+					 struct bpf_token *token)
 {
 	return 0;
 }
=20
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
=20
 BTF_SET_START(untrusted_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf_map_free_security)
-BTF_ID(func, bpf_lsm_bpf_prog_alloc_security)
-BTF_ID(func, bpf_lsm_bpf_prog_free_security)
+BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a236a2cb7ac1..19a0d5dd4d7e 100644
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
=20
@@ -2772,10 +2772,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfpt=
r_t uattr, u32 uattr_size)
 	prog->aux->token =3D token;
 	token =3D NULL;
=20
-	err =3D security_bpf_prog_alloc(prog->aux);
-	if (err)
-		goto free_prog;
-
 	prog->aux->user =3D get_current_user();
 	prog->len =3D attr->insn_cnt;
=20
@@ -2783,12 +2779,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 	if (copy_from_bpfptr(prog->insns,
 			     make_bpfptr(attr->insns, uattr.is_kernel),
 			     bpf_prog_insn_size(prog)) !=3D 0)
-		goto free_prog_sec;
+		goto free_prog;
 	/* copy eBPF program license from user space */
 	if (strncpy_from_bpfptr(license,
 				make_bpfptr(attr->license, uattr.is_kernel),
 				sizeof(license) - 1) < 0)
-		goto free_prog_sec;
+		goto free_prog;
 	license[sizeof(license) - 1] =3D 0;
=20
 	/* eBPF programs must be GPL compatible to use GPL-ed functions */
@@ -2802,25 +2798,29 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
 	if (bpf_prog_is_dev_bound(prog->aux)) {
 		err =3D bpf_prog_dev_bound_init(prog, attr);
 		if (err)
-			goto free_prog_sec;
+			goto free_prog;
 	}
=20
 	if (type =3D=3D BPF_PROG_TYPE_EXT && dst_prog &&
 	    bpf_prog_is_dev_bound(dst_prog->aux)) {
 		err =3D bpf_prog_dev_bound_inherit(prog, dst_prog);
 		if (err)
-			goto free_prog_sec;
+			goto free_prog;
 	}
=20
 	/* find program type: socket_filter vs tracing_filter */
 	err =3D find_prog_type(type, prog);
 	if (err < 0)
-		goto free_prog_sec;
+		goto free_prog;
=20
 	prog->aux->load_time =3D ktime_get_boottime_ns();
 	err =3D bpf_obj_name_cpy(prog->aux->name, attr->prog_name,
 			       sizeof(attr->prog_name));
 	if (err < 0)
+		goto free_prog;
+
+	err =3D security_bpf_prog_load(prog, attr, token);
+	if (err)
 		goto free_prog_sec;
=20
 	/* run eBPF verifier */
@@ -2866,10 +2866,11 @@ static int bpf_prog_load(union bpf_attr *attr, bpfp=
tr_t uattr, u32 uattr_size)
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
index dcb3e7014f9b..c8a1c66cfaad 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5180,16 +5180,21 @@ int security_bpf_map_alloc(struct bpf_map *map)
 }
=20
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
+ * allocates associated BPF program object. This hook is also responsible =
for
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
=20
 /**
@@ -5204,14 +5209,14 @@ void security_bpf_map_free(struct bpf_map *map)
 }
=20
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
=20
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 340b2bbbb2dd..c2de56ca5ea5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6799,7 +6799,8 @@ static void selinux_bpf_map_free(struct bpf_map *map)
 	kfree(bpfsec);
 }
=20
-static int selinux_bpf_prog_alloc(struct bpf_prog_aux *aux)
+static int selinux_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *at=
tr,
+				 struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
=20
@@ -6808,16 +6809,16 @@ static int selinux_bpf_prog_alloc(struct bpf_prog_a=
ux *aux)
 		return -ENOMEM;
=20
 	bpfsec->sid =3D current_sid();
-	aux->security =3D bpfsec;
+	prog->aux->security =3D bpfsec;
=20
 	return 0;
 }
=20
-static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
+static void selinux_bpf_prog_free(struct bpf_prog *prog)
 {
-	struct bpf_security_struct *bpfsec =3D aux->security;
+	struct bpf_security_struct *bpfsec =3D prog->aux->security;
=20
-	aux->security =3D NULL;
+	prog->aux->security =3D NULL;
 	kfree(bpfsec);
 }
 #endif
@@ -7174,7 +7175,7 @@ static struct security_hook_list selinux_hooks[] __ro=
_after_init =3D {
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
-	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
+	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
 #endif
=20
 #ifdef CONFIG_PERF_EVENTS
@@ -7232,7 +7233,7 @@ static struct security_hook_list selinux_hooks[] __ro=
_after_init =3D {
 #endif
 #ifdef CONFIG_BPF_SYSCALL
 	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
-	LSM_HOOK_INIT(bpf_prog_alloc_security, selinux_bpf_prog_alloc),
+	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 #endif
 #ifdef CONFIG_PERF_EVENTS
 	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
--=20
2.34.1


