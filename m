Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C82FE083
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 05:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbhAUETl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 23:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbhAUERx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:17:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ED1C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 20:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eF4+pJllK7BuDIZs6R8FguanshdKC1X0mTkWRWvnGzM=; b=XzFUX8BSil0nURA0xJT0tU98MS
        9Jyt/UWY+CYNc6wflb4xNrWj0j1r7MbrSH7owTWW9Dr2b/9vurzrjB3r2HmppT1PyfLZxUornmXl1
        cZRgl4gFKEztUTmnRvUudo51qUHzcB5gQOwLNr/nYIUV+pMSJkawmv3Kx17sQNd26MWTYBApmXUfH
        xOKIDm6rzJxMU91ILpHr+EosNhTmk4wdRzayR+pmQQMCdIvA+R3IztFp/POT4AM6HdgH9qeklkOgd
        OtKkQh60PFNMtvGCI/R5il7g84VJeb0vn4SQ0r4qdlcnYC1SLoco1WI9gvwRenJqCSOT/HGx1XP+M
        hGtS9gtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ROM-00Gb7f-2T; Thu, 21 Jan 2021 04:16:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v4 00/18] Refactor generic_file_buffered_read
Date:   Thu, 21 Jan 2021 04:15:58 +0000
Message-Id: <20210121041616.3955703-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a combination of Christoph's work to refactor
generic_file_buffered_read() and some of my large-page support
which was disrupted by Kent's refactoring of generic_file_buffered_read.

v4:
 - Rebase on next-20210120
 - Fix compilation error with pagevec_init & reinit
 - Simplify filemap_range_uptodate() by passing pos instead of iocb
v3:
 - Fixed missing put_page for readahead with IOCB_NOIO (hch)
 - Fixed commit message for lock_page_for_iocb (nborisov)
v2:
 - Added pagevec conversion upfront and rebased other patches on top of
   it (me)
 - Limit page search by max pgoff_t rather than by number of pages (me)
 - Renamed mapping_get_read_thps() to filemap_get_read_batch() (hch/me)
 - Added doc for filemap_get_read_batch() (hch/me)
 - Removed 'first' parameter from filemap_update_page() (me)
 - Folded "Remove parameters from filemap_update_page()" into an earlier
   patch (hch)
 - Restructured filemap_update_page() error handling flow (hch/me)
 - Pass the pagevec to filemap_create_page() (hch)
 - Renamed 'find_page' label to 'retry' (hch)
 - Explicitly check for AOP_TRUNCATED_PAGE instead of assuming err > 0
   means retry (hch)
 - Move mark_page_accessed() and handling of i_size into main copy loop (me)


Christoph Hellwig (2):
  mm/filemap: Rename generic_file_buffered_read to filemap_read
  mm/filemap: Simplify generic_file_read_iter

Matthew Wilcox (Oracle) (16):
  mm/filemap: Rename generic_file_buffered_read subfunctions
  mm/filemap: Remove dynamically allocated array from filemap_read
  mm/filemap: Convert filemap_get_pages to take a pagevec
  mm/filemap: Use head pages in generic_file_buffered_read
  mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
  mm/filemap: Support readpage splitting a page
  mm/filemap: Inline __wait_on_page_locked_async into caller
  mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
  mm/filemap: Change filemap_read_page calling conventions
  mm/filemap: Change filemap_create_page calling conventions
  mm/filemap: Convert filemap_update_page to return an errno
  mm/filemap: Move the iocb checks into filemap_update_page
  mm/filemap: Add filemap_range_uptodate
  mm/filemap: Split filemap_readahead out of filemap_get_pages
  mm/filemap: Restructure filemap_get_pages
  mm/filemap: Don't relock the page after calling readpage

 fs/btrfs/file.c         |   2 +-
 include/linux/fs.h      |   4 +-
 include/linux/pagemap.h |   3 +-
 mm/filemap.c            | 565 ++++++++++++++++++----------------------
 mm/huge_memory.c        |   4 +-
 mm/migrate.c            |   4 +-
 6 files changed, 267 insertions(+), 315 deletions(-)

-- 
2.29.2

