Return-Path: <linux-fsdevel+bounces-12380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DA85EAC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C107FB27CA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B11114A08F;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZqTenVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6512E1DF;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=T8C5TPl4zhOxwfGQSJyTtViA5Q9VIk3mdKsUoADRqMHqFQz8fFjTp4Gd9Logi3hRR06zr/ZkPiX1LZnrqpXFUy/fSXwN/HgXxJj5LU3Lb29+uNe9rBcXk9QHkJSh4RV9SJ/5kqxxc/ZVII49/EbqzOzpSHsmLDHail5+xPBnSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=zODK8f1Oy6szXpHeADRTdhogMg3GAwHuizUWMJpE3DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QruHK1h+evfwFcpkYp0fAKRp5bLv5ksY5MUhVuu5Q7O591me5f+3UGo6ZuZEmRtJc25C38C9WIid9iOECUiBjhRl4+zLUQd1r9lNKNLZf4xAcNGyTj511GjHB/zAAosQFifCLyf1A/F+KdDvQkoOPQqy8YwGy04u/MSPXWWvHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZqTenVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AB51C4AF75;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550707;
	bh=zODK8f1Oy6szXpHeADRTdhogMg3GAwHuizUWMJpE3DE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EZqTenVf4PLgedTk1rJ753Y6K4Dpv0W+PXOQ+O6XztyKcvNh1FE7lHIrpUjKps0FB
	 BE8fgzu2nqU0fm1hvmeCWrNIJXyeigiIA6CJtIBy0CeExigttHfIPUNoIReHEj91rS
	 n8dSratBFnSdVJt4+CPzym1SwMREEyF9g1MKfOPrU/LrBhfXNWZMyADs12eTMKAnZn
	 JPBthukiLEhLl/cAkGrEOwLc2PLLboFdudLK5fawpg3Lx45Wnw0Ji1YrBH7/j5jjsS
	 Hyay/OR1tYUESoA6X/0MZ4CH4+tgI4RMh75woXvMMb8jM9tQz/5WP5m4qdMQTxyAgZ
	 FWCPpe1pXmGIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A073C54791;
	Wed, 21 Feb 2024 21:25:07 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:52 -0600
Subject: [PATCH v2 21/25] ovl: use vfs_{get,set}_fscaps() for copy-up
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-21-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4041; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=zODK8f1Oy6szXpHeADRTdhogMg3GAwHuizUWMJpE3DE=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moryy7rWCDyCKYhTErtw9reV?=
 =?utf-8?q?BQghynbKThrJ7UB_cXmkPrOJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqKwAKCRBTA5mu5fQxyVGuB/_98YVYzC3rmVA+s5SJScrnZ4Y5tk6TMC1IC3?=
 =?utf-8?q?m8QqEF/wR9kN8x37EMkdEPDIonp4yWwKAp6jK5PHooi_f/TDfrw9dyMvPoFu1mtHO?=
 =?utf-8?q?k7vcZiK+5YhYlIWrGhaRNAhn89fEQAq8U0XJc0QZMBWZX3zC/JjGALUIe_AXfYqoT?=
 =?utf-8?q?kymSa8cturCezE9r8NumhzW5fw2Xeam38vDff9hJEQnZdTqoORMKGVWyvWlcy0o7g?=
 =?utf-8?q?1kEuga_GwQcCqZY7BooJEggxTGYotp66PNUyX0oamXw/4QROT9Cldpj8wp9PrlATv?=
 =?utf-8?q?F94aP27wamFYLAmAwztP?= 1sjZ5ZJP6nJXzabi+skNTzn9983WmN
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Using vfs_{get,set}xattr() for fscaps will be blocked in a future
commit, so convert ovl to use the new interfaces. Also remove the now
unused ovl_getxattr_value().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/overlayfs/copy_up.c | 72 ++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b8e25ca51016..d7c8d76e2394 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -73,6 +73,23 @@ static int ovl_copy_acl(struct ovl_fs *ofs, const struct path *path,
 	return err;
 }
 
+static int ovl_copy_fscaps(struct ovl_fs *ofs, const struct path *oldpath,
+			   struct dentry *new)
+{
+	struct vfs_caps capability;
+	int err;
+
+	err = vfs_get_fscaps(mnt_idmap(oldpath->mnt), oldpath->dentry,
+			     &capability);
+	if (err) {
+		if (err == -ENODATA || err == -EOPNOTSUPP)
+			return 0;
+		return err;
+	}
+
+	return vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), new, &capability, 0);
+}
+
 int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct dentry *new)
 {
 	struct dentry *old = oldpath->dentry;
@@ -130,6 +147,14 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			break;
 		}
 
+		if (is_fscaps_xattr(name)) {
+			error = ovl_copy_fscaps(OVL_FS(sb), oldpath, new);
+			if (!error)
+				continue;
+			/* fs capabilities must be copied */
+			break;
+		}
+
 retry:
 		size = ovl_do_getxattr(oldpath, name, value, value_size);
 		if (size == -ERANGE)
@@ -1039,61 +1064,40 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr_value(const struct path *path, char *name, char **value)
-{
-	ssize_t res;
-	char *buf;
-
-	res = ovl_do_getxattr(path, name, NULL, 0);
-	if (res == -ENODATA || res == -EOPNOTSUPP)
-		res = 0;
-
-	if (res > 0) {
-		buf = kzalloc(res, GFP_KERNEL);
-		if (!buf)
-			return -ENOMEM;
-
-		res = ovl_do_getxattr(path, name, buf, res);
-		if (res < 0)
-			kfree(buf);
-		else
-			*value = buf;
-	}
-	return res;
-}
-
 /* Copy up data of an inode which was copied up metadata only in the past. */
 static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct path upperpath;
 	int err;
-	char *capability = NULL;
-	ssize_t cap_size;
+	struct vfs_caps capability;
+	bool has_capability = false;
 
 	ovl_path_upper(c->dentry, &upperpath);
 	if (WARN_ON(upperpath.dentry == NULL))
 		return -EIO;
 
 	if (c->stat.size) {
-		err = cap_size = ovl_getxattr_value(&upperpath, XATTR_NAME_CAPS,
-						    &capability);
-		if (cap_size < 0)
+		err = vfs_get_fscaps(mnt_idmap(upperpath.mnt), upperpath.dentry,
+				     &capability);
+		if (!err)
+			has_capability = 1;
+		else if (err != -ENODATA && err != EOPNOTSUPP)
 			goto out;
 	}
 
 	err = ovl_copy_up_data(c, &upperpath);
 	if (err)
-		goto out_free;
+		goto out;
 
 	/*
 	 * Writing to upper file will clear security.capability xattr. We
 	 * don't want that to happen for normal copy-up operation.
 	 */
 	ovl_start_write(c->dentry);
-	if (capability) {
-		err = ovl_do_setxattr(ofs, upperpath.dentry, XATTR_NAME_CAPS,
-				      capability, cap_size, 0);
+	if (has_capability) {
+		err = vfs_set_fscaps(mnt_idmap(upperpath.mnt), upperpath.dentry,
+				     &capability, 0);
 	}
 	if (!err) {
 		err = ovl_removexattr(ofs, upperpath.dentry,
@@ -1101,13 +1105,11 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	}
 	ovl_end_write(c->dentry);
 	if (err)
-		goto out_free;
+		goto out;
 
 	ovl_clear_flag(OVL_HAS_DIGEST, d_inode(c->dentry));
 	ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
 	ovl_set_upperdata(d_inode(c->dentry));
-out_free:
-	kfree(capability);
 out:
 	return err;
 }

-- 
2.43.0


