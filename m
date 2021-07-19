Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6DC3CEF15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244092AbhGSV10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357281AbhGSSAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:00:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD1C061574;
        Mon, 19 Jul 2021 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cRYuesrZ3ObFa4fKCj1q2UzL69UAq5pal7SYP2/grTc=; b=btU2/FVCn/k/+J3rnGAsBpMJjb
        El4oZTgVbeUcsV0YVuKKKUaFi8u/Oy/pIadYc6YreUbqMsYWetutCYyAioE3HbCWj9FaNiqW+al00
        iW2GjahAqQmLRvh6l6h0YWbu+WkUNEWKtC+Ztiv/Oa+BbWBNxOorq0MaNJe0mkj3t8rWgIxjFpusR
        N4pdxuz/rUPpYmCL37ApLkPRKRhGj9PCQEreFwhomb8W5KdEB0g8ZdjAlD/tvx0XL+ZMqdi72YtyZ
        ydMhxnQ5C5bWkbtj0wgL/+UVlSdE47pfvVnxsqv/QDt7AngxzCGcUhkQFGkQ70E/Hk7I7kFEx7V2U
        jAwyRYAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YBO-007LQq-MU; Mon, 19 Jul 2021 18:40:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH v15 00/17] Folio support in block + iomap layers
Date:   Mon, 19 Jul 2021 19:39:44 +0100
Message-Id: <20210719184001.1750630-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is (almost) everything necessary to support folios in iomap.
No regressions with an xfstests run on my setup.

v15:
 - Turn the / PAGE_SIZE into >> PAGE_SHIFT, as requested by Darrick
 - Modify the for loop to be in Darrick's preferred form
 - Improve documentation of bio_add_folio()
 - Add documentation for bio_for_each_folio_all() and folio_iter
 - Add bio.h to the generated kernel-doc
 - Rebase on top of folio for-next (which includes the iomap changes in -rc2)
   https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next

Matthew Wilcox (Oracle) (17):
  block: Add bio_add_folio()
  block: Add bio_for_each_folio_all()
  iomap: Convert to_iomap_page to take a folio
  iomap: Convert iomap_page_create to take a folio
  iomap: Convert iomap_page_release to take a folio
  iomap: Convert iomap_releasepage to use a folio
  iomap: Convert iomap_invalidatepage to use a folio
  iomap: Pass the iomap_page into iomap_set_range_uptodate
  iomap: Use folio offsets instead of page offsets
  iomap: Convert bio completions to use folios
  iomap: Convert readahead and readpage to use a folio
  iomap: Convert iomap_page_mkwrite to use a folio
  iomap: Convert iomap_write_begin and iomap_write_end to folios
  iomap: Convert iomap_read_inline_data to take a folio
  iomap: Convert iomap_write_end_inline to take a folio
  iomap: Convert iomap_add_to_ioend to take a folio
  iomap: Convert iomap_migrate_page to use folios

 Documentation/core-api/kernel-api.rst |   1 +
 block/bio.c                           |  21 ++
 fs/iomap/buffered-io.c                | 511 +++++++++++++-------------
 include/linux/bio.h                   |  56 ++-
 4 files changed, 327 insertions(+), 262 deletions(-)

-- 
2.30.2

