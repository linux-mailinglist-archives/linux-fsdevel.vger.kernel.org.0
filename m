Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D841774991
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHHT6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjHHT61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:58:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4D1D3C7;
        Tue,  8 Aug 2023 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5i9GXV7tySDWUQHcbaIxRb87yMVl9hJSLmmjh+9RA7g=; b=V1C6gWoApAMsLhagGEpF52BvA8
        3txPA4gZUkV48uI00JazTqbOroaeSVEGUHldKdHU57YvrHAwT0YCobTCOylAv3Duq3X9/3Hh1OtXD
        ZFwbDahE+2pxiRKOuPZrgXqc3khRxj+1dgzOQbDFN1EYP302+ejlgb5djBquuCD4cikFeSu7lGI16
        wEGV4UMPOaEXSJpk+bvQ1peJu2hEzGmMU3gXmDrmK6ialBC8NioBBQ/rImBAMyGkbRxoLQRXvYyr0
        3q17Vv+8KHhtW8LHUraPKSaQ8xmS1sYTFEwXKWkeSbhtEOuR0o/UNEnqLWTVLaqRgjpMSaqinGnMa
        nNY+pLug==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPNK-002vdD-2D;
        Tue, 08 Aug 2023 16:16:02 +0000
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
Date:   Tue,  8 Aug 2023 09:15:51 -0700
Message-Id: <20230808161600.1099516-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808161600.1099516-1-hch@lst.de>
References: <20230808161600.1099516-1-hch@lst.de>
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
---
 fs/xfs/xfs_super.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d2f3ae6ba8938b..f00d1162815d19 100644
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
+ 	if (rtdev)
+		blkdev_put(rtdev, sb);
  out_close_logdev:
 	if (logdev && logdev != ddev)
-		xfs_blkdev_put(mp, logdev);
+		blkdev_put(logdev, sb);
 	goto out_relock;
 }
 
-- 
2.39.2

