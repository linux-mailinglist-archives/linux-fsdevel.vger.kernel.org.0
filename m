Return-Path: <linux-fsdevel+bounces-50334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA8ACB0B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD3F189FD9C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2F226D1E;
	Mon,  2 Jun 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pv1/3uw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1083225417;
	Mon,  2 Jun 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872950; cv=none; b=AvJa7KsZXYpGtWrZwNeJXq0MD1xAg81WI63nIQXT6scT6x+AB/OVfpGJUgx9zZ9Ej5/JIIubXNulht7VBJjcQgIgPnkCh013e6aWEVPmo78Jq1L5U/HWeBsuFakO2FoIxMGhtxStrO7vqVdXr+6aBU4mVohsnu95KY2tAzikvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872950; c=relaxed/simple;
	bh=xMuOkareOjJkjyUfBS4IvfeElA0FAadf3AwmfN0gZJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUHF5SJEE6BNh0ji/AfwS/B8sJH3H4TB+wxauaclfApPeUTgKoUYswwJPvEIyYwiut4KFjncM8Gduu1XEmWYM3qmd0WqLeqhgIn8aQNRUmmHgybob+FwHBuqt+jRZVJAANhodewHryi0RrJKjaSwNE6iz4B5HNwEmaMyWgkIyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pv1/3uw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98690C4CEEB;
	Mon,  2 Jun 2025 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872950;
	bh=xMuOkareOjJkjyUfBS4IvfeElA0FAadf3AwmfN0gZJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pv1/3uw/IpTYy0uOvTHgd5Fh0TaY2AIcpny39eMSm2IdvsIbLlBpYrshtIfgWv9s6
	 MLbIvTI/QTJx/j7rliqjAe19yTJBcQJtpPTsFST5QaFclmawTrslbOQlBASbxoUpvO
	 vVjq/U5HuWZ4xv0WZOYMR3Yxpxoo49ueArvPSwxhK7QPTPMRuhgDNZa6DpaErvm5Ml
	 PEOA+lMIxJrjlZUlVEtA7pXODt6v4sDm07aknH3o8VUb/85OZpJiZwOiO3SAMWfx9R
	 0HxvIwCgnTL8UyFUu17dIPNsHDcQYFQVPr6QIQ5AGudJoBRSilpnc2SftLh8fFhWcE
	 jeVO9k0cSGkpQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:47 -0400
Subject: [PATCH RFC v2 04/28] vfs: allow mkdir to wait for delegation break
 on parent
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-4-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4897; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xMuOkareOjJkjyUfBS4IvfeElA0FAadf3AwmfN0gZJU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7k4bw5YQLN8ucaXbTAdLj/XT1eNL9+G4ufs
 MDSnEU1B1yJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5AAKCRAADmhBGVaC
 FZx1D/9C40qh8CQhavJ78Mw8gLubF5wF1xv1dj4OWwtN5GDDSpAuhx2DaqqE2deCyBhm3KWxCBR
 xrlnOxGc+OsnzC4utibTSIbwNMpsUFgyLK2G+FEnLGlKcntIAP0iw97EH7njrI+d6LTAWg1pUQy
 irJJkfpMAhp2fEqMM3k0+rTJjBilBsrQyDgHYf3GYu4PxLupM892bvNURmvxcmYIdgMVNtwmN5P
 ScAeecqkiIKaLk/WJtloF/X7fDwbApNhU2pGa/AC9a9abdLL2gSQS6fTEwnuGTa1yUXBycIGd2c
 uvqIKwtICMgy1BjC6WRII6mOJ6MQ7Zr2bIvMDCpAcYDZmEbhDLAnl1cZnLyGakxmaAGv+79dD7Q
 d6c87sBzX+AkURnJoSqUZtbVN7zHovADkWvbTHjnNI3fAHny5DytNAmEOzdPe0UJbReJw38vk3i
 TFgsGVw/RAOj1P1jUSaoZvRB1RFyfOxpPguEaACtDxz79yQOKuWWyoTvjKVMfvt1Z88uOEiiUZN
 STKoGtBZZpTuNW2a3MhtFvvoxSe4DHk/kKfh2qyk+C7cYjQlogSRED55JwIbRoNSoWXzer+iIie
 tTXSe4SS/7kJ3CSGfaP+lN2F5H3hSSub12O1Ayhpqm2eZd7h15qqjQLchxx0hCppJGi7IHbYqoV
 GrQO1uz4hrcxIvA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename the existing vfs_mkdir to __vfs_mkdir, make it static and add a
new delegated_inode parameter. Add a new exported vfs_mkdir wrapper
around it that passes a NULL pointer for delegated_inode.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 67 +++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0fea12860036162c01a291558e068fde9c986142..7c9e237ed1b1a535934ffe5e523424bb035e7ae0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4318,29 +4318,9 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return do_mknodat(AT_FDCWD, getname(filename), mode, dev);
 }
 
-/**
- * vfs_mkdir - create directory returning correct dentry if possible
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child directory
- * @mode:	mode of the child directory
- *
- * Create a directory.
- *
- * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then take
- * care to map the inode according to @idmap before checking permissions.
- * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply pass @nop_mnt_idmap.
- *
- * In the event that the filesystem does not use the *@dentry but leaves it
- * negative or unhashes it and possibly splices a different one returning it,
- * the original dentry is dput() and the alternate is returned.
- *
- * In case of an error the dentry is dput() and an ERR_PTR() is returned.
- */
-struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode)
+static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+				  struct dentry *dentry, umode_t mode,
+				  struct inode **delegated_inode)
 {
 	int error;
 	unsigned max_links = dir->i_sb->s_max_links;
@@ -4363,6 +4343,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		goto err;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		goto err;
+
 	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
 	error = PTR_ERR(de);
 	if (IS_ERR(de))
@@ -4378,6 +4362,33 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	dput(dentry);
 	return ERR_PTR(error);
 }
+
+/**
+ * vfs_mkdir - create directory returning correct dentry if possible
+ * @idmap:	idmap of the mount the inode was found from
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
+ * @mode:	mode of the child directory
+ *
+ * Create a directory.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply pass @nop_mnt_idmap.
+ *
+ * In the event that the filesystem does not use the *@dentry but leaves it
+ * negative or unhashes it and possibly splices a different one returning it,
+ * the original dentry is dput() and the alternate is returned.
+ *
+ * In case of an error the dentry is dput() and an ERR_PTR() is returned.
+ */
+struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
+{
+	return __vfs_mkdir(idmap, dir, dentry, mode, NULL);
+}
 EXPORT_SYMBOL(vfs_mkdir);
 
 int do_mkdirat(int dfd, struct filename *name, umode_t mode)
@@ -4386,6 +4397,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	struct inode *delegated_inode = NULL;
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -4396,12 +4408,17 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	error = security_path_mkdir(&path, dentry,
 			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error) {
-		dentry = vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
-				  dentry, mode);
+		dentry = __vfs_mkdir(mnt_idmap(path.mnt), path.dentry->d_inode,
+				     dentry, mode, &delegated_inode);
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
 	done_path_create(&path, dentry);
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry;
+	}
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;

-- 
2.49.0


