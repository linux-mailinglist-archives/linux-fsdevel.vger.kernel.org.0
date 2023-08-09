Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DB8776BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjHIWGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHIWFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF0211F;
        Wed,  9 Aug 2023 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GtxSI3G0KMvD3w3NQ4Y2DCVvtdWy77yyG+dW+Ld1Cuw=; b=E2sxgfocH2WI4hmEDrJ4Yc2ubo
        RENf+I1Kej1xIQU9lLz2KV+SaKU/5g7WagCbYjnaSon7jkrz8hx74k+IT7w+SQIvpepeer4BGS6tj
        D1jid7cnAQMaBGohr+ohsIndqqvrMcS7ncggBZ5JHLUCsc/uRJbt/wTGqM4RuL9tFWQctUmnn+RwD
        LWLAeaPh8/e/nZGakBi7qk3pCwBwQ3VwgFMN5ZvNz7gQv8QGNBZdXY3mWoiNHT+AysV62G7anjy5W
        rQuu52bBc9eE9s0aEgxokvdrHrrEtHZuD4Ndcm/3bRvoxwzWSdNffJbRWd0UEabxGF8pPA0NUYklw
        hOxwjQ4w==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJL-005xoK-39;
        Wed, 09 Aug 2023 22:05:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: [PATCH 05/13] xfs: close the RT and log block devices in xfs_free_buftarg
Date:   Wed,  9 Aug 2023 15:05:37 -0700
Message-Id: <20230809220545.1308228-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809220545.1308228-1-hch@lst.de>
References: <20230809220545.1308228-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Closing the block devices logically belongs into xfs_free_buftarg,  So
instead of open coding it in the caller move it there and add a check
for the s_bdev so that the main device isn't close as that's done by the
VFS helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_buf.c   |  5 +++++
 fs/xfs/xfs_super.c | 12 ++----------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 15d1e5a7c2d340..e33eb17648dfed 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1938,6 +1938,8 @@ void
 xfs_free_buftarg(
 	struct xfs_buftarg	*btp)
 {
+	struct block_device	*bdev = btp->bt_bdev;
+
 	unregister_shrinker(&btp->bt_shrinker);
 	ASSERT(percpu_counter_sum(&btp->bt_io_count) == 0);
 	percpu_counter_destroy(&btp->bt_io_count);
@@ -1946,6 +1948,9 @@ xfs_free_buftarg(
 	blkdev_issue_flush(btp->bt_bdev);
 	invalidate_bdev(btp->bt_bdev);
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
+	/* the main block device is closed by kill_block_super */
+	if (bdev != btp->bt_mount->m_super->s_bdev)
+		blkdev_put(bdev, btp->bt_mount->m_super);
 
 	kmem_free(btp);
 }
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fc21e543357ef5..368c05a2dea5b9 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -399,18 +399,10 @@ STATIC void
 xfs_close_devices(
 	struct xfs_mount	*mp)
 {
-	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
-		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
-
+	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
 		xfs_free_buftarg(mp->m_logdev_targp);
-		blkdev_put(logdev, mp->m_super);
-	}
-	if (mp->m_rtdev_targp) {
-		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
-
+	if (mp->m_rtdev_targp)
 		xfs_free_buftarg(mp->m_rtdev_targp);
-		blkdev_put(rtdev, mp->m_super);
-	}
 	xfs_free_buftarg(mp->m_ddev_targp);
 }
 
-- 
2.39.2

