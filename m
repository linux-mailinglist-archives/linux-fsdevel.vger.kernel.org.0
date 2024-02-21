Return-Path: <linux-fsdevel+bounces-12369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4A85EAA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A791C22944
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBCB1339A6;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZlkCZR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74082128819;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=XmFZyYXmXVX50b8ufSxdjg3F1sN8kGvjB3m9VTxOLmBydO851FkizF7fp7Wp7xTu94KBDaTVFsRj5rjy1PI+PIHNuPCA05uWhhF8rBMeItvhD+Hc1vRbzqtAyZxUahaqDOcyAjnd6pnWDpH8ozBpr+E2hP6APVtw5/nR0FheoTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=OhFFK2aqwLPE1WOUvtrX8svKCrxfnUe+iJ8IlWQVyNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tYB1YnHxIwzGatyRWOScTdI0L3OG9DXzJCi+ZQRK9OLaN+ftkwTAeoGXlwL5g7ucUtuMLqmcbJkJg/C0fjbkD/WC3KgAfiQyaz0TH2/LiyHMhRRbZaPDdefoHN3jl8cqfULtEEY7ZG/jwFOYrg/2CRwO0dyutrBdcRH91H6xiTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZlkCZR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39E73C41679;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=OhFFK2aqwLPE1WOUvtrX8svKCrxfnUe+iJ8IlWQVyNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RZlkCZR8EhACEKs533voXeKxdPegitqhuX3z+DURsKNsWzw1nUSRXg2qO1/O6bxVa
	 hD7SyJbDNexmwxY61JfdIwdNgEW6W7AFebONEMq3JprI4reQniICejGasqx21vLFe8
	 dz/LgdGWyvQxSaMlRaqObz2+vDyr5myLud3DDlJs38QPVyyPnLD+RDini2/Yrpswhz
	 W0l9eQB0jsOGpSmO6FLVQxpfGYwxztqIwdmwpEfvMJjJFLLERzKZHmKXYZGQ3vVtco
	 9mCq8U5hUgfCLcx/54VhcMsDn70tRVjAUfrxbSYtg6L1PV3X0t3uVI7zjwzETq+Ojj
	 3eh/MiuqF1P+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FC0C54791;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:38 -0600
Subject: [PATCH v2 07/25] capability: provide a helper for converting
 vfs_caps to xattr for userspace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-7-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4882; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=OhFFK2aqwLPE1WOUvtrX8svKCrxfnUe+iJ8IlWQVyNc=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moe+AhIBa2iFKus4HKFQ2il7?=
 =?utf-8?q?yas4jPP3dyS1+Ne_5Mxo69eJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqHgAKCRBTA5mu5fQxybNwB/_0Q84CMY/0WnJZlUjjtKZuKkVW2vuFaN8zeS?=
 =?utf-8?q?2QYvI/A8cu38Pd7o4lvanR9S9hXj4vl4S6oG1Mty8l9_rvg72P/DOk5fedO0P0xte?=
 =?utf-8?q?tekIGcH2ISDFUwuzWZV6bEEezmJxftYAfqlz43NxT/FQmhxVP0HxL/T7C_6axOrX9?=
 =?utf-8?q?+LATljuFCYBTlmEJxQYbvp8gb/zhITu0gcFUULQFVRJRLB6qe+6k4BQbXc9MO5E5Y?=
 =?utf-8?q?Q8d0NA_k+rEqS6CmssspC20ypVSjz2/p2jiq8s2SQRQOicbBpeL5eObtE35O2Aa2h?=
 =?utf-8?q?gGTIjwO9eFWGTjh3O3Ca?= xgnvBlVxCegczqxtnWEXgMFeBGeNVF
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

cap_inode_getsecurity() implements a handful of policies for capability
xattrs read by userspace:

 - It returns EINVAL if the on-disk capability is in v1 format.

 - It masks off all bits in magic_etc except for the version and
   VFS_CAP_FLAGS_EFFECTIVE.

 - v3 capabilities are converted to v2 format if the rootid returned to
   userspace would be 0 or if the rootid corresponds to root in an
   ancestor user namespace.

 - It returns EOVERFLOW for a v3 capability whose rootid does not map to
   a valid id in current_user_ns() or to root in an ancestor namespace.

