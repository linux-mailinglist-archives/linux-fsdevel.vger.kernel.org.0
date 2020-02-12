Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116DB159FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBLESs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:18:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=d1v/EAEwBpaURPMR3I6ceII7qxa5d8ZtTLZ0hbWs6Do=; b=mL1CBG80IxbXJemxmEvSnYtTcS
        jYbOFspXS4vCYLmFZxFeRFpnGVZaarDxMd7Zx+A8+xxrnI/aishDN6KV0ZRQZROXgV1Cp6uVe1Dpu
        KzhB6+ext1celPSo5Z0vh9t3I/hRW3rWlxqaAxl8mqwFupAxs0uB7s2YDAbnHrjogOJqWwwf7boXG
        ly1pmQBs6c8rZjvaWLBsxfK393ZA74eipLEmBsvi+ikjWyb5Ch0Mgh9Z6ZSt/qZoCvgB46ANSITp3
        p1K8PsoM75X6l/12/Kp9JbJbPBIMh0sTN9j8a/0STfTGw6GQjet2BxKwuMUYSJBnQEmjC9u4gGXE4
        oD05T5Eg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006oZ-9e; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/25] xfs: Support large pages
Date:   Tue, 11 Feb 2020 20:18:39 -0800
Message-Id: <20200212041845.25879-20-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
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
index 5573bf2957dd..0c10fd799f8c 100644
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
index 2094386af8ac..a02efa1f72af 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1779,7 +1779,7 @@ static struct file_system_type xfs_fs_type = {
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
 	.kill_sb		= kill_block_super,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_LARGE_PAGES,
 };
 MODULE_ALIAS_FS("xfs");
 
-- 
2.25.0

