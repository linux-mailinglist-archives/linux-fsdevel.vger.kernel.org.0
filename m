Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC9196E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 02:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfHUAat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 20:30:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHUAas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oeVOANfId+UFajzaQ2gzW3c9xEV2b0FiX63evlEKZv0=; b=Huw1B8AMREhrx9XNmoNt4deM9
        XSwL/uolvP12oF8bakTOb7gFvccAgSYatlSvv+RwOvuBI9BK82q1JqugmsueqUJgDGNHLUBBc4DCm
        sD3r5M8F6HJoy0IXcPqibA1BqVjt4yjo1S6wUcbb/zFH87Nyk+JwaiDp52ecZDxywdLagHBjD2JaT
        OC6kJF8BHpxkJJOgIInWAPbzOUoPkTHbJUFKR7UjSKlhvoGTygIQr+ld7CoqaF4P5y1JaxTw7sRcA
        LVKoZsjeg24PM2/zpg7HAOCev4FNVrKKIlJo48lA2VKZV1aNJASlHIaQsoaHn2HP23USgRMtBCwmD
        zOdQErHLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0EWQ-0003HO-6R; Wed, 21 Aug 2019 00:30:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 0/5] iomap & xfs support for large pages
Date:   Tue, 20 Aug 2019 17:30:34 -0700
Message-Id: <20190821003039.12555-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

In order to support large pages in the page cache, filesystems have
to understand that they're being passed a large page and read or write
the entire large page, rather than just the first page.  This pair of
patches adds that support to XFS.

Still untested beyond compilation.

v2:
 - Added a few helpers per Dave Chinner's suggestions
 - Use GFP_ZERO instead of individually zeroing each field of iop
 - Rewrite iomap_set_range_uptodate() to use bitmap functions instead
   of individual bit operations
 - Drop support for large pages being used for files with inline data
   (it didn't work anyway, because kmap_atomic() is only going to map
   the first page of a compound page)
 - Pass a struct page to xfs_finish_page_writeback instead of the bvec

Matthew Wilcox (Oracle) (5):
  fs: Introduce i_blocks_per_page
  mm: Add file_offset_of_ helpers
  iomap: Support large pages
  xfs: Support large pages
  xfs: Pass a page to xfs_finish_page_writeback

 fs/iomap/buffered-io.c  | 121 ++++++++++++++++++++++++++--------------
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |  37 ++++++------
 include/linux/iomap.h   |   2 +-
 include/linux/mm.h      |   2 +
 include/linux/pagemap.h |  38 ++++++++++++-
 6 files changed, 135 insertions(+), 67 deletions(-)

-- 
2.23.0.rc1
