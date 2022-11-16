Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF762BC32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiKPLj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 06:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbiKPLjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:39:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D75B85B;
        Wed, 16 Nov 2022 03:27:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2597661CF8;
        Wed, 16 Nov 2022 11:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A410C433C1;
        Wed, 16 Nov 2022 11:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668598020;
        bh=dBx066KLI/l0TeugX04sNgQiqQgNxiQSsgEXSIsffcs=;
        h=From:To:Cc:Subject:Date:From;
        b=oLTuoIVYLmKipB/qrPIE62cke0vN4lyyGGNe2y7iVJN7gtf1YEGqQZheUUj15PW8r
         +Wf5hs6V4+j6zSFOJZB8P+6sw5eP77l60s8OfdeUMu2UbwC3X6TytDe8i53fRfWxQt
         Mg40ieY7jo1aDKG5Wxg+DNYKyz7isP3qwfTHKkRypOiFBGO2rKqO8YkmSyHEdM/xUH
         FMt8Hh3AliuoRp+ydXRQ66RxNfsIuNbA4iwz3pdiPDsiQyLZci24pgPFtaXe2cVndh
         qGyS6GAY8H0l9+nXJMhY5l5rBOZb4IbhAeL09YB8i5yvf4U76iGSbBVezCuX4e+3bL
         ppgy49tN6Ntgw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     ceph-devel@vger.kernel.org, chuck.lever@oracle.com,
        Xiubo Li <xiubli@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] filelock: new helper: vfs_inode_has_locks
Date:   Wed, 16 Nov 2022 06:26:58 -0500
Message-Id: <20221116112658.8793-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Ceph has a need to know whether a particular inode has any locks set on
it. It's currently tracking that by a num_locks field in its
filp->private_data, but that's problematic as it tries to decrement this
field when releasing locks and that can race with the file being torn
down.

Add a new vfs_inode_has_locks helper that just returns whether any locks
are currently held on the inode.

Cc: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c         | 23 +++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 5876c8ff0edc..9ccf89b6c95d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2672,6 +2672,29 @@ int vfs_cancel_lock(struct file *filp, struct file_lock *fl)
 }
 EXPORT_SYMBOL_GPL(vfs_cancel_lock);
 
+/**
+ * vfs_inode_has_locks - are any file locks held on @inode?
+ * @inode: inode to check for locks
+ *
+ * Return true if there are any FL_POSIX or FL_FLOCK locks currently
+ * set on @inode.
+ */
+bool vfs_inode_has_locks(struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	bool ret;
+
+	ctx = smp_load_acquire(&inode->i_flctx);
+	if (!ctx)
+		return false;
+
+	spin_lock(&ctx->flc_lock);
+	ret = !list_empty(&ctx->flc_posix) || !list_empty(&ctx->flc_flock);
+	spin_unlock(&ctx->flc_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfs_inode_has_locks);
+
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..d6cb42b7e91c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1170,6 +1170,7 @@ extern int locks_delete_block(struct file_lock *);
 extern int vfs_test_lock(struct file *, struct file_lock *);
 extern int vfs_lock_file(struct file *, unsigned int, struct file_lock *, struct file_lock *);
 extern int vfs_cancel_lock(struct file *filp, struct file_lock *fl);
+bool vfs_inode_has_locks(struct inode *inode);
 extern int locks_lock_inode_wait(struct inode *inode, struct file_lock *fl);
 extern int __break_lease(struct inode *inode, unsigned int flags, unsigned int type);
 extern void lease_get_mtime(struct inode *, struct timespec64 *time);
-- 
2.38.1

