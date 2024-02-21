Return-Path: <linux-fsdevel+bounces-12378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF785EAC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC5FEB27CED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783214A088;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqHKBP3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3112DD91;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=KBrQYCzsHdOYqYU4eWLWaZOFrqcy/Pk5s92zfKWQ/36X3QtA2ruGu6RJxaaHn4e4kEmBTnJ8adhdY2e7RrIMbjTirsvME/vE95WR3n4lCBqr5DLMA1IFuOwnVJ1GWEJCs6TLJAo5EiO/JSFnZrhsgUHH1T0m+sfRJ6polOxLZjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=ttWdljGV2VOOVlmLs8ch4F+B9OPu/3AJrV4l738gSBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pw2v80WMhiGpLtqu9x5KB0I6HV5bC3+f6CIL7sKWUZlOQcY5EHaoPXuUx4Rfl/QvAjXVPuWSFB3OTZleUDoj0s/14Ah5RACKokbSzY7tKF2hWDnVrOQbokj+/lxK51PURSP0Ji+YSMGOTNuBX8bEmzbvxmh2dbT3oRjwJUyp9Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqHKBP3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E595C36AEE;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=ttWdljGV2VOOVlmLs8ch4F+B9OPu/3AJrV4l738gSBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uqHKBP3J4IPMX2ack7XXoakPLKGIQWPInhHuqQcEsbokp77sYp+0fBwH7WFmzz1X2
	 ero9AJeBQJrkHPwe/FaDYck/ACfEJoZgUAzc+Op7aBaIdJVi+6Lzw4u8juhNq9HlAI
	 d5uFcA29Z3Co9rw30F5W2vCC/31QIThKoHnAnPAm6qF/9vI23uOeyQzIUwbAy5b9yS
	 8ED4KrNbstsfd3mEjSxKkKHw8kexLcNnGqaCFJr0SLSHC5JmdRu8KmLnpjcEU9XLIB
	 nLmaJqBWTTb8vtExN0sZ3E47+JhPHp+5Y064Qlix3nBNp+LkLqh5ccHEWk5KuYwf5V
	 wGjCyip2arhWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B9FC5478C;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:51 -0600
Subject: [PATCH v2 20/25] ovl: add fscaps handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-20-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4817; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=ttWdljGV2VOOVlmLs8ch4F+B9OPu/3AJrV4l738gSBE=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moqr1C0o66vju1JEhWEhxdjP?=
 =?utf-8?q?9MjLsg75RZLdJMz_EGbaqxmJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqKgAKCRBTA5mu5fQxyasXB/_0ck2MmFB/6xo9OUk9n0uU1WV1hFMVoAQcMt?=
 =?utf-8?q?qmhIQz/2o92A+LSQK3qhijWqisOM+8FwP0mq2qJxzMN_vIR8aLOcS0thGDP0hfR39?=
 =?utf-8?q?KgwnIBaHRd/nB/r7IdYiRO+hJmxzhiWNUp1IIYYbAlGvxeD7YKcQaPI6w_ujDpQ/1?=
 =?utf-8?q?BRMFLG/aUZlWxGKGWcvTaun5znDQgPzJy2O4WmnYgB0YdN+3H+qKej3XIqL5cxd9t?=
 =?utf-8?q?pymr8a_HVtkrcMynShyHq7SIhQ1Hshd+ebeNCgKfG4XE3neYdZrCQjNHAcwys74za?=
 =?utf-8?q?Z8osEiqTuT5wf1p4sORt?= V1GcnFZzEQHrTdJSCnsZ7y7llnM8zr
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Add handlers which read fs caps from the lower or upper filesystem and
write/remove fs caps to the upper filesystem, performing copy-up as
necessary.

While fscaps only really make sense on regular files, the general policy
is to allow most xattr namespaces on all different inode types, so
fscaps handlers are installed in the inode operations for all types of
inodes.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/overlayfs/dir.c       |  2 ++
 fs/overlayfs/inode.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/overlayfs/overlayfs.h |  5 ++++
 3 files changed, 79 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0f8b4a719237..4ff360fe10c9 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1307,6 +1307,8 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
