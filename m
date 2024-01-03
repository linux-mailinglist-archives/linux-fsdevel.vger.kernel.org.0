Return-Path: <linux-fsdevel+bounces-7291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F1F8237ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901512829BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7E6208CB;
	Wed,  3 Jan 2024 22:23:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7D1EB44
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 22:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403GkdQ0023083
	for <linux-fsdevel@vger.kernel.org>; Wed, 3 Jan 2024 14:23:47 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vcvqhf413-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 14:23:46 -0800
Received: from twshared10507.42.prn1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 3 Jan 2024 14:23:37 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 6E0A93DF9EB8B; Wed,  3 Jan 2024 14:21:19 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>, <torvalds@linuxfoundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <kernel-team@meta.com>
Subject: [PATCH bpf-next 19/29] bpf: support symbolic BPF FS delegation mount options
Date: Wed, 3 Jan 2024 14:20:24 -0800
Message-ID: <20240103222034.2582628-20-andrii@kernel.org>
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
X-Proofpoint-GUID: EAqtR_DWU7L3zAbf7psQyGnCq2-vhp6g
X-Proofpoint-ORIG-GUID: EAqtR_DWU7L3zAbf7psQyGnCq2-vhp6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02

Besides already supported special "any" value and hex bit mask, support
string-based parsing of delegation masks based on exact enumerator
names. Utilize BTF information of `enum bpf_cmd`, `enum bpf_map_type`,
`enum bpf_prog_type`, and `enum bpf_attach_type` types to find supported
symbolic names (ignoring __MAX_xxx guard values and stripping repetitive
prefixes like BPF_ for cmd and attach types, BPF_MAP_TYPE_ for maps, and
BPF_PROG_TYPE_ for prog types). The case doesn't matter, but it is
normalized to lower case in mount option output. So "PROG_LOAD",
"prog_load", and "MAP_create" are all valid values to specify for
delegate_cmds options, "array" is among supported for map types, etc.

Besides supporting string values, we also support multiple values
specified at the same time, using colon (':') separator.

There are corresponding changes on bpf_show_options side to use known
values to print them in human-readable format, falling back to hex mask
printing, if there are any unrecognized bits. This shouldn't be
necessary when enum BTF information is present, but in general we should
always be able to fall back to this even if kernel was built without BTF.
As mentioned, emitted symbolic names are normalized to be all lower case.

Example below shows various ways to specify delegate_cmds options
through mount command and how mount options are printed back:

12/14 14:39:07.604
vmuser@archvm:~/local/linux/tools/testing/selftests/bpf
$ mount | rg token

  $ sudo mkdir -p /sys/fs/bpf/token
  $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
               -o delegate_cmds=3Dprog_load:MAP_CREATE \
               -o delegate_progs=3Dkprobe \
               -o delegate_attachs=3Dxdp
  $ mount | grep token
  bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=3Dmap_cr=
