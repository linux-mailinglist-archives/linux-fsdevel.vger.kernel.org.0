Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007D554A2A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbiFMXWL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbiFMXV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E996232057;
        Mon, 13 Jun 2022 16:21:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8A501F97B;
        Mon, 13 Jun 2022 23:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMccZnZTMuPJ2V0RFKCrt4ZJ93PoZsHv4InGH+qJUso=;
        b=VKjD9dl4WKgqy+qwHUPJUMCOG9EgkISb94nr5isNlb2KKHDYAApSRs45O0QMJlCzhljIwt
        YOFaDD+TX6RDIzFuHzxDrDU3jR0O6wfGPNRZJVAtdQflcXG8CpcoMzWE5Afc94SbmGLVUC
        H+n9Ua/4mh+pUfM/w/YWwGM9199QdqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162509;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMccZnZTMuPJ2V0RFKCrt4ZJ93PoZsHv4InGH+qJUso=;
        b=aDzlr0KMDwebjinIlh9/ilLCiOPvscFz1hfoFYprQI0uiZ5BZkXiJd9H0tmRrJRPmDWBDF
        zuBKCbM6O8KuQQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C489134CF;
        Mon, 13 Jun 2022 23:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c2sGCovGp2IbcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:21:47 +0000
Subject: [PATCH 11/12] nfsd: use (un)lock_inode instead of fh_(un)lock
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230203.21248.2885738961424931868.stgit@noble.brown>
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

Except for the xattr changes, these callers don't need to save pre/post
attrs, so use a simple lock/unlock.

For the xattr changes, make the saving of pre/post explicit rather than
requiring a comment.

Also many fh_unlock() are not needed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs2acl.c   |    6 +++---
 fs/nfsd/nfs3acl.c   |    4 ++--
 fs/nfsd/nfs3proc.c  |    4 ----
 fs/nfsd/nfs4acl.c   |    7 +++----
 fs/nfsd/nfs4proc.c  |    2 --
 fs/nfsd/nfs4state.c |    8 ++++----
 fs/nfsd/nfsfh.c     |    1 -
 fs/nfsd/nfsfh.h     |    8 --------
 fs/nfsd/vfs.c       |   26 ++++++++++++--------------
 9 files changed, 24 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b5760801d377..9edd3c1a30fb 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -111,7 +111,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_errno;
 
-	fh_lock(fh);
+	inode_lock(inode);
 
 	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
 			      argp->acl_access);
@@ -122,7 +122,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_drop_lock;
 
-	fh_unlock(fh);
+	inode_unlock(inode);
 
 	fh_drop_write(fh);
 
@@ -136,7 +136,7 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 	return rpc_success;
 
 out_drop_lock:
-	fh_unlock(fh);
+	inode_unlock(inode);
 	fh_drop_write(fh);
 out_errno:
 	resp->status = nfserrno(error);
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 35b2ebda14da..9446c6743664 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -101,7 +101,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 	if (error)
 		goto out_errno;
 
-	fh_lock(fh);
+	inode_lock(inode);
 
 	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
 			      argp->acl_access);
@@ -111,7 +111,7 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 			      argp->acl_default);
 
 out_drop_lock:
-	fh_unlock(fh);
+	inode_unlock(inode);
 	fh_drop_write(fh);
 out_errno:
 	resp->status = nfserrno(error);
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index d85b110d58dd..7bb07c7e6ee8 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -374,7 +374,6 @@ nfsd3_proc_mkdir(struct svc_rqst *rqstp)
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &argp->attrs, S_IFDIR, 0, &resp->fh);
-	fh_unlock(&resp->dirfh);
 	return rpc_success;
 }
 
@@ -449,7 +448,6 @@ nfsd3_proc_mknod(struct svc_rqst *rqstp)
 	type = nfs3_ftypes[argp->ftype];
 	resp->status = nfsd_create(rqstp, &resp->dirfh, argp->name, argp->len,
 				   &argp->attrs, type, rdev, &resp->fh);
-	fh_unlock(&resp->dirfh);
 out:
 	return rpc_success;
 }
@@ -472,7 +470,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
 				   argp->name, argp->len);
-	fh_unlock(&resp->fh);
 	return rpc_success;
 }
 
@@ -493,7 +490,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
-	fh_unlock(&resp->fh);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index eaa3a0cf38f1..7bcc6dc0f762 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -779,19 +779,18 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_error < 0)
 		goto out_nfserr;
 
-	fh_lock(fhp);
+	inode_lock(inode);
 
 	host_error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl);
 	if (host_error < 0)
 		goto out_drop_lock;
 
-	if (S_ISDIR(inode->i_mode)) {
+	if (S_ISDIR(inode->i_mode))
 		host_error = set_posix_acl(&init_user_ns, inode,
 					   ACL_TYPE_DEFAULT, dpacl);
-	}
 
 out_drop_lock:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 
 	posix_acl_release(pacl);
 	posix_acl_release(dpacl);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 79434e29b63f..d6defaf5a77a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -860,7 +860,6 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
 				create->cr_bmval);
 
