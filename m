Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4E54A2A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiFMXVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241456AbiFMXV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8193204E;
        Mon, 13 Jun 2022 16:21:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9086721AA0;
        Mon, 13 Jun 2022 23:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvae5qbFLPE6aGXLD70p+XHvaKYzCxL7NtQu9CXSHSo=;
        b=JUuLIxo5v6mR2RWqhYFTpBZhAgnDrWra+KfVdWwlemURh81e0yn6RPVKX2JhIja57rUxRG
        Mhf6Y1TNPdTPexy2gArx8aKoySipDoz+fHrI9nzs/s+EIquFJjgVnyFp6L49M53mRhP4Y+
        BPiwpptaDfGE+urYgdb9R1C1yNrj1dM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zvae5qbFLPE6aGXLD70p+XHvaKYzCxL7NtQu9CXSHSo=;
        b=Ez1SXRYApDfGu3J1wt02dviUw2QqYbGeP9WfCFQ9irHE2Xi34pPHVDzFmOuZYaANkoV04O
        fIxPMTN0cwPrrdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A56B134CF;
        Mon, 13 Jun 2022 23:21:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3rrSAV7Gp2LwbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:21:02 +0000
Subject: [PATCH 08/12] nfsd: allow parallel creates from nfsd
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230200.21248.15108802355330895562.stgit@noble.brown>
In-Reply-To: <165516173293.21248.14587048046993234326.stgit@noble.brown>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than getting write access, locking the directory, and performing
a lookup, use
  filename_create_one_len() for create, or
  lookup_hash_update_len() for delete
which combines all these steps and handles shared locking for concurrent
updates where appropriate.

As we don't use fh_lock() we need to call fh_fill_pre_attrs()
explicitly.  However if we only get a shared lock, then the pre/post
attributes won't be atomic, so we need to ensure that fh know that,
and doesn't try to encode wcc attrs either.

Note that there is only one filesystem that allows shared locks for
create/unlink and that is NFS (for re-export).  NFS does support atomic
pre/post attributes, so there is no loss in not providing them.

