Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644C92ACBEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgKJDhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbgKJDhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD029C0613D6
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+S0FIkOgSwV58iPjqMAeIZmxUl9T/7Do9UD2c+elmSw=; b=doNRLcNhJNoIcekY1BM+VTUwdS
        8eorL//tbpj8SmLOSa8NgwMPdm+j1MMHkaPb/ZxTq24IyahHtZvMUuYsbeNT3VdHZO3BHH+aqAo3h
        WokffqQS12nh3HUq6WIkhwWN/XGKZ5lImN082vW5kPeXT+nOzclx+yErcgd1ylUx7GYM5dPiCUU1m
        kFZxT9w0eaSITAOsVPw0HT0/x/2ChS0AF6WZdV4Nwf2fOcEYIsSeELIx4rQPAEHAjzyZme7tMZuvt
        IV0GXIXDpogOz1X5hQzOY3+hvNakOv1qyYnLRSrkqSXLYlHMxQIw88N3ebB+muscvA6NYNIe11E0o
        MzSY8k/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKSu-00064K-MD; Tue, 10 Nov 2020 03:37:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 00/18] Refactor generic_file_buffered_read
Date:   Tue, 10 Nov 2020 03:36:45 +0000
Message-Id: <20201110033703.23261-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a combination of Christoph's work to refactor
generic_file_buffered_read() and my THP support on top of Kent's patches
which are currently in -mm.  I really like where this ended up.

v3:
 - Fixed missing put_page for readahead with IOCB_NOIO (hch)
 - Fixed commit message for lock_page_for_iocb (nborisov)
 - Kent has agreed to reduce to PAGEVEC_SIZE entries per iteration,
   since we can go up to larger pagevecs later if needed.
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
 mm/filemap.c            | 568 ++++++++++++++++++----------------------
 mm/huge_memory.c        |   4 +-
 mm/migrate.c            |   4 +-
 6 files changed, 270 insertions(+), 315 deletions(-)

-- 
2.28.0

