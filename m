Return-Path: <linux-fsdevel+bounces-222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F927C79BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 843F2B2095E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A82C848;
	Thu, 12 Oct 2023 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA242B5E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:32:27 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A4CDC
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:26 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CLuWUq031838
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:25 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpbs025hf-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:32:25 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:32:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6DF7439A3A539; Thu, 12 Oct 2023 15:29:23 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 10/18] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
Date: Thu, 12 Oct 2023 15:28:02 -0700
Message-ID: <20231012222810.4120312-11-andrii@kernel.org>
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
X-Proofpoint-GUID: mW6fZ8x0_gx3rHlL6gvvbiDazISHGz52
X-Proofpoint-ORIG-GUID: mW6fZ8x0_gx3rHlL6gvvbiDazISHGz52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similarly to bpf_prog_alloc LSM hook, rename and extend bpf_map_alloc
hook into bpf_map_create, taking not just struct bpf_map, but also
bpf_attr and bpf_token, to give a fuller context to LSMs.

Unlike bpf_prog_alloc, there is no need to move the hook around, as it
currently is firing right before allocating BPF map ID and FD, which
seems to be a sweet spot.

But like bpf_prog_alloc/bpf_prog_free combo, make sure that bpf_map_free
LSM hook is called even if bpf_map_create hook returned error, as if few
LSMs are combined together it could be that one LSM successfully
allocated security blob for its needs, while subsequent LSM rejected BPF
map creation. The former LSM would still need to free up LSM blob, so we
need to ensure security_bpf_map_free() is called regardless of the
outcome.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h |  5 +++--
 include/linux/security.h      |  6 ++++--
 kernel/bpf/bpf_lsm.c          |  6 +++---
 kernel/bpf/syscall.c          |  4 ++--
 security/security.c           | 16 ++++++++++------
 security/selinux/hooks.c      |  7 ++++---
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
index f7088a06c593..0adfb136521a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -398,8 +398,9 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *l=
smrule)
 LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
 LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
-LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
+LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *at=
tr,
+	 struct bpf_token *token)
+LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *a=
ttr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
diff --git a/include/linux/security.h b/include/linux/security.h
index b9fb101561b6..59c5fab2c4d6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2025,7 +2025,8 @@ struct bpf_token;
 extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size=
);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
-extern int security_bpf_map_alloc(struct bpf_map *map);
+extern int security_bpf_map_create(struct bpf_map *map, union bpf_attr *=
attr,
+				   struct bpf_token *token);
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr =
*attr,
 				  struct bpf_token *token);
@@ -2047,7 +2048,8 @@ static inline int security_bpf_prog(struct bpf_prog=
 *prog)
 	return 0;
 }
=20
-static inline int security_bpf_map_alloc(struct bpf_map *map)
+static inline int security_bpf_map_create(struct bpf_map *map, union bpf=
_attr *attr,
+					  struct bpf_token *token)
 {
 	return 0;
 }
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 3e956f6302f3..9e4e615f11eb 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -260,8 +260,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const st=
ruct bpf_prog *prog)
 BTF_SET_START(sleepable_lsm_hooks)
 BTF_ID(func, bpf_lsm_bpf)
 BTF_ID(func, bpf_lsm_bpf_map)
-BTF_ID(func, bpf_lsm_bpf_map_alloc_security)
-BTF_ID(func, bpf_lsm_bpf_map_free_security)
+BTF_ID(func, bpf_lsm_bpf_map_create)
+BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog)
 BTF_ID(func, bpf_lsm_bpf_prog_load)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
@@ -347,7 +347,7 @@ BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
=20
 BTF_SET_START(untrusted_lsm_hooks)
-BTF_ID(func, bpf_lsm_bpf_map_free_security)
+BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ee0fea87b17b..160571b65b41 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1285,9 +1285,9 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
=20
-	err =3D security_bpf_map_alloc(map);
+	err =3D security_bpf_map_create(map, attr, token);
 	if (err)
-		goto free_map;
+		goto free_map_sec;
=20
 	err =3D bpf_map_alloc_id(map);
 	if (err)
diff --git a/security/security.c b/security/security.c
index bc8b72325c3b..145e8082b9a6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5167,16 +5167,20 @@ int security_bpf_prog(struct bpf_prog *prog)
 }
=20
 /**
- * security_bpf_map_alloc() - Allocate a bpf map LSM blob
- * @map: bpf map
+ * security_bpf_map_create() - Check if BPF map creation is allowed
+ * @map BPF map object
+ * @attr: BPF syscall attributes used to create BPF map
+ * @token: BPF token used to grant user access
  *
- * Initialize the security field inside bpf map.
+ * Do a check when the kernel creates a new BPF map. This is also the
+ * point where LSM blob is allocated for LSMs that need them.
  *
  * Return: Returns 0 on success, error on failure.
  */
-int security_bpf_map_alloc(struct bpf_map *map)
+int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
+			    struct bpf_token *token)
 {
-	return call_int_hook(bpf_map_alloc_security, 0, map);
+	return call_int_hook(bpf_map_create, 0, map, attr, token);
 }
=20
 /**
@@ -5205,7 +5209,7 @@ int security_bpf_prog_load(struct bpf_prog *prog, u=
nion bpf_attr *attr,
  */
 void security_bpf_map_free(struct bpf_map *map)
 {
-	call_void_hook(bpf_map_free_security, map);
+	call_void_hook(bpf_map_free, map);
 }
=20
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f386adb0f27d..3d5dea4f1df0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6783,7 +6783,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 			    BPF__PROG_RUN, NULL);
 }
=20
-static int selinux_bpf_map_alloc(struct bpf_map *map)
+static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *a=
ttr,
+				  struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
=20
@@ -7180,7 +7181,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
 	LSM_HOOK_INIT(bpf, selinux_bpf),
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
+	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
 #endif
=20
@@ -7238,7 +7239,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
 	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
 #endif
 #ifdef CONFIG_BPF_SYSCALL
-	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
+	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 #endif
 #ifdef CONFIG_PERF_EVENTS
--=20
2.34.1


