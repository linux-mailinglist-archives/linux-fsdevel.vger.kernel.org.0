Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8D3D8341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhG0WnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 18:43:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57176 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbhG0WnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 18:43:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5292421E78;
        Tue, 27 Jul 2021 22:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627425801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5Drv34FJdxt83TLCHoF7R/jR6m1Ke+UdAwK940UJS8=;
        b=POQVZD6jz6bHKpZdUP3pme3Ne0lfuA0QXD2/qoSH6gmCGQGafCZ4vM7qBz3LHNaZy24r0e
        Rj4WvMK4i2czcfoDpe6muZvktwvwiwjMDfyOd8Kj43liBzjW+zoNMEUTxdskHJuUKrPqdo
        zUJubPuWzxSFgJwd4MDXiYap/l0f+f8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627425801;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5Drv34FJdxt83TLCHoF7R/jR6m1Ke+UdAwK940UJS8=;
        b=zq5NuAnhowY2d5S3RAU4pMzBqxRHTgUFa7dWbUGHN6NsFEpIe4xoeBlbtgFPrIm3tJc6CK
        y9yHKR5ULGy3QcCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3005013A5D;
        Tue, 27 Jul 2021 22:43:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HmfjNwWMAGHGVQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 27 Jul 2021 22:43:17 +0000
Subject: [PATCH 06/11] nfsd: include a vfsmount in struct svc_fh
From:   NeilBrown <neilb@suse.de>
To:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Wed, 28 Jul 2021 08:37:45 +1000
Message-ID: <162742546552.32498.8097200286954882080.stgit@noble.brown>
In-Reply-To: <162742539595.32498.13687924366155737575.stgit@noble.brown>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A future patch will allow exportfs_decode_fh{,_raw} to return a
different vfsmount than the one passed.  This is specifically for btrfs,
but would be useful for any filesystem that presents as multiple volumes
(i.e. different st_dev, each with their own st_ino number-space).

For nfsd, this means that the mnt in the svc_export may not apply to all
filehandles reached from that export.  So svc_fh needs to store a
distinct vfsmount as well.

For now, fs->fh_mnt == fh->fh_export->ex_path.mnt, but that will change.

