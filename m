Return-Path: <linux-fsdevel+bounces-8642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DE839EB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0189FB28092
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8EBA2C;
	Wed, 24 Jan 2024 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRxaWJLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A946AD4D;
	Wed, 24 Jan 2024 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062907; cv=none; b=qlrSpncHloLJWPSbwHRW+BGr3TkFB8IEIYH6GRgEDgbiyAq01JVHoo2QImemh2uSdJGxbxM3eTCYHDR8vF2Fna6xE/eTFcitrSErs4+EPHs5FKCKORxDaFPAOtk1/4G+RgL6+EOBMsweLaSoe0Uuh5V18meJpfQrleDpCECGS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062907; c=relaxed/simple;
	bh=GPkoXyIEH6iSkgXDnv6dJGbvYnHBGmsnYRvo25cKQpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1AHECHd/IZIQR07iQzOCVX0vR2+hdmaIFcwbhbL3rRwM8BR4N7zHuenUAlWTBXuuni8GU/qlM0T473LxCvrMG18F92ZAS5jX3kOvpHdGyUdUN31RJ5HpJencHfKkGMYqpHDtRaPDVxAxFAV7+tJDyBTG5sOKmRVjPPZRFl09WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRxaWJLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4306CC433F1;
	Wed, 24 Jan 2024 02:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062906;
	bh=GPkoXyIEH6iSkgXDnv6dJGbvYnHBGmsnYRvo25cKQpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRxaWJLGYAzGxgNlaJydQSMh/2XSaWSQycabfL8fDCxZ97+LRY8M6zNDwTkscp1F+
	 fdl1CWbJW9NNUBVyPfVHpJay1g8/lo6gechrKtG0ytOuhE0R+ue9ZWmWCrH4YDPQLE
	 wePMxVNiJTOcOtPZ252p0QKccKJjKRy5zAlQ4m7x4ZabYKUAnuYMlm/CJedXIE4IoD
	 6wae/MT7mgWYZ8vINH/GW9jZzTffMbVEyNkzJRQxqLMtwis2GuFnPAjILKV1LWq143
	 x0ZGkLmaLS8iC7hhhkfTgi5B1pUUaUbrO38gHoPWeUpQ7cUq3TzWS7Hn1WNPW/2wDe
	 vtE4X94ecRIVg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 04/30] bpf: add BPF token support to BPF_MAP_CREATE command
Date: Tue, 23 Jan 2024 18:21:01 -0800
Message-Id: <20240124022127.2379740-5-andrii@kernel.org>
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

Allow providing token_fd for BPF_MAP_CREATE command to allow controlled
BPF map creation from unprivileged process through delegated BPF token.
New BPF_F_TOKEN_FD flag is added to specify together with BPF token FD
for BPF_MAP_CREATE command.

Wire through a set of allowed BPF map types to BPF token, derived from
BPF FS at BPF token creation time. This, in combination with allowed_cmds
allows to create a narrowly-focused BPF token (controlled by privileged
agent) with a restrictive set of BPF maps that application can attempt
to create.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h                           |  2 +
 include/uapi/linux/bpf.h                      |  7 +++
 kernel/bpf/inode.c                            |  3 +-
 kernel/bpf/syscall.c                          | 59 ++++++++++++++-----
 kernel/bpf/token.c                            | 16 +++++
 tools/include/uapi/linux/bpf.h                |  7 +++
 .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
 .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
 8 files changed, 84 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cd56840b67d1..3afcb6435566 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1630,6 +1630,7 @@ struct bpf_token {
 	atomic64_t refcnt;
 	struct user_namespace *userns;
 	u64 allowed_cmds;
+	u64 allowed_maps;
 };
 
 struct bpf_struct_ops_value;
