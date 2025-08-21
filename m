Return-Path: <linux-fsdevel+bounces-58439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF50FB2E9C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76451CC32BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9E1E5B70;
	Thu, 21 Aug 2025 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnvAJk00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F538190685
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737519; cv=none; b=YSoy6NwE44St69eU5xBZvvRtNkETmepp/9m/qtYlrvLCUAUR3PvoU0e822tJQz3C7dgwkY0+imE5CuPxxuIEyNvIlQbR6kcxeOloW2pZ7t3EHWO3B5xC8T7T1Rc1gOBhaaUFFMnqsFnQSDt61HITYWd0DcpkCr3KlVkEeL2ISFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737519; c=relaxed/simple;
	bh=QZeQeRWjycXa9Hs1XvW2ORa1shYr5peoRygN6AQ1KBA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2NivF6zzHnejwy9dRFo9SDn7lU67Nxy26C3eGbcFXTW5DI7H8KPtJJIypVNSsQ4DPJqMOwyzTL4Em0Qy/ZVBei6uOu4LfX4KBs4vIm/nj8uBgE+3dL7LU2i+u2LwOsfH3KZUizyBuzNU5vin/5mpeEcAccmz95Oxmy+ViPlhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnvAJk00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EF9C4CEE7;
	Thu, 21 Aug 2025 00:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737519;
	bh=QZeQeRWjycXa9Hs1XvW2ORa1shYr5peoRygN6AQ1KBA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lnvAJk00VWYtgCiSJruWyIgumdS2RXucJTCKT5eV96QXAXL+gaHxmma6XamjiwroN
	 GH8VciSXJunJccWC3l6BAj1qyujygZmtxmojUdzQSub3dxW0/f8QJZu8+ckCi0DFQY
	 VQa08RDI4MZth7AF9XTm42zhMrfAArccq+10jGttNBDwQ2I44Wc8R3mkTSuChOYk9q
	 vwfRtQLVreFKIzi9xmhYWcR2duRfrTRBvmZV8VHg1aim40Zdj+g/L9yCVs9E5YC604
	 Sz791cuY6VGfzA8L+e0d4pUzTo4T5eJn1wfL5ahjqFyCijpVyG5OT6LQwaOtx4tVzG
	 M8BjY9TjalQRw==
Date: Wed, 20 Aug 2025 17:51:58 -0700
Subject: [PATCH 5/7] fuse: update file mode when updating acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573708651.15537.17340709280148279543.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
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
mode bits, most filesystems will then update the mode bits and drop the
ACL xattr to reduce inefficiency in the file access paths.  Let's do
that too.  Note that means that we can setacl and end up with no ACL
xattrs, so we also need to tolerate ENODATA returns from
fuse_removexattr.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 8f484b105f13ab..63df349dee1caf 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -98,6 +98,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -113,6 +114,17 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		return -EINVAL;
 
+	/*
+	 * If the ACL can be represented entirely with changes to the mode
+	 * bits, then most filesystems will update the mode bits and delete
+	 * the ACL xattr.
+	 */
+	if (acl && type == ACL_TYPE_ACCESS && fc->posix_acl) {
+		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (ret)
+			return ret;
+	}
+
 	if (acl) {
 		unsigned int extra_flags = 0;
 		/*
@@ -143,7 +155,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * through POSIX ACLs. Such daemons don't expect setgid bits to
 		 * be stripped.
 		 */
-		if (fc->posix_acl &&
+		if (fc->posix_acl && mode == inode->i_mode &&
 		    !in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
@@ -152,6 +164,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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


