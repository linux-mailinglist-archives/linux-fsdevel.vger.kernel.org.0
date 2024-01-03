Return-Path: <linux-fsdevel+bounces-7292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1F8237F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B7E1F26165
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550620B21;
	Wed,  3 Jan 2024 22:23:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E8208C6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 403Giua2028108
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:23:48 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3vd5qtmj37-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:23:48 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:41 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 8D94A3DF9EBDB; Wed,  3 Jan 2024 14:21:31 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 25/29] libbpf: wire up BPF token support at BPF object level
Date: Wed, 3 Jan 2024 14:20:30 -0800
Message-ID: <20240103222034.2582628-26-andrii@kernel.org>
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
X-Proofpoint-GUID: ImVTLv2wiizBPQHzDLHlDc6vIxlfHZSn
X-Proofpoint-ORIG-GUID: ImVTLv2wiizBPQHzDLHlDc6vIxlfHZSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

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
@@ -1367,6 +1369,10 @@ int btf_load_into_kernel(struct btf *btf, char *lo=
g_buf, size_t log_sz, __u32 lo
 		opts.log_level =3D log_level;
 	}
=20
+	opts.token_fd =3D token_fd;
+	if (token_fd)
+		opts.btf_flags |=3D BPF_F_TOKEN_FD;
+
 	btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
 		/* time to turn on verbose mode and try again */
@@ -1394,7 +1400,7 @@ int btf_load_into_kernel(struct btf *btf, char *log=
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
index a1486309b700..69d87d743557 100644
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
@@ -693,6 +695,10 @@ struct bpf_object {
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
@@ -2192,7 +2198,7 @@ static int build_map_pin_path(struct bpf_map *map, =
const char *path)
 	int err;
=20
 	if (!path)
-		path =3D "/sys/fs/bpf";
+		path =3D BPF_FS_DEFAULT_PATH;
=20
 	err =3D pathname_concat(buf, sizeof(buf), path, bpf_map__name(map));
 	if (err)
@@ -3279,7 +3285,7 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
 	} else {
 		/* currently BPF_BTF_LOAD only supports log_level 1 */
 		err =3D btf_load_into_kernel(kern_btf, obj->log_buf, obj->log_size,
-					   obj->log_level ? 1 : 0);
+					   obj->log_level ? 1 : 0, obj->token_fd);
 	}
 	if (sanitize) {
 		if (!err) {
@@ -4604,6 +4610,58 @@ int bpf_map__set_max_entries(struct bpf_map *map, =
__u32 max_entries)
 	return 0;
 }
=20
+static int bpf_object_prepare_token(struct bpf_object *obj)
+{
+	const char *bpffs_path;
+	int bpffs_fd =3D -1, token_fd, err;
+	bool mandatory;
+	enum libbpf_print_level level;
+
+	/* token is explicitly prevented */
+	if (obj->token_path && obj->token_path[0] =3D=3D '\0') {
+		pr_debug("object '%s': token is prevented, skipping...\n", obj->name);
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
@@ -4613,6 +4671,10 @@ bpf_object__probe_loading(struct bpf_object *obj)
 		BPF_EXIT_INSN(),
 	};
 	int ret, insn_cnt =3D ARRAY_SIZE(insns);
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.token_fd =3D obj->token_fd,
+		.prog_flags =3D obj->token_fd ? BPF_F_TOKEN_FD : 0,
+	);
=20
 	if (obj->gen_loader)
 		return 0;
@@ -4622,9 +4684,9 @@ bpf_object__probe_loading(struct bpf_object *obj)
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
@@ -4647,6 +4709,9 @@ bool kernel_supports(const struct bpf_object *obj, =
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
@@ -4766,6 +4831,9 @@ static int bpf_object__create_map(struct bpf_object=
 *obj, struct bpf_map *map, b
 	create_attr.map_flags =3D def->map_flags;
 	create_attr.numa_node =3D map->numa_node;
 	create_attr.map_extra =3D map->map_extra;
+	create_attr.token_fd =3D obj->token_fd;
+	if (obj->token_fd)
+		create_attr.map_flags |=3D BPF_F_TOKEN_FD;
=20
 	if (bpf_map__is_struct_ops(map))
 		create_attr.btf_vmlinux_value_type_id =3D map->btf_vmlinux_value_type_=
id;
@@ -6617,6 +6685,10 @@ static int bpf_object_load_prog(struct bpf_object =
*obj, struct bpf_program *prog
 	load_attr.prog_flags =3D prog->prog_flags;
 	load_attr.fd_array =3D obj->fd_array;
=20
+	load_attr.token_fd =3D obj->token_fd;
+	if (obj->token_fd)
+		load_attr.prog_flags |=3D BPF_F_TOKEN_FD;
+
 	/* adjust load_attr if sec_def provides custom preload callback */
 	if (prog->sec_def && prog->sec_def->prog_prepare_load_fn) {
 		err =3D prog->sec_def->prog_prepare_load_fn(prog, &load_attr, prog->se=
c_def->cookie);
@@ -7062,7 +7134,7 @@ static int bpf_object_init_progs(struct bpf_object =
*obj, const struct bpf_object
 static struct bpf_object *bpf_object_open(const char *path, const void *=
obj_buf, size_t obj_buf_sz,
 					  const struct bpf_object_open_opts *opts)
 {
-	const char *obj_name, *kconfig, *btf_tmp_path;
+	const char *obj_name, *kconfig, *btf_tmp_path, *token_path;
 	struct bpf_object *obj;
 	char tmp_name[64];
 	int err;
@@ -7099,6 +7171,10 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
 	if (log_size && !log_buf)
 		return ERR_PTR(-EINVAL);
=20
+	token_path =3D OPTS_GET(opts, bpf_token_path, NULL);
+	if (token_path && strlen(token_path) >=3D PATH_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
 	obj =3D bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
 	if (IS_ERR(obj))
 		return obj;
@@ -7107,6 +7183,14 @@ static struct bpf_object *bpf_object_open(const ch=
ar *path, const void *obj_buf,
 	obj->log_size =3D log_size;
 	obj->log_level =3D log_level;
=20
+	if (token_path) {
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
@@ -7617,7 +7701,8 @@ static int bpf_object_load(struct bpf_object *obj, =
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
@@ -8154,6 +8239,11 @@ void bpf_object__close(struct bpf_object *obj)
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


