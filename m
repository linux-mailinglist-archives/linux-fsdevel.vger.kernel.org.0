Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E12A6F0B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732313AbgKDUme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732228AbgKDUmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:42:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B22BC0401C4
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 12:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/hemmFsrPQvqVweaLIDmcJDf86/Fr7yzPcMM0Q+k5dA=; b=EuEJt54n5bkVy/7VjGacu/Glkm
        5HtjOYxiy6mYzyZCyAVeetktSSwQg6Qj+QkDhftqj8MmAMcgr3eggLBXoEvifWEUSqI7l3oISiEOX
        WPmxcRiNQx6v8FRHfpjYW1sMbqAGwFNPRk0/CCfrMmqGZWcJA4aELi84cdDv4ThZeZIuGgS1q5hNc
        5nqB+OpNTtA6X5XwTKV3HYqH/SocEkUrbGheILHk7oO8nRf96n1MkE8eAate9HOc0jkvWJ1t4CtyK
        h5Z4O49Z4ubIMQoRR9eoivRA6jiXPpEUTQrNcNFvpB1AKFtaNvLlSbJCfbR8/M0GfZ38xmU9GWzYV
        d7+is9Yg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kaPbp-0006Cp-B9; Wed, 04 Nov 2020 20:42:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v2 00/18] Refactor generic_file_buffered_read
Date:   Wed,  4 Nov 2020 20:42:01 +0000
Message-Id: <20201104204219.23810-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a combination of Christoph's work to refactor
generic_file_buffered_read() and my THP support on top of Kent's patches
which are currently in -mm.  I really like where this ended up.

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

I kept the R-b on patches, even when they changed a little.
Let me know if there's any you'd like to withdraw ;-)

Christoph Hellwig (2):
  mm/filemap: Rename generic_file_buffered_read to filemap_read
  mm/filemap: Simplify generic_file_read_iter

Matthew Wilcox (Oracle) (16):
  mm/filemap: Rename generic_file_buffered_read subfunctions
  mm/filemap: Remove dynamically allocated array from filemap_read
  mm/filemap: Convert filemap_get_pages to take a pagevec
  mm/filemap: Use THPs in generic_file_buffered_read
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
 mm/filemap.c            | 566 ++++++++++++++++++----------------------
 mm/huge_memory.c        |   4 +-
 mm/migrate.c            |   4 +-
 6 files changed, 268 insertions(+), 315 deletions(-)

-- 
2.28.0

