Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36772655AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgIJXr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgIJXrP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:47:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3E0C061796;
        Thu, 10 Sep 2020 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3NRZ9mRuxVTkFoTUITZkJOzyjhC6Qf6X2z+v5c8zFFY=; b=U6Eiw1+IKNIsYaYA2AEGILmHrz
        PPcx6lFKYWh+MzdSvdtztkRCnjxTRGpduRr6Lz9fTvzQuCPeekEoWn5dpT6Hx3tzH7SCWN/eGR2T7
        hJLOKSon0vdgI81lB0F47cOLLz5HyCU+ZqSaetOU7rpiBJF29UWS4huKWeYGmJLia30sxDEBKRv2P
        HEnCPWb705zyAUDNdNoOiS8YU6B4tDmlyobyUQP0e7XDIQLCWN4UQ/U1mEkCgJmo3g7/M+FJbLyEf
        LkRpbbEgaqEUeDJZlK4rJe5eFs1zfkSLLUE8JBdljlFbX+q4izqTZ3aoEmt4NIvJtpYF8spSK7fO5
        DaZfVUKw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGWHV-0001RZ-4x; Thu, 10 Sep 2020 23:47:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/9] iomap: Fix misplaced page flushing
Date:   Fri, 11 Sep 2020 00:46:59 +0100
Message-Id: <20200910234707.5504-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200910234707.5504-1-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If iomap_unshare_actor() unshares to an inline iomap, the page was
not being flushed.  block_write_end() and __iomap_write_end() already
contain flushes, so adding it to iomap_write_end_inline() seems like
the best place.  That means we can remove it from iomap_write_actor().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 897ab9a26a74..d81a9a86c5aa 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -717,6 +717,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
 	WARN_ON_ONCE(!PageUptodate(page));
 	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
 
+	flush_dcache_page(page);
 	addr = kmap_atomic(page);
 	memcpy(iomap->inline_data + pos, addr + pos, copied);
 	kunmap_atomic(addr);
@@ -810,8 +811,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
 
-		flush_dcache_page(page);
-
 		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
 				srcmap);
 		if (unlikely(status < 0))
-- 
2.28.0