Changes include:
  fh_compose()
  nfsd_lookup_dentry()
     now take a *path instead of a *dentry

  nfsd4_encode_fattr()
  nfsd4_encode_fattr_to_buf()
     now take a *vfsmount as well as a *dentry

  nfsd_cross_mnt() now takes a *path instead of a **dentry
     to pass in, and get back, the mnt and dentry.

  nfsd_lookup_parent() used to take a *dentry and a **dentry.
     now it just takes a *path.  This is the *path that as passed
     to nfsd_lookup_dentry().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/export.c   |    4 +-
 fs/nfsd/nfs3xdr.c  |   22 +++++----
 fs/nfsd/nfs4proc.c |    9 ++--
 fs/nfsd/nfs4xdr.c  |   55 +++++++++++-----------
 fs/nfsd/nfsfh.c    |   30 +++++++-----
 fs/nfsd/nfsfh.h    |    3 +
 fs/nfsd/nfsproc.c  |    5 ++
 fs/nfsd/vfs.c      |  133 ++++++++++++++++++++++++++++------------------------
 fs/nfsd/vfs.h      |   10 ++--
 fs/nfsd/xdr4.h     |    2 -
 10 files changed, 150 insertions(+), 123 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 9421dae22737..e506cbe78b4f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1003,7 +1003,7 @@ exp_rootfh(struct net *net, struct auth_domain *clp, char *name,
 	 * fh must be initialized before calling fh_compose
 	 */
 	fh_init(&fh, maxsize);
-	if (fh_compose(&fh, exp, path.dentry, NULL))
+	if (fh_compose(&fh, exp, &path, NULL))
 		err = -EINVAL;
 	else
 		err = 0;
@@ -1178,7 +1178,7 @@ exp_pseudoroot(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	exp = rqst_find_fsidzero_export(rqstp);
 	if (IS_ERR(exp))
 		return nfserrno(PTR_ERR(exp));
-	rv = fh_compose(fhp, exp, exp->ex_path.dentry, NULL);
+	rv = fh_compose(fhp, exp, &exp->ex_path, NULL);
 	exp_put(exp);
 	return rv;
 }
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 0a5ebc52e6a9..67af0c5c1543 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -1089,36 +1089,38 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
 		 const char *name, int namlen, u64 ino)
 {
 	struct svc_export	*exp;
-	struct dentry		*dparent, *dchild;
+	struct dentry		*dparent;
+	struct path		child;
 	__be32 rv = nfserr_noent;
 
 	dparent = cd->fh.fh_dentry;
 	exp  = cd->fh.fh_export;
+	child.mnt = cd->fh.fh_mnt;
 
 	if (isdotent(name, namlen)) {
 		if (namlen == 2) {
-			dchild = dget_parent(dparent);
+			child.dentry = dget_parent(dparent);
 			/*
 			 * Don't return filehandle for ".." if we're at
 			 * the filesystem or export root:
 			 */
-			if (dchild == dparent)
+			if (child.dentry == dparent)
 				goto out;
 			if (dparent == exp->ex_path.dentry)
 				goto out;
 		} else
-			dchild = dget(dparent);
+			child.dentry = dget(dparent);
 	} else
-		dchild = lookup_positive_unlocked(name, dparent, namlen);
-	if (IS_ERR(dchild))
+		child.dentry = lookup_positive_unlocked(name, dparent, namlen);
+	if (IS_ERR(child.dentry))
 		return rv;
-	if (d_mountpoint(dchild))
+	if (d_mountpoint(child.dentry))
 		goto out;
-	if (dchild->d_inode->i_ino != ino)
+	if (child.dentry->d_inode->i_ino != ino)
 		goto out;
-	rv = fh_compose(fhp, exp, dchild, &cd->fh);
+	rv = fh_compose(fhp, exp, &child, &cd->fh);
 out:
-	dput(dchild);
+	dput(child.dentry);
 	return rv;
 }
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 486c5dba4b65..743b9315cd3e 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -902,7 +902,7 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_secinfo *secinfo = &u->secinfo;
 	struct svc_export *exp;
-	struct dentry *dentry;
+	struct path path;
 	__be32 err;
 
 	err = fh_verify(rqstp, &cstate->current_fh, S_IFDIR, NFSD_MAY_EXEC);
@@ -910,16 +910,16 @@ nfsd4_secinfo(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return err;
 	err = nfsd_lookup_dentry(rqstp, &cstate->current_fh,
 				    secinfo->si_name, secinfo->si_namelen,
-				    &exp, &dentry);
+				    &exp, &path);
 	if (err)
 		return err;
 	fh_unlock(&cstate->current_fh);
