Return-Path: <linux-fsdevel+bounces-12381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E218785EAC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3161F230E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546914A093;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/DrHt2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485412E1E8;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=dseJqO9nVSpov9Srg1XmV/laayeeRhiBmTUAwUz0HAHvYL68s0K2quPuJ2Z/60QqBZYqIpX7WX/uct1bWFtBorquXOtwIiPbkGaNDsPGsl782h0XJVVJNs+/SVB+EJ7YZ4TlSbHl92pfh7EXoNtX/pUzj2i48Pzo/TZeDii8LqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=RQFtdcZgDrf45vR2XiLoEkCPweXmO4ZdGDXy9B9n38k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtfBuVHrXmTD87yDgF+ldZY87NqvSgHzUWCiWADHbeyxfflQpnPattt7A9kYnTapEc8R7B5jaESXZ1XEyjJkUSvsNsuqN4n0oQ3d8bUdcoM2/SCytjbuxElEO9yo1kujPzRCK0ZfBfCA5IWWa556Na+j0fhIQSZonrrf1HR+khY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/DrHt2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B21FC341C8;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=RQFtdcZgDrf45vR2XiLoEkCPweXmO4ZdGDXy9B9n38k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a/DrHt2kmlpWdSvlfpEqoT+ztdgYDFlQx+ciof4tYe7LF1KVF37Ba0B1z/zcyF//n
	 s/dlkzoyTrW/XbIz6ACIbJMaJDxL0HYAp3dFFCwBDQ7am4xSVN6FUDOLsMqbmX9cZY
	 aAJ6QYC9tQ1u54O1o8ca7yjXn1UXn3Wf1oe4DdekQxO04Vb4vMi8wqF71bscivyze5
	 x12nGIE5ZVRLGAa9NKLmtCvOH9Yo+uNjkqPPBzdqQeiTytcs5MBMnRSG1VXyPmkoEr
	 +1dq6dIcfoeKPPFybfp7hf1Do4+6+Im1/z/ONhjKneEdbOzK77kI1L3Xbn2PJ5yURn
	 5wMgcIUYJh90g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EA8C54798;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:53 -0600
Subject: [PATCH v2 22/25] fs: use vfs interfaces for capabilities xattrs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-22-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8472; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=RQFtdcZgDrf45vR2XiLoEkCPweXmO4ZdGDXy9B9n38k=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mosKTAjMWeC0JwdcAIeT/V7q?=
 =?utf-8?q?bWgZMaWg9RP69NM_lVsgG1+JATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqLAAKCRBTA5mu5fQxyYsNB/_9Y4IU7+FdOu481pv/83xdJkuv3HJDQ0OP6d?=
 =?utf-8?q?PEatAyIagnNoameoxxxOXPAJKIj5Q4CkEed978+mLU2_kAgoUny2gWC/i4OaBfuMH?=
 =?utf-8?q?hHIX/npJMtYubeIoEdBcvSEMwkUj8HT7HP0Ximcmuy/CiumUMSn1i8uyI_6q6X5c1?=
 =?utf-8?q?Bamvez+8NIfJ9Dh+OUk4jDZgWUc0rOzf5WprMEmBnUKNDF5R0erPvqoJ2wgO2BbCx?=
 =?utf-8?q?6eErI4_s++SjtCrwT16me5yj5VUN+2Ix7qkRevh08dpk06QcqYJENzMHW9hkJmy5g?=
 =?utf-8?q?/XjN3HtxwEWdW7qnUJ05?= E9Boh3G9Ai9l4Tn+77y40mzF1cubex
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Now that all the plumbing is in place, switch over to using the new
inode operations to get/set fs caps. This pushes all mapping of ids into
the caller's user ns to above the vfs_*() level, making this consistent
with other vfs_*() interfaces.

cap_convert_nscap() is updated to return vfs_caps and moved to be called
from the new code path for setting fscaps. This means that use of
vfs_setxattr() will no longer remap ids in fscap xattrs, but all code
which used vfs_setxattr() for fscaps xattrs has been converted to the
new interfaces.

