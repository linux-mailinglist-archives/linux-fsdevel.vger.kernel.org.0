Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEAC6EC599
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjDXFw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjDXFvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:51:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7E46AD;
        Sun, 23 Apr 2023 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ygZamnLPppSKQbVI2TYtcZ1SuuieTgm7wFWt/6s68PI=; b=wpOqw6FzWnc2w4juTchLC7VO9t
        ir9ELtuxBb0jOKnL07jIkpyJF+L1nWBSzPVGIhqVdKTgVpv8nsOhz6XqjGvbC4V9beDfWCniIGswt
        O9bKd9P+QqRipzQOTI8TmgW/aUC2QEQw/GLLlogXyX29WSz+zFQVPjQfpsqKsOQNqIIlcpMnx4i9l
        eK8Ns7AAgVVLldGZlqGnxg0NNJ4YeF6tqzIBhBzJQw7Kon0F3ruc0VhAPDYUTJO+38G7SJ6XlYNkX
        v0ncA0oNgduUMDrajW3dXaIsa/P7DAZvC/IznI7HvWu6OsI4XjPKJ/KK+z4OqYXElqnES62wVc7FU
        cqsVOn2Q==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp5b-00FPB8-1e;
        Mon, 24 Apr 2023 05:50:16 +0000
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
Subject: [PATCH 15/17] block: stop setting ->direct_IO
Date:   Mon, 24 Apr 2023 07:49:24 +0200
Message-Id: <20230424054926.26927-16-hch@lst.de>
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

Direct I/O on block devices now nevers goes through aops->direct_IO.
Stop setting it and set the FMODE_CAN_ODIRECT in ->open instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index fd510b6142bd57..318247832a7bcf 100644
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
@@ -481,7 +480,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	 * during an unstable branch.
 	 */
 	filp->f_flags |= O_LARGEFILE;
-	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
+	filp->f_mode |= FMODE_CAN_ODIRECT | FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
 	if (filp->f_flags & O_NDELAY)
 		filp->f_mode |= FMODE_NDELAY;
-- 
2.39.2

