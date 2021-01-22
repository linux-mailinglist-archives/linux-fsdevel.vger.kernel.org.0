Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B4300824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 17:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbhAVQDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 11:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbhAVQDL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:03:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88CFC0613D6;
        Fri, 22 Jan 2021 08:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=B/kiTjmHGaRRrP1G8JY0NUDXmSmRpyqLhF1JzYpU0yM=; b=rU5ATMS8dhDUJCkDffPcPMDRq3
        oUX7YcNAyZiLiso2iGLJqhfCGU2IdBa3NH2Msn0/DQi+n5Ewmx/mzrhO9MLxEdAxOgGHWi56Q6kyl
        O3zUemwf2vaevlNOpYlASc/SBlz2toh2Omljod5bwRHbZ/aITycyOrPi4VKiw1Y/N47WYif/0pZjk
        dNIB/7XNOzrugVQn9gQxjiO1A8nepck4L0rri12pQdbVzW/RwHJBxj/r2Yni0XhBuRA8APXw+mgnx
        oLUEzlP4cxXG2TAR7jzgKeTSzBPED92JPjz+E1U5DsLh9wzhCCs1xcPJdkmejqZSedL59tuOrto1M
        vF1UXPYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ysc-000w5I-L8; Fri, 22 Jan 2021 16:01:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/18] Refactor generic_file_buffered_read
Date:   Fri, 22 Jan 2021 16:01:22 +0000
Message-Id: <20210122160140.223228-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a combination of Christoph's work to refactor
generic_file_buffered_read() and some of my large-page support
which was disrupted by Kent's refactoring of generic_file_buffered_read.

v5:
 - Rebase on next-20210122 (new conflict due to typo fix)
 - Folded in Reviewed-bys
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

