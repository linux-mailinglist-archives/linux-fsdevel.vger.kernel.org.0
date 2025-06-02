Return-Path: <linux-fsdevel+bounces-50338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F0ACB0A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9738116BCE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E454422B8CE;
	Mon,  2 Jun 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efnvxsvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FE2221FB1;
	Mon,  2 Jun 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872959; cv=none; b=AJWdjqhIbNS64PFBps06tIAhvDMxZ3Cb8calJHaxyRaguaAUVwGi36vJAfqC4fA1h8OcliWePYJ8lhP1Vl/TnwXCawz2x5UgBzIuipGbGphDNU17wiYylWSaMYAtdIHjy9SXcrZDnq05eHwY5Stfnxs88BCRe/saqquVGwdRlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872959; c=relaxed/simple;
	bh=LL9hPGs8JOfm/3852E6F/kJJzUCWzKIPIPUHPbH2s5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kK8Dbulkiq6WRXTf05tAS5k/6bXn31yuC6rh98rz2f9cRuoEDBEbvd28dqT/Af6etQpL5h0eOnwMw5PJ902tWPCSIo/3kIvR1ivoQ80d59f8jDilJzWtpciHwzlUwDYY5KH0l+6X2dmFqb6fjDlZI5w8yOrnp+uJ6XVXR9cYmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efnvxsvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2D2C4CEF4;
	Mon,  2 Jun 2025 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748872959;
	bh=LL9hPGs8JOfm/3852E6F/kJJzUCWzKIPIPUHPbH2s5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=efnvxsvP/gIr20jjHLqh+gpIs7S96DLp3GDq91bcayoh75mrDrGkmXY6pN2dPCtfq
	 UbARkMn7A1SAkfVCzW/q32dspvaeSJJTnvIJyLyBmUzPB7OI255l6xWrni2GRZ49jT
	 I+hZhrt22waCy+44t1+KeLeJjuHEbV5qMdlljoiXcqOKvFJOH3geUwXT1Px0we/ZHQ
	 AgV1ctvlE2FlP3fZFI/6gAM3z5irpbWdWhCylIK67852WIdjLzzdpjFsWamr2XTZya
	 27L4TcAbjNGhpXXd+Sk2cijJLf6ZncJg2yg/slAwmzmwaAvpEsQPkLWB4u51hos+B1
	 NDjWSTz01qjXA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:01:51 -0400
Subject: [PATCH RFC v2 08/28] vfs: make vfs_mknod break delegations on
 parent directory
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-8-a7919700de86@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LL9hPGs8JOfm/3852E6F/kJJzUCWzKIPIPUHPbH2s5s=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7lToSEk9cSNhHcBXPahgPt6wLf6CzscMey/
 eMXhBKLUXKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u5QAKCRAADmhBGVaC
 FVfREACKsgoGrCzFIaWVTptASQ5M/6y05BlTGkJQFFPdNN2q6m+UqXQjkMAPF3DkJ2nOAHlTzAq
 rvvcaQ+C/EUknWfJqx+vTi+KgKyMBmBF2DTnDrS5Q+1PcfPLtJRuJ28936Z0udb5Q0+7vrKHsXa
 Iuq6NtLNXP7vtbyc1w/F0CYQBr4b0XOI6Bc1M48L8WHPbKKGnv1fkcanNzOpEBhl13m+oSNbgV3
 SUfIWYJKDorozx9s8TwYhBxwCsl9hY08wfWFRxUGy6fe5wZ+xbqaVe+K2zsMDs52LXOH4DRZ8DF
 jL+9GRNLIMtpHFBtgx33BOA+MiQbHO9QbkRlBIT7z9Ezu3Pyk5EQIiIONDSeL4gbe4Ev22qHWxo
 Q036DtyWwHgKYUoOKAvzEk1fT1PzKAaPa9Nf30mX92cFnUnWe5DDm/p/eXNx+SgO4sFdT6lGHiU
 xN7q6hXGOXPJFF3/8ThHB+wlkAcUnZ5BMPB+uVktEyIV8WyOeYSw3ZriFKLqT6Yjfcy3SUJI6iY
 67H42x0jw0q3KHhX+6MLIIC3zv4fv0OrZ8WlI/Zi+9emqn/s2Vu/AuM9EgEbBx1SMiEz/CMkx2E
 JbUshOjeUJsCAYBLn3dOEi5mnNRKZst2sjvZBAcBKnUjGSqyCRtFmtCmHtlvujwKhBBDpmppNhC
 rVMqk36Ds9MAeZg==
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
index 7b27a9bc4616d3880d6365f1e37f13f7f45bc2c9..8f0517ade308134ed6566566d9b575c4e9fb0d4e 100644
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
2.49.0


