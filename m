Return-Path: <linux-fsdevel+bounces-62626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4FB9B384
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992B617993E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A96E32127D;
	Wed, 24 Sep 2025 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFklbh05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EC320A30;
	Wed, 24 Sep 2025 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737202; cv=none; b=ctR1mzvFKtNA7wpGXpuP51fcrSbzhhh6sEs1xs5lyjsHtvgMpw2nrl9NGYr+vLrUH6Qm99vmunv9r1rwZ0Hj47f4K2LcQXMdc8PsnoJRRgTTsbhzByfPz/1es8hW5oHbjS2XgVSyONQhmUFaZBpNYyXcKZYbHYl5CfNHLFlNyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737202; c=relaxed/simple;
	bh=bc8ny3d/9eV4XN0Uf7xrDNg9Y6GbrUCifJ3A2DoNcSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNp2gVO1KOj90dsPE4CO9W0yWwBcGT09y+g/bpNi2Bww15SLSUxbdWnDzbze007zs6jLXwTSoVgjHbTFgujRthh+YK2VErul+Js+F7mNSTB6a4K8uaJ07xz9CcJrLwyduv8FyklgZFm4nb3gNyLFOKMnXil/fLbysEbTzPiVxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFklbh05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5652C4CEF8;
	Wed, 24 Sep 2025 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737202;
	bh=bc8ny3d/9eV4XN0Uf7xrDNg9Y6GbrUCifJ3A2DoNcSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LFklbh05RPZBoO1bNTrHW8uInsc9R5RVE3/vIRCarx5umPz3tNsdYx1LVJTZS5X/7
	 0VRlJr6pEX0nCMDfmDbtKnR7u+w7ycsgpTpIf+zh8/2VmdD7qqqCfRnr2dXRkoV53f
	 dZ4tmDeDJTett3UQHdzxwd1efc3mV50QGO8BQGUPjKKeSqFzOtv6Fl0Bhd91AK5oE1
	 RaH428plovPIIaMAIrvezI+Pz3VC7YeAgbI4t6h/2tEB5k18/BonjwNPGY8d2fJYp6
	 qQEQte/SHiGgimH40Xs4ZfYnNnoBuUF33XeTzPbNV558fxKCY2wSxFdNgm4Nw+Ajfr
	 zoya95MwPojJw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:05:54 -0400
Subject: [PATCH v3 08/38] vfs: make vfs_mknod break delegations on parent
 directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-8-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=bc8ny3d/9eV4XN0Uf7xrDNg9Y6GbrUCifJ3A2DoNcSk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMMe7RZAJo9092o6alMTG/F8D+sT2Nvzeunr
 jrTg4UE3OaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDAAKCRAADmhBGVaC
 FfUzEACJH0sX2UeO3mlH8sZ4wIvSoIouQIOm0dGb+ve+Zd/Ci4QTxZ6Ed4JW/HsG7iGOHn/0yTB
 SEwl4iZv/V26Gh7mRM2pFzfN1M56bQwXyKrwJBMvgsF2a7kQHFKA+eRFPnEGHz8lpbZkZovpnv5
 AwqZRbwlVG+8epVDZYdEjnEiI12YgLJz7rN8vSLh3X2KtBUHNnN5jRFU/C2XmihuWpwrwcCseup
 QMQu4M/bSlWuik8j3rGUWUa27RubaBbNa3B4YNfD9lN7bRQHP8mbHdwksdvh6pOWrVAn0RY40dS
 JvLqJSxNd3ahOWx7N6LI8cSMA7jTboNnDEkEucUGzWp/K41BiJZRq/WupeSMQas7+hl681dMMaH
 ql5xvQfjc+jSZJJoBAJaSeX0pgpsTopL9+PU0dKMOX4wKJQUiuzzyl3NuEeCFuOHbODwg5oJaUP
 TL16h5P6Iy3Dy7iv58jzmMT9sLIWl4NQioqI6Gni5tl5up8oJ8HPXpJW8bmGOEsmPW4HxIQKYfK
 TmNvwwGJmtu+FBJ1VtTGg9cYmGIXUrwO0Ha72Z7d20fgB1EWscyRhs1gwIqC5i6tObOvMdD122k
 5ZLjAWDAnRtdnW+3UiAFR2x2UFtaQbzfMvskZ6a+C601St0wA2xq7RiLGBUhpVnotSNka8fSbTP
 d95JtEwHPOOZRIA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In order to add directory delegation support, we need to break
delegations on the parent whenever there is going to be a change in the
directory.

Rename vfs_mknod as __vfs_mknod, make it static, and add a new
delegated_inode parameter.  Make do_mknodat call __vfs_mknod and wait
synchronously for delegation breaks to complete. Add a new exported
vfs_mknod wrapper that calls __vfs_mknod with a NULL delegated_inode
pointer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 57 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d4b8330a3eb97e205dc2e71766fed1e45503323b..7bcd898c84138061030f1f8b91273261cdf2a9b4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4215,24 +4215,9 @@ inline struct dentry *user_path_create(int dfd, const char __user *pathname,
 }
 EXPORT_SYMBOL(user_path_create);
 
-/**
- * vfs_mknod - create device node or file
- * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of the parent directory
- * @dentry:	dentry of the child device node
- * @mode:	mode of the child device node
- * @dev:	device number of device to create
- *
- * Create a device node or file.
- *
- * If the inode has been found through an idmapped mount the idmap of
- * the vfsmount must be passed through @idmap. This function will then take
- * care to map the inode according to @idmap before checking permissions.
- * On non-idmapped mounts or if permission checking is to be performed on the
- * raw inode simply pass @nop_mnt_idmap.
- */
-int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
-	      struct dentry *dentry, umode_t mode, dev_t dev)
+static int __vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t dev,
+		       struct inode **delegated_inode)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
 	int error = may_create(idmap, dir, dentry);
@@ -4256,11 +4241,37 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		return error;
 
+	error = try_break_deleg(dir, delegated_inode);
+	if (error)
+		return error;
+
 	error = dir->i_op->mknod(idmap, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
 }
+
+/**
+ * vfs_mknod - create device node or file
+ * @idmap:	idmap of the mount the inode was found from
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child device node
+ * @mode:	mode of the child device node
+ * @dev:	device number of device to create
+ *
+ * Create a device node or file.
+ *
+ * If the inode has been found through an idmapped mount the idmap of
+ * the vfsmount must be passed through @idmap. This function will then take
+ * care to map the inode according to @idmap before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply pass @nop_mnt_idmap.
+ */
+int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
+	      struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	return __vfs_mknod(idmap, dir, dentry, mode, dev, NULL);
+}
 EXPORT_SYMBOL(vfs_mknod);
 
 static int may_mknod(umode_t mode)
@@ -4314,12 +4325,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 				security_path_post_mknod(idmap, dentry);
 			break;
 		case S_IFCHR: case S_IFBLK:
-			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, new_decode_dev(dev));
+			error = __vfs_mknod(idmap, path.dentry->d_inode,
+					    dentry, mode, new_decode_dev(dev),
+					    &delegated_inode);
 			break;
 		case S_IFIFO: case S_IFSOCK:
-			error = vfs_mknod(idmap, path.dentry->d_inode,
-					  dentry, mode, 0);
+			error = __vfs_mknod(idmap, path.dentry->d_inode,
+					    dentry, mode, 0,
+					    &delegated_inode);
 			break;
 	}
 out2:

-- 
2.51.0