eate:prog_load,delegate_progs=3Dkprobe,delegate_attachs=3Dxdp)

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/inode.c | 249 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 211 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5fb10da5717f..af5d2ffadd70 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -595,6 +595,136 @@ struct bpf_prog *bpf_prog_get_type_path(const char =
*name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);
=20
+struct bpffs_btf_enums {
+	const struct btf *btf;
+	const struct btf_type *cmd_t;
+	const struct btf_type *map_t;
+	const struct btf_type *prog_t;
+	const struct btf_type *attach_t;
+};
+
+static int find_bpffs_btf_enums(struct bpffs_btf_enums *info)
+{
+	const struct btf *btf;
+	const struct btf_type *t;
+	const char *name;
+	int i, n;
+
+	memset(info, 0, sizeof(*info));
+
+	btf =3D bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+	if (!btf)
+		return -ENOENT;
+
+	info->btf =3D btf;
+
+	for (i =3D 1, n =3D btf_nr_types(btf); i < n; i++) {
+		t =3D btf_type_by_id(btf, i);
+		if (!btf_type_is_enum(t))
+			continue;
+
+		name =3D btf_name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (strcmp(name, "bpf_cmd") =3D=3D 0)
+			info->cmd_t =3D t;
+		else if (strcmp(name, "bpf_map_type") =3D=3D 0)
+			info->map_t =3D t;
+		else if (strcmp(name, "bpf_prog_type") =3D=3D 0)
+			info->prog_t =3D t;
+		else if (strcmp(name, "bpf_attach_type") =3D=3D 0)
+			info->attach_t =3D t;
+		else
+			continue;
+
+		if (info->cmd_t && info->map_t && info->prog_t && info->attach_t)
+			return 0;
+	}
+
+	return -ESRCH;
+}
+
+static bool find_btf_enum_const(const struct btf *btf, const struct btf_=
type *enum_t,
+				const char *prefix, const char *str, int *value)
+{
+	const struct btf_enum *e;
+	const char *name;
+	int i, n, pfx_len =3D strlen(prefix);
+
+	*value =3D 0;
+
+	if (!btf || !enum_t)
+		return false;
+
+	for (i =3D 0, n =3D btf_vlen(enum_t); i < n; i++) {
+		e =3D &btf_enum(enum_t)[i];
+
+		name =3D btf_name_by_offset(btf, e->name_off);
+		if (!name || strncasecmp(name, prefix, pfx_len) !=3D 0)
+			continue;
+
+		/* match symbolic name case insensitive and ignoring prefix */
+		if (strcasecmp(name + pfx_len, str) =3D=3D 0) {
+			*value =3D e->val;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static void seq_print_delegate_opts(struct seq_file *m,
+				    const char *opt_name,
+				    const struct btf *btf,
+				    const struct btf_type *enum_t,
+				    const char *prefix,
+				    u64 delegate_msk, u64 any_msk)
+{
+	const struct btf_enum *e;
+	bool first =3D true;
+	const char *name;
+	u64 msk;
+	int i, n, pfx_len =3D strlen(prefix);
+
+	delegate_msk &=3D any_msk; /* clear unknown bits */
+
+	if (delegate_msk =3D=3D 0)
+		return;
+
+	seq_printf(m, ",%s", opt_name);
+	if (delegate_msk =3D=3D any_msk) {
+		seq_printf(m, "=3Dany");
+		return;
+	}
+
+	if (btf && enum_t) {
+		for (i =3D 0, n =3D btf_vlen(enum_t); i < n; i++) {
+			e =3D &btf_enum(enum_t)[i];
+			name =3D btf_name_by_offset(btf, e->name_off);
+			if (!name || strncasecmp(name, prefix, pfx_len) !=3D 0)
+				continue;
+			msk =3D 1ULL << e->val;
+			if (delegate_msk & msk) {
+				/* emit lower-case name without prefix */
+				seq_printf(m, "%c", first ? '=3D' : ':');
+				name +=3D pfx_len;
+				while (*name) {
+					seq_printf(m, "%c", tolower(*name));
+					name++;
+				}
+
+				delegate_msk &=3D ~msk;
+				first =3D false;
+			}
+		}
+	}
+	if (delegate_msk)
+		seq_printf(m, "%c0x%llx", first ? '=3D' : ':', delegate_msk);
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -614,29 +744,34 @@ static int bpf_show_options(struct seq_file *m, str=
uct dentry *root)
 	if (mode !=3D S_IRWXUGO)
 		seq_printf(m, ",mode=3D%o", mode);
=20
-	mask =3D (1ULL << __MAX_BPF_CMD) - 1;
-	if ((opts->delegate_cmds & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_cmds=3Dany");
-	else if (opts->delegate_cmds)
-		seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_cmds);
-
-	mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
-	if ((opts->delegate_maps & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_maps=3Dany");
-	else if (opts->delegate_maps)
-		seq_printf(m, ",delegate_maps=3D0x%llx", opts->delegate_maps);
-
-	mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
-	if ((opts->delegate_progs & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_progs=3Dany");
-	else if (opts->delegate_progs)
-		seq_printf(m, ",delegate_progs=3D0x%llx", opts->delegate_progs);
-
-	mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
-	if ((opts->delegate_attachs & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_attachs=3Dany");
-	else if (opts->delegate_attachs)
-		seq_printf(m, ",delegate_attachs=3D0x%llx", opts->delegate_attachs);
+	if (opts->delegate_cmds || opts->delegate_maps ||
+	    opts->delegate_progs || opts->delegate_attachs) {
+		struct bpffs_btf_enums info;
+
+		/* ignore errors, fallback to hex */
+		(void)find_bpffs_btf_enums(&info);
+
+		mask =3D (1ULL << __MAX_BPF_CMD) - 1;
+		seq_print_delegate_opts(m, "delegate_cmds",
+					info.btf, info.cmd_t, "BPF_",
+					opts->delegate_cmds, mask);
+
+		mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_maps",
+					info.btf, info.map_t, "BPF_MAP_TYPE_",
+					opts->delegate_maps, mask);
+
+		mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_progs",
+					info.btf, info.prog_t, "BPF_PROG_TYPE_",
+					opts->delegate_progs, mask);
+
+		mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_attachs",
+					info.btf, info.attach_t, "BPF_",
+					opts->delegate_attachs, mask);
+	}
+
 	return 0;
 }
=20
@@ -686,7 +821,6 @@ static int bpf_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
 	kuid_t uid;
 	kgid_t gid;
 	int opt, err;
-	u64 msk;
=20
 	opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -741,24 +875,63 @@ static int bpf_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
 	case OPT_DELEGATE_CMDS:
 	case OPT_DELEGATE_MAPS:
 	case OPT_DELEGATE_PROGS:
-	case OPT_DELEGATE_ATTACHS:
-		if (strcmp(param->string, "any") =3D=3D 0) {
-			msk =3D ~0ULL;
-		} else {
-			err =3D kstrtou64(param->string, 0, &msk);
-			if (err)
-				return err;
+	case OPT_DELEGATE_ATTACHS: {
+		struct bpffs_btf_enums info;
+		const struct btf_type *enum_t;
+		const char *enum_pfx;
+		u64 *delegate_msk, msk =3D 0;
+		char *p;
+		int val;
+
+		/* ignore errors, fallback to hex */
+		(void)find_bpffs_btf_enums(&info);
+
+		switch (opt) {
+		case OPT_DELEGATE_CMDS:
+			delegate_msk =3D &opts->delegate_cmds;
+			enum_t =3D info.cmd_t;
+			enum_pfx =3D "BPF_";
+			break;
+		case OPT_DELEGATE_MAPS:
+			delegate_msk =3D &opts->delegate_maps;
+			enum_t =3D info.map_t;
+			enum_pfx =3D "BPF_MAP_TYPE_";
+			break;
+		case OPT_DELEGATE_PROGS:
+			delegate_msk =3D &opts->delegate_progs;
+			enum_t =3D info.prog_t;
+			enum_pfx =3D "BPF_PROG_TYPE_";
+			break;
+		case OPT_DELEGATE_ATTACHS:
+			delegate_msk =3D &opts->delegate_attachs;
+			enum_t =3D info.attach_t;
+			enum_pfx =3D "BPF_";
+			break;
+		default:
+			return -EINVAL;
 		}
+
+		while ((p =3D strsep(&param->string, ":"))) {
+			if (strcmp(p, "any") =3D=3D 0) {
+				msk |=3D ~0ULL;
+			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) =
{
+				msk |=3D 1ULL << val;
+			} else {
+				err =3D kstrtou64(p, 0, &msk);
+				if (err)
+					return err;
+			}
+		}
+
 		/* Setting delegation mount options requires privileges */
 		if (msk && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		switch (opt) {
-		case OPT_DELEGATE_CMDS: opts->delegate_cmds |=3D msk; break;
-		case OPT_DELEGATE_MAPS: opts->delegate_maps |=3D msk; break;
-		case OPT_DELEGATE_PROGS: opts->delegate_progs |=3D msk; break;
-		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |=3D msk; break;
-		default: return -EINVAL;
-		}
+
+		*delegate_msk |=3D msk;
+		break;
+	}
+	default:
+		/* ignore unknown mount options */
 		break;
 	}
=20
--=20
2.34.1


