Return-Path: <linux-fsdevel+bounces-14498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10EB87D1DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7186A1F2173E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D035B1F1;
	Fri, 15 Mar 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQD40j7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD475A781;
	Fri, 15 Mar 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521619; cv=none; b=eN5jKVqTGS1qWA9N1mfrZJXCzUSUgTSuaEAxYBxpujUVKGysD8HSs4rQ7ckb1EG/z5XNW11Anh2EO09zXeRDlBTcrYeKx3FVV0qGDvZmcELSXVw9+FJ3e30VuzYM8WhuopuObZx+2x9EnamYXzpbvLCt5k4MJwqeBJra8OJPjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521619; c=relaxed/simple;
	bh=CD3w7e6TBoYw/V9/hui6oM/jYFbSpiUuU+kvpTyfg1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s+D/zI29Sbb2zzagHrwVPSlBFfRIyCAu3lfiE7byEPZOfiWhn/20Ib2S1U+OV+DP0Hsvu9NwNEWzkWqqlJA6VeYiKk4YjSr0CKnPWTpQFQtKze2V7dtBtqPaZQG3Xjo286WEVwUuzIYfbWWs9L2iC5POiA25kQVDH9Cuh1q/SuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQD40j7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1999BC433B2;
	Fri, 15 Mar 2024 16:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521619;
	bh=CD3w7e6TBoYw/V9/hui6oM/jYFbSpiUuU+kvpTyfg1Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dQD40j7oid4/iuqhNMERS4VZ8nm5mP6XM9EX3RiRv0tBpAQQMkb/yqt8ASKuu4vE6
	 oV2uEStJ3uDcq3baGTKj+9aprALhb1rt4Hcvlu63fgKEb8MzQL1ueyrzA2xJRSBIsm
	 YbZPNoQb7ox2bqmeCwkN4H0I92beN/3FdL+Umia4DFMAvr+tKSJR3aYHYwdJPz2PBA
	 PpMP6Q2xokY4n6Rw/fKBihtuOQY4+HW0RhLmNkw05g7BGWdW7RqyH/S8exqkBz8UrF
	 Zpa9NWFJsAHxzKRW9gKlj9H1If7ty5wPT1XWM11zpf0opiUAtWtU7U7oCbkfzm8cQm
	 +VQmmq2JbeA/w==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:01 -0400
Subject: [PATCH RFC 10/24] nfsd: allow filecache to hold S_IFDIR files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-10-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5740; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=CD3w7e6TBoYw/V9/hui6oM/jYFbSpiUuU+kvpTyfg1Q=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HztVEGIOXi32wZD0v7/ZrnQr+jTt63ZR0Qxq
 GOaYid8YHeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87QAKCRAADmhBGVaC
 FcAjEACpdhaheJd+4qxrhuIClBQkjkXswazHDJvdD5jbGO4xW+pKfm0kQ/mijipJKWSgpa/jVQd
 9CoTxap3ZI+GUmALtkgolvV/Wdp6NN8/N3tf0DgNETc6QGxa6IlhwQ/6HB1HZpBx1FqyUKbdCN7
 jdAbAfpNXoaJqD6Rf1Awez2tGS6fFSxPgkhhnUWD50CqXYQ7O4JMrqiOrAhKoO8RFlIa7RHxEIb
 F/SlaUSAg8k3kMCS/mztNVFAc21L8LoYZExNcNSEgJkA1Py2TrqIAxOjqqYZp8PRcxJg+c1BW2z
 4+bVisvcqAxDsGoN59iYxmmeZCW2frrI5rWXWH0zKzsLQ5M53BjCG6iqpSzXaqfyb4mN0mOwNX9
 W8iS30S5p1Mg4IWhr986l0VHATmJ000GHDOlg0iDpNVCaqTn4hbYh+uU9qPx2Kg9PbSLnR6mw4R
 5gaYwYNzlDdi3FOCoysnIqCwgyuis2ctVx/6SY72an9XGgn/oWGYH6GJI9r2fsC5uTzcULWRP9d
 PnWhFJotKKf0YxLIFn25k8KOUnva+saIhc4y/gdOvdas45jOJCts0SxbTkymK22OuboycjH+x1G
 HbHl/pwaSA0ZqUWYn4sdStmSfSahIxUpCNpMyHPGCQhkeiGLxrhzd+4+UkA7eeOI78XrhHymL+5
 92N5qHz4Odc34eg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The filecache infrastructure will only handle S_ISREG files at the
