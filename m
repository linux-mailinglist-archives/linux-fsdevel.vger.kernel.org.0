Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726C462C21E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKPPRe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiKPPRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:17:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4704FF8B;
        Wed, 16 Nov 2022 07:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2CE261E83;
        Wed, 16 Nov 2022 15:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA1EC433D7;
        Wed, 16 Nov 2022 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611850;
        bh=p23e5m8DB+OKwKhVmD1O6yeNHkOhWzyyqsVD65vSeBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0HQqOExoOnjBN1V8PkV04km2Y9lGdedL8CkqrITCb/VFyvbRXCXPbPhoxgJqh/G1
         /48k+c/B41BxHsbc4m9N98fSkWBzEu9Eq3LDsmEyZOREfTw1PHLV6VuV2r9YoLQvxH
         /QHAjsu/I0r/PCrF0Z5WnvjbZtlf5WPathtxXailBPUEOIiOZS1M3ehgVpZr79WoF7
         +ZN39A23hWVkcul/OO2mOh6ghaIAniyZ0gwUjj8QsQmyD46cLMsB9C1HhKOIjMWYat
         biLuw5WRkfVzZBGk3FsVhTUwsAGSKtKCofKdO9VEMRnrteEcSLi5xnsINyUaymcWr3
         SiL554x2Bg59A==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de
Subject: [PATCH 1/7] filelock: add a new locks_inode_context accessor function
Date:   Wed, 16 Nov 2022 10:17:20 -0500
Message-Id: <20221116151726.129217-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116151726.129217-1-jlayton@kernel.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
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

There are a number of places in the kernel that are accessing the
inode->i_flctx field without smp_load_acquire. This is required to
ensure that the caller doesn't see a partially-initialized structure.

Add a new accessor function for it to make this clear.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c         | 20 ++++++++++----------
 include/linux/fs.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 9ccf89b6c95d..07436328dd0a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -175,7 +175,7 @@ locks_get_lock_context(struct inode *inode, int type)
 	struct file_lock_context *ctx;
 
 	/* paired with cmpxchg() below */
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (likely(ctx) || type == F_UNLCK)
 		goto out;
 
@@ -194,7 +194,7 @@ locks_get_lock_context(struct inode *inode, int type)
 	 */
 	if (cmpxchg(&inode->i_flctx, NULL, ctx)) {
 		kmem_cache_free(flctx_cache, ctx);
-		ctx = smp_load_acquire(&inode->i_flctx);
+		ctx = locks_inode_context(inode);
 	}
 out:
 	trace_locks_get_lock_context(inode, type, ctx);
@@ -891,7 +891,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 	void *owner;
 	void (*func)(void);
 
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (!ctx || list_empty_careful(&ctx->flc_posix)) {
 		fl->fl_type = F_UNLCK;
 		return;
@@ -1483,7 +1483,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	new_fl->fl_flags = type;
 
 	/* typically we will check that ctx is non-NULL before calling */
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (!ctx) {
 		WARN_ON_ONCE(1);
 		goto free_lock;
@@ -1588,7 +1588,7 @@ void lease_get_mtime(struct inode *inode, struct timespec64 *time)
 	struct file_lock_context *ctx;
 	struct file_lock *fl;
 
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
 		spin_lock(&ctx->flc_lock);
 		fl = list_first_entry_or_null(&ctx->flc_lease,
@@ -1634,7 +1634,7 @@ int fcntl_getlease(struct file *filp)
 	int type = F_UNLCK;
 	LIST_HEAD(dispose);
 
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (ctx && !list_empty_careful(&ctx->flc_lease)) {
 		percpu_down_read(&file_rwsem);
 		spin_lock(&ctx->flc_lock);
@@ -1823,7 +1823,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 	struct file_lock_context *ctx;
 	LIST_HEAD(dispose);
 
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (!ctx) {
 		trace_generic_delete_lease(inode, NULL);
 		return error;
@@ -2563,7 +2563,7 @@ void locks_remove_posix(struct file *filp, fl_owner_t owner)
 	 * posix_lock_file().  Another process could be setting a lock on this
 	 * file at the same time, but we wouldn't remove that lock anyway.
 	 */
-	ctx =  smp_load_acquire(&inode->i_flctx);
+	ctx =  locks_inode_context(inode);
 	if (!ctx || list_empty(&ctx->flc_posix))
 		return;
 
@@ -2684,7 +2684,7 @@ bool vfs_inode_has_locks(struct inode *inode)
 	struct file_lock_context *ctx;
 	bool ret;
 
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (!ctx)
 		return false;
 
@@ -2865,7 +2865,7 @@ void show_fd_locks(struct seq_file *f,
 	struct file_lock_context *ctx;
 	int id = 0;
 
-	ctx = smp_load_acquire(&inode->i_flctx);
+	ctx = locks_inode_context(inode);
 	if (!ctx)
 		return;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d6cb42b7e91c..092673178e13 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1187,6 +1187,13 @@ extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
 extern bool locks_owner_has_blockers(struct file_lock_context *flctx,
 			fl_owner_t owner);
+
+static inline struct file_lock_context *
+locks_inode_context(const struct inode *inode)
+{
+	return smp_load_acquire(&inode->i_flctx);
+}
+
 #else /* !CONFIG_FILE_LOCKING */
 static inline int fcntl_getlk(struct file *file, unsigned int cmd,
 			      struct flock __user *user)
@@ -1327,6 +1334,13 @@ static inline bool locks_owner_has_blockers(struct file_lock_context *flctx,
 {
 	return false;
 }
+
+static inline struct file_lock_context *
+locks_inode_context(const struct inode *inode)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_FILE_LOCKING */
 
 static inline struct inode *file_inode(const struct file *f)
-- 
2.38.1

