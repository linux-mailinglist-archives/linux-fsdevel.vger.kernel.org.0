Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F954A2A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 01:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbiFMXWG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 19:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbiFMXVx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:21:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A53193A;
        Mon, 13 Jun 2022 16:21:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B801F21A94;
        Mon, 13 Jun 2022 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655162503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUF4AhRWCiEgz1MsSrvILiRjzwqzC+l2o2t3OmAkQ6Q=;
        b=UGQ2Y2JgDGR1dlSMXaTaex3knm9MLPW56eaKkkz9xCh6sbq4Sa0G+5ENyb2xDwWSRd0IEA
        +4DWhsqqqxyimJ3wJyl2gurDUQmBdPCprXRQ/G7pVeBLirmyI8+hpH/rwQssT2XTB3ftvZ
        y/C9JHSIASC+jMJ6huxI2bDdgKXB9JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655162503;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUF4AhRWCiEgz1MsSrvILiRjzwqzC+l2o2t3OmAkQ6Q=;
        b=mD53fllLcILh7klqva97XPMH3l4JpWjPOb7Xne1ms67faTChW6wmn0QSYSDwJtdnrgmEdk
        IKZc/6Abb+dyVCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F489134CF;
        Mon, 13 Jun 2022 23:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cWexDoXGp2IYcAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 13 Jun 2022 23:21:41 +0000
Subject: [PATCH 10/12] nfsd: reduce locking in nfsd_lookup()
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>, Daire Byrne <daire@dneg.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 14 Jun 2022 09:18:22 +1000
Message-ID: <165516230202.21248.2917435222861526857.stgit@noble.brown>
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

nfsd_lookup() takes an exclusive lock on the parent inode, but many
callers don't want the lock and may not need to lock at all if the
result is in the dcache.

Also this is the only place where the fh_locked flag is needed, as
nfsd_lookup() may or may not return with the inode locked, and the
fh_locked flag tells which.

Change nfsd_lookup() to be passed a pointer to an int flag.
If the pointer is NULL, don't take the lock.
If not, record in the int whether the lock is held.
Then in that one place that care, pass a pointer to an int, and be sure
to unlock if necessary.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs3proc.c |    2 +-
 fs/nfsd/nfs4proc.c |   27 +++++++++++++--------------
 fs/nfsd/nfsproc.c  |    2 +-
 fs/nfsd/vfs.c      |   36 +++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h      |    8 +++++---
 5 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 0fdbb9504a87..d85b110d58dd 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -96,7 +96,7 @@ nfsd3_proc_lookup(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_lookup(rqstp, &resp->dirfh,
 				   argp->name, argp->len,
-				   &resp->fh);
+				   &resp->fh, NULL);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71a4b8ef77f0..79434e29b63f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -411,7 +411,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 }
 
 static __be32
-do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh **resfh)
+do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
+	       struct nfsd4_open *open, struct svc_fh **resfh,
+	       int *locked)
 {
 	struct svc_fh *current_fh = &cstate->current_fh;
 	int accmode;
@@ -455,14 +457,9 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
 						FATTR4_WORD1_TIME_MODIFY);
 	} else
-		/*
-		 * Note this may exit with the parent still locked.
-		 * We will hold the lock until nfsd4_open's final
-		 * lookup, to prevent renames or unlinks until we've had
-		 * a chance to an acquire a delegation if appropriate.
-		 */
 		status = nfsd_lookup(rqstp, current_fh,
-				     open->op_fname, open->op_fnamelen, *resfh);
+				     open->op_fname, open->op_fnamelen, *resfh,
+				     locked);
 	if (status)
 		goto out;
 	status = nfsd_check_obj_isreg(*resfh);
@@ -537,6 +534,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool reclaim = false;
+	int locked = 0;
 
 	dprintk("NFSD: nfsd4_open filename %.*s op_openowner %p\n",
 		(int)open->op_fnamelen, open->op_fname,
@@ -598,7 +596,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	switch (open->op_claim_type) {
 	case NFS4_OPEN_CLAIM_DELEGATE_CUR:
 	case NFS4_OPEN_CLAIM_NULL:
-		status = do_open_lookup(rqstp, cstate, open, &resfh);
+		status = do_open_lookup(rqstp, cstate, open, &resfh, &locked);
 		if (status)
 			goto out;
 		break;
@@ -636,6 +634,8 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		fput(open->op_filp);
 		open->op_filp = NULL;
 	}
+	if (locked)
+		inode_unlock(cstate->current_fh.fh_dentry->d_inode);
 	if (resfh && resfh != &cstate->current_fh) {
 		fh_dup2(&cstate->current_fh, resfh);
 		fh_put(resfh);
@@ -920,7 +920,7 @@ static __be32 nfsd4_do_lookupp(struct svc_rqst *rqstp, struct svc_fh *fh)
 		return nfserr_noent;
 	}
 	fh_put(&tmp_fh);
-	return nfsd_lookup(rqstp, fh, "..", 2, fh);
+	return nfsd_lookup(rqstp, fh, "..", 2, fh, NULL);
 }
 
 static __be32
