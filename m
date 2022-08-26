Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AC65A1EB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 04:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiHZCSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 22:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244779AbiHZCSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:18:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A8CC307;
        Thu, 25 Aug 2022 19:18:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93DB42245B;
        Fri, 26 Aug 2022 02:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661480311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/OQ71GnjI/3L/tS+ak62PjchNjosq9EXd1NsoX0Vxs=;
        b=XSdZOFmDAB/wQMJXXzRPpn3gg+X1cWIaC6KW+ZcEWufeU8cvFw1gJn9f0BH3oe79vLSIrn
        I27fyoTPgwBLe8NQ07B/yRb1sRg30CpEbVoPG5wSaZj3piiHATMxPi6gzyhSx2mVY4OJkA
        7tfT68Xn6xBeT6ozLNldRdLLSCR8gXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661480311;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e/OQ71GnjI/3L/tS+ak62PjchNjosq9EXd1NsoX0Vxs=;
        b=TE3w9pqIP5IP3pyMWSv+2HkpMuU9YiizpNInCKv3rl7OZkts84dFoDETzH0h1rD8XaOK5i
        Fw9KysyBSCMxODAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDDA513A65;
        Fri, 26 Aug 2022 02:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0c+sHXQtCGPDMQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 26 Aug 2022 02:18:28 +0000
Subject: [PATCH 08/10] NFSD: allow parallel creates from nfsd
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Aug 2022 12:10:43 +1000
Message-ID: <166147984376.25420.3784384336816172144.stgit@noble.brown>
In-Reply-To: <166147828344.25420.13834885828450967910.stgit@noble.brown>
References: <166147828344.25420.13834885828450967910.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than getting write access, locking the directory, and performing
a lookup, use
  filename_create_one_len() for create, or
  lookup_hash_update_len() for delete, or
  lock_rename_lookup_one() for rename
which combine all these steps and handle shared locking for concurrent
updates where appropriate.

Functions which call these need to allocate a workqueue_head on the
stack which will be used if the name does not yet exist in the dcache.
Any other thread that wants to look up the name will wait on this
workqueue_head until the NFS operation completes.

As the directory lock is sometimes a shared lock, fh_fill_pre_attrs()
needs to determin if the lock was exclusive, so that when attributes are
returned to an NFSv4 client, that fact can be reported.

Note that there is only one filesystem that will, in this patch series,
allow shared locks for create/unlink and that is NFS (for re-export).
NFS does not support atomic pre/post attributes, so there is no loss in
not providing them.

When some other filesystem supports concurrent updates, we might need to
consider if the pre/post attributes are more important than the
parallelism.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |   28 +++-----
 fs/nfsd/nfs4proc.c |   29 ++++-----
 fs/nfsd/nfsfh.c    |    9 +++
 fs/nfsd/nfsproc.c  |   29 ++++-----
 fs/nfsd/vfs.c      |  177 ++++++++++++++++++++--------------------------------
 5 files changed, 112 insertions(+), 160 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a41cca619338..05e7907940ea 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -234,13 +234,15 @@ static __be32
 nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd3_createargs *argp)
 {
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct iattr *iap = &argp->attrs;
-	struct dentry *parent, *child;
 	struct nfsd_attrs attrs = {
 		.na_iattr	= iap,
 	};
 	__u32 v_mtime, v_atime;
+	struct dentry *child;
 	struct inode *inode;
+	struct path path;
 	__be32 status;
 	int host_err;
 
@@ -253,20 +255,15 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
 
-	inode_lock_nested(inode, I_MUTEX_PARENT);
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
@@ -342,10 +339,7 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	status = nfsd_create_setattr(rqstp, fhp, resfhp, &attrs);
 
 out:
-	inode_unlock(inode);
-	if (child && !IS_ERR(child))
-		dput(child);
-	fh_drop_write(fhp);
+	done_path_update(&path, child);
 	return status;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a72ab97f77ef..78e20b8fb2b4 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -235,16 +235,17 @@ static __be32
 nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct svc_fh *resfhp, struct nfsd4_open *open)
 {
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct iattr *iap = &open->op_iattr;
 	struct nfsd_attrs attrs = {
 		.na_iattr	= iap,
 		.na_seclabel	= &open->op_label,
 	};
-	struct dentry *parent, *child;
 	__u32 v_mtime, v_atime;
+	struct dentry *child;
 	struct inode *inode;
+	struct path path;
 	__be32 status;
-	int host_err;
 
 	if (isdotent(open->op_fname, open->op_fnamelen))
 		return nfserr_exist;
@@ -254,23 +255,20 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
 
 	if (is_create_with_attrs(open))
 		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
+	inode = d_inode(path.dentry);
 
-	inode_lock_nested(inode, I_MUTEX_PARENT);
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
@@ -375,11 +373,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (attrs.na_aclerr)
 		open->op_bmval[0] &= ~FATTR4_WORD0_ACL;
 out:
-	inode_unlock(inode);
+	done_path_update(&path, child);
 	nfsd_attrs_free(&attrs);
-	if (child && !IS_ERR(child))
-		dput(child);
-	fh_drop_write(fhp);
 	return status;
 }
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index a5b71526cee0..5f024e6649d9 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -11,6 +11,7 @@
 #include <linux/exportfs.h>
 
 #include <linux/sunrpc/svcauth_gss.h>
