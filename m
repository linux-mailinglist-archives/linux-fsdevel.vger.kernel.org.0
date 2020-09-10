Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91B82655A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgIJXr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgIJXrS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:47:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021DBC061757;
        Thu, 10 Sep 2020 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vqqJRR6FGWwEroRGJxb8U5uLILmsH4BqITcpCA5DevA=; b=U05AqtgaCYnJ76YXpy5uvatIUO
        4gsJez3Lmv2YIHzqVvkH55hL0T9ou3I8kpp/oXTKy6kU1LlqgfWtHRftn7h0ITzie7TKczKs6kbWQ
        YP0Ujt1BCeF7KJJYHCKP29QBx8qH9MCaMOf2Na/DsB4Uz4hqDdRr0fC03NbJKrHuLy09HQgm++d9P
        uj6bkjm7lAJLFlIl/0HwAO0ZAKXaMbsVmts0U2ukubGjV00JVuq5yaV12E/6TLK3TRb/gkeN0VXUK
        Ynfmlt15Gc/vj++h8kBVnQvlbnr/B1w4L+ZZsfluR9264QpjbfAzdI6f1BFlfY+8XiJfjJqDdf/hF
        4CPSdwHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGWHV-0001Rh-Pn; Thu, 10 Sep 2020 23:47:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 3/9] iomap: Use kzalloc to allocate iomap_page
Date:   Fri, 11 Sep 2020 00:47:01 +0100
Message-Id: <20200910234707.5504-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can skip most of the initialisation, although spinlocks still
need explicit initialisation as architectures may use a non-zero
value to indicate unlocked.  The comment is no longer useful as
attach_page_private() handles the refcount now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 330f86b825d7..58a1fd83f2a4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -49,16 +49,8 @@ iomap_page_create(struct inode *inode, struct page *page)
 	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
-	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
-	atomic_set(&iop->read_count, 0);
-	atomic_set(&iop->write_count, 0);
+	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
 	spin_lock_init(&iop->uptodate_lock);
-	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
-
-	/*
-	 * migrate_page_move_mapping() assumes that pages with private data have
-	 * their count elevated by 1.
-	 */
 	attach_page_private(page, iop);
 	return iop;
 }
-- 
2.28.0

