Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A271394FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgAMPhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:37:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57844 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PyHbyvKFQNe8v5T0y5nRYH5QHMFCBJQIcCvIL1xBpxU=; b=aXRA6eIkhgUgZqBvbUS+ZT0AY
        Ux0HfjsTPwuBndSDbLlPFYPMuDrL5UPjn7V+uWPhI0Uonke0LyYqhJQt5I8fekhyUoIr/i7MENFfH
        krWVP95kKeqDv5LMdxMgajQV8ep7p4jSGWuWcFcbW+SWoQrIjORQd4iEMjtI5FE91MUy9jD2QTWQX
        SO+CvbiJfx7clU0wIuWhNtsC05ZLJzRnh5XqWFKeoETzy88ij9ENSzkSliyoXrBFEKrsOZjtCgBjG
        CvnWRJjqZ6vQEaxyuAvXYKUW89bjx8tk6KlSxpK8yE2KFdMB3VRIoQrd0K6ZGoFvHj8QAoyPyvAVR
        MhswCUdAQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1mr-00075X-0L; Mon, 13 Jan 2020 15:37:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        jlayton@kernel.org, hch@infradead.org
Subject: [RFC 0/8] Replacing the readpages a_op
Date:   Mon, 13 Jan 2020 07:37:38 -0800
Message-Id: <20200113153746.26654-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

I think everybody hates the readpages API.  The fundamental problem with
it is that it passes the pages to be read on a doubly linked list, using
the ->lru list in the struct page.  That means the filesystems have to
do the work of calling add_to_page_cache{,_lru,_locked}, and handling
failures (because another task is also accessing that chunk of the file,
and so it fails).

This is an attempt to add a ->readahead op to replace ->readpages.  I've
converted two users, iomap/xfs and cifs.  The cifs conversion is lacking
fscache support, and that's just because I didn't want to do that work;
I don't believe there's anything fundamental to it.  But I wanted to do
iomap because it is The Infrastructure Of The Future and cifs because it
is the sole remaining user of add_to_page_cache_locked(), which enables
the last two patches in the series.  By the way, that gives CIFS access
to the workingset shadow infrastructure, which it had to ignore before
because it couldn't put pages onto the lru list at the right time.

The fundamental question is, how do we indicate to the implementation of
->readahead what pages to operate on?  I've gone with passing a pagevec.
This has the obvious advantage that it's a data structure that already
exists and is used within filemap for batches of pages.  I had to add a
bit of new infrastructure to support iterating over the pages in the
pagevec, but with that done, it's quite nice.

I think the biggest problem is that the size of the pagevec is limited
to 15 pages (60kB).  So that'll mean that if the readahead window bumps
all the way up to 256kB, we may end up making 5 BIOs (and merging them)
instead of one.  I'd kind of like to be able to allocate variable length
pagevecs while allowing regular pagevecs to be allocated on the stack,
but I can't figure out a way to do that.  eg this doesn't work:

-       struct page *pages[PAGEVEC_SIZE];
+       union {
+               struct page *pages[PAGEVEC_SIZE];
+               struct page *_pages[];
+       }

and if we just allocate them, useful and wonderful tools are going to
point out when pages[16] is accessed that we've overstepped the end of
the array.

I have considered alternatives to the pagevec like just having the
->readahead implementation look up the pages in the i_pages XArray
directly.  That didn't work out too well.

Anyway, I want to draw your attention to the diffstat below.  Net 91 lines
deleted, and that's with adding all the infrastructure for ->readahead
and getting rid of none of the infrastructure for ->readpages.  There's
probably a good couple of hundred lines of code to be deleted there.

Matthew Wilcox (Oracle) (8):
  pagevec: Add an iterator
  mm: Fix the return type of __do_page_cache_readahead
  mm: Use a pagevec for readahead
  mm/fs: Add a_ops->readahead
  iomap,xfs: Convert from readpages to readahead
  cifs: Convert from readpages to readahead
  mm: Remove add_to_page_cache_locked
  mm: Unify all add_to_page_cache variants

 Documentation/filesystems/locking.rst |   8 +-
 Documentation/filesystems/vfs.rst     |   9 ++
 fs/cifs/file.c                        | 125 ++++-------------------
 fs/iomap/buffered-io.c                |  60 +++--------
 fs/iomap/trace.h                      |  18 ++--
 fs/xfs/xfs_aops.c                     |  12 +--
 include/linux/fs.h                    |   3 +
 include/linux/iomap.h                 |   4 +-
 include/linux/pagemap.h               |  23 +----
 include/linux/pagevec.h               |  20 ++++
 mm/filemap.c                          |  72 ++++---------
 mm/internal.h                         |   2 +-
 mm/readahead.c                        | 141 +++++++++++++++++---------
 13 files changed, 203 insertions(+), 294 deletions(-)

-- 
2.24.1

