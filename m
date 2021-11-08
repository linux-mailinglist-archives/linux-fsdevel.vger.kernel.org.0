Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D604479DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 06:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhKHFPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 00:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhKHFPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:15:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723BEC061570;
        Sun,  7 Nov 2021 21:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nzuUy/RymcDXWey2K/SRNJ0dp8iKpgBkhbpM0hGxxL4=; b=MTukNndNFo7xpUENhAmjVatEPu
        BDGXech/R4FW5SDL9ituYcQvpsJPBe4lv/MrJmn2MrD6lr0rgEP3JR13/MjnTR8dM6g5UlrbFxC8v
        Yle2CRx7DA8Q3RVo6LbA6gCW2Eous6ohXI8s6sAqlPuQG5e+EICfAMuxDA2KQOWOt8cnHdN93q0jd
        3SrXrsF8IYVmrWkbTRLfeNwI3jbp0AyfIWBQPvWkvgwoXyLYZA3t9rNVw6tMtM4pl7dGY7mHF31ZT
        9xYYmsaAhseZYNlg5ZPrtol0LTpiGYVj1rTJTWqpW7o12mdLbc7IVQjf5+9wI9oz+XTlJU5h26U+f
        XjOJi98g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwtX-008AzS-1k; Mon, 08 Nov 2021 05:09:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 28/28] xfs: Support multi-page folios
Date:   Mon,  8 Nov 2021 04:05:51 +0000
Message-Id: <20211108040551.1942823-29-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that iomap has been converted, XFS is multi-page folio safe.
Indicate to the VFS that it can now create multi-page folios for XFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index e1472004170e..5380a3f001e9 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -87,6 +87,7 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
+	mapping_set_large_folios(VFS_I(ip)->i_mapping);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -336,6 +337,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
+	mapping_set_large_folios(inode->i_mapping);
 	return error;
 }
 
-- 
2.33.0