@@ -936,7 +936,7 @@ nfsd4_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	return nfsd_lookup(rqstp, &cstate->current_fh,
 			   u->lookup.lo_name, u->lookup.lo_len,
-			   &cstate->current_fh);
+			   &cstate->current_fh, NULL);
 }
 
 static __be32
@@ -1078,11 +1078,10 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (err)
 		return err;
 	err = nfsd_lookup_dentry(rqstp, &cstate->current_fh,
-				    secinfo->si_name, secinfo->si_namelen,
-				    &exp, &dentry);
+				 secinfo->si_name, secinfo->si_namelen,
+				 &exp, &dentry, NULL);
 	if (err)
 		return err;
-	fh_unlock(&cstate->current_fh);
 	if (d_really_is_negative(dentry)) {
 		exp_put(exp);
 		err = nfserr_noent;
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 2dccf77634e8..465d70e053f6 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -133,7 +133,7 @@ nfsd_proc_lookup(struct svc_rqst *rqstp)
 
 	fh_init(&resp->fh, NFS_FHSIZE);
 	resp->status = nfsd_lookup(rqstp, &argp->fh, argp->name, argp->len,
-				   &resp->fh);
+				   &resp->fh, NULL);
 	fh_put(&argp->fh);
 	if (resp->status != nfs_ok)
 		goto out;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b0df216ab3e4..4c2e431100ba 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -172,7 +172,8 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc_export *exp)
 __be32
 nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   const char *name, unsigned int len,
-		   struct svc_export **exp_ret, struct dentry **dentry_ret)
+		   struct svc_export **exp_ret, struct dentry **dentry_ret,
+		   int *locked)
 {
 	struct svc_export	*exp;
 	struct dentry		*dparent;
@@ -184,6 +185,9 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	dparent = fhp->fh_dentry;
 	exp = exp_get(fhp->fh_export);
 
+	if (locked)
+		*locked = 0;
+
 	/* Lookup the name, but don't follow links */
 	if (isdotent(name, len)) {
 		if (len==1)
@@ -199,13 +203,15 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				goto out_nfserr;
 		}
 	} else {
-		/*
-		 * In the nfsd4_open() case, this may be held across
-		 * subsequent open and delegation acquisition which may
-		 * need to take the child's i_mutex:
-		 */
-		fh_lock_nested(fhp, I_MUTEX_PARENT);
-		dentry = lookup_one_len(name, dparent, len);
+		if (locked) {
+			inode_lock_nested(dparent->d_inode, I_MUTEX_PARENT);
+			dentry = lookup_one_len(name, dparent, len);
+			if (IS_ERR(dentry))
+				inode_unlock(dparent->d_inode);
+			else
+				*locked = 1;
+		} else
+			dentry = lookup_one_len_unlocked(name, dparent, len);
 		host_err = PTR_ERR(dentry);
 		if (IS_ERR(dentry))
 			goto out_nfserr;
@@ -218,7 +224,10 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 * something that we might be about to delegate,
 			 * and a mountpoint won't be renamed:
 			 */
-			fh_unlock(fhp);
+			if (locked && *locked) {
+				inode_unlock(dparent->d_inode);
+				*locked = 0;
+			}
 			if ((host_err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
 				dput(dentry);
 				goto out_nfserr;
@@ -248,7 +257,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
-				unsigned int len, struct svc_fh *resfh)
+	    unsigned int len, struct svc_fh *resfh,
+	    int *locked)
 {
 	struct svc_export	*exp;
 	struct dentry		*dentry;
@@ -257,7 +267,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (err)
 		return err;
-	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
+	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry, locked);
 	if (err)
 		return err;
 	err = check_nfsd_access(exp, rqstp);
@@ -273,6 +283,10 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 out:
 	dput(dentry);
 	exp_put(exp);
+	if (err && locked && *locked) {
+		inode_unlock(fhp->fh_dentry->d_inode);
+		*locked = 0;
+	}
 	return err;
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 26347d76f44a..b7d41b73dd79 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -45,10 +45,12 @@ typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
-				const char *, unsigned int, struct svc_fh *);
+			    const char *, unsigned int, struct svc_fh *,
+			    int *);
 __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
-				const char *, unsigned int,
-				struct svc_export **, struct dentry **);
+				    const char *, unsigned int,
+				    struct svc_export **, struct dentry **,
+				    int *);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
 				struct iattr *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);


