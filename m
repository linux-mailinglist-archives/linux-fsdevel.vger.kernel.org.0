Return-Path: <linux-fsdevel+bounces-64944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A429BF7515
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB7B83541A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1BF343D90;
	Tue, 21 Oct 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgd6jLI9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A0733F8BD;
	Tue, 21 Oct 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060367; cv=none; b=g03I9bW6BrqtqdCMzfWL9sHRGa8Tp3Fbuyp5/Ja8aCzU50QMcjG9in7NBGcqfySJFcsV3Ux6961q7TYqDEmY+5wGI6e9hgg3HGszwRFhNvnHWgjKb1g7JHE+vPsRLqBZncffFO69xtd3t1Ka7zM1RGqrDb2yzhBZ6Sqa6kWTrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060367; c=relaxed/simple;
	bh=dxvpC5CTwlaM82NIyMQ70G3zBp6uBnMFProuC2fkia0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8IJv+vlEhH9DNRBRxTh1P3q1RoBIFtPFMWZWbymruImHGSRsIZ9c4kDayQ/y8MaRo5L7RgoYj6xwKeSJiOIfX+6wUT+cwcBcy+DSUqpRS3pY8JG02bA8ne8m30BXt4vG/f5pjJjqNdP3dgSynM7JQOT1sLBhKoI8PFbpkM97/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgd6jLI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7000DC4CEF1;
	Tue, 21 Oct 2025 15:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060365;
	bh=dxvpC5CTwlaM82NIyMQ70G3zBp6uBnMFProuC2fkia0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cgd6jLI9KhRmkTrcC91F3FAzaNa22cpBHHtb/iHHqslEn4zxhJNvly48bNPs9ucfK
	 6aF4gw2e3vBB2Ns1dOOKWYdjjwYJxVgLOaqfq8xSxCwyZeJRgsYvmH9xzm2EdlM41G
	 JEJKGP6i+F1qIxSrAozELSdqOWGvax7S4LqyOctQwx0eGqTwbGu0AHKRxZl5jofamp
	 iTkpSgZFBZ4owLDY3sec8abljxPtZ0fEW6y9wOhEkmmwriQ0ekA9AidJllJ8bMH1DA
	 YjDhopKBEowwz4YHPEyUM5KKSDAgW3uf7AMBKswsR6A5hC07JdezA81NlqOxlKEoCZ
	 oiM8W+RuRrgVQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:36 -0400
Subject: [PATCH v3 01/13] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-1-a08b1cde9f4c@kernel.org>
References: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
In-Reply-To: <20251021-dir-deleg-ro-v3-0-a08b1cde9f4c@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dxvpC5CTwlaM82NIyMQ70G3zBp6uBnMFProuC2fkia0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YEVYLznz73RG2SG2lZYGviOe6oYp7vdP463
 dBJqnqKDm+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBAAKCRAADmhBGVaC
 FbNuD/9rHiRNhZ4IMbW65OW8jit0py4NylV+LNDh5XD1QLhkZtGe5K89UxF7Bm37UL9Xrgf/zzk
 JUWRS5hfZfnJsAWCDKiUIGBT3eNOAn1ET5tMB1DjXZoODfNxl0Huis1dbyq2nVfkq5jN5DajtEQ
 qnZosPPdiIgP22s/4jcILFMY14Axa7/1nRFcLMpB2sQXwL2OVQtYJD4Hv50U/dQ0i4jRdhYkmPM
 dVR+WRKMCJcmAc4IaOhGWBKiol43Pyy0RqrqdITgOC4P9DZoBm1EMwgBRSFPdRSqioB13w+o1to
 LWbyOYCEP+uaf1kKxAiFSBvUBQb0IDcgBsyUyYd1AR128p0CvqjIaYbJ6SRfZi/FsV0DmsVE+Ir
 yvJwjG1ANo/Zsv6Lrzmxu3xNzyZFRa2ABikyi90SJKXoi7z7nNAndVwpkK4L7h3ZCKFs1sEs0O7
 jXVjapzr3UmVwg4bvtDGLRTMWbXYOtyPa64rI9T0hial9saTZZ5LwwWUTPQc447CwB1gIeGwJyp
 nfMjMouvNOTFHGYuwXU14uHMhHKZCpIF9VFLmylMPZQc4Hhp7gFBKdv4hsXBDGnhg8X6OpCTKLe
 hHA8v5f6B2D49NiiGlB/NuO+CvmDl3RzgJVT2TFnoLGXV6H9AGRd7rFrklCSPtmDp1djAoiEMci
 DH1XyNEa4/PsP/Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When nfsd starts requesting directory delegations, setlease handlers may
