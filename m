Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D367D653
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjAZUY4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjAZUYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070354C0D9;
        Thu, 26 Jan 2023 12:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3ZBspEH4YyXN6KT07nYgGdCc5W23kSB2CSnTPWJXB+8=; b=JjRMSJ2A1e+rUFJtRwyfrQTa9M
        jSbjSghXIoBQa8dyybSQXcEevNgNB6o22USN0Exg1pC8UcBJ9WcqqqmYg+omBRm3cXxg0HZ72ORA1
        frD6yxkqz8Q6EZYMjDNdK9TvaqE4PEYpLPRGKxh1vEXX6hjkRKg50ffer93vLtiFMZh3tIv1zbjZ7
        7c0ASytgUQHHOUzA33OIIlltL8oYD4jDHsAh8jTZ2ILoFqPfGxMKwAPbBnTOigemYI8N1qAHZfC0A
        icP4REfnShRsla1qAXkHOC8bBvshghiZPLjv2KQ1sf22LMA4ifSmHkOTBXdhpoxNLPnc9Rz4arosF
        nZZT+mtA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nB-0073jK-V2; Thu, 26 Jan 2023 20:24:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/31] Convert most of ext4 to folios
Date:   Thu, 26 Jan 2023 20:23:44 +0000
Message-Id: <20230126202415.1682629-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This, on top of a number of patches currently in next and a few patches
sent to the mailing lists earlier today, converts most of ext4 to use
folios instead of pages.  It does not add support for large folios.
It does not convert mballoc to use folios.  write_begin() and write_end()
still take a page parameter instead of a folio.

It does convert a lot of code away from the page APIs that we're trying
to remove.  It does remove a lot of calls to compound_head().  I'd like
to see it land in 6.4, so getting it in for review early.

Matthew Wilcox (Oracle) (31):
  fs: Add FGP_WRITEBEGIN
  fscrypt: Add some folio helper functions
  ext4: Convert ext4_bio_write_page() to use a folio
  ext4: Convert ext4_finish_bio() to use folios
  ext4: Convert ext4_writepage() to use a folio
  ext4: Turn mpage_process_page() into mpage_process_folio()
  ext4: Convert mpage_submit_page() to mpage_submit_folio()
  ext4: Convert ext4_bio_write_page() to ext4_bio_write_folio()
  ext4: Convert ext4_readpage_inline() to take a folio
  ext4: Convert ext4_convert_inline_data_to_extent() to use a folio
  ext4: Convert ext4_try_to_write_inline_data() to use a folio
  ext4: Convert ext4_da_convert_inline_data_to_extent() to use a folio
  ext4: Convert ext4_da_write_inline_data_begin() to use a folio
  ext4: Convert ext4_read_inline_page() to ext4_read_inline_folio()
  ext4: Convert ext4_write_inline_data_end() to use a folio
  ext4: Convert ext4_write_begin() to use a folio
  ext4: Convert ext4_write_end() to use a folio
  ext4: Use a folio in ext4_journalled_write_end()
  ext4: Convert ext4_journalled_zero_new_buffers() to use a folio
  ext4: Convert __ext4_block_zero_page_range() to use a folio
  ext4: Convert __ext4_journalled_writepage() to take a folio
  ext4: Convert ext4_page_nomap_can_writeout() to take a folio
  ext4: Use a folio in ext4_da_write_begin()
  ext4: Convert ext4_mpage_readpages() to work on folios
  ext4: Convert ext4_block_write_begin() to take a folio
  ext4: Convert ext4_writepage() to take a folio
  ext4: Use a folio in ext4_page_mkwrite()
  ext4: Use a folio iterator in __read_end_io()
  ext4: Convert mext_page_mkuptodate() to take a folio
  ext4: Convert pagecache_read() to use a folio
  ext4: Use a folio in ext4_read_merkle_tree_page

 fs/ext4/ext4.h             |   9 +-
 fs/ext4/inline.c           | 171 ++++++++--------
 fs/ext4/inode.c            | 394 +++++++++++++++++++------------------
 fs/ext4/move_extent.c      |  33 ++--
 fs/ext4/page-io.c          |  98 +++++----
 fs/ext4/readpage.c         |  72 ++++---
 fs/ext4/verity.c           |  30 ++-
 fs/iomap/buffered-io.c     |   2 +-
 fs/netfs/buffered_read.c   |   3 +-
 include/linux/fscrypt.h    |  21 ++
 include/linux/page-flags.h |   5 -
 include/linux/pagemap.h    |   2 +
 mm/folio-compat.c          |   4 +-
 13 files changed, 424 insertions(+), 420 deletions(-)

-- 
2.35.1