+#include <linux/namei.h>
 #include "nfsd.h"
 #include "vfs.h"
 #include "auth.h"
@@ -627,6 +628,14 @@ void fh_fill_pre_attrs(struct svc_fh *fhp)
 	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return;
 
+	if (!IS_PAR_UPDATE(fhp->fh_dentry->d_inode) &&
+	    inode_trylock_shared(fhp->fh_dentry->d_inode)) {
+		/* only have a shared lock */
+		inode_unlock_shared(fhp->fh_dentry->d_inode);
+		fhp->fh_no_atomic_attr = true;
+		fhp->fh_no_wcc = true;
+	}
+
 	inode = d_inode(fhp->fh_dentry);
 	err = fh_getattr(fhp, &stat);
 	if (err) {
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7381972f1677..e91aff4949e8 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -260,6 +260,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 {
 	struct nfsd_createargs *argp = rqstp->rq_argp;
 	struct nfsd_diropres *resp = rqstp->rq_resp;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	svc_fh		*dirfhp = &argp->fh;
 	svc_fh		*newfhp = &resp->fh;
 	struct iattr	*attr = &argp->attrs;
@@ -268,8 +269,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	};
 	struct inode	*inode;
 	struct dentry	*dchild;
+	struct path	path;
 	int		type, mode;
-	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
 
 	dprintk("nfsd: CREATE   %s %.*s\n",
@@ -285,26 +286,21 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	resp->status = nfserr_exist;
 	if (isdotent(argp->name, argp->len))
 		goto done;
-	hosterr = fh_want_write(dirfhp);
-	if (hosterr) {
-		resp->status = nfserrno(hosterr);
-		goto done;
-	}
 
-	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
+	path.dentry = dirfhp->fh_dentry;
+	path.mnt = dirfhp->fh_export->ex_path.mnt;
+	dchild = filename_create_one_len(argp->name, argp->len, &path, 0, &wq);
 	if (IS_ERR(dchild)) {
 		resp->status = nfserrno(PTR_ERR(dchild));
-		goto out_unlock;
+		goto done;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
 	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
-	dput(dchild);
 	if (resp->status) {
 		if (resp->status != nfserr_noent)
-			goto out_unlock;
+			goto out_done;
 		/*
 		 * If the new file handle wasn't verified, we can't tell
 		 * whether the file exists or not. Time to bail ...
@@ -313,7 +309,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		if (!newfhp->fh_dentry) {
 			printk(KERN_WARNING 
 				"nfsd_proc_create: file handle not verified\n");
-			goto out_unlock;
+			goto out_done;
 		}
 	}
 
@@ -347,7 +343,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 								 newfhp->fh_dentry,
 								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
 					if (resp->status && resp->status != nfserr_rofs)
-						goto out_unlock;
+						goto out_done;
 				}
 			} else
 				type = S_IFREG;
@@ -384,7 +380,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		/* Make sure the type and device matches */
 		resp->status = nfserr_exist;
 		if (inode && inode_wrong_type(inode, type))
-			goto out_unlock;
+			goto out_done;
 	}
 
 	resp->status = nfs_ok;
@@ -406,9 +402,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 						    (time64_t)0);
 	}
 
-out_unlock:
-	inode_unlock(dirfhp->fh_dentry->d_inode);
-	fh_drop_write(dirfhp);
+out_done:
+	done_path_update(&path, dchild);
 done:
 	fh_put(dirfhp);
 	if (resp->status != nfs_ok)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..9b1e633977e0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1346,7 +1346,9 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	    char *fname, int flen, struct nfsd_attrs *attrs,
 	    int type, dev_t rdev, struct svc_fh *resfhp)
 {
-	struct dentry	*dentry, *dchild = NULL;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct dentry	*dchild = NULL;
+	struct path	path;
 	__be32		err;
 	int		host_err;
 
@@ -1357,33 +1359,24 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err)
 		return err;
 
-	dentry = fhp->fh_dentry;
-
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		return nfserrno(host_err);
+	path.dentry = fhp->fh_dentry;
+	path.mnt = fhp->fh_export->ex_path.mnt;
 
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dchild = lookup_one_len(fname, dentry, flen);
+	dchild = filename_create_one_len(fname, flen, &path, 0, &wq);
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild)) {
 		err = nfserrno(host_err);
-		goto out_unlock;
+		goto out;
 	}
 	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
