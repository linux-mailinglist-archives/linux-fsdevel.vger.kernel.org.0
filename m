Return-Path: <linux-fsdevel+bounces-55342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29353B09822
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BBA62B3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A92B2459D5;
	Thu, 17 Jul 2025 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLhJPohU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F2244663
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795220; cv=none; b=R6l4zSerE25gRxDpIi3l/fmpSzQPvVmB5S9/62tCZrU9LZ98/WzrSMCAxyUgfphaJXtaZoB4QC04vMS1jYwussTMhUHSfEWT8k9zPGupm3EF0GnXvCm0+eSe7y0AoWfgupkHUwjr1kW3OeJKPaTkfeRYO+6ETOgV+uLx6cKA4Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795220; c=relaxed/simple;
	bh=TMW36VSFVH7U0DicT5ihlTLsKQfFwsLjHRmBEBpuXTA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7eC9WWsLTqL9V0gaT5bkeXnRJdQ9XgSqWUhDfS5oic0xkqhX4VskjmWPrq8jZICjGVLGc9bq/V1s8fx5nrTQ9m5VgE7n2LleGXAj84P4s15eYFMEzNXXq59H/C4F+d8Cgc31Sh47pwLNogEfCgO64lvrFeG/gy7ifT/I4aMocY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLhJPohU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AA5C4CEE3;
	Thu, 17 Jul 2025 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795218;
	bh=TMW36VSFVH7U0DicT5ihlTLsKQfFwsLjHRmBEBpuXTA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qLhJPohUakDOK+BcWghBX6fCsfawo+Rb93kjoSWNz+up50EnKhOJJ6rtgKF3iSv0d
	 XDlBguo7Z9qDfzAwwkPDSSLMwGS0IocToyzYTGQ9+QlXJVCRxvNbMmBw00xbSVsaY4
	 ehcdjTgEi4TfvmIk+M/TWiNJXXyGw2ipAVOogU1RiehmBQ35b+uAYiFtO3bBrO/QXP
	 iNZBypPjHbhgEc7FC+n0YY6B64+pMynu8IoAgyvl8FPJIoxNJbXOW79e31GoXeUZJb
	 7eCVP+pSzs5Wv4R8nMN5ni1IZQTXczVchahOxg3ibR3ZCRSf7wQ2wRkJLm1EVERLcu
	 acStYEHISUw6w==
Date: Thu, 17 Jul 2025 16:33:38 -0700
Subject: [PATCH 4/7] fuse: update file mode when updating acls
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450869.713693.5806841508366894742.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
References: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
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
that too.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 8f484b105f13ab..b892976d9e284c 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -98,6 +98,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct inode *inode = d_inode(dentry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -113,6 +114,20 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		return -EINVAL;
 
+	/*
+	 * If the ACL can be represented entirely with changes to the mode
+	 * bits, then most filesystems will update the mode bits and delete
+	 * the ACL xattr.  Note that we only started doing this after the main
+	 * ACL implementation was merged, so that's why it's gated on regular
+	 * iomap.  XXX: This should be some sort of separate flag?
+	 */
+	if (acl && type == ACL_TYPE_ACCESS &&
+	    fuse_has_iomap(inode) && fc->posix_acl) {
+		ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (ret)
+			return ret;
+	}
+
 	if (acl) {
 		unsigned int extra_flags = 0;
 		/*
@@ -143,7 +158,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * through POSIX ACLs. Such daemons don't expect setgid bits to
 		 * be stripped.
 		 */
-		if (fc->posix_acl &&
+		if (fc->posix_acl && mode == inode->i_mode &&
 		    !in_group_or_capable(idmap, inode,
 					 i_gid_into_vfsgid(idmap, inode)))
 			extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
@@ -152,6 +167,19 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		kfree(value);
 	} else {
 		ret = fuse_removexattr(inode, name);
+		/* If the acl didn't exist to start with that's fine. */
+		if (ret == -ENODATA)
+			ret = 0;
+	}
+
+	/* If we scheduled a mode update above, push that to userspace now. */
+	if (!ret && mode != inode->i_mode) {
+		struct iattr attr = {
+			.ia_valid = ATTR_MODE,
+			.ia_mode = mode,
+		};
+
+		ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
 	}
 
 	if (fc->posix_acl) {