Removing the mapping of fscaps rootids from vfs_getxattr() is more
invovled and will be addressed in a later commit.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c                 | 49 ++++++++++++++++++++++++----
 include/linux/capability.h |  2 +-
 security/commoncap.c       | 79 +++++++++++++++-------------------------------
 3 files changed, 69 insertions(+), 61 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 8b0f7384cbc9..30eff6bc4f6d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -534,13 +534,6 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
-	if (size && is_fscaps_xattr(name)) {
-		error = cap_convert_nscap(idmap, dentry, &value, size);
-		if (error < 0)
-			return error;
-		size = error;
-	}
-
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(idmap, dentry, name, value, size,
@@ -851,6 +844,24 @@ int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return do_set_acl(idmap, dentry, ctx->kname->name,
 				  ctx->kvalue, ctx->size);
 
+	if (is_fscaps_xattr(ctx->kname->name)) {
+		struct vfs_caps caps;
+		int ret;
+
+		/*
+		 * rootid is already in the mount idmap, so pass nop_mnt_idmap
+		 * so that it won't be mapped.
+		 */
+		ret = vfs_caps_from_xattr(&nop_mnt_idmap, current_user_ns(),
+					  &caps, ctx->kvalue, ctx->size);
+		if (ret)
+			return ret;
+		ret = cap_convert_nscap(idmap, dentry, &caps);
+		if (ret)
+			return ret;
+		return vfs_set_fscaps(idmap, dentry, &caps, ctx->flags);
+	}
+
 	return vfs_setxattr(idmap, dentry, ctx->kname->name,
 			ctx->kvalue, ctx->size, ctx->flags);
 }
@@ -949,6 +960,27 @@ do_getxattr(struct mnt_idmap *idmap, struct dentry *d,
 	ssize_t error;
 	char *kname = ctx->kname->name;
 
+	if (is_fscaps_xattr(kname)) {
+		struct vfs_caps caps;
+		struct vfs_ns_cap_data data;
+		int ret;
+
+		ret = vfs_get_fscaps(idmap, d, &caps);
+		if (ret)
+			return ret;
+		/*
+		 * rootid is already in the mount idmap, so pass nop_mnt_idmap
+		 * so that it won't be mapped.
+		 */
+		ret = vfs_caps_to_user_xattr(&nop_mnt_idmap, current_user_ns(),
+					     &caps, &data, ctx->size);
+		if (ret < 0)
+			return ret;
+		if (ctx->size && copy_to_user(ctx->value, &data, ret))
+			return -EFAULT;
+		return ret;
+	}
+
 	if (ctx->size) {
 		if (ctx->size > XATTR_SIZE_MAX)
 			ctx->size = XATTR_SIZE_MAX;
@@ -1139,6 +1171,9 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 	if (is_posix_acl_xattr(kname))
 		return vfs_remove_acl(idmap, d, kname);
 
+	if (is_fscaps_xattr(kname))
+		return vfs_remove_fscaps(idmap, d);
+
 	return vfs_removexattr(idmap, d, kname);
 }
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index eb06d7c6224b..5e7cbf07e3a7 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -229,6 +229,6 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   struct vfs_caps *cpu_caps);
 
 int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const void **ivalue, size_t size);
+		      struct vfs_caps *caps);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index 19affcfa3126..4254e5e46024 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -485,27 +485,21 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
 }
 
 /**
- * rootid_from_xattr - translate root uid of vfs caps
+ * rootid_from_vfs_caps - translate root uid of vfs caps
  *
- * @value:	vfs caps value which may be modified by this function
- * @size:	size of @ivalue
+ * @caps:	vfs caps value which may be modified by this function
  * @task_ns:	user namespace of the caller
+ *
+ * Return the rootid from a v3 fs cap, or the id of root in the task's user
+ * namespace for v1 and v2 fs caps.
  */
