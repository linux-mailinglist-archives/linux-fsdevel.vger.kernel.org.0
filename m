Return-Path: <linux-fsdevel+bounces-4274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDA17FE34C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C9A1C20ADA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CE147A55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOaZfNhq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F261FC9;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 215A3C433C7;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294658;
	bh=2HiADlLvgGW720oIUK6woDmD2V9EI+/r0VTeM20LPPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EOaZfNhqvhlO8BZ4PLdI0JgXRNglutJeDpDR46JAPYU7frD9BNZA0I4AOCKObzayW
	 GCwsJvfneErUDdYut0s8slvX2MRREyyu7kla6KAGaGpbjp/4vCi25bbnh7t4SAyiLr
	 M+hlrB6h+IS6N+vB1UyUQ/LjxMjwrXk3DMqgp4dx7JXYqrzMoZ6jcaEGVRLJ11ElPv
	 LBPPPqyACX6l0ay8zeu2VL+3fGGWMtaW2tZohzQPmaJKlo2VxdFh/eKRysVqanoiPN
	 sfGTuWmq8HeFfnwr1v3QuplABP1yvb7Gdx/9GYFZY0XV3+Ge7Aa1+88eYIyxvi6xzF
	 qe14FbjluFU4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13130C07CB1;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:31 -0600
Subject: [PATCH 13/16] fs: use vfs interfaces for capabilities xattrs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-13-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8524; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=2HiADlLvgGW720oIUK6woDmD2V9EI+/r0VTeM20LPPs=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I84eoLP86nEuxsd0EOX/Og5?=
 =?utf-8?q?0rHT0ZAzT63Z49r_9RiM2oOJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyPAAKCRBTA5mu5fQxyZhyB/_9gYYIbkYFa10api1PrNd0MoEaeKZ/aJybzo?=
 =?utf-8?q?VQjHKThBmpvtRrAxol4IrKQr4Gruq6rBfw62ZdbflNs_AgQHicVr/QIC6zxyar2Vo?=
 =?utf-8?q?a6KkLhLKnAajluGF6ghiJG+gkoOd+qRPX6HmmOfUH8ge7hAK+ils71Wdb_emuoGBO?=
 =?utf-8?q?u7J4L1641adZs1rEEfEBzVhPAT/2lPD2rvpco0QupuBPFU9ty3XyQdtRF6Gb3vuxF?=
 =?utf-8?q?UnGWzm_rkoNeZCp6VhQkcEpsCQ6nF8ypGwiTXGUsf6+aJy1+LK/gsgNSq519SdLiQ?=
 =?utf-8?q?0i5VlzDTtQOb4qIHrm6/?= QazLsgiYauqobTgzmjki+Qj658voFS
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
index f60ef2a79dfa..372644b15457 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -540,13 +540,6 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
-	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
-		error = cap_convert_nscap(idmap, dentry, &value, size);
-		if (error < 0)
-			return error;
-		size = error;
-	}
-
 retry_deleg:
 	inode_lock(inode);
 	error = __vfs_setxattr_locked(idmap, dentry, name, value, size,
@@ -857,6 +850,24 @@ int do_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		return do_set_acl(idmap, dentry, ctx->kname->name,
 				  ctx->kvalue, ctx->size);
 
+	if (strcmp(ctx->kname->name, XATTR_NAME_CAPS) == 0) {
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
@@ -955,6 +966,27 @@ do_getxattr(struct mnt_idmap *idmap, struct dentry *d,
 	ssize_t error;
 	char *kname = ctx->kname->name;
 
+	if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
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
@@ -1145,6 +1177,9 @@ removexattr(struct mnt_idmap *idmap, struct dentry *d,
 	if (is_posix_acl_xattr(kname))
 		return vfs_remove_acl(idmap, d, kname);
 
+	if (strcmp(kname, XATTR_NAME_CAPS) == 0)
+		return vfs_remove_fscaps(idmap, d);
+
 	return vfs_removexattr(idmap, d, kname);
 }
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index c0bd9447685b..563f084e9453 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -229,6 +229,6 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   struct vfs_caps *cpu_caps);
 
 int cap_convert_nscap(struct mnt_idmap *idmap, struct dentry *dentry,
-		      const void **ivalue, size_t size);
+		      struct vfs_caps *caps);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index c645330f83a0..bd95b806af2f 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -484,27 +484,21 @@ int cap_inode_getsecurity(struct mnt_idmap *idmap,
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
@@ -512,11 +506,10 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
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
@@ -524,59 +517,39 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
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