-	/*
-	 * We unconditionally drop our ref to dchild as fh_compose will have
-	 * already grabbed its own ref for it.
-	 */
-	dput(dchild);
-	if (err)
-		goto out_unlock;
-	fh_fill_pre_attrs(fhp);
-	err = nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
-				 rdev, resfhp);
-	fh_fill_post_attrs(fhp);
-out_unlock:
-	inode_unlock(dentry->d_inode);
+	if (!err) {
+		fh_fill_pre_attrs(fhp);
+		err = nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
+					 rdev, resfhp);
+		fh_fill_post_attrs(fhp);
+	}
+	done_path_update(&path, dchild);
+out:
 	return err;
 }
 
@@ -1442,15 +1435,17 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
 __be32
 nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	     char *fname, int flen,
-	     char *path, struct nfsd_attrs *attrs,
+	     char *lpath, struct nfsd_attrs *attrs,
 	     struct svc_fh *resfhp)
 {
-	struct dentry	*dentry, *dnew;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct dentry	*dnew;
+	struct path	path;
 	__be32		err, cerr;
 	int		host_err;
 
 	err = nfserr_noent;
-	if (!flen || path[0] == '\0')
+	if (!flen || lpath[0] == '\0')
 		goto out;
 	err = nfserr_exist;
 	if (isdotent(fname, flen))
@@ -1460,33 +1455,27 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err)
 		goto out;
 
-	host_err = fh_want_write(fhp);
-	if (host_err) {
-		err = nfserrno(host_err);
-		goto out;
-	}
+	path.dentry = fhp->fh_dentry;
+	path.mnt = fhp->fh_export->ex_path.mnt;
 
-	dentry = fhp->fh_dentry;
-	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
-	dnew = lookup_one_len(fname, dentry, flen);
+	dnew = filename_create_one_len(fname, flen, &path, 0, &wq);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
-		inode_unlock(dentry->d_inode);
-		goto out_drop_write;
+		goto out;
 	}
 	fh_fill_pre_attrs(fhp);
-	host_err = vfs_symlink(&init_user_ns, d_inode(dentry), dnew, path);
+	host_err = vfs_symlink(mnt_user_ns(path.mnt), d_inode(path.dentry),
+			       dnew, lpath);
 	err = nfserrno(host_err);
 	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
 	if (!err)
 		nfsd_create_setattr(rqstp, fhp, resfhp, attrs);
 	fh_fill_post_attrs(fhp);
-	inode_unlock(dentry->d_inode);
+	done_path_update(&path, dnew);
 	if (!err)
 		err = nfserrno(commit_metadata(fhp));
-	dput(dnew);
-	if (err==0) err = cerr;
-out_drop_write:
+	if (err==0)
+		err = cerr;
 	fh_drop_write(fhp);
 out:
 	return err;
@@ -1500,8 +1489,10 @@ __be32
 nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 				char *name, int len, struct svc_fh *tfhp)
 {
-	struct dentry	*ddir, *dnew, *dold;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct dentry	*dold, *dnew;
 	struct inode	*dirp;
+	struct path	path;
 	__be32		err;
 	int		host_err;
 
@@ -1521,31 +1512,24 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 	if (isdotent(name, len))
 		goto out;
 
-	host_err = fh_want_write(tfhp);
-	if (host_err) {
-		err = nfserrno(host_err);
-		goto out;
-	}
-
-	ddir = ffhp->fh_dentry;
-	dirp = d_inode(ddir);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
+	path.dentry = ffhp->fh_dentry;
+	path.mnt = ffhp->fh_export->ex_path.mnt;
+	dirp = d_inode(path.dentry);
 
-	dnew = lookup_one_len(name, ddir, len);
+	dnew = filename_create_one_len(name, len, &path, 0, &wq);
 	if (IS_ERR(dnew)) {
 		err = nfserrno(PTR_ERR(dnew));
-		goto out_unlock;
+		goto out;
 	}
 
 	dold = tfhp->fh_dentry;
 
 	err = nfserr_noent;
 	if (d_really_is_negative(dold))
-		goto out_dput;
+		goto out_done;
 	fh_fill_pre_attrs(ffhp);
 	host_err = vfs_link(dold, &init_user_ns, dirp, dnew, NULL);
-	fh_fill_post_attrs(ffhp);
-	inode_unlock(dirp);
+
 	if (!host_err) {
 		err = nfserrno(commit_metadata(ffhp));
 		if (!err)
@@ -1556,17 +1540,11 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
 		else
 			err = nfserrno(host_err);
 	}
-	dput(dnew);
-out_drop_write:
-	fh_drop_write(tfhp);
+out_done:
+	fh_fill_post_attrs(ffhp);
+	done_path_update(&path, dnew);
 out:
 	return err;
-
-out_dput:
-	dput(dnew);
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 static void
@@ -1602,6 +1580,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	__be32		err;
 	int		host_err;
 	bool		close_cached = false;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
@@ -1627,40 +1606,36 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 		goto out;
 	}
 
