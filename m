Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00BB4421CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 21:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKAUpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 16:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhKAUpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:45:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A163C061714;
        Mon,  1 Nov 2021 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=chNWjrMwxLlygvBLJNWRNHDSE0gjni5bIuk9Yy4tZbo=; b=mqHGFzEOS8E9CxQtoKts2Wr12C
        I1N4Da08CVdnvJ93OJWiJXiQXJmAmmXVRYFDL42Y+9W0tDiPUOCB09Or5yn/TkHqPzjYHdQRJBcRr
        sk6ywml3gbPH7h552U5YCA4Jjye3g5aMc3eMoo08IJPn6pAKVF9r9ZpaUuzrJ/eO/TzKqOQRwKUyA
        armn0zRIawNhoW2YPjxD7MUiEL6cvl9MUbLs65pAc8nWT+362aevCP0me4Mn3E8uUrHSGrUMGKiXY
        GFGmoLtuOy+CxoQGxfTppCfS3NPfXlnOhv7ZmI6oEjb5mDu+qX53EiMCKsfsDzFzb9Qbv6R5a9rjk
        FLURsvRw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhe5b-0040Ls-6E; Mon, 01 Nov 2021 20:39:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 00/21] iomap/xfs folio patches
Date:   Mon,  1 Nov 2021 20:39:08 +0000
Message-Id: <20211101203929.954622-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset converts XFS & iomap to use folios, and gets them to
a state where they can handle multi-page folios.  I don't anticipate
needing to touch XFS again until we're at the point where we want to
convert the aops to be type-safe.  The patches apply to both current
Linus head and next-20211101.  It completes an xfstests run with no
unexpected failures.  Most of these patches have been posted before and
I've retained acks/reviews where I thought them reasonable.  Some are new.

I'd really like a better name than 'mapping_set_large_folios()'.
mapping_set_multi_page_folios() seems a bit long.  mapping_set_mpf()
is a bit obscure.

Jens, I'd really like your ack on patches 2 & 3; I know we discussed
them before.

Matthew Wilcox (Oracle) (21):
  fs: Remove FS_THP_SUPPORT
  block: Add bio_add_folio()
  block: Add bio_for_each_folio_all()
  iomap: Convert to_iomap_page to take a folio
  iomap: Convert iomap_page_create to take a folio
  iomap: Convert iomap_page_release to take a folio
  iomap: Convert iomap_releasepage to use a folio
  iomap: Add iomap_invalidate_folio
  iomap: Pass the iomap_page into iomap_set_range_uptodate
  iomap: Convert bio completions to use folios
  iomap: Use folio offsets instead of page offsets
  iomap: Convert iomap_read_inline_data to take a folio
  iomap: Convert readahead and readpage to use a folio
  iomap: Convert iomap_page_mkwrite to use a folio
  iomap: Convert iomap_write_begin and iomap_write_end to folios
  iomap: Convert iomap_write_end_inline to take a folio
  iomap,xfs: Convert ->discard_page to ->discard_folio
  iomap: Convert iomap_add_to_ioend to take a folio
  iomap: Convert iomap_migrate_page to use folios
  iomap: Support multi-page folios in invalidatepage
  xfs: Support multi-page folios

 Documentation/core-api/kernel-api.rst |   1 +
 block/bio.c                           |  22 ++
 fs/inode.c                            |   2 -
 fs/iomap/buffered-io.c                | 499 +++++++++++++-------------
 fs/xfs/xfs_aops.c                     |  24 +-
 fs/xfs/xfs_icache.c                   |   2 +
 include/linux/bio.h                   |  56 ++-
 include/linux/fs.h                    |   1 -
 include/linux/iomap.h                 |   3 +-
 include/linux/pagemap.h               |  16 +
 mm/shmem.c                            |   3 +-
 11 files changed, 366 insertions(+), 263 deletions(-)

-- 
2.33.0

