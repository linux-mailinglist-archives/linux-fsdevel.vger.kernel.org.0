Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00545CDE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 21:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhKXUX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 15:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbhKXUX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:23:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63804C061574;
        Wed, 24 Nov 2021 12:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dxu8rmSj5L6/mmz45KruXo7nmpwWJ/sOE5r4T8rfCAo=; b=vKiwxHVhDBbH9WgvIEHzDg4gBn
        tIZBoymYM8gOJJlXuvkgfthzXQe5erlk8fd70Ib9ZUqOT/d7fTgBliixRA1VyiE4ZFF9Z9eWgxZyj
        mWInKt2kfiVRMDWQf7QJAPA/lsm3YTK8dM7BaFfigw0oG5iGUzWGr2TXQ4aKqHDwlWaXnO5Mj/gZJ
        okE8RFgfmUC5r1jpsgIupV286bqsXoBI+D9gGJg/5npk9VAeWc6AfvDgBJY4sLxCIBmLTh8Z900GC
        u3nEaLBDxvV58lnWE0xQ1+ImPVCbZEHI+HVaV0XT57bE49FDUqjgGl6CFIZYrZc5UpM+I9dGhYx5Y
        3YhbpOjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpyl2-003F4b-J2; Wed, 24 Nov 2021 20:20:44 +0000
Date:   Wed, 24 Nov 2021 20:20:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Folio fixes for 5.16
Message-ID: <YZ6enA9aRgJLL55w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

In the course of preparing the folio changes for iomap for next merge
window, we discovered some problems that would be nice to address now:

 - Renaming multi-page folios to large folios.
   mapping_multi_page_folio_support() is just a little too long, so
   we settled on mapping_large_folio_support().  That meant renaming,
   eg folio_test_multi() to folio_test_large().
 - I hadn't included folio wrappers for zero_user_segments(), etc.
   Also, multi-page^W^W large folio support is now independent of
   CONFIG_TRANSPARENT_HUGEPAGE, so machines with HIGHMEM always need to
   fall back to the out-of-line zero_user_segments().
 - The build bots finally got round to telling me that I missed a
   couple of architectures when adding flush_dcache_folio().  Christoph
   suggested that we just add linux/cacheflush.h and not rely on
   asm-generic/cacheflush.h.

These changes have been in linux-next for the last week with no new
squawks.

The following changes since commit 8ab774587903771821b59471cc723bba6d893942:

  Merge tag 'trace-v5.16-5' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2021-11-14 19:07:19 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.16b

for you to fetch changes up to c035713998700e8843c7d087f55bce3c54c0e3ec:

  mm: Add functions to zero portions of a folio (2021-11-18 15:05:56 -0500)

----------------------------------------------------------------
Fixes for 5.16 folios:

 - Fix compilation warnings on csky and sparc
 - Rename multipage folios to large folios
 - Rename AS_THP_SUPPORT and FS_THP_SUPPORT
 - Add functions to zero portions of a folio

----------------------------------------------------------------
Matthew Wilcox (Oracle) (6):
      Add linux/cacheflush.h
      mm: Rename folio_test_multi to folio_test_large
      mm: Remove folio_test_single
      fs: Remove FS_THP_SUPPORT
      fs: Rename AS_THP_SUPPORT and mapping_thp_support
      mm: Add functions to zero portions of a folio

 arch/arc/include/asm/cacheflush.h     |  1 -
 arch/arm/include/asm/cacheflush.h     |  1 -
 arch/m68k/include/asm/cacheflush_mm.h |  1 -
 arch/mips/include/asm/cacheflush.h    |  2 --
 arch/nds32/include/asm/cacheflush.h   |  1 -
 arch/nios2/include/asm/cacheflush.h   |  1 -
 arch/parisc/include/asm/cacheflush.h  |  1 -
 arch/sh/include/asm/cacheflush.h      |  1 -
 arch/xtensa/include/asm/cacheflush.h  |  3 ---
 fs/inode.c                            |  2 --
 include/asm-generic/cacheflush.h      |  6 -----
 include/linux/cacheflush.h            | 18 ++++++++++++++
 include/linux/fs.h                    |  1 -
 include/linux/highmem.h               | 47 +++++++++++++++++++++++++++++++----
 include/linux/page-flags.h            | 14 +++++------
 include/linux/pagemap.h               | 26 +++++++++++++++----
 mm/highmem.c                          |  2 --
 mm/memcontrol.c                       |  2 +-
 mm/shmem.c                            |  3 ++-
 mm/util.c                             |  2 +-
 20 files changed, 92 insertions(+), 43 deletions(-)
 create mode 100644 include/linux/cacheflush.h


