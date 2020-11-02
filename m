Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CFA2A332A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgKBSnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 13:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgKBSnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:43:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379C7C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 10:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=6VlMwrSe0hBiy4UFkQVpNAY49Fbf0diF2wld7e93HSc=; b=Er0k8MJFzxwnu0J21+wUeAJu3K
        TKq9qT+U9UNWnrEUddUkgnlXTsV6JLf+z2nv8ijZZ59x9aJ5mVJ7e8fblvbwCDxOHuf4xC7D+GbgG
        +yL65dNd66uWibUZyJgbJR/rO5aYrJHGzYcv+LT05J1bb2bhS7qjX3w76O58xMCYj8UTM5wLbBPQF
        OSa9uYOmoO5HG0ikOOeddea7JeTga9e/X7CB/o/TggQ27xkV4SsbPFGPlnN+ipkhz6+NwclOQV/k5
        3L3Lnz0mDZcsQDdsMYHzTxF2ML2qnQid56lDYx9KHILfclKLqezn+USbaNshxT2py2XUqA9Cryl5h
        4Yjzz9hg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZenT-0006lk-4k; Mon, 02 Nov 2020 18:43:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH 00/17] Refactor generic_file_buffered_read
Date:   Mon,  2 Nov 2020 18:42:55 +0000
Message-Id: <20201102184312.25926-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a combination of Christoph's work to refactor
generic_file_buffered_read() and my THP support on top of Kent's patches
which are currently in -mm.  I really like where this ended up.

Christoph Hellwig (2):
  mm/filemap: rename generic_file_buffered_read to filemap_read
  mm: simplify generic_file_read_iter

Matthew Wilcox (Oracle) (15):
  mm/filemap: Rename generic_file_buffered_read subfunctions
  mm/filemap: Use THPs in generic_file_buffered_read
  mm/filemap: Pass a sleep state to put_and_wait_on_page_locked
  mm/filemap: Support readpage splitting a page
  mm/filemap: Inline __wait_on_page_locked_async into caller
  mm/filemap: Don't call ->readpage if IOCB_WAITQ is set
  mm/filemap: Change filemap_read_page calling conventions
  mm/filemap: Change filemap_create_page arguments
  mm/filemap: Convert filemap_update_page to return an errno
  mm/filemap: Move the iocb checks into filemap_update_page
  mm/filemap: Add filemap_range_uptodate
  mm/filemap: Split filemap_readahead out of filemap_get_pages
  mm/filemap: Remove parameters from filemap_update_page()
  mm/filemap: Restructure filemap_get_pages
  mm/filemap: Don't relock the page after calling readpage

 fs/btrfs/file.c         |   2 +-
 include/linux/fs.h      |   4 +-
 include/linux/pagemap.h |   3 +-
 mm/filemap.c            | 493 +++++++++++++++++++---------------------
 mm/huge_memory.c        |   4 +-
 mm/migrate.c            |   4 +-
 6 files changed, 237 insertions(+), 273 deletions(-)

-- 
2.28.0

