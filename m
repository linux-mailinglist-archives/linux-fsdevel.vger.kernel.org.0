Return-Path: <linux-fsdevel+bounces-5281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8280959A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81D7282174
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A157335
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D859170C
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 14:28:55 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7Lb9mK031149
	for <linux-fsdevel@vger.kernel.org>; Thu, 7 Dec 2023 14:28:54 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uufqfurdr-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 14:28:54 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 14:28:11 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id AB4973CC5458F; Thu,  7 Dec 2023 14:27:59 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <paul@paul-moore.com>,
        <brauner@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH RFC bpf-next 2/3] bpf: extend parsing logic for BPF FS delegate_cmds mount option
Date: Thu, 7 Dec 2023 14:27:54 -0800
Message-ID: <20231207222755.3920286-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207222755.3920286-1-andrii@kernel.org>
References: <20231207222755.3920286-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LYNN4NlNFXOUFcFIt3UCHNXDRBEuIql-
X-Proofpoint-GUID: LYNN4NlNFXOUFcFIt3UCHNXDRBEuIql-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_17,2023-12-07_01,2023-05-22_02

Besides already supported special "any" value and hex bit mask, support
string-based parsing of enum bpf_cmd values based on exact enumerator
names. We use __BPF_CMD_MAPPER macro to generate a lookup table. So
"BPF_PROG_LOAD" and "BPF_MAP_CREATE" are valid values to specify for
delegate_cmds options.

A bunch of code changes are setting up generic routines which will make
similar support for delegate_maps, delegate_progs, and delegate_attachs
mount options trivial to add once we have similar mapper macros for
respective enums.

Besides supporting string values, we also support multiple values
specified at the same time, using colon (':') separator.

There are corresponding changes on bpf_show_options side to use known
values to print them in human-readable format, falling back to hex mask
printing, if there are any unrecognized bits (which shouldn't happen for
delegate_cmds, but is necessary for the same routing to be able to
handle other delegate_xxx options).

Example below shows various ways to specify delegate_cmds options
through mount command and how mount options are printed back:

  $ sudo mkdir -p /sys/fs/bpf/token
  $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
               -o delegate_cmds=3DBPF_PROG_LOAD \
               -o delegate_cmds=3DBPF_MAP_CREATE \
               -o delegate_cmds=3DBPF_TOKEN_CREATE:BPF_BTF_LOAD:BPF_LINK_=
CREATE
  $ mount | grep token
  bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=3DBPF_MA=
