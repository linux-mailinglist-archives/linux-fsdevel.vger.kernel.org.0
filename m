Return-Path: <linux-fsdevel+bounces-213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AB7C798E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E004E282C3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBE405EB;
	Thu, 12 Oct 2023 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC1405FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:31:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1416DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:31:27 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39CLuAQ6015866
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:31:27 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3tpbsne34c-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:31:26 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 15:31:23 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id F3FC239A3A46E; Thu, 12 Oct 2023 15:29:06 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
        <keescook@chromium.org>, <brauner@kernel.org>,
        <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v7 bpf-next 02/18] bpf: add BPF token delegation mount options to BPF FS
Date: Thu, 12 Oct 2023 15:27:54 -0700
Message-ID: <20231012222810.4120312-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012222810.4120312-1-andrii@kernel.org>
References: <20231012222810.4120312-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SJKE2hHCgDv80dpw9kD-R_sZyH68y9qU
X-Proofpoint-ORIG-GUID: SJKE2hHCgDv80dpw9kD-R_sZyH68y9qU
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_14,2023-10-12_01,2023-05-22_02
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add few new mount options to BPF FS that allow to specify that a given
BPF FS instance allows creation of BPF token (added in the next patch),
and what sort of operations are allowed under BPF token. As such, we get
4 new mount options, each is a bit mask
  - `delegate_cmds` allow to specify which bpf() syscall commands are
    allowed with BPF token derived from this BPF FS instance;
  - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
    a set of allowable BPF map types that could be created with BPF token;
  - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
    a set of allowable BPF program types that could be loaded with BPF toke=
n;
  - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
    a set of allowable BPF program attach types that could be loaded with
    BPF token; delegate_progs and delegate_attachs are meant to be used
    together, as full BPF program type is, in general, determined
    through both program type and program attach type.