-	fh_unlock(&cstate->current_fh);
 	set_change_info(&create->cr_cinfo, &cstate->current_fh);
 	fh_dup2(&cstate->current_fh, &resfh);
 out:
@@ -1040,7 +1039,6 @@ nfsd4_remove(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfsd_unlink(rqstp, &cstate->current_fh, 0,
 			     remove->rm_name, remove->rm_namelen);
 	if (!status) {
-		fh_unlock(&cstate->current_fh);
 		set_change_info(&remove->rm_cinfo, &cstate->current_fh);
 	}
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9409a0dc1b76..cb664c61b546 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7321,21 +7321,21 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct file_lock *lock)
 {
 	struct nfsd_file *nf;
+	struct inode *inode = fhp->fh_dentry->d_inode;
 	__be32 err;
 
 	err = nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
 	if (err)
 		return err;
-	fh_lock(fhp); /* to block new leases till after test_lock: */
-	err = nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
-							NFSD_MAY_READ));
+	inode_lock(inode); /* to block new leases till after test_lock: */
+	err = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
 	if (err)
 		goto out;
 	lock->fl_file = nf->nf_file;
 	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
 	lock->fl_file = NULL;
 out:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	nfsd_file_put(nf);
 	return err;
 }
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index a50db688c60d..ae270e4f921f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -685,7 +685,6 @@ fh_put(struct svc_fh *fhp)
 	struct dentry * dentry = fhp->fh_dentry;
 	struct svc_export * exp = fhp->fh_export;
 	if (dentry) {
-		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
 		dput(dentry);
 		fh_clear_pre_post_attrs(fhp);
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index ecc57fd3fd67..c5061cdb1016 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -323,14 +323,6 @@ static inline u64 nfsd4_change_attribute(struct kstat *stat,
 extern void fh_fill_pre_attrs(struct svc_fh *fhp, bool atomic);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 
-
-/*
- * Lock a file handle/inode
- * NOTE: both fh_lock and fh_unlock are done "by hand" in
- * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
- * so, any changes here should be reflected there.
- */
-
 static inline void
 fh_lock_nested(struct svc_fh *fhp, unsigned int subclass)
 {
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4c2e431100ba..f2f4868618bb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -253,7 +253,6 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * returned. Otherwise the covered directory is returned.
  * NOTE: this mountpoint crossing is not supported properly by all
  *   clients and is explicitly disallowed for NFSv3
- *      NeilBrown <neilb@cse.unsw.edu.au>
  */
 __be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
@@ -434,7 +433,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			return err;
 	}
 
-	fh_lock(fhp);
+	inode_lock(inode);
 	if (size_change) {
 		/*
 		 * RFC5661, Section 18.30.4:
@@ -470,7 +469,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	host_err = notify_change(&init_user_ns, dentry, iap, NULL);
 
 out_unlock:
-	fh_unlock(fhp);
+	inode_unlock(inode);
 	if (size_change)
 		put_write_access(inode);
 out:
@@ -2123,12 +2122,8 @@ nfsd_listxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char **bufp,
 }
 
 /*
- * Removexattr and setxattr need to call fh_lock to both lock the inode
- * and set the change attribute. Since the top-level vfs_removexattr
- * and vfs_setxattr calls already do their own inode_lock calls, call
- * the _locked variant. Pass in a NULL pointer for delegated_inode,
- * and let the client deal with NFS4ERR_DELAY (same as with e.g.
- * setattr and remove).
+ * Pass in a NULL pointer for delegated_inode, and let the client deal
+ * with NFS4ERR_DELAY (same as with e.g.  setattr and remove).
  */
 __be32
 nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
@@ -2144,12 +2139,14 @@ nfsd_removexattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name)
 	if (ret)
 		return nfserrno(ret);
 
-	fh_lock(fhp);
+	inode_lock(fhp->fh_dentry->d_inode);
+	fh_fill_pre_attrs(fhp, true);
 
 	ret = __vfs_removexattr_locked(&init_user_ns, fhp->fh_dentry,
 				       name, NULL);
 
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
 	return nfsd_xattr_errno(ret);
@@ -2169,12 +2166,13 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh *fhp, char *name,
 	ret = fh_want_write(fhp);
 	if (ret)
 		return nfserrno(ret);
-	fh_lock(fhp);
+	inode_lock(fhp->fh_dentry->d_inode);
+	fh_fill_pre_attrs(fhp, true);
 
 	ret = __vfs_setxattr_locked(&init_user_ns, fhp->fh_dentry, name, buf,
 				    len, flags, NULL);
-
-	fh_unlock(fhp);
+	fh_fill_post_attrs(fhp);
+	inode_unlock(fhp->fh_dentry->d_inode);
 	fh_drop_write(fhp);
 
 	return nfsd_xattr_errno(ret);


