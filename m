Return-Path: <linux-fsdevel+bounces-8657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE215839EF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E801F21B43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F8175AA;
	Wed, 24 Jan 2024 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXqSRTBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430ED1759C;
	Wed, 24 Jan 2024 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062961; cv=none; b=Y8Op4Bk8bIhUobGIZ9F+MFvma2PZGefEAwLY3P+XlKMYkaVj8j5jXtpdJZYqvKhD+emgOFoqXoLZ/ivtDksdLMBNTIky8aFHRz1PaRvJWegQRDrSCQgY4z5S3OfJutLLF0KTTW5yKc78RqJ63evfRfKg9TC/vX8gU+KMlezV914=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062961; c=relaxed/simple;
	bh=V3eeD/P6gPsaCD81zuOXmaiuOwvyxO6BCYZ5jnl26Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhbQnb8IMWREJB9DDduuCdQ96YJx3/pFgO+Uig2VJsk6/RFk6g97TN03PlfuTg43USC9kuTzKpY7Un7XuJjf59bRQgAibeFh6zsL3qZU5ECUaWnaWSh1KAd4RsPn/TPgTF0Vu/3ecFb8JzCT2zrwMCh0YQRyeusGC6DU9O8nNt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXqSRTBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE5FC433C7;
	Wed, 24 Jan 2024 02:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062961;
	bh=V3eeD/P6gPsaCD81zuOXmaiuOwvyxO6BCYZ5jnl26Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXqSRTBRJncwwVjkYgBuTU9+7TVJnnV4MTMl6TUd6EAWXKxTMnyJ1r0EYm5M+K12v
	 7IgGMLrSTTOR7DziKXr2+ztRsrRHwwrq2PKwqOXeoMPCBOt5BrgOjNn9HjBEJzbuBI
	 GOZRRLBMIM5uBcMkMJH+52V2S5zI/wTsCiQrEeb1lPovxEfk0U7mhSbdMp8adFX7Eo
	 PrATa12+xf38Xna0RWtwK1ldEGQlo9qN65jGCyTFinaKgj7tpVzYyYoZ3sOl5huVy/
	 q5QoOMDL/Zj9AcKfDuhu2ZtMz5ttQJSb6MPcbuhqAGrbJrxUNe+NcAVposfzpIYXqz
	 +zYHq+mGjKTkQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 19/30] bpf: support symbolic BPF FS delegation mount options
