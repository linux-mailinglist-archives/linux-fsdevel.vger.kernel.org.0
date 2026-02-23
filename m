Return-Path: <linux-fsdevel+bounces-78086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFHrL1nhnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C617F3FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F11231924A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B89137F756;
	Mon, 23 Feb 2026 23:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEd7dm6z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91A37F738;
	Mon, 23 Feb 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888732; cv=none; b=Hap/4+lpDZneh9kOBWqWKftzsHN2IJ/A8fPyPsRIZV5Bir+j8UbkglSnsC/sJ1ssRJQI2o6DvjFt2NF4PsL98PA40fUPGkooTk1iLOUpQB4oKkd/Hp3FTNnVZ0sVkJonqKPubg8TP1xixsC+yI5rG83lV3VhnT7ZKObjbaAEYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888732; c=relaxed/simple;
	bh=14xfhs0F4VwY9P0lpmc19aDZgCi+JG/Cq2JvR2rdsLE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=og4Tjwm539HPGbhl45mxvoUmNflLdXKxGDYBuwTEcktznSuWIM7P4I9H8Q5F26DrMKlcj524y9BIRXLx0XqXZJpari7Ym9XDqO3w4RRAJwrEudF6m1alpFI0bNF7u+OfcEe8mtVXuW3wUIae37KBJmtmYksW9lxU9aVFoXnQlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEd7dm6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92012C116C6;
	Mon, 23 Feb 2026 23:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888731;
	bh=14xfhs0F4VwY9P0lpmc19aDZgCi+JG/Cq2JvR2rdsLE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eEd7dm6zzTXP63gd1ExEHTuKi0ozZSQEio3Ctrz4+1afYYdCeUZkRNy6l/VMOIMGm
	 USSgpDir/llMaliSa5d4YlVMjsH6dE6q/RMjeknwdIkQ+nnw6Hfvq/umVfBd/6D2kZ
	 n8hY/3mC1LyY5giR/oE/Jsacau80wrCx9R2WnbbRJNeGPdjmYBcYgVsUG3dvKdRytV
	 UtGd/cJxkX4DFAJElMUgB9MqVPcXmkEMMLjRQChKXP11PdBINvSogzCtN0D/qmd0ES
	 bSLkLsGI2U3ifeLngktNPFK/i4HZgLlTTGjOJZfCvQItSxXDmitDwNIh60NABxXnLi
	 HGok/Rdh87aXA==
Date: Mon, 23 Feb 2026 15:18:51 -0800
Subject: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735590.3937167.5158925391897638243.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
References: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78086-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 247C617F3FA
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

There are three inode flags (immutable, append, sync) that are enforced
by the VFS.  Whenever we go around setting iflags, let's update the VFS
state so that they actually work.  Make it so that the fuse server can
set these three inode flags at load time and have the kernel advertise
and enforce them.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    1 +
 include/uapi/linux/fuse.h |    8 +++++++
 fs/fuse/dir.c             |    1 +
 fs/fuse/inode.c           |    1 +
 fs/fuse/ioctl.c           |   50 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 884f29533d0206..b4da866187ba2c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1654,6 +1654,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct file_kattr *fa);
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b6fa828776b82f..bf8514a5ee27af 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -249,6 +249,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -606,12 +608,18 @@ struct fuse_file_lock {
  * kernel can use cached attributes more aggressively (e.g. ACL inheritance)
  * FUSE_ATTR_IOMAP: Use iomap for this inode
  * FUSE_ATTR_ATOMIC: Enable untorn writes
+ * FUSE_ATTR_SYNC: File writes are synchronous
+ * FUSE_ATTR_IMMUTABLE: File is immutable
+ * FUSE_ATTR_APPEND: File is append-only
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_EXCLUSIVE	(1 << 2)
 #define FUSE_ATTR_IOMAP		(1 << 3)
 #define FUSE_ATTR_ATOMIC	(1 << 4)
+#define FUSE_ATTR_SYNC		(1 << 5)
+#define FUSE_ATTR_IMMUTABLE	(1 << 6)
+#define FUSE_ATTR_APPEND	(1 << 7)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5ae6c5639f6d2c..10543873f1a611 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1446,6 +1446,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
+	generic_fill_statx_attr(inode, stat);
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 94355977904068..7fcadbfe87a593 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -542,6 +542,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
+		fuse_fileattr_init(inode, attr);
 		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 07529db21fb781..bd2caf191ce2e0 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -502,6 +502,53 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
 	fuse_file_release(inode, ff, O_RDONLY, NULL, S_ISDIR(inode->i_mode));
 }
 
+static inline void update_iflag(struct inode *inode, unsigned int iflag,
+				bool set)
+{
+	if (set)
+		inode->i_flags |= iflag;
+	else
+		inode->i_flags &= ~iflag;
+}
+
+static void fuse_fileattr_update_inode(struct inode *inode,
+				       const struct file_kattr *fa)
+{
+	unsigned int old_iflags = inode->i_flags;
+
+	if (!fuse_inode_is_exclusive(inode))
+		return;
+
+	if (fa->flags_valid) {
+		update_iflag(inode, S_SYNC, fa->flags & FS_SYNC_FL);
+		update_iflag(inode, S_IMMUTABLE, fa->flags & FS_IMMUTABLE_FL);
+		update_iflag(inode, S_APPEND, fa->flags & FS_APPEND_FL);
+	} else if (fa->fsx_valid) {
+		update_iflag(inode, S_SYNC, fa->fsx_xflags & FS_XFLAG_SYNC);
+		update_iflag(inode, S_IMMUTABLE,
+					fa->fsx_xflags & FS_XFLAG_IMMUTABLE);
+		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
+	}
+
+	if (old_iflags != inode->i_flags)
+		fuse_invalidate_attr(inode);
+}
+
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
+{
+	if (!fuse_inode_is_exclusive(inode))
+		return;
+
+	if (attr->flags & FUSE_ATTR_SYNC)
+		inode->i_flags |= S_SYNC;
+
+	if (attr->flags & FUSE_ATTR_IMMUTABLE)
+		inode->i_flags |= S_IMMUTABLE;
+
+	if (attr->flags & FUSE_ATTR_APPEND)
+		inode->i_flags |= S_APPEND;
+}
+
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
@@ -572,7 +619,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
+		if (err)
+			goto cleanup;
 	}
+	fuse_fileattr_update_inode(inode, fa);
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);


