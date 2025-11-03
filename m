Return-Path: <linux-fsdevel+bounces-66789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 05928C2BE2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87A52349144
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F93318120;
	Mon,  3 Nov 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2AURiXt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E4316908;
	Mon,  3 Nov 2025 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174419; cv=none; b=s9CfYpEkizpOOJ0nSMNzWseZ32+nXhV05CTws+Xv/TYPrpMAsgDTymHwlLR3aHoLpgG+Ct+sj7EFMZyhzw9oaK/u3C3v7aq2iGfBfsl5TNuoXc8KkYTjjQt+ldZ5RJnvkm/RKbZo1cCY+m2YW7UwIxg1hJmZKg8whBi3HH4XDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174419; c=relaxed/simple;
	bh=YhL5OvzR8GSJpMDvQ8tbMUForHK8kp34QnTLaEJR2wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmVoFcKdjFHp1aU8b3i7MHzTLKyhLV/UxEIVN5cz1GgooZ6/vem1VUOFnMxhAPW+upsmx6p8Jvyc3tWt/7J1GDz1u+bHUVxeAlqm3AyVrM6sxZLqIGLVgB6d6O7jfcggGwvKlx/5MwA3aETRaYA4dWbQdhZb29sJMkFKVN3jswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2AURiXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C9FC16AAE;
	Mon,  3 Nov 2025 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174418;
	bh=YhL5OvzR8GSJpMDvQ8tbMUForHK8kp34QnTLaEJR2wE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I2AURiXtC+hFf4PwdxLP4aL6s+W6oTHRI+Vt47k4cvN74/zKr1mC5v2481ePxuWrd
	 Wl7GlsOJ4K4J1Vnhm2qpprjSahehHTqETQ4MadbskvxJQyFqcCAZ6bCcaUgx/VRZ3t
	 zr3ruydRMrbQfF+jMMgKIk2TP1mH/ULtFcMxGIsVE9MwsKqRESEk3iRJBuX0gXxQv5
	 bLstOdOUO7MUBEXij2FTInqYr/6kPIQjdVUQFsytUaxj83fL3E329Fu/+x677TPUsd
	 POwppa8kfKwgYQ+tLfmWY6eKd7vMVG7T5ByuFfWfv7dt8grm+oj5Njbgb+yPF+fcxe
	 4Dn0P7T8tGeSw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Nov 2025 07:52:42 -0500
Subject: [PATCH v4 14/17] nfsd: allow filecache to hold S_IFDIR files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dir-deleg-ro-v4-14-961b67adee89@kernel.org>
References: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
In-Reply-To: <20251103-dir-deleg-ro-v4-0-961b67adee89@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7422; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YhL5OvzR8GSJpMDvQ8tbMUForHK8kp34QnTLaEJR2wE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpCKWeczgx1Z+RTzva+DQqLRnYoPMZ++BxuPOcP
 PjJUuDNuemJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaQilngAKCRAADmhBGVaC
 FUcREACPZg/hOfAPtSpgqZTOoGfLPBrjfAULd07qptKhcWtQqcxl0YuZLXcqiB0EV9arND8Bh3j
 Tg2QRYMXRg/y/KMoyns4SbgZHk19rRlK4a6cE4B8AD2u/GZUONbef5fRIYNL3Z/ZYT3lVwAYfx0
 SXhUrPppYnCiKq0gh4Hx2y2ZM/OZSkr6GuMUxGOzpRtHtWZJgh3fdHxdNcWqQdk31T8p/uypEBZ
 B+cE7cAYzIQ+p4vLm52YQiUucmXuCeotCOEp9o5odD8mIZHwkS1gOHv+0YTu/PvIHLwIB+K/Gqt
 faTkBW6DsG7Y2yHpikaAQuvn73oHxnx0MU9c9Rm3o8mZoy9BJgODcmL++7QXGqKWdDYUKgQrZ9H
 Lr6Jdd3rOznGLTfaxE9Jd+2AzQslvNzxRrMYdHp2MTGU1BmyDSKX4MmGkXV5YR8bEKikV/vIC8l
 EJ7i96VsQ+2c6RvjvDsDhpiDR3rzBrYdHjANu632DcU7O2y7UU0rUjT8zFpHYDe72qQ/Sm7bWVf
 nerOd20fVcuypMl3wmldE71VAJncbVX6BI1bFOXLXbfs2WPVVQKeXCSpUmZolJcCAux/A60NFON
 sSajyAvCCpLh4af4jTFwT2t3F1rGFWDPOyktFRce2RqKtEt5afei1ZIkovx5rjWqxE/9S97Op1o
 6UHjFBSpc1wUvDw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The filecache infrastructure will only handle S_IFREG files at the
moment. Directory delegations will require adding support for opening
S_IFDIR inodes.

Plumb a "type" argument into nfsd_file_do_acquire() and have all of the
existing callers set it to S_IFREG. Add a new nfsd_file_acquire_dir()
wrapper that nfsd can call to request a nfsd_file that holds a directory
open.

For now, there is no need for a fsnotify_mark for directories, as
CB_NOTIFY is not yet supported. Change nfsd_file_do_acquire() to avoid
allocating one for non-S_IFREG inodes.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 57 ++++++++++++++++++++++++++++++++++++++++-------------
 fs/nfsd/filecache.h |  2 ++
 fs/nfsd/vfs.c       |  5 +++--
 fs/nfsd/vfs.h       |  2 +-
 4 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a238b6725008a5c2988bd3da874d1f34ee778437..93798575b8075c63f95cd415b6d24df706ada0f6 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1086,7 +1086,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 		     struct auth_domain *client,
 		     struct svc_fh *fhp,
 		     unsigned int may_flags, struct file *file,
