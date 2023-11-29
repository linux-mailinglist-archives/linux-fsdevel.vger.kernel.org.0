Return-Path: <linux-fsdevel+bounces-4264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58B7FE36D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF601C20B01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C847A51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmIQSuTT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AB61690;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE134C433D9;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294657;
	bh=rEZM0PVp6B4xr9cFfrir9S9tivQgwae/87tx7pQYtPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NmIQSuTT5QABW/JM9mk4Y6P9IqsRbh1AzC7TDHw2ap1Ou9R3cR9btT4RkPSjIOuuy
	 EJMOJeha2WSab01lzikLwTKIVVIbrOxsSyVfi2ur68DhB3sSRyS/HAQmSlyzwiV65X
	 p7AN5s2GE9dGLp2Nm0lCgo3MIqtQAI9lF2TsyLmf8mQ4ryMla/LevCTcK/yCdzB/R4
	 52n1gBtMURFqRZu2S2pJGYlPDQEiZfVdKz6jnw4pQT8Te7g9OMkVGHyqgol7yCPamX
	 cXNUriKk3mYwKcewEN+L6Yu7ZHluNhOqkIPCrj+sIM266M72LtGk/BVXNQBL7qjJ7X
	 N453KCPlIjztg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B3C10DC1;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:23 -0600
Subject: [PATCH 05/16] capability: provide helpers for converting between
 xattrs and vfs_caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-5-da5a26058a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11589; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=rEZM0PVp6B4xr9cFfrir9S9tivQgwae/87tx7pQYtPw=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I1iss3rNLVl2UZBM57RVYLa?=
 =?utf-8?q?Y48HKiyLX7CxZzC_xrTaalGJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyNQAKCRBTA5mu5fQxyeN1B/_0V9hhGaEvf4zWw2QJxFgY9ooSXwAyqgF8q7?=
 =?utf-8?q?u/0pP1qeCQToOH5MCP+9GL/9or9GClN+MDte6u08N6b_ft/myKObUapwocQYB/j5W?=
 =?utf-8?q?LYhffMKM3uHmVSVg5NsjaMQSc6PUnOTdWTYGzzfdce3HspbTuOR7EncQI_xeaRiKU?=
 =?utf-8?q?m83jdh/6WfaZVRvhylVfFK1AhPjJ/ILEq7t3pbhsa/OJIK+SghFrw7dTieLooJCYw?=
 =?utf-8?q?REG1Fn_/veLK5ITbx2TnRQG2K1uzym3p++6IqBPatvdOxg1wdTMOANEF4aQ16rBRc?=
 =?utf-8?q?IGyr9j07GzOZK/aULGng?= 58hy3tcQeMYdFmBqVt8swRhcncbobk
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

To pass around vfs_caps instead of raw xattr data we will need to
convert between the two representations near userspace and disk
boundaries. We already convert xattrs from disks to vfs_caps, so move
that code into a helper, and change get_vfs_caps_from_disk() to use the
helper.

When converting vfs_caps to xattrs we have different considerations
depending on the destination of the xattr data. For xattrs which will be
written to disk we need to reject the xattr if the rootid does not map
into the filesystem's user namespace, whereas xattrs read by userspace
may need to undergo a conversion from v3 to v2 format when the rootid
does not map. So this helper is split into an internal and an external
interface. The internal interface does not return an error if the rootid
has no mapping in the target user namespace and will be used for
conversions targeting userspace. The external interface returns
EOVERFLOW if the rootid has no mapping and will be used for all other
conversions.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/capability.h |  10 ++
 security/commoncap.c       | 227 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 186 insertions(+), 51 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index eb46d346bbbc..cdd7d2d8855e 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -209,6 +209,16 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+/* helpers to convert between xattr and in-kernel representations */
+int vfs_caps_from_xattr(struct mnt_idmap *idmap,
+			struct user_namespace *src_userns,
+			struct vfs_caps *vfs_caps,
+			const void *data, int size);
+int vfs_caps_to_xattr(struct mnt_idmap *idmap,
+		      struct user_namespace *dest_userns,
+		      const struct vfs_caps *vfs_caps,
+		      void *data, int size);
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
diff --git a/security/commoncap.c b/security/commoncap.c
index 3d045d377e5e..ef37966f3522 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -618,54 +618,41 @@ static inline int bprm_caps_from_vfs_caps(struct vfs_caps *caps,
 }
 
 /**
- * get_vfs_caps_from_disk - retrieve vfs caps from disk
+ * vfs_caps_from_xattr - convert raw caps xattr data to vfs_caps
  *
- * @idmap:	idmap of the mount the inode was found from
- * @dentry:	dentry from which @inode is retrieved
- * @cpu_caps:	vfs capabilities
+ * @idmap:      idmap of the mount the inode was found from
+ * @src_userns: user namespace for ids in xattr data
+ * @vfs_caps:   destination buffer for vfs_caps data
+ * @data:       rax xattr caps data
+ * @size:       size of xattr data
  *
- * Extract the on-exec-apply capability sets for an executable file.
+ * Converts a raw security.capability xattr into the kernel-internal
+ * capabilities format.
  *
- * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then
- * take care to map the inode according to @idmap before checking
- * permissions. On non-idmapped mounts or if permission checking is to be
- * performed on the raw inode simply pass @nop_mnt_idmap.
+ * If the xattr is being read or written through an idmapped mount the
+ * idmap of the vfsmount must be passed through @idmap. This function
+ * will then take care to map the rootid according to @idmap.
+ *
+ * Return: On success, return 0; on error, return < 0.
  */
