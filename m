Return-Path: <linux-fsdevel+bounces-8663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB17839F0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B61F25853
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047D717BD4;
	Wed, 24 Jan 2024 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6eHLKSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5E17BC2;
	Wed, 24 Jan 2024 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062983; cv=none; b=LSsJINbdx7zroV964WJTZw6N4GHhgJpoK1lERSxqkaKH4baXF6ePLfgQr+3xA7e6uaiBOLNNBPHr6dp6LIpCw/G5lCXDGVaFeqaWzo8985Il29lMiHOJuw1+K5isaJmrJ8eAdmLNzS5FevPzrNGcYx4HmhhjzhqFSxgIyP/YE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062983; c=relaxed/simple;
	bh=GhxsfoICwee4K8PBrxJIUW3bm3g3/UjDWSM3BNGUSkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VerNlqrZH25d4CwuwczaAAhA8YuyBEH1Kf6jt67z7Ej1M8oLD7ByExQLU/2Oxg6kjb7FYgLyS1bbr6fy2dH19V9FvGe7EDJcJcJtKltgU040+QszObbZYNLUdf9BXSflhD66LOJ0Ecp+sxgxV0eTpSh5kZYX9u0IXnEPGBNEcFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6eHLKSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6971C433C7;
	Wed, 24 Jan 2024 02:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062983;
	bh=GhxsfoICwee4K8PBrxJIUW3bm3g3/UjDWSM3BNGUSkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6eHLKSvdC0ZyHD99WQXoH44p6VyI5vpRzenPn3Ew6m94qPJ9Lxhkq/iKwWLqWDfk
	 YyV+xxlA7paT/bACMAHesw3eWaoUweaFKMXXa+gwq35eFhl23TfCh4RSCWJk+yphNX
	 qNDzUXKKJ12yifcskjLlouA0Zpn1BJep7epJcWKgM+rGJfh501P+tlWdUwUWZjYoh7
	 z1BIUnjJxH/06aft4IlYsCWXxX6iadCDojQDuu8ev6mUnTqW4HajvC0xJpbWLuxAdJ
	 lDWbWabxC21EnH+67kPApvVnpMQ0z6FTxi5dC5lIIGcDVKKJOPlr/DhNxpQgZXTPcT
	 fhzd+Fx2ZBEJg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 25/30] libbpf: wire up BPF token support at BPF object level
Date: Tue, 23 Jan 2024 18:21:22 -0800
Message-Id: <20240124022127.2379740-26-andrii@kernel.org>
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

Add BPF token support to BPF object-level functionality.

BPF token is supported by BPF object logic either as an explicitly
provided BPF token from outside (through BPF FS path), or implicitly
(unless prevented through bpf_object_open_opts).

Implicit mode is assumed to be the most common one for user namespaced
unprivileged workloads. The assumption is that privileged container
manager sets up default BPF FS mount point at /sys/fs/bpf with BPF token
delegation options (delegate_{cmds,maps,progs,attachs} mount options).
BPF object during loading will attempt to create BPF token from
/sys/fs/bpf location, and pass it for all relevant operations
(currently, map creation, BTF load, and program load).

In this implicit mode, if BPF token creation fails due to whatever
reason (BPF FS is not mounted, or kernel doesn't support BPF token,
etc), this is not considered an error. BPF object loading sequence will
proceed with no BPF token.

In explicit BPF token mode, user provides explicitly custom BPF FS mount
point path. In such case, BPF object will attempt to create BPF token
from provided BPF FS location. If BPF token creation fails, that is
considered a critical error and BPF object load fails with an error.

Libbpf provides a way to disable implicit BPF token creation, if it
causes any troubles (BPF token is designed to be completely optional and
shouldn't cause any problems even if provided, but in the world of BPF
LSM, custom security logic can be installed that might change outcome
depending on the presence of BPF token). To disable libbpf's default BPF
token creation behavior user should provide either invalid BPF token FD
(negative), or empty bpf_token_path option.

BPF token presence can influence libbpf's feature probing, so if BPF
object has associated BPF token, feature probing is instructed to use
BPF object-specific feature detection cache and token FD.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             |  10 +++-
 tools/lib/bpf/libbpf.c          | 102 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h          |  13 +++-
 tools/lib/bpf/libbpf_internal.h |  17 +++++-
 4 files changed, 131 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d..ec92b87cae01 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1317,7 +1317,9 @@ struct btf *btf__parse_split(const char *path, struct btf *base_btf)
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
 
-int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 log_level)
+int btf_load_into_kernel(struct btf *btf,
+			 char *log_buf, size_t log_sz, __u32 log_level,
+			 int token_fd)
 {
 	LIBBPF_OPTS(bpf_btf_load_opts, opts);
 	__u32 buf_sz = 0, raw_size;
@@ -1367,6 +1369,10 @@ int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 lo
 		opts.log_level = log_level;
 	}
 