-		     struct nfsd_file **pnf, bool want_gc)
+		     umode_t type, bool want_gc, struct nfsd_file **pnf)
 {
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
 	struct nfsd_file *new, *nf;
@@ -1097,13 +1097,13 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 	int ret;
 
 retry:
-	if (rqstp) {
-		status = fh_verify(rqstp, fhp, S_IFREG,
+	if (rqstp)
+		status = fh_verify(rqstp, fhp, type,
 				   may_flags|NFSD_MAY_OWNER_OVERRIDE);
-	} else {
-		status = fh_verify_local(net, cred, client, fhp, S_IFREG,
+	else
+		status = fh_verify_local(net, cred, client, fhp, type,
 					 may_flags|NFSD_MAY_OWNER_OVERRIDE);
-	}
+
 	if (status != nfs_ok)
 		return status;
 	inode = d_inode(fhp->fh_dentry);
@@ -1176,15 +1176,18 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 
 open_file:
 	trace_nfsd_file_alloc(nf);
-	nf->nf_mark = nfsd_file_mark_find_or_create(inode);
-	if (nf->nf_mark) {
+
+	if (type == S_IFREG)
+		nf->nf_mark = nfsd_file_mark_find_or_create(inode);
+
+	if (type != S_IFREG || nf->nf_mark) {
 		if (file) {
 			get_file(file);
 			nf->nf_file = file;
 			status = nfs_ok;
 			trace_nfsd_file_opened(nf, status);
 		} else {
-			ret = nfsd_open_verified(fhp, may_flags, &nf->nf_file);
+			ret = nfsd_open_verified(fhp, type, may_flags, &nf->nf_file);
 			if (ret == -EOPENSTALE && stale_retry) {
 				stale_retry = false;
 				nfsd_file_unhash(nf);
@@ -1246,7 +1249,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
 	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
-				    fhp, may_flags, NULL, pnf, true);
+				    fhp, may_flags, NULL, S_IFREG, true, pnf);
 }
 
 /**
@@ -1271,7 +1274,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
 	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
-				    fhp, may_flags, NULL, pnf, false);
+				    fhp, may_flags, NULL, S_IFREG, false, pnf);
 }
 
 /**
@@ -1314,8 +1317,8 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 	const struct cred *save_cred = get_current_cred();
 	__be32 beres;
 
-	beres = nfsd_file_do_acquire(NULL, net, cred, client,
-				     fhp, may_flags, NULL, pnf, false);
+	beres = nfsd_file_do_acquire(NULL, net, cred, client, fhp, may_flags,
+				     NULL, S_IFREG, false, pnf);
 	put_cred(revert_creds(save_cred));
 	return beres;
 }
@@ -1344,7 +1347,33 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 struct nfsd_file **pnf)
 {
 	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
-				    fhp, may_flags, file, pnf, false);
+				    fhp, may_flags, file, S_IFREG, false, pnf);
+}
+
+/**
+ * nfsd_file_acquire_dir - Get a struct nfsd_file with an open directory
+ * @rqstp: the RPC transaction being executed
+ * @fhp: the NFS filehandle of the file to be opened
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * The nfsd_file_object returned by this API is reference-counted
+ * but not garbage-collected. The object is unhashed after the
+ * final nfsd_file_put(). This opens directories only, and only
+ * in O_RDONLY mode.
+ *
+ * Return values:
+ *   %nfs_ok - @pnf points to an nfsd_file with its reference
+ *   count boosted.
+ *
+ * On error, an nfsstat value in network byte order is returned.
+ */
+__be32
+nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		      struct nfsd_file **pnf)
+{
+	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL, fhp,
+				    NFSD_MAY_READ|NFSD_MAY_64BIT_COOKIE,
+				    NULL, S_IFDIR, false, pnf);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index e3d6ca2b60308e5e91ba4bb32d935f54527d8bda..b383dbc5b9218d21a29b852572f80fab08de9fa9 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -82,5 +82,7 @@ __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 			       struct auth_domain *client, struct svc_fh *fhp,
 			       unsigned int may_flags, struct nfsd_file **pnf);
+__be32 nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index edcc8c05e435a4abba27dd2eb07facf4b5ed3243..e94747ae5897b1a33e2d09b7a3cbf6f5ad1ca417 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -959,15 +959,16 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 /**
  * nfsd_open_verified - Open a regular file for the filecache
  * @fhp: NFS filehandle of the file to open
+ * @type: S_IFMT inode type allowed (0 means any type is allowed)
  * @may_flags: internal permission flags
  * @filp: OUT: open "struct file *"
  *
  * Returns zero on success, or a negative errno value.
  */
 int
-nfsd_open_verified(struct svc_fh *fhp, int may_flags, struct file **filp)
+nfsd_open_verified(struct svc_fh *fhp, umode_t type, int may_flags, struct file **filp)
 {
-	return __nfsd_open(fhp, S_IFREG, may_flags, filp);
+	return __nfsd_open(fhp, type, may_flags, filp);
 }
 
 /*
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 0c0292611c6de3daf6f3ed51e2c61c0ad2751de4..09de48c50cbef8e7c4828b38dcb663b529514a30 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -114,7 +114,7 @@ __be32		nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
-int		nfsd_open_verified(struct svc_fh *fhp, int may_flags,
+int		nfsd_open_verified(struct svc_fh *fhp, umode_t type, int may_flags,
 				struct file **filp);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,

-- 
2.51.1


