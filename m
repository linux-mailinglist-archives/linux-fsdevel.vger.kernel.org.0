Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF31D628372
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiKNPC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 10:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiKNPCu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:02:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932602CC97;
        Mon, 14 Nov 2022 07:02:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41299B80EC1;
        Mon, 14 Nov 2022 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B1AC433C1;
        Mon, 14 Nov 2022 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668438164;
        bh=/YEJK2LtCqHBbhlhoimsihvSQn+rQ9IvRz7FDueffCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CC3Ymf78D6duM1DR0TW3Qq+rseDKlOXMG/OwyVDGv0MKjNjWxQzaJR76Yvy4US69q
         5O+16tV6fwicowf6JJCZL2VEv5wO8tzk2BIJ0YD2pyC+Mf59i2Zdsm2lYz7fMotg1D
         v16W3/2uuAu7lmyU+kvDp76I4VJJHgyWZ/r+2RoFU6MzLnGZRNelirb7k6XzwYpO/i
         PVl2rr61IYZlUKIyti7KQ1+O054loDizucCzEa38MxzhgfdPciHzoqbLtk0jdTWg5p
         Ey+Iyi/Azht6h/tNI8wMw8kYigjEqAVGQIqHYi1vT3QZfTqYkgBfl9j8WhrKotc8ym
         pYVPl+vZQr9Nw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com, linux-fsdevel@vger.kernel.org
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] filelock: remove redundant filp arg from vfs_cancel_lock
Date:   Mon, 14 Nov 2022 10:02:40 -0500
Message-Id: <20221114150240.198648-4-jlayton@kernel.org>
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
 fs/lockd/svclock.c | 4 +---
 fs/locks.c         | 6 +++---
 include/linux/fs.h | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 21ee6b1c4d9e..2bced428b078 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -677,7 +677,6 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 {
 	struct nlm_block	*block;
 	int status = 0;
-	int mode;
 
 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
@@ -695,8 +694,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	if (block != NULL) {
 		struct file_lock *fl = &block->b_call->a_args.lock.fl;
 
-		mode = lock_to_openmode(fl);
-		vfs_cancel_lock(block->b_file->f_file[mode], fl);
+		vfs_cancel_lock(fl);
 		status = nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);
 	}
diff --git a/fs/locks.c b/fs/locks.c
index 0bc1808f7d98..64eeb4002bbb 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2657,14 +2657,14 @@ void locks_remove_file(struct file *filp)
 
 /**
  * vfs_cancel_lock - file byte range unblock lock
- * @filp: The file to apply the unblock to
  * @fl: The lock to be unblocked
  *
  * Used by lock managers to cancel blocked requests
  */
-int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
+int vfs_cancel_lock(struct file_lock *fl)
 {
-	WARN_ON_ONCE(filp != fl->fl_file);
+	struct file *filp = fl->fl_file;
+
 	if (filp->f_op->lock)
 		return filp->f_op->lock(filp, F_CANCELLK, fl);
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 507fa1a61bb5..d5da4c448cd8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1169,7 +1169,7 @@ extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *
 extern int locks_delete_block(struct file_lock *);
 extern int vfs_test_lock(struct file_lock *);
 extern int vfs_lock_file(unsigned int, struct file_lock *, struct file_lock *);
-extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
+extern int vfs_cancel_lock(struct file_lock *fl);
 bool vfs_file_has_locks(struct file *file);
 extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
@@ -1280,7 +1280,7 @@ static inline int vfs_lock_file(unsigned int cmd, struct file_lock *fl,
 	return -ENOLCK;
 }
 
-static inline int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
+static inline int vfs_cancel_lock(struct file_lock *fl)
 {
 	return 0;
 }
-- 
2.38.1