Currently, these mount options accept the following forms of values:
  - a special value "any", that enables all possible values of a given
  bit set;
  - numeric value (decimal or hexadecimal, determined by kernel
  automatically) that specifies a bit mask value directly;
  - all the values for a given mount option are combined, if specified
  multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
  delegate_maps=3D0x1 -o delegate_maps=3D0x2` will result in a combined 0x3
  mask.

Ideally, more convenient (for humans) symbolic form derived from
corresponding UAPI enums would be accepted (e.g., `-o
delegate_progs=3Dkprobe|tracepoint`) and I intend to implement this, but
it requires a bunch of UAPI header churn, so I postponed it until this
feature lands upstream or at least there is a definite consensus that
this feature is acceptable and is going to make it, just to minimize
amount of wasted effort and not increase amount of non-essential code to
be reviewed.

Attentive reader will notice that BPF FS is now marked as
FS_USERNS_MOUNT, which theoretically makes it mountable inside non-init
user namespace as long as the process has sufficient *namespaced*
capabilities within that user namespace. But in reality we still
restrict BPF FS to be mountable only by processes with CAP_SYS_ADMIN *in
init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is added
to allow creating BPF FS context object (i.e., fsopen("bpf")) from
inside unprivileged process inside non-init userns, to capture that
userns as the owning userns. It will still be required to pass this
context object back to privileged process to instantiate and mount it.

This manipulation is important, because capturing non-init userns as the
owning userns of BPF FS instance (super block) allows to use that userns
to constraint BPF token to that userns later on (see next patch). So
creating BPF FS with delegation inside unprivileged userns will restrict
derived BPF token objects to only "work" inside that intended userns,
making it scoped to a intended "container".

There is a set of selftests at the end of the patch set that simulates
this sequence of steps and validates that everything works as intended.
But careful review is requested to make sure there are no missed gaps in
the implementation and testing.

All this is based on suggestions and discussions with Christian Brauner
([0]), to the best of my ability to follow all the implications.

  [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@=
brauner/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 10 ++++++
 kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 61bde4520f5c..3b3270ef11cc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1562,6 +1562,16 @@ struct bpf_link_primer {
 	u32 id;
 };
=20
+struct bpf_mount_opts {
+	umode_t mode;
+
+	/* BPF token-related delegation options */
+	u64 delegate_cmds;
+	u64 delegate_maps;
+	u64 delegate_progs;
+	u64 delegate_attachs;
+};
+
 struct bpf_struct_ops_value;
 struct btf_member;
=20
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 99d0625b6c82..24b3faf901f4 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -20,6 +20,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <linux/kstrtox.h>
 #include "preload/bpf_preload.h"
=20
 enum bpf_type {
@@ -600,10 +601,31 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
  */
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
+	struct bpf_mount_opts *opts =3D root->d_sb->s_fs_info;
 	umode_t mode =3D d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
=20
 	if (mode !=3D S_IRWXUGO)
 		seq_printf(m, ",mode=3D%o", mode);
+
+	if (opts->delegate_cmds =3D=3D ~0ULL)
+		seq_printf(m, ",delegate_cmds=3Dany");
+	else if (opts->delegate_cmds)
+		seq_printf(m, ",delegate_cmds=3D0x%llx", opts->delegate_cmds);
+
+	if (opts->delegate_maps =3D=3D ~0ULL)
+		seq_printf(m, ",delegate_maps=3Dany");
+	else if (opts->delegate_maps)
+		seq_printf(m, ",delegate_maps=3D0x%llx", opts->delegate_maps);
+
+	if (opts->delegate_progs =3D=3D ~0ULL)
+		seq_printf(m, ",delegate_progs=3Dany");
+	else if (opts->delegate_progs)
+		seq_printf(m, ",delegate_progs=3D0x%llx", opts->delegate_progs);
+
+	if (opts->delegate_attachs =3D=3D ~0ULL)
+		seq_printf(m, ",delegate_attachs=3Dany");
+	else if (opts->delegate_attachs)
+		seq_printf(m, ",delegate_attachs=3D0x%llx", opts->delegate_attachs);
 	return 0;
 }
=20
@@ -627,22 +649,27 @@ static const struct super_operations bpf_super_ops =
=3D {
=20
 enum {
 	OPT_MODE,
+	OPT_DELEGATE_CMDS,
+	OPT_DELEGATE_MAPS,
+	OPT_DELEGATE_PROGS,
+	OPT_DELEGATE_ATTACHS,
 };
=20
 static const struct fs_parameter_spec bpf_fs_parameters[] =3D {
 	fsparam_u32oct	("mode",			OPT_MODE),
+	fsparam_string	("delegate_cmds",		OPT_DELEGATE_CMDS),
+	fsparam_string	("delegate_maps",		OPT_DELEGATE_MAPS),
+	fsparam_string	("delegate_progs",		OPT_DELEGATE_PROGS),
+	fsparam_string	("delegate_attachs",		OPT_DELEGATE_ATTACHS),
 	{}
 };
=20
-struct bpf_mount_opts {
-	umode_t mode;
-};
-
 static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *par=
am)
 {
-	struct bpf_mount_opts *opts =3D fc->fs_private;
+	struct bpf_mount_opts *opts =3D fc->s_fs_info;
 	struct fs_parse_result result;
-	int opt;
+	int opt, err;
+	u64 msk;
=20
 	opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -666,6 +693,25 @@ static int bpf_parse_param(struct fs_context *fc, stru=
ct fs_parameter *param)
 	case OPT_MODE:
 		opts->mode =3D result.uint_32 & S_IALLUGO;
 		break;
+	case OPT_DELEGATE_CMDS:
+	case OPT_DELEGATE_MAPS:
+	case OPT_DELEGATE_PROGS:
+	case OPT_DELEGATE_ATTACHS:
+		if (strcmp(param->string, "any") =3D=3D 0) {
+			msk =3D ~0ULL;
+		} else {
+			err =3D kstrtou64(param->string, 0, &msk);
+			if (err)
+				return err;
+		}
+		switch (opt) {
+		case OPT_DELEGATE_CMDS: opts->delegate_cmds |=3D msk; break;
+		case OPT_DELEGATE_MAPS: opts->delegate_maps |=3D msk; break;
+		case OPT_DELEGATE_PROGS: opts->delegate_progs |=3D msk; break;
+		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |=3D msk; break;
+		default: return -EINVAL;
+		}
+		break;
 	}
=20
 	return 0;
@@ -740,10 +786,14 @@ static int populate_bpffs(struct dentry *parent)
 static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr bpf_rfiles[] =3D { { "" } };
-	struct bpf_mount_opts *opts =3D fc->fs_private;
+	struct bpf_mount_opts *opts =3D sb->s_fs_info;
 	struct inode *inode;
 	int ret;
=20
+	/* Mounting an instance of BPF FS requires privileges */
+	if (fc->user_ns !=3D &init_user_ns && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	ret =3D simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -765,7 +815,10 @@ static int bpf_get_tree(struct fs_context *fc)
=20
 static void bpf_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct bpf_mount_opts *opts =3D fc->s_fs_info;
+
+	if (opts)
+		kfree(opts);
 }
=20
 static const struct fs_context_operations bpf_context_ops =3D {
@@ -787,17 +840,32 @@ static int bpf_init_fs_context(struct fs_context *fc)
=20
 	opts->mode =3D S_IRWXUGO;
=20
-	fc->fs_private =3D opts;
+	/* start out with no BPF token delegation enabled */
+	opts->delegate_cmds =3D 0;
+	opts->delegate_maps =3D 0;
+	opts->delegate_progs =3D 0;
+	opts->delegate_attachs =3D 0;
+
+	fc->s_fs_info =3D opts;
 	fc->ops =3D &bpf_context_ops;
 	return 0;
 }
=20
+static void bpf_kill_super(struct super_block *sb)
+{
+	struct bpf_mount_opts *opts =3D sb->s_fs_info;
+
+	kill_litter_super(sb);
+	kfree(opts);
+}
+
 static struct file_system_type bpf_fs_type =3D {
 	.owner		=3D THIS_MODULE,
 	.name		=3D "bpf",
 	.init_fs_context =3D bpf_init_fs_context,
 	.parameters	=3D bpf_fs_parameters,
-	.kill_sb	=3D kill_litter_super,
+	.kill_sb	=3D bpf_kill_super,
+	.fs_flags	=3D FS_USERNS_MOUNT,
 };
=20
 static int __init bpf_init(void)
--=20
2.34.1