+	.get_fscaps	= ovl_get_fscaps,
+	.set_fscaps	= ovl_set_fscaps,
 	.update_time	= ovl_update_time,
 	.fileattr_get	= ovl_fileattr_get,
 	.fileattr_set	= ovl_fileattr_set,
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..7a8978ea6fe1 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -568,6 +568,72 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 #endif
 
+int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+		   struct vfs_caps *caps)
+{
+	int err;
+	const struct cred *old_cred;
+	struct path realpath;
+
+	ovl_path_real(dentry, &realpath);
+	old_cred = ovl_override_creds(dentry->d_sb);
+	err = vfs_get_fscaps(mnt_idmap(realpath.mnt), realpath.dentry, caps);
+	revert_creds(old_cred);
+	return err;
+}
+
+int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+		   const struct vfs_caps *caps, int setxattr_flags)
+{
+	int err;
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
+	struct dentry *upperdentry = ovl_dentry_upper(dentry);
+	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
+	const struct cred *old_cred;
+
+	/*
+	 * If the fscaps are to be remove from a lower file, check that they
+	 * exist before copying up.
+	 */
+	if (!caps && !upperdentry) {
+		struct path realpath;
+		struct vfs_caps lower_caps;
+
+		ovl_path_lower(dentry, &realpath);
+		old_cred = ovl_override_creds(dentry->d_sb);
+		err = vfs_get_fscaps(mnt_idmap(realpath.mnt), realdentry,
+				     &lower_caps);
+		revert_creds(old_cred);
+		if (err)
+			goto out;
+	}
+
+	err = ovl_want_write(dentry);
+	if (err)
+		goto out;
+
+	err = ovl_copy_up(dentry);
+	if (err)
+		goto out_drop_write;
+	upperdentry = ovl_dentry_upper(dentry);
+
+	old_cred = ovl_override_creds(dentry->d_sb);
+	if (!caps)
+		err = vfs_remove_fscaps(ovl_upper_mnt_idmap(ofs), upperdentry);
+	else
+		err = vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), upperdentry,
+				     caps, setxattr_flags);
+	revert_creds(old_cred);
+
+	/* copy c/mtime */
+	ovl_copyattr(d_inode(dentry));
+
+out_drop_write:
+	ovl_drop_write(dentry);
+out:
+	return err;
+}
+
 int ovl_update_time(struct inode *inode, int flags)
 {
 	if (flags & S_ATIME) {
@@ -747,6 +813,8 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
+	.get_fscaps	= ovl_get_fscaps,
+	.set_fscaps	= ovl_set_fscaps,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
 	.fileattr_get	= ovl_fileattr_get,
@@ -758,6 +826,8 @@ static const struct inode_operations ovl_symlink_inode_operations = {
 	.get_link	= ovl_get_link,
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
+	.get_fscaps	= ovl_get_fscaps,
+	.set_fscaps	= ovl_set_fscaps,
 	.update_time	= ovl_update_time,
 };
 
@@ -769,6 +839,8 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.get_inode_acl	= ovl_get_inode_acl,
 	.get_acl	= ovl_get_acl,
 	.set_acl	= ovl_set_acl,
+	.get_fscaps	= ovl_get_fscaps,
+	.set_fscaps	= ovl_set_fscaps,
 	.update_time	= ovl_update_time,
 };
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ee949f3e7c77..4f948749ee02 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -781,6 +781,11 @@ static inline struct posix_acl *ovl_get_acl_path(const struct path *path,
 }
 #endif
 
+int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+		   struct vfs_caps *caps);
+int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+		   const struct vfs_caps *caps, int setxattr_flags);
+
 int ovl_update_time(struct inode *inode, int flags);
 bool ovl_is_private_xattr(struct super_block *sb, const char *name);
 

-- 
2.43.0