When some other filesystem supports concurrent updates, we might need to
consider if the pre/post attributes are more important than the
parallelism.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |   31 +++++-------
 fs/nfsd/nfs4proc.c |   32 +++++-------
 fs/nfsd/nfsfh.c    |    7 ++-
 fs/nfsd/nfsfh.h    |    4 +-
 fs/nfsd/nfsproc.c  |   29 +++++------
 fs/nfsd/vfs.c      |  134 +++++++++++++++++++++++-----------------------------
 6 files changed, 105 insertions(+), 132 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 981a3a7a6e16..0fdbb9504a87 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -231,12 +231,14 @@ static __be32
 nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd3_createargs *argp)
 {
+	struct path path;
 	struct iattr *iap = &argp->attrs;
-	struct dentry *parent, *child;
+	struct dentry *child;
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
 	int host_err;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (isdotent(argp->name, argp->len))
 		return nfserr_exist;
@@ -247,20 +249,15 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (status != nfs_ok)
 		return status;
 
-	parent = fhp->fh_dentry;
-	inode = d_inode(parent);
+	path.dentry = fhp->fh_dentry;
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	inode = d_inode(path.dentry);
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
+	child = filename_create_one_len(argp->name, argp->len,
+					&path, 0, &wq);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
-
-	child = lookup_one_len(argp->name, parent, argp->len);
-	if (IS_ERR(child)) {
-		status = nfserrno(PTR_ERR(child));
-		goto out;
-	}
+	if (IS_ERR(child))
+		return nfserrno(PTR_ERR(child));
 
 	if (d_really_is_negative(child)) {
 		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
@@ -311,6 +308,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
+	fh_fill_pre_attrs(fhp, (child->d_flags & DCACHE_PAR_UPDATE) == 0);
 
 	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
 	if (host_err < 0) {
@@ -332,12 +330,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
-
+	fh_fill_post_attrs(fhp);
 out:
-	fh_unlock(fhp);
-	if (child && !IS_ERR(child))
-		dput(child);
-	fh_drop_write(fhp);
+	done_path_update(&path, child, &wq);
 	return status;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 3895eb52d2b1..71a4b8ef77f0 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -285,12 +285,13 @@ static __be32
 nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd4_open *open)
 {
+	struct path path;
 	struct iattr *iap = &open->op_iattr;
-	struct dentry *parent, *child;
+	struct dentry *child;
 	__u32 v_mtime, v_atime;
 	struct inode *inode;
 	__be32 status;
-	int host_err;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (isdotent(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
@@ -300,20 +301,17 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (status != nfs_ok)
 		return status;
-	parent = fhp->fh_dentry;
-	inode = d_inode(parent);
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
+	path.dentry = fhp->fh_dentry;
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	inode = d_inode(path.dentry);
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
+	child = filename_create_one_len(open->op_fname,
+					open->op_fnamelen,
+					&path, 0, &wq);
 
-	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
-	if (IS_ERR(child)) {
-		status = nfserrno(PTR_ERR(child));
-		goto out;
-	}
+	if (IS_ERR(child))
+		return nfserrno(PTR_ERR(child));
 
 	if (d_really_is_negative(child)) {
 		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
@@ -386,6 +384,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!IS_POSIXACL(inode))
 		iap->ia_mode &= ~current_umask();
 
+	fh_fill_pre_attrs(fhp, (child->d_flags & DCACHE_PAR_UPDATE) == 0);
 	status = nfsd4_vfs_create(fhp, child, open);
 	if (status != nfs_ok)
 		goto out;
@@ -405,12 +404,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 set_attr:
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
-
+	fh_fill_post_attrs(fhp);
 out:
-	fh_unlock(fhp);
-	if (child && !IS_ERR(child))
-		dput(child);
-	fh_drop_write(fhp);
+	done_path_update(&path, child, &wq);
 	return status;
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c29baa03dfaf..a50db688c60d 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -616,7 +616,7 @@ fh_update(struct svc_fh *fhp)
  * @fhp: file handle to be updated
  *
  */
-void fh_fill_pre_attrs(struct svc_fh *fhp)
+void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic)
 {
 	bool v4 = (fhp->fh_maxsize == NFS4_FHSIZE);
 	struct inode *inode;
@@ -626,6 +626,11 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return;
 
+	if (!atomic) {
+		fhp->fh_no_atomic_attr = true;
+		fhp->fh_no_wcc = true;
+	}
+
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err) {
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index fb9d358a267e..ecc57fd3fd67 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -320,7 +320,7 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 		return time_to_chattr(&stat->ctime);
 }
 
-extern void fh_fill_pre_attrs(struct svc_fh *fhp);
+extern void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 
 
@@ -347,7 +347,7 @@ fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
 
 	inode = d_inode(dentry);
 	inode_lock_nested(inode, subclass);
-	fh_fill_pre_attrs(fhp);
+	fh_fill_pre_attrs(fhp, true);
 	fhp->fh_locked = true;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index fcdab8a8a41f..2dccf77634e8 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -255,6 +255,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 static __be32
 nfsd_proc_create(struct svc_rqst *rqstp)
 {
+	struct path path;
 	struct nfsd_createargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
 	svc_fh		*dirfhp = &argp->fh;
@@ -263,8 +264,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	struct inode	*inode;
 	struct dentry	*dchild;
 	int		type, mode;
-	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	dprintk("nfsd: CREATE   %s %.*s\n",
 		SVCFH_fmt(dirfhp), argp->len, argp->name);
@@ -279,17 +280,13 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	resp->status = nfserr_exist;
 	if (isdotent(argp->name, argp->len))
 		goto done;
-	hosterr = fh_want_write(dirfhp);
-	if (hosterr) {
-		resp->status = nfserrno(hosterr);
-		goto done;
-	}
 
-	fh_lock_nested(dirfhp, I_MUTEX_PARENT);
-	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
+	path.dentry = dirfhp->fh_dentry;
+	path.mnt = dirfhp->fh_export->ex_path.mnt;
+	dchild = filename_create_one_len(argp->name, argp->len, &path, 0, &wq);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
-		goto out_unlock;
+		goto out_done;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
@@ -298,7 +295,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	dput(dchild);
 	if (resp->status) {
 		if (resp->status != nfserr_noent)
-			goto out_unlock;
+			goto out_done;
 		/*
 		 * If the new file handle wasn't verified, we can't tell
 		 * whether the file exists or not. Time to bail ...
@@ -307,7 +304,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		if (!newfhp->fh_dentry) {
 			printk(KERN_WARNING 
 				"nfsd_proc_create: file handle not verified\n");
-			goto out_unlock;
+			goto out_done;
 		}
 	}
 
@@ -341,7 +338,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 								 newfhp->fh_dentry,
 								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
 					if (resp->status && resp->status != nfserr_rofs)
-						goto out_unlock;
+						goto out_done;
 				}
 			} else
 				type = S_IFREG;
@@ -378,7 +375,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		/* Make sure the type and device matches */
 		resp->status = nfserr_exist;
 		if (inode && inode_wrong_type(inode, type))
-			goto out_unlock;
+			goto out_done;
 	}
 
 	resp->status = nfs_ok;
@@ -400,10 +397,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 						    (time64_t)0);
 	}
 
-out_unlock:
-	/* We don't really need to unlock, as fh_put does it. */
-	fh_unlock(dirfhp);
-	fh_drop_write(dirfhp);
+out_done:
+	done_path_update(&path, dchild, &wq);
 done:
 	fh_put(dirfhp);
 	if (resp->status != nfs_ok)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 840e3af63a6f..6cdd5e407600 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1274,12 +1274,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dirp = d_inode(dentry);
 
 	dchild = dget(resfhp->fh_dentry);
-	if (!fhp->fh_locked) {
-		WARN_ONCE(1, "nfsd_create: parent %pd2 not locked!\n",
-				dentry);
-		err = nfserr_io;
-		goto out;
-	}
 
 	err = nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE);
 	if (err)
@@ -1362,9 +1356,11 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		char *fname, int flen, struct iattr *iap,
 		int type, dev_t rdev, struct svc_fh *resfhp)
 {
-	struct dentry	*dentry, *dchild = NULL;
+	struct path	path;
+	struct dentry	*dchild = NULL;
 	__be32		err;
 	int		host_err;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (isdotent(fname, flen))
 		return nfserr_exist;
@@ -1373,27 +1369,22 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err)
 		return err;
 
-	dentry = fhp->fh_dentry;
-
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
+	path.dentry = fhp->fh_dentry;
+	path.mnt = fhp->fh_export->ex_path.mnt;
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
-	dchild = lookup_one_len(fname, dentry, flen);
+	dchild = filename_create_one_len(fname, flen, &path, 0, &wq);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild))
 		return nfserrno(host_err);
 	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
