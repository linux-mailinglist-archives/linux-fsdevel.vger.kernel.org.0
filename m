Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A830477E1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbhLPVHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLPVHU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909A2C061574;
        Thu, 16 Dec 2021 13:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eopyKE4k2XeTajA356L1MfJ+TGRn08rwtoWo6zNEjPA=; b=HmohCdjvgCsB3u/7t72y0Pnuh5
        BguTcTUmOvDPhuY0wco1NY4bKL+mgJAVOLL2zNu3F9nT4kZQXwCSQxSJmlOSpQkGMUETKAkOI0IR2
        Eh0Pla1qoz/soS4Sn3GviyJat9zlF8lpAKVj1aCOHsqra+GW5ih5kiVXWz8PW4ywFozArAJHL/710
        l5ncbZ6akbSjDPxfEhZ3sliwOZXJA5DNtz0xRlkVK2rO45tou4aJJ9lGJ1tWcp/h18fxJHxNmOwG/
        j/h/p3WSTEvPglsrGYOL5iTMyQYGycYcf7gO8woeub8/mnxcb2zS7v9fWrX6YR04MCjjtVIruJ8xm
        7ag+AK9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyA-00Fx34-Sv; Thu, 16 Dec 2021 21:07:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/25] iomap/xfs folio patches
Date:   Thu, 16 Dec 2021 21:06:50 +0000
Message-Id: <20211216210715.3801857-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset converts XFS & iomap to use folios, and gets them to a
state where they can handle multi-page folios.  Applying these patches
is not yet sufficient to actually start using multi-page folios for
XFS; more page cache changes are needed.  I don't anticipate needing to
touch XFS again until we're at the point where we want to convert the
aops to be type-safe.  It completes an xfstests run with no unexpected
failures.

I think everything here has been posted before, but I want to get
acks/reviews on patch 15 in particular.  I'll send a pull request
for these patches tomorrow.

v3:
 - Rebased to -rc5, which removes the first four patches from v2.
 - Fixed passing lengths > PAGE_SIZE to iomap_write_begin().
v2:
 - Added review tags from Jens, Darrick & Christoph (thanks!)
 - Added folio_zero_* wrappers around zero_user_*()
 - Added a patch to rename AS_THP_SUPPORT
 - Added a patch to convert __block_write_begin_int() to take a folio
 - Split the iomap_add_to_ioend() patch into three
 - Updated changelog of bio_add_folio() (Jens)
 - Adjusted whitespace of bio patches (Christoph, Jens)
 - Improved changelog of readahead conversion to explain why the put_page()
   disappeared (Christoph)
 - Add a patch to zero an entire folio at a time, instead of limiting to
   a page
 - Switch pos & end_pos back to being u64 from loff_t
 - Call block_write_end() and ->page_done with the head page of the folio,
   as that's what those functions expect.

Matthew Wilcox (Oracle) (25):
  block: Add bio_add_folio()
  block: Add bio_for_each_folio_all()
  fs/buffer: Convert __block_write_begin_int() to take a folio
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
  iomap: Allow iomap_write_begin() to be called with the full length
  iomap: Convert __iomap_zero_iter to use a folio
  iomap: Convert iomap_write_begin() and iomap_write_end() to folios
  iomap: Convert iomap_write_end_inline to take a folio
  iomap,xfs: Convert ->discard_page to ->discard_folio
  iomap: Simplify iomap_writepage_map()
  iomap: Simplify iomap_do_writepage()
  iomap: Convert iomap_add_to_ioend() to take a folio
  iomap: Convert iomap_migrate_page() to use folios
  iomap: Support large folios in invalidatepage
  xfs: Support large folios

 Documentation/core-api/kernel-api.rst |   1 +
 block/bio.c                           |  22 ++
 fs/buffer.c                           |  23 +-
 fs/internal.h                         |   2 +-
 fs/iomap/buffered-io.c                | 518 +++++++++++++-------------
 fs/xfs/xfs_aops.c                     |  24 +-
 fs/xfs/xfs_icache.c                   |   2 +
 include/linux/bio.h                   |  56 ++-
 include/linux/iomap.h                 |   3 +-
 9 files changed, 373 insertions(+), 278 deletions(-)

-- 
2.33.0

