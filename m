Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B413B7D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAOCjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:39:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAOCjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dgVSjPiUW1SPVGvVVdOphNpP+4nkQOa7q3OECJziRBo=; b=etdc3dH2zGxPrx8fVOWxw3kEF
        d4vTgZ7k/ntJ5a69XXQyRytwqzUFxwqSGLp++ckJsghZRNfNj35E8O3YjbO/HH79+bXmXIXp0eUvE
        /J3UId9CWn++GN1Ee0wjKqPhfJWOceJIdhc6O+oEmmn/c1kcO3w+1Qof4AxrgUVWPOpN5tFzIX5q4
        khVQ7u96RzM/WBezBgE/LeQ2p3g125Ll1vnX1aqXFOi/Bc3jvmIf0V+Mk4z4u9U1/PefbIC//cOrT
        TJhzqgPZgjFaUQ+yVXstUIj663mmWV1/8ztF/THMsH7b+yrDSlr4L1fT6KRueW9uIm+GHT8Vt1VLY
        ck7FjsewQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZx-0008AB-L4; Wed, 15 Jan 2020 02:38:45 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [RFC v2 0/9] Replacing the readpages a_op
Date:   Tue, 14 Jan 2020 18:38:34 -0800
Message-Id: <20200115023843.31325-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This is an attempt to add a ->readahead op to replace ->readpages.  I've
converted two users, iomap/xfs and cifs.  The cifs conversion is lacking
fscache support, and that's just because I didn't want to do that work;
I don't believe there's anything fundamental to it.  But I wanted to do
iomap because it is The Infrastructure Of The Future and cifs because it
is the sole remaining user of add_to_page_cache_locked(), which enables
the last two patches in the series.  By the way, that gives CIFS access
to the workingset shadow infrastructure, which it had to ignore before
because it couldn't put pages onto the lru list at the right time.

v2: Chris asked me to show what this would look like if we just have
the implementation look up the pages in the page cache, and I managed
to figure out some things I'd done wrong last time.  It's even simpler
than v1 (net 104 lines deleted).

Matthew Wilcox (Oracle) (9):
  mm: Fix the return type of __do_page_cache_readahead
  readahead: Ignore return value of ->readpages
  XArray: Add xarray_for_each_range
  readahead: Put pages in cache earlier
  mm: Add readahead address space operation
  iomap,xfs: Convert from readpages to readahead
  cifs: Convert from readpages to readahead
  mm: Remove add_to_page_cache_locked
  mm: Unify all add_to_page_cache variants

 Documentation/core-api/xarray.rst     |  10 +-
 Documentation/filesystems/locking.rst |   7 +-
 Documentation/filesystems/vfs.rst     |  11 ++
 fs/cifs/file.c                        | 143 +++++---------------------
 fs/iomap/buffered-io.c                |  72 +++----------
 fs/iomap/trace.h                      |   2 +-
 fs/xfs/xfs_aops.c                     |  10 +-
 include/linux/fs.h                    |   2 +
 include/linux/iomap.h                 |   2 +-
 include/linux/pagemap.h               |  25 ++---
 include/linux/xarray.h                |  30 ++++++
 mm/filemap.c                          |  72 ++++---------
 mm/internal.h                         |   2 +-
 mm/readahead.c                        |  76 +++++++++-----
 14 files changed, 180 insertions(+), 284 deletions(-)

-- 
2.24.1

