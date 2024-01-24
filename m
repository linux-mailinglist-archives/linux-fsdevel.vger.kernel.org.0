Return-Path: <linux-fsdevel+bounces-8648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D386839ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6921F25AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87E5FBF4;
	Wed, 24 Jan 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uio6QoV7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F02F9D3;
	Wed, 24 Jan 2024 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062929; cv=none; b=fIMy0QJcBYHCnpyqvTMgKHTxebVLBGiGsg2SpPYr0VOFBcqwCfUUaHH7cwqBmhiFGJ/UtEWkoEhhow3LoRblMGiFCdaOP1UPHMNS8Qt1NkRUVW8yKqQJXPcEbgnsOQdlokpYyGbdPMFP+HtMrF7Td7olYEmPmtfoi8tgkaeYWxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062929; c=relaxed/simple;
	bh=Xg+1O3WLEmvRnnkF/9CTgg2GV+ijaNjd6AsUtATDB8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al7eNJ8NwqRK9JrMv9bonhGDMAXfJssYQ8N+6/3iNdzvZ6D81CllDtg6G58aF8Eim7V4zhi5k91NsXAT9Wfo+OtjutBVjrJPzsmx9Xfh45zDoe5Xc0foCnvNCj+mt+SahXkPRco/1itt6AijlwgmrNjzoznwJ8zLX+t9j2HpupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uio6QoV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF7AC433F1;
	Wed, 24 Jan 2024 02:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062928;
	bh=Xg+1O3WLEmvRnnkF/9CTgg2GV+ijaNjd6AsUtATDB8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uio6QoV7xG01Vty4joZg4U5+vOQERAuNeldXl3ul/X0s9dALJyfp+aCLw3bhZSEUw
	 mC71FguqDJ69D8LZ2ibinv8qfBas7xhoT7NcHHP0rVp7h8UHghjbw4xpIqEzka3Epn
	 XRj7GGPtKRDjj8yrDeAZQAizXG2C7aXbg5IziPuKvM3Xv5zXIOuqA3Pu2WU9GMa0aC
	 yurc5kQg3/XbdfOc/P2R/SUmF1TyvbAeNFo53mI+KqiK0qDcna/NUklO73ivLqwKBP
	 +1TbM1hVNAA5TPwP3Ullgh9KV/YrBEIIR57sOveUILjNp9hMkcb4x1BNUJ3HJPUlUz
	 yqsOUuYilNRAw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 10/30] bpf,lsm: refactor bpf_map_alloc/bpf_map_free LSM hooks
Date: Tue, 23 Jan 2024 18:21:07 -0800
Message-Id: <20240124022127.2379740-11-andrii@kernel.org>
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

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/lsm_hook_defs.h |  5 +++--
 include/linux/security.h      |  6 ++++--
 kernel/bpf/bpf_lsm.c          |  6 +++---
 kernel/bpf/syscall.c          |  4 ++--
 security/security.c           | 16 ++++++++++------
 security/selinux/hooks.c      |  7 ++++---
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 370181aa685b..1be4d3ca6efb 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -404,8 +404,9 @@ LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
 LSM_HOOK(int, 0, bpf, int cmd, union bpf_attr *attr, unsigned int size)
 LSM_HOOK(int, 0, bpf_map, struct bpf_map *map, fmode_t fmode)
 LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
-LSM_HOOK(int, 0, bpf_map_alloc_security, struct bpf_map *map)
-LSM_HOOK(void, LSM_RET_VOID, bpf_map_free_security, struct bpf_map *map)
+LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *attr,
+	 struct bpf_token *token)
+LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
 LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
 	 struct bpf_token *token)
 LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
diff --git a/include/linux/security.h b/include/linux/security.h
index cb2932fce448..83fcdc974116 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2069,7 +2069,8 @@ struct bpf_token;
 extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
 extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
 extern int security_bpf_prog(struct bpf_prog *prog);
-extern int security_bpf_map_alloc(struct bpf_map *map);
+extern int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
+				   struct bpf_token *token);
 extern void security_bpf_map_free(struct bpf_map *map);
 extern int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 				  struct bpf_token *token);
@@ -2091,7 +2092,8 @@ static inline int security_bpf_prog(struct bpf_prog *prog)
 	return 0;
 }
 
-static inline int security_bpf_map_alloc(struct bpf_map *map)
+static inline int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
+					  struct bpf_token *token)
 {
 	return 0;
 }
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 7ee0dd011de4..76976908b302 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -260,8 +260,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -359,7 +359,7 @@ BTF_ID(func, bpf_lsm_userns_create)
 BTF_SET_END(sleepable_lsm_hooks)
 
 BTF_SET_START(untrusted_lsm_hooks)
-BTF_ID(func, bpf_lsm_bpf_map_free_security)
+BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6e64c81d591f..266fac7c9ccf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1318,9 +1318,9 @@ static int map_create(union bpf_attr *attr)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_alloc(map);
+	err = security_bpf_map_create(map, attr, token);
 	if (err)
-		goto free_map;
+		goto free_map_sec;
 
 	err = bpf_map_alloc_id(map);
 	if (err)
diff --git a/security/security.c b/security/security.c
index eb159da4b146..26fcab35b6cd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5410,16 +5410,20 @@ int security_bpf_prog(struct bpf_prog *prog)
 }
 
 /**
- * security_bpf_map_alloc() - Allocate a bpf map LSM blob
- * @map: bpf map
+ * security_bpf_map_create() - Check if BPF map creation is allowed
+ * @map: BPF map object
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
 
 /**
@@ -5448,7 +5452,7 @@ int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
  */
 void security_bpf_map_free(struct bpf_map *map)
 {
-	call_void_hook(bpf_map_free_security, map);
+	call_void_hook(bpf_map_free, map);
 }
 
 /**
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6d64fb189b1b..3d336a7952f7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6920,7 +6920,8 @@ static int selinux_bpf_prog(struct bpf_prog *prog)
 			    BPF__PROG_RUN, NULL);
 }
 
-static int selinux_bpf_map_alloc(struct bpf_map *map)
+static int selinux_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
+				  struct bpf_token *token)
 {
 	struct bpf_security_struct *bpfsec;
 
@@ -7325,7 +7326,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf, selinux_bpf),
 	LSM_HOOK_INIT(bpf_map, selinux_bpf_map),
 	LSM_HOOK_INIT(bpf_prog, selinux_bpf_prog),
-	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
+	LSM_HOOK_INIT(bpf_map_free, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free, selinux_bpf_prog_free),
 #endif
 
@@ -7383,7 +7384,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(audit_rule_init, selinux_audit_rule_init),
 #endif
 #ifdef CONFIG_BPF_SYSCALL
-	LSM_HOOK_INIT(bpf_map_alloc_security, selinux_bpf_map_alloc),
+	LSM_HOOK_INIT(bpf_map_create, selinux_bpf_map_create),
 	LSM_HOOK_INIT(bpf_prog_load, selinux_bpf_prog_load),
 #endif
 #ifdef CONFIG_PERF_EVENTS
-- 
2.34.1


