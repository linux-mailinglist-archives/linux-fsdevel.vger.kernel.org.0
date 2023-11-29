Return-Path: <linux-fsdevel+bounces-4267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A57FE344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA507B20994
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B69247A45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQlYzNKm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D87761FB5;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4985C43397;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294657;
	bh=rQN1xLGeld4j4IW55z8ld7WdVy/2BRoKQW9LSljn2x0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQlYzNKmwllaE+g7Kiw69evrBe9kNjK/CFcpROSwzp+Xfc4dVrwcJXdbUE4rGhXeH
	 jjr2KAwWQBZuDhTQkr6VU3G3xzjHSquVC4gEpLt+3uoJ9G7g4S3Yo+PkRPPdEg5kJZ
	 FPbWRnnRwIEHGMJlnMNMpiSb6DzULhg4U5j5PNrGJIeEaOowYLgjK1R6+bWD0L/FjD
	 d5fEZuaiAoQhcK5PaSvLnqV3JK/tfCRM3/BW9QQOsXdAJaTBLJAJ18+k9N6RE8nIIY
	 c2cG3cPzEFv7ONmYwlQTEjLTQbMltr1Da/eENDa2ApaicEVp7H7lGEjmqKHmxrfvgy
	 yInCUeH8TZr3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B6C07CB1;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:24 -0600
Subject: [PATCH 06/16] capability: provide a helper for converting vfs_caps
 to xattr for userspace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-6-da5a26058a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4302; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=rQN1xLGeld4j4IW55z8ld7WdVy/2BRoKQW9LSljn2x0=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I2DU3K3tsTu4Nh8wDOr9uJU?=
 =?utf-8?q?4ZS6gYIJ3xT83+V_4MHJNZuJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyNgAKCRBTA5mu5fQxyYcPB/_oCnDaCsGtlI83YM/2/wsWTJyD+0FVcqwnJX?=
 =?utf-8?q?JNLK440u0oY9qYSciy1oqdWpmygdZisDX+oEpTIOJlA_52I9g7hW/k6g9hGzYDRJU?=
 =?utf-8?q?VL5z6MsXIuwFz2jRII3hPjri3Rg5X6dgmQW4+HS0g00Gvj66S0WCBY4C1_BYZK9uo?=
 =?utf-8?q?Y4vkbYHxH6wTyU9BwZtLIIqKedD9n9HB7CM9eWan/UXNjK4Dm8ULZsgbVLp/06oU+?=
 =?utf-8?q?UfBaYt_a2HVuGd1xWx1kbMJqiFhZ1Gu61AOG2ByjQ4YwRvaNwUKzQcYjYKSuCGWaa?=
 =?utf-8?q?nqvqsXumbDoNi6naMlwM?= DC44ra2po4L1NPdaT9HLGdiUjQS6Aj
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
 security/commoncap.c       | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index cdd7d2d8855e..c0bd9447685b 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -218,6 +218,10 @@ int vfs_caps_to_xattr(struct mnt_idmap *idmap,
 		      struct user_namespace *dest_userns,
 		      const struct vfs_caps *vfs_caps,
 		      void *data, int size);
+int vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
+			   struct user_namespace *dest_userns,
+			   const struct vfs_caps *vfs_caps,
+			   void *data, int size);
 
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
diff --git a/security/commoncap.c b/security/commoncap.c
index ef37966f3522..c645330f83a0 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -789,6 +789,74 @@ int vfs_caps_to_xattr(struct mnt_idmap *idmap,
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
+ * Converts a kernel-interrnal capability into the raw security.capability
+ * xattr format. Includes permission checking and v2->v3 conversion as
+ * appropriate.
+ *
+ * If the xattr is being read or written through an idmapped mount the
+ * idmap of the vfsmount must be passed through @idmap. This function
+ * will then take care to map the rootid according to @idmap.
+ *
+ * Return: On success, return 0; on error, return < 0.
+ */
+int vfs_caps_to_user_xattr(struct mnt_idmap *idmap,
+			   struct user_namespace *dest_userns,
+			   const struct vfs_caps *vfs_caps,
+			   void *data, int size)
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


