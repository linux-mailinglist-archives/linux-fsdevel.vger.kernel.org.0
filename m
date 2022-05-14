Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD15272FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiENQhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiENQhq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:37:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE7245BC;
        Sat, 14 May 2022 09:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E636FB80AF0;
        Sat, 14 May 2022 16:37:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748D6C340EE;
        Sat, 14 May 2022 16:37:42 +0000 (UTC)
Subject: [PATCH v2 3/8] NFSD: Refactor nfsd_create_setattr()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Sat, 14 May 2022 12:37:41 -0400
Message-ID: <165254626145.2361.5174277064974037411.stgit@bazille.1015granger.net>
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
index bbed7a986784..83c989a5d6f3 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1181,14 +1181,26 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp, u64 offset,
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
@@ -1196,10 +1208,31 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct svc_fh *resfhp,
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
@@ -1226,7 +1259,6 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct dentry	*dentry, *dchild;
 	struct inode	*dirp;
 	__be32		err;
-	__be32		err2;
 	int		host_err;
 
 	dentry = fhp->fh_dentry;
@@ -1299,22 +1331,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
@@ -1505,20 +1523,7 @@ do_nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


