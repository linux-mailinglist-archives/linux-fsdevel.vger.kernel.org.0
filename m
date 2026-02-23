Return-Path: <linux-fsdevel+bounces-78080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEUCGATgnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:17:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8017F1A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47717301AE62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C816837F733;
	Mon, 23 Feb 2026 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9QHVVdm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F9937D10B;
	Mon, 23 Feb 2026 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888638; cv=none; b=OSG1IkD4LIdKyjPFHLR5k9y694J0Y4gG6Xs+Ayw2RclNMCkR9GM1qIclvJaBiKn+CKxFyQh4CPzHfbMfWr160p5InZ+h08QBiO0Qai1tf3OWOn/KbZ7YGQppM0NzW6SuwjGWA5h/JgGfTrNThs4CcPZWL7FgFjcleZt0xCluAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888638; c=relaxed/simple;
	bh=QQvOAP5PpdwOMtRGMMk3kkm4XfPCZ/YqnQRvbE/V8zM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZolYDAtu6cHoJrROqiTb++nL3kAMc261DivbuwUmbAGg7fg05nncWop8EiuixBw6qbpfoId0fZd0hgtaC0iSvaKYMKnE6HZ9n8XPkbIeykFCmth8uO52ubZD7XTgtkjgbjms2onMmA5PQDzhigF06w1Us/LKQXctx3sbEwzXmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9QHVVdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C6C116C6;
	Mon, 23 Feb 2026 23:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888637;
	bh=QQvOAP5PpdwOMtRGMMk3kkm4XfPCZ/YqnQRvbE/V8zM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=i9QHVVdmp4swB279a1fQdexXAxDALxIDKkYDw9HB2BeEz4wXbEEFJ36cqGFBMlAME
	 ctfeQPr2Q1txFySj/ufl/jR3XQhrPGcqdxGzCYpciqiJ6HA8HEW32qXcyGs0IdELd/
	 ytA1QzCrkTMXAXltrG8zFdhipgr7AbHxwUhuO+L1HEVpbWI/ION0QlamOGgUsQqMH6
	 4YrygtIKu3EhUQrEyJflx7s+Oz6B2BLjsmOqdhj4sDnKV7m2/CznW/NrSN8HyAEIlw
	 gLjdb9EeI/e41ypm1+zpHUSQDELlfLgcvq8VQPlGmytjflNjcgsZvU2dLp+5pxfyTp
	 BYNELbo9uTkqA==
Date: Mon, 23 Feb 2026 15:17:17 -0800
Subject: [PATCH 33/33] fuse: implement freeze and shutdowns for iomap
 filesystems
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734951.3935739.9034530025371248347.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78080-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07D8017F1A2
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Implement filesystem freezing and block device shutdown notifications
for iomap-based servers

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/uapi/linux/fuse.h |   12 +++++++
 fs/fuse/inode.c           |   73 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)


diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5f3724f36f764a..b6fa828776b82f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -695,6 +695,10 @@ enum fuse_opcode {
 	FUSE_STATX		= 52,
 	FUSE_COPY_FILE_RANGE_64	= 53,
 
+	FUSE_FREEZE_FS		= 4089,
+	FUSE_UNFREEZE_FS	= 4090,
+	FUSE_SHUTDOWN_FS	= 4091,
+
 	FUSE_IOMAP_CONFIG	= 4092,
 	FUSE_IOMAP_IOEND	= 4093,
 	FUSE_IOMAP_BEGIN	= 4094,
@@ -1257,6 +1261,14 @@ struct fuse_syncfs_in {
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
index 4d805c7f484517..f3afa63bfe7f61 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1235,6 +1235,74 @@ static struct dentry *fuse_get_parent(struct dentry *child)
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
@@ -1257,6 +1325,11 @@ static const struct super_operations fuse_super_operations = {
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


