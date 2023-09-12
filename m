Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A650E79DB34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbjILVyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjILVyl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EBD110E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694555631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1sTa/BzpFwicP9t+7UWXqKyTFh/7V/E3ka3D8hs1KPY=;
        b=Ug23oL/VDmu0IiSLsq48m/Av9oYaGrvNj4Ir8B2TO9ZJ8kdw+9huA/ITSoBApu1ypM1sKB
        NLn/tKbdnZUR4dpAHs+aaYKopFU5Asj1oh/+d0eytWagU3MXNPvGB5hqxxfx9drgbF1ZLr
        7JGeYd833PqO8Oao8Iwo7vovOfyskb8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-lw8J3KKMPS-ua7R-JebFng-1; Tue, 12 Sep 2023 17:53:47 -0400
X-MC-Unique: lw8J3KKMPS-ua7R-JebFng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E481C05ABE;
        Tue, 12 Sep 2023 21:53:47 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A2E040C200A;
        Tue, 12 Sep 2023 21:53:47 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, teigland@redhat.com,
        rpeterso@redhat.com, agruenba@redhat.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, aahringo@redhat.com
Subject: [PATCHv2 nfsd/master 1/7] lockd: introduce safe async lock op
Date:   Tue, 12 Sep 2023 17:53:18 -0400
Message-Id: <20230912215324.3310111-2-aahringo@redhat.com>
In-Reply-To: <20230912215324.3310111-1-aahringo@redhat.com>
References: <20230912215324.3310111-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch reverts mostly commit 40595cdc93ed ("nfs: block notification
on fs with its own ->lock") and introduces an EXPORT_OP_ASYNC_LOCK
export flag to signal that the "own ->lock" implementation supports
async lock requests. The only main user is DLM that is used by GFS2 and
OCFS2 filesystem. Those implement their own lock() implementation and
return FILE_LOCK_DEFERRED as return value. Since commit 40595cdc93ed
("nfs: block notification on fs with its own ->lock") the DLM
implementation were never updated. This patch should prepare for DLM
to set the EXPORT_OP_ASYNC_LOCK export flag and update the DLM
plock implementation regarding to it.

Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 Documentation/filesystems/nfs/exporting.rst |  7 +++++++
 fs/lockd/svclock.c                          |  4 +---
 fs/nfsd/nfs4state.c                         | 10 +++++++---
 include/linux/exportfs.h                    | 14 ++++++++++++++
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 4b30daee399a..198d805d611c 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -241,3 +241,10 @@ following flags are defined:
     all of an inode's dirty data on last close. Exports that behave this
     way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
     waiting for writeback when closing such files.
+
+  EXPORT_OP_ASYNC_LOCK - Indicates a capable filesystem to do async lock
+    requests from lockd. Only set EXPORT_OP_ASYNC_LOCK if the filesystem has
+    it's own ->lock() functionality as core posix_lock_file() implementation
+    has no async lock request handling yet. For more information about how to
+    indicate an async lock request from a ->lock() file_operations struct, see
+    fs/locks.c and comment for the function vfs_lock_file().
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 43aeba9de55c..d500e32ebb18 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -481,9 +481,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	    struct nlm_host *host, struct nlm_lock *lock, int wait,
 	    struct nlm_cookie *cookie, int reclaim)
 {
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct inode		*inode = nlmsvc_file_inode(file);
-#endif
 	struct nlm_block	*block = NULL;
 	int			error;
 	int			mode;
@@ -497,7 +495,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
-	if (nlmsvc_file_file(file)->f_op->lock) {
+	if (!exportfs_lock_op_is_async(inode->i_sb->s_export_op)) {
 		async_block = wait;
 		wait = 0;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8534693eb6a4..7cabe882724e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7487,6 +7487,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd4_blocked_lock *nbl = NULL;
 	struct file_lock *file_lock = NULL;
 	struct file_lock *conflock = NULL;
+	struct super_block *sb;
 	__be32 status = 0;
 	int lkflg;
 	int err;
@@ -7508,6 +7509,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		dprintk("NFSD: nfsd4_lock: permission denied!\n");
 		return status;
 	}
+	sb = cstate->current_fh.fh_dentry->d_sb;
 
 	if (lock->lk_is_new) {
 		if (nfsd4_has_session(cstate))
@@ -7559,7 +7561,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate))
+			if (nfsd4_has_session(cstate) ||
+			    exportfs_lock_op_is_async(sb->s_export_op))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
@@ -7571,7 +7574,8 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			fl_type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate))
+			if (nfsd4_has_session(cstate) ||
+			    exportfs_lock_op_is_async(sb->s_export_op))
 				fl_flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
@@ -7599,7 +7603,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * for file locks), so don't attempt blocking lock notifications
 	 * on those filesystems:
 	 */
-	if (nf->nf_file->f_op->lock)
+	if (!exportfs_lock_op_is_async(sb->s_export_op))
 		fl_flags &= ~FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 11fbd0ee1370..6dd993240fcc 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -224,9 +224,23 @@ struct export_operations {
 						  atomic attribute updates
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
+#define EXPORT_OP_ASYNC_LOCK		(0x40) /* fs can do async lock request */
 	unsigned long	flags;
 };
 
+/**
+ * exportfs_lock_op_is_async() - export op supports async lock operation
+ * @export_ops:	the nfs export operations to check
+ *
+ * Returns true if the nfs export_operations structure has
+ * EXPORT_OP_ASYNC_LOCK in their flags set
+ */
+static inline bool
+exportfs_lock_op_is_async(const struct export_operations *export_ops)
+{
+	return export_ops->flags & EXPORT_OP_ASYNC_LOCK;
+}
+
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent,
 				    int flags);
-- 
2.31.1