Date: Tue, 23 Jan 2024 18:21:16 -0800
Message-Id: <20240124022127.2379740-20-andrii@kernel.org>
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
               -o delegate_cmds=prog_load:MAP_CREATE \
               -o delegate_progs=kprobe \
               -o delegate_attachs=xdp
  $ mount | grep token
  bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=map_create:prog_load,delegate_progs=kprobe,delegate_attachs=xdp)

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/inode.c | 249 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 211 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5fb10da5717f..af5d2ffadd70 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -595,6 +595,136 @@ struct bpf_prog *bpf_prog_get_type_path(const char *name, enum bpf_prog_type typ
 }
 EXPORT_SYMBOL(bpf_prog_get_type_path);
 
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
+	btf = bpf_get_btf_vmlinux();
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+	if (!btf)
+		return -ENOENT;
+
+	info->btf = btf;
+
+	for (i = 1, n = btf_nr_types(btf); i < n; i++) {
+		t = btf_type_by_id(btf, i);
+		if (!btf_type_is_enum(t))
+			continue;
+
+		name = btf_name_by_offset(btf, t->name_off);
+		if (!name)
+			continue;
+
+		if (strcmp(name, "bpf_cmd") == 0)
+			info->cmd_t = t;
+		else if (strcmp(name, "bpf_map_type") == 0)
+			info->map_t = t;
+		else if (strcmp(name, "bpf_prog_type") == 0)
+			info->prog_t = t;
+		else if (strcmp(name, "bpf_attach_type") == 0)
+			info->attach_t = t;
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
+static bool find_btf_enum_const(const struct btf *btf, const struct btf_type *enum_t,
+				const char *prefix, const char *str, int *value)
+{
+	const struct btf_enum *e;
+	const char *name;
+	int i, n, pfx_len = strlen(prefix);
+
+	*value = 0;
+
+	if (!btf || !enum_t)
+		return false;
+
+	for (i = 0, n = btf_vlen(enum_t); i < n; i++) {
+		e = &btf_enum(enum_t)[i];
+
+		name = btf_name_by_offset(btf, e->name_off);
+		if (!name || strncasecmp(name, prefix, pfx_len) != 0)
+			continue;
+
+		/* match symbolic name case insensitive and ignoring prefix */
+		if (strcasecmp(name + pfx_len, str) == 0) {
+			*value = e->val;
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
+	bool first = true;
+	const char *name;
+	u64 msk;
+	int i, n, pfx_len = strlen(prefix);
+
+	delegate_msk &= any_msk; /* clear unknown bits */
+
+	if (delegate_msk == 0)
+		return;
+
+	seq_printf(m, ",%s", opt_name);
+	if (delegate_msk == any_msk) {
+		seq_printf(m, "=any");
+		return;
+	}
+
+	if (btf && enum_t) {
+		for (i = 0, n = btf_vlen(enum_t); i < n; i++) {
+			e = &btf_enum(enum_t)[i];
+			name = btf_name_by_offset(btf, e->name_off);
+			if (!name || strncasecmp(name, prefix, pfx_len) != 0)
+				continue;
+			msk = 1ULL << e->val;
+			if (delegate_msk & msk) {
+				/* emit lower-case name without prefix */
+				seq_printf(m, "%c", first ? '=' : ':');
+				name += pfx_len;
+				while (*name) {
+					seq_printf(m, "%c", tolower(*name));
+					name++;
+				}
+
+				delegate_msk &= ~msk;
+				first = false;
+			}
+		}
+	}
+	if (delegate_msk)
+		seq_printf(m, "%c0x%llx", first ? '=' : ':', delegate_msk);
+}
+
 /*
  * Display the mount options in /proc/mounts.
  */
@@ -614,29 +744,34 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
 
-	mask = (1ULL << __MAX_BPF_CMD) - 1;
-	if ((opts->delegate_cmds & mask) == mask)
-		seq_printf(m, ",delegate_cmds=any");
-	else if (opts->delegate_cmds)
-		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
-
-	mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
-	if ((opts->delegate_maps & mask) == mask)
-		seq_printf(m, ",delegate_maps=any");
-	else if (opts->delegate_maps)
-		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
-
-	mask = (1ULL << __MAX_BPF_PROG_TYPE) - 1;
-	if ((opts->delegate_progs & mask) == mask)
-		seq_printf(m, ",delegate_progs=any");
-	else if (opts->delegate_progs)
-		seq_printf(m, ",delegate_progs=0x%llx", opts->delegate_progs);
-
-	mask = (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
-	if ((opts->delegate_attachs & mask) == mask)
-		seq_printf(m, ",delegate_attachs=any");
-	else if (opts->delegate_attachs)
-		seq_printf(m, ",delegate_attachs=0x%llx", opts->delegate_attachs);
+	if (opts->delegate_cmds || opts->delegate_maps ||
+	    opts->delegate_progs || opts->delegate_attachs) {
+		struct bpffs_btf_enums info;
+
+		/* ignore errors, fallback to hex */
+		(void)find_bpffs_btf_enums(&info);
+
+		mask = (1ULL << __MAX_BPF_CMD) - 1;
+		seq_print_delegate_opts(m, "delegate_cmds",
+					info.btf, info.cmd_t, "BPF_",
+					opts->delegate_cmds, mask);
+
+		mask = (1ULL << __MAX_BPF_MAP_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_maps",
+					info.btf, info.map_t, "BPF_MAP_TYPE_",
+					opts->delegate_maps, mask);
+
+		mask = (1ULL << __MAX_BPF_PROG_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_progs",
+					info.btf, info.prog_t, "BPF_PROG_TYPE_",
+					opts->delegate_progs, mask);
+
+		mask = (1ULL << __MAX_BPF_ATTACH_TYPE) - 1;
+		seq_print_delegate_opts(m, "delegate_attachs",
+					info.btf, info.attach_t, "BPF_",
+					opts->delegate_attachs, mask);
+	}
+
 	return 0;
 }
 
@@ -686,7 +821,6 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	kuid_t uid;
 	kgid_t gid;
 	int opt, err;
-	u64 msk;
 
 	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -741,24 +875,63 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case OPT_DELEGATE_CMDS:
 	case OPT_DELEGATE_MAPS:
 	case OPT_DELEGATE_PROGS:
-	case OPT_DELEGATE_ATTACHS:
-		if (strcmp(param->string, "any") == 0) {
-			msk = ~0ULL;
-		} else {
-			err = kstrtou64(param->string, 0, &msk);
-			if (err)
-				return err;
+	case OPT_DELEGATE_ATTACHS: {
+		struct bpffs_btf_enums info;
+		const struct btf_type *enum_t;
+		const char *enum_pfx;
+		u64 *delegate_msk, msk = 0;
+		char *p;
+		int val;
+
+		/* ignore errors, fallback to hex */
+		(void)find_bpffs_btf_enums(&info);
+
+		switch (opt) {
+		case OPT_DELEGATE_CMDS:
+			delegate_msk = &opts->delegate_cmds;
+			enum_t = info.cmd_t;
+			enum_pfx = "BPF_";
+			break;
+		case OPT_DELEGATE_MAPS:
+			delegate_msk = &opts->delegate_maps;
+			enum_t = info.map_t;
+			enum_pfx = "BPF_MAP_TYPE_";
+			break;
+		case OPT_DELEGATE_PROGS:
+			delegate_msk = &opts->delegate_progs;
+			enum_t = info.prog_t;
+			enum_pfx = "BPF_PROG_TYPE_";
+			break;
+		case OPT_DELEGATE_ATTACHS:
+			delegate_msk = &opts->delegate_attachs;
+			enum_t = info.attach_t;
+			enum_pfx = "BPF_";
+			break;
+		default:
+			return -EINVAL;
 		}
+
+		while ((p = strsep(&param->string, ":"))) {
+			if (strcmp(p, "any") == 0) {
+				msk |= ~0ULL;
+			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
+				msk |= 1ULL << val;
+			} else {
+				err = kstrtou64(p, 0, &msk);
+				if (err)
+					return err;
+			}
+		}
+
 		/* Setting delegation mount options requires privileges */
 		if (msk && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		switch (opt) {
-		case OPT_DELEGATE_CMDS: opts->delegate_cmds |= msk; break;
-		case OPT_DELEGATE_MAPS: opts->delegate_maps |= msk; break;
-		case OPT_DELEGATE_PROGS: opts->delegate_progs |= msk; break;
-		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |= msk; break;
-		default: return -EINVAL;
-		}
+
+		*delegate_msk |= msk;
+		break;
+	}
+	default:
+		/* ignore unknown mount options */
 		break;
 	}
 
-- 
2.34.1


