Return-Path: <linux-fsdevel+bounces-5189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21AA809274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958D1281FCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABF3563B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:37:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F1171D
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 10:55:08 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7EKGfg022711
	for <linux-fsdevel@vger.kernel.org>; Thu, 7 Dec 2023 10:55:07 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uufqaj8ms-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 10:55:07 -0800
Received: from twshared38604.02.prn6.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 10:55:05 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 817C33CC1CAA8; Thu,  7 Dec 2023 10:54:56 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH bpf-next 6/8] libbpf: wire up BPF token support at BPF object level
Date: Thu, 7 Dec 2023 10:54:41 -0800
Message-ID: <20231207185443.2297160-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207185443.2297160-1-andrii@kernel.org>
References: <20231207185443.2297160-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RvYU5XvHOPc9Zq68spqSHAK3gR8OiBjv
X-Proofpoint-ORIG-GUID: RvYU5XvHOPc9Zq68spqSHAK3gR8OiBjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02

Add BPF token support to BPF object-level functionality.

BPF token is supported by BPF object logic either as an explicitly
provided BPF token from outside (through BPF FS path or explicit BPF
token FD), or implicitly (unless prevented through
bpf_object_open_opts).

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

In explicit BPF token mode, user provides explicitly either custom BPF
FS mount point path or creates BPF token on their own and just passes
token FD directly. In such case, BPF object will either dup() token FD
(to not require caller to hold onto it for entire duration of BPF object
lifetime) or will attempt to create BPF token from provided BPF FS
location. If BPF token creation fails, that is considered a critical
error and BPF object load fails with an error.

Libbpf provides a way to disable implicit BPF token creation, if it
causes any troubles (BPF token is designed to be completely optional and
shouldn't cause any problems even if provided, but in the world of BPF
LSM, custom security logic can be installed that might change outcome
dependin on the presence of BPF token). To disable libbpf's default BPF
token creation behavior user should provide either invalid BPF token FD
(negative), or empty bpf_token_path option.

