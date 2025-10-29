Return-Path: <linux-fsdevel+bounces-65998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA310C179A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60B98355938
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB412D323F;
	Wed, 29 Oct 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seTmrVh1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A22C3277;
	Wed, 29 Oct 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698635; cv=none; b=NqO/7FV5mFWrY6UIJEbprpjuv/8MIhUjb5T7hng8SUb3066404rZjCfi+j4PLTtjM5w84AuJEwq5oGKVRbiOIoNZ7JoOTVUv2HUKiarHJAY4cX0zLGC0xYSPvM6MizCYV3c5mjChTNkF13MnWU5P4pY1+yfwVbNoU2VrOaffSJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698635; c=relaxed/simple;
	bh=SWTMEt3z0VXKoppTdA3QABPVO46ZAplSRpO0+Arv/Z4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqIdZvQRguqzKaH2KWKgrDCqe1JgF7sbITqAPxKqYp5a4eToyLsKi9qfnCsX/skkoHjeUHCpPNvbkZDTDbC83YBwIkeOvAaBUBIJC0W4drpfThB7mEEmW6nnVI/thw1N2oonvByaQpnLzoCZIMGHhWXvfrtP7E2MpnV1YqszVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seTmrVh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD43C4CEE7;
	Wed, 29 Oct 2025 00:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698635;
	bh=SWTMEt3z0VXKoppTdA3QABPVO46ZAplSRpO0+Arv/Z4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=seTmrVh1mZCKLHQxYs5nZIt3X4CYRbCP2jSWbhuDuLML4VKA6aIWm3iOYoOWnjZ0F
	 xQrtzaqnsXsJmaJq5QhhMnXPr66WiuEZJAwdS/ychNmJ4vXq3VxEBdHkF+5Berf7vo
	 e/C5VbwChpyCN6v+YbYUNVgJN7g0QEeuYRMdHyJq0SwF4y1TldNezalgxKtSG7kZ94
	 iSicuF8tjG9vPvfJ4b2kdgVbsEpRuuL8rMx90TtLlD5wTKzmz96WazwzFcbPZt4QBn
	 xg1US/qPce9gCXimFUZc1/s/HC0v4KXJ3I0HYBZJLgITrjagjiuB/h5TZI2Y2rg6Un
	 WYjO26vCUzPGg==
Date: Tue, 28 Oct 2025 17:43:54 -0700
Subject: [PATCH 4/5] fuse: update file mode when updating acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169809339.1424347.12261722424900811903.stgit@frogsfrogsfrogs>
In-Reply-To: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If someone sets ACLs on a file that can be expressed fully as Unix DAC
mode bits, most local filesystems will then update the mode bits and
drop the ACL xattr to reduce inefficiency in the file access paths.
Let's do that too.  Note that means that we can setacl and end up with
no ACL xattrs, so we also need to tolerate ENODATA returns from
fuse_removexattr.

Note that here we define a "local" fuse filesystem as one that uses
fuseblk mode; we'll shortly add fuse servers that use iomap for the file
IO path to that list.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    2 +-
 fs/fuse/acl.c    |   43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8c47d103c8ffa6..d550937770e16e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
 	return get_fuse_mount_super(inode->i_sb);
 }
 
-static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
+static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
 {
 	return get_fuse_mount_super(inode->i_sb)->fc;
 }
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 8f484b105f13ab..72bb4c94079b7b 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -11,6 +11,18 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 
+/*
+ * If this fuse server behaves like a local filesystem, we can implement the
+ * kernel's optimizations for ACLs for local filesystems instead of passing
+ * the ACL requests straight through to another server.
+ */
+static inline bool fuse_inode_has_local_acls(const struct inode *inode)
+{
+	const struct fuse_conn *fc = get_fuse_conn(inode);
+
+	return fc->posix_acl && fuse_inode_is_exclusive(inode);
+}
+
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
 					struct inode *inode, int type, bool rcu)
 {
@@ -98,6 +110,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -113,6 +126,18 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		return -EINVAL;
 
+	/*
+	 * If the ACL can be represented entirely with changes to the mode
+	 * bits, then most filesystems will update the mode bits and delete
+	 * the ACL xattr.
+	 */
+	if (acl && type == ACL_TYPE_ACCESS &&
+	    fuse_inode_has_local_acls(inode)) {
+		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (ret)
+			return ret;
+	}
+
 	if (acl) {
 		unsigned int extra_flags = 0;
 		/*
@@ -143,7 +168,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * through POSIX ACLs. Such daemons don't expect setgid bits to
 		 * be stripped.
 		 */
-		if (fc->posix_acl &&
+		if (fc->posix_acl && mode == inode->i_mode &&
 		    !in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
@@ -152,6 +177,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
+		/* If the acl didn't exist to start with that's fine. */
+		if (ret == -ENODATA)
+			ret = 0;
+	}
+
+	/* If we scheduled a mode update above, push that to userspace now. */
+	if (!ret) {
+		struct iattr attr = { };
+
+		if (mode != inode->i_mode) {
+			attr.ia_valid |= ATTR_MODE;
+			attr.ia_mode = mode;
+		}
+
+		if (attr.ia_valid)
+			ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
 	}
 
 	if (fc->posix_acl) {


