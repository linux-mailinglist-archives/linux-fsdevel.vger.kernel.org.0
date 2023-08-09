Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB784776BC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjHIWGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHIWFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C1418F;
        Wed,  9 Aug 2023 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=n7uUvh2I36vtP2pdQDofTFTMFabyiLXXmy52th8BfPE=; b=ufrdTvMm6/CpESXQWsaY5Malug
        qAis15wD1DVhXisPEIDtllailQ7qcnTZF7ZYPgK+MPpRciUJ12wtAc45hKnDj+Yo58TaQBQvIht2W
        AKsl23OJ3JJKCrCY6eXed+g2qU2Fp0TnhzMfaohyL+P4GkILl2+n16qDZxQIiJ1fqrL/98sRzj0Y+
        uxn+XdFfPStfiwZROOoln3gH73GORwMAIKLFwnOPFOG7oe55Ar4qk/EL5pQm5CcUUPxVypyxKBpvl
        Mc39GxK9wViYhgPhZy/FE1zAcPseDtfxPDJRl6ADCNKg3RabldkPf6reD9x7kz8HoYeE4Jyt6gDnJ
        8OzwcIrQ==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJM-005xoM-0u;
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
Subject: [PATCH 06/13] xfs: close the external block devices in xfs_mount_free
Date:   Wed,  9 Aug 2023 15:05:38 -0700
Message-Id: <20230809220545.1308228-7-hch@lst.de>
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

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex.  Move closing the buftargs into ->kill_sb
to archive that.  Note that the flushing of the disk caches and
block device mapping invalidated needs to stay in ->put_super as the main
block device is closed in kill_block_super already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_buf.c   |  2 --
 fs/xfs/xfs_super.c | 36 ++++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e33eb17648dfed..3b903f6bce98d8 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1945,8 +1945,6 @@ xfs_free_buftarg(
 	percpu_counter_destroy(&btp->bt_io_count);
 	list_lru_destroy(&btp->bt_lru);
 
-	blkdev_issue_flush(btp->bt_bdev);
-	invalidate_bdev(btp->bt_bdev);
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
 	/* the main block device is closed by kill_block_super */
 	if (bdev != btp->bt_mount->m_super->s_bdev)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 368c05a2dea5b9..4ae3b01ed038c7 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -396,14 +396,19 @@ xfs_blkdev_get(
 }
 
 STATIC void
-xfs_close_devices(
+xfs_shutdown_devices(
 	struct xfs_mount	*mp)
 {
-	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
-		xfs_free_buftarg(mp->m_logdev_targp);
-	if (mp->m_rtdev_targp)
-		xfs_free_buftarg(mp->m_rtdev_targp);
-	xfs_free_buftarg(mp->m_ddev_targp);
+	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
+		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
+		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
+	}
+	if (mp->m_rtdev_targp) {
+		blkdev_issue_flush(mp->m_rtdev_targp->bt_bdev);
+		invalidate_bdev(mp->m_rtdev_targp->bt_bdev);
+	}
+	blkdev_issue_flush(mp->m_ddev_targp->bt_bdev);
+	invalidate_bdev(mp->m_ddev_targp->bt_bdev);
 }
 
 /*
@@ -741,6 +746,17 @@ static void
 xfs_mount_free(
 	struct xfs_mount	*mp)
 {
+	/*
+	 * Free the buftargs here because blkdev_put needs to be called outside
+	 * of sb->s_umount, which is held around the call to ->put_super.
+	 */
+	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
+		xfs_free_buftarg(mp->m_logdev_targp);
+	if (mp->m_rtdev_targp)
+		xfs_free_buftarg(mp->m_rtdev_targp);
+	if (mp->m_ddev_targp)
+		xfs_free_buftarg(mp->m_ddev_targp);
+
 	kfree(mp->m_rtname);
 	kfree(mp->m_logname);
 	kmem_free(mp);
@@ -1126,7 +1142,7 @@ xfs_fs_put_super(
 	xfs_inodegc_free_percpu(mp);
 	xfs_destroy_percpu_counters(mp);
 	xfs_destroy_mount_workqueues(mp);
-	xfs_close_devices(mp);
+	xfs_shutdown_devices(mp);
 }
 
 static long
@@ -1499,7 +1515,7 @@ xfs_fs_fill_super(
 
 	error = xfs_init_mount_workqueues(mp);
 	if (error)
-		goto out_close_devices;
+		goto out_shutdown_devices;
 
 	error = xfs_init_percpu_counters(mp);
 	if (error)
@@ -1713,8 +1729,8 @@ xfs_fs_fill_super(
 	xfs_destroy_percpu_counters(mp);
  out_destroy_workqueues:
 	xfs_destroy_mount_workqueues(mp);
- out_close_devices:
-	xfs_close_devices(mp);
+ out_shutdown_devices:
+	xfs_shutdown_devices(mp);
 	return error;
 
  out_unmount:
-- 
2.39.2

