Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E321D527309
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiENQiW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiENQiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:38:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1C2D1DC;
        Sat, 14 May 2022 09:38:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13CA0B80AF1;
        Sat, 14 May 2022 16:38:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8536FC34113;
        Sat, 14 May 2022 16:38:14 +0000 (UTC)
Subject: [PATCH v2 8/8] NFSD: Instantiate a struct file when creating a
 regular NFSv4 file
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Sat, 14 May 2022 12:38:13 -0400
Message-ID: <165254629346.2361.2854636099340313544.stgit@bazille.1015granger.net>
In-Reply-To: <165254610700.2361.2480451215356922637.stgit@bazille.1015granger.net>
References: <165254610700.2361.2480451215356922637.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There have been reports of races that cause NFSv4 OPEN(CREATE) to
return an error even though the requested file was created. NFSv4
does not provide a status code for this case.

To mitigate some of these problems, reorganize the NFSv4
OPEN(CREATE) logic to allocate resources before the file is actually
created, and open the new file while the parent directory is still
locked.

Two new APIs are added:

+ Add an API that works like nfsd_file_acquire() but does not open
the underlying file. The OPEN(CREATE) path can use this API when it
already has an open file.

+ Add an API that is kin to dentry_open(). NFSD needs to create a
file and grab an open "struct file *" atomically. The
alloc_empty_file() has to be done before the inode create. If it
fails (for example, because the NFS server has exceeded its
max_files limit), we avoid creating the file and can still return
an error to the NFS client.

BugLink: https://bugzilla.linux-nfs.org/show_bug.cgi?id=382
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Tested-by: JianHong Yin <jiyin@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   51 ++++++++++++++++++++++++++++++++++++++++++++-------
 fs/nfsd/filecache.h |    2 ++
 fs/nfsd/nfs4proc.c  |   43 +++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c |   16 +++++++++++++---
 fs/nfsd/xdr4.h      |    1 +
 fs/open.c           |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h  |    2 ++
 7 files changed, 143 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index dc9166136796..764c2cfc49a4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -912,9 +912,9 @@ nfsd_file_is_cached(struct inode *inode)
 	return ret;
 }
 
-__be32
-nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		  unsigned int may_flags, struct nfsd_file **pnf)
+static __be32
+nfsd_do_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     unsigned int may_flags, struct nfsd_file **pnf, bool open)
 {
 	__be32	status;
 	struct net *net = SVC_NET(rqstp);
@@ -1009,10 +1009,13 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		nfsd_file_gc();
 
 	nf->nf_mark = nfsd_file_mark_find_or_create(nf);
-	if (nf->nf_mark)
-		status = nfsd_open_verified(rqstp, fhp, may_flags,
-					    &nf->nf_file);
-	else
+	if (nf->nf_mark) {
+		if (open)
+			status = nfsd_open_verified(rqstp, fhp, may_flags,
+						    &nf->nf_file);
+		else
+			status = nfs_ok;
+	} else
 		status = nfserr_jukebox;
 	/*
 	 * If construction failed, or we raced with a call to unlink()
@@ -1032,6 +1035,40 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	goto out;
 }
 
+/**
+ * nfsd_file_acquire - Get a struct nfsd_file with an open file
+ * @rqstp: the RPC transaction being executed
+ * @fhp: the NFS filehandle of the file to be opened
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
+ * network byte order is returned.
+ */
+__be32
+nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_do_file_acquire(rqstp, fhp, may_flags, pnf, true);
+}
+
+/**
+ * nfsd_file_create - Get a struct nfsd_file, do not open
+ * @rqstp: the RPC transaction being executed
+ * @fhp: the NFS filehandle of the file just created
+ * @may_flags: NFSD_MAY_ settings for the file
+ * @pnf: OUT: new or found "struct nfsd_file" object
+ *
+ * Returns nfs_ok and sets @pnf on success; otherwise an nfsstat in
+ * network byte order is returned.
+ */
+__be32
+nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		 unsigned int may_flags, struct nfsd_file **pnf)
+{
+	return nfsd_do_file_acquire(rqstp, fhp, may_flags, pnf, false);
+}
+
 /*
  * Note that fields may be added, removed or reordered in the future. Programs
  * scraping this file for info should test the labels to ensure they're
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 2d775fea431a..b72efcb088ce 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -61,5 +61,7 @@ void nfsd_file_close_inode_sync(struct inode *inode);
 bool nfsd_file_is_cached(struct inode *inode);
 __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned int may_flags, struct nfsd_file **nfp);
+__be32 nfsd_file_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  unsigned int may_flags, struct nfsd_file **nfp);
 int	nfsd_file_cache_stats_open(struct inode *, struct file *);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 99c0485a29e9..28bae84d7809 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -243,6 +243,37 @@ static inline bool nfsd4_create_is_exclusive(int createmode)
 		createmode == NFS4_CREATE_EXCLUSIVE4_1;
 }
 
+static __be32
+nfsd4_vfs_create(struct svc_fh *fhp, struct dentry *child,
+		 struct nfsd4_open *open)
+{
+	struct file *filp;
+	struct path path;
+	int oflags;
+
+	oflags = O_CREAT | O_LARGEFILE;
+	switch (open->op_share_access & NFS4_SHARE_ACCESS_BOTH) {
+	case NFS4_SHARE_ACCESS_WRITE:
+		oflags |= O_WRONLY;
+		break;
+	case NFS4_SHARE_ACCESS_BOTH:
+		oflags |= O_RDWR;
+		break;
+	default:
+		oflags |= O_RDONLY;
+	}
+
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.dentry = child;
+	filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
+			     current_cred());
+	if (IS_ERR(filp))
+		return nfserrno(PTR_ERR(filp));
+
+	open->op_filp = filp;
+	return nfs_ok;
+}
+
 /*
  * Implement NFSv4's unchecked, guarded, and exclusive create
  * semantics for regular files. Open state for this new file is
@@ -355,11 +386,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
-	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
-	if (host_err < 0) {
-		status = nfserrno(host_err);
+	status = nfsd4_vfs_create(fhp, child, open);
+	if (status != nfs_ok)
 		goto out;
-	}
 	open->op_created = true;
 
 	/* A newly created file already has a file size of zero. */
