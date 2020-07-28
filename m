Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5A02310F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgG1RcW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731892AbgG1RcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:32:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F58C061794;
        Tue, 28 Jul 2020 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=njIc4GtApUEkUq+Y3M6myb5PPl1nQCPh1a/7THG/dqg=; b=OzKb/5EQL1+PSalWlZDTMma0JV
        00XCMnNP4RNcsB5khnCW1EtwC3ThpE4WRQEap/aP15nCFaNtB0wf/WIJEHRrTQ+pOqYHgtfAW+fo5
        2K5CwsAcXvwEdsy2fANPA5Cq3wr6pH+Spm37Eh/HwVyzo5JOCfD6SyV0okkBbQXxapD8nrpsmFL9u
        uxSJddj7OZoDpYyPBohVlitF/4lv+qo6G75550JXyNApz4XoPEo3RNiH36G1iEUICGCQqhnVKzQq0
        mYCBILjdt4L+48op1J5giyfQOTJtYduTgPs/k2KtOUtLdIu9LrWmIqN963tWunPx/BJOzuLWfxk42
        W8hckoow==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0TSc-0001t4-7j; Tue, 28 Jul 2020 17:32:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC 0/2] Avoid indirect function calls in iomap
Date:   Tue, 28 Jul 2020 18:32:13 +0100
Message-Id: <20200728173216.7184-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This RFC converts indirect function calls into direct function calls.
It converts one user as an example (readahead).  Converting more users of
iomap_apply() would yield a more advantageous diffstat.  It's actually
slightly more code in each filesystem, but indirect function calls
are pretty expensive.  It also flattens the call graph (see the patch
2 changelog).  This all needs more refinement, but I'm about to start
work on overhauling the block size < page size support, and I thought
I'd send this out now.

It does survive a basic xfstests run.

Matthew Wilcox (Oracle) (2):
  iomap: Add iomap_iter
  iomap: Convert readahead to iomap_iter

 fs/iomap/apply.c       | 29 +++++++++++++++
 fs/iomap/buffered-io.c | 82 ++++++++++++++----------------------------
 fs/xfs/xfs_aops.c      |  9 ++++-
 fs/xfs/xfs_iomap.c     | 15 ++++++++
 fs/xfs/xfs_iomap.h     |  2 ++
 fs/zonefs/super.c      | 20 ++++++++++-
 include/linux/iomap.h  | 67 +++++++++++++++++++++++++++++++++-
 7 files changed, 165 insertions(+), 59 deletions(-)

-- 
2.27.0