+	opts.token_fd = token_fd;
+	if (token_fd)
+		opts.btf_flags |= BPF_F_TOKEN_FD;
+
 	btf->fd = bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
 		/* time to turn on verbose mode and try again */
@@ -1394,7 +1400,7 @@ int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 lo
 
 int btf__load_into_kernel(struct btf *btf)
 {
-	return btf_load_into_kernel(btf, NULL, 0, 0);
+	return btf_load_into_kernel(btf, NULL, 0, 0, 0);
 }
 
 int btf__fd(const struct btf *btf)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 67f52e371cb2..a2866329d8f2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -59,6 +59,8 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
 
+#define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
+
 #define BPF_INSN_SZ (sizeof(struct bpf_insn))
 
 /* vsprintf() in __base_pr() uses nonliteral format string. It may break
@@ -694,6 +696,10 @@ struct bpf_object {
 
 	struct usdt_manager *usdt_man;
 
+	struct kern_feature_cache *feat_cache;
+	char *token_path;
+	int token_fd;
+
 	char path[];
 };
 
@@ -2217,7 +2223,7 @@ static int build_map_pin_path(struct bpf_map *map, const char *path)
 	int err;
 
 	if (!path)
-		path = "/sys/fs/bpf";
+		path = BPF_FS_DEFAULT_PATH;
 
 	err = pathname_concat(buf, sizeof(buf), path, bpf_map__name(map));
 	if (err)
@@ -3226,7 +3232,7 @@ static int bpf_object__sanitize_and_load_btf(struct bpf_object *obj)
 	} else {
 		/* currently BPF_BTF_LOAD only supports log_level 1 */
 		err = btf_load_into_kernel(kern_btf, obj->log_buf, obj->log_size,
-					   obj->log_level ? 1 : 0);
+					   obj->log_level ? 1 : 0, obj->token_fd);
 	}
 	if (sanitize) {
 		if (!err) {
@@ -4547,6 +4553,58 @@ int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 	return 0;
 }
 
+static int bpf_object_prepare_token(struct bpf_object *obj)
+{
+	const char *bpffs_path;
+	int bpffs_fd = -1, token_fd, err;
+	bool mandatory;
+	enum libbpf_print_level level;
+
+	/* token is explicitly prevented */
+	if (obj->token_path && obj->token_path[0] == '\0') {
+		pr_debug("object '%s': token is prevented, skipping...\n", obj->name);
+		return 0;
+	}
+
+	mandatory = obj->token_path != NULL;
+	level = mandatory ? LIBBPF_WARN : LIBBPF_DEBUG;
+
+	bpffs_path = obj->token_path ?: BPF_FS_DEFAULT_PATH;
+	bpffs_fd = open(bpffs_path, O_DIRECTORY, O_RDWR);
+	if (bpffs_fd < 0) {
+		err = -errno;
+		__pr(level, "object '%s': failed (%d) to open BPF FS mount at '%s'%s\n",
+		     obj->name, err, bpffs_path,
+		     mandatory ? "" : ", skipping optional step...");
+		return mandatory ? err : 0;
+	}
+
+	token_fd = bpf_token_create(bpffs_fd, 0);
+	close(bpffs_fd);
+	if (token_fd < 0) {
+		if (!mandatory && token_fd == -ENOENT) {
+			pr_debug("object '%s': BPF FS at '%s' doesn't have BPF token delegation set up, skipping...\n",
+				 obj->name, bpffs_path);
+			return 0;
+		}
+		__pr(level, "object '%s': failed (%d) to create BPF token from '%s'%s\n",
+		     obj->name, token_fd, bpffs_path,
+		     mandatory ? "" : ", skipping optional step...");
+		return mandatory ? token_fd : 0;
+	}
+
+	obj->feat_cache = calloc(1, sizeof(*obj->feat_cache));
+	if (!obj->feat_cache) {
+		close(token_fd);
+		return -ENOMEM;
+	}
+
+	obj->token_fd = token_fd;
+	obj->feat_cache->token_fd = token_fd;
+
+	return 0;
+}
+
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
@@ -4556,6 +4614,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		BPF_EXIT_INSN(),
 	};
 	int ret, insn_cnt = ARRAY_SIZE(insns);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd = obj->token_fd,
+		.prog_flags = obj->token_fd ? BPF_F_TOKEN_FD : 0,
+	);
 
 	if (obj->gen_loader)
 		return 0;
@@ -4565,9 +4627,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		pr_warn("Failed to bump RLIMIT_MEMLOCK (err = %d), you might need to do it explicitly!\n", ret);
 
 	/* make sure basic loading works */
-	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, NULL);
+	ret = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, insn_cnt, &opts);
 	if (ret < 0)
-		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, NULL);
+		ret = bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, insn_cnt, &opts);
 	if (ret < 0) {
 		ret = errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -4590,6 +4652,9 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
 		 */
 		return true;
 
+	if (obj->token_fd)
+		return feat_supported(obj->feat_cache, feat_id);
+
 	return feat_supported(NULL, feat_id);
 }
 
