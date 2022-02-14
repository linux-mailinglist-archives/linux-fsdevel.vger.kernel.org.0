Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59D4B5BCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiBNUzP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 15:55:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiBNUzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:55:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6E106CB8
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/rveRtCAVtTxS7QANg2AkZ7UaZV55OMKQy2uRCLWACE=; b=Ldh5T3N6zurDGcPZAcsvYHoW0k
        ZWWwFmsBr4iLkOxqgETxhe2SfLp7aVqkGuF1KyvddCoj/SJRy4eamVgzMH4BaGPiGYI2uOqJay3nv
        L3DVCWEKDTQelw9McfH995jGX/ZywY3MYqrQN0IUHz1bQ1NSQL5z7BpKyNx08ZnpotDnoeNSEncEs
        jav2MecNNr2ez09MXh4pGmRWdlAqUav1AEIDJBy5TS7UQ5NQtZcgeNyvp9eKYsrIVk/jyJMvdtkch
        98dAZO6eiyKnfzzKBdHHMPRjix0j8eOfEZPcsgMP4UG4/OofHJ1s9QzNvAOzftKGmnyKsPsDNGO8A
        wdlBlz7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJhWF-00DDdS-5f; Mon, 14 Feb 2022 20:00:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/10] Various fixes around invalidate_page()
Date:   Mon, 14 Feb 2022 20:00:07 +0000
Message-Id: <20220214200017.3150590-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Blame Rik for this.  His "clean up hwpoison page cache page in fault path"
patch on Friday made me look at how invalidate_inode_page() handled tail
pages.  It's not buggy, but __invalidate_mapping_pages() has a minor
accounting bug, and all of this related code could be done a little
more efficiently by using folios instead of pages.

I don't _love_ the name mapping_shrink_folio(), but I'm having a hard
time coming up with a verb that means "remove from cache if unused".
Maybe mapping_evict_folio()?  Or filemap_evict_folio()?

The last two patches are just cleanup that should be done at some point,
and since this patchset already conflicts with everything else, why not?
I've stashed these in my for-next tree immediately after converting
__remove_mapping() to take a folio because it seems to fit best there.
The bots may complain about build problems as a result, but this is
really a patch series for humans to review.

Matthew Wilcox (Oracle) (10):
  splice: Use a folio in page_cache_pipe_buf_try_steal()
  mm/truncate: Inline invalidate_complete_page() into its one caller
  mm/truncate: Convert invalidate_inode_page() to use a folio
  mm/truncate: Replace page_mapped() call in invalidate_inode_page()
  mm: Convert remove_mapping() to take a folio
  mm/truncate: Split invalidate_inode_page() into mapping_shrink_folio()
  mm/truncate: Convert __invalidate_mapping_pages() to use a folio
  mm: Turn deactivate_file_page() into deactivate_file_folio()
  mm/truncate: Combine invalidate_mapping_pagevec() and
    __invalidate_mapping_pages()
  fs: Move many prototypes to pagemap.h

 drivers/block/xen-blkback/xenbus.c           |   1 +
 drivers/usb/gadget/function/f_mass_storage.c |   1 +
 fs/coda/file.c                               |   1 +
 fs/iomap/fiemap.c                            |   1 +
 fs/nfsd/filecache.c                          |   1 +
 fs/nfsd/vfs.c                                |   1 +
 fs/splice.c                                  |  24 ++--
 fs/vboxsf/utils.c                            |   1 +
 include/linux/fs.h                           | 120 -------------------
 include/linux/mm.h                           |   1 -
 include/linux/pagemap.h                      | 114 ++++++++++++++++++
 include/linux/swap.h                         |   3 +-
 mm/internal.h                                |   4 +
 mm/memory-failure.c                          |   4 +-
 mm/swap.c                                    |  33 +++--
 mm/truncate.c                                | 109 ++++++++---------
 mm/vmscan.c                                  |  23 ++--
 17 files changed, 219 insertions(+), 223 deletions(-)

-- 
2.34.1