-	if (d_really_is_negative(dentry)) {
+	if (d_really_is_negative(path.dentry)) {
 		exp_put(exp);
 		err = nfserr_noent;
 	} else
 		secinfo->si_exp = exp;
-	dput(dentry);
+	path_put(&path);
 	if (cstate->minorversion)
 		/* See rfc 5661 section 2.6.3.1.1.8 */
 		fh_put(&cstate->current_fh);
@@ -1930,6 +1930,7 @@ _nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	p = buf;
 	status = nfsd4_encode_fattr_to_buf(&p, count, &cstate->current_fh,
 				    cstate->current_fh.fh_export,
+				    cstate->current_fh.fh_mnt,
 				    cstate->current_fh.fh_dentry,
 				    verify->ve_bmval,
 				    rqstp, 0);
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 7abeccb975b2..21c277fa28ae 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2823,9 +2823,9 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
  */
 static __be32
 nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
-		struct svc_export *exp,
-		struct dentry *dentry, u32 *bmval,
-		struct svc_rqst *rqstp, int ignore_crossmnt)
+		   struct svc_export *exp,
+		   struct vfsmount *mnt, struct dentry *dentry,
+		   u32 *bmval, struct svc_rqst *rqstp, int ignore_crossmnt)
 {
 	u32 bmval0 = bmval[0];
 	u32 bmval1 = bmval[1];
@@ -2851,7 +2851,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	u32 minorversion = resp->cstate.minorversion;
 	struct path path = {
-		.mnt	= exp->ex_path.mnt,
+		.mnt	= mnt,
 		.dentry	= dentry,
 	};
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
@@ -2882,7 +2882,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		if (!tempfh)
 			goto out;
 		fh_init(tempfh, NFS4_FHSIZE);
-		status = fh_compose(tempfh, exp, dentry, NULL);
+		status = fh_compose(tempfh, exp, &path, NULL);
 		if (status)
 			goto out;
 		fhp = tempfh;
@@ -3274,13 +3274,12 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
-                	goto out_resource;
+			goto out_resource;
 		/*
 		 * Get parent's attributes if not ignoring crossmount
 		 * and this is the root of a cross-mounted filesystem.
 		 */
-		if (ignore_crossmnt == 0 &&
-		    dentry == exp->ex_path.mnt->mnt_root) {
+		if (ignore_crossmnt == 0 && dentry == mnt->mnt_root) {
 			err = get_parent_attributes(exp, &parent_stat);
 			if (err)
 				goto out_nfserr;
@@ -3380,17 +3379,18 @@ static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
 }
 
 __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
-			struct svc_fh *fhp, struct svc_export *exp,
-			struct dentry *dentry, u32 *bmval,
-			struct svc_rqst *rqstp, int ignore_crossmnt)
+				 struct svc_fh *fhp, struct svc_export *exp,
+				 struct vfsmount *mnt, struct dentry *dentry,
+				 u32 *bmval, struct svc_rqst *rqstp,
+				 int ignore_crossmnt)
 {
 	struct xdr_buf dummy;
 	struct xdr_stream xdr;
 	__be32 ret;
 
 	svcxdr_init_encode_from_buffer(&xdr, &dummy, *p, words << 2);
-	ret = nfsd4_encode_fattr(&xdr, fhp, exp, dentry, bmval, rqstp,
-							ignore_crossmnt);
+	ret = nfsd4_encode_fattr(&xdr, fhp, exp, mnt, dentry, bmval, rqstp,
+				 ignore_crossmnt);
 	*p = xdr.p;
 	return ret;
 }
@@ -3409,14 +3409,16 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 			const char *name, int namlen)
 {
 	struct svc_export *exp = cd->rd_fhp->fh_export;
-	struct dentry *dentry;
+	struct path path;
 	__be32 nfserr;
 	int ignore_crossmnt = 0;
 
-	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
-	if (IS_ERR(dentry))
-		return nfserrno(PTR_ERR(dentry));
+	path.dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry,
+					      namlen);
+	if (IS_ERR(path.dentry))
+		return nfserrno(PTR_ERR(path.dentry));
 
+	path.mnt = mntget(cd->rd_fhp->fh_mnt);
 	exp_get(exp);
 	/*
 	 * In the case of a mountpoint, the client may be asking for
@@ -3425,7 +3427,7 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 	 * we will not follow the cross mount and will fill the attribtutes
 	 * directly from the mountpoint dentry.
 	 */
