Return-Path: <linux-fsdevel+bounces-4268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F8B7FE341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8667281814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7194147A59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCKANpzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A761FB4;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4CFEC433A9;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294657;
	bh=+rNu+aEJtyNDKr3Mz+sg00VpaKJj7LN1+EUYKCn22bc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCKANpzAjVN+iZhP0a6dpqp1xM6AJIp2C/3VFbXbPYlklUhPNfzkn7v5VbXxJQC6K
	 tG9adpxF0Ec+kk2XBpQKlvQ8nOZM8jViq/EUplejF8Ou74+FGM8NfvmloHfXpcJWyK
	 PEUQuZHqvIGBnfWoR5GC9oEFQT/S8Db+3lCwLHiWRA7O75lHulk+06FP0AAG6ps/W4
	 LFnbaTUFtdTWirRytgxK7jlaOPlsU4ZjJScsstI8DQzYfzilT/jO/Nbir0wlEHQiOg
	 gWdY5zqroFCJ85q5h1BLBB+tC9Htz3qr+N/JSJBmoFz0UBeXD9nKePkkkoNIOEXgaW
	 7Fn8kko3KkrXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AABC10DC3;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:26 -0600
Subject: [PATCH 08/16] fs: add vfs_get_fscaps()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-8-da5a26058a5b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3647; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=+rNu+aEJtyNDKr3Mz+sg00VpaKJj7LN1+EUYKCn22bc=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I4/avu6/WjMpQysJRD4e086?=
 =?utf-8?q?dAG/Cwb8KohO3Og_fd3i1iGJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyOAAKCRBTA5mu5fQxyUF1B/_9oQr2DVGypJwRSipJa6KV9qSjXlv20xo0hN?=
 =?utf-8?q?hsSFvuH9Ach0ImZwoiRJyWGJTQ1qBcQPq7seTQQ+7B+_S2dK266E1ICJEoRmy+cIe?=
 =?utf-8?q?8P+BJme5M6yUAyFiSPqel1NPeKIbMFIGG6LST8fWtudf6UinqfhFZKyvd_qE1ALWh?=
 =?utf-8?q?6jQ12XE2xqlEPn0/tDpmo8eT7EU0F0z5LdbBiLGrQIQwMQpHnldwMwrCZkrjFnViq?=
 =?utf-8?q?2fZbAj_wzu2f79hmFumu4lFZ7Y4Gtb7CrOmipp/+6R4MsVmbtiaiiDpWIn3MrIlDO?=
 =?utf-8?q?0ivXbVWESxV66lWPdbWZ?= CcbdRRuAOliiqvt4XyKPp1qO4gEpFI
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Provide a type-safe interface for retrieving filesystem capabilities and
a generic implementation suitable for most filesystems. Also add an
internal interface, __vfs_get_fscaps(), which skips security checks for
later use from the capability code.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c         | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 ++++
 2 files changed, 70 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 09d927603433..3abaf9bef0a5 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -181,6 +181,72 @@ xattr_supports_user_prefix(struct inode *inode)
 }
 EXPORT_SYMBOL(xattr_supports_user_prefix);
 
+static int generic_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			      struct vfs_caps *caps)
+{
+	struct inode *inode = d_inode(dentry);
+	struct vfs_ns_cap_data *nscaps = NULL;
+	int ret;
+
+	ret = (int)vfs_getxattr_alloc(idmap, dentry, XATTR_NAME_CAPS,
+				      (char **)&nscaps, 0, GFP_NOFS);
+
+	if (ret >= 0)
+		ret = vfs_caps_from_xattr(idmap, i_user_ns(inode), caps, nscaps, ret);
+
+	kfree(nscaps);
+	return ret;
+}
+
+/**
+ * __vfs_get_fscaps - get filesystem capabilities without security checks
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to get filesystem capabilities
+ * @caps: storage in which to return the filesystem capabilities
+ *
+ * This function gets the filesystem capabilities for the dentry and returns
+ * them in @caps. It does not perform security checks.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int __vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+		     struct vfs_caps *caps)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (inode->i_op->get_fscaps)
+		return inode->i_op->get_fscaps(idmap, dentry, caps);
+	return generic_get_fscaps(idmap, dentry, caps);
+}
+
+/**
+ * vfs_get_fscaps - get filesystem capabilities
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to get filesystem capabilities
+ * @caps: storage in which to return the filesystem capabilities
+ *
+ * This function gets the filesystem capabilities for the dentry and returns
+ * them in @caps.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+		   struct vfs_caps *caps)
+{
+	int error;
+
+	/*
+	 * The VFS has no restrictions on reading security.* xattrs, so
+	 * xattr_permission() isn't needed. Only LSMs get a say.
+	 */
+	error = security_inode_getxattr(dentry, XATTR_NAME_CAPS);
+	if (error)
+		return error;
+
+	return __vfs_get_fscaps(idmap, dentry, caps);
+}
+EXPORT_SYMBOL(vfs_get_fscaps);
+
 int
 __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	       struct inode *inode, const char *name, const void *value,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a0a77f67b999..e25b39e4017a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2055,6 +2055,10 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
+extern int __vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			    struct vfs_caps *caps);
+extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			  struct vfs_caps *caps);
 
 enum freeze_holder {
 	FREEZE_HOLDER_KERNEL	= (1U << 0),

-- 
2.43.0


