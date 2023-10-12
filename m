Return-Path: <linux-fsdevel+bounces-228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504EA7C79CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6C5B20D01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80C3D019;
	Thu, 12 Oct 2023 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44002405FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:32:37 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01991CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:35 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39CLuL0s022418
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:35 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3tpbry9abt-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:35 -0700
Received: from twshared40933.03.prn6.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:32:31 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 7A4A139A3A544; Thu, 12 Oct 2023 15:29:25 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 11/18] bpf,lsm: add bpf_token_create and bpf_token_free LSM hooks
Date: Thu, 12 Oct 2023 15:28:03 -0700
Message-ID: <20231012222810.4120312-12-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012222810.4120312-1-andrii@kernel.org>
References: <20231012222810.4120312-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0q9-BgVhRTir0HiPe9x153-IViS9gDmo
X-Proofpoint-ORIG-GUID: 0q9-BgVhRTir0HiPe9x153-IViS9gDmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wire up bpf_token_create and bpf_token_free LSM hooks, which allow to
allocate LSM security blob (we add `void *security` field to struct
bpf_token for that), but also control who can instantiate BPF token.
This follows existing pattern for BPF map and BPF prog.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h           |  3 +++
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      | 11 +++++++++++
 kernel/bpf/bpf_lsm.c          |  2 ++
 kernel/bpf/token.c            |  6 ++++++
 security/security.c           | 28 ++++++++++++++++++++++++++++
 6 files changed, 53 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c87af564f464..dfcac60f1857 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1585,6 +1585,9 @@ struct bpf_token {
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
index 0adfb136521a..d776c9b7b856 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -404,6 +404,9 @@ LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf=
_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *a=
ttr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
+LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_at=
tr *attr,
+	 struct path *path)
+LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
 #endif /* CONFIG_BPF_SYSCALL */
=20
 LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
diff --git a/include/linux/security.h b/include/linux/security.h
index 59c5fab2c4d6..b9cb1446bb78 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2031,6 +2031,9 @@ extern void security_bpf_map_free(struct bpf_map *m=
ap);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr =
*attr,
 				  struct bpf_token *token);
 extern void security_bpf_prog_free(struct bpf_prog *prog);
+extern int security_bpf_token_create(struct bpf_token *token, union bpf_=
attr *attr,
+				     struct path *path);
+extern void security_bpf_token_free(struct bpf_token *token);
 #else
 static inline int security_bpf(int cmd, union bpf_attr *attr,
 					     unsigned int size)
@@ -2065,6 +2068,14 @@ static inline int security_bpf_prog_load(struct bp=
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
+static inline void security_bpf_token_free(struct bpf_token *token)
+{ }
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
=20
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 9e4e615f11eb..2a019528953e 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -265,6 +265,8 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog)
 BTF_ID(func, bpf_lsm_bpf_prog_load)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
+BTF_ID(func, bpf_lsm_bpf_token_create)
+BTF_ID(func, bpf_lsm_bpf_token_free)
 BTF_ID(func, bpf_lsm_bprm_check_security)
 BTF_ID(func, bpf_lsm_bprm_committed_creds)
 BTF_ID(func, bpf_lsm_bprm_committing_creds)
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index d4e0cc8075d3..18fd1e04f92d 100644
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
@@ -28,6 +29,7 @@ void bpf_token_inc(struct bpf_token *token)
=20
 static void bpf_token_free(struct bpf_token *token)
 {
+	security_bpf_token_free(token);
 	put_user_ns(token->userns);
 	kvfree(token);
 }
@@ -183,6 +185,10 @@ int bpf_token_create(union bpf_attr *attr)
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
diff --git a/security/security.c b/security/security.c
index 145e8082b9a6..83a2403b7261 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5201,6 +5201,23 @@ int security_bpf_prog_load(struct bpf_prog *prog, =
union bpf_attr *attr,
 	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 }
=20
+/**
+ * security_bpf_token_create() - Check if creating of BPF token is allow=
ed
+ * @token BPF token object
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
 /**
  * security_bpf_map_free() - Free a bpf map's LSM blob
  * @map: bpf map
@@ -5222,6 +5239,17 @@ void security_bpf_prog_free(struct bpf_prog *prog)
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


