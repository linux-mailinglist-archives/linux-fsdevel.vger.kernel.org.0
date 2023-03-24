Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F956C8455
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjCXSDe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjCXSCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD91BAEB;
        Fri, 24 Mar 2023 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rnAo4L7RmnIku5i+IL0cWPvo7OyCYgpklRMlOVhR32U=; b=j/l857Wi8xGShCZKdRe7OlnU2M
        UUN534rzq3/viXWPJ4LTgd71npb4oCul35QKqSp9rf+TaWan8pPH3mWTCire5lwgoMpeG2ru30lMs
        DQ4nG13TYquzGkyv/bTPS+qcle4HLVDeNnol8B47Ck/kLXUjHIsRk8ZEkj2DabPiPVRMbLy3yD2W3
        Pm+mrZc351yJEtfMLncC0JFDcrTGROCTMLwlRJAc/ZSnjRWuPG8uvoBgfc9RsSQKafNNHcOFwm1/t
        CzzTrCHS07DrHEB+UynalWwd8fvGjNJPmg1T/7M480Is4RvvtjIWd3cI46cT4jvsG7Py8CprJrWfc
        O36zIOjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljK-0057Yn-Ob; Fri, 24 Mar 2023 18:01:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/29] Convert most of ext4 to folios
Date:   Fri, 24 Mar 2023 18:01:00 +0000
Message-Id: <20230324180129.1220691-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On top of next-20230321, this converts most of ext4 to use folios instead
of pages.  It does not enable large folios although it fixes some places
that will need to be fixed before they can be enabled for ext4.  It does
not convert mballoc to use folios.  write_begin() and write_end() still
take a page parameter instead of a folio.

It does convert a lot of code away from the page APIs that we're trying
to remove.  It does remove a lot of calls to compound_head().  I'd like
to see it land in 6.4.

v2:
 Address all the feedback I received on v1.  At least I hope I did.

Matthew Wilcox (Oracle) (29):
  fs: Add FGP_WRITEBEGIN
  fscrypt: Add some folio helper functions
  ext4: Convert ext4_bio_write_page() to use a folio
  ext4: Convert ext4_finish_bio() to use folios
  ext4: Turn mpage_process_page() into mpage_process_folio()
  ext4: Convert mpage_submit_page() to mpage_submit_folio()
  ext4: Convert mpage_page_done() to mpage_folio_done()
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
  ext4: Convert ext4_page_nomap_can_writeout to
    ext4_folio_nomap_can_writeout
  ext4: Use a folio in ext4_da_write_begin()
  ext4: Convert ext4_mpage_readpages() to work on folios
  ext4: Convert ext4_block_write_begin() to take a folio
  ext4: Use a folio in ext4_page_mkwrite()
  ext4: Use a folio iterator in __read_end_io()
  ext4: Convert mext_page_mkuptodate() to take a folio
  ext4: Convert pagecache_read() to use a folio
  ext4: Use a folio in ext4_read_merkle_tree_page

 block/bio.c                |   1 +
 fs/ext4/ext4.h             |   9 +-
 fs/ext4/inline.c           | 171 ++++++++++----------
 fs/ext4/inode.c            | 312 +++++++++++++++++++------------------
 fs/ext4/move_extent.c      |  33 ++--
 fs/ext4/page-io.c          |  98 ++++++------
 fs/ext4/readpage.c         |  72 ++++-----
 fs/ext4/verity.c           |  30 ++--
 fs/iomap/buffered-io.c     |   2 +-
 fs/netfs/buffered_read.c   |   3 +-
 fs/nfs/file.c              |  12 +-
 include/linux/fscrypt.h    |  21 +++
 include/linux/page-flags.h |   5 -
 include/linux/pagemap.h    |   2 +
 mm/folio-compat.c          |   4 +-
 15 files changed, 387 insertions(+), 388 deletions(-)

-- 
2.39.2

