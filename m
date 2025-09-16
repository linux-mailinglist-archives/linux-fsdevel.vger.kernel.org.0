Return-Path: <linux-fsdevel+bounces-61498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8413B58931
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9170A2A14EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F921A0712;
	Tue, 16 Sep 2025 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd86+AHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703E19E99F;
	Tue, 16 Sep 2025 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982338; cv=none; b=YuymI0tubblOv+wgHj0c6nbwGvY4IbXRPqtg+487erdnXDbUeAHdlrA2N6AmOo19j5HywZIo1ClQiYpGPu6I0yLTRDxENwl0thFpH8SPoai/zMrbkm6a/6X++IYkG+jYrdEmNAAgw4tpQk2C8TH2LHNzk5CLLFMIRsggTsoLp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982338; c=relaxed/simple;
	bh=zLQeuT3EfxmV9o26f5Bu45BGkAYyR5LsdV79Koh7vJ4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2etIlY710MsbDdJvh5JFj9HmLKklT9h9UMyGcyMWOIzHeQiZLzurGvjApc6srsWfdaV9qpanxQDRotLNlwgqjn4633m9wyMKvlagx05eCjpN/2JH/zj8DXi4Z43PKHvkHSUnB691PVgW7FzzgL766iVMeU5Wj0oP3mx4PsJfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd86+AHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E78FC4CEF1;
	Tue, 16 Sep 2025 00:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982338;
	bh=zLQeuT3EfxmV9o26f5Bu45BGkAYyR5LsdV79Koh7vJ4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Yd86+AHfLwIOthN6utBf6vnxQNZYMW+XioT8dNRP9GVWJNicpuWUhqzV/TsPhQ2ss
	 Fkl/0Hr7Fa8cyFUu+ppy4MGC/vL7bwWjV1Zn8NPu8jQils2jd0pvf3RZs7nmYDs9Kq
	 4MuoUnbBFJOVvyNB/wscx0xRkoaEy1sJr5Ybm/9nDpiZP/pdu0OBq3jxDzG5J1XTq7
	 Y6PxuLL4P4LKjBOzQu6B6hnrRCviEsgT8g5K9ohSzdkEC50r/WeVBcy3ZQoQM/t1F3
	 d1bOr5M82fbq81WhpRWDPF08R9z+Z1LxqZhvjQyMrtNkSvuyUuhAXtP+Dz6TSE51CP
	 KSZVqFj/X4Llw==
Date: Mon, 15 Sep 2025 17:25:37 -0700
Subject: [PATCH 6/8] fuse: update file mode when updating acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798150156.381990.10321060777321307486.stgit@frogsfrogsfrogs>
In-Reply-To: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
References: <175798149979.381990.14913079500562122255.stgit@frogsfrogsfrogs>
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
 fs/fuse/acl.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 8f484b105f13ab..4997827ee83c6d 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -11,6 +11,16 @@
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 
+/*
+ * If this fuse server behaves like a local filesystem, we can implement the
+ * kernel's optimizations for ACLs for local filesystems instead of passing
+ * the ACL requests straight through to another server.
+ */
+static inline bool fuse_has_local_acls(const struct fuse_conn *fc)
+{
+	return fc->posix_acl && fc->local_fs;
+}
+
 static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
 					struct inode *inode, int type, bool rcu)
 {
@@ -98,6 +108,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -113,6 +124,17 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		return -EINVAL;
 
+	/*
+	 * If the ACL can be represented entirely with changes to the mode
+	 * bits, then most filesystems will update the mode bits and delete
+	 * the ACL xattr.
+	 */
+	if (acl && type == ACL_TYPE_ACCESS && fuse_has_local_acls(fc)) {
+		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (ret)
+			return ret;
+	}
+
 	if (acl) {
 		unsigned int extra_flags = 0;
 		/*
@@ -143,7 +165,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * through POSIX ACLs. Such daemons don't expect setgid bits to
 		 * be stripped.
 		 */
-		if (fc->posix_acl &&
+		if (fc->posix_acl && mode == inode->i_mode &&
 		    !in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
@@ -152,6 +174,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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


