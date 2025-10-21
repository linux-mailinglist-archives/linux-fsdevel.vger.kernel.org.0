Return-Path: <linux-fsdevel+bounces-64954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE4BF75E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2FB19A5C42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008134C9B2;
	Tue, 21 Oct 2025 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf3l4SMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC734C992;
	Tue, 21 Oct 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060396; cv=none; b=h9VWUdt2+P2Ryb94CIJxIhBh9ZRRWnWgGhIv8thyPZSRW4T9a2uzFyWSfQhuafCC2wjR+U6j9r1DAMTItT47ulr9uHKwraev936/CuErCa3sBJc4JFl4Hi7AmEGgg0kaC4uRcWBiOIEFvJBWWW+zH+V3oHCWq8H/UlG17iaqFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060396; c=relaxed/simple;
	bh=MP4W7EqPdZca1WQgHgdKAkKp34XY8wVHuAMOFeV6ZCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km0IYzFR57zxwBA8/ilOh1LJG/p4KW+GKVim/33cGipB6qZ/74+DJlLIQYJ9S0Jb1wC7WTZINZiVj82MUzPYGYgSDNTGyvIb2CosSAO6eEglOFnoOgvue2NHtY0eL3mcW66+ZqNrqeJoizDlkwE5pSfiJgIcA8C8O6HJuxUsNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf3l4SMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145E6C4CEFF;
	Tue, 21 Oct 2025 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060396;
	bh=MP4W7EqPdZca1WQgHgdKAkKp34XY8wVHuAMOFeV6ZCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lf3l4SMdyTbGIsxtiKP/Xx0ZABwQIpdApc1NJXGQmntVpQIzzAKFza3K1VA7kXxm4
	 HYjvdm0TVNs+ee1BMO2jo5gF13v9/VNktCuTNdpi2wyOyDl5ByJurwUV1BqEu3RCoE
	 eE4xPpVqhlL0gPozLtjQmt3P1BsGe9e4UjRZP9IOXto+kKxlere/15qDgE9fpxhpdk
	 4RVlhJXqIQ/0mK9/OSLF4xa4WK7gMo5NrwDVM2b2JM/gQgXEvZjd+N8et6isEDqdFE
	 EIaqLC/D0zPuCJHZnwshjpRfItYxsiCScPIm607n3xXNAojEKKSwILUy1rKK36E74l
	 AVzWeJHM+Lq8g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 21 Oct 2025 11:25:45 -0400
Subject: [PATCH v3 10/13] nfsd: allow filecache to hold S_IFDIR files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-dir-deleg-ro-v3-10-a08b1cde9f4c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7422; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MP4W7EqPdZca1WQgHgdKAkKp34XY8wVHuAMOFeV6ZCs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo96YFC5402XcUQ8VOdabN5K9Rh+lxbOgJldqfZ
 KC7AYLhUtuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaPemBQAKCRAADmhBGVaC
 FSEBD/91FcWSP5VQ1WBORv7jdJJaNXwtg7ox3ryodZI1WmQ5zjn1+uMNhNx6sADVe9Inwrwp6SH
 rlNTPx3oGJSo4/QhE6kcIyaSKZ6LxHxWvzWABGTgOF1Ah5DjTNQeLtCMPs8JsdsP/F1+WvtCiO9
 wDX2mSQjUOShw5zH8VTF6xOOwVKkrnVEc6TxuiD/7s2ixpv0ZjMEjg34Rd0Z5Bv27uYKLqz8h3O
 4GOIdR65LqfCmzpymbzVGhFu94/1jflwEOOXLtfvhAcLchynu9t//FSbKjZBCx8WIna1nGckeTp
 zLnN4vm1ZDanx9n0GSU/yN6wYN6ey+m1dWxrObLy4a9Ci+2pkAoldAxp/qyPRFETKQSebeYqESW
 DXk/5dakZBMJT7+VufGWvd9g3ExpMurHfl8ecfVtKb5KNhop+9uRLL517nEn8TIZpIk+gcRxRvK
 N2NoMhyMUbqN2Z3Z9S0iPP7AY9JVVVkrlLQt3kYKQAxTXWGWtngkzFFc0b3hj3Okq3qMewf38e5
 STE0IZpBkJl4mhWG9i4YuxFSKKj+OpPKT5YODIheRYT1VTUqvon0Hz2rBq9u3E+gbenhbtqb5Tv
 JwRuGi/8csCQeghXNmtRj6FQXWFnh9MQL/h6Lhgu9kGpOlLotXKf8jRVZG1NcAvs1Be7zpd5oVs
 qERMv7ISDjjgCog==
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
index 386f454badce7ed448399ef93e9c8edafbcc4d79..f1c6b6e87d84fa6e1923b44a89baf5183ede54b8 100644
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
index c713ed0b04e0311ab606c5c456c8ce92dd506cce..12309426410f923492e73f6867cd6597a9c0a097 100644
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


