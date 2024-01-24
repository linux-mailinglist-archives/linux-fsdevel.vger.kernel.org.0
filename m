Return-Path: <linux-fsdevel+bounces-8640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6A839EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237051F25BE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806F5380;
	Wed, 24 Jan 2024 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smsQAjHk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981B246A6;
	Wed, 24 Jan 2024 02:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062899; cv=none; b=UIozCLDDarkbb2mt0rzIWrnIYRR8vKO5VkKMxyfPU388XEJZLNSdALCxvUWl1dSsMAIWrw5OzzLiwcdaTtSUZ6ev8PNBlqQvkLD+znTeEnNvVWxrQdRhAEAqd2tx6KqeiECXmmMYLWVFwyuMshMYFMDJP6kVk5fyz4AaKBPLOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062899; c=relaxed/simple;
	bh=rho1xOyT6IdZOs9nCWeAYRkPrhMIdVxQNXc1aH9EVxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OJvYec6XTU6kpJSRors8KT8Q8zeNNgGruZJ9mRIHfD6O7xtUSdmpWLvsM4mRguv9mpxPf4BNtpTParWMZv+oKZEveSFZcl8WmqdY96iPLBCpvR851lNNvit9O2e+AtrMSYmOxor3m3eU95D1zZ3YNK7J0T0tSG97s9E3hPPEydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smsQAjHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFBCC433C7;
	Wed, 24 Jan 2024 02:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062899;
	bh=rho1xOyT6IdZOs9nCWeAYRkPrhMIdVxQNXc1aH9EVxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=smsQAjHk7R6Xl16wyP69HqvfInLMtIX7e6m0oEvVTxAjATPGV3hICh6VF3eL3Ajo0
	 D8ZcBMxFMWGBSQup52vhIGonIcY2iIse40+YyBQ91EvSckHMe4hHEs+kK6PtJQtVaC
	 ZZgjDEBqgCStgbZVrvwUTQUNmelLl9yIJWsmnZtwQSDA4E5mmet3GrNyD5oPSiyfbw
	 8jlFOWDq5oHNncZEXHenaIwF0xjqtWvreKfHsDAa8FC7t9Jvdf0gPjjKfw1L8dg9IQ
	 ROaPXHD6USzhE/lL5XRpjozQV8yZD6Ed24LS+i1KCVig3J+LyELcIme8xwIV41qyHC
	 2WTJU+uHJfMjw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 02/30] bpf: add BPF token delegation mount options to BPF FS
Date: Tue, 23 Jan 2024 18:20:59 -0800
Message-Id: <20240124022127.2379740-3-andrii@kernel.org>
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
making it scoped to a intended "container". Also, setting these
delegation options requires capable(CAP_SYS_ADMIN), so unprivileged
process cannot set this up without involvement of a privileged process.

There is a set of selftests at the end of the patch set that simulates
this sequence of steps and validates that everything works as intended.
But careful review is requested to make sure there are no missed gaps in
the implementation and testing.

This somewhat subtle set of aspects is the result of previous
discussions ([0]) about various user namespace implications and
interactions with BPF token functionality and is necessary to contain
BPF token inside intended user namespace.

  [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef785e@brauner/

Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h | 12 ++++++
 kernel/bpf/inode.c  | 90 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 90 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 377857b232c6..697528fa0c0d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1609,6 +1609,18 @@ struct bpf_link_primer {
 	u32 id;
 };
 
+struct bpf_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
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
index 41e0a55c35f5..70b748f6228c 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -20,6 +20,7 @@
 #include <linux/filter.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <linux/kstrtox.h>
 #include "preload/bpf_preload.h"
 
 enum bpf_type {
@@ -601,6 +602,7 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct inode *inode = d_inode(root);
 	umode_t mode = inode->i_mode & S_IALLUGO & ~S_ISVTX;
+	struct bpf_mount_opts *opts = root->d_sb->s_fs_info;
 
 	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
 		seq_printf(m, ",uid=%u",
@@ -610,6 +612,26 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, inode->i_gid));
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
 
@@ -635,28 +657,31 @@ enum {
 	OPT_UID,
 	OPT_GID,
 	OPT_MODE,
+	OPT_DELEGATE_CMDS,
+	OPT_DELEGATE_MAPS,
+	OPT_DELEGATE_PROGS,
+	OPT_DELEGATE_ATTACHS,
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
 	fsparam_u32	("uid",				OPT_UID),
 	fsparam_u32	("gid",				OPT_GID),
 	fsparam_u32oct	("mode",			OPT_MODE),
+	fsparam_string	("delegate_cmds",		OPT_DELEGATE_CMDS),
+	fsparam_string	("delegate_maps",		OPT_DELEGATE_MAPS),
+	fsparam_string	("delegate_progs",		OPT_DELEGATE_PROGS),
+	fsparam_string	("delegate_attachs",		OPT_DELEGATE_ATTACHS),
 	{}
 };
 
-struct bpf_mount_opts {
-	kuid_t uid;
-	kgid_t gid;
-	umode_t mode;
-};
-
 static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = fc->s_fs_info;
 	struct fs_parse_result result;
 	kuid_t uid;
 	kgid_t gid;
-	int opt;
+	int opt, err;
+	u64 msk;
 
 	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
 	if (opt < 0) {
@@ -708,6 +733,28 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
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
+		/* Setting delegation mount options requires privileges */
+		if (msk && !capable(CAP_SYS_ADMIN))
+			return -EPERM;
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
@@ -784,10 +831,14 @@ static int populate_bpffs(struct dentry *parent)
 static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr bpf_rfiles[] = { { "" } };
-	struct bpf_mount_opts *opts = fc->fs_private;
+	struct bpf_mount_opts *opts = sb->s_fs_info;
 	struct inode *inode;
 	int ret;
 
+	/* Mounting an instance of BPF FS requires privileges */
+	if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
 	if (ret)
 		return ret;
@@ -811,7 +862,7 @@ static int bpf_get_tree(struct fs_context *fc)
 
 static void bpf_free_fc(struct fs_context *fc)
 {
-	kfree(fc->fs_private);
+	kfree(fc->s_fs_info);
 }
 
 static const struct fs_context_operations bpf_context_ops = {
@@ -835,17 +886,32 @@ static int bpf_init_fs_context(struct fs_context *fc)
 	opts->uid = current_fsuid();
 	opts->gid = current_fsgid();
 
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