-	if (nfsd_mountpoint(dentry, exp)) {
+	if (nfsd_mountpoint(path.dentry, exp)) {
 		int err;
 
 		if (!(exp->ex_flags & NFSEXP_V4ROOT)
@@ -3434,11 +3436,11 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 			goto out_encode;
 		}
 		/*
-		 * Why the heck aren't we just using nfsd_lookup??
+		 * Why the heck aren't we just using nfsd_lookup_dentry??
 		 * Different "."/".." handling?  Something else?
 		 * At least, add a comment here to explain....
 		 */
-		err = nfsd_cross_mnt(cd->rd_rqstp, &dentry, &exp);
+		err = nfsd_cross_mnt(cd->rd_rqstp, &path, &exp);
 		if (err) {
 			nfserr = nfserrno(err);
 			goto out_put;
@@ -3446,13 +3448,13 @@ nfsd4_encode_dirent_fattr(struct xdr_stream *xdr, struct nfsd4_readdir *cd,
 		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
 		if (nfserr)
 			goto out_put;
-
 	}
 out_encode:
-	nfserr = nfsd4_encode_fattr(xdr, NULL, exp, dentry, cd->rd_bmval,
-					cd->rd_rqstp, ignore_crossmnt);
+	nfserr = nfsd4_encode_fattr(xdr, NULL, exp, path.mnt, path.dentry,
+				    cd->rd_bmval, cd->rd_rqstp,
+				    ignore_crossmnt);
 out_put:
-	dput(dentry);
+	path_put(&path);
 	exp_put(exp);
 	return nfserr;
 }
@@ -3651,8 +3653,9 @@ nfsd4_encode_getattr(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4
 	struct svc_fh *fhp = getattr->ga_fhp;
 	struct xdr_stream *xdr = resp->xdr;
 
-	return nfsd4_encode_fattr(xdr, fhp, fhp->fh_export, fhp->fh_dentry,
-				    getattr->ga_bmval, resp->rqstp, 0);
+	return nfsd4_encode_fattr(xdr, fhp, fhp->fh_export,
+				  fhp->fh_mnt, fhp->fh_dentry,
+				  getattr->ga_bmval, resp->rqstp, 0);
 }
 
 static __be32
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c475d2271f9c..0bf7ac13ae50 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -299,6 +299,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	}
 
 	fhp->fh_dentry = dentry;
+	fhp->fh_mnt = mntget(exp->ex_path.mnt);
 	fhp->fh_export = exp;
 
 	switch (rqstp->rq_vers) {
@@ -556,7 +557,7 @@ static void set_version_and_fsid_type(struct svc_fh *fhp, struct svc_export *exp
 }
 
 __be32
-fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
+fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct path *path,
 	   struct svc_fh *ref_fh)
 {
 	/* ref_fh is a reference file handle.
@@ -567,13 +568,13 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	 *
 	 */
 
-	struct inode * inode = d_inode(dentry);
+	struct inode * inode = d_inode(path->dentry);
 	dev_t ex_dev = exp_sb(exp)->s_dev;
 
 	dprintk("nfsd: fh_compose(exp %02x:%02x/%ld %pd2, ino=%ld)\n",
 		MAJOR(ex_dev), MINOR(ex_dev),
 		(long) d_inode(exp->ex_path.dentry)->i_ino,
-		dentry,
+		path->dentry,
 		(inode ? inode->i_ino : 0));
 
 	/* Choose filehandle version and fsid type based on
@@ -590,14 +591,15 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 
 	if (fhp->fh_locked || fhp->fh_dentry) {
 		printk(KERN_ERR "fh_compose: fh %pd2 not initialized!\n",
-		       dentry);
+		       path->dentry);
 	}
 	if (fhp->fh_maxsize < NFS_FHSIZE)
 		printk(KERN_ERR "fh_compose: called with maxsize %d! %pd2\n",
 		       fhp->fh_maxsize,
-		       dentry);
+		       path->dentry);
 
-	fhp->fh_dentry = dget(dentry); /* our internal copy */
+	fhp->fh_dentry = dget(path->dentry); /* our internal copy */
+	fhp->fh_mnt = mntget(path->mnt);
 	fhp->fh_export = exp_get(exp);
 
 	if (fhp->fh_handle.fh_version == 0xca) {
@@ -609,9 +611,9 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 		fhp->fh_handle.ofh_xdev = fhp->fh_handle.ofh_dev;
 		fhp->fh_handle.ofh_xino =
 			ino_t_to_u32(d_inode(exp->ex_path.dentry)->i_ino);
-		fhp->fh_handle.ofh_dirino = ino_t_to_u32(parent_ino(dentry));
+		fhp->fh_handle.ofh_dirino = ino_t_to_u32(parent_ino(path->dentry));
 		if (inode)
-			_fh_update_old(dentry, exp, &fhp->fh_handle);
+			_fh_update_old(path->dentry, exp, &fhp->fh_handle);
 	} else {
 		fhp->fh_handle.fh_size =
 			key_len(fhp->fh_handle.fh_fsid_type) + 4;
@@ -624,7 +626,7 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 			exp->ex_fsid, exp->ex_uuid);
 
 		if (inode)
-			_fh_update(fhp, exp, dentry);
+			_fh_update(fhp, exp, path->dentry);
 		if (fhp->fh_handle.fh_fileid_type == FILEID_INVALID) {
 			fh_put(fhp);
 			return nfserr_opnotsupp;
@@ -675,8 +677,10 @@ fh_update(struct svc_fh *fhp)
 void
 fh_put(struct svc_fh *fhp)
 {
-	struct dentry * dentry = fhp->fh_dentry;
-	struct svc_export * exp = fhp->fh_export;
+	struct dentry *dentry = fhp->fh_dentry;
+	struct svc_export *exp = fhp->fh_export;
+	struct vfsmount *mnt = fhp->fh_mnt;
+
 	if (dentry) {
 		fh_unlock(fhp);
 		fhp->fh_dentry = NULL;
@@ -684,6 +688,10 @@ fh_put(struct svc_fh *fhp)
 		fh_clear_wcc(fhp);
 	}
 	fh_drop_write(fhp);
+	if (mnt) {
+		mntput(mnt);
+		fhp->fh_mnt = NULL;
+	}
 	if (exp) {
 		exp_put(exp);
 		fhp->fh_export = NULL;
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 6106697adc04..26c02209babd 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -31,6 +31,7 @@ static inline ino_t u32_to_ino_t(__u32 uino)
 typedef struct svc_fh {
 	struct knfsd_fh		fh_handle;	/* FH data */
 	int			fh_maxsize;	/* max size for fh_handle */
+	struct vfsmount	*	fh_mnt;		/* mnt, possibly of subvol */
 	struct dentry *		fh_dentry;	/* validated dentry */
 	struct svc_export *	fh_export;	/* export pointer */
 
@@ -171,7 +172,7 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
  * Function prototypes
  */
 __be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
-__be32	fh_compose(struct svc_fh *, struct svc_export *, struct dentry *, struct svc_fh *);
+__be32	fh_compose(struct svc_fh *, struct svc_export *, struct path *, struct svc_fh *);
 __be32	fh_update(struct svc_fh *);
 void	fh_put(struct svc_fh *);
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 60d7c59e7935..245199b0e630 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -268,6 +268,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 	struct iattr	*attr = &argp->attrs;
 	struct inode	*inode;
 	struct dentry	*dchild;
+	struct path	path;
 	int		type, mode;
 	int		hosterr;
 	dev_t		rdev = 0, wanted = new_decode_dev(attr->ia_size);
@@ -298,7 +299,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
 		goto out_unlock;
 	}
 	fh_init(newfhp, NFS_FHSIZE);
-	resp->status = fh_compose(newfhp, dirfhp->fh_export, dchild, dirfhp);
+	path.mnt = dirfhp->fh_mnt;
+	path.dentry = dchild;
+	resp->status = fh_compose(newfhp, dirfhp->fh_export, &path, dirfhp);
 	if (!resp->status && d_really_is_negative(dchild))
 		resp->status = nfserr_noent;
 	dput(dchild);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7c32edcfd2e9..c0c6920f25a4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,27 +49,26 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
-/* 
- * Called from nfsd_lookup and encode_dirent. Check if we have crossed 
+/*
+ * Called from nfsd_lookup and encode_dirent. Check if we have crossed
  * a mount point.
- * Returns -EAGAIN or -ETIMEDOUT leaving *dpp and *expp unchanged,
- *  or nfs_ok having possibly changed *dpp and *expp
+ * Returns -EAGAIN or -ETIMEDOUT leaving *path and *expp unchanged,
+ *  or nfs_ok having possibly changed *path and *expp
  */
 int
-nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp, 
-		        struct svc_export **expp)
+nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *path_parent,
+	       struct svc_export **expp)
 {
 	struct svc_export *exp = *expp, *exp2 = NULL;
-	struct dentry *dentry = *dpp;
-	struct path path = {.mnt = mntget(exp->ex_path.mnt),
-			    .dentry = dget(dentry)};
+	struct path path = {.mnt = mntget(path_parent->mnt),
+			    .dentry = dget(path_parent->dentry)};
 	int err = 0;
 
 	err = follow_down(&path, 0);
 	if (err < 0)
 		goto out;
-	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
-	    nfsd_mountpoint(dentry, exp) == 2) {
+	if (path.mnt == path_parent->mnt && path.dentry == path_parent->dentry &&
+	    nfsd_mountpoint(path.dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */
 		path_put(&path);
 		goto out;
@@ -93,19 +92,14 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 	if (nfsd_v4client(rqstp) ||
 		(exp->ex_flags & NFSEXP_CROSSMOUNT) || EX_NOHIDE(exp2)) {
 		/* successfully crossed mount point */
-		/*
-		 * This is subtle: path.dentry is *not* on path.mnt
-		 * at this point.  The only reason we are safe is that
-		 * original mnt is pinned down by exp, so we should
-		 * put path *before* putting exp
-		 */
-		*dpp = path.dentry;
-		path.dentry = dentry;
+		path_put(path_parent);
+		*path_parent = path;
+		exp_put(exp);
 		*expp = exp2;
-		exp2 = exp;
+	} else {
+		path_put(&path);
+		exp_put(exp2);
 	}
-	path_put(&path);
-	exp_put(exp2);
 out:
 	return err;
 }
@@ -121,27 +115,30 @@ static void follow_to_parent(struct path *path)
 	path->dentry = dp;
 }
 
-static int nfsd_lookup_parent(struct svc_rqst *rqstp, struct dentry *dparent, struct svc_export **exp, struct dentry **dentryp)
+static int nfsd_lookup_parent(struct svc_rqst *rqstp, struct svc_export **exp,
+			      struct path *path)
 {
+	struct path path2;
 	struct svc_export *exp2;
-	struct path path = {.mnt = mntget((*exp)->ex_path.mnt),
-			    .dentry = dget(dparent)};
 
-	follow_to_parent(&path);
-
-	exp2 = rqst_exp_parent(rqstp, &path);
+	path2 = *path;
+	path_get(&path2);
+	follow_to_parent(&path2);
+	exp2 = rqst_exp_parent(rqstp, path);
 	if (PTR_ERR(exp2) == -ENOENT) {
-		*dentryp = dget(dparent);
+		/* leave path unchanged */
+		path_put(&path2);
+		return 0;
 	} else if (IS_ERR(exp2)) {
-		path_put(&path);
+		path_put(&path2);
 		return PTR_ERR(exp2);
 	} else {
-		*dentryp = dget(path.dentry);
+		path_put(path);
+		*path = path2;
 		exp_put(*exp);
 		*exp = exp2;
+		return 0;
 	}
-	path_put(&path);
-	return 0;
 }
 
 /*
@@ -172,29 +169,32 @@ int nfsd_mountpoint(struct dentry *dentry, struct svc_export *exp)
 __be32
 nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		   const char *name, unsigned int len,
-		   struct svc_export **exp_ret, struct dentry **dentry_ret)
+		   struct svc_export **exp_ret, struct path *ret)
 {
 	struct svc_export	*exp;
 	struct dentry		*dparent;
-	struct dentry		*dentry;
 	int			host_err;
 
 	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name);
 
 	dparent = fhp->fh_dentry;
+	ret->mnt = mntget(fhp->fh_mnt);
 	exp = exp_get(fhp->fh_export);
 
 	/* Lookup the name, but don't follow links */
 	if (isdotent(name, len)) {
 		if (len==1)
-			dentry = dget(dparent);
+			ret->dentry = dget(dparent);
 		else if (dparent != exp->ex_path.dentry)
-			dentry = dget_parent(dparent);
+			ret->dentry = dget_parent(dparent);
 		else if (!EX_NOHIDE(exp) && !nfsd_v4client(rqstp))
-			dentry = dget(dparent); /* .. == . just like at / */
+			ret->dentry = dget(dparent); /* .. == . just like at / */
 		else {
-			/* checking mountpoint crossing is very different when stepping up */
-			host_err = nfsd_lookup_parent(rqstp, dparent, &exp, &dentry);
+			/* checking mountpoint crossing is very different when
+			 * stepping up
+			 */
+			ret->dentry = dget(dparent);
+			host_err = nfsd_lookup_parent(rqstp, &exp, ret);
 			if (host_err)
 				goto out_nfserr;
 		}
@@ -205,11 +205,13 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		 * need to take the child's i_mutex:
 		 */
 		fh_lock_nested(fhp, I_MUTEX_PARENT);
-		dentry = lookup_one_len(name, dparent, len);
-		host_err = PTR_ERR(dentry);
-		if (IS_ERR(dentry))
+		ret->dentry = lookup_one_len(name, dparent, len);
+		host_err = PTR_ERR(ret->dentry);
+		if (IS_ERR(ret->dentry)) {
+			ret->dentry = NULL;
 			goto out_nfserr;
-		if (nfsd_mountpoint(dentry, exp)) {
+		}
+		if (nfsd_mountpoint(ret->dentry, exp)) {
 			/*
 			 * We don't need the i_mutex after all.  It's
 			 * still possible we could open this (regular
@@ -219,18 +221,16 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 * and a mountpoint won't be renamed:
 			 */
 			fh_unlock(fhp);
-			if ((host_err = nfsd_cross_mnt(rqstp, &dentry, &exp))) {
-				dput(dentry);
+			if ((host_err = nfsd_cross_mnt(rqstp, ret, &exp)))
 				goto out_nfserr;
-			}
 		}
 	}
-	*dentry_ret = dentry;
 	*exp_ret = exp;
 	return 0;
 
 out_nfserr:
 	exp_put(exp);
+	path_put(ret);
 	return nfserrno(host_err);
 }
 
@@ -251,13 +251,13 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 				unsigned int len, struct svc_fh *resfh)
 {
 	struct svc_export	*exp;
-	struct dentry		*dentry;
+	struct path		path;
 	__be32 err;
 
 	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
 	if (err)
 		return err;
-	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
+	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &path);
 	if (err)
 		return err;
 	err = check_nfsd_access(exp, rqstp);
@@ -267,11 +267,11 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
 	 * Note: we compose the file handle now, but as the
 	 * dentry may be negative, it may need to be updated.
 	 */
-	err = fh_compose(resfh, exp, dentry, fhp);
-	if (!err && d_really_is_negative(dentry))
+	err = fh_compose(resfh, exp, &path, fhp);
+	if (!err && d_really_is_negative(path.dentry))
 		err = nfserr_noent;
 out:
-	dput(dentry);
+	path_put(&path);
 	exp_put(exp);
 	return err;
 }
@@ -740,7 +740,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	__be32		err;
 	int		host_err = 0;
 
-	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.mnt = fhp->fh_mnt;
 	path.dentry = fhp->fh_dentry;
 	inode = d_inode(path.dentry);
 
@@ -1350,6 +1350,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild = NULL;
+	struct path	path;
 	__be32		err;
 	int		host_err;
 
@@ -1371,7 +1372,9 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	host_err = PTR_ERR(dchild);
 	if (IS_ERR(dchild))
 		return nfserrno(host_err);
-	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
+	path.mnt = fhp->fh_mnt;
+	path.dentry = dchild;
+	err = fh_compose(resfhp, fhp->fh_export, &path, fhp);
 	/*
 	 * We unconditionally drop our ref to dchild as fh_compose will have
 	 * already grabbed its own ref for it.
@@ -1390,11 +1393,12 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		struct svc_fh *resfhp, int createmode, u32 *verifier,
-	        bool *truncp, bool *created)
+	       char *fname, int flen, struct iattr *iap,
+	       struct svc_fh *resfhp, int createmode, u32 *verifier,
+	       bool *truncp, bool *created)
 {
 	struct dentry	*dentry, *dchild = NULL;
+	struct path	path;
 	struct inode	*dirp;
 	__be32		err;
 	int		host_err;
@@ -1436,7 +1440,9 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out;
 	}
 
-	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
+	path.mnt = fhp->fh_mnt;
+	path.dentry = dchild;
+	err = fh_compose(resfhp, fhp->fh_export, &path, fhp);
 	if (err)
 		goto out;
 
@@ -1569,7 +1575,7 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_fh *fhp, char *buf, int *lenp)
 	if (unlikely(err))
 		return err;
 
-	path.mnt = fhp->fh_export->ex_path.mnt;
+	path.mnt = fhp->fh_mnt;
 	path.dentry = fhp->fh_dentry;
 
 	if (unlikely(!d_is_symlink(path.dentry)))
@@ -1600,6 +1606,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dnew;
+	struct path	pathnew;
 	__be32		err, cerr;
 	int		host_err;
 
@@ -1633,7 +1640,9 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	fh_drop_write(fhp);
 
-	cerr = fh_compose(resfhp, fhp->fh_export, dnew, fhp);
+	pathnew.mnt = fhp->fh_mnt;
+	pathnew.dentry = dnew;
+	cerr = fh_compose(resfhp, fhp->fh_export, &pathnew, fhp);
 	dput(dnew);
 	if (err==0) err = cerr;
 out:
@@ -2107,7 +2116,7 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *fhp, struct kstatfs *stat, in
 	err = fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP | access);
 	if (!err) {
 		struct path path = {
-			.mnt	= fhp->fh_export->ex_path.mnt,
+			.mnt	= fhp->fh_mnt,
 			.dentry	= fhp->fh_dentry,
 		};
 		if (vfs_statfs(&path, stat))
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index b21b76e6b9a8..52f587716208 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -42,13 +42,13 @@ struct nfsd_file;
 typedef int (*nfsd_filldir_t)(void *, const char *, int, loff_t, u64, unsigned);
 
 /* nfsd/vfs.c */
-int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
+int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct path *,
 		                struct svc_export **expp);
 __be32		nfsd_lookup(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int, struct svc_fh *);
 __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc_fh *,
 				const char *, unsigned int,
-				struct svc_export **, struct dentry **);
+				struct svc_export **, struct path *);
 __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
 				struct iattr *, int, time64_t);
 int nfsd_mountpoint(struct dentry *, struct svc_export *);