see requests for leases on directories. Push the !S_ISREG check down
into the non-trivial setlease handlers, so we can selectively enable
them where they're supported.

FUSE is special: It's the only filesystem that supports atomic_open and
allows kernel-internal leases. atomic_open is issued when the VFS
doesn't know the state of the dentry being opened. If the file doesn't
exist, it may be created, in which case the dir lease should be broken.

The existing kernel-internal lease implementation has no provision for
this. Ensure that we don't allow directory leases by default going
forward by explicitly disabling them there.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dir.c          | 1 +
 fs/locks.c             | 5 +++--
 fs/nfs/nfs4file.c      | 2 ++
 fs/smb/client/cifsfs.c | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a132e7cbb88121e7db7fb504d57d3c..667774cc72a1d49796f531fcb342d2e4878beb85 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2230,6 +2230,7 @@ static const struct file_operations fuse_dir_operations = {
 	.fsync		= fuse_dir_fsync,
 	.unlocked_ioctl	= fuse_dir_ioctl,
 	.compat_ioctl	= fuse_dir_compat_ioctl,
+	.setlease	= simple_nosetlease,
 };
 
 static const struct inode_operations fuse_common_inode_operations = {
diff --git a/fs/locks.c b/fs/locks.c
index 04a3f0e2072461b6e2d3d1cd12f2b089d69a7db3..0b16921fb52e602ea2e0c3de39d9d772af98ba7d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1929,6 +1929,9 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, int arg, struct file_lease **flp,
 			void **priv)
 {
+	if (!S_ISREG(file_inode(filp)->i_mode))
+		return -EINVAL;
+
 	switch (arg) {
 	case F_UNLCK:
 		return generic_delete_lease(filp, *priv);
@@ -2018,8 +2021,6 @@ vfs_setlease(struct file *filp, int arg, struct file_lease **lease, void **priv)
 
 	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
 		return -EACCES;
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
 	error = security_file_lock(filp, arg);
 	if (error)
 		return error;
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 7f43e890d3564a000dab9365048a3e17dc96395c..7317f26892c5782a39660cae87ec1afea24e36c0 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -431,6 +431,8 @@ void nfs42_ssc_unregister_ops(void)
 static int nfs4_setlease(struct file *file, int arg, struct file_lease **lease,
 			 void **priv)
 {
+	if (!S_ISREG(file_inode(file)->i_mode))
+		return -EINVAL;
 	return nfs4_proc_setlease(file, arg, lease, priv);
 }
 
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 4f959f1e08d235071a151c1438c753fcd05099e5..1522c6b61b48c05c93f2bedeab0d35b6d85378e2 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1149,6 +1149,9 @@ cifs_setlease(struct file *file, int arg, struct file_lease **lease, void **priv
 	struct inode *inode = file_inode(file);
 	struct cifsFileInfo *cfile = file->private_data;
 
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
 	/* Check if file is oplocked if this is request for new lease */
 	if (arg == F_UNLCK ||
 	    ((arg == F_RDLCK) && CIFS_CACHE_READ(CIFS_I(inode))) ||

-- 
2.51.0