BPF token presence can influence libbpf's feature probing, so if BPF
object has associated BPF token, feature probing is instructed to use
BPF object-specific feature detection cache and token FD.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             |   7 +-
 tools/lib/bpf/libbpf.c          | 120 ++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.h          |  28 +++++++-
 tools/lib/bpf/libbpf_internal.h |  17 ++++-
 4 files changed, 160 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d..63033c334320 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1317,7 +1317,9 @@ struct btf *btf__parse_split(const char *path, stru=
ct btf *base_btf)
=20
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool s=
wap_endian);
=20
-int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, =
__u32 log_level)
+int btf_load_into_kernel(struct btf *btf,
+			 char *log_buf, size_t log_sz, __u32 log_level,
+			 int token_fd)
 {
 	LIBBPF_OPTS(bpf_btf_load_opts, opts);
 	__u32 buf_sz =3D 0, raw_size;
@@ -1367,6 +1369,7 @@ int btf_load_into_kernel(struct btf *btf, char *log=
_buf, size_t log_sz, __u32 lo
 		opts.log_level =3D log_level;
 	}
=20
+	opts.token_fd =3D token_fd;
 	btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
 		/* time to turn on verbose mode and try again */
@@ -1394,7 +1397,7 @@ int btf_load_into_kernel(struct btf *btf, char *log=
_buf, size_t log_sz, __u32 lo
=20
 int btf__load_into_kernel(struct btf *btf)
 {
-	return btf_load_into_kernel(btf, NULL, 0, 0);
+	return btf_load_into_kernel(btf, NULL, 0, 0, 0);
 }
=20
 int btf__fd(const struct btf *btf)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1a9fe08179ee..53bf0993b09a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -59,6 +59,8 @@
 #define BPF_FS_MAGIC		0xcafe4a11
 #endif
=20
+#define BPF_FS_DEFAULT_PATH "/sys/fs/bpf"
+
 #define BPF_INSN_SZ (sizeof(struct bpf_insn))
=20
 /* vsprintf() in __base_pr() uses nonliteral format string. It may break
@@ -694,6 +696,10 @@ struct bpf_object {
=20
 	struct usdt_manager *usdt_man;
=20
+	struct kern_feature_cache *feat_cache;
+	char *token_path;
+	int token_fd;
+
 	char path[];
 };
=20
@@ -2193,7 +2199,7 @@ static int build_map_pin_path(struct bpf_map *map, =
const char *path)
 	int err;
=20
 	if (!path)
-		path =3D "/sys/fs/bpf";
+		path =3D BPF_FS_DEFAULT_PATH;
=20
 	err =3D pathname_concat(buf, sizeof(buf), path, bpf_map__name(map));
 	if (err)
@@ -3269,7 +3275,7 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
 	} else {
 		/* currently BPF_BTF_LOAD only supports log_level 1 */
 		err =3D btf_load_into_kernel(kern_btf, obj->log_buf, obj->log_size,
-					   obj->log_level ? 1 : 0);
+					   obj->log_level ? 1 : 0, obj->token_fd);
 	}
 	if (sanitize) {
 		if (!err) {
@@ -4592,6 +4598,63 @@ int bpf_map__set_max_entries(struct bpf_map *map, =
__u32 max_entries)
 	return 0;
 }
=20
+static int bpf_object_prepare_token(struct bpf_object *obj)
+{
+	const char *bpffs_path;
+	int bpffs_fd =3D -1, token_fd, err;
+	bool mandatory;
+	enum libbpf_print_level level =3D LIBBPF_DEBUG;
+
+	/* token is already set up */
+	if (obj->token_fd > 0)
+		return 0;
+	/* token is explicitly prevented */
+	if (obj->token_fd < 0) {
+		pr_debug("object '%s': token is prevented, skipping...\n", obj->name);
+		/* reset to zero to avoid extra checks during map_create and prog_load=
 steps */
+		obj->token_fd =3D 0;
+		return 0;
+	}
+
+	mandatory =3D obj->token_path !=3D NULL;
+	level =3D mandatory ? LIBBPF_WARN : LIBBPF_DEBUG;
+
+	bpffs_path =3D obj->token_path ?: BPF_FS_DEFAULT_PATH;
+	bpffs_fd =3D open(bpffs_path, O_DIRECTORY, O_RDWR);
+	if (bpffs_fd < 0) {
+		err =3D -errno;
+		__pr(level, "object '%s': failed (%d) to open BPF FS mount at '%s'%s\n=
",
+		     obj->name, err, bpffs_path,
+		     mandatory ? "" : ", skipping optional step...");
+		return mandatory ? err : 0;
+	}
+
+	token_fd =3D bpf_token_create(bpffs_fd, 0);
+	close(bpffs_fd);
+	if (token_fd < 0) {
+		if (!mandatory && token_fd =3D=3D -ENOENT) {
+			pr_debug("object '%s': BPF FS at '%s' doesn't have BPF token delegati=
on set up, skipping...\n",
+				 obj->name, bpffs_path);
+			return 0;
+		}
+		__pr(level, "object '%s': failed (%d) to create BPF token from '%s'%s\=
n",
+		     obj->name, token_fd, bpffs_path,
+		     mandatory ? "" : ", skipping optional step...");
+		return mandatory ? token_fd : 0;
+	}
+
+	obj->feat_cache =3D calloc(1, sizeof(*obj->feat_cache));
+	if (!obj->feat_cache) {
+		close(token_fd);
+		return -ENOMEM;
+	}
+
+	obj->token_fd =3D token_fd;
+	obj->feat_cache->token_fd =3D token_fd;
+
+	return 0;
+}
+
 static int
 bpf_object__probe_loading(struct bpf_object *obj)
 {
@@ -4601,6 +4664,7 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		BPF_EXIT_INSN(),
 	};
 	int ret, insn_cnt =3D ARRAY_SIZE(insns);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts, .token_fd =3D obj->token_fd);
