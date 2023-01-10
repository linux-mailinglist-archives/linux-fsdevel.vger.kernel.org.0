Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2E663E78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 11:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjAJKpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 05:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjAJKpJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:45:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D2DE92;
        Tue, 10 Jan 2023 02:45:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E802B811F3;
        Tue, 10 Jan 2023 10:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D451BC433D2;
        Tue, 10 Jan 2023 10:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673347503;
        bh=YPYCeeaaXwh7aY9GYxh7P9qUFm2HxYcXT2ViDRDG18M=;
        h=From:To:Cc:Subject:Date:From;
        b=T4KGQDjXcLDVSRJVum2jhz/hgPOD/cd4TyAv07tJxdpHHbyNBtho4qwVB1Zl4+SWF
         97PVTcWrb6DKoJsTIKilnOtrEU6pmOCsQb1FIWbkQACle0bYqUKd6TaiqVe120wVlh
         u56DaxZoOcLAP+KyU5NoHADA1jKzOQuec9bKRJsbC+OoeIZnUDOIDEgDaG/nOt+OmG
         xLN9d6h2tz3gYuieLmYsYipqXm2+ACPkvr0JdFzd+rbfxRJdIMVnzwhgqnS7hkq3+X
         ibuYsC+oKAqmrdihk391seKGuwIng6owIXGhPjoaC0zG0oX17raRjFGR5yqECwToqm
         DXRXERDNN851A==
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: remove locks_inode
Date:   Tue, 10 Jan 2023 05:44:59 -0500
Message-Id: <20230110104501.11722-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

