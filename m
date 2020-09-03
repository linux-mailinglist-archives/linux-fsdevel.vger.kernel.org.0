Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A425C3C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Sep 2020 16:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgICO6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Sep 2020 10:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729137AbgICOJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:09:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA37C061247
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2020 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BGySdJflA1gKFqjiDRkNXG0Jv90KRbvhCWmyg0BrMEE=; b=BS3D2UgX8tmFhwbyD3oVT64EAm
        1nG6QMe6BKXHTG9n7z+faTybdzawCxBvb9CbVpcgTGR9obSidOnK2p4ttXtfIAEsJ1jORkBekPH6K
        3Bnmn2Tg7d0gZOG0WWgk3XRuMNRN1OXIuYJerA78t/lHVBPaEtYeQ5T4OdGg3JMfINuRB7Nc+jNoZ
        Ui0Dxzy9peCJGdfKW3xgEt/cl2ygPLKy+lhZgpvA5/fGddP623pwFNDQlhu9SR1PCza7BIyy8J8LP
        oAAGj8q9vhoORy2UTte8lmBYvq1q5SukfO3FlkEMwweBuEY+Pm+827OXp8E+c7msgGhcrNJ8znxfp
        iHl5zr6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpv1-0003hs-3p; Thu, 03 Sep 2020 14:08:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 0/9] Readahead patches for 5.9/5.10
Date:   Thu,  3 Sep 2020 15:08:35 +0100
Message-Id: <20200903140844.14194-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

The first patch from David should go upstream soon as a bugfix.

The others are infrastructure for both the THP patchset and for the
fscache rewrite, so it'd be great to get those upstream early in 5.10.

David Howells (4):
  Fix khugepaged's request size in collapse_file
  mm/readahead: Pass readahead_control to force_page_cache_ra
  mm/filemap: Fold ra_submit into do_sync_mmap_readahead
  mm/readahead: Pass a file_ra_state into force_page_cache_ra

Matthew Wilcox (Oracle) (5):
  mm/readahead: Add DEFINE_READAHEAD
  mm/readahead: Make page_cache_ra_unbounded take a readahead_control
  mm/readahead: Make do_page_cache_ra take a readahead_control
  mm/readahead: Make ondemand_readahead take a readahead_control
  mm/readahead: Add page_cache_sync_ra and page_cache_async_ra

 fs/ext4/verity.c        |   4 +-
 fs/f2fs/verity.c        |   4 +-
 include/linux/pagemap.h |  72 ++++++++++++++++++----
 mm/filemap.c            |  10 ++--
 mm/internal.h           |  19 +++---
 mm/khugepaged.c         |   2 +-
 mm/readahead.c          | 130 +++++++++++++++-------------------------
 7 files changed, 127 insertions(+), 114 deletions(-)

-- 
2.28.0