=20
 	if (obj->gen_loader)
 		return 0;
@@ -4610,9 +4674,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		pr_warn("Failed to bump RLIMIT_MEMLOCK (err =3D %d), you might need to=
 do it explicitly!\n", ret);
=20
 	/* make sure basic loading works */
-	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, =
insn_cnt, NULL);
+	ret =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, =
insn_cnt, &opts);
 	if (ret < 0)
-		ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, in=
sn_cnt, NULL);
+		ret =3D bpf_prog_load(BPF_PROG_TYPE_TRACEPOINT, NULL, "GPL", insns, in=
sn_cnt, &opts);
 	if (ret < 0) {
 		ret =3D errno;
 		cp =3D libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -4635,6 +4699,9 @@ bool kernel_supports(const struct bpf_object *obj, =
enum kern_feature_id feat_id)
 		 */
 		return true;
=20
+	if (obj->token_fd)
+		return feat_supported(obj->feat_cache, feat_id);
+
 	return feat_supported(NULL, feat_id);
 }
=20
@@ -4754,6 +4821,7 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 	create_attr.map_flags =3D def->map_flags;
 	create_attr.numa_node =3D map->numa_node;
 	create_attr.map_extra =3D map->map_extra;
+	create_attr.token_fd =3D obj->token_fd;
=20
 	if (bpf_map__is_struct_ops(map))
 		create_attr.btf_vmlinux_value_type_id =3D map->btf_vmlinux_value_type_=
