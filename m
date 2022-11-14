Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D675628370
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiKNPCy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbiKNPCt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:02:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09C27B0F;
        Mon, 14 Nov 2022 07:02:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF6FAB81031;
        Mon, 14 Nov 2022 15:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E8AC433D6;
        Mon, 14 Nov 2022 15:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668438163;
        bh=7aG68TuFkOb17iVe4TLCJUkh3oqnV66M5riWQvs1Rzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kl2+I0s5QEjc/Zss16XyaCl/F1RCbsjVXGlxajXfaskteM5iu24hW4kOL4/LJyk1D
         2wRV4dyKTuNWuCePOKpkowQEt4xk4d7ssKpatKncH0QICwvlbtM+xoVbAkZcjToFmp
         gANqx2Fv2IWgtCUwQTtcwXn9vyJVozNWNflTAaWnXByew2PT74l3L5+fLqh9XLgVr2
         ys2JhyFLJ4DaVnlVCKwLolAWksZUSoIUvAALu0YTe7BQlCtaGAr172zXkDVbonJrY4
         SHRubTuV5jYl7Wq/xoTIrfGGE0EiiZH2Wuvk2sAhXKTBBNu/PKAYeffwihWNBVr7E2
         VusU8gGLx6QKA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] filelock: remove redundant filp argument from vfs_lock_file
Date:   Mon, 14 Nov 2022 10:02:38 -0500
Message-Id: <20221114150240.198648-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114150240.198648-1-jlayton@kernel.org>
References: <20221114150240.198648-1-jlayton@kernel.org>
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

The existing API requires that the fl_file field be filled out when
calling it, as some underlying filesystems require that information
deep down in their call stacks.

Simplify vfs_lock_file by removing the redundant @filp argument and
using fl_file in its place.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ksmbd/smb2pdu.c  |  4 ++--
 fs/lockd/svclock.c  | 13 +++++--------
 fs/lockd/svcsubs.c  |  4 ++--
 fs/locks.c          | 13 ++++++-------
 fs/nfsd/nfs4state.c |  4 ++--
 include/linux/fs.h  |  6 +++---
 6 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f2bcd2a5fb7f..4668553be5e3 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7007,7 +7007,7 @@ int smb2_lock(struct ksmbd_work *work)
 		flock = smb_lock->fl;
 		list_del(&smb_lock->llist);
 retry:
-		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
+		rc = vfs_lock_file(smb_lock->cmd, flock, NULL);
 skip:
 		if (flags & SMB2_LOCKFLAG_UNLOCK) {
 			if (!rc) {
@@ -7129,7 +7129,7 @@ int smb2_lock(struct ksmbd_work *work)
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
-		rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
+		rc = vfs_lock_file(F_SETLK, rlock, NULL);
 		if (rc)
 			pr_err("rollback unlock fail : %d\n", rc);
 
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 4e30f3c50970..c965783b71a6 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -475,7 +475,6 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 #endif
 	struct nlm_block	*block = NULL;
 	int			error;
-	int			mode;
 	int			async_block = 0;
 	__be32			ret;
 
@@ -534,8 +533,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 
 	if (!wait)
 		lock->fl.fl_flags &= ~FL_SLEEP;
-	mode = lock_to_openmode(&lock->fl);
-	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
+	error = vfs_lock_file(F_SETLK, &lock->fl, NULL);
 	lock->fl.fl_flags &= ~FL_SLEEP;
 
 	dprintk("lockd: vfs_lock_file returned %d\n", error);
@@ -661,12 +659,10 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	lock->fl.fl_type = F_UNLCK;
 	lock->fl.fl_file = file->f_file[O_RDONLY];
 	if (lock->fl.fl_file)
-		error = vfs_lock_file(lock->fl.fl_file, F_SETLK,
-					&lock->fl, NULL);
+		error = vfs_lock_file(F_SETLK, &lock->fl, NULL);
 	lock->fl.fl_file = file->f_file[O_WRONLY];
 	if (lock->fl.fl_file)
-		error |= vfs_lock_file(lock->fl.fl_file, F_SETLK,
-					&lock->fl, NULL);
+		error |= vfs_lock_file(F_SETLK, &lock->fl, NULL);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
 }
@@ -845,7 +841,8 @@ nlmsvc_grant_blocked(struct nlm_block *block)
 	fl_start = lock->fl.fl_start;
 	fl_end = lock->fl.fl_end;
 	mode = lock_to_openmode(&lock->fl);
-	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
+	WARN_ON_ONCE(lock->fl.fl_file != file->f_file[mode]);
+	error = vfs_lock_file(F_SETLK, &lock->fl, NULL);
 	lock->fl.fl_flags &= ~FL_SLEEP;
 	lock->fl.fl_start = fl_start;
 	lock->fl.fl_end = fl_end;
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 3515f17eaf3f..33842d67daa7 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -189,10 +189,10 @@ static int nlm_unlock_files(struct nlm_file *file, const struct file_lock *fl)
 	lock.fl_flags = FL_POSIX;
 
 	lock.fl_file = file->f_file[O_RDONLY];
-	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
+	if (lock.fl_file && vfs_lock_file(F_SETLK, &lock, NULL))
 		goto out_err;
 	lock.fl_file = file->f_file[O_WRONLY];
-	if (lock.fl_file && vfs_lock_file(lock.fl_file, F_SETLK, &lock, NULL))
+	if (lock.fl_file && vfs_lock_file(F_SETLK, &lock, NULL))
 		goto out_err;
 	return 0;
 out_err:
diff --git a/fs/locks.c b/fs/locks.c
index b429d614316b..a38845633f73 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2263,7 +2263,6 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 
 /**
  * vfs_lock_file - file byte range lock
- * @filp: The file to apply the lock to
  * @cmd: type of locking operation (F_SETLK, F_GETLK, etc.)
  * @fl: The lock to be applied
  * @conf: Place to return a copy of the conflicting lock, if found.
@@ -2294,13 +2293,13 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
  * ->lm_grant() before returning to the caller with a FILE_LOCK_DEFERRED
  * return code.
  */
-int vfs_lock_file(struct file *filp, unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
+int vfs_lock_file(unsigned int cmd, struct file_lock *fl, struct file_lock *conf)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	struct file *filp = fl->fl_file;
+
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, cmd, fl);
-	else
-		return posix_lock_file(filp, fl, conf);
+	return posix_lock_file(filp, fl, conf);
 }
 EXPORT_SYMBOL_GPL(vfs_lock_file);
 
