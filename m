Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9E7527303
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiENQiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 12:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiENQh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 12:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5FF2A717;
        Sat, 14 May 2022 09:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6FC61017;
        Sat, 14 May 2022 16:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E455C340EE;
        Sat, 14 May 2022 16:37:55 +0000 (UTC)
Subject: [PATCH v2 5/8] NFSD: Refactor NFSv4 OPEN(CREATE)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Date:   Sat, 14 May 2022 12:37:54 -0400
Message-ID: <165254627429.2361.14805290330362747915.stgit@bazille.1015granger.net>
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

Copy do_nfsd_create() to nfs4proc.c and remove NFSv3-specific logic.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c |  162 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 152 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b207c76a873f..99c0485a29e9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -37,6 +37,8 @@
 #include <linux/falloc.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <linux/namei.h>
+
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_ssc.h>
 
@@ -235,6 +237,154 @@ static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_state *cstate
 			&resfh->fh_handle);
 }
 
+static inline bool nfsd4_create_is_exclusive(int createmode)
+{
+	return createmode == NFS4_CREATE_EXCLUSIVE ||
+		createmode == NFS4_CREATE_EXCLUSIVE4_1;
+}
+
+/*
+ * Implement NFSv4's unchecked, guarded, and exclusive create
+ * semantics for regular files. Open state for this new file is
+ * subsequently fabricated in nfsd4_process_open2().
+ *
+ * Upon return, caller must release @fhp and @resfhp.
+ */
+static __be32
+nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		  struct svc_fh *resfhp, struct nfsd4_open *open)
+{
+	struct iattr *iap = &open->op_iattr;
+	struct dentry *parent, *child;
+	__u32 v_mtime, v_atime;
+	struct inode *inode;
+	__be32 status;
+	int host_err;
+
+	if (isdotent(open->op_fname, open->op_fnamelen))
+		return nfserr_exist;
+	if (!(iap->ia_valid & ATTR_MODE))
+		iap->ia_mode = 0;
+
+	status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
+	if (status != nfs_ok)
+		return status;
+	parent = fhp->fh_dentry;
+	inode = d_inode(parent);
+
+	host_err = fh_want_write(fhp);
+	if (host_err)
+		return nfserrno(host_err);
+
+	fh_lock_nested(fhp, I_MUTEX_PARENT);
+
+	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
+	if (IS_ERR(child)) {
+		status = nfserrno(PTR_ERR(child));
+		goto out;
+	}
+
+	if (d_really_is_negative(child)) {
+		status = fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_CREATE);
+		if (status != nfs_ok)
+			goto out;
+	}
+
+	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
+	if (status != nfs_ok)
+		goto out;
+
+	v_mtime = 0;
+	v_atime = 0;
+	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+		u32 *verifier = (u32 *)open->op_verf.data;
+
+		/*
+		 * Solaris 7 gets confused (bugid 4218508) if these have
+		 * the high bit set, as do xfs filesystems without the
+		 * "bigtime" feature. So just clear the high bits. If this
+		 * is ever changed to use different attrs for storing the
+		 * verifier, then do_open_lookup() will also need to be
+		 * fixed accordingly.
+		 */
+		v_mtime = verifier[0] & 0x7fffffff;
+		v_atime = verifier[1] & 0x7fffffff;
+	}
+
+	if (d_really_is_positive(child)) {
+		status = nfs_ok;
+
+		switch (open->op_createmode) {
+		case NFS4_CREATE_UNCHECKED:
+			if (!d_is_reg(child))
+				break;
+
+			/*
+			 * In NFSv4, we don't want to truncate the file
+			 * now. This would be wrong if the OPEN fails for
+			 * some other reason. Furthermore, if the size is
+			 * nonzero, we should ignore it according to spec!
+			 */
+			open->op_truncate = (iap->ia_valid & ATTR_SIZE) &&
+						!iap->ia_size;
+			break;
+		case NFS4_CREATE_GUARDED:
+			status = nfserr_exist;
+			break;
+		case NFS4_CREATE_EXCLUSIVE:
+			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
+			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			    d_inode(child)->i_size == 0) {
+				open->op_created = true;
+				break;		/* subtle */
+			}
+			status = nfserr_exist;
+			break;
+		case NFS4_CREATE_EXCLUSIVE4_1:
+			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
+			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			    d_inode(child)->i_size == 0) {
+				open->op_created = true;
+				goto set_attr;	/* subtle */
+			}
+			status = nfserr_exist;
+		}
+		goto out;
+	}
+
+	if (!IS_POSIXACL(inode))
+		iap->ia_mode &= ~current_umask();
+
+	host_err = vfs_create(&init_user_ns, inode, child, iap->ia_mode, true);
+	if (host_err < 0) {
+		status = nfserrno(host_err);
+		goto out;
+	}
+	open->op_created = true;
+
+	/* A newly created file already has a file size of zero. */
+	if ((iap->ia_valid & ATTR_SIZE) && (iap->ia_size == 0))
+		iap->ia_valid &= ~ATTR_SIZE;
+	if (nfsd4_create_is_exclusive(open->op_createmode)) {
+		iap->ia_valid = ATTR_MTIME | ATTR_ATIME |
+				ATTR_MTIME_SET|ATTR_ATIME_SET;
+		iap->ia_mtime.tv_sec = v_mtime;
+		iap->ia_atime.tv_sec = v_atime;
+		iap->ia_mtime.tv_nsec = 0;
+		iap->ia_atime.tv_nsec = 0;
+	}
+
+set_attr:
+	status = nfsd_create_setattr(rqstp, fhp, resfhp, iap);
+
+out:
+	fh_unlock(fhp);
+	if (child && !IS_ERR(child))
+		dput(child);
+	fh_drop_write(fhp);
+	return status;
+}
+
 static __be32
 do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, struct nfsd4_open *open, struct svc_fh **resfh)
 {
@@ -264,16 +414,8 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * yes          | yes    | GUARDED4        | GUARDED4
 		 */
 
-		/*
-		 * Note: create modes (UNCHECKED,GUARDED...) are the same
-		 * in NFSv4 as in v3 except EXCLUSIVE4_1.
-		 */
 		current->fs->umask = open->op_umask;
-		status = do_nfsd_create(rqstp, current_fh, open->op_fname,
-					open->op_fnamelen, &open->op_iattr,
-					*resfh, open->op_createmode,
-					(u32 *)open->op_verf.data,
-					&open->op_truncate, &open->op_created);
+		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
 		current->fs->umask = 0;
 
 		if (!status && open->op_label.len)
@@ -284,7 +426,7 @@ do_open_lookup(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate, stru
 		 * use the returned bitmask to indicate which attributes
 		 * we used to store the verifier:
 		 */
-		if (nfsd_create_is_exclusive(open->op_createmode) && status == 0)
+		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
 			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
 						FATTR4_WORD1_TIME_MODIFY);
 	} else


