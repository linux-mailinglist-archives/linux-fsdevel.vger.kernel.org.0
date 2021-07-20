Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2D3CFAD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbhGTM6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 08:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhGTM4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 08:56:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E8BC061797;
        Tue, 20 Jul 2021 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9tQ/vkftl90fUakEYwmUtyqNIiTjMWNhtPNyLLbAXC4=; b=CG28sDnc9ZabaWRAeS8SY53hiF
        C37QAZA+391g+vVM/mvA9UM0te38hfwPCzHBT9I4vJ6c0MyNjPpOGCP0Fdw7DNQ0Pb/J6VSWhy88A
        er0getgYzwBesjbTTwKBg0fZREfa+Tb3tbZ7UQoyP3JQ9k5C/P5FVJpVjh0ZkbMV0zoohIfx+AbOa
        Quylr0B9EH9N+5nyODcyoAkGXiU9cE966q1xNl6B+Mxjq6tkuAISHO05XTD3ftYkpXkKRYi/q7mM4
        S7lgyhguHpPWEpaDUl+5Hn1VY6cx9Wq0ddtwzu1NeT6hJI/BFkphT7XnX0cciWboWpkZBmCjMEXIR
        lvlOhMyg==;
Received: from [2001:4bb8:193:7660:5612:5e3c:ba3d:2b3c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5pto-0089Ke-4X; Tue, 20 Jul 2021 13:35:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] ext2: use iomap_fiemap to implement ->fiemap
Date:   Tue, 20 Jul 2021 15:33:39 +0200
Message-Id: <20210720133341.405438-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720133341.405438-1-hch@lst.de>
References: <20210720133341.405438-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch from generic_block_fiemap to use the iomap version.  The only
interesting part is that ext2_get_blocks gets confused when being
asked for overly long ranges, so copy over the limit to the inode
size from generic_block_fiemap into ext2_fiemap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext2/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 3e9a04770f49..04f0def0f5eb 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -855,8 +855,14 @@ const struct iomap_ops ext2_iomap_ops = {
 int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
-	return generic_block_fiemap(inode, fieinfo, start, len,
-				    ext2_get_block);
+	int ret;
+
+	inode_lock(inode);
+	len = min_t(u64, len, i_size_read(inode));
+	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
+	inode_unlock(inode);
+
+	return ret;
 }
 
 static int ext2_writepage(struct page *page, struct writeback_control *wbc)
-- 
2.30.2