@@ -2314,7 +2313,7 @@ static int do_lock_file_wait(struct file *filp, unsigned int cmd,
 		return error;
 
 	for (;;) {
-		error = vfs_lock_file(filp, cmd, fl, NULL);
+		error = vfs_lock_file(cmd, fl, NULL);
 		if (error != FILE_LOCK_DEFERRED)
 			break;
 		error = wait_event_interruptible(fl->fl_wait,
@@ -2578,7 +2577,7 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 	lock.fl_ops = NULL;
 	lock.fl_lmops = NULL;
 
-	error = vfs_lock_file(filp, F_SETLK, &lock, NULL);
+	error = vfs_lock_file(F_SETLK, &lock, NULL);
 
 	if (lock.fl_ops && lock.fl_ops->fl_release_private)
 		lock.fl_ops->fl_release_private(&lock);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 836bd825ca4a..eab75ba9f44d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7448,7 +7448,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&nn->blocked_locks_lock);
 	}
 
-	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, conflock);
+	err = vfs_lock_file(F_SETLK, file_lock, conflock);
 	switch (err) {
 	case 0: /* success! */
 		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
@@ -7670,7 +7670,7 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 						locku->lu_length);
 	nfs4_transform_lock_offset(file_lock);
 
-	err = vfs_lock_file(nf->nf_file, F_SETLK, file_lock, NULL);
+	err = vfs_lock_file(F_SETLK, file_lock, NULL);
 	if (err) {
 		dprintk("NFSD: nfs4_locku: vfs_lock_file failed!\n");
 		goto out_nfserr;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e4d0f1fa7f9f..57b6eed9a44d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1168,7 +1168,7 @@ extern void posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
 extern int locks_delete_block(struct file_lock *);
 extern int vfs_test_lock(struct file *, struct file_lock *);
-extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
+extern int vfs_lock_file(unsigned int, struct file_lock *, struct file_lock *);
 extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
 bool vfs_file_has_locks(struct file *file);
 extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
@@ -1274,8 +1274,8 @@ static inline int vfs_test_lock(struct file *filp, struct file_lock *fl)
 	return 0;
 }
 
-static inline int vfs_lock_file(struct file *filp, unsigned int cmd,
-				struct file_lock *fl, struct file_lock *conf)
+static inline int vfs_lock_file(unsigned int cmd, struct file_lock *fl,
+				struct file_lock *conf)
 {
 	return -ENOLCK;
 }
-- 
2.38.1