These policies must be maintained when converting vfs_caps to an xattr
for userspace. Provide a vfs_caps_to_user_xattr() helper which will
enforce these policies.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/capability.h |  4 +++
 security/commoncap.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index a0893ac4664b..eb06d7c6224b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -218,6 +218,10 @@ ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
 			  struct user_namespace *dest_userns,
 			  const struct vfs_caps *vfs_caps,
 			  void *data, size_t size);
+ssize_t vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
+			       struct user_namespace *dest_userns,
+			       const struct vfs_caps *vfs_caps,
+			       void *data, size_t size);
 
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
diff --git a/security/commoncap.c b/security/commoncap.c
index 7531c9634997..289530e58c37 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -791,6 +791,84 @@ ssize_t vfs_caps_to_xattr(struct mnt_idmap *idmap,
 	return ret;
 }
 
+/**
+ * vfs_caps_to_user_xattr - convert vfs_caps to caps xattr for userspace
+ *
+ * @idmap:       idmap of the mount the inode was found from
+ * @dest_userns: user namespace for ids in xattr data
+ * @vfs_caps:    source vfs_caps data
+ * @data:        destination buffer for rax xattr caps data
+ * @size:        size of the @data buffer
+ *
+ * Converts a kernel-internal capability into the raw security.capability
+ * xattr format. Implements the following policies required for fscaps
+ * returned to userspace:
+ *
+ *  - Returns -EINVAL if the on-disk capability is in v1 format.
+ *  - Masks off all bits in magic_etc except for the version and
+ *    VFS_CAP_FLAGS_EFFECTIVE.
+ *  - Converts v3 capabilities to v2 format if the rootid returned to
+ *    userspace would be 0 or if the rootid corresponds to root in an
+ *    ancestor user namespace.
+ *  - Returns EOVERFLOW for a v3 capability whose rootid does not map to a
+ *    valid id in current_user_ns() or to root in an ancestor namespace.
+ *
+ * If the xattr is being read or written through an idmapped mount the
+ * idmap of the vfsmount must be passed through @idmap. This function
+ * will then take care to map the rootid according to @idmap.
+ *
+ * Return: On success, return the size of the xattr data. On error,
+ * return < 0.
+ */
+ssize_t vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
+			       struct user_namespace *dest_userns,
+			       const struct vfs_caps *vfs_caps,
+			       void *data, size_t size)
+{
+	struct vfs_ns_cap_data *ns_caps = data;
+	bool is_v3;
+	u32 magic;
+
+	/* Preserve previous behavior of returning EINVAL for v1 caps */
+	if ((vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_1)
+		return -EINVAL;
+
+	size = __vfs_caps_to_xattr(idmap, dest_userns, vfs_caps, data, size);
+	if (size < 0)
+		return size;
+
+	magic = vfs_caps->magic_etc &
+		(VFS_CAP_REVISION_MASK | VFS_CAP_FLAGS_EFFECTIVE);
+	ns_caps->magic_etc = cpu_to_le32(magic);
+
+	/*
+	 * If this is a v3 capability with a valid, non-zero rootid, return
+	 * the v3 capability to userspace. A v3 capability with a rootid of
+	 * 0 will be converted to a v2 capability below for compatibility
+	 * with old userspace.
+	 */
+	is_v3 = (vfs_caps->magic_etc & VFS_CAP_REVISION_MASK) == VFS_CAP_REVISION_3;
+	if (is_v3) {
+		uid_t rootid = le32_to_cpu(ns_caps->rootid);
+		if (rootid != (uid_t)-1 && rootid != (uid_t)0)
+			return size;
+	}
+
+	if (!rootid_owns_currentns(vfs_caps->rootid))
+		return -EOVERFLOW;
+
+	/* This comes from a parent namespace. Return as a v2 capability. */
+	if (is_v3) {
+		magic = VFS_CAP_REVISION_2 |
+			(vfs_caps->magic_etc & VFS_CAP_FLAGS_EFFECTIVE);
+		ns_caps->magic_etc = cpu_to_le32(magic);
+		ns_caps->rootid = cpu_to_le32(0);
+		size = XATTR_CAPS_SZ_2;
+	}
+
+	return size;
+}
+
 /**
  * get_vfs_caps_from_disk - retrieve vfs caps from disk
  *

-- 
2.43.0


