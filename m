Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9445E1FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 22:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357194AbhKYVQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 16:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhKYVOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:14:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FEDC061761;
        Thu, 25 Nov 2021 13:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JbPu0sanHIoDdCdNVaSqLJ/ATyCk1958f2ugIhUQGQ0=; b=v1nkFrq//MZVSs4ZVxUaxeuNfp
        6OCy9uc7M4DrudT7JEykQ2r2hNUkj+6QRL8z0Yj4wI6E+gu7LlJbyeDZq5m96R3coBFAZvLSLZOvv
        dw1mctTaJlQUMNwVWmmMGxV9iXGiEcIjk8lWVwF7RbIR8DTn9CtBKqClXCxrzlWyxJvrBNLYttafX
        lY+Mw8ldQ6LfUsN8zegw00ApSNMiPaJ3IJShrnwJA5X2Pysp5tCaIHFLHYQfWgI+Ee57J1mis+Axy
        Q1DwEotOgm3HRlBiDSPVavGhG870BESemCtkjOO3t2VfYxL/6pF/kr8dCPmC9w3y/SdKQL6t4Z34L
        Dsun5cXw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqLyV-007og9-Cf; Thu, 25 Nov 2021 21:08:11 +0000
Date:   Thu, 25 Nov 2021 21:08:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: iomap folio conversion for 5.17
Message-ID: <YZ/7O9Zb3PSsCbk9@casper.infradead.org>
References: <20211124183905.GE266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124183905.GE266024@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:39:05AM -0800, Darrick J. Wong wrote:
> Hi folks,
> 
> The iomap-for-next branch of the xfs-linux repository at:
> 
> 	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.

Hi Darrick,

Would you like to pull the folio changes from my git tree?
They are generally as posted previously, with minor tweaks to match
upstream changes.  They do not introduce any new xfstests problems
in my testing.

The following changes since commit b501b85957deb17f1fe0a861fee820255519d526:

  Merge tag 'asm-generic-5.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic (2021-11-25 10:41:28 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux.git tags/iomap-folio-5.17

for you to fetch changes up to 979fe192e8a935968fd739983217128b431f6268:

  xfs: Support large folios (2021-11-25 14:03:56 -0500)

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
 fs/iomap/buffered-io.c                | 506 +++++++++++++++++-----------------
 fs/xfs/xfs_aops.c                     |  24 +-
 fs/xfs/xfs_icache.c                   |   2 +
 include/linux/bio.h                   |  56 +++-
 include/linux/iomap.h                 |   3 +-
 9 files changed, 363 insertions(+), 276 deletions(-)

