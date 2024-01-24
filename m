Return-Path: <linux-fsdevel+bounces-8649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8605839ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A6E287869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250D113AD4;
	Wed, 24 Jan 2024 02:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agI5NkaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA28523F;
	Wed, 24 Jan 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062932; cv=none; b=Chrxkl9UyqpNljBagIe2HBavKo+lSZ8G669Z3Mv5HqkduZmxf/G3nEdvzb9EV1XN6DncJg+jEc9siRuYkB0463nYflXHuL53Wc1AiiRBg4MoFRtLNCCBuuZJUYM7vfrEcZ72b0oD77LWO7qdIKoDp+ajgQoii537P0fFyQbJQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062932; c=relaxed/simple;
	bh=Xtw+UTgOwWFnQXcFlbGdeQXEJ5jODRqkakY4v5A1ZFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ineEV9qEBh2m0cZ9IZKygzk67xiGDrfI2Op4wt0KzFYMesdqqFWJ1n+PXzDn1xdnzbG4QKaAc6sTSNTjrK0mg/D9RTurCI13cWJT3cIVNcAlZwV/AIS/F35xZw0FbsxxpsKofJHcskE3NrD8MPNCuhhW5PXkfrg6JBH3blWWgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agI5NkaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157F5C433C7;
	Wed, 24 Jan 2024 02:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062932;
	bh=Xtw+UTgOwWFnQXcFlbGdeQXEJ5jODRqkakY4v5A1ZFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agI5NkaZfR6nOAHaWEaIWMbPLUZBJUDsDK/ws92KSOmcdT1At6jbU4he3Vnu5tG5E
	 rHXVvm+S2tbzWIIgWwTNOMgRahuLBfkmth/8esNxZXrE4Fdavl4UFBePBEwXSZgrGV
	 04m+JsI6HJoNT1Y2vinxDXP0QXqDA1+6ZtroiW0mz56P+oEtjQxAuU43gNu1AmoUGv
	 +Zbw/KvjnbE7VD7+JKZMVtGGaaLG7mPhQB+BGTaHyLLtsw7eTN1f8KiCPgNatIllvw
	 aJIuLJKk7QknK+k2nD/efOfB/2bNjJCtwlQbjHfZSu2a1wkUh7fjEPOxbl/WY3SiI/
	 un/uc6DjXZJxw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 11/30] bpf,lsm: add BPF token LSM hooks
Date: Tue, 23 Jan 2024 18:21:08 -0800
Message-Id: <20240124022127.2379740-12-andrii@kernel.org>
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
 kernel/bpf/token.c            | 12 ++++++-
 security/security.c           | 60 +++++++++++++++++++++++++++++++++++
 6 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1b556c74f43f..2a184a847381 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1634,6 +1634,9 @@ struct bpf_token {
 	u64 allowed_maps;
 	u64 allowed_progs;
 	u64 allowed_attachs;
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 };
 
 struct bpf_struct_ops_value;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1be4d3ca6efb..cd6fbc7af3f8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -410,6 +410,11 @@ LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
+LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr,
+	 struct path *path)
+LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
+LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
+LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
 #endif /* CONFIG_BPF_SYSCALL */
 
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 83fcdc974116..15804af54f37 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -32,6 +32,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/sockptr.h>
+#include <linux/bpf.h>
 #include <uapi/linux/lsm.h>
 
 struct linux_binprm;
@@ -2075,6 +2076,11 @@ extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				  struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
+extern int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+				     struct path *path);
+extern void security_bpf_token_free(struct bpf_token *token);
+extern int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+extern int security_bpf_token_capable(const struct bpf_token *token, int cap);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2109,6 +2115,25 @@ static inline int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *
 
 static inline void security_bpf_prog_free(struct bpf_prog *prog)
 { }
+
+static inline int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
+				     struct path *path)
+{
+	return 0;
+}
+
+static inline void security_bpf_token_free(struct bpf_token *token)
+{ }
+
+static inline int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	return 0;
+}
+
+static inline int security_bpf_token_capable(const struct bpf_token *token, int cap)
+{
+	return 0;
+}
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
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
index c13c73788d8c..64c568f47f69 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -7,6 +7,7 @@
 #include <linux/idr.h>
 #include <linux/namei.h>
 #include <linux/user_namespace.h>
+#include <linux/security.h>
 
 static bool bpf_ns_capable(struct user_namespace *ns, int cap)
 {
@@ -21,6 +22,8 @@ bool bpf_token_capable(const struct bpf_token *token, int cap)
 	userns = token ? token->userns : &init_user_ns;
 	if (!bpf_ns_capable(userns, cap))
 		return false;
+	if (token && security_bpf_token_capable(token, cap) < 0)
+		return false;
 	return true;
 }
 
@@ -31,6 +34,7 @@ void bpf_token_inc(struct bpf_token *token)
 
 static void bpf_token_free(struct bpf_token *token)
 {
+	security_bpf_token_free(token);
 	put_user_ns(token->userns);
 	kfree(token);
 }
@@ -193,6 +197,10 @@ int bpf_token_create(union bpf_attr *attr)
 	token->allowed_progs = mnt_opts->delegate_progs;
 	token->allowed_attachs = mnt_opts->delegate_attachs;
 
+	err = security_bpf_token_create(token, attr, &path);
+	if (err)
+		goto out_token;
+
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
 		err = fd;
@@ -237,7 +245,9 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
 {
 	if (!token)
 		return false;
-	return token->allowed_cmds & (1ULL << cmd);
+	if (!(token->allowed_cmds & (1ULL << cmd)))
+		return false;
+	return security_bpf_token_cmd(token, cmd) == 0;
 }
 
 bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type)
diff --git a/security/security.c b/security/security.c
index 26fcab35b6cd..73e009e3d937 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5444,6 +5444,55 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 }
 
+/**
+ * security_bpf_token_create() - Check if creating of BPF token is allowed
+ * @token: BPF token object
+ * @attr: BPF syscall attributes used to create BPF token
+ * @path: path pointing to BPF FS mount point from which BPF token is created
+ *
+ * Do a check when the kernel instantiates a new BPF token object from BPF FS
+ * instance. This is also the point where LSM blob can be allocated for LSMs.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_create(struct bpf_token *token, union bpf_attr *attr,
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
+ * Do a check when the kernel decides whether provided BPF token should allow
+ * delegation of requested BPF syscall command.
+ *
+ * Return: Returns 0 on success, error on failure.
+ */
+int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
+{
+	return call_int_hook(bpf_token_cmd, 0, token, cmd);
+}
+
+/**
+ * security_bpf_token_capable() - Check if BPF token is allowed to delegate
+ * requested BPF-related capability
+ * @token: BPF token object
+ * @cap: capabilities requested to be delegated by BPF token
+ *
+ * Do a check when the kernel decides whether provided BPF token should allow
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
@@ -5465,6 +5514,17 @@ void security_bpf_prog_free(struct bpf_prog *prog)
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
 
 /**
-- 
2.34.1


