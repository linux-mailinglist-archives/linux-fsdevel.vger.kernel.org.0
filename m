Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAF24EF6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 21:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFUT2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 15:28:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:33216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbfFUT2i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 15:28:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C92DAF3B;
        Fri, 21 Jun 2019 19:28:37 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        david@fromorbit.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/6] iomap: Read page from srcmap for IOMAP_COW
Date:   Fri, 21 Jun 2019 14:28:24 -0500
Message-Id: <20190621192828.28900-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190621192828.28900-1-rgoldwyn@suse.de>
References: <20190621192828.28900-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 6648957af268..8a7b20e432ef 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -655,7 +655,7 @@ __iomap_write_begin(struct inode *inode, loff_t pos, unsigned len,
 
 static int
 iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
-		struct page **pagep, struct iomap *iomap)
+		struct page **pagep, struct iomap *iomap, struct iomap *srcmap)
 {
 	const struct iomap_page_ops *page_ops = iomap->page_ops;
 	pgoff_t index = pos >> PAGE_SHIFT;
@@ -681,6 +681,8 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 
 	if (iomap->type == IOMAP_INLINE)
 		iomap_read_inline_data(inode, page, iomap);
+	else if (iomap->type == IOMAP_COW)
+		status = __iomap_write_begin(inode, pos, len, page, srcmap);
 	else if (iomap->flags & IOMAP_F_BUFFER_HEAD)
 		status = __block_write_begin_int(page, pos, len, NULL, iomap);
 	else
@@ -833,7 +835,7 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		}
 
 		status = iomap_write_begin(inode, pos, bytes, flags, &page,
-				iomap);
+				iomap, srcmap);
 		if (unlikely(status))
 			break;
 
@@ -932,7 +934,7 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 			return PTR_ERR(rpage);
 
 		status = iomap_write_begin(inode, pos, bytes,
-					   AOP_FLAG_NOFS, &page, iomap);
+					   AOP_FLAG_NOFS, &page, iomap, srcmap);
 		put_page(rpage);
 		if (unlikely(status))
 			return status;
@@ -978,13 +980,13 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
 EXPORT_SYMBOL_GPL(iomap_file_dirty);
 
 static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
-		unsigned bytes, struct iomap *iomap)
+		unsigned bytes, struct iomap *iomap, struct iomap *srcmap)
 {
 	struct page *page;
 	int status;
 
 	status = iomap_write_begin(inode, pos, bytes, AOP_FLAG_NOFS, &page,
-				   iomap);
+				   iomap, srcmap);
 	if (status)
 		return status;
 
@@ -1022,7 +1024,7 @@ iomap_zero_range_actor(struct inode *inode, loff_t pos, loff_t count,
 		if (IS_DAX(inode))
 			status = iomap_dax_zero(pos, offset, bytes, iomap);
 		else
-			status = iomap_zero(inode, pos, offset, bytes, iomap);
+			status = iomap_zero(inode, pos, offset, bytes, iomap, srcmap);
 		if (status < 0)
 			return status;
 
-- 
2.16.4

