Return-Path: <linux-fsdevel+bounces-7290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D2B8237E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081EB2868D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307632030A;
	Wed,  3 Jan 2024 22:23:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DA01DA44
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GkdPs023083
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:23:44 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcvqhf413-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:23:43 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 06DF63DF9EAF3; Wed,  3 Jan 2024 14:20:58 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 11/29] bpf,lsm: add BPF token LSM hooks
Date: Wed, 3 Jan 2024 14:20:16 -0800
Message-ID: <20240103222034.2582628-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103222034.2582628-1-andrii@kernel.org>
References: <20240103222034.2582628-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: i8ZgLjfUa7f-F-a-kcBfp_Pfne0r7HzC
X-Proofpoint-ORIG-GUID: i8ZgLjfUa7f-F-a-kcBfp_Pfne0r7HzC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
allocate LSM security blob (we add `void *security` field to struct
bpf_token for that), but also control who can instantiate BPF token.
This follows existing pattern for BPF map and BPF prog.

Also add security_bpf_token_allow_cmd() and security_bpf_token_capable()
LSM hooks that allow LSM implementation to control and negate (if
necessary) BPF token's delegation of a specific bpf_cmd and capability,
respectively.

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h           |  3 ++
 include/linux/lsm_hook_defs.h |  5 +++
 include/linux/security.h      | 25 +++++++++++++++
 kernel/bpf/bpf_lsm.c          |  4 +++
 kernel/bpf/token.c            | 18 +++++++----
 security/security.c           | 60 +++++++++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d1023cd67f65..778d07bb7240 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1633,6 +1633,9 @@ struct bpf_token {
 	u64 allowed_maps;
 	u64 allowed_progs;
 	u64 allowed_attachs;
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 };
=20
 struct bpf_struct_ops_value;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
index adb25cc63ce3..3fdd00b452ac 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -404,6 +404,11 @@ LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bp=
f_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *a=
ttr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
+LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_at=
tr *attr,
+	 struct path *path)
+LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
+LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_=
cmd cmd)
+LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int c=
ap)
 #endif /* CONFIG_BPF_SYSCALL */
=20
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 08fd777cbe94..00809d2d5c38 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <linux/bpf.h>
=20
 struct linux_binprm;
 struct cred;
@@ -2031,6 +2032,11 @@ extern void security_bpf_map_free(struct bpf_map *=
map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr =
*attr,
 				  struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
+extern int security_bpf_token_create(struct bpf_token *token, union bpf_=
attr *attr,
+				     struct path *path);
+extern void security_bpf_token_free(struct bpf_token *token);
+extern int security_bpf_token_cmd(const struct bpf_token *token, enum bp=
f_cmd cmd);
+extern int security_bpf_token_capable(const struct bpf_token *token, int=
 cap);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2065,6 +2071,25 @@ static inline int security_bpf_prog_load(struct bp=
f_prog *prog, union bpf_attr *
=20
 static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
+
+static inline int security_bpf_token_create(struct bpf_token *token, uni=
on bpf_attr *attr,
+				     struct path *path)
+{
+	return 0;
+}
+
+static inline void security_bpf_token_free(struct bpf_token *token)
+{ }
+
+static inline int security_bpf_token_cmd(const struct bpf_token *token, =
enum bpf_cmd cmd)
+{
+	return 0;
+}
+
+static inline int security_bpf_token_capable(const struct bpf_token *tok=
en, int cap)
+{
+	return 0;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
=20
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 76976908b302..63b4dc495125 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -265,6 +265,10 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog)
 BTF_ID(func, bpf_lsm_bpf_prog_load)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
+BTF_ID(func, bpf_lsm_bpf_token_create)
+BTF_ID(func, bpf_lsm_bpf_token_free)
+BTF_ID(func, bpf_lsm_bpf_token_cmd)
+BTF_ID(func, bpf_lsm_bpf_token_capable)
 BTF_ID(func, bpf_lsm_bprm_check_security)
 BTF_ID(func, bpf_lsm_bprm_committed_creds)
 BTF_ID(func, bpf_lsm_bprm_committing_creds)
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 5a51e6b8f6bf..17212efcde60 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -7,6 +7,7 @@
 #include <linux/idr.h>
 #include <linux/namei.h>
 #include <linux/user_namespace.h>
+#include <linux/security.h>
=20
 bool bpf_token_capable(const struct bpf_token *token, int cap)
 {
@@ -14,10 +15,9 @@ bool bpf_token_capable(const struct bpf_token *token, =
int cap)
 	 * token's userns is *exactly* the same as current user's userns
 	 */
 	if (token && current_user_ns() =3D=3D token->userns) {
-		if (ns_capable(token->userns, cap))
-			return true;
-		if (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN)=
)
-			return true;
+		if (ns_capable(token->userns, cap) ||
+		    (cap !=3D CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN=
)))
+			return security_bpf_token_capable(token, cap) =3D=3D 0;
 	}
 	/* otherwise fallback to capable() checks */
 	return capable(cap) || (cap !=3D CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN=
));
@@ -30,6 +30,7 @@ void bpf_token_inc(struct bpf_token *token)
=20
 static void bpf_token_free(struct bpf_token *token)
 {
+	security_bpf_token_free(token);
 	put_user_ns(token->userns);
 	kvfree(token);
 }