moment. Plumb a "type" variable into nfsd_file_do_acquire and have all
of the existing callers set it to S_ISREG. Add a new
nfsd_file_acquire_dir() wrapper that we can then call to request a
nfsd_file that holds a directory open.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 37 +++++++++++++++++++++++++++++++------
 fs/nfsd/filecache.h |  2 ++
 fs/nfsd/vfs.c       |  5 +++--
 fs/nfsd/vfs.h       |  2 +-
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ddd3e0d9cfa6..ba66d571d567 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -979,7 +979,7 @@ nfsd_file_is_cached(struct inode *inode)
 static __be32
 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct file *file,
-		     struct nfsd_file **pnf, bool want_gc)
+		     umode_t type, bool want_gc, struct nfsd_file **pnf)
 {
 	unsigned char need = may_flags & NFSD_FILE_MAY_MASK;
 	struct net *net = SVC_NET(rqstp);
@@ -991,7 +991,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	int ret;
 
 retry:
-	status = fh_verify(rqstp, fhp, S_IFREG,
+	status = fh_verify(rqstp, fhp, type,
 				may_flags|NFSD_MAY_OWNER_OVERRIDE);
 	if (status != nfs_ok)
 		return status;
@@ -1083,7 +1083,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			trace_nfsd_file_opened(nf, status);
 		} else {
 			ret = nfsd_open_verified(rqstp, fhp, may_flags,
-						 &nf->nf_file);
+						 type, &nf->nf_file);
 			if (ret == -EOPENSTALE && stale_retry) {
 				stale_retry = false;
 				nfsd_file_unhash(nf);
@@ -1139,7 +1139,7 @@ __be32
 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, S_IFREG, true, pnf);
 }
 
 /**
@@ -1163,7 +1163,7 @@ __be32
 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, S_IFREG, false, pnf);
 }
 
 /**
@@ -1189,7 +1189,32 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 unsigned int may_flags, struct file *file,
 			 struct nfsd_file **pnf)
 {
-	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
+	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, S_IFREG, false, pnf);
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
+		  struct nfsd_file **pnf)
+{
+	return nfsd_file_do_acquire(rqstp, fhp, NFSD_MAY_READ|NFSD_MAY_64BIT_COOKIE,
+				    NULL, S_IFDIR, false, pnf);
 }
 
 /*
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index c61884def906..de29a1c9d949 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -65,5 +65,7 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 __be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct file *file,
 		  struct nfsd_file **nfp);
+__be32 nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index fe088e7c49c8..a8313bba2a6f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -950,6 +950,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
  * nfsd_open_verified - Open a regular file for the filecache
  * @rqstp: RPC request
  * @fhp: NFS filehandle of the file to open
+ * @type: S_IFMT inode type allowed (0 means any type is allowed)
  * @may_flags: internal permission flags
  * @filp: OUT: open "struct file *"
  *
@@ -957,9 +958,9 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
  */
 int
 nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp, int may_flags,
-		   struct file **filp)
+		   umode_t type, struct file **filp)
 {
-	return __nfsd_open(rqstp, fhp, S_IFREG, may_flags, filp);
+	return __nfsd_open(rqstp, fhp, type, may_flags, filp);
 }
 
 /*
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index c60fdb6200fd..c7f0349c179e 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -105,7 +105,7 @@ int 		nfsd_open_break_lease(struct inode *, int);
 __be32		nfsd_open(struct svc_rqst *, struct svc_fh *, umode_t,
 				int, struct file **);
 int		nfsd_open_verified(struct svc_rqst *rqstp, struct svc_fh *fhp,
-				   int may_flags, struct file **filp);
+				   int may_flags, umode_t type, struct file **filp);
 __be32		nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct file *file, loff_t offset,
 				unsigned long *count,

-- 
2.44.0


