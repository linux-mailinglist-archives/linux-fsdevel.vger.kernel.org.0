Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6864F2B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 21:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiLPUxs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 15:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLPUxq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:53:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A087869A97;
        Fri, 16 Dec 2022 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=hmYtOOn13p4lbysgav7EhLRx986TllxVNwO7mP9Sbd4=; b=Bba+Wb9LRXsH2LmmwZdj+XCa1u
        zs1f+hExV/7EQhNTOV5wIe7qTA+4SPe5cK5G5XMcnjW3JMJHtz07uyrZV/aoISqrfnlrftzfmSrtl
        pYxt89CbtfL4x0M4pICKQxWlpL0owBvEBFdwPptcdBTdsRCs1T6azgYz8IButEKPo0d/l3WdZO7kX
        gBr2Q/+CxuC+ZL25UcnPHLc1atTP5E2CfWsnBnIL2i3wkeYucxGEpge3gtcv6gxvWxRK03uSF8jO0
        MxU8X+9QBKAJt60I/wQJYXQCTNGVg1v5tB0R/6NFIOZ46SzCq1d5C1SYGwYGs96kQPPIb3IM+PZ2+
        Os/tXVZw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p6HiH-00Frfd-Oe; Fri, 16 Dec 2022 20:53:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     reiserfs-devel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 0/8] Convert reiserfs from b_page to b_folio
Date:   Fri, 16 Dec 2022 20:53:39 +0000
Message-Id: <20221216205348.3781217-1-willy@infradead.org>
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

These patches apply on top of
https://lore.kernel.org/linux-fsdevel/20221215214402.3522366-1-willy@infradead.org/

The non-trivial ones mostly revolve around uses of kmap()/kmap_atomic(),
so review from the experts on those would be welcome.  If these all look
good to people, I can pass them off to Andrew for the 6.3 merge window.

Running xfstests against reiserfs gives me 313/701 failures before and
after this set of patches.  I don't have a huge amount of confidence
that we're really getting good coverage from that test run!

Matthew Wilcox (Oracle) (8):
  reiserfs: use b_folio instead of b_page in some obvious cases
  reiserfs: use kmap_local_folio() in _get_block_create_0()
  reiserfs: Convert direct2indirect() to call folio_zero_range()
  reiserfs: Convert reiserfs_delete_item() to use kmap_local_folio()
  reiserfs: Convert do_journal_end() to use kmap_local_folio()
  reiserfs: Convert map_block_for_writepage() to use kmap_local_folio()
  reiserfs: Convert convert_tail_for_hole() to use folios
  reiserfs: Use flush_dcache_folio() in reiserfs_quota_write()

 fs/reiserfs/inode.c           | 73 +++++++++++++++++------------------
 fs/reiserfs/journal.c         | 12 +++---
 fs/reiserfs/prints.c          |  4 +-
 fs/reiserfs/stree.c           |  9 +++--
 fs/reiserfs/super.c           |  2 +-
 fs/reiserfs/tail_conversion.c | 19 ++++-----
 6 files changed, 59 insertions(+), 60 deletions(-)

-- 
2.35.1