-	/*
-	 * We unconditionally drop our ref to dchild as fh_compose will have
-	 * already grabbed its own ref for it.
-	 */
-	dput(dchild);
-	if (err)
-		return err;
-	return nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
-					rdev, resfhp);
+	if (!err) {
+		fh_fill_pre_attrs(fhp, (dchild->d_flags & DCACHE_PAR_UPDATE) == 0);
+		err = nfsd_create_locked(rqstp, fhp, fname, flen, iap, type,
+					 rdev, resfhp);
+		fh_fill_post_attrs(fhp);
+	}
+	done_path_update(&path, dchild, &wq);
+	return err;
 }
 
 /*
@@ -1441,15 +1432,17 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
 __be32
 nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				char *fname, int flen,
-				char *path,
+				char *lpath,
 				struct svc_fh *resfhp)
 {
-	struct dentry	*dentry, *dnew;
+	struct path	path;
+	struct dentry	*dnew;
 	__be32		err, cerr;
 	int		host_err;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	err = nfserr_noent;
-	if (!flen || path[0] == '\0')
+	if (!flen || lpath[0] == '\0')
 		goto out;
 	err = nfserr_exist;
 	if (isdotent(fname, flen))
@@ -1459,28 +1452,28 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err)
 		goto out;
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		goto out_nfserr;
+	path.dentry = fhp->fh_dentry;
+	path.mnt = fhp->fh_export->ex_path.mnt;
 
-	fh_lock(fhp);
-	dentry = fhp->fh_dentry;
-	dnew = lookup_one_len(fname, dentry, flen);
+	dnew = filename_create_one_len(fname, flen, &path, 0, &wq);
 	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew))
 		goto out_nfserr;
 
-	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
+	fh_fill_pre_attrs(fhp, (dnew->d_flags & DCACHE_PAR_UPDATE) == 0);
+	host_err = vfs_symlink(mnt_user_ns(path.mnt), d_inode(path.dentry),
+			       dnew, lpath);
 	err = nfserrno(host_err);
-	fh_unlock(fhp);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
 
-	fh_drop_write(fhp);
+	fh_fill_post_attrs(fhp);
 
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
-	dput(dnew);
-	if (err==0) err = cerr;
+	if (err==0)
+		err = cerr;
+
+	done_path_update(&path, dnew, &wq);
 out:
 	return err;
 
@@ -1497,10 +1490,12 @@ __be32
 nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 				char *name, int len, struct svc_fh *tfhp)
 {
-	struct dentry	*ddir, *dnew, *dold;
+	struct path	path;
+	struct dentry	*dold, *dnew;
 	struct inode	*dirp;
 	__be32		err;
 	int		host_err;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
 	if (err)
@@ -1518,17 +1513,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	if (isdotent(name, len))
 		goto out;
 
-	host_err = fh_want_write(tfhp);
-	if (host_err) {
-		err = nfserrno(host_err);
-		goto out;
-	}
-
-	fh_lock_nested(ffhp, I_MUTEX_PARENT);
-	ddir = ffhp->fh_dentry;
-	dirp = d_inode(ddir);
+	path.dentry = ffhp->fh_dentry;
+	path.mnt = ffhp->fh_export->ex_path.mnt;
+	dirp = d_inode(path.dentry);
 
-	dnew = lookup_one_len(name, ddir, len);
+	dnew = filename_create_one_len(name, len, &path, 0, &wq);
 	host_err = PTR_ERR(dnew);
 	if (IS_ERR(dnew))
 		goto out_nfserr;
@@ -1537,9 +1526,10 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
-		goto out_dput;
+		goto out_done;
+	fh_fill_pre_attrs(ffhp, (dnew->d_flags & DCACHE_PAR_UPDATE) == 0);
 	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
-	fh_unlock(ffhp);
+
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
@@ -1550,17 +1540,15 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		else
 			err = nfserrno(host_err);
 	}
-out_dput:
-	dput(dnew);
-out_unlock:
-	fh_unlock(ffhp);
-	fh_drop_write(tfhp);
+out_done:
+	fh_fill_post_attrs(ffhp);
+	done_path_update(&path, dnew, &wq);
 out:
 	return err;
 
 out_nfserr:
 	err = nfserrno(host_err);
-	goto out_unlock;
+	goto out;
 }
 
 static void
@@ -1625,8 +1613,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * so do it by hand */
 	trap = lock_rename(tdentry, fdentry);
 	ffhp->fh_locked = tfhp->fh_locked = true;
