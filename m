Return-Path: <linux-fsdevel+bounces-66033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB58C17A96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B45189F1B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B12D6E51;
	Wed, 29 Oct 2025 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mki6rYJJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A43D280328;
	Wed, 29 Oct 2025 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699183; cv=none; b=ow/bpdbM4C+yAjw3gXhoo3AM1ZkvLEioZa1QhrwwUHSiqMjZlMjons0531kPpKFIc89pWF1KpT9+qNsGscfj5kQFfHX5laU1vr9Fh3qGYkJtImxBakGt27bwwXmlIzUAXOYJnUJLS7M8Q6zAvrB/51AXhkW/Ub8L+wA7Z4BuAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699183; c=relaxed/simple;
	bh=8N1aWQ0HdDBx26664X4lfj7Yx7kPfiPy8s8LXkpzjJU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpINDUW0W4srOAcOSLhh9rUFAfwdA/nFgCCP9t19kpXJkpWucV+3S4Lb90+X3dQ1+ovgGa/d+rpnPN1TTtMttcyCgCJcg+PhP22ybj43t1aA3S/uel58FkxVeK4muH8Ww23gDWA8Xl+q2c7Y6luQssJA6lwTGF00zTF+7w5SWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mki6rYJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB727C4CEE7;
	Wed, 29 Oct 2025 00:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699182;
	bh=8N1aWQ0HdDBx26664X4lfj7Yx7kPfiPy8s8LXkpzjJU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Mki6rYJJv0V0/5lNkC+IJWBqYCGMjidA/Iux5COOVmVXd+EyldTTPl7wCy3OriccP
	 ur8ycK6o74skEjNdVHsnXx5FGHfHvRVe3LC+0Z03SKrTKpn3d0zJ0o35zS8nrbP38W
	 s3Xj4aSaRvkg0wJlnN/sBfcHDgPrq3/CqiQ1KvmrNPB1vOVCayXdG5+RtlaGrPs2Rn
	 1CZE7si0CkLm9uVNYyG98OTabCsX1rL0hN1N6bE0MGQWsN6a/fLCEC8yV2mIeIItGV
	 o7dBBik4LYmo8gcT6IPSdzg2SnMXmUmWgBi4O2boRH9F7ZdLhGD97gnYec1fPG4WXU
	 g5kPrcuwRk4gQ==
Date: Tue, 28 Oct 2025 17:53:02 -0700
Subject: [PATCH 31/31] fuse: implement freeze and shutdowns for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811023.1424854.7225516717354931327.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement filesystem freezing and block device shutdown notifications
for iomap-based servers

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/uapi/linux/fuse.h |   12 +++++++
 fs/fuse/inode.c           |   73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)


diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 41e88f1089f1b9..5d10e471f2df7f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -690,6 +690,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_FREEZE_FS		= 4089,
+	FUSE_UNFREEZE_FS	= 4090,
+	FUSE_SHUTDOWN_FS	= 4091,
+
 	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
@@ -1251,6 +1255,14 @@ struct fuse_syncfs_in {
 	uint64_t	padding;
 };
 
+struct fuse_freezefs_in {
+	uint64_t	unlinked;
+};
+
+struct fuse_shutdownfs_in {
+	uint64_t	flags;
+};
+
 /*
  * For each security context, send fuse_secctx with size of security context
  * fuse_secctx will be followed by security context name and this in turn
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c3f985baf21c77..d41a6e418537b5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1221,6 +1221,74 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	return parent;
 }
 
+#ifdef CONFIG_FUSE_IOMAP
+/*
+ * Second stage of a freeze. The data is already frozen so we only
+ * need to take care of the fuse server.
+ */
+static int fuse_freeze_fs(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_freezefs_in inarg = {
+		.unlinked = atomic_long_read(&sb->s_remove_count),
+	};
+	FUSE_ARGS(args);
+	int err;
+
+	if (!fc->iomap)
+		return -EOPNOTSUPP;
+
+	args.opcode = FUSE_FREEZE_FS;
+	args.nodeid = get_node_id(sb->s_root->d_inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS)
+		err = -EOPNOTSUPP;
+	return err;
+}
+
+static int fuse_unfreeze_fs(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	FUSE_ARGS(args);
+	int err;
+
+	if (!fc->iomap)
+		return 0;
+
+	args.opcode = FUSE_UNFREEZE_FS;
+	args.nodeid = get_node_id(sb->s_root->d_inode);
+	err = fuse_simple_request(fm, &args);
+	if (err == -ENOSYS)
+		err = 0;
+	return err;
+}
+
+static void fuse_shutdown_fs(struct super_block *sb)
+{
+	struct fuse_mount *fm = get_fuse_mount_super(sb);
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_shutdownfs_in inarg = {
+		.flags = 0,
+	};
+	FUSE_ARGS(args);
+
+	if (!fc->iomap)
+		return;
+
+	args.opcode = FUSE_SHUTDOWN_FS;
+	args.nodeid = get_node_id(sb->s_root->d_inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+	fuse_simple_request(fm, &args);
+}
+#endif /* CONFIG_FUSE_IOMAP */
+
 /* only for fid encoding; no support for file handle */
 static const struct export_operations fuse_export_fid_operations = {
 	.encode_fh	= fuse_encode_fh,
@@ -1243,6 +1311,11 @@ static const struct super_operations fuse_super_operations = {
 	.statfs		= fuse_statfs,
 	.sync_fs	= fuse_sync_fs,
 	.show_options	= fuse_show_options,
+#ifdef CONFIG_FUSE_IOMAP
+	.freeze_fs	= fuse_freeze_fs,
+	.unfreeze_fs	= fuse_unfreeze_fs,
+	.shutdown	= fuse_shutdown_fs,
+#endif
 };
 
 static void sanitize_global_limit(unsigned int *limit)


