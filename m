Return-Path: <linux-fsdevel+bounces-12376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE085EAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F9B2789F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B69135A7F;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzqK00wH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598712AAE2;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=bxM94GCzQ6Qi8Oqgyl3TXv3uJYZ9iMhg/RGGlvSPa+TAp14XczAA2Ous2lD0nBlkzGMnR497dyekF3NdkT/FhSNMTs6NzHzN9r8izkAS/bWt3W0IPYYHdjlUCecZV/BorsvcGPMMLAXfAPTxnRi9GDSowapVC60YNn9Y/qDM0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=Yr3ph0XCYOXrp9CXWdQMd7IWQbhJjbtCnaMZrcY53gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bw/i2eZcirMgisYTFexaGG9ezqUkiUYSYFEU+WtPovHo4VU8V3IqA05fTFXLS+DN4TvL2cEnJLSvjX0TOWdEzpSuz5fHhCvBZaJx7MfK8b9lM00FIad3Jy99EUTXQrsRps9bBdoc4YQaaye80Lw9V9zYqnj0ga/oJN3aFUq5ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzqK00wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5D8FC32790;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=Yr3ph0XCYOXrp9CXWdQMd7IWQbhJjbtCnaMZrcY53gY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lzqK00wHaspxkj8s4YixHYBHO5uRXAEZjNOy9Tt0Z+zVFhBNoRvYu/G86zief0nKx
	 DOC8vrh8C8IjEHbdu7wwreh1NNB3LwwbqMH0XaZWH+IykU6H5BTj1w/GUbwEY07O5Z
	 pvwC+B2b6olS/XcTYKLHEbL6kmg/L1ovWhiGt+wN7z3/EUgIDJm5CNvALRd0UvLCPr
	 YN7WDcK0FDtDVAfriM9B0F3WsZlZvlWdTcQPII7bNMfNd41fGQdq/VjOUrAZzeTnvH
	 ZJaeZRN5maBuF9hI2NOJ5ijYh2cBqpS/xIahdqiP82EiiWzznvttVF2LXIWeD/RRi7
	 EhxIDDDI3G5bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1A0C54791;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:45 -0600
Subject: [PATCH v2 14/25] evm: add support for fscaps security hooks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-14-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4327; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=Yr3ph0XCYOXrp9CXWdQMd7IWQbhJjbtCnaMZrcY53gY=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mol25TRgD1iHEn0O+Lzt/PUv?=
 =?utf-8?q?oaNtWltRiGhhXzf_m3QV75SJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqJQAKCRBTA5mu5fQxyS9CB/_9kSIwlWp/cTH5n9oXEiY7IRY7QctvMWegFy?=
 =?utf-8?q?imx7di5G0HHXG0GkFzYw+GCyZNDCVL5R5AuZIagZMKH_cytRQKwJZdn+UxoBt7VxR?=
 =?utf-8?q?cVA0NXxcM5vRXXYDzuNpVQNmbfH5HvHaFvaIDzOEYFmJqsIW/jaxzfWVB_RjglGLz?=
 =?utf-8?q?pDryq2M/ZCsQx9KBTGmEwTBnxzalQNyrtvXgG4UHhg2ZBqBAWhD3SNXDCf7Ii95JG?=
 =?utf-8?q?mya1vE_xyBqVMzbjM3/l+t7NBgQWvLHaHz7A3od4uGdwyYRfroyU95TFJcCTgcv4b?=
 =?utf-8?q?gK682Ja2e9Zo3X4dw5Wp?= Ka5r0Q2dpUgYDHMm+pijpjRjRaNrcP
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Support the new fscaps security hooks by converting the vfs_caps to raw
xattr data and then handling them the same as other xattrs.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/evm.h               | 39 +++++++++++++++++++++++++
 security/integrity/evm/evm_main.c | 60 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 36ec884320d9..aeb9ff52ad22 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -57,6 +57,20 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 {
 	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
 }
+extern int evm_inode_set_fscaps(struct mnt_idmap *idmap,
+				struct dentry *dentry,
+				const struct vfs_caps *caps, int flags);
+static inline int evm_inode_remove_fscaps(struct dentry *dentry)
+{
+	return evm_inode_set_fscaps(&nop_mnt_idmap, dentry, NULL, XATTR_REPLACE);
+}
+extern void evm_inode_post_set_fscaps(struct mnt_idmap *idmap,
+				      struct dentry *dentry,
+				      const struct vfs_caps *caps, int flags);
+static inline void evm_inode_post_remove_fscaps(struct dentry *dentry)
+{
+	return evm_inode_post_set_fscaps(&nop_mnt_idmap, dentry, NULL, 0);
+}
 
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
 			    const struct qstr *qstr, struct xattr *xattrs,
@@ -164,6 +178,31 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 	return;
 }
 
+static inline int evm_inode_set_fscaps(struct mnt_idmap *idmap,
+				       struct dentry *dentry,
+				       const struct vfs_caps *caps, int flags)
+{
+	return 0;
+}
+
+static inline int evm_inode_remove_fscaps(struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline void evm_inode_post_set_fscaps(struct mnt_idmap *idmap,
+					     struct dentry *dentry,
+					     const struct vfs_caps *caps,
+					     int flags)
+{
+	return;
+}
+
+static inline void evm_inode_post_remove_fscaps(struct dentry *dentry)
+{
+	return;
+}
+
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
 					  struct xattr *xattrs,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cc7956d7878b..ecf4634a921a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -805,6 +805,66 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
 	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
 }
 
+int evm_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			 const struct vfs_caps *caps, int flags)
+{
+	struct inode *inode = d_inode(dentry);
+	struct vfs_ns_cap_data nscaps;
+	const void *xattr_data = NULL;
+	int size = 0;
+
+	/* Policy permits modification of the protected xattrs even though
+	 * there's no HMAC key loaded
+	 */
+	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
+		return 0;
+
+	if (caps) {
+		size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
+					 sizeof(nscaps));
+		if (size < 0)
+			return size;
+		xattr_data = &nscaps;
+	}
+
+	return evm_protect_xattr(idmap, dentry, XATTR_NAME_CAPS, xattr_data, size);
+}
+
+void evm_inode_post_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			       const struct vfs_caps *caps, int flags)
+{
+	struct inode *inode = d_inode(dentry);
+	struct vfs_ns_cap_data nscaps;
+	const void *xattr_data = NULL;
+	int size = 0;
+
+	if (!evm_revalidate_status(XATTR_NAME_CAPS))
+		return;
+
+	evm_reset_status(dentry->d_inode);
+
+	if (!(evm_initialized & EVM_INIT_HMAC))
+		return;
+
+	if (is_unsupported_fs(dentry))
+		return;
+
+	if (caps) {
+		size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
+					 sizeof(nscaps));
+		/*
+		 * The fscaps here should have been converted to an xattr by
+		 * evm_inode_set_fscaps() already, so a failure to convert
+		 * here is a bug.
+		 */
+		if (WARN_ON_ONCE(size < 0))
+			return;
+		xattr_data = &nscaps;
+	}
+
+	evm_update_evmxattr(dentry, XATTR_NAME_CAPS, xattr_data, size);
+}
+
 static int evm_attr_change(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr)
 {

-- 
2.43.0


