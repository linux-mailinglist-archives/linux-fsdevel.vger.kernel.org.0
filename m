Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5952500E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgHXPXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgHXPR4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DFEC061799;
        Mon, 24 Aug 2020 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vg63jAHJfG2SzXwAA4F8u4EABDJK8kFbtsgiuvgE/iE=; b=O4ub1tEVsA9kU09ZzyqjnYqLiE
        qd3Ogz447N5q6xe5QqJS6PetMeBFjPO8xP+KShjzwd1fzVYDV5AxzmXJ2pZNJbaMyNX8vto74+uEK
        cf0Fy7D0KkJe38ALG6R99zIFxNQHnKdG1FCEXgGVfyoKHrHt/oBmeVmO5rmIFU1WDzmck7Qzjz7ZB
        hLDNe1ccAKsDBIq3z5d08YmyqEnWEC7g+OhGVVrKgshg9aSK0pVTV+OrnwCM7ssLztd7swOuJ/3HT
        Rgx+o/1FRjyEKjjwSGvGeEvWOt8uyfl3atffNAhwVuMon7a8+hOuLJBonyWCRmc/BdzF7+QOwogOm
        Hg7OajcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDW-0004CN-5w; Mon, 24 Aug 2020 15:17:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] iomap/fs/block patches for 5.11
Date:   Mon, 24 Aug 2020 16:16:49 +0100
Message-Id: <20200824151700.16097-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As promised earlier [1], here are the patches which I would like to
merge into 5.11 to support THPs.  They depend on that earlier series.
If there's anything in here that you'd like to see pulled out and added
to that earlier series, let me know.

There are a couple of pieces in here which aren't exactly part of
iomap, but I think make sense to take through the iomap tree.

[1] https://lore.kernel.org/linux-fsdevel/20200824145511.10500-1-willy@infradead.org/

Matthew Wilcox (Oracle) (11):
  fs: Make page_mkwrite_check_truncate thp-aware
  mm: Support THPs in zero_user_segments
  mm: Zero the head page, not the tail page
  block: Add bio_for_each_thp_segment_all
  iomap: Support THPs in iomap_adjust_read_range
  iomap: Support THPs in invalidatepage
  iomap: Support THPs in read paths
  iomap: Change iomap_write_begin calling convention
  iomap: Support THPs in write paths
  iomap: Inline data shouldn't see THPs
  iomap: Handle tail pages in iomap_page_mkwrite

 fs/iomap/buffered-io.c  | 178 ++++++++++++++++++++++++----------------
 include/linux/bio.h     |  13 +++
 include/linux/bvec.h    |  27 ++++++
 include/linux/highmem.h |  15 +++-
 include/linux/pagemap.h |  10 +--
 mm/highmem.c            |  62 +++++++++++++-
 mm/shmem.c              |   7 ++
 mm/truncate.c           |   7 ++
 8 files changed, 236 insertions(+), 83 deletions(-)

-- 
2.28.0

