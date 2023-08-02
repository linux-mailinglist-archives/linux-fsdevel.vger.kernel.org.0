Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CA76D29E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 17:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjHBPnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjHBPma (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:42:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ACC1981;
        Wed,  2 Aug 2023 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XMPneISqjawu91NBggI2WgeuEkyhCfHxDeU0xyhMo0U=; b=wnYWuPX2W/dInPzieM+5Nh7pFL
        yIbFDEQk+eNqVEdJoQhGrQssG8MD2wHclg6aOXifn09aXcAq8V27JW/r7ja+SWV6mZhkDFDa0CDRn
        6gYzRyFjyjcdl+b9xxl1DXwN+YXWYNIQ1Jue9GjQ+XQ1GW1Fro1lrksi5uq0Ntp7kJQibSu59UXTh
        cIzojbnQjsVpPhFzkvrfICDJvZcqUbq5GMec/iIkf5Pd/l1XbuXi10+P9uSEM1S7AEGp5h9z1D9p7
        MXW0mFULgs9ZUOsSMjkKYYaYpalbMkrjOrK9FxENDFgakDcsjltK7IL0c3TwE6zk0MvlZ3bec+4bi
        Z0cMSQtg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRDzJ-005GNC-2t;
        Wed, 02 Aug 2023 15:42:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 11/12] xfs: drop s_umount over opening the log and RT devices
Date:   Wed,  2 Aug 2023 17:41:30 +0200
Message-Id: <20230802154131.2221419-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154131.2221419-1-hch@lst.de>
References: <20230802154131.2221419-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like get_tree_bdev needs to drop s_umount when opening the main
device, we need to do the same for the xfs log and RT devices to avoid a
potential lock order reversal with s_unmount for the mark_dead path.

It might be preferable to just drop s_umount over ->fill_super entirely,
but that will require a fairly massive audit first, so we'll do the easy
version here first.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 8185102431301d..d5042419ed9997 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -448,17 +448,21 @@ STATIC int
 xfs_open_devices(
 	struct xfs_mount	*mp)
 {
-	struct block_device	*ddev = mp->m_super->s_bdev;
+	struct super_block	*sb = mp->m_super;
+	struct block_device	*ddev = sb->s_bdev;
 	struct block_device	*logdev = NULL, *rtdev = NULL;
 	int			error;
 
+	/* see get_tree_bdev why this is needed and safe */
+	up_write(&sb->s_umount);
+
 	/*
 	 * Open real time and log devices - order is important.
 	 */
 	if (mp->m_logname) {
 		error = xfs_blkdev_get(mp, mp->m_logname, &logdev);
 		if (error)
-			return error;
+			goto out_unlock;
 	}
 
 	if (mp->m_rtname) {
@@ -496,7 +500,10 @@ xfs_open_devices(
 		mp->m_logdev_targp = mp->m_ddev_targp;
 	}
 
-	return 0;
+	error = 0;
+out_unlock:
+	down_write(&sb->s_umount);
+	return error;
 
  out_free_rtdev_targ:
 	if (mp->m_rtdev_targp)
@@ -508,7 +515,7 @@ xfs_open_devices(
  out_close_logdev:
 	if (logdev && logdev != ddev)
 		xfs_blkdev_put(mp, logdev);
-	return error;
+	goto out_unlock;
 }
 
 /*
-- 
2.39.2