-	trap = lock_rename(tdentry, fdentry);
+	trap = lock_rename_lookup_one(tdentry, fdentry, &ndentry, &odentry,
+				      tname, tlen, fname, flen, 0, 0, &wq);
+	host_err = PTR_ERR(trap);
+	if (IS_ERR(trap))
+		goto out_nfserr;
 	fh_fill_pre_attrs(ffhp);
 	fh_fill_pre_attrs(tfhp);
 
-	odentry = lookup_one_len(fname, fdentry, flen);
-	host_err = PTR_ERR(odentry);
-	if (IS_ERR(odentry))
-		goto out_nfserr;
-
 	host_err = -ENOENT;
 	if (d_really_is_negative(odentry))
-		goto out_dput_old;
+		goto out_unlock;
 	host_err = -EINVAL;
 	if (odentry == trap)
-		goto out_dput_old;
+		goto out_unlock;
 
-	ndentry = lookup_one_len(tname, tdentry, tlen);
-	host_err = PTR_ERR(ndentry);
-	if (IS_ERR(ndentry))
-		goto out_dput_old;
 	host_err = -ENOTEMPTY;
 	if (ndentry == trap)
-		goto out_dput_new;
+		goto out_unlock;
 
 	host_err = -EXDEV;
 	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
+		goto out_unlock;
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
+		goto out_unlock;
 
 	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
 	    nfsd_has_cached_files(ndentry)) {
 		close_cached = true;
-		goto out_dput_old;
+		dget(ndentry);
+		goto out_unlock;
 	} else {
 		struct renamedata rd = {
 			.old_mnt_userns	= &init_user_ns,
@@ -1677,18 +1652,14 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 				host_err = commit_metadata(ffhp);
 		}
 	}
- out_dput_new:
-	dput(ndentry);
- out_dput_old:
-	dput(odentry);
- out_nfserr:
-	err = nfserrno(host_err);
-
 	if (!close_cached) {
 		fh_fill_post_attrs(ffhp);
 		fh_fill_post_attrs(tfhp);
 	}
-	unlock_rename(tdentry, fdentry);
+ out_unlock:
+	unlock_rename_lookup(tdentry, fdentry, ndentry, odentry, true);
+ out_nfserr:
+	err = nfserrno(host_err);
 	fh_drop_write(ffhp);
 
 	/*
@@ -1715,9 +1686,11 @@ __be32
 nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 				char *fname, int flen)
 {
-	struct dentry	*dentry, *rdentry;
+	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
+	struct dentry	*rdentry;
 	struct inode	*dirp;
 	struct inode	*rinode;
+	struct path	path;
 	__be32		err;
 	int		host_err;
 
@@ -1728,24 +1701,16 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	if (err)
 		goto out;
 
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		goto out_nfserr;
+	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.dentry = fhp->fh_dentry;
 
-	dentry = fhp->fh_dentry;
-	dirp = d_inode(dentry);
-	inode_lock_nested(dirp, I_MUTEX_PARENT);
+	rdentry = lookup_hash_update_len(fname, flen, &path, 0, &wq);
+	dirp = d_inode(path.dentry);
 
-	rdentry = lookup_one_len(fname, dentry, flen);
 	host_err = PTR_ERR(rdentry);
 	if (IS_ERR(rdentry))
-		goto out_unlock;
+		goto out_nfserr;
 
-	if (d_really_is_negative(rdentry)) {
-		dput(rdentry);
-		host_err = -ENOENT;
-		goto out_unlock;
-	}
 	rinode = d_inode(rdentry);
 	ihold(rinode);
 
@@ -1762,14 +1727,11 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 	fh_fill_post_attrs(fhp);
 
-	inode_unlock(dirp);
+	done_path_update(&path, rdentry);
 	if (!host_err)
 		host_err = commit_metadata(fhp);
-	dput(rdentry);
 	iput(rinode);    /* truncate the inode here */
 
-out_drop_write:
-	fh_drop_write(fhp);
 out_nfserr:
 	if (host_err == -EBUSY) {
 		/* name is mounted-on. There is no perfect
@@ -1784,9 +1746,6 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 	}
 out:
 	return err;
-out_unlock:
-	inode_unlock(dirp);
-	goto out_drop_write;
 }
 
 /*


