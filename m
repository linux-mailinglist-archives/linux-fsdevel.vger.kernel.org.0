Return-Path: <linux-fsdevel+bounces-6588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B21819FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 14:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3EE286937
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3E358A5;
	Wed, 20 Dec 2023 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OFjtUT/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573D230662;
	Wed, 20 Dec 2023 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8RSMaLm8J3BAud8wZe5DBi5drp4MBQE414D7i1/am6w=; b=OFjtUT/rPMi+Tbe1mlO9EDFhRK
	Z5qjbejrCpkKmTlbBmc5VevZNJ4blFKIVChjjQA/OlRRxLlt0btzzlzOkItDpQku7Kon7YMJmrR+b
	ywcN2Zjttn4elWwU+yhppv5SFi0TcjR3TWtw24fxiH3kYJthxtqyys5xUVAHu0cFEYDFKb6UEPshf
	jU9jB9B6dHK6yXYo/uM59cMGNi1TionJ65q3Zm37N2dM4Q9Hg13L9YGVcBN+EBlDhJelbNIuq/DGh
	DYRxP2Q7Xe8xSvA/gyoQXW5KjQcxqN7aSHuIhkvWciQFRVvHNwuXd2eK+8MjmvuC19cckjy/Wdx79
	tj/IZIlg==;
Received: from 36.249.197.178.dynamic.dsl-lte-bonding.lssmb00p-msn.res.cust.swisscom.ch ([178.197.249.36] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFwm6-000BrB-NW; Wed, 20 Dec 2023 14:38:14 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Christian Brauner <brauner@kernel.org>,
	Jie Jiang <jiejiang@chromium.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Re-support uid and gid when mounting bpffs
Date: Wed, 20 Dec 2023 14:38:05 +0100
Message-Id: <20231220133805.20953-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

For a clean, conflict-free revert of the token-related patches in commit
d17aff807f84 ("Revert BPF token-related functionality"), the bpf fs commit
750e785796bb ("bpf: Support uid and gid when mounting bpffs") was undone
temporarily as well.

This patch manually re-adds the functionality from the original one back
in 750e785796bb, no other functional changes intended.

Testing:

  # mount -t bpf -o uid=65534,gid=65534 bpffs ./foo
  # ls -la . | grep foo
  drwxrwxrwt   2 nobody nogroup          0 Dec 20 13:16 foo
  # mount -t bpf
  bpffs on /root/foo type bpf (rw,relatime,uid=65534,gid=65534)

Also, passing invalid arguments for uid/gid are properly rejected as expected.

Fixes: d17aff807f84 ("Revert BPF token-related functionality")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jie Jiang <jiejiang@chromium.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
---
 kernel/bpf/inode.c | 53 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 1aafb2ff2e95..41e0a55c35f5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -599,8 +599,15 @@ EXPORT_SYMBOL(bpf_prog_get_type_path);
  */
 static int bpf_show_options(struct seq_file *m, struct dentry *root)
 {
-	umode_t mode = d_inode(root)->i_mode & S_IALLUGO & ~S_ISVTX;
-
+	struct inode *inode = d_inode(root);
+	umode_t mode = inode->i_mode & S_IALLUGO & ~S_ISVTX;
+
+	if (!uid_eq(inode->i_uid, GLOBAL_ROOT_UID))
+		seq_printf(m, ",uid=%u",
+			   from_kuid_munged(&init_user_ns, inode->i_uid));
+	if (!gid_eq(inode->i_gid, GLOBAL_ROOT_GID))
+		seq_printf(m, ",gid=%u",
+			   from_kgid_munged(&init_user_ns, inode->i_gid));
 	if (mode != S_IRWXUGO)
 		seq_printf(m, ",mode=%o", mode);
 	return 0;
@@ -625,15 +632,21 @@ static const struct super_operations bpf_super_ops = {
 };
 
 enum {
+	OPT_UID,
+	OPT_GID,
 	OPT_MODE,
 };
 
 static const struct fs_parameter_spec bpf_fs_parameters[] = {
+	fsparam_u32	("uid",				OPT_UID),
+	fsparam_u32	("gid",				OPT_GID),
 	fsparam_u32oct	("mode",			OPT_MODE),
 	{}
 };
 
 struct bpf_mount_opts {
+	kuid_t uid;
+	kgid_t gid;
 	umode_t mode;
 };
 
@@ -641,6 +654,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct bpf_mount_opts *opts = fc->fs_private;
 	struct fs_parse_result result;
+	kuid_t uid;
+	kgid_t gid;
 	int opt;
 
 	opt = fs_parse(fc, bpf_fs_parameters, param, &result);
@@ -662,12 +677,42 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	switch (opt) {
+	case OPT_UID:
+		uid = make_kuid(current_user_ns(), result.uint_32);
+		if (!uid_valid(uid))
+			goto bad_value;
+
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fc->user_ns, uid))
+			goto bad_value;
+
+		opts->uid = uid;
+		break;
+	case OPT_GID:
+		gid = make_kgid(current_user_ns(), result.uint_32);
+		if (!gid_valid(gid))
+			goto bad_value;
+
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fc->user_ns, gid))
+			goto bad_value;
+
+		opts->gid = gid;
+		break;
 	case OPT_MODE:
 		opts->mode = result.uint_32 & S_IALLUGO;
 		break;
 	}
 
 	return 0;
+bad_value:
+	return invalfc(fc, "Bad value for '%s'", param->key);
 }
 
 struct bpf_preload_ops *bpf_preload_ops;
@@ -750,6 +795,8 @@ static int bpf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &bpf_super_ops;
 
 	inode = sb->s_root->d_inode;
+	inode->i_uid = opts->uid;
+	inode->i_gid = opts->gid;
 	inode->i_op = &bpf_dir_iops;
 	inode->i_mode &= ~S_IALLUGO;
 	populate_bpffs(sb->s_root);
@@ -785,6 +832,8 @@ static int bpf_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	opts->mode = S_IRWXUGO;
+	opts->uid = current_fsuid();
+	opts->gid = current_fsgid();
 
 	fc->fs_private = opts;
 	fc->ops = &bpf_context_ops;
-- 
2.27.0


