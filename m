Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E26EC53E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDXFtw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjDXFtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:49:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FE919B3;
        Sun, 23 Apr 2023 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bS05QMoD6j6YpGz1rHCHZCzEMuRJxwEBMPELLNqMvVM=; b=QAuUTMs9c0fPPuxtegrv+eZFd7
        m1Lb/Zn2oEdFxGNTL6MyQ1wn8x4GTSTmoDmXSEpvoQtz2+8sgXF6o1xdmIGxAfsSLMFUF2Rdb/QCw
        QELH8/3nG4bNASqOdAHA35mLeydY1xzz4dUPnNEsh0dTA/um5YWXh/LZcV75W2WYGokrA0cEhf1qA
        KKw6r1pxS24iVwx30XkH6ewxhXLH1nN6hYHJDiHEFB82PfR4sJADmcttvzNs0seHtisbFo0Bbqa9V
        n3yxCEfgi9duwfR5Ke4/YsTw+fVVP3Ub8FBS1iXniGGQbGngJEVnnvGoIEv6ORCKaN3u1LbDCqCFv
        PHlgzFNw==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp54-00FOuy-17;
        Mon, 24 Apr 2023 05:49:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/17] fs: remove emergency_thaw_bdev
Date:   Mon, 24 Apr 2023 07:49:13 +0200
Message-Id: <20230424054926.26927-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fold emergency_thaw_bdev into it's only caller, to prepare for buffer.c
to be built only when buffer_head support is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/buffer.c   | 6 ------
 fs/internal.h | 6 ------
 fs/super.c    | 4 +++-
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index eb14fbaa7d35f7..58e0007892b1c7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -563,12 +563,6 @@ static int osync_buffers_list(spinlock_t *lock, struct list_head *list)
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
index dc4eb91a577a80..cad87784eb5e0f 100644
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
index 04bc62ab7dfea9..d8f0a28d1850b1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1026,7 +1026,9 @@ static void do_thaw_all_callback(struct super_block *sb)
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

