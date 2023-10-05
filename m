Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CE7BA7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjJERRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 13:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjJERQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:16:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEED3C3D
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Oct 2023 10:08:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F182C433C9;
        Thu,  5 Oct 2023 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696525728;
        bh=d84NB+X9d1rQy0bV3Ua2t/Ly3L81BRm2XA79SxQnRm4=;
        h=From:To:Cc:Subject:Date:From;
        b=oLfI+Vg6N0ZabxzIaHNr0bmREQ4i4wTFAhW9jeAULdqDsesFAnI3lDiePXBt8f8zT
         TcGPSXk7EzkcvVjlvZ/qogATmqBvK33TanBltFt9uLqz+3PDpRSQi0S8Gaue8YyDft
         aNt80M5S/wIlsuD3/pZ4nmWcT26h+ET09rr084HAcDDAvY5mw4RaXkjsC5UiJUj2Dr
         7XQZOERwj9smPRiPg7/Vo1u3HMx8xGjp2hKCafeidjFtf0Hv2L1QzwNx7YUEhX/K6+
         EE5/kqixYYMb9MMXzSpnpPeyiwG5BaExknT9VYtqnzINizTzqDmmK+3fYj+Hk6vx1A
         596VhdJRinBhg==
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] backing file: free directly
Date:   Thu,  5 Oct 2023 19:08:35 +0200
Message-Id: <20231005-sakralbau-wappnen-f5c31755ed70@brauner>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689; i=brauner@kernel.org; h=from:subject:message-id; bh=qoHdWBXAvI5VzDtDyvPn/dobJ1x4vLcXnav3nRkf6q0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTKvTXsqUx5v0ZGVfcgv/72LuvbpVvO2WewXvjv9G1Lo5Rm 381/HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPh/s7wP7d/6wLjOcpc0/9JB+jcet 882VR5wZOPSz5MPzhvz7yLRxsZGQ6uyc9Yk/s4O/vH9UVuD/asXbWvUYetvtdYIpidr2RGOjsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Backing files as used by overlayfs are never installed into file
descriptor tables and are explicitly documented as such. They aren't
subject to rcu access conditions like regular files are.

Their lifetime is bound to the lifetime of the overlayfs file, i.e.,
they're stashed in ovl_file->private_data and go away otherwise. If
they're set as vma->vm_file - which is their main purpose - then they're
subject to regular refcount rules and vma->vm_file can't be installed
into an fdtable after having been set. All in all I don't see any need
for rcu delay here. So free it directly.

This all hinges on such hybrid beasts to never actually be installed
into fdtables which - as mentioned before - is not allowed. So add an
explicit WARN_ON_ONCE() so we catch any case where someone is suddenly
trying to install one of those things into a file descriptor table so we
can have nice long chat with them.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey Linus,

I've put the following change on top of the rcu change. We really don't
need any rcu delayed freeing for backing files unless I'm missing
something. They should never ever appear in fdtables. So fd_install()
should yell if anyone tries to do that. I'm still off this week but
this bothered me.

Christian
---
 fs/file.c       | 3 +++
 fs/file_table.c | 9 +--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 666514381159..2f6965848907 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -604,6 +604,9 @@ void fd_install(unsigned int fd, struct file *file)
 	struct files_struct *files = current->files;
 	struct fdtable *fdt;
 
+	if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
+		return;
+
 	rcu_read_lock_sched();
 
 	if (unlikely(files->resize_in_progress)) {
diff --git a/fs/file_table.c b/fs/file_table.c
index a79a80031343..08fd1dd6d863 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -61,13 +61,6 @@ struct path *backing_file_real_path(struct file *f)
 }
 EXPORT_SYMBOL_GPL(backing_file_real_path);
 
-static void file_free_rcu(struct rcu_head *head)
-{
-	struct file *f = container_of(head, struct file, f_rcuhead);
-
-	kfree(backing_file(f));
-}
-
 static inline void file_free(struct file *f)
 {
 	security_file_free(f);
@@ -76,7 +69,7 @@ static inline void file_free(struct file *f)
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
 		path_put(backing_file_real_path(f));
-		call_rcu(&f->f_rcuhead, file_free_rcu);
+		kfree(backing_file(f));
 	} else {
 		kmem_cache_free(filp_cachep, f);
 	}
-- 
2.34.1