locks_inode was turned into a wrapper around file_inode in de2a4a501e71
(Partially revert "locks: fix file locking on overlayfs"). Finish
replacing locks_inode invocations everywhere with file_inode.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/afs/flock.c              | 14 +++++++-------
 fs/lockd/clntlock.c         |  2 +-
 fs/lockd/clntproc.c         |  2 +-
 fs/locks.c                  | 28 ++++++++++++++--------------
 fs/nfsd/nfs4state.c         |  4 ++--
 fs/open.c                   |  2 +-
 include/linux/filelock.h    |  4 +---
 include/linux/lockd/lockd.h |  4 ++--
 8 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index bbcc5afd1576..9c6dea3139f5 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -451,7 +451,7 @@ static int afs_do_setlk_check(struct afs_vnode *vnode, struct key *key,
  */
 static int afs_do_setlk(struct file *file, struct file_lock *fl)
 {
-	struct inode *inode = locks_inode(file);
+	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	enum afs_flock_mode mode = AFS_FS_S(inode->i_sb)->flock_mode;
 	afs_lock_type_t type;
@@ -701,7 +701,7 @@ static int afs_do_setlk(struct file *file, struct file_lock *fl)
  */
 static int afs_do_unlk(struct file *file, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	int ret;
 
 	_enter("{%llx:%llu},%u", vnode->fid.vid, vnode->fid.vnode, fl->fl_type);
@@ -721,7 +721,7 @@ static int afs_do_unlk(struct file *file, struct file_lock *fl)
  */
 static int afs_do_getlk(struct file *file, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	struct key *key = afs_file_key(file);
 	int ret, lock_count;
 
@@ -763,7 +763,7 @@ static int afs_do_getlk(struct file *file, struct file_lock *fl)
  */
 int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	enum afs_flock_operation op;
 	int ret;
 
@@ -798,7 +798,7 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
  */
 int afs_flock(struct file *file, int cmd, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(locks_inode(file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	enum afs_flock_operation op;
 	int ret;
 
@@ -843,7 +843,7 @@ int afs_flock(struct file *file, int cmd, struct file_lock *fl)
  */
 static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(locks_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
 
 	_enter("");
 
@@ -861,7 +861,7 @@ static void afs_fl_copy_lock(struct file_lock *new, struct file_lock *fl)
  */
 static void afs_fl_release_private(struct file_lock *fl)
 {
-	struct afs_vnode *vnode = AFS_FS_I(locks_inode(fl->fl_file));
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(fl->fl_file));
 
 	_enter("");
 
diff --git a/fs/lockd/clntlock.c b/fs/lockd/clntlock.c
index a5bb3f721a9d..82b19a30e0f0 100644
--- a/fs/lockd/clntlock.c
+++ b/fs/lockd/clntlock.c
@@ -188,7 +188,7 @@ __be32 nlmclnt_grant(const struct sockaddr *addr, const struct nlm_lock *lock)
 			continue;
 		if (!rpc_cmp_addr(nlm_addr(block->b_host), addr))
 			continue;
-		if (nfs_compare_fh(NFS_FH(locks_inode(fl_blocked->fl_file)), fh) != 0)
+		if (nfs_compare_fh(NFS_FH(file_inode(fl_blocked->fl_file)), fh) != 0)
 			continue;
 		/* Alright, we found a lock. Set the return status
 		 * and wake up the caller
diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
index e875a3571c41..16b4de868cd2 100644
--- a/fs/lockd/clntproc.c
+++ b/fs/lockd/clntproc.c
@@ -131,7 +131,7 @@ static void nlmclnt_setlockargs(struct nlm_rqst *req, struct file_lock *fl)
 	char *nodename = req->a_host->h_rpcclnt->cl_nodename;
 
 	nlmclnt_next_cookie(&argp->cookie);
-	memcpy(&lock->fh, NFS_FH(locks_inode(fl->fl_file)), sizeof(struct nfs_fh));
+	memcpy(&lock->fh, NFS_FH(file_inode(fl->fl_file)), sizeof(struct nfs_fh));
 	lock->caller  = nodename;
 	lock->oh.data = req->a_owner;
 	lock->oh.len  = snprintf(req->a_owner, sizeof(req->a_owner), "%u@%s",
diff --git a/fs/locks.c b/fs/locks.c
index a5cc90c958c9..624c6ac92ede 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -234,7 +234,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list,
 				char *list_type)
 {
 	struct file_lock *fl;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 
 	list_for_each_entry(fl, list, fl_list)
 		if (fl->fl_file == filp)
@@ -888,7 +888,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 {
 	struct file_lock *cfl;
 	struct file_lock_context *ctx;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	void *owner;
 	void (*func)(void);
 
@@ -1331,7 +1331,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 int posix_lock_file(struct file *filp, struct file_lock *fl,
 			struct file_lock *conflock)
 {
-	return posix_lock_inode(locks_inode(filp), fl, conflock);
+	return posix_lock_inode(file_inode(filp), fl, conflock);
 }
 EXPORT_SYMBOL(posix_lock_file);
 
@@ -1630,7 +1630,7 @@ EXPORT_SYMBOL(lease_get_mtime);
 int fcntl_getlease(struct file *filp)
 {
 	struct file_lock *fl;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	int type = F_UNLCK;
 	LIST_HEAD(dispose);
@@ -1668,7 +1668,7 @@ int fcntl_getlease(struct file *filp)
 static int
 check_conflicting_open(struct file *filp, const long arg, int flags)
 {
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	int self_wcount = 0, self_rcount = 0;
 
 	if (flags & FL_LAYOUT)
@@ -1704,7 +1704,7 @@ static int
 generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **priv)
 {
 	struct file_lock *fl, *my_fl = NULL, *lease;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	bool is_deleg = (*flp)->fl_flags & FL_DELEG;
 	int error;
@@ -1820,7 +1820,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 {
 	int error = -EAGAIN;
 	struct file_lock *fl, *victim = NULL;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	LIST_HEAD(dispose);
 
@@ -1862,7 +1862,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
 			void **priv)
 {
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	int error;
 
 	if ((!uid_eq(current_fsuid(), inode->i_uid)) && !capable(CAP_LEASE))
@@ -2351,7 +2351,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		struct flock *flock)
 {
 	struct file_lock *file_lock = locks_alloc_lock();
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	struct file *f;
 	int error;
 
@@ -2555,7 +2555,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 void locks_remove_posix(struct file *filp, fl_owner_t owner)
 {
 	int error;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	struct file_lock lock;
 	struct file_lock_context *ctx;
 
@@ -2592,7 +2592,7 @@ static void
 locks_remove_flock(struct file *filp, struct file_lock_context *flctx)
 {
 	struct file_lock fl;
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 
 	if (list_empty(&flctx->flc_flock))
 		return;
@@ -2637,7 +2637,7 @@ void locks_remove_file(struct file *filp)
 {
 	struct file_lock_context *ctx;
 
-	ctx = locks_inode_context(locks_inode(filp));
+	ctx = locks_inode_context(file_inode(filp));
 	if (!ctx)
 		return;
 
@@ -2721,7 +2721,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 	 */
 
 	if (fl->fl_file != NULL)
-		inode = locks_inode(fl->fl_file);
+		inode = file_inode(fl->fl_file);
 
 	seq_printf(f, "%lld: ", id);
 
@@ -2862,7 +2862,7 @@ static void __show_fd_locks(struct seq_file *f,
 void show_fd_locks(struct seq_file *f,
 		  struct file *filp, struct files_struct *files)
 {
-	struct inode *inode = locks_inode(filp);
+	struct inode *inode = file_inode(filp);
 	struct file_lock_context *ctx;
 	int id = 0;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 7b2ee535ade8..b989c72e54e4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5374,7 +5374,7 @@ static int nfsd4_check_conflicting_opens(struct nfs4_client *clp,
 {
 	struct nfs4_ol_stateid *st;
 	struct file *f = fp->fi_deleg_file->nf_file;
-	struct inode *ino = locks_inode(f);
+	struct inode *ino = file_inode(f);
 	int writes;
 
 	writes = atomic_read(&ino->i_writecount);
@@ -7828,7 +7828,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
 		return status;
 	}
 
-	inode = locks_inode(nf->nf_file);
+	inode = file_inode(nf->nf_file);
 	flctx = locks_inode_context(inode);
 
 	if (flctx && !list_empty_careful(&flctx->flc_posix)) {
diff --git a/fs/open.c b/fs/open.c
index 9b1c08298a07..117ad27922a1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -871,7 +871,7 @@ static int do_dentry_open(struct file *f,
 	if (error)
 		goto cleanup_all;
 
-	error = break_lease(locks_inode(f), f->f_flags);
+	error = break_lease(file_inode(f), f->f_flags);
 	if (error)
 		goto cleanup_all;
 
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index dc5056a66e2c..efcdd1631d9b 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -133,8 +133,6 @@ struct file_lock_context {
 	struct list_head	flc_lease;
 };
 
-#define locks_inode(f) file_inode(f)
-
 #ifdef CONFIG_FILE_LOCKING
 int fcntl_getlk(struct file *, unsigned int, struct flock *);
 int fcntl_setlk(unsigned int, struct file *, unsigned int,
@@ -345,7 +343,7 @@ locks_inode_context(const struct inode *inode)
 
 static inline int locks_lock_file_wait(struct file *filp, struct file_lock *fl)
 {
-	return locks_lock_inode_wait(locks_inode(filp), fl);
+	return locks_lock_inode_wait(file_inode(filp), fl);
 }
 
 #ifdef CONFIG_FILE_LOCKING
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 70ce419e2709..2b7f067af3c4 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -312,7 +312,7 @@ static inline struct file *nlmsvc_file_file(struct nlm_file *file)
 
 static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
 {
-	return locks_inode(nlmsvc_file_file(file));
+	return file_inode(nlmsvc_file_file(file));
 }
 
 static inline int __nlm_privileged_request4(const struct sockaddr *sap)
@@ -372,7 +372,7 @@ static inline int nlm_privileged_requester(const struct svc_rqst *rqstp)
 static inline int nlm_compare_locks(const struct file_lock *fl1,
 				    const struct file_lock *fl2)
 {
-	return locks_inode(fl1->fl_file) == locks_inode(fl2->fl_file)
+	return file_inode(fl1->fl_file) == file_inode(fl2->fl_file)
 	     && fl1->fl_pid   == fl2->fl_pid
 	     && fl1->fl_owner == fl2->fl_owner
 	     && fl1->fl_start == fl2->fl_start
-- 
2.39.0

