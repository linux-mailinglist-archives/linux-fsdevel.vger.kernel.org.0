Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA56C477E62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbhLPVIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241588AbhLPVHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40AC061751;
        Thu, 16 Dec 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=C/aEEIUI8R1IaR4jIAxLPfTciBIfzrBXc1+qsDU9LWQ=; b=aBSQ2v/hS8CUP+5vmDxnEbfDm2
        xNkZzKlEY251Gwp3szPLCYi1bdov1Nu8pYaqMxObQJoSWMp6K4j4MeBuhXIRue07oDRPP9wK6Y6lf
        W4itzeHSKgawVtnubEkqjdH7+ux9w4+n35RkF7hUVEV9/IOyJ3BEE+JgTaM4s8ynEyvCveDDhxQ9C
        7dj225p7o/WDzITGYj46OR6lin5M63FTJ9PHiSn3+119t834sFKZvxoaOHhQuFhVV28uC3Tsncf+J
        O35ziU7uZGD4txO3uFHWPq/OhZwI+GzZ3SH8mOYxdw2AeY53O4XjxhKRRoS5Nh9lu5uYq7LBowsxe
        6PrZGACw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyD-00Fx5o-V0; Thu, 16 Dec 2021 21:07:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 25/25] xfs: Support large folios
Date:   Thu, 16 Dec 2021 21:07:15 +0000
Message-Id: <20211216210715.3801857-26-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that iomap has been converted, XFS is large folio safe.
Indicate to the VFS that it can now create large folios for XFS.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index da4af2142a2b..cdc39f576ca1 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -87,6 +87,7 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
+	mapping_set_large_folios(VFS_I(ip)->i_mapping);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -320,6 +321,7 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
+	mapping_set_large_folios(inode->i_mapping);
 	return error;
 }
 
-- 
2.33.0

