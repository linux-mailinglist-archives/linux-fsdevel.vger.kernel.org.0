Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D36527305
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiENQiL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiENQiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07253245BC;
        Sat, 14 May 2022 09:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5389C61013;
        Sat, 14 May 2022 16:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875D5C340EE;
        Sat, 14 May 2022 16:38:01 +0000 (UTC)
Subject: [PATCH v2 6/8] NFSD: Remove do_nfsd_create()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Sat, 14 May 2022 12:38:00 -0400
Message-ID: <165254628063.2361.6929042734714750301.stgit@bazille.1015granger.net>
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

Now that its two callers have their own version-specific instance of
this function, do_nfsd_create() is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |  150 ---------------------------------------------------------
 fs/nfsd/vfs.h |   10 ----
 2 files changed, 160 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 83c989a5d6f3..0b0dbb8e0894 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1387,156 +1387,6 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 					rdev, resfhp);
 }
 
-/*
- * NFSv3 and NFSv4 version of nfsd_create
- */
-__be32
-do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		char *fname, int flen, struct iattr *iap,
-		struct svc_fh *resfhp, int createmode, u32 *verifier,
-	        bool *truncp, bool *created)
-{
-	struct dentry	*dentry, *dchild = NULL;
-	struct inode	*dirp;
-	__be32		err;
-	int		host_err;
-	__u32		v_mtime=0, v_atime=0;
-
-	err = nfserr_perm;
-	if (!flen)
-		goto out;
-	err = nfserr_exist;
-	if (isdotent(fname, flen))
-		goto out;
-	if (!(iap->ia_valid & ATTR_MODE))
-		iap->ia_mode = 0;
-	err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
-	if (err)
-		goto out;
-
-	dentry = fhp->fh_dentry;
-	dirp = d_inode(dentry);
-
-	host_err = fh_want_write(fhp);
-	if (host_err)
-		goto out_nfserr;
-
-	fh_lock_nested(fhp, I_MUTEX_PARENT);
-
-	/*
-	 * Compose the response file handle.
-	 */
-	dchild = lookup_one_len(fname, dentry, flen);
-	host_err = PTR_ERR(dchild);
-	if (IS_ERR(dchild))
-		goto out_nfserr;
-
-	/* If file doesn't exist, check for permissions to create one */
-	if (d_really_is_negative(dchild)) {
-		err = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
-		if (err)
-			goto out;
-	}
-
-	err = fh_compose(resfhp, fhp->fh_export, dchild, fhp);
-	if (err)
-		goto out;
-
-	if (nfsd_create_is_exclusive(createmode)) {
-		/* solaris7 gets confused (bugid 4218508) if these have
-		 * the high bit set, as do xfs filesystems without the
-		 * "bigtime" feature.  So just clear the high bits. If this is
-		 * ever changed to use different attrs for storing the
-		 * verifier, then do_open_lookup() will also need to be fixed
-		 * accordingly.
-		 */
-		v_mtime = verifier[0]&0x7fffffff;
-		v_atime = verifier[1]&0x7fffffff;
-	}
-	
-	if (d_really_is_positive(dchild)) {
-		err = 0;
-
-		switch (createmode) {
-		case NFS3_CREATE_UNCHECKED:
-			if (! d_is_reg(dchild))
-				goto out;
-			else if (truncp) {
-				/* in nfsv4, we need to treat this case a little
-				 * differently.  we don't want to truncate the
-				 * file now; this would be wrong if the OPEN
-				 * fails for some other reason.  furthermore,
-				 * if the size is nonzero, we should ignore it
-				 * according to spec!
-				 */
-				*truncp = (iap->ia_valid & ATTR_SIZE) && !iap->ia_size;
-			}
-			else {
-				iap->ia_valid &= ATTR_SIZE;
-				goto set_attr;
-			}
-			break;
-		case NFS3_CREATE_EXCLUSIVE:
-			if (   d_inode(dchild)->i_mtime.tv_sec == v_mtime
-			    && d_inode(dchild)->i_atime.tv_sec == v_atime
-			    && d_inode(dchild)->i_size  == 0 ) {
-				if (created)
-					*created = true;
-				break;
-			}
-			fallthrough;
-		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (   d_inode(dchild)->i_mtime.tv_sec == v_mtime
-			    && d_inode(dchild)->i_atime.tv_sec == v_atime
-			    && d_inode(dchild)->i_size  == 0 ) {
-				if (created)
-					*created = true;
-				goto set_attr;
-			}
-			fallthrough;
-		case NFS3_CREATE_GUARDED:
-			err = nfserr_exist;
-		}
-		goto out;
-	}
-
-	if (!IS_POSIXACL(dirp))
-		iap->ia_mode &= ~current_umask();
-
-	host_err = vfs_create(&init_user_ns, dirp, dchild, iap->ia_mode, true);
-	if (host_err < 0)
-		goto out_nfserr;
-	if (created)
-		*created = true;
-
-	nfsd_check_ignore_resizing(iap);
-
-	if (nfsd_create_is_exclusive(createmode)) {
-		/* Cram the verifier into atime/mtime */
-		iap->ia_valid = ATTR_MTIME|ATTR_ATIME
-			| ATTR_MTIME_SET|ATTR_ATIME_SET;
-		/* XXX someone who knows this better please fix it for nsec */ 
-		iap->ia_mtime.tv_sec = v_mtime;
-		iap->ia_atime.tv_sec = v_atime;
-		iap->ia_mtime.tv_nsec = 0;
-		iap->ia_atime.tv_nsec = 0;
-	}
-
- set_attr:
-	err = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
-
- out:
-	fh_unlock(fhp);
-	if (dchild && !IS_ERR(dchild))
-		dput(dchild);
-	fh_drop_write(fhp);
- 	return err;
- 
- out_nfserr:
-	err = nfserrno(host_err);
-	goto out;
-}
-
 /*
  * Read a symlink. On entry, *lenp must contain the maximum path length that
  * fits into the buffer. On return, it contains the true length.
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 1f32a83456b0..f99794b033a5 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -71,10 +71,6 @@ __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
 __be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct svc_fh *resfhp, struct iattr *iap);
-__be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
-				char *name, int len, struct iattr *attrs,
-				struct svc_fh *res, int createmode,
-				u32 *verifier, bool *truncp, bool *created);
 __be32		nfsd_commit(struct svc_rqst *rqst, struct svc_fh *fhp,
 				u64 offset, u32 count, __be32 *verf);
 #ifdef CONFIG_NFSD_V4
@@ -161,10 +157,4 @@ static inline __be32 fh_getattr(const struct svc_fh *fh, struct kstat *stat)
 				    AT_STATX_SYNC_AS_STAT));
 }
 
-static inline int nfsd_create_is_exclusive(int createmode)
-{
-	return createmode == NFS3_CREATE_EXCLUSIVE
-	       || createmode == NFS4_CREATE_EXCLUSIVE4_1;
-}
-
 #endif /* LINUX_NFSD_VFS_H */