@@ -186,6 +187,10 @@ int bpf_token_create(union bpf_attr *attr)
 	token->allowed_progs =3D mnt_opts->delegate_progs;
 	token->allowed_attachs =3D mnt_opts->delegate_attachs;
=20
+	err =3D security_bpf_token_create(token, attr, &path);
+	if (err)
+		goto out_token;
+
 	fd =3D get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		err =3D fd;
@@ -233,8 +238,9 @@ bool bpf_token_allow_cmd(const struct bpf_token *toke=
n, enum bpf_cmd cmd)
 	 */
 	if (!token || current_user_ns() !=3D token->userns)
 		return false;
-
-	return token->allowed_cmds & (1ULL << cmd);
+	if (!(token->allowed_cmds & (1ULL << cmd)))
+		return false;
+	return security_bpf_token_cmd(token, cmd) =3D=3D 0;
 }
=20
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_ma=
p_type type)
diff --git a/security/security.c b/security/security.c
index ad24cf36da94..088a79c35c26 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5201,6 +5201,55 @@ int security_bpf_prog_load(struct bpf_prog *prog, =
union bpf_attr *attr,
 	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 }
=20
+/**
+ * security_bpf_token_create() - Check if creating of BPF token is allow=
ed
+ * @token: BPF token object
+ * @attr: BPF syscall attributes used to create BPF token
+ * @path: path pointing to BPF FS mount point from which BPF token is cr=
eated
+ *
+ * Do a check when the kernel instantiates a new BPF token object from B=
PF FS
+ * instance. This is also the point where LSM blob can be allocated for =
LSMs.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_create(struct bpf_token *token, union bpf_attr *a=
ttr,
+			      struct path *path)
+{
+	return call_int_hook(bpf_token_create, 0, token, attr, path);
+}
+
+/**
+ * security_bpf_token_cmd() - Check if BPF token is allowed to delegate
+ * requested BPF syscall command
+ * @token: BPF token object
+ * @cmd: BPF syscall command requested to be delegated by BPF token
+ *
+ * Do a check when the kernel decides whether provided BPF token should =
allow
+ * delegation of requested BPF syscall command.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd c=
md)
+{
+	return call_int_hook(bpf_token_cmd, 0, token, cmd);
+}
+
+/**
+ * security_bpf_token_capable() - Check if BPF token is allowed to deleg=
ate
+ * requested BPF-related capability
+ * @token: BPF token object
+ * @cap: capabilities requested to be delegated by BPF token
+ *
+ * Do a check when the kernel decides whether provided BPF token should =
allow
+ * delegation of requested BPF-related capabilities.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return call_int_hook(bpf_token_capable, 0, token, cap);
+}
+
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
  * @map: bpf map
@@ -5222,6 +5271,17 @@ void security_bpf_prog_free(struct bpf_prog *prog)
 {
 	call_void_hook(bpf_prog_free, prog);
 }
+
+/**
+ * security_bpf_token_free() - Free a BPF token's LSM blob
+ * @token: BPF token struct
+ *
+ * Clean up the security information stored inside BPF token.
+ */
+void security_bpf_token_free(struct bpf_token *token)
+{
+	call_void_hook(bpf_token_free, token);
+}
 #endif /* CONFIG_BPF_SYSCALL */
=20
 /**
--=20
2.34.1