@@ -2268,6 +2269,7 @@ int bpf_token_create(union bpf_attr *attr);
 struct bpf_token *bpf_token_get_from_fd(u32 ufd);
 
 bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd);
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type);
 
 int bpf_obj_pin_user(u32 ufd, int path_fd, const char __user *pathname);
 int bpf_obj_get_user(int path_fd, const char __user *pathname, int flags);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 353d136563a9..62f8be885731 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -983,6 +983,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
 
 /* Note that tracing related programs such as
@@ -1362,6 +1363,8 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+/* BPF token FD is passed in a corresponding command's token_fd field */
+	BPF_F_TOKEN_FD          = (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1435,6 +1438,10 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		/* BPF token FD to use with BPF_MAP_CREATE operation.
+		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32	map_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 565be1f3f1ea..034b7e4d8f19 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -620,7 +620,8 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	else if (opts->delegate_cmds)
 		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
 
-	if (opts->delegate_maps == ~0ULL)
+	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((opts->delegate_maps & mask) == mask)
 		seq_printf(m, ",delegate_maps=any");
 	else if (opts->delegate_maps)
 		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3ad88e9def4d..5144c046c52a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1011,8 +1011,8 @@ int map_check_no_btf(const struct bpf_map *map,
 	return -ENOTSUPP;
 }
 
-static int map_check_btf(struct bpf_map *map, const struct btf *btf,
-			 u32 btf_key_id, u32 btf_value_id)
+static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
+			 const struct btf *btf, u32 btf_key_id, u32 btf_value_id)
 {
 	const struct btf_type *key_type, *value_type;
 	u32 key_size, value_size;
@@ -1040,7 +1040,7 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
 
-		if (!bpf_capable()) {
+		if (!bpf_token_capable(token, CAP_BPF)) {
 			ret = -EPERM;
 			goto free_map_tab;
 		}
@@ -1128,14 +1128,16 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
 	const struct bpf_map_ops *ops;
+	struct bpf_token *token = NULL;
 	int numa_node = bpf_map_attr_numa_node(attr);
 	u32 map_type = attr->map_type;
 	struct bpf_map *map;
+	bool token_flag;
 	int f_flags;
 	int err;
 
@@ -1143,6 +1145,12 @@ static int map_create(union bpf_attr *attr)
 	if (err)
 		return -EINVAL;
 
+	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
+	 * to avoid per-map type checks tripping on unknown flag
+	 */
+	token_flag = attr->map_flags & BPF_F_TOKEN_FD;
+	attr->map_flags &= ~BPF_F_TOKEN_FD;
+
 	if (attr->btf_vmlinux_value_type_id) {
 		if (attr->map_type != BPF_MAP_TYPE_STRUCT_OPS ||
 		    attr->btf_key_type_id || attr->btf_value_type_id)
@@ -1183,14 +1191,32 @@ static int map_create(union bpf_attr *attr)
 	if (!ops->map_mem_usage)
 		return -EINVAL;
 
+	if (token_flag) {
+		token = bpf_token_get_from_fd(attr->map_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+
+		/* if current token doesn't grant map creation permissions,
+		 * then we can't use this token, so ignore it and rely on
+		 * system-wide capabilities checks
+		 */
+		if (!bpf_token_allow_cmd(token, BPF_MAP_CREATE) ||
+		    !bpf_token_allow_map_type(token, attr->map_type)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	err = -EPERM;
+
 	/* Intent here is for unprivileged_bpf_disabled to block BPF map
 	 * creation for unprivileged users; other actions depend
 	 * on fd availability and access to bpffs, so are dependent on
 	 * object creation success. Even with unprivileged BPF disabled,
 	 * capability checks are still carried out.
 	 */
-	if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
-		return -EPERM;
+	if (sysctl_unprivileged_bpf_disabled && !bpf_token_capable(token, CAP_BPF))
+		goto put_token;
 
 	/* check privileged map type permissions */
 	switch (map_type) {
@@ -1223,25 +1249,27 @@ static int map_create(union bpf_attr *attr)
 	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
 	case BPF_MAP_TYPE_STRUCT_OPS:
 	case BPF_MAP_TYPE_CPUMAP:
-		if (!bpf_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_BPF))
+			goto put_token;
 		break;
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_DEVMAP:
 	case BPF_MAP_TYPE_DEVMAP_HASH:
 	case BPF_MAP_TYPE_XSKMAP:
-		if (!bpf_net_capable())
-			return -EPERM;
+		if (!bpf_token_capable(token, CAP_NET_ADMIN))
+			goto put_token;
 		break;
 	default:
 		WARN(1, "unsupported map type %d", map_type);
-		return -EPERM;
+		goto put_token;
 	}
 
 	map = ops->map_alloc(attr);
-	if (IS_ERR(map))
-		return PTR_ERR(map);
+	if (IS_ERR(map)) {
+		err = PTR_ERR(map);
+		goto put_token;
+	}
 	map->ops = ops;
 	map->map_type = map_type;
 
@@ -1278,7 +1306,7 @@ static int map_create(union bpf_attr *attr)
 		map->btf = btf;
 
 		if (attr->btf_value_type_id) {
-			err = map_check_btf(map, btf, attr->btf_key_type_id,
+			err = map_check_btf(map, token, btf, attr->btf_key_type_id,
 					    attr->btf_value_type_id);
 			if (err)
 				goto free_map;
@@ -1299,6 +1327,7 @@ static int map_create(union bpf_attr *attr)
 		goto free_map_sec;
 
 	bpf_map_save_memcg(map);
+	bpf_token_put(token);
 
 	err = bpf_map_new_fd(map, f_flags);
 	if (err < 0) {
@@ -1319,6 +1348,8 @@ static int map_create(union bpf_attr *attr)
 free_map:
 	btf_put(map->btf);
 	map->ops->map_free(map);
+put_token:
+	bpf_token_put(token);
 	return err;
 }
 
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index bdb6fe697568..bc86be4ca567 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -73,6 +73,13 @@ static void bpf_token_show_fdinfo(struct seq_file *m, struct file *filp)
 		seq_printf(m, "allowed_cmds:\tany\n");
 	else
 		seq_printf(m, "allowed_cmds:\t0x%llx\n", token->allowed_cmds);
+
+	BUILD_BUG_ON(__MAX_BPF_MAP_TYPE >= 64);
+	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+	if ((token->allowed_maps & mask) == mask)
+		seq_printf(m, "allowed_maps:\tany\n");
+	else
+		seq_printf(m, "allowed_maps:\t0x%llx\n", token->allowed_maps);
 }
 
 #define BPF_TOKEN_INODE_NAME "bpf-token"
@@ -168,6 +175,7 @@ int bpf_token_create(union bpf_attr *attr)
 
 	mnt_opts = path.dentry->d_sb->s_fs_info;
 	token->allowed_cmds = mnt_opts->delegate_cmds;
+	token->allowed_maps = mnt_opts->delegate_maps;
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
 	if (fd < 0) {
@@ -215,3 +223,11 @@ bool bpf_token_allow_cmd(const struct bpf_token *token, enum bpf_cmd cmd)
 		return false;
 	return token->allowed_cmds & (1ULL << cmd);
 }
+
+bool bpf_token_allow_map_type(const struct bpf_token *token, enum bpf_map_type type)
+{
+	if (!token || type >= __MAX_BPF_MAP_TYPE)
+		return false;
+
+	return token->allowed_maps & (1ULL << type);
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 353d136563a9..62f8be885731 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -983,6 +983,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	__MAX_BPF_MAP_TYPE
 };
 
 /* Note that tracing related programs such as
@@ -1362,6 +1363,8 @@ enum {
 
 /* Get path from provided FD in BPF_OBJ_PIN/BPF_OBJ_GET commands */
 	BPF_F_PATH_FD		= (1U << 14),
+/* BPF token FD is passed in a corresponding command's token_fd field */
+	BPF_F_TOKEN_FD          = (1U << 15),
 };
 
 /* Flags for BPF_PROG_QUERY. */
@@ -1435,6 +1438,10 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
+		/* BPF token FD to use with BPF_MAP_CREATE operation.
+		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32	map_token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
index 9f766ddd946a..573249a2814d 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_probes.c
@@ -68,6 +68,8 @@ void test_libbpf_probe_map_types(void)
 
 		if (map_type == BPF_MAP_TYPE_UNSPEC)
 			continue;
+		if (strcmp(map_type_name, "__MAX_BPF_MAP_TYPE") == 0)
+			continue;
 
 		if (!test__start_subtest(map_type_name))
 			continue;
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
index eb34d612d6f8..1f328c0d8aff 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_str.c
@@ -132,6 +132,9 @@ static void test_libbpf_bpf_map_type_str(void)
 		const char *map_type_str;
 		char buf[256];
 
+		if (map_type == __MAX_BPF_MAP_TYPE)
+			continue;
+
 		map_type_name = btf__str_by_offset(btf, e->name_off);
 		map_type_str = libbpf_bpf_map_type_str(map_type);
 		ASSERT_OK_PTR(map_type_str, map_type_name);
-- 
2.34.1