-static vfsuid_t rootid_from_xattr(const void *value, size_t size,
-				  struct user_namespace *task_ns)
+static vfsuid_t rootid_from_vfs_caps(const struct vfs_caps *caps,
+				     struct user_namespace *task_ns)
 {
-	const struct vfs_ns_cap_data *nscap = value;
-	uid_t rootid = 0;
-
-	if (size == XATTR_CAPS_SZ_3)
-		rootid = le32_to_cpu(nscap->rootid);
-
-	return VFSUIDT_INIT(make_kuid(task_ns, rootid));
-}
+	if ((caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3)
+		return caps->rootid;
 
-static bool validheader(size_t size, const struct vfs_cap_data *cap)
-{
-	return is_v2header(size, cap) || is_v3header(size, cap);
+	return VFSUIDT_INIT(make_kuid(task_ns, 0));
 }
 
 /**
@@ -513,11 +507,10 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  *
  * @idmap:	idmap of the mount the inode was found from
  * @dentry:	used to retrieve inode to check permissions on
- * @ivalue:	vfs caps value which may be modified by this function
- * @size:	size of @ivalue
+ * @caps:	vfs caps which may be modified by this function
  *
- * User requested a write of security.capability.  If needed, update the
- * xattr to change from v2 to v3, or to fixup the v3 rootid.
+ * User requested a write of security.capability.  Check permissions, and if
+ * needed, update the xattr to change from v2 to v3.
  *
  * If the inode has been found through an idmapped mount the idmap of
  * the vfsmount must be passed through @idmap. This function will then
@@ -525,59 +518,39 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  * permissions. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
  *
- * Return: On success, return the new size; on error, return < 0.
+ * Return: On success, return 0; on error, return < 0.
  */
 int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const void **ivalue, size_t size)
+		      struct vfs_caps *caps)
 {
-	struct vfs_ns_cap_data *nscap;
-	uid_t nsrootid;
-	const struct vfs_cap_data *cap = *ivalue;
-	__u32 magic, nsmagic;
 	struct inode *inode = d_backing_inode(dentry);
 	struct user_namespace *task_ns = current_user_ns(),
 		*fs_ns = inode->i_sb->s_user_ns;
-	kuid_t rootid;
 	vfsuid_t vfsrootid;
-	size_t newsize;
+	__u32 revision;
 
-	if (!*ivalue)
-		return -EINVAL;
-	if (!validheader(size, cap))
+	revision = sansflags(caps->magic_etc);
+	if (revision != VFS_CAP_REVISION_2 && revision != VFS_CAP_REVISION_3)
 		return -EINVAL;
 	if (!capable_wrt_inode_uidgid(idmap, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2 && (idmap == &nop_mnt_idmap))
+	if (revision == VFS_CAP_REVISION_2 && (idmap == &nop_mnt_idmap))
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
 			/* user is privileged, just write the v2 */
-			return size;
+			return 0;
 
-	vfsrootid = rootid_from_xattr(*ivalue, size, task_ns);
+	vfsrootid = rootid_from_vfs_caps(caps, task_ns);
 	if (!vfsuid_valid(vfsrootid))
 		return -EINVAL;
 
-	rootid = from_vfsuid(idmap, fs_ns, vfsrootid);
-	if (!uid_valid(rootid))
+	if (!vfsuid_has_fsmapping(idmap, fs_ns, vfsrootid))
 		return -EINVAL;
 
-	nsrootid = from_kuid(fs_ns, rootid);
-	if (nsrootid == -1)
-		return -EINVAL;
+	caps->rootid = vfsrootid;
+	caps->magic_etc = VFS_CAP_REVISION_3 |
+			  (caps->magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
 
-	newsize = sizeof(struct vfs_ns_cap_data);
-	nscap = kmalloc(newsize, GFP_ATOMIC);
-	if (!nscap)
-		return -ENOMEM;
-	nscap->rootid = cpu_to_le32(nsrootid);
-	nsmagic = VFS_CAP_REVISION_3;
-	magic = le32_to_cpu(cap->magic_etc);
-	if (magic & VFS_CAP_FLAGS_EFFECTIVE)
-		nsmagic |= VFS_CAP_FLAGS_EFFECTIVE;
-	nscap->magic_etc = cpu_to_le32(nsmagic);
-	memcpy(&nscap->data, &cap->data, sizeof(__le32) * 2 * VFS_CAP_U32);
-
-	*ivalue = nscap;
-	return newsize;
+	return 0;
 }
 
 /*

-- 
2.43.0