P_CREATE:BPF_PROG_LOAD:BPF_BTF_LOAD:BPF_LINK_CREATE:BPF_TOKEN_CREATE)

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/inode.c | 127 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 96 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5359a0929c35..20b2d170fc0b 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -595,6 +595,54 @@ struct bpf_prog *bpf_prog_get_type_path(const char *=
name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);
=20
+#define __BPF_KV_FN(name, val) { #name, val },
+static const struct constant_table cmd_kvs[] =3D {
+	__BPF_CMD_MAPPER(__BPF_KV_FN)
+	{}
+};
+static const struct constant_table map_kvs[] =3D {
+	{}
+};
+static const struct constant_table prog_kvs[] =3D {
+	{}
+};
+static const struct constant_table attach_kvs[] =3D {
+	{}
+};
+#undef __BPF_KV_FN
+
+static void seq_print_delegate_opts(struct seq_file *m,
+				    const char *opt_name,
+				    const struct constant_table *tbl,
+				    u64 delegate_msk, u64 any_msk)
+{
+	bool first =3D true;
+	u64 msk;
+	int i;
+
+	delegate_msk &=3D any_msk; /* clear unknown bits */
+
+	if (delegate_msk =3D=3D 0)
+		return;
+
+	if (delegate_msk =3D=3D any_msk) {
+		seq_printf(m, ",%s=3Dany", opt_name);
+		return;
+	}
+
+	seq_printf(m, ",%s", opt_name);
+	for (i =3D 0; cmd_kvs[i].name; i++) {
+		msk =3D 1ULL << cmd_kvs[i].value;
+		if (delegate_msk & msk) {
+			seq_printf(m, "%c%s", first ? '=3D' : ':', cmd_kvs[i].name);
+			delegate_msk &=3D ~msk;
+			first =3D false;
+		}
+	}
+	if (delegate_msk)
+		seq_printf(m, "%c0x%llx", first ? '=3D' : ':', delegate_msk);
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -608,28 +656,17 @@ static int bpf_show_options(struct seq_file *m, str=
uct dentry *root)
 		seq_printf(m, ",mode=3D%o", mode);
=20
 	mask =3D (1ULL << __MAX_BPF_CMD) - 1;
-	if ((opts->delegate_cmds & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_cmds=3Dany");
-	else if (opts->delegate_cmds)
-		seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_cmds);
+	seq_print_delegate_opts(m, "delegate_cmds", cmd_kvs, opts->delegate_cmd=
s, mask);
=20
 	mask =3D (1ULL << __MAX_BPF_MAP_TYPE) - 1;
-	if ((opts->delegate_maps & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_maps=3Dany");
-	else if (opts->delegate_maps)
-		seq_printf(m, ",delegate_maps=3D0x%llx", opts->delegate_maps);
+	seq_print_delegate_opts(m, "delegate_maps", map_kvs, opts->delegate_map=
s, mask);
=20
 	mask =3D (1ULL << __MAX_BPF_PROG_TYPE) - 1;
-	if ((opts->delegate_progs & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_progs=3Dany");
-	else if (opts->delegate_progs)
-		seq_printf(m, ",delegate_progs=3D0x%llx", opts->delegate_progs);
+	seq_print_delegate_opts(m, "delegate_progs", prog_kvs, opts->delegate_p=
rogs, mask);
=20
 	mask =3D (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
-	if ((opts->delegate_attachs & mask) =3D=3D mask)
-		seq_printf(m, ",delegate_attachs=3Dany");
-	else if (opts->delegate_attachs)
-		seq_printf(m, ",delegate_attachs=3D0x%llx", opts->delegate_attachs);
+	seq_print_delegate_opts(m, "delegate_attachs", attach_kvs, opts->delega=
te_attachs, mask);
+
 	return 0;
 }
=20
@@ -673,7 +710,6 @@ static int bpf_parse_param(struct fs_context *fc, str=
uct fs_parameter *param)
 	struct bpf_mount_opts *opts =3D fc->s_fs_info;
 	struct fs_parse_result result;
 	int opt, err;
-	u64 msk;
=20
 	opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -700,26 +736,55 @@ static int bpf_parse_param(struct fs_context *fc, s=
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
+		const struct constant_table *kvs;
+		u64 *delegate_msk, msk =3D 0;
+		char *p;
+		int val;
+
+		switch (opt) {
+		case OPT_DELEGATE_CMDS:
+			delegate_msk =3D &opts->delegate_cmds;
+			kvs =3D cmd_kvs;
+			break;
+		case OPT_DELEGATE_MAPS:
+			delegate_msk =3D &opts->delegate_maps;
+			kvs =3D map_kvs;
+			break;
+		case OPT_DELEGATE_PROGS:
+			delegate_msk =3D &opts->delegate_progs;
+			kvs =3D prog_kvs;
+			break;
+		case OPT_DELEGATE_ATTACHS:
+			delegate_msk =3D &opts->delegate_attachs;
+			kvs =3D attach_kvs;
+			break;
+		default:
+			return -EINVAL;
 		}
+
+		while ((p =3D strsep(&param->string, ":"))) {
+			if (strcmp(p, "any") =3D=3D 0) {
+				msk |=3D ~0ULL;
+			} else if ((val =3D lookup_constant(kvs, p, -1)) >=3D 0) {
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
 		break;
 	}
+	default:
+		/* ignore unknown mount options */
+	}
=20
 	return 0;
 }
--=20
2.34.1


