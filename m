Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3405776BB0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbjHARWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjHARWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 13:22:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA041212A;
        Tue,  1 Aug 2023 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PsY+MbsgOeBE0qNyqxA2FkxVtq6lybIS3fnERYydddM=; b=Vm2OJftemIv4WoAk6AEE6ZcO5i
        fsFmLxN+lpMVYKPMrkHZENthIa8UahNL3cLi+lK/VIoQ0YiHk0yCIsdjW7SowEcIlwNmLeTE0QdTI
        m+L4Pvh2EYfzvZBvlWCuql/FkIPW5jgRoClg1WW7q/vHckPhGrXvNGtRLrDIHzCFHwPGqvXzRAKmN
        PwA6uiR7Ea3RKuLMIwCcTXz/xHRQnVbFI8Dyox0KJOoLceF4R8Ex6uJ7VEyjBCTxW3eojgvhzs0w/
        cLJcr01OMPrcs+GEIChFmlOYmQAL1sW3bEAMck8+vMh2L/HaB3j5V1IhDJoMoDba+iNPVLSOdKo+E
        Oa46YRew==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQt4T-002uUH-14;
        Tue, 01 Aug 2023 17:22:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/6] fs: remove emergency_thaw_bdev
Date:   Tue,  1 Aug 2023 19:21:56 +0200
Message-Id: <20230801172201.1923299-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801172201.1923299-1-hch@lst.de>
References: <20230801172201.1923299-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold emergency_thaw_bdev into it's only caller, to prepare for buffer.c
to be built only when buffer_head support is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/buffer.c   | 6 ------
 fs/internal.h | 6 ------
 fs/super.c    | 4 +++-
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c0f..376f468e16662d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -562,12 +562,6 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
 	return err;
 }
 
-void emergency_thaw_bdev(struct super_block *sb)
-{
-	while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
-		printk(KERN_WARNING "Emergency Thaw on %pg\n", sb->s_bdev);
-}
-
 /**
  * sync_mapping_buffers - write out & wait upon a mapping's "associated" buffers
  * @mapping: the mapping which wants those buffers written
diff --git a/fs/internal.h b/fs/internal.h
index f7a3dc11102647..d538d832fd608b 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -23,16 +23,10 @@ struct mnt_idmap;
  */
 #ifdef CONFIG_BLOCK
 extern void __init bdev_cache_init(void);
-
-void emergency_thaw_bdev(struct super_block *sb);
 #else
 static inline void bdev_cache_init(void)
 {
 }
-static inline int emergency_thaw_bdev(struct super_block *sb)
-{
-	return 0;
-}
 #endif /* CONFIG_BLOCK */
 
 /*
diff --git a/fs/super.c b/fs/super.c
index e781226e28800c..bc666e7ee1a984 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1029,7 +1029,9 @@ static void do_thaw_all_callback(struct super_block *sb)
 {
 	down_write(&sb->s_umount);
 	if (sb->s_root && sb->s_flags & SB_BORN) {
-		emergency_thaw_bdev(sb);
+		if (IS_ENABLED(CONFIG_BLOCK))
+			while (sb->s_bdev && !thaw_bdev(sb->s_bdev))
+				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 		thaw_super_locked(sb);
 	} else {
 		up_write(&sb->s_umount);
-- 
2.39.2

