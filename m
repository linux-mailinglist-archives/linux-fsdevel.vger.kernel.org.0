Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362251A3341
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgDILdK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 07:33:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=3cbloTQMTK2+YtlOcpDF6XXPDlt2XsCpV5cvNUve9YA=; b=BYGcaAlYpL9TDZFXpXsktzVo7n
        BmKGNJmmycl/jjBrQ6J6jJxvHahAXw1GlbfO9fscsNUhHSgCiBT3ItQpu/9CqKoNZ+z3+DiP7KAWa
        cZOgKuiLc6X4I/6yll17V21ne+q0IdEddiK+nFskrFwXJy6i4sgT3j5sKi4BZ+sM/PDS7zMWM2FbN
        RcQkoAfYA5MeEFwC+VmvU5Huq0p8Y7gn+aWC89XTPhZHpan9M108TH8DGpkI3MdAxDrK1CTg2BsQI
        CTG6QZbp5LwZafekSY9LwUwOILJkAK/aKaWJyStiQxzPMqv/qiP1C1Q+aa62ET93xQWpK//bq/opG
        24hdniAg==;
Received: from [2001:4bb8:180:5765:8cdf:b820:7ed9:b80c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMVQi-0003lr-TM; Thu, 09 Apr 2020 11:33:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] ubifs: remove broken lazytime support
Date:   Thu,  9 Apr 2020 13:33:05 +0200
Message-Id: <20200409113305.1604965-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When "ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs" introduced atime
support to ubifs, it also added lazytime support.  As far as I can tell
the lazytime support is terminally broken, as it causes
mark_inode_dirty_sync to be called from __writeback_single_inode, which
will then trigger the locking assert in ubifs_dirty_inode.  Just remove
the broken lazytime support for now, it can be added back later,
especially as some infrastructure changes should make that easier soon.

Fixes: 8c1c5f263833 ("ubifs: introduce UBIFS_ATIME_SUPPORT to ubifs")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ubifs/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 743928efffc1..49fe062ce45e 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1375,7 +1375,6 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
 			.dirtied_ino_d = ALIGN(ui->data_len, 8) };
-	int iflags = I_DIRTY_TIME;
 	int err, release;
 
 	if (!IS_ENABLED(CONFIG_UBIFS_ATIME_SUPPORT))
@@ -1393,11 +1392,8 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
 	if (flags & S_MTIME)
 		inode->i_mtime = *time;
 
-	if (!(inode->i_sb->s_flags & SB_LAZYTIME))
-		iflags |= I_DIRTY_SYNC;
-
 	release = ui->dirty;
-	__mark_inode_dirty(inode, iflags);
+	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 	mutex_unlock(&ui->ui_mutex);
 	if (release)
 		ubifs_release_budget(c, &req);
-- 
2.25.1

