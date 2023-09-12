Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CBC79DACF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbjILV3i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjILV3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:29:35 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2810D9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:29:29 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKioEU017009
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:29:29 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2ya00d71-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:29:28 -0700
Received: from twshared15338.14.prn3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 12 Sep 2023 14:29:22 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D183137F405E6; Tue, 12 Sep 2023 14:29:09 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <keescook@chromium.org>,
        <brauner@kernel.org>, <lennart@poettering.net>,
        <kernel-team@meta.com>, <sargun@sargun.me>
Subject: [PATCH v4 bpf-next 01/12] bpf: add BPF token delegation mount options to BPF FS
Date:   Tue, 12 Sep 2023 14:28:55 -0700
Message-ID: <20230912212906.3975866-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212906.3975866-1-andrii@kernel.org>
References: <20230912212906.3975866-1-andrii@kernel.org>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: phwfChb3xdKvj1yJu_1FLGDSkoLky4eH
X-Proofpoint-GUID: phwfChb3xdKvj1yJu_1FLGDSkoLky4eH
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_20,2023-09-05_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add few new mount options to BPF FS that allow to specify that a given
BPF FS instance allows creation of BPF token (added in the next patch),
and what sort of operations are allowed under BPF token. As such, we get
4 new mount options, each is a bit mask
  - `delegate_cmds` allow to specify which bpf() syscall commands are
    allowed with BPF token derived from this BPF FS instance;
  - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
    a set of allowable BPF map types that could be created with BPF token;
  - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
    a set of allowable BPF program types that could be loaded with BPF token;
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
  delegate_maps=0x1 -o delegate_maps=0x2` will result in a combined 0x3
  mask.

Ideally, more convenient (for humans) symbolic form derived from
corresponding UAPI enums would be accepted (e.g., `-o
delegate_progs=kprobe|tracepoint`) and I intend to implement this, but
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

  [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 10 ++++++
 kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b9e573159432..e9a3ab390844 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1558,6 +1558,16 @@ struct bpf_link_primer {
 	u32 id;
 };
 
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
 
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 99d0625b6c82..8f66b57d3546 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -20,6 +20,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <linux/kstrtox.h>
 #include "preload/bpf_preload.h"
 
 enum bpf_type {
@@ -600,10 +601,31 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
  */
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
+	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
 	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
 
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
+
+	if (opts->delegate_cmds == ~0ULL)
+		seq_printf(m, ",delegate_cmds=any");
+	else if (opts->delegate_cmds)
+		seq_printf(m, ",delegate_cmds=0x%llx", opts->delegate_cmds);
+
+	if (opts->delegate_maps == ~0ULL)
+		seq_printf(m, ",delegate_maps=any");
+	else if (opts->delegate_maps)
+		seq_printf(m, ",delegate_maps=0x%llx", opts->delegate_maps);
+
+	if (opts->delegate_progs == ~0ULL)
+		seq_printf(m, ",delegate_progs=any");
+	else if (opts->delegate_progs)
+		seq_printf(m, ",delegate_progs=0x%llx", opts->delegate_progs);
+
+	if (opts->delegate_attachs == ~0ULL)
+		seq_printf(m, ",delegate_attachs=any");
+	else if (opts->delegate_attachs)
+		seq_printf(m, ",delegate_attachs=0x%llx", opts->delegate_attachs);
 	return 0;
 }
 
@@ -627,22 +649,27 @@ static const struct super_operations bpf_super_ops = {
 
 enum {
 	OPT_MODE,
+	OPT_DELEGATE_CMDS,
+	OPT_DELEGATE_MAPS,
+	OPT_DELEGATE_PROGS,
+	OPT_DELEGATE_ATTACHS,
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
 	fsparam_u32oct	("mode",			OPT_MODE),
+	fsparam_string	("delegate_cmds",		OPT_DELEGATE_CMDS),
+	fsparam_string	("delegate_maps",		OPT_DELEGATE_MAPS),
+	fsparam_string	("delegate_progs",		OPT_DELEGATE_PROGS),
+	fsparam_string	("delegate_attachs",		OPT_DELEGATE_ATTACHS),
 	{}
 };
 
-struct bpf_mount_opts {
-	umode_t mode;
-};
-
 static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = fc->s_fs_info;
 	struct fs_parse_result result;
-	int opt;
+	int opt, err;
+	u64 msk;
 
 	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -666,6 +693,25 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case OPT_MODE:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
+	case OPT_DELEGATE_CMDS:
+	case OPT_DELEGATE_MAPS:
+	case OPT_DELEGATE_PROGS:
+	case OPT_DELEGATE_ATTACHS:
+		if (strcmp(param->string, "any") == 0) {
+			msk = ~0ULL;
+		} else {
+			err = kstrtou64(param->string, 0, &msk);
+			if (err)
+				return err;
+		}
+		switch (opt) {
+		case OPT_DELEGATE_CMDS: opts->delegate_cmds |= msk; break;
+		case OPT_DELEGATE_MAPS: opts->delegate_maps |= msk; break;
+		case OPT_DELEGATE_PROGS: opts->delegate_progs |= msk; break;
+		case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |= msk; break;
+		default: return -EINVAL;
+		}
+		break;
 	}
 
 	return 0;
@@ -740,10 +786,14 @@ static int populate_bpffs(struct dentry *parent)
 static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr bpf_rfiles[] = { { "" } };
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = sb->s_fs_info;
 	struct inode *inode;
 	int ret;
 
+	/* Delegating an instance of BPF FS requires privileges */
+	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -765,7 +815,10 @@ static int bpf_get_tree(struct fs_context *fc)
 
 static void bpf_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	struct bpf_mount_opts *opts = fc->s_fs_info;
+
+	if (opts)
+		kfree(opts);
 }
 
 static const struct fs_context_operations bpf_context_ops = {
@@ -787,17 +840,32 @@ static int bpf_init_fs_context(struct fs_context *fc)
 
 	opts->mode = S_IRWXUGO;
 
-	fc->fs_private = opts;
+	/* start out with no BPF token delegation enabled */
+	opts->delegate_cmds = 0;
+	opts->delegate_maps = 0;
+	opts->delegate_progs = 0;
+	opts->delegate_attachs = 0;
+
+	fc->s_fs_info = opts;
 	fc->ops = &bpf_context_ops;
 	return 0;
 }
 
+static void bpf_kill_super(struct super_block *sb)
+{
+	struct bpf_mount_opts *opts = sb->s_fs_info;
+
+	kill_litter_super(sb);
+	kfree(opts);
+}
+
 static struct file_system_type bpf_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "bpf",
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.kill_sb	= bpf_kill_super,
+	.fs_flags	= FS_USERNS_MOUNT,
 };
 
 static int __init bpf_init(void)
-- 
2.34.1

