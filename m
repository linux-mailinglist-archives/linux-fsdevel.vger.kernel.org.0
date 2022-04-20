Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BCB508F6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381489AbiDTSbp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381490AbiDTSbm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0238BFF;
        Wed, 20 Apr 2022 11:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A37A761B1F;
        Wed, 20 Apr 2022 18:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BC9C385A0;
        Wed, 20 Apr 2022 18:28:54 +0000 (UTC)
Subject: [PATCH RFC 3/8] NFSD: Refactor nfsd_create_setattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 20 Apr 2022 14:28:53 -0400
Message-ID: <165047933398.1829.4730484936887112886.stgit@manet.1015granger.net>
In-Reply-To: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
References: <165047903719.1829.18357114060053600197.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd like to move do_nfsd_create() out of vfs.c. Therefore
nfsd_create_setattr() needs to be made publicly visible.

Note that both call sites in vfs.c commit both the new object and
its parent directory, so just combine those common metadata commits
into nfsd_create_setattr().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   79 ++++++++++++++++++++++++++++++---------------------------
 fs/nfsd/vfs.h |    2 +
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 97fee9b33490..ed58f7d46730 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1187,14 +1187,26 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
 	return err;
 }
 
-static __be32
-nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
-			struct iattr *iap)
+/**
+ * nfsd_create_setattr - Set a created file's attributes
+ * @rqstp: RPC transaction being executed
+ * @fhp: NFS filehandle of parent directory
+ * @resfhp: NFS filehandle of new object
+ * @iap: requested attributes of new object
+ *
+ * Returns nfs_ok on success, or an nfsstat in network byte order.
+ */
+__be32
+nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		    struct svc_fh *resfhp, struct iattr *iap)
 {
+	__be32 status;
+
 	/*
-	 * Mode has already been set earlier in create:
+	 * Mode has already been set by file creation.
 	 */
 	iap->ia_valid &= ~ATTR_MODE;
+
 	/*
 	 * Setting uid/gid works only for root.  Irix appears to
 	 * send along the gid on create when it tries to implement
@@ -1202,10 +1214,31 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
 	 */
 	if (!uid_eq(current_fsuid(), GLOBAL_ROOT_UID))
 		iap->ia_valid &= ~(ATTR_UID|ATTR_GID);
+
+	/*
+	 * Callers expect new file metadata to be committed even
+	 * if the attributes have not changed.
+	 */
 	if (iap->ia_valid)
-		return nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
-	/* Callers expect file metadata to be committed here */
-	return nfserrno(commit_metadata(resfhp));
+		status = nfsd_setattr(rqstp, resfhp, iap, 0, (time64_t)0);
+	else
+		status = nfserrno(commit_metadata(resfhp));
+
+	/*
+	 * Transactional filesystems had a chance to commit changes
+	 * for both parent and child simultaneously making the
+	 * following commit_metadata a noop in many cases.
+	 */
+	if (!status)
+		status = nfserrno(commit_metadata(fhp));
+
+	/*
+	 * Update the new filehandle to pick up the new attributes.
+	 */
+	if (!status)
+		status = fh_update(resfhp);
+
+	return status;
 }
 
 /* HPUX client sometimes creates a file in mode 000, and sets size to 0.
@@ -1232,7 +1265,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry	*dentry, *dchild;
 	struct inode	*dirp;
 	__be32		err;
-	__be32		err2;
 	int		host_err;
 
 	dentry = fhp->fh_dentry;
@@ -1305,22 +1337,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err < 0)
 		goto out_nfserr;
 
-	err = nfsd_create_setattr(rqstp, resfhp, iap);
+	err = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
 
-	/*
-	 * nfsd_create_setattr already committed the child.  Transactional
-	 * filesystems had a chance to commit changes for both parent and
-	 * child simultaneously making the following commit_metadata a
-	 * noop.
-	 */
-	err2 = nfserrno(commit_metadata(fhp));
-	if (err2)
-		err = err2;
-	/*
-	 * Update the file handle to get the new inode info.
-	 */
-	if (!err)
-		err = fh_update(resfhp);
 out:
 	dput(dchild);
 	return err;
@@ -1511,20 +1529,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
  set_attr:
-	err = nfsd_create_setattr(rqstp, resfhp, iap);
-
-	/*
-	 * nfsd_create_setattr already committed the child
-	 * (and possibly also the parent).
-	 */
-	if (!err)
-		err = nfserrno(commit_metadata(fhp));
-
-	/*
-	 * Update the filehandle to get the new inode info.
-	 */
-	if (!err)
-		err = fh_update(resfhp);
+	err = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
 
  out:
 	fh_unlock(fhp);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index ccb87b2864f6..1f32a83456b0 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -69,6 +69,8 @@ __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				int type, dev_t rdev, struct svc_fh *res);
 __be32		nfsd_access(struct svc_rqst *, struct svc_fh *, u32 *, u32 *);
+__be32		nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				struct svc_fh *resfhp, struct iattr *iap);
 __be32		do_nfsd_create(struct svc_rqst *, struct svc_fh *,
 				char *name, int len, struct iattr *attrs,
 				struct svc_fh *res, int createmode,


