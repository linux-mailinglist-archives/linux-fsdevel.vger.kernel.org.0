Return-Path: <linux-fsdevel+bounces-12379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C673D85EAC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD8F285CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE814A094;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyOX9ubk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4256612D76C;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=B/CsYQYNHbSOJiInIRVP223U1MWPXzeclsZpg+n9bDkFeCKPW/odObBMo1dyIM5ei6QTPJTrCKoEDHa7u7MxdyPWz0Vy9E28LCgQaHrsza1LRW8HntHnyw7Sz/+wpZeQx1FKXQ8nod9fIxl4x8Ezwkj2AZkr3O6SLwHlkY+UsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=a3ugvMhATksPxV+a7Wcb3fojtkXnejQOJKEmfG2Au6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVZbFFSKr9s7lQxC0+6OGi+CmzxMkIp8ql6XcMui2hcGRToosIR+EsDA10Yg0U00waGtVw8hfzGwKO4a6Fg1mXaR4RI9f6FPv4/nzKC1OoqeKYWv1AH1Vr4N2M82k/ZKr7JgjULAryw8/fcDqsG3OuRzo/svc9VFUv9/puQJ8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyOX9ubk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1873CC43141;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=a3ugvMhATksPxV+a7Wcb3fojtkXnejQOJKEmfG2Au6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fyOX9ubkNP7PgYk94oDhtYGquf+vSSCFPMucQ0Dq2rCZQXUB/iZqjXl8cMzOrCk81
	 80q9tpt7qDd2z033II1TkZorVEAtmK0acy7UCkqNZjpwQo5rZOvnLyQRhHwCSFky1v
	 1jFcJfZggb8rW0E+8V/yJk/JwS3iFdRQaCXJ6iiVKM7PfETwcKRcQyTcumymYdfA9w
	 oLL4R5CZ9n0TaZTpjw22Tf0CGQBQK69IAh6Zaa681oK6Uh5Dn7qu8EzdsqcH1dFUKE
	 gAT9G4DKCvPMTrv2Id/QAPjwz/fbRyzcOPsTzafuZ+DQKzK7P9rdfqZ76hK4MxMJAe
	 KtZ7d8bEGLS1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511CC48BEB;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:50 -0600
Subject: [PATCH v2 19/25] fs: add vfs_remove_fscaps()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-19-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3779; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=a3ugvMhATksPxV+a7Wcb3fojtkXnejQOJKEmfG2Au6A=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mopgDVenhi3VLPaPvFwxM95t?=
 =?utf-8?q?qNAaxCLXvBKa+2y_76GFlFmJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqKQAKCRBTA5mu5fQxyQftB/_0eV/oZCodcvmT2NzrSTKkvLIWCpVU5YGKGF?=
 =?utf-8?q?ugW3HG3lJRUuGtO+t+A3RwZKzOSWbtk1CkbGAetJWXa_aqqprqjsUstKaAApbpfZo?=
 =?utf-8?q?Z+eK6TN/rCUWHcGfXJrwsSbxogu7GRc2n0qYaSlu+qA3xEzF8z6c/Ddpr_k/Dc7FV?=
 =?utf-8?q?T0eukTELGcPFhqthrQZQwUPUa27SB4BCSgNW5nS3MQFGNmL3komWpIDaUw1t7zzje?=
 =?utf-8?q?PB3Q8p_Sd6mViD54RmlcUD/RuxaNacNOjFHyQ0gXUwF/iAQuoi0uwi4vkFeECAIEt?=
 =?utf-8?q?6niPSkeZ/0OqmUxINUBZ?= jM1eqVetaMefnRdsKXRtEreKVXPamw
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Provide a type-safe interface for removing filesystem capabilities and a
generic implementation suitable for most filesystems. Also add an
internal interface, vfs_remove_fscaps_nosec(), which is called with the
inode lock held and skips security checks for later use from the
capability code.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 83 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 96de43928a51..8b0f7384cbc9 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -324,6 +324,87 @@ int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 EXPORT_SYMBOL(vfs_set_fscaps);
 
+static int generic_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	return __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+}
+
+/**
+ * vfs_remove_fscaps_nosec - remove filesystem capabilities without
+ *                           security checks
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to remove filesystem capabilities
+ *
+ * This function removes any filesystem capabilities from the specified
+ * dentry. Does not perform any security checks, and callers must hold the
+ * inode lock.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int vfs_remove_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	if (inode->i_op->set_fscaps)
+		error =  inode->i_op->set_fscaps(idmap, dentry, NULL,
+						 XATTR_REPLACE);
+	else
+		error = generic_remove_fscaps(idmap, dentry);
+
+	return error;
+}
+
+/**
+ * vfs_remove_fscaps - remove filesystem capabilities
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to remove filesystem capabilities
+ *
+ * This function removes any filesystem capabilities from the specified
+ * dentry.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+
+	error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
+	if (error)
+		goto out_inode_unlock;
+
+	error = security_inode_remove_fscaps(idmap, dentry);
+	if (error)
+		goto out_inode_unlock;
+
+	error = try_break_deleg(inode, &delegated_inode);
+	if (error)
+		goto out_inode_unlock;
+
+	error = vfs_remove_fscaps_nosec(idmap, dentry);
+	if (!error) {
+		fsnotify_xattr(dentry);
+		evm_inode_post_remove_fscaps(dentry);
+	}
+
+out_inode_unlock:
+	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(vfs_remove_fscaps);
+
 int
 __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	       struct inode *inode, const char *name, const void *value,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4f5d7ed44644..c07427d2fc71 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2122,6 +2122,8 @@ extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 			  struct vfs_caps *caps);
 extern int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 			  const struct vfs_caps *caps, int setxattr_flags);
+extern int vfs_remove_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry);
+extern int vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry);
 
 /**
  * enum freeze_holder - holder of the freeze

-- 
2.43.0


