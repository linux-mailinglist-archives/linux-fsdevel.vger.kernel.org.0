Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95531E7355
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391811AbgE2DDo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391649AbgE2C6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D085EC08C5C9;
        Thu, 28 May 2020 19:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2bQkIqpgUB37LvBPYV8/XJBmZx89qdwplflUzXZDdzY=; b=TqBqDt5yRMSJ9ijrd8mg+cAjs2
        d/wNj6Ep59Qlhnl9akruCY7xpZQWYpalWA5XpY3YbpIxRhxMR6CNM1YE0icEXb/xAD/IpGRAdN7o+
        rS/t3mcndeumHHK8vRoIUotOTHq5SHNP7dZXGeWdJiiGbW2TW/bW8Nu83QplKcOMWiOgy9zOtFpV4
        0fz9f7cRl0FDKE9q4pcFSuJblmVYJoLW4BIMAKXW51Z2rGq1Bt7N6bi02gDBXwLshKU1MlSPE0Ype
        ic6VcE0o0q5yJva6NZi11ZZL93hns8UXkK23sEy7w1ZQCOvB3Ilg2CIk6ozevT5Ex2LQkgfqcVAZv
        wllHRCyg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Rs-Al; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/39] xfs: Support large pages
Date:   Thu, 28 May 2020 19:58:05 -0700
Message-Id: <20200529025824.32296-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

There is one place which assumes the size of a page; fix it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_aops.c  | 2 +-
 fs/xfs/xfs_super.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5b25f5ee84dc..bb677ecbdf32 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -548,7 +548,7 @@ xfs_discard_page(
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	iomap_invalidatepage(page, 0, PAGE_SIZE);
+	iomap_invalidatepage(page, 0, thp_size(page));
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index abf06bf9c3f3..0c7c4afa5afd 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1793,7 +1793,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_LARGE_PAGES,
 };
 MODULE_ALIAS_FS("xfs");
 
-- 
2.26.2

