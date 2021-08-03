Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146E53DF5B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 21:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbhHCTcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 15:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhHCTcb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:32:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC9EC061757;
        Tue,  3 Aug 2021 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kyaz/Rz/bSCjiof19r0/8BkeZwVEwIoViXF5/mhhW7o=; b=IdTCll474SU4SUOfKffebGMqNs
        K4eY3QxkRlDIGPWAFx1SsF8CWY4amwUt94jiaCwZiRz4GUSw8M9+n2NwfeOgvuz/db+Pf2mHJlM/U
        kYlrrS+bX7MBnJl36fs2EoEpnzSZRDNULdy0sScDEwNqNal/FNtWG8okwyFyy+h28GwJrO3XNL1DN
        y8i5/Ufh8rQzfPAZQ6YWJQtf5wjw8dwE9I4i8ghgyxaGDW/wt+LeA5v/HE3P0nwTRxpMeIYxWD8H6
        c8EZmw6SvWwxllWyWeSmfCowq/4guu8nJdI27j2FDkKaVQp8xtnWD0WQm9LAq1ztKT4ND55Qd+2H9
        L/sD2eQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mB08X-0051rz-It; Tue, 03 Aug 2021 19:31:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/2] iomap: Use kmap_local_page instead of kmap_atomic
Date:   Tue,  3 Aug 2021 20:31:33 +0100
Message-Id: <20210803193134.1198733-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

kmap_atomic() has the side-effect of disabling pagefaults and
preemption.  kmap_local_page() does not do this and is preferred.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index c1c8cd41ea81..8ee0211bea86 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -223,10 +223,10 @@ static int iomap_read_inline_data(struct inode *inode, struct page *page,
 	if (poff > 0)
 		iomap_page_create(inode, page);
 
-	addr = kmap_atomic(page) + poff;
+	addr = kmap_local_page(page) + poff;
 	memcpy(addr, iomap->inline_data, size);
 	memset(addr + size, 0, PAGE_SIZE - poff - size);
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 	iomap_set_range_uptodate(page, poff, PAGE_SIZE - poff);
 	return PAGE_SIZE - poff;
 }
@@ -682,9 +682,9 @@ static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
 	BUG_ON(!iomap_inline_data_valid(iomap));
 
 	flush_dcache_page(page);
-	addr = kmap_atomic(page);
-	memcpy(iomap_inline_data(iomap, pos), addr + pos, copied);
-	kunmap_atomic(addr);
+	addr = kmap_local_page(page) + pos;
+	memcpy(iomap_inline_data(iomap, pos), addr, copied);
+	kunmap_local(addr);
 
 	mark_inode_dirty(inode);
 	return copied;
-- 
2.30.2

