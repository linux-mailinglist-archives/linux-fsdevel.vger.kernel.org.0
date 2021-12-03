Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC61467D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbhLCSvb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Dec 2021 13:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhLCSva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:51:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B17BC061751;
        Fri,  3 Dec 2021 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kF6dmKlPKnjUDrUnQOFbFf+3qy5XKLqFHNl3T/IoT5I=; b=HrIXJSAhpv5A42dLxSAvzmFi2l
        i4Upfw202xAcBuWfW8eLIHpzOCYwb5mWQh3Y4RiKwoaOltJoMvEo485AtvZLPQMd9De7UxVF8uGFY
        YOha9TFu8gwOhpZMIbdxCz3Okdk/dfQuDtD5bz6kE9t7gTDrU3VgL0VCuRN6nXpUTTEsb0iFKay2C
        l4zQehntOL7UKleJy2EHltIJm6Txkc0vZ+wGZVEX8BOvKGhlNRgxO6mOwl8Xj7MzTXVCwdMCNdbvy
        uBAuKDq7/B69hXM6fPFgrW20jeuJfnXbdlJ1R3S+Tk4UyqXEGQdmG1+trEW6fLtnLIVOJ+JtL6kzY
        Z6/p1/DQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtDbG-009pzR-Q8; Fri, 03 Dec 2021 18:48:02 +0000
Date:   Fri, 3 Dec 2021 18:48:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] iomap folio conversion for 5.17
Message-ID: <YapmYhfP3Vx2m9CJ@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Would you like to pull the folio changes from my git tree?
They are generally as posted previously, with minor tweaks to match
upstream changes.  They do not introduce any new xfstests problems
in my testing.

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux.git tags/iomap-folio-5.17

for you to fetch changes up to 0976b3cc2108b11c106ecad72459cceb35158553:

  xfs: Support large folios (2021-11-29 08:30:52 -0500)

----------------------------------------------------------------
Convert fs/iomap to use folios

These patches prepare XFS to use large folios to cache files.
There are some preliminary patches to add folio interfaces to the
block layer & buffer layer, then all the iomap functions are
converted to use folios instead of pages.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (24):
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
 fs/iomap/buffered-io.c                | 510 +++++++++++++++++-----------------
 fs/xfs/xfs_aops.c                     |  24 +-
 fs/xfs/xfs_icache.c                   |   2 +
 include/linux/bio.h                   |  56 +++-
 include/linux/iomap.h                 |   3 +-
 9 files changed, 365 insertions(+), 278 deletions(-)

