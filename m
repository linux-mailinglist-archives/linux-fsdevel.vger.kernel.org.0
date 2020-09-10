Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5A626559B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgIJXrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXrM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:47:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1CCC061756;
        Thu, 10 Sep 2020 16:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gATiEIJ5yym8gDZW7pIpWvARxJPI7Am+GdMp2jh+5MM=; b=NU+A3j4UiyhwWUqTbemQKJ7NoT
        bJbdq0iulAfED6zqYzsugnRZeP4UFzoCZXBTUxe3UU0nxN1pxpDgbXamafmx7vgty1r6sztkFceoc
        uhCtLXWHHlRk8UEarcpLejYVsKtGgEDyGzsi1+3zAjHhmygjlNrGDioIz9zRv1FhKFM6KhSKpk31W
        9giPinWY+QjDf/q+iQqddSd89v8Xi9iu/rSoc6Qc49vUBRfO7hQxKyAA3RwyRbQ3MzGLfQgWh0J7X
        BFCVnyNyY/g0MCXWFxTQJUOtq/pm5rcIOT9stXwsB8VLtzKhCFJprAB/2wZXJI9/bYGDR9edkQMRp
        lHM6Bawg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGWHU-0001RW-R5; Thu, 10 Sep 2020 23:47:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
Subject: [PATCH v2 0/9] THP iomap patches for 5.10
Date:   Fri, 11 Sep 2020 00:46:58 +0100
Message-Id: <20200910234707.5504-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches are carefully plucked from the THP series.  I would like
them to hit 5.10 to make the THP patchset merge easier.  Some of these
are just generic improvements that make sense on their own terms, but
the overall intent is to support THPs in iomap.

v2:
 - Move the call to flush_dcache_page (Christoph)
 - Clarify comments (Darrick)
 - Rename read_count to read_bytes_pending (Christoph)
 - Rename write_count to write_bytes_pending (Christoph)
 - Restructure iomap_readpage_actor() (Christoph)
 - Change return type of the zeroing functions from loff_t to s64

Matthew Wilcox (Oracle) (9):
  iomap: Fix misplaced page flushing
  fs: Introduce i_blocks_per_page
  iomap: Use kzalloc to allocate iomap_page
  iomap: Use bitmap ops to set uptodate bits
  iomap: Support arbitrarily many blocks per page
  iomap: Convert read_count to read_bytes_pending
  iomap: Convert write_count to write_bytes_pending
  iomap: Convert iomap_write_end types
  iomap: Change calling convention for zeroing

 fs/dax.c                |  13 ++-
 fs/iomap/buffered-io.c  | 173 +++++++++++++++++-----------------------
 fs/jfs/jfs_metapage.c   |   2 +-
 fs/xfs/xfs_aops.c       |   2 +-
 include/linux/dax.h     |   3 +-
 include/linux/pagemap.h |  16 ++++
 6 files changed, 96 insertions(+), 113 deletions(-)

-- 
2.28.0