-int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
-			   const struct dentry *dentry,
-			   struct vfs_caps *cpu_caps)
+int vfs_caps_from_xattr(struct mnt_idmap *idmap,
+			struct user_namespace *src_userns,
+			struct vfs_caps *vfs_caps,
+			const void *data, int size)
 {
-	struct inode *inode = d_backing_inode(dentry);
 	__u32 magic_etc;
-	int size;
-	struct vfs_ns_cap_data data, *nscaps = &data;
-	struct vfs_cap_data *caps = (struct vfs_cap_data *) &data;
+	const struct vfs_ns_cap_data *ns_caps = data;
+	struct vfs_cap_data *caps = (struct vfs_cap_data *)ns_caps;
 	kuid_t rootkuid;
-	vfsuid_t rootvfsuid;
-	struct user_namespace *fs_ns;
-
-	memset(cpu_caps, 0, sizeof(struct vfs_caps));
-
-	if (!inode)
-		return -ENODATA;
 
-	fs_ns = inode->i_sb->s_user_ns;
-	size = __vfs_getxattr((struct dentry *)dentry, inode,
-			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
-	if (size == -ENODATA || size == -EOPNOTSUPP)
-		/* no data, that's ok */
-		return -ENODATA;
-
-	if (size < 0)
-		return size;
+	memset(vfs_caps, 0, sizeof(*vfs_caps));
 
 	if (size < sizeof(magic_etc))
 		return -EINVAL;
 
-	cpu_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
+	vfs_caps->magic_etc = magic_etc = le32_to_cpu(caps->magic_etc);
 
-	rootkuid = make_kuid(fs_ns, 0);
+	rootkuid = make_kuid(src_userns, 0);
 	switch (magic_etc & VFS_CAP_REVISION_MASK) {
 	case VFS_CAP_REVISION_1:
 		if (size != XATTR_CAPS_SZ_1)
@@ -678,39 +665,177 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 	case VFS_CAP_REVISION_3:
 		if (size != XATTR_CAPS_SZ_3)
 			return -EINVAL;
-		rootkuid = make_kuid(fs_ns, le32_to_cpu(nscaps->rootid));
+		rootkuid = make_kuid(src_userns, le32_to_cpu(ns_caps->rootid));
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	rootvfsuid = make_vfsuid(idmap, fs_ns, rootkuid);
-	if (!vfsuid_valid(rootvfsuid))
-		return -ENODATA;
+	vfs_caps->rootid = make_vfsuid(idmap, src_userns, rootkuid);
+	if (!vfsuid_valid(vfs_caps->rootid))
+		return -EOVERFLOW;
 
-	/* Limit the caps to the mounter of the filesystem
-	 * or the more limited uid specified in the xattr.
+	vfs_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
+	vfs_caps->inheritable.val = le32_to_cpu(caps->data[0].inheritable);
+
+	/*
+	 * Rev1 had just a single 32-bit word, later expanded
+	 * to a second one for the high bits
 	 */
-	if (!rootid_owns_currentns(rootvfsuid))
-		return -ENODATA;
+	if ((magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
+		vfs_caps->permitted.val += (u64)le32_to_cpu(caps->data[1].permitted) << 32;
+		vfs_caps->inheritable.val += (u64)le32_to_cpu(caps->data[1].inheritable) << 32;
+	}
+
+	vfs_caps->permitted.val &= CAP_VALID_MASK;
+	vfs_caps->inheritable.val &= CAP_VALID_MASK;
+
+	return 0;
+}
+
+/*
+ * Inner implementation of vfs_caps_to_xattr() which does not return an
+ * error if the rootid does not map into @dest_userns.
+ */
+static int __vfs_caps_to_xattr(struct mnt_idmap *idmap,
+			       struct user_namespace *dest_userns,
+			       const struct vfs_caps *vfs_caps,
+			       void *data, int size)
+{
+	struct vfs_ns_cap_data *ns_caps = data;
+	struct vfs_cap_data *caps = (struct vfs_cap_data *)ns_caps;
+	kuid_t rootkuid;
+	uid_t rootid;
+
+	memset(ns_caps, 0, size);
+
+	rootid = 0;
+	switch (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) {
+	case VFS_CAP_REVISION_1:
+		if (size < XATTR_CAPS_SZ_1)
+			return -EINVAL;
+		size = XATTR_CAPS_SZ_1;
+		break;
+	case VFS_CAP_REVISION_2:
+		if (size < XATTR_CAPS_SZ_2)
+			return -EINVAL;
+		size = XATTR_CAPS_SZ_2;
+		break;
+	case VFS_CAP_REVISION_3:
+		if (size < XATTR_CAPS_SZ_3)
+			return -EINVAL;
+		size = XATTR_CAPS_SZ_3;
+		rootkuid = from_vfsuid(idmap, dest_userns, vfs_caps->rootid);
+		rootid = from_kuid(dest_userns, rootkuid);
+		ns_caps->rootid = cpu_to_le32(rootid);
+		break;
 
-	cpu_caps->permitted.val = le32_to_cpu(caps->data[0].permitted);
-	cpu_caps->inheritable.val = le32_to_cpu(caps->data[0].inheritable);
+	default:
+		return -EINVAL;
+	}
+
+	caps->magic_etc = cpu_to_le32(vfs_caps->magic_etc);
+
+	caps->data[0].permitted = cpu_to_le32(lower_32_bits(vfs_caps->permitted.val));
+	caps->data[0].inheritable = cpu_to_le32(lower_32_bits(vfs_caps->inheritable.val));
 
 	/*
 	 * Rev1 had just a single 32-bit word, later expanded
 	 * to a second one for the high bits
 	 */
-	if ((magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
-		cpu_caps->permitted.val += (u64)le32_to_cpu(caps->data[1].permitted) << 32;
-		cpu_caps->inheritable.val += (u64)le32_to_cpu(caps->data[1].inheritable) << 32;
+	if ((vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) != VFS_CAP_REVISION_1) {
+		caps->data[1].permitted =
+			cpu_to_le32(upper_32_bits(vfs_caps->permitted.val));
+		caps->data[1].inheritable =
+			cpu_to_le32(upper_32_bits(vfs_caps->inheritable.val));
 	}
 
-	cpu_caps->permitted.val &= CAP_VALID_MASK;
-	cpu_caps->inheritable.val &= CAP_VALID_MASK;
+	return size;
+}
+
+
+/**
+ * vfs_caps_to_xattr - convert vfs_caps to raw caps xattr data
+ *
+ * @idmap:       idmap of the mount the inode was found from
+ * @dest_userns: user namespace for ids in xattr data
+ * @vfs_caps:    source vfs_caps data
+ * @data:        destination buffer for rax xattr caps data
+ * @size:        size of the @data buffer
+ *
+ * Converts a kernel-interrnal capability into the raw security.capability
+ * xattr format.
+ *
+ * If the xattr is being read or written through an idmapped mount the
+ * idmap of the vfsmount must be passed through @idmap. This function
+ * will then take care to map the rootid according to @idmap.
+ *
+ * Return: On success, return 0; on error, return < 0.
+ */
+int vfs_caps_to_xattr(struct mnt_idmap *idmap,
+		      struct user_namespace *dest_userns,
+		      const struct vfs_caps *vfs_caps,
+		      void *data, int size)
+{
+	struct vfs_ns_cap_data *caps = data;
+	int ret;
+
+	ret = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
+	if (ret > 0 &&
+	    (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3 &&
+	     le32_to_cpu(caps->rootid) == (uid_t)-1)
+		return -EOVERFLOW;
+	return ret;
+}
+
+/**
+ * get_vfs_caps_from_disk - retrieve vfs caps from disk
+ *
+ * @idmap:	idmap of the mount the inode was found from
+ * @dentry:	dentry from which @inode is retrieved
+ * @cpu_caps:	vfs capabilities
+ *
+ * Extract the on-exec-apply capability sets for an executable file.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then
+ * take care to map the inode according to @idmap before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply pass @nop_mnt_idmap.
+ */
+int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
+			   const struct dentry *dentry,
+			   struct vfs_caps *cpu_caps)
+{
+	struct inode *inode = d_backing_inode(dentry);
+	int size, ret;
+	struct vfs_ns_cap_data data, *nscaps = &data;
+
+	if (!inode)
+		return -ENODATA;
 
-	cpu_caps->rootid = rootvfsuid;
+	size = __vfs_getxattr((struct dentry *)dentry, inode,
+			      XATTR_NAME_CAPS, &data, XATTR_CAPS_SZ);
+	if (size == -ENODATA || size == -EOPNOTSUPP)
+		/* no data, that's ok */
+		return -ENODATA;
+
+	if (size < 0)
+		return size;
+
+	ret = vfs_caps_from_xattr(idmap, inode->i_sb->s_user_ns,
+				  cpu_caps, nscaps, size);
+	if (ret == -EOVERFLOW)
+		return -ENODATA;
+	if (ret)
+		return ret;
+
+	/* Limit the caps to the mounter of the filesystem
+	 * or the more limited uid specified in the xattr.
+	 */
+	if (!rootid_owns_currentns(cpu_caps->rootid))
+		return -ENODATA;
 
 	return 0;
 }

-- 
2.43.0


