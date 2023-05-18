Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F088F707914
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjEREYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjEREYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:24:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F03C0F;
        Wed, 17 May 2023 21:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=03mKXpnMy+5CBTfSc9DyTLTj9+GwZq7mKLCCXcotUas=; b=qZZe9IwOJP9uOL4eA9IOE8cJr1
        BJMy99Dx/eZAY1WU8WQPz8XJTUXKJupQvZsZ9KkHk7f7R+a6/qkhlMGLpBaas+0nF3Zql5veIJOL3
        U1/xIzennwDuV9y50k7kzS5oEzqlnC8Wt/BcXPxVZm4banEMONLgCAF7qdED50KrZbHIv0xllhOty
        g+ZEM/ODg8p+vgHZcsSiPkA+pyJlQhQBSxXSDuFDRtdeNuN08xLZNpDyXFuKcol5IXYQxaiIyBV2D
        ZaC+Ee6hvuBlriG2EnhjvYTjqs4ErRkiYwUvmgRMQGEr5vIsJsmezZANVLN/5epWf80hsWrBGyBhG
        3kmupHKw==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVBG-00BqTj-2U;
        Thu, 18 May 2023 04:23:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 13/13] xfs: wire up the ->mark_dead holder operation for log and RT devices
Date:   Thu, 18 May 2023 06:23:22 +0200
Message-Id: <20230518042323.663189-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
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

Implement a set of holder_ops that shut down the file system when the
block device used as log or RT device is removed undeneath the file
system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index eb469b8f9a0497..75d37bbc5415fc 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -377,6 +377,17 @@ xfs_setup_dax_always(
 	return 0;
 }
 
+static void
+xfs_hop_mark_dead(
+	struct block_device	*bdev)
+{
+	xfs_force_shutdown(bdev->bd_holder, SHUTDOWN_DEVICE_REMOVED);
+}
+
+static const struct blk_holder_ops xfs_holder_ops = {
+	.mark_dead		= xfs_hop_mark_dead,
+};
+
 STATIC int
 xfs_blkdev_get(
 	xfs_mount_t		*mp,
@@ -386,7 +397,7 @@ xfs_blkdev_get(
 	int			error = 0;
 
 	*bdevp = blkdev_get_by_path(name, FMODE_READ|FMODE_WRITE|FMODE_EXCL,
-				    mp, NULL);
+				    mp, &xfs_holder_ops);
 	if (IS_ERR(*bdevp)) {
 		error = PTR_ERR(*bdevp);
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
-- 
2.39.2

