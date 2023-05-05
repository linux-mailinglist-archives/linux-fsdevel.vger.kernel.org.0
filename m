Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A716F882A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 19:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjEERxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 13:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjEERxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 13:53:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517491A614;
        Fri,  5 May 2023 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2SmGIpoDx0Ds5vs7kDwnN/QWoJfhRzBJ9mJDaeg/+bk=; b=haNSkBRxXecHMPmvns4lB4M/Xa
        QMRkLTeIgQzH13hTk8Ha3ZumDptcETH0RMgQghByd4StNvkWMEKih3fTZv2Wfe1sYvs78oI35w4aa
        IHYCpBJ9j5QOP5WRS+ZMtRG5iQVbsl1b5UhPR+1GLPbNa05t7108KsoTpHi9Er32/f5qP7vjA6U9y
        X8Q1roWrIHXtLx5xePRDArLOwVH2cpt9bD1A2BM9Ow6jm3tPFa3f/5p2e2cGoOO4BNqzORWy3KCz5
        EIojBxbljkNE/5d9MYWuwvT1SsMuG/KhpnUjVhQZW9LyOyw0iPpp3RksxJAAFa0pZCL0jRw+JrJc8
        SDiFy5oA==;
Received: from 66-46-223-221.dedicated.allstream.net ([66.46.223.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puzb3-00BSyZ-0j;
        Fri, 05 May 2023 17:51:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH 9/9] xfs: wire up the ->mark_dead holder operation for log and RT devices
Date:   Fri,  5 May 2023 13:51:32 -0400
Message-Id: <20230505175132.2236632-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505175132.2236632-1-hch@lst.de>
References: <20230505175132.2236632-1-hch@lst.de>
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
---
 fs/xfs/xfs_super.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 3abe5ae96cc59b..9c2401d9548d83 100644
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