-	fh_fill_pre_attrs(ffhp);
-	fh_fill_pre_attrs(tfhp);
+	fh_fill_pre_attrs(ffhp, true);
+	fh_fill_pre_attrs(tfhp, true);
 
 	odentry = lookup_one_len(fname, fdentry, flen);
 	host_err = PTR_ERR(odentry);
@@ -1717,11 +1705,13 @@ __be32
 nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 				char *fname, int flen)
 {
-	struct dentry	*dentry, *rdentry;
+	struct dentry	*rdentry;
 	struct inode	*dirp;
 	struct inode	*rinode;
 	__be32		err;
 	int		host_err;
+	struct path	path;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	err = nfserr_acces;
 	if (!flen || isdotent(fname, flen))
@@ -1730,24 +1720,18 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (err)
 		goto out;
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		goto out_nfserr;
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.dentry = fhp->fh_dentry;
 
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
-	dentry = fhp->fh_dentry;
-	dirp = d_inode(dentry);
+	rdentry = lookup_hash_update_len(fname, flen, &path, 0, &wq);
+	dirp = d_inode(path.dentry);
 
-	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_drop_write;
+		goto out_nfserr;
+
+	fh_fill_pre_attrs(fhp, (rdentry->d_flags & DCACHE_PAR_UPDATE) == 0);
 
-	if (d_really_is_negative(rdentry)) {
-		dput(rdentry);
-		host_err = -ENOENT;
-		goto out_drop_write;
-	}
 	rinode = d_inode(rdentry);
 	ihold(rinode);
 
@@ -1761,15 +1745,13 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	} else {
 		host_err = vfs_rmdir(&init_user_ns, dirp, rdentry);
 	}
+	fh_fill_post_attrs(fhp);
 
-	fh_unlock(fhp);
+	done_path_update(&path, rdentry, &wq);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
-out_drop_write:
-	fh_drop_write(fhp);
 out_nfserr:
 	if (host_err == -EBUSY) {
 		/* name is mounted-on. There is no perfect


