Return-Path: <linux-fsdevel+bounces-63982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E34BD3D9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 17:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8FB04FDB7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350330E0F9;
	Mon, 13 Oct 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9PYadLY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30B430E0E2;
	Mon, 13 Oct 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366931; cv=none; b=FOxkEtwVQdZO5bY2CCL1GdYfJX/rKurs5zfJvmL5+/g3Dj7CZzfPivS4nGzYwg7X7Vnyr8teS3gpv+hEeSBp/k9/WR11VZHO8M6r+A5Ob6O6aHuV1jZ+j4Ymq6Joat4woHcr8yZFHg0+/iTP2LT5CQCA2vsVkBFPltyW2WLvfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366931; c=relaxed/simple;
	bh=kQ3kwVXghyQcw4aroQIwAfURWIu333iEGSOIpiFKuOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=csWovrDD6fj3AnQGZnOBL/XKUQNgsnZc8Y0VrcTbEA1GWLcQ+m651CFuqrOknrb6jWCCT8CkGUfUdjZYDt4tKStT6dBkWQ9lfzi8YFZxedX2wxZZzAZ+l6OWqrKE4iGDwsMiAW4yGGufR/rELWy6RbTfuIQY/ayQGTWqHKNAFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9PYadLY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22357C4CEFE;
	Mon, 13 Oct 2025 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366930;
	bh=kQ3kwVXghyQcw4aroQIwAfURWIu333iEGSOIpiFKuOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G9PYadLYjucUApJfGHyrp9bsPygjU/VYs6TgIuisMy6gcBaV9Usd9DGViUjT+wOvl
	 Kxp/gRwo0Og3OTX7w2qHRjLjr9jSruFJ8sE6JG4n+hEk91DycUUxBksUzKniPkp0w0
	 fe1sqnnqxnUMAn4dqGI3ovIkOzX/pioziRyqPxWixHCg785nysNA0tgMIUkl8g7SEG
	 eEBdhd67RCoUtLjhNBbydjcvp3DWoCQb7BxHCbxstI0r1dRcgmpVrakImiGhrw74WJ
	 chXdh+PUcDAd8EjWl4THhblyRqpsJF+spMsirnNXlzBvxhl+k3N8chtPTd6ReHdHaB
	 /iw1B5DQ90W/w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:08 -0400
Subject: [PATCH 10/13] nfsd: allow filecache to hold S_IFDIR files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-10-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6750; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kQ3kwVXghyQcw4aroQIwAfURWIu333iEGSOIpiFKuOI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7RErtdhkjg1yGfBHVs1pGPOHPYtO0JxXJ/Jcj
 ej6jGcMMLuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RKwAKCRAADmhBGVaC
 FeYHD/9UEjXQAOETdxKwg2Kze+p9+gqVQbebyPRUxP6lwlXeA6toCaD7aMmGy17ukjntEeFCIb1
 qZrItL0eqjEKBmmd1jgqLtf5UKcLmL9Qkeo2FTJCs02sD9VavVlpy8tqQFykbo3lpRk+AtVYKhf
 XgLgs0RD+eQj5HAOamRmO691Iu09AmHE04B34ChoVWBGIfSZcn2VY01ir367ydmcZ3ijGeKmTPB
 IA8hs1Hl93duddUk90bbaOiHSRp+SpuTU+4NhJv2kqHdwcRfnexcdgPPk+UXVhQ52G5jqRHchkU
 nJhI2gVH6e2DVT9y6SHtbhyt54/DtETsOx+kW8BK7rkka6rRJ3d3DgFs6qJja9elxs8zJKzm04Y
 W2nHrw/QdmaNVXJbJOCaFlnQV7rd6aU6Cl4u7WnJgZOTWHKjy2rb0mfGmZIgH+yVZMMT5MZ6j6z
 p/H+2fE6Ro5dcw4JaffWmf0jVRFgf4A9PxrRZYbnn3RU9M7wY8KaBXsUKwPRCmwI0SZH02z2w3T
 7/S6lFb/T5iBWiGfquuXXlr9vjfcWl0GFe+cWjI55tGJ9vF76M+QgcinObWQ6SawIOAd7VY/3No
 eqJAVHnipXGog5guRQbYSy7neMdVrAoeAqvnAET2B80lZ3ucoSeX4IeZU+KFblFkGLuha0xHnGN
 HDBXDlt6C8yz7vw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The filecache infrastructure will only handle S_ISREG files at the
moment. Plumb a "type" variable into nfsd_file_do_acquire and have all
of the existing callers set it to S_ISREG. Add a new
nfsd_file_acquire_dir() wrapper that we can then call to request a
nfsd_file that holds a directory open.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 50 ++++++++++++++++++++++++++++++++++++++------------
 fs/nfsd/filecache.h |  2 ++
 fs/nfsd/vfs.c       |  5 +++--
 fs/nfsd/vfs.h       |  2 +-
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a238b6725008a5c2988bd3da874d1f34ee778437..c2aa8357a1d9c136b55b2dbcb8de77d77f86b7c2 100644
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
@@ -1184,7 +1184,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			status = nfs_ok;
 			trace_nfsd_file_opened(nf, status);
 		} else {
-			ret = nfsd_open_verified(fhp, may_flags, &nf->nf_file);
+			ret = nfsd_open_verified(fhp, type, may_flags, &nf->nf_file);
 			if (ret == -EOPENSTALE && stale_retry) {
 				stale_retry = false;
 				nfsd_file_unhash(nf);
@@ -1246,7 +1246,7 @@ nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
 	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
-				    fhp, may_flags, NULL, pnf, true);
+				    fhp, may_flags, NULL, S_IFREG, true, pnf);
 }
 
 /**
@@ -1271,7 +1271,7 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
 	return nfsd_file_do_acquire(rqstp, SVC_NET(rqstp), NULL, NULL,
-				    fhp, may_flags, NULL, pnf, false);
+				    fhp, may_flags, NULL, S_IFREG, false, pnf);
 }
 
 /**
@@ -1314,8 +1314,8 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 	const struct cred *save_cred = get_current_cred();
 	__be32 beres;
 
-	beres = nfsd_file_do_acquire(NULL, net, cred, client,
-				     fhp, may_flags, NULL, pnf, false);
+	beres = nfsd_file_do_acquire(NULL, net, cred, client, fhp, may_flags,
+				     NULL, S_IFREG, false, pnf);
 	put_cred(revert_creds(save_cred));
 	return beres;
 }
@@ -1344,7 +1344,33 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
index 858485c76b6524e965b7cbc92f67c1a4eb19e34e..abfa8f15fb5f8325885c7a6734e684728e725f93 100644
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
index fa46f8b5f132079e3a2c45e71ecf9cc43181f6b0..ded2900d423f80d33fb6c8b809bc5d9fc842ebfd 100644
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
2.51.0


