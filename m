Return-Path: <linux-fsdevel+bounces-55676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B29B0DA41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321ECAA05F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06EA2EA15C;
	Tue, 22 Jul 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9nn/bWT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6EA2E9EB6;
	Tue, 22 Jul 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189085; cv=none; b=fbJB4DAG5EQrFnL5ViRsE+JYguVSyskWT60DxzXUHBG6xhyp/YWRc40yxyA4gudVZJoAQ+mBel93bDHkN9xXA03AtD0LWQCC/PCiGOt9jLbg6vnKS58g8npYxptveTAQFvdDRNiKwUf0VY+t1SBmzJ/iHL0+yAy0LUaQc9X8THo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189085; c=relaxed/simple;
	bh=ipcSAl2p7UNMrGTsCUH7w6ERABiAEJElRNJbsHfYPrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjkYX9I+GXM7alW+Y3sAd4xr4RAyKmN54aRFxz1g0+8XfWR97P7Nqg4TJR0wFc6WJixDqd/7zrEDlLtz1HnGrXCRzEKxokWHyj70HW9wBYwlOwPj1ux9xq7FYKXmnPUEL7lYLGmVb9kA3eINN8txvrndIotpf+82FC7zrZIYKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9nn/bWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35624C4CEF9;
	Tue, 22 Jul 2025 12:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753189084;
	bh=ipcSAl2p7UNMrGTsCUH7w6ERABiAEJElRNJbsHfYPrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9nn/bWTe1yw++iKM2rvj5tjQ1zUqHF6Y9Fx93zeXL95IbxUhZwVY0DKtGppeSb2w
	 k80qLOSIHmVcpv54m6/9gbvecy5RPq/oMEZ0Sj6iDXkLDvQNUtfjfMYE4ZZTjKrW+O
	 39ntGfuTCW33qAInR9fRSUjjEUBFZYQSiiRe39JdAmeQWlD4oGeBIRQNH7c89i13Oh
	 u7ZaUN5wkDttp5uonGTFrc3m/8YgPfmDVQmcp2hpEGORmjlJ21vR5GkzxTCCERJy/n
	 iYO+Ff+Gp1EZQck9cCDL/pQfF1J/WvAhBBy23wkUyIlbEJEf2i3ACeLCFibltYhxsm
	 D9immRI/mGISg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH RFC DRAFT v2 06/13] ceph: move fscrypt to filesystem inode
Date: Tue, 22 Jul 2025 14:57:12 +0200
Message-ID: <20250722-work-inode-fscrypt-v2-6-782f1fdeaeba@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
References: <20250722-work-inode-fscrypt-v2-0-782f1fdeaeba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=openpgp-sha256; l=4616; i=brauner@kernel.org; h=from:subject:message-id; bh=ipcSAl2p7UNMrGTsCUH7w6ERABiAEJElRNJbsHfYPrI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTUd216/cZuiYZ4UIp8W8wuuepbQdM+rm+5+abX2Yv3+ 48w3Yf2HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5VMrI0BretfrFddfwp4l6 +l2RR29xl8/8vu6UVrHgFc+mOXGP4xgZvm05d/ndYR7Dpmu/32f7LLG7wM28JKpit0aXoo+5D+M iDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Move fscrypt data pointer into the filesystem's private inode and record
the offset from the embedded struct inode.

This will allow us to drop the fscrypt data pointer from struct inode
itself and move it into the filesystem's inode.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ceph/dir.c         |  8 ++++++++
 fs/ceph/inode.c       | 21 +++++++++++++++++++++
 include/linux/netfs.h |  6 ++++++
 3 files changed, 35 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a321aa6d0ed2..2db146fadddb 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2229,6 +2229,10 @@ const struct file_operations ceph_snapdir_fops = {
 };
 
 const struct inode_operations ceph_dir_iops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
 	.lookup = ceph_lookup,
 	.permission = ceph_permission,
 	.getattr = ceph_getattr,
@@ -2248,6 +2252,10 @@ const struct inode_operations ceph_dir_iops = {
 };
 
 const struct inode_operations ceph_snapdir_iops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
 	.lookup = ceph_lookup,
 	.permission = ceph_permission,
 	.getattr = ceph_getattr,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 06cd2963e41e..3f8f779f3dcd 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -36,6 +36,12 @@
 
 static const struct inode_operations ceph_symlink_iops;
 static const struct inode_operations ceph_encrypted_symlink_iops;
+static const struct inode_operations ceph_encrypted_nop_iops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
+};
 
 static void ceph_inode_work(struct work_struct *work);
 
@@ -49,6 +55,7 @@ static int ceph_set_ino_cb(struct inode *inode, void *data)
 
 	ci->i_vino = *(struct ceph_vino *)data;
 	inode->i_ino = ceph_vino_to_ino_t(ci->i_vino);
+	inode->i_op = &ceph_encrypted_nop_iops;
 	inode_set_iversion_raw(inode, 0);
 	percpu_counter_inc(&mdsc->metric.total_inodes);
 
@@ -89,6 +96,8 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 	inode->i_state = 0;
 	inode->i_mode = *mode;
 
+	inode->i_op = &ceph_encrypted_nop_iops;
+
 	err = ceph_security_init_secctx(dentry, *mode, as_ctx);
 	if (err < 0)
 		goto out_err;
@@ -232,6 +241,10 @@ struct inode *ceph_get_snapdir(struct inode *parent)
 }
 
 const struct inode_operations ceph_file_iops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
 	.permission = ceph_permission,
 	.setattr = ceph_setattr,
 	.getattr = ceph_getattr,
@@ -2314,6 +2327,10 @@ static int ceph_encrypted_symlink_getattr(struct mnt_idmap *idmap,
  * symlinks
  */
 static const struct inode_operations ceph_symlink_iops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
 	.get_link = simple_get_link,
 	.setattr = ceph_setattr,
 	.getattr = ceph_getattr,
@@ -2321,6 +2338,10 @@ static const struct inode_operations ceph_symlink_iops = {
 };
 
 static const struct inode_operations ceph_encrypted_symlink_iops = {
+#ifdef CONFIG_FS_ENCRYPTION
+	.i_fscrypt = offsetof(struct ceph_inode_info, netfs.i_fscrypt_info) -
+		     offsetof(struct ceph_inode_info, netfs.inode),
+#endif
 	.get_link = ceph_encrypted_get_link,
 	.setattr = ceph_setattr,
 	.getattr = ceph_encrypted_symlink_getattr,
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 065c17385e53..fda1321da861 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -57,6 +57,9 @@ typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_error);
  */
 struct netfs_inode {
 	struct inode		inode;		/* The VFS inode */
+#ifdef CONFIG_FS_ENCRYPTION
+	struct fscrypt_inode_info *i_fscrypt_info;
+#endif
 	const struct netfs_request_ops *ops;
 #if IS_ENABLED(CONFIG_FSCACHE)
 	struct fscache_cookie	*cache;
@@ -503,6 +506,9 @@ static inline void netfs_inode_init(struct netfs_inode *ctx,
 		ctx->zero_point = ctx->remote_i_size;
 		mapping_set_release_always(ctx->inode.i_mapping);
 	}
+#ifdef CONFIG_FS_ENCRYPTION
+	ctx->i_fscrypt_info = NULL;
+#endif
 }
 
 /**

-- 
2.47.2