@@ -138,7 +138,7 @@ static inline int fh_want_write(struct svc_fh *fh)
 
 	if (fh->fh_want_write)
 		return 0;
-	ret = mnt_want_write(fh->fh_export->ex_path.mnt);
+	ret = mnt_want_write(fh->fh_mnt);
 	if (!ret)
 		fh->fh_want_write = true;
 	return ret;
@@ -148,13 +148,13 @@ static inline void fh_drop_write(struct svc_fh *fh)
 {
 	if (fh->fh_want_write) {
 		fh->fh_want_write = false;
-		mnt_drop_write(fh->fh_export->ex_path.mnt);
+		mnt_drop_write(fh->fh_mnt);
 	}
 }
 
 static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 {
-	struct path p = {.mnt = fh->fh_export->ex_path.mnt,
+	struct path p = {.mnt = fh->fh_mnt,
 			 .dentry = fh->fh_dentry};
 	return nfserrno(vfs_getattr(&p, stat, STATX_BASIC_STATS,
 				    AT_STATX_SYNC_AS_STAT));
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 3e4052e3bd50..8934db5113ac 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -763,7 +763,7 @@ void nfsd4_encode_operation(struct nfsd4_compoundres *, struct nfsd4_op *);
 void nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op);
 __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 		struct svc_fh *fhp, struct svc_export *exp,
-		struct dentry *dentry,
+		struct vfsmount *mnt, struct dentry *dentry,
 		u32 *bmval, struct svc_rqst *, int ignore_crossmnt);
 extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);


