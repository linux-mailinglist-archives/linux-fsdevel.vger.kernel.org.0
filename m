Return-Path: <linux-fsdevel+bounces-64478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D31AABE856F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 13:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3844C34FDC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C96B3469EC;
	Fri, 17 Oct 2025 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMpZHhGi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FC3451BE;
	Fri, 17 Oct 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700746; cv=none; b=Glv6tMcBX2G4KnJ3sK3PmAslQJybMGrIXEmAc0g966zjZqOBABAVOCiAe5C4TXCZDQJgMLj9jbBVrfmOYDsseYuzXSSJesqRjcsAXAMWe+RGUABhYOezISJeXdam795ufAG17MOZT2bh5K1A3WGTJg5yGQ9uKO0WO4d4+O+Gf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700746; c=relaxed/simple;
	bh=s4rvzuIbyXzK6y+wPnL+4uRpK7mDo/eer/xGdjtob/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx4fCeXoGCqoxKa21n1HPDtsos3r3oyGrSPOkSYYhQaxRS2aPw1pk8b2MRa2Udds6pH+kNDFdSwQyI7TBbe1ziDiey3rzRtBTMjVw6aCWLFHFbjUUsa7IW1lx+r7SMJ+bpw/2NCxjhLPJ8wq2jCAFMiQ2Y2sF81i9GsyOLuKioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMpZHhGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97545C4CEFE;
	Fri, 17 Oct 2025 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700745;
	bh=s4rvzuIbyXzK6y+wPnL+4uRpK7mDo/eer/xGdjtob/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MMpZHhGimGzVe0IiwpWahv0abICWYOv8gTvTxx/P+V0qoGnQ2DTeBIzxGftH+9921
	 x1rCSAaVDozwbBxHIvk/2okbt3ZvWmRDAinDxIWFlk1Z4Exav3F4IGi1dVUH09aWlK
	 TEt6jx9FyTdA+Kfi85mGl5h2VLX/CQpckB085s+BW6EJAAVuvwadHDslIKIa0ttTIh
	 poeFeOELmG/QIPcGplKwRQTbkkJnixNjdSEBy2oHAcIkaUKbkfvhrwyxeGU4KmFk3r
	 xBLufYrXEpj05rqZyFLI1LTcGQGs82ekcVRra1mVihxMVUSqmlC3gdY0gAM49wWuVJ
	 zn2lQr4EmG/lQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 17 Oct 2025 07:31:53 -0400
Subject: [PATCH v2 01/11] filelock: push the S_ISREG check down to
 ->setlease handlers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-dir-deleg-ro-v2-1-8c8f6dd23c8b@kernel.org>
References: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
In-Reply-To: <20251017-dir-deleg-ro-v2-0-8c8f6dd23c8b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=s4rvzuIbyXzK6y+wPnL+4uRpK7mDo/eer/xGdjtob/k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo8ilA8aL4CnPyfaV9t/SWXvPqdJZ3P0s+8wOA+
 KvLINJfAbCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPIpQAAKCRAADmhBGVaC
 Fd6bEACh6JeUKAw/8CkWtgnXscgMQ+cLyVSGl0oJdySpoPVb1vlmvjA5P2WxQZD2zO+0FTjlB4h
 Yui9nx0a2pn+U/knDhQs0BLYG3Z1FeCw6h6u6HnE7JSo8BJmUgjgtctBiYDDZ7EPs1aHTtTQMxZ
 /ILDU6DBF2lstn0YMUejGJwR70La4VTrS3GOcEBFz2VA+gCr7atugFJ/+JsfSQK0nRbvDtoWRBP
 Lt9UTLpG53FiY+KWI3UhBf861liynfDeqZ7qSS6M7iKgLrdWRJb7sjFRGeP09qpFCnrGwOuyaiQ
 uzhmKOk1C/JdTzFBeC0yBaCYLgn46LhDzKLZ+0xZyCIb/5zmhHVcPB/ET/emOhPrWuC5lmTGCSa
 Y5Iqgw7eZa/bgBMOynaDz/+6oFKceSQm46wCYeiK8TxD/hL3in2GYO+Ak9qttuCnATvOC6LExFB
 6C7kRbmPvpzv2J+37pHafRJva0bPoxuqvUbGCv8zfwMeZ/CHE15Di2M4Kv6on7GcFyIG018j9dV
 QcOcDI7ZEE06fqk9/AfcwBvUqRaRp0JHDgdS22zRZwZ1M/veDjaqHeFSpc36WC26dqReYoPOB1u
 vrRnjKHQImDTRu1hcYSWEs9Pe8bVUlAz3JbC/dxt6lyqwshEKp1zKpL+DLB+flbWKsEc46hy2mi
 MzwrIrAQI5FGPBA==
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
index 05b1fa76e8ccf1e86f0c174593cd6e1acb84608d..03c44c1d9bb631b87a8b67aa16e481d6bb3c7d14 100644
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


