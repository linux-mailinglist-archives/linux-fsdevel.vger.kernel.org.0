Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ECB628371
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiKNPC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiKNPCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:02:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9F27FCB;
        Mon, 14 Nov 2022 07:02:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84471B81047;
        Mon, 14 Nov 2022 15:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF57C433D7;
        Mon, 14 Nov 2022 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668438164;
        bh=rmgw+Yyv8ois3D0M3uDFibZOlPG7ljwXQjesCHxWEpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZOVIdQ17UEpp1I2LBfDeEbmJYYsP2GRur7+fxIYyXrob+/8Xmiz74vM5RulqoFKeR
         DbyF7t4vm6dRSzLSh9HYghdEH+agCUgWc17QW68ukJbeSykttrZ3MgWf4wk4gO9Jjn
         IOs4/+8bLXP7gsLPzOVFu+f5ov0TCKuWWmr0hsT7jF+X59VRqAwrgstNXsj4ZKTnaT
         Ye20o/WdDk+dcLv0m5YyOscF3W4b2pZavJQTUMTJ60UShjjKS8ourGXaKv0CgzD4Af
         OK4PJuax1YMbIo/CZj/hC03qnB/jFXaUQioXngf7EcjIXuGEqf1Rf/1+QmKCX1loii
         kjYSlo3UMH5Kg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] filelock: remove redundant filp argument from vfs_test_lock
Date:   Mon, 14 Nov 2022 10:02:39 -0500
Message-Id: <20221114150240.198648-3-jlayton@kernel.org>
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

struct file_lock already has a fl_file field that must be populated, so
the @filp argument to this function is redundant. Remove it and use
fl_file instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c  |  4 +---
 fs/locks.c          | 10 +++++-----
 fs/nfsd/nfs4state.c |  2 +-
 include/linux/fs.h  |  4 ++--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index c965783b71a6..21ee6b1c4d9e 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -586,7 +586,6 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		struct nlm_lock *conflock, struct nlm_cookie *cookie)
 {
 	int			error;
-	int			mode;
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_testlock(%s/%ld, ty=%d, %Ld-%Ld)\n",
@@ -601,8 +600,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		goto out;
 	}
 
-	mode = lock_to_openmode(&lock->fl);
-	error = vfs_test_lock(file->f_file[mode], &lock->fl);
+	error = vfs_test_lock(&lock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error == FILE_LOCK_DEFERRED)
diff --git a/fs/locks.c b/fs/locks.c
index a38845633f73..0bc1808f7d98 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2138,15 +2138,15 @@ SYSCALL_DEFINE2(flock, unsigned int, fd, unsigned int, cmd)
 
 /**
  * vfs_test_lock - test file byte range lock
- * @filp: The file to test lock for
  * @fl: The lock to test; also used to hold result
  *
  * Returns -ERRNO on failure.  Indicates presence of conflicting lock by
  * setting conf->fl_type to something other than F_UNLCK.
  */
-int vfs_test_lock(struct file *filp, struct file_lock *fl)
+int vfs_test_lock(struct file_lock *fl)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	struct file *filp = fl->fl_file;
+
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_GETLK, fl);
 	posix_test_lock(filp, fl);
@@ -2246,7 +2246,7 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 		fl->fl_owner = filp;
 	}
 
-	error = vfs_test_lock(filp, fl);
+	error = vfs_test_lock(fl);
 	if (error)
 		goto out;
 
@@ -2453,7 +2453,7 @@ int fcntl_getlk64(struct file *filp, unsigned int cmd, struct flock64 *flock)
 		fl->fl_owner = filp;
 	}
 
-	error = vfs_test_lock(filp, fl);
+	error = vfs_test_lock(fl);
 	if (error)
 		goto out;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index eab75ba9f44d..beec9da50016 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7537,7 +7537,7 @@ static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, struct
 	if (err)
 		goto out;
 	lock->fl_file = nf->nf_file;
-	err = nfserrno(vfs_test_lock(nf->nf_file, lock));
+	err = nfserrno(vfs_test_lock(lock));
 	lock->fl_file = NULL;
 out:
 	inode_unlock(inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 57b6eed9a44d..507fa1a61bb5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1167,7 +1167,7 @@ extern void locks_release_private(struct file_lock *);
 extern void posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
 extern int locks_delete_block(struct file_lock *);
-extern int vfs_test_lock(struct file *, struct file_lock *);
+extern int vfs_test_lock(struct file_lock *);
 extern int vfs_lock_file(unsigned int, struct file_lock *, struct file_lock *);
 extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
 bool vfs_file_has_locks(struct file *file);
@@ -1269,7 +1269,7 @@ static inline int locks_delete_block(struct file_lock *waiter)
 	return -ENOENT;
 }
 
-static inline int vfs_test_lock(struct file *filp, struct file_lock *fl)
+static inline int vfs_test_lock(struct file_lock *fl)
 {
 	return 0;
 }
-- 
2.38.1

