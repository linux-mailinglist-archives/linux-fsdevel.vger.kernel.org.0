Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133B167AAA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 07:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjAYG6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 01:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjAYG6s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:58:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75C47403;
        Tue, 24 Jan 2023 22:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jiYaBZoZNbB0DyC7ufHGMa8g4Js0DKfbCLQsl0B5ckY=; b=tTHVgQy5h7NkL2NI+FSrreUyj2
        LqeIw+WcwLrIS+N2R+gmKdizI8LYuvgAsucQHW8c0lmeDP+DeQUzl1JT3GTOWOp//iq1LEGNy2DOr
        PzUbzf5t9TeQBE3GsEWTRQsYhCucQSkCtHCjdnJu/pzZ8V52dsBc0dcR3HAEEvqq1phhHL3H0hjom
        4DWX0nIEPKNCuUXABshGaLewr9405yTv6itdIA+dowfqcN0L5Fr6b0Co+L6BjYThbxJh9SjMjM4YZ
        XSDf0kNYx6uo2Gz/c3kN0TCo2Dz+U34f+iAcR0uMiSCr/F0DZLVx01nXtKT4e8srUv4E/fnbV7QNR
        HXKMRKzg==;
Received: from [2001:4bb8:19a:27af:97a1:70ca:d917:c407] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKZk4-006CeG-RB; Wed, 25 Jan 2023 06:58:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: move sb_init_dio_done_wq out of direct-io.c
Date:   Wed, 25 Jan 2023 07:58:38 +0100
Message-Id: <20230125065839.191256-2-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125065839.191256-1-hch@lst.de>
References: <20230125065839.191256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb_init_dio_done_wq is also used by the iomap code, so move it to
super.c in preparation for building direct-io.c conditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/direct-io.c | 24 ------------------------
 fs/internal.h  |  4 +---
 fs/super.c     | 24 ++++++++++++++++++++++++
 3 files changed, 25 insertions(+), 27 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae10a..ab0d7ea89813a6 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -558,30 +558,6 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
 	return ret;
 }
 
-/*
- * Create workqueue for deferred direct IO completions. We allocate the
- * workqueue when it's first needed. This avoids creating workqueue for
- * filesystems that don't need it and also allows us to create the workqueue
- * late enough so the we can include s_id in the name of the workqueue.
- */
-int sb_init_dio_done_wq(struct super_block *sb)
-{
-	struct workqueue_struct *old;
-	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
-						      WQ_MEM_RECLAIM, 0,
-						      sb->s_id);
-	if (!wq)
-		return -ENOMEM;
-	/*
-	 * This has to be atomic as more DIOs can race to create the workqueue
-	 */
-	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
-	/* Someone created workqueue before us? Free ours... */
-	if (old)
-		destroy_workqueue(wq);
-	return 0;
-}
-
 static int dio_set_defer_completion(struct dio *dio)
 {
 	struct super_block *sb = dio->inode->i_sb;
diff --git a/fs/internal.h b/fs/internal.h
index a803cc3cf716ab..cb0c0749661aae 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -120,6 +120,7 @@ extern bool trylock_super(struct super_block *sb);
 struct super_block *user_get_super(dev_t, bool excl);
 void put_super(struct super_block *sb);
 extern bool mount_capable(struct fs_context *);
+int sb_init_dio_done_wq(struct super_block *sb);
 
 /*
  * open.c
@@ -187,9 +188,6 @@ extern void mnt_pin_kill(struct mount *m);
  */
 extern const struct dentry_operations ns_dentry_operations;
 
-/* direct-io.c: */
-int sb_init_dio_done_wq(struct super_block *sb);
-
 /*
  * fs/stat.c:
  */
diff --git a/fs/super.c b/fs/super.c
index 12c08cb20405d5..904adfbacdcf3c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1764,3 +1764,27 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
+
+/*
+ * Create workqueue for deferred direct IO completions. We allocate the
+ * workqueue when it's first needed. This avoids creating workqueue for
+ * filesystems that don't need it and also allows us to create the workqueue
+ * late enough so the we can include s_id in the name of the workqueue.
+ */
+int sb_init_dio_done_wq(struct super_block *sb)
+{
+	struct workqueue_struct *old;
+	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
+						      WQ_MEM_RECLAIM, 0,
+						      sb->s_id);
+	if (!wq)
+		return -ENOMEM;
+	/*
+	 * This has to be atomic as more DIOs can race to create the workqueue
+	 */
+	old = cmpxchg(&sb->s_dio_done_wq, NULL, wq);
+	/* Someone created workqueue before us? Free ours... */
+	if (old)
+		destroy_workqueue(wq);
+	return 0;
+}
-- 
2.39.0