@@ -517,6 +546,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		(int)open->op_fnamelen, open->op_fname,
 		open->op_openowner);
 
+	open->op_filp = NULL;
+
 	/* This check required by spec. */
 	if (open->op_create && open->op_claim_type != NFS4_OPEN_CLAIM_NULL)
 		return nfserr_inval;
@@ -613,6 +644,10 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (reclaim && !status)
 		nn->somebody_reclaimed = true;
 out:
+	if (open->op_filp) {
+		fput(open->op_filp);
+		open->op_filp = NULL;
+	}
 	if (resfh && resfh != &cstate->current_fh) {
 		fh_dup2(&cstate->current_fh, resfh);
 		fh_put(resfh);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 97c83c29d4ca..71c8f3f5e19b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5093,9 +5093,19 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *fp,
 
 	if (!fp->fi_fds[oflag]) {
 		spin_unlock(&fp->fi_lock);
-		status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
-		if (status)
-			goto out_put_access;
+
+		if (!open->op_filp) {
+			status = nfsd_file_acquire(rqstp, cur_fh, access, &nf);
+			if (status != nfs_ok)
+				goto out_put_access;
+		} else {
+			status = nfsd_file_create(rqstp, cur_fh, access, &nf);
+			if (status != nfs_ok)
+				goto out_put_access;
+			nf->nf_file = open->op_filp;
+			open->op_filp = NULL;
+		}
+
 		spin_lock(&fp->fi_lock);
 		if (!fp->fi_fds[oflag]) {
 			fp->fi_fds[oflag] = nf;
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 846ab6df9d48..7b744011f2d3 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -273,6 +273,7 @@ struct nfsd4_open {
 	bool		op_truncate;        /* used during processing */
 	bool		op_created;         /* used during processing */
 	struct nfs4_openowner *op_openowner; /* used during processing */
+	struct file	*op_filp;           /* used during processing */
 	struct nfs4_file *op_file;          /* used during processing */
 	struct nfs4_ol_stateid *op_stp;	    /* used during processing */
 	struct nfs4_clnt_odstate *op_odstate; /* used during processing */
diff --git a/fs/open.c b/fs/open.c
index 1315253e0247..117355ae6bd5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -981,6 +981,48 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
+/**
+ * dentry_create - Create and open a file
+ * @path: path to create
+ * @flags: O_ flags
+ * @mode: mode bits for new file
+ * @cred: credentials to use
+ *
+ * Caller must hold the parent directory's lock, and have prepared
+ * a negative dentry, placed in @path->dentry, for the new file.
+ *
+ * Caller sets @path->mnt to the vfsmount of the filesystem where
+ * the new file is to be created. The parent directory and the
+ * negative dentry must reside on the same filesystem instance.
+ *
+ * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * is returned.
+ */
+struct file *dentry_create(const struct path *path, int flags, umode_t mode,
+			   const struct cred *cred)
+{
+	struct file *f;
+	int error;
+
+	validate_creds(cred);
+	f = alloc_empty_file(flags, cred);
+	if (IS_ERR(f))
+		return f;
+
+	error = vfs_create(mnt_user_ns(path->mnt),
+			   d_inode(path->dentry->d_parent),
+			   path->dentry, mode, true);
+	if (!error)
+		error = vfs_open(path, f);
+
+	if (unlikely(error)) {
+		fput(f);
+		return ERR_PTR(error);
+	}
+	return f;
+}
+EXPORT_SYMBOL(dentry_create);
+
 struct file *open_with_fake_path(const struct path *path, int flags,
 				struct inode *inode, const struct cred *cred)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index aa6c1bbdb8c4..b848355b5e6c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2640,6 +2640,8 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
 			      name, flags, mode);
 }
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
+extern struct file *dentry_create(const struct path *path, int flags,
+				  umode_t mode, const struct cred *cred);
 extern struct file * open_with_fake_path(const struct path *, int,
 					 struct inode*, const struct cred *);
 static inline struct file *file_clone_open(struct file *file)


