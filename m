Return-Path: <linux-fsdevel+bounces-12368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7485EA97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D12B27465
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCFE133983;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdMpuRoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC512839A;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=HfzGVwEVeGYAbE/kIbKUkJLg1awgCry22FfH6+EIGW4I0EmAk0DAsbxoBRYnRqaWWsoVNfQ+JXzc5LJTTZh5aAbwo4S0nipMgkTLIgaMUXutxeQVrHZ8kZl6MD1oeo3l8s0MayJyTbNnPoSYNAo/BTe6m2gpa09sergJWEvyomQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=KV67NQ3jY16wtebp+H7T3tkKlXDYN1N/ejbqZKr3l94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kTKbvoPZfgk87YyJIoirED3/JXQsaoAaMpWKDWEp0PIz8TyWybe4sbQYL8oba08xnRUJJR0vAALSi2mVsbRBPxdhf+KxBzSHC/jITUEDLBX/9Lb0NlH4RnBFIRymObwpT972xNlG3JFDOejGGzj/TtyFHoRiHQ8arTi05MVJgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdMpuRoC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 062F9C4166D;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=KV67NQ3jY16wtebp+H7T3tkKlXDYN1N/ejbqZKr3l94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tdMpuRoC3KRrCsZbyIG1qt+q1GFq3KoiPjqrICz36gS5wz1CP2h0hpSqfJ5U9BbJs
	 nUb5YDHmg5qSfeA9p6Jh8HqXx1uofZAPRUSUwdKOmXAmtk+a7KEUfSK8j1atP2hONS
	 7QRML7jrkapTT5C12iX+ZUhUg0nxsAL9f7LU3Xl9hQFO1KGnZQSxaWXyXGj8WW6E52
	 aoRTEBVS9qtuFFIqgWrGHzVuw58kwyf4vszeUlYfX/1xgpMlircLrDeM7hTBwY/1Ld
	 IfLaHPTrxmJMGQIB7uRJ4nnFUrBoWZqhE/o8xBJmMdnbfuSw0pQb2zf4M1aW+hYNrv
	 HxW1NuFvhYEEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B54C48BEB;
	Wed, 21 Feb 2024 21:25:05 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:37 -0600
Subject: [PATCH v2 06/25] capability: provide helpers for converting
 between xattrs and vfs_caps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-6-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11618; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=KV67NQ3jY16wtebp+H7T3tkKlXDYN1N/ejbqZKr3l94=; 
 =?utf-8?q?b=3DowGbwMvMwMUYzDxz3dMvhicZT6slMaRey5L9sT2C27hXw2e3XWJbx5+YymITz?=
 =?utf-8?q?i362vFF8xZty9M/_byHdyWjMwsDIxSArpsgyYd791RrczwVtdsiehxnEygQyhYGLU?=
 =?utf-8?q?wAm4rad/X+g8zyJNnf7WoOgs5U3n6_18k1ZeYR/J/0d5s+vVDpvbJqbP/6ZdE97vs?=
 =?utf-8?q?ZWj9udDda0ag+Xn1b3N1TIinUNiM9gKKywLpgn2XlN/_6JEup8NZvseR55rte2ezD?=
 =?utf-8?q?5Kp2mXf5J7P3cTI8H9mhMC3OcHh+c3zrxr9SJbO2XDZUTZ+4YZg8dk3vC_74ngsrn?=
 =?utf-8?q?38p5k64YGz434v3WthuH1WK2xqt+ExVlIlnye245wt8jPKjnu3l5C3QkOauPCcp3D?=
 =?utf-8?q?AhSKR1_57HW8ymHbzqLdG5vvKnD5Xl9441bceXxXn6hgj690/6a3m1+7z1li/sXG7?=
 =?utf-8?q?4/LmZb7milT+V5mC84LX?= ZWjY5Iinf5y9rD21/cv7O8XVAWAA==
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
 security/commoncap.c       | 228 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 187 insertions(+), 51 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index eb46d346bbbc..a0893ac4664b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -209,6 +209,16 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+/* helpers to convert between xattr and in-kernel representations */
+int vfs_caps_from_xattr(struct mnt_idmap *idmap,
+			struct user_namespace *src_userns,
+			struct vfs_caps *vfs_caps,
+			const void *data, size_t size);
+ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
+			  struct user_namespace *dest_userns,
+			  const struct vfs_caps *vfs_caps,
+			  void *data, size_t size);
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
 			   const struct dentry *dentry,
diff --git a/security/commoncap.c b/security/commoncap.c
index a0b5c9740759..7531c9634997 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -619,54 +619,41 @@ static inline int bprm_caps_from_vfs_caps(struct vfs_caps *caps,
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
+			const void *data, size_t size)
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
@@ -679,39 +666,178 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
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
+static ssize_t __vfs_caps_to_xattr(struct mnt_idmap *idmap,
+				   struct user_namespace *dest_userns,
+				   const struct vfs_caps *vfs_caps,
+				   void *data, size_t size)
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
+ * Converts a kernel-internal capability into the raw security.capability
+ * xattr format.
+ *
+ * If the xattr is being read or written through an idmapped mount the
+ * idmap of the vfsmount must be passed through @idmap. This function
+ * will then take care to map the rootid according to @idmap.
+ *
+ * Return: On success, return the size of the xattr data. On error,
+ * return < 0.
+ */
+ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
+			  struct user_namespace *dest_userns,
+			  const struct vfs_caps *vfs_caps,
+			  void *data, size_t size)
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


