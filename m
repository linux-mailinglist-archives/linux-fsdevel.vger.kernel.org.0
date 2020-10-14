Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11BF28DDAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgJNJap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 05:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgJNJTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAED8C0F26E8;
        Tue, 13 Oct 2020 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=JQvYb8jJr+MgXpV2DsLI4lPmkqQj4myz+oW6Z2HPnPY=; b=DS/5QqP2xlNHHOB0YjQa7JsRg5
        T9p86exNHJEnsbNVDku2A/JVqG858e+rDx8zX7Fp+9dSxVbdcXHoyg5Q9GAD4Kd7C/H9pHPZE3fyk
        9Tzs6UQOyGzU79rfcfGQ4QFs9KdvMJ7n4u2/E8bzXa7qWv46yHUKCRw7DZQ+4l26YW7b1q4gvb8Vi
        Gss5X/7GIICn7Q84dy+s9aBwc94foz5Vscmy7M4C+e4AgoP8FPXGOis22SoO0EOQTX6HUuxyh6gRc
        um00ulVxxKwgHs2MctRkTu5vDHt4yZF7G4Y3TkvyzzvmLXfXJeUzyRIohA0VV7KZThIS42/fExuxK
        zbM4pCcw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSX55-0005i0-AC; Wed, 14 Oct 2020 03:03:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 00/14] Transparent Huge Page support for XFS
Date:   Wed, 14 Oct 2020 04:03:43 +0100
Message-Id: <20201014030357.21898-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset includes all the filesystem and iomap changes needed to
support transparent huge pages.  A separate patchset will enable the MM
side of things.  I'm hoping Darrick agrees to take the first two patches
through the iomap tree,

These patches are for review.  They don't currently apply to the iomap
tree due to some conflicting patches.  I'll rebase on top of -rc1 once
it's out (they do apply to 5.9).  

Matthew Wilcox (Oracle) (14):
  fs: Support THPs in vfs_dedupe_file_range
  fs: Make page_mkwrite_check_truncate thp-aware
  iomap: Support THPs in BIO completion path
  iomap: Support THPs in iomap_adjust_read_range
  iomap: Support THPs in invalidatepage
  iomap: Support THPs in iomap_is_partially_uptodate
  iomap: Support THPs in readpage
  iomap: Support THPs in readahead
  iomap: Change iomap_write_begin calling convention
  iomap: Handle THPs when writing to pages
  iomap: Support THP writeback
  iomap: Inline data shouldn't see THPs
  iomap: Handle tail pages in iomap_page_mkwrite
  xfs: Support THPs

 fs/iomap/buffered-io.c  | 307 +++++++++++++++++++++++++++-------------
 fs/read_write.c         |   8 +-
 fs/xfs/xfs_aops.c       |   2 +-
 fs/xfs/xfs_super.c      |   2 +-
 include/linux/pagemap.h |  10 +-
 5 files changed, 219 insertions(+), 110 deletions(-)

-- 
2.28.0

