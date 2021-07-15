Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87163C97FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhGOFFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhGOFFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:05:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65456C06175F;
        Wed, 14 Jul 2021 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+TBu3dsQSGib/JvdjedtN222MCjABnCjiAwlgdbT2YY=; b=lE8VmvNdrwB6S/ZdOcsq631oFl
        sbTbqHu27mfxXUDoKk+B0IZfyzeJxkjhEiDVXCCGD0zFsU/hckDQqmicWGSwm+1hShkHT1H38IVmC
        jH2gAm5+XTIXiL3ommIvl0O/ldcK/m7L5LlIqKxEdcFptaWCOM0XlMfH3eYJDmmmmtpI9ktiijaWf
        xT2HZSDXm/fJ+Kpf7EU4QuCBUwaiuMy783aprUpB9GLTB7+m10JDQLj9Ug2SUtOCaUcz+vqrB65a+
        h2jClrCWUi1OcEGhatiq7jvGO8ZbQVK0xwHzorSScpNxgQWPyoL01TFgQkXzcD/dQxsX+YAQJI026
        AieOnykQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tTv-002zcT-SX; Thu, 15 Jul 2021 05:00:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 104/138] iomap: Convert iomap_write_end_inline to take a folio
Date:   Thu, 15 Jul 2021 04:36:30 +0100
Message-Id: <20210715033704.692967-105-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline data only occupies a single page, but using a folio means that
we don't need to call compound_head() in PageUptodate().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c616ef1feb21..ac33f19325ab 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -662,18 +662,18 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	return copied;
 }
 
-static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
+static size_t iomap_write_end_inline(struct inode *inode, struct folio *folio,
 		struct iomap *iomap, loff_t pos, size_t copied)
 {
 	void *addr;
 
-	WARN_ON_ONCE(!PageUptodate(page));
+	WARN_ON_ONCE(!folio_test_uptodate(folio));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
-	flush_dcache_page(page);
-	addr = kmap_atomic(page);
+	flush_dcache_folio(folio);
+	addr = kmap_local_folio(folio, 0);
 	memcpy(iomap->inline_data + pos, addr + pos, copied);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 	mark_inode_dirty(inode);
 	return copied;
@@ -690,7 +690,7 @@ static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	size_t ret;
 
 	if (srcmap->type == IOMAP_INLINE) {
-		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
+		ret = iomap_write_end_inline(inode, folio, iomap, pos, copied);
 	} else if (srcmap->flags & IOMAP_F_BUFFER_HEAD) {
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
-- 
2.30.2

