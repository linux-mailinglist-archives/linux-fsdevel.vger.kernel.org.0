Return-Path: <linux-fsdevel+bounces-12385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D385EACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F3C1C22D61
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D314A4E4;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvVoVQef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F812D74B;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=p8SP/J9uTz7ZS2ZIDmXjYEOb3R9d38Ibf2WmNxkTE/bRM4ntO5SL8uDvdpospfqJAWIJwFIHFXrBBM/REuf3xOcvUkqROF4yvNBtSm9JRmdy96IhuYF6GYWAwEtmJxXO1DgZJFDQ61eonGRyjc3iEg4yVn8CE+7ntDe2e759vsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=DaMtiOZBeQDVEion4ZN4zKQprvyExzuJ8doVlQBSc+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjSNYF8NpgIB/xDj6rEN5phSVtjRwUI1lgnDI8Z91JgtnFDStDoHrcfrYh7lNmMUdYWUqozlvq8aMp8N/g93ZEGp2jsFQo+LTyQ6xhRQM7cDdmZ33wDp3OmPu+7C9ioM9BkwY1JEvksImR36q93D1O5n3YEgPRMhyHwudT1hJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvVoVQef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF0F6C3279A;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=DaMtiOZBeQDVEion4ZN4zKQprvyExzuJ8doVlQBSc+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DvVoVQefCHkO2csohbS3+DfA7v+LfDjn3ihNeo+F5RWTo/d+i+POCZfKnpVl/aq2+
	 EFlacb9HtfXWmP2h8D8rTfy8DhkMQ0l/b+lImzLz2lC7FDWdgCYnEjxIqIlVIViRJ6
	 EL2T3qf+BkYg0yboVvr8ooXGcvyAPGpgWHa3rPGYSxypgLadkoUgY0Pa2F10wqPip9
	 uAKFzt8IhkOFxlo7jHWzeydHasZEdd/inkcYudHEDGW8QI6pZK9FK6eO8unzGvpL9A
	 5YIAbQU/4f52rFo4iwf2/O4khZjPzsjNcxw2AdJwMLs2eRhEtG27fEWXe3Kc8bGHTA
	 g43F4co1z154Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB15EC54793;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:48 -0600
Subject: [PATCH v2 17/25] fs: add vfs_get_fscaps()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-17-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3594; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=DaMtiOZBeQDVEion4ZN4zKQprvyExzuJ8doVlQBSc+c=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1monpM9wsGSZSvppxhKtdjKe8?=
 =?utf-8?q?E/VR1Wssga6IW1B_2+E5+u6JATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqJwAKCRBTA5mu5fQxyb00B/_9W4Ogzb7YrK4uooki+F6O5V/u8cnm14dQIt?=
 =?utf-8?q?C1D1/LcKAxqObtAO+ncDERx5iTwUlrSxVUYHuaHFboa_4Inr3IZy5FL7oDPg9k1hg?=
 =?utf-8?q?Nlxs/lpczEboUlQdrR0avbXapmFGjvnjVS6aC6M8QKTxhnoUliZVEwjyI_QwyQzL4?=
 =?utf-8?q?T+7xdZm5xpYnuqlhLTZe0Ir54jV5FO08fcbevSq0ccjxzGD6QUD9sn9Px3PbQrbCI?=
 =?utf-8?q?Ai8J/V_9BQ9D5Hmqt4o/K33RmONq0GUG2E/pgbLJynIiMrPtQsaMRx/J4gtt89H8G?=
 =?utf-8?q?j9HULnOCsoy8UvVzJw6r?= kKjfHaJw+PgLCgqMO8rXVQNmIrkzhG
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Provide a type-safe interface for retrieving filesystem capabilities and
a generic implementation suitable for most filesystems. Also add an
internal interface, vfs_get_fscaps_nosec(), which skips security checks
for later use from the capability code.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  4 ++++
 2 files changed, 68 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 06290e4ebc03..10d1b1f78fc2 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -181,6 +181,70 @@ xattr_supports_user_prefix(struct inode *inode)
 }
 EXPORT_SYMBOL(xattr_supports_user_prefix);
 
+static int generic_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			      struct vfs_caps *caps)
+{
+	struct inode *inode = d_inode(dentry);
+	struct vfs_ns_cap_data nscaps;
+	int ret;
+
+	ret = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, &nscaps, sizeof(nscaps));
+
+	if (ret >= 0)
+		ret = vfs_caps_from_xattr(idmap, i_user_ns(inode), caps, &nscaps, ret);
+
+	return ret;
+}
+
+/**
+ * vfs_get_fscaps_nosec - get filesystem capabilities without security checks
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to get filesystem capabilities
+ * @caps: storage in which to return the filesystem capabilities
+ *
+ * This function gets the filesystem capabilities for the dentry and returns
+ * them in @caps. It does not perform security checks.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int vfs_get_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry,
+			 struct vfs_caps *caps)
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
+	error = security_inode_get_fscaps(idmap, dentry);
+	if (error)
+		return error;
+
+	return vfs_get_fscaps_nosec(idmap, dentry, caps);
+}
+EXPORT_SYMBOL(vfs_get_fscaps);
+
 int
 __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	       struct inode *inode, const char *name, const void *value,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 89163e0f7aad..d7cd2467e1ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2116,6 +2116,10 @@ extern int vfs_dedupe_file_range(struct file *file,
 extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 					struct file *dst_file, loff_t dst_pos,
 					loff_t len, unsigned int remap_flags);
+extern int vfs_get_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry,
+				struct vfs_caps *caps);
+extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			  struct vfs_caps *caps);
 
 /**
  * enum freeze_holder - holder of the freeze

-- 
2.43.0