id;
@@ -6589,6 +6657,7 @@ static int bpf_object_load_prog(struct bpf_object *=
obj, struct bpf_program *prog
 	load_attr.attach_btf_id =3D prog->attach_btf_id;
 	load_attr.kern_version =3D kern_version;
 	load_attr.prog_ifindex =3D prog->prog_ifindex;
+	load_attr.token_fd =3D obj->token_fd;
=20
 	/* specify func_info/line_info only if kernel supports them */
 	btf_fd =3D bpf_object__btf_fd(obj);
@@ -7050,10 +7119,10 @@ static int bpf_object_init_progs(struct bpf_objec=
t *obj, const struct bpf_object
 static struct bpf_object *bpf_object_open(const char *path, const void *=
obj_buf, size_t obj_buf_sz,
 					  const struct bpf_object_open_opts *opts)
 {
-	const char *obj_name, *kconfig, *btf_tmp_path;
+	const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
 	struct bpf_object *obj;
 	char tmp_name[64];
-	int err;
+	int err, token_fd;
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
@@ -7087,6 +7156,20 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
 	if (log_size && !log_buf)
 		return ERR_PTR(-EINVAL);
=20
+	token_path =3D OPTS_GET(opts, bpf_token_path, NULL);
+	token_fd =3D OPTS_GET(opts, bpf_token_fd, -1);
+	/* non-empty token path can't be combined with invalid token FD */
+	if (token_path && token_path[0] !=3D '\0' && token_fd < 0)
+		return ERR_PTR(-EINVAL);
+	if (token_path && token_path[0] =3D=3D '\0') {
+		/* empty token path can't be combined with valid token FD */
+		if (token_fd > 0)
+			return ERR_PTR(-EINVAL);
+		/* empty token_path is equivalent to invalid token_fd */
+		token_path =3D NULL;
+		token_fd =3D -1;
+	}
+
 	obj =3D bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
@@ -7095,6 +7178,23 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
 	obj->log_size =3D log_size;
 	obj->log_level =3D log_level;
=20
+	obj->token_fd =3D token_fd <=3D 0 ? token_fd : dup_good_fd(token_fd);
+	if (token_fd > 0 && obj->token_fd < 0) {
+		err =3D -errno;
+		goto out;
+	}
+	if (token_path) {
+		if (strlen(token_path) >=3D PATH_MAX) {
+			err =3D -ENAMETOOLONG;
+			goto out;
+		}
+		obj->token_path =3D strdup(token_path);
+		if (!obj->token_path) {
+			err =3D -ENOMEM;
+			goto out;
+		}
+	}
+
 	btf_tmp_path =3D OPTS_GET(opts, btf_custom_path, NULL);
 	if (btf_tmp_path) {
 		if (strlen(btf_tmp_path) >=3D PATH_MAX) {
@@ -7605,7 +7705,8 @@ static int bpf_object_load(struct bpf_object *obj, =
int extra_log_level, const ch
 	if (obj->gen_loader)
 		bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_programs, obj-=
>nr_maps);
=20
-	err =3D bpf_object__probe_loading(obj);
+	err =3D bpf_object_prepare_token(obj);
+	err =3D err ? : bpf_object__probe_loading(obj);
 	err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
@@ -8142,6 +8243,11 @@ void bpf_object__close(struct bpf_object *obj)
 	}
 	zfree(&obj->programs);
=20
+	zfree(&obj->feat_cache);
+	zfree(&obj->token_path);
+	if (obj->token_fd > 0)
+		close(obj->token_fd);
+
 	free(obj);
 }
=20
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6cd9c501624f..d3de39b537f3 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -177,10 +177,36 @@ struct bpf_object_open_opts {
 	 * logs through its print callback.
 	 */
 	__u32 kernel_log_level;
+	/* FD of a BPF token instantiated by user through bpf_token_create()
+	 * API. BPF object will keep dup()'ed FD internally, so passed token
+	 * FD can be closed after BPF object/skeleton open step.
+	 *
+	 * Setting bpf_token_fd to negative value disables libbpf's automatic
+	 * attempt to create BPF token from default BPF FS mount point
+	 * (/sys/fs/bpf), in case this default behavior is undesirable.
+	 *
+	 * bpf_token_path and bpf_token_fd are mutually exclusive and only one
+	 * of those options should be set.
+	 */
+	int bpf_token_fd;
+	/* Path to BPF FS mount point to derive BPF token from.
+	 *
+	 * Created BPF token will be used for all bpf() syscall operations
+	 * that accept BPF token (e.g., map creation, BTF and program loads,
+	 * etc) automatically within instantiated BPF object.
+	 *
+	 * Setting bpf_token_path option to empty string disables libbpf's
+	 * automatic attempt to create BPF token from default BPF FS mount
+	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
+	 *
+	 * bpf_token_path and bpf_token_fd are mutually exclusive and only one
+	 * of those options should be set.
+	 */
+	const char *bpf_token_path;
=20
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field kernel_log_level
+#define bpf_object_open_opts__last_field bpf_token_path
=20
 /**
  * @brief **bpf_object__open()** creates a bpf_object by opening
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
index b45566e428d7..4cda32298c49 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -383,7 +383,9 @@ int parse_cpu_mask_file(const char *fcpu, bool **mask=
, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len,
 			 int token_fd);
-int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, =
__u32 log_level);
+int btf_load_into_kernel(struct btf *btf,
+			 char *log_buf, size_t log_sz, __u32 log_level,
+			 int token_fd);
=20
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
@@ -547,6 +549,17 @@ static inline bool is_ldimm64_insn(struct bpf_insn *=
insn)
 	return insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW);
 }
=20
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
@@ -558,7 +571,7 @@ static inline int ensure_good_fd(int fd)
 	if (fd < 0)
 		return fd;
 	if (fd < 3) {
-		fd =3D fcntl(fd, F_DUPFD_CLOEXEC, 3);
+		fd =3D dup_good_fd(fd);
 		saved_errno =3D errno;
 		close(old_fd);
 		errno =3D saved_errno;
--=20
2.34.1


