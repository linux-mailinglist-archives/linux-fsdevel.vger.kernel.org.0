Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC4720BE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Jun 2023 00:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjFBWZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 18:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236490AbjFBWY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:24:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129349D;
        Fri,  2 Jun 2023 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iQ0827CwQnnlSwpm+aCdM8sh89dkXAHIYux3uuAVwMw=; b=dYiN6hgrBf7BhxOgIIJ45hksR8
        gjn0PVUsFdlrY1p5jBic5I3Q1H3G1xuPJGOVcASl5lI0KET4BoAqD4OTMjBDMmBSBd8GFa3vUL4tP
        68+KxKlOP1bQgT0sI9kSzjUhec1KMnBLm0uQZxrz9QnM8IlrrwyKiPOoMnFcy230H1liLUUPS1PO/
        xNz760nafRuDfQjlbMVd5yxKwA2REfNnxdgDxV/vN9gtag3ZakfyqcFk+szdGObaytQs6/PJHx8p8
        jv7iO26ti7Vd7bgbmL1l+igKFdWh9MwAj1rvkqWnMR6yeaqJZERXfcrue7Vu2pObUVCD1NK39KGwo
        kqK+r1/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5DCQ-009aPG-Dx; Fri, 02 Jun 2023 22:24:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 0/7] Create large folios in iomap buffered write path
Date:   Fri,  2 Jun 2023 23:24:37 +0100
Message-Id: <20230602222445.2284892-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit ebb7fb1557b1 limited the length of ioend chains to 4096 entries
to improve worst-case latency.  Unfortunately, this had the effect of
limiting the performance of:

fio -name write-bandwidth -rw=write -bs=1024Ki -size=32Gi -runtime=30 \
        -iodepth 1 -ioengine sync -zero_buffers=1 -direct=0 -end_fsync=1 \
        -numjobs=4 -directory=/mnt/test

The problem ends up being lock contention on the i_pages spinlock as we
clear the writeback bit on each folio (and propagate that up through
the tree).  By using larger folios, we decrease the number of folios
to be processed by a factor of 256 for this benchmark, eliminating the
lock contention.

It's also the right thing to do.  This is a project that has been on
the back burner for years, it just hasn't been important enough to do
before now.

I think it's probably best if this goes through the iomap tree since
the changes outside iomap are either to the page cache or they're
trivial.

v2:
 - Fix misplaced semicolon
 - Rename fgp_order to fgp_set_order
 - Rename FGP_ORDER to FGP_GET_ORDER
 - Add fgp_t
 - Update the documentation for ->release_folio
 - Fix iomap_invalidate_folio()
 - Update iomap_release_folio()

Matthew Wilcox (Oracle) (7):
  iomap: Remove large folio handling in iomap_invalidate_folio()
  doc: Correct the description of ->release_folio
  iomap: Remove unnecessary test from iomap_release_folio()
  filemap: Add fgp_t typedef
  filemap: Allow __filemap_get_folio to allocate large folios
  iomap: Create large folios in the buffered write path
  iomap: Copy larger chunks from userspace

 Documentation/filesystems/locking.rst | 14 ++++--
 fs/btrfs/file.c                       |  6 +--
 fs/f2fs/compress.c                    |  2 +-
 fs/f2fs/f2fs.h                        |  2 +-
 fs/gfs2/bmap.c                        |  2 +-
 fs/iomap/buffered-io.c                | 43 ++++++++--------
 include/linux/iomap.h                 |  2 +-
 include/linux/pagemap.h               | 71 ++++++++++++++++++++++-----
 mm/filemap.c                          | 61 ++++++++++++-----------
 mm/folio-compat.c                     |  2 +-
 mm/readahead.c                        | 13 -----
 11 files changed, 130 insertions(+), 88 deletions(-)

-- 
2.39.2

