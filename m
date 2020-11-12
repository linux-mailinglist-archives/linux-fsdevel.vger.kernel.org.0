Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB722B1054
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 22:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgKLV12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 16:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgKLV1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:27:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5BBC0613D1;
        Thu, 12 Nov 2020 13:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8axyOdS5T903WsgMUOPiWyL+TAWT7lLkDYHasIa5tYA=; b=CrGfwCIv5OsRz2rMW/f1C6GreK
        8WiKFwpQ52dYowy5mI7ySWoPoieMlBqoUFlncoa3wFNS6q14Wo52TdrWfhAwxbilawrg+qJRI/8jo
        SveEmdGtLKoG5/r4RQEmxI4g4dhVRa2YwsRhiU1Vnr7cSK41k6yUCHW6eSHFGszeMoFVVCD9Nxcuq
        YcX4UtU8UzWgoAyJqU1YbmYY0UgvLX1oysfgHLw/idfKlXoWqkM3iI0xG9WUp810R4Ip7pCRwIIZP
        ySX3cg0xMCYf2pXWvrmQgFg8jYO+Mz9/JEJLU3ZBczC0dZVZ3YOc7CzxRVxSfoG8TlyGsZIhlF/JW
        ct2/vhAA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdK79-0007G0-Hm; Thu, 12 Nov 2020 21:26:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        akpm@linux-foundation.org, hughd@google.com, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Date:   Thu, 12 Nov 2020 21:26:25 +0000
Message-Id: <20201112212641.27837-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This THP prep patchset changes several page cache iteration APIs to only
return head pages.

 - It's only possible to tag head pages in the page cache, so only
   return head pages, not all their subpages.
 - Factor a lot of common code out of the various batch lookup routines
 - Add mapping_seek_hole_data()
 - Unify find_get_entries() and pagevec_lookup_entries()
 - Make find_get_entries only return head pages, like find_get_entry().

These are only loosely connected, but they seem to make sense together
as a series.

v4:
 - Add FGP_ENTRY, remove find_get_entry and find_lock_entry
 - Rename xas_find_get_entry to find_get_entry
 - Add "Optimise get_shadow_from_swap_cache"
 - Move "iomap: Use mapping_seek_hole_data" to this patch series
 - Rebase against next-20201112

Matthew Wilcox (Oracle) (16):
  mm: Make pagecache tagged lookups return only head pages
  mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
  mm/swap: Optimise get_shadow_from_swap_cache
  mm: Add FGP_ENTRY
  mm/filemap: Rename find_get_entry to mapping_get_entry
  mm/filemap: Add helper for finding pages
  mm/filemap: Add mapping_seek_hole_data
  iomap: Use mapping_seek_hole_data
  mm: Add and use find_lock_entries
  mm: Add an 'end' parameter to find_get_entries
  mm: Add an 'end' parameter to pagevec_lookup_entries
  mm: Remove nr_entries parameter from pagevec_lookup_entries
  mm: Pass pvec directly to find_get_entries
  mm: Remove pagevec_lookup_entries
  mm/truncate,shmem: Handle truncates that split THPs
  mm/filemap: Return only head pages from find_get_entries

 fs/iomap/seek.c         | 125 ++------------
 include/linux/pagemap.h |   6 +-
 include/linux/pagevec.h |   4 -
 mm/filemap.c            | 351 +++++++++++++++++++++++++---------------
 mm/internal.h           |   7 +-
 mm/shmem.c              | 218 ++++++-------------------
 mm/swap.c               |  38 +----
 mm/swap_state.c         |   7 +-
 mm/truncate.c           | 249 +++++++++++-----------------
 9 files changed, 390 insertions(+), 615 deletions(-)

-- 
2.28.0

