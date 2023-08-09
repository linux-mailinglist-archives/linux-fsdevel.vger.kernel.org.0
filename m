Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71956776BD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 00:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjHIWGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjHIWF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:05:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F29D2126;
        Wed,  9 Aug 2023 15:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kB68DmZwK80MitdBPMr8zbkuh+bDZpl9ET1tnFndqgs=; b=cMlbj/NmcItbD7S8XxA1JTZHY/
        /5HIxu65VJSGivrddkgc6edRjc5J4G7lcR9wv+EOcogyn2zqtP8X4NVYh/hSJGcK0wzYlpq+vOO7j
        FkusVCHZnUe5WFBkPOX1ZygMIzNdq3gSA7CIt6dQk2NIz32SuYLiAUraPm7a+SH1b/D9v/kb0fxtz
        s7jFEr1hQaga2FsQXhLt/tUfD/ETlvm9XSnUmvBB8ERoiz1zEUvbBG01d42yrR2h52PumboUfH4k4
        8xV0wbAEykSPS8aJg7/v06S9rCT7L6NB2Vm7mU2DZqq8iuQw6aZ5ZzgWvZ2fP9fRMUcSdlwZMDRet
        /UCz4P8A==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTrJM-005xoS-1p;
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
Subject: [PATCH 07/13] xfs: document the invalidate_bdev call in invalidate_bdev
Date:   Wed,  9 Aug 2023 15:05:39 -0700
Message-Id: <20230809220545.1308228-8-hch@lst.de>
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

Copy and paste the commit message from Darrick into a comment to explain
the seemly odd invalidate_bdev in xfs_shutdown_devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 4ae3b01ed038c7..c169beb0d8cab3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -399,6 +399,32 @@ STATIC void
 xfs_shutdown_devices(
 	struct xfs_mount	*mp)
 {
+	/*
+	 * Udev is triggered whenever anyone closes a block device or unmounts
+	 * a file systemm on a block device.
+	 * The default udev rules invoke blkid to read the fs super and create
+	 * symlinks to the bdev under /dev/disk.  For this, it uses buffered
+	 * reads through the page cache.
+	 *
+	 * xfs_db also uses buffered reads to examine metadata.  There is no
+	 * coordination between xfs_db and udev, which means that they can run
+	 * concurrently.  Note there is no coordination between the kernel and
+	 * blkid either.
+	 *
+	 * On a system with 64k pages, the page cache can cache the superblock
+	 * and the root inode (and hence the root directory) with the same 64k
+	 * page.  If udev spawns blkid after the mkfs and the system is busy
+	 * enough that it is still running when xfs_db starts up, they'll both
+	 * read from the same page in the pagecache.
+	 *
+	 * The unmount writes updated inode metadata to disk directly.  The XFS
+	 * buffer cache does not use the bdev pagecache, nor does it invalidate
+	 * the pagecache on umount.  If the above scenario occurs, the pagecache
+	 * no longer reflects what's on disk, xfs_db reads the stale metadata,
+	 * and fails to find /a.  Most of the time this succeeds because closing
+	 * a bdev invalidates the page cache, but when processes race, everyone
+	 * loses.
+	 */
 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp) {
 		blkdev_issue_flush(mp->m_logdev_targp->bt_bdev);
 		invalidate_bdev(mp->m_logdev_targp->bt_bdev);
-- 
2.39.2

