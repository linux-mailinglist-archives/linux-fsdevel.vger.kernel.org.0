Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4272A776BB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjHIWF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHIWFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D26CC6;
        Wed,  9 Aug 2023 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hQKQ7iNKLOfj5a3qVIegk556ZInv0gN1XnkKlge+c4A=; b=48E6c2ZeK6SNLV5qI+DTQvKa8M
        8jQ1bvR8hz7+04YIm45Zx8VwwdMhZ/+eMxqyA5MjNzLWPjJnV9wT0s2kXaaB0qNxq84iqvaLiW5jY
        NSqBCgh6KCAFKKYtFPCTcBtWCcq9GeuM9+iWPp5oqUi821e6tzhyopXSIvzRudXtjM/wQkbPVAnz2
        36GrDVwCpkchkH7dMyOWHiaK/U46fnwReUxiuqBWXm7H9ThKzuU5l8ksYSoUd6zM3IZU+QCrRruwJ
        9WskQCPFFyCE+M9WnxYpXWxrPLo3tDeidtx/7+m4oNKEB8L+1+6Tx+BKcSv55NZnV0UQnKO86dO6N
        ULS3oNVQ==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJL-005xo8-2A;
        Wed, 09 Aug 2023 22:05:47 +0000
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
Subject: [PATCH 04/13] xfs: remove xfs_blkdev_put
Date:   Wed,  9 Aug 2023 15:05:36 -0700
Message-Id: <20230809220545.1308228-5-hch@lst.de>
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

There isn't much use for this trivial wrapper, especially as the NULL
check is only needed in a single call site.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_super.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d2f3ae6ba8938b..fc21e543357ef5 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -395,15 +395,6 @@ xfs_blkdev_get(
 	return error;
 }
 
-STATIC void
-xfs_blkdev_put(
-	struct xfs_mount	*mp,
-	struct block_device	*bdev)
-{
-	if (bdev)
-		blkdev_put(bdev, mp->m_super);
-}
-
 STATIC void
 xfs_close_devices(
 	struct xfs_mount	*mp)
@@ -412,13 +403,13 @@ xfs_close_devices(
 		struct block_device *logdev = mp->m_logdev_targp->bt_bdev;
 
 		xfs_free_buftarg(mp->m_logdev_targp);
-		xfs_blkdev_put(mp, logdev);
+		blkdev_put(logdev, mp->m_super);
 	}
 	if (mp->m_rtdev_targp) {
 		struct block_device *rtdev = mp->m_rtdev_targp->bt_bdev;
 
 		xfs_free_buftarg(mp->m_rtdev_targp);
-		xfs_blkdev_put(mp, rtdev);
+		blkdev_put(rtdev, mp->m_super);
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
 }
@@ -503,10 +494,11 @@ xfs_open_devices(
  out_free_ddev_targ:
 	xfs_free_buftarg(mp->m_ddev_targp);
  out_close_rtdev:
-	xfs_blkdev_put(mp, rtdev);
+	if (rtdev)
+		blkdev_put(rtdev, sb);
  out_close_logdev:
 	if (logdev && logdev != ddev)
-		xfs_blkdev_put(mp, logdev);
+		blkdev_put(logdev, sb);
 	goto out_relock;
 }
 
-- 
2.39.2

