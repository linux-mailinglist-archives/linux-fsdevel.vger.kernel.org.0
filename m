Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE67C75B0C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjGTOFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjGTOFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6A92128;
        Thu, 20 Jul 2023 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2edPrdL7m4BTLQgL/NuD1QkLdVOYHBfaZFGCvDQFQfg=; b=OwL7uhRkFeTFS6ZvjxdAWM3y1x
        RHsM4c1rRHpuWx7voqK4KAG2bGhvjTGr8Kt7Uw1rLav9sqvlOf+smv90NNU1BrwvpWhNuzQEPjJim
        SL6mMmrfLx/ZjL8JuHH7h8vFLzW8boQBAXQmwgjBuwOTGNhR5aOLTLtsUa/dG5QIZMfBIrNwGy9dF
        QtzTQ67Mn651iBrXmMGTcW6qHGY4b0TpdiUa+OZC5AyyVF0OxgqJW62fvy0q1llGNGZ+hwXJGY72W
        ghbu2Eg8o6DvtLDGj9CTT91ZgZrV9Db4wlhSdYAtBckdOPBs5857BWr6fo49nE/l7j9rfnWWOo4N/
        ef2tG8MA==;
Received: from [2001:4bb8:19a:298e:a587:c3ea:b692:5b8d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMUHB-00BKsX-1J;
        Thu, 20 Jul 2023 14:05:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] block: stop setting ->direct_IO
Date:   Thu, 20 Jul 2023 16:04:50 +0200
Message-Id: <20230720140452.63817-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720140452.63817-1-hch@lst.de>
References: <20230720140452.63817-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Direct I/O on block devices now nevers goes through aops->direct_IO.
Stop setting it and set the FMODE_CAN_ODIRECT in ->open instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index eb599a173ef02d..0c37c35003c3b7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -428,7 +428,6 @@ const struct address_space_operations def_blk_aops = {
 	.writepage	= blkdev_writepage,
 	.write_begin	= blkdev_write_begin,
 	.write_end	= blkdev_write_end,
-	.direct_IO	= blkdev_direct_IO,
 	.migrate_folio	= buffer_migrate_folio_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
 };
@@ -505,7 +504,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	 * during an unstable branch.
 	 */
 	filp->f_flags |= O_LARGEFILE;
-	filp->f_mode |= FMODE_BUF_RASYNC;
+	filp->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
 
 	/*
 	 * Use the file private data to store the holder for exclusive openes.
-- 
2.39.2