@@ -4714,6 +4779,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.map_flags = def->map_flags;
 	create_attr.numa_node = map->numa_node;
 	create_attr.map_extra = map->map_extra;
+	create_attr.token_fd = obj->token_fd;
+	if (obj->token_fd)
+		create_attr.map_flags |= BPF_F_TOKEN_FD;
 
 	if (bpf_map__is_struct_ops(map))
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
@@ -7030,6 +7098,10 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.prog_flags = prog->prog_flags;
 	load_attr.fd_array = obj->fd_array;
 
+	load_attr.token_fd = obj->token_fd;
+	if (obj->token_fd)
+		load_attr.prog_flags |= BPF_F_TOKEN_FD;
+
 	/* adjust load_attr if sec_def provides custom preload callback */
 	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
 		err = prog->sec_def->prog_prepare_load_fn(prog, &load_attr, prog->sec_def->cookie);
@@ -7475,7 +7547,7 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf, size_t obj_buf_sz,
 					  const struct bpf_object_open_opts *opts)
 {
-	const char *obj_name, *kconfig, *btf_tmp_path;
+	const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
 	struct bpf_object *obj;
 	char tmp_name[64];
 	int err;
@@ -7512,6 +7584,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	if (log_size && !log_buf)
 		return ERR_PTR(-EINVAL);
 
+	token_path = OPTS_GET(opts, bpf_token_path, NULL);
+	if (token_path && strlen(token_path) >= PATH_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
@@ -7520,6 +7596,14 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	obj->log_size = log_size;
 	obj->log_level = log_level;
 
+	if (token_path) {
+		obj->token_path = strdup(token_path);
+		if (!obj->token_path) {
+			err = -ENOMEM;
+			goto out;
+		}
+	}
+
 	btf_tmp_path = OPTS_GET(opts, btf_custom_path, NULL);
 	if (btf_tmp_path) {
 		if (strlen(btf_tmp_path) >= PATH_MAX) {
@@ -8030,7 +8114,8 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
 	if (obj->gen_loader)
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj->nr_maps);
 
-	err = bpf_object__probe_loading(obj);
+	err = bpf_object_prepare_token(obj);
+	err = err ? : bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err = err ? : bpf_object__sanitize_maps(obj);
@@ -8565,6 +8650,11 @@ void bpf_object__close(struct bpf_object *obj)
 	}
 	zfree(&obj->programs);
 
+	zfree(&obj->feat_cache);
+	zfree(&obj->token_path);
+	if (obj->token_fd > 0)
+		close(obj->token_fd);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6cd9c501624f..535ae15ed493 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -177,10 +177,21 @@ struct bpf_object_open_opts {
 	 * logs through its print callback.
 	 */
 	__u32 kernel_log_level;
+	/* Path to BPF FS mount point to derive BPF token from.
+	 *
+	 * Created BPF token will be used for all bpf() syscall operations
+	 * that accept BPF token (e.g., map creation, BTF and program loads,
+	 * etc) automatically within instantiated BPF object.
+	 *
+	 * Setting bpf_token_path option to empty string disables libbpf's
+	 * automatic attempt to create BPF token from default BPF FS mount
+	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
+	 */
+	const char *bpf_token_path;
 
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field kernel_log_level
+#define bpf_object_open_opts__last_field bpf_token_path
 
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 28fabed1cd8f..930cc9616527 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -384,7 +384,9 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len,
 			 int token_fd);
-int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 log_level);
+int btf_load_into_kernel(struct btf *btf,
+			 char *log_buf, size_t log_sz, __u32 log_level,
+			 int token_fd);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
@@ -548,6 +550,17 @@ static inline bool is_ldimm64_insn(struct bpf_insn *insn)
 	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
 }
 
+/* Unconditionally dup FD, ensuring it doesn't use [0, 2] range.
+ * Original FD is not closed or altered in any other way.
+ * Preserves original FD value, if it's invalid (negative).
+ */
+static inline int dup_good_fd(int fd)
+{
+	if (fd < 0)
+		return fd;
+	return fcntl(fd, F_DUPFD_CLOEXEC, 3);
+}
+
 /* if fd is stdin, stdout, or stderr, dup to a fd greater than 2
  * Takes ownership of the fd passed in, and closes it if calling
  * fcntl(fd, F_DUPFD_CLOEXEC, 3).
@@ -559,7 +572,7 @@ static inline int ensure_good_fd(int fd)
 	if (fd < 0)
 		return fd;
 	if (fd < 3) {
-		fd = fcntl(fd, F_DUPFD_CLOEXEC, 3);
+		fd = dup_good_fd(fd);
 		saved_errno = errno;
 		close(old_fd);
 		errno = saved_errno;
-- 
2.34.1


