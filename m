Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096E4298636
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 05:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422276AbgJZElm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 00:41:42 -0400
Received: from casper.infradead.org ([90.155.50.34]:60092 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421510AbgJZEll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pxEXet7MGL+dPnK3y9N8fU3daWL9JbWFkgKOPtlkptM=; b=iGOYd9CBbXIgHNstxbpWvXuMMn
        GqHz0Sp4oTweX01lrIEM9Yo3LHZHGOhlomvPCbGgiaOs1ORNj1MvEDmDXZcLYrtiBiVSm2UIgNdPA
        SA96euAaRO9BxOlVxo1u9QTQSEtj3MrB/Gwvbqps+iB2Uff+KCHwFnQFXPbqGBLx+ZMNIbBSHzmTa
        wZ+yXY3r20PxmC6dThHpvHR+MTNgiABqVIRnOh62xOfj+gTph7Kwoq0YQUufdltkwwg5gWfFXTRU6
        YzrX2WMTjID57kfmoEcevRt76izVSV1sCsFTNnYUPP6C2iuBJUPaIn6/4te//In87HmwfBEEoEAtO
        gsG47Bhw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWtta-0006Zg-8y; Mon, 26 Oct 2020 04:14:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/12] Overhaul multi-page lookups for THP
Date:   Mon, 26 Oct 2020 04:13:56 +0000
Message-Id: <20201026041408.25230-1-willy@infradead.org>
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
as a series.  Another ~30 MM patches to come after this batch to
enable THPs for filesystems.

Matthew Wilcox (Oracle) (12):
  mm: Make pagecache tagged lookups return only head pages
  mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
  mm/filemap: Add helper for finding pages
  mm/filemap: Add mapping_seek_hole_data
  mm: Add and use find_lock_entries
  mm: Add an 'end' parameter to find_get_entries
  mm: Add an 'end' parameter to pagevec_lookup_entries
  mm: Remove nr_entries parameter from pagevec_lookup_entries
  mm: Pass pvec directly to find_get_entries
  mm: Remove pagevec_lookup_entries
  mm/truncate,shmem: Handle truncates that split THPs
  mm/filemap: Return only head pages from find_get_entries

 include/linux/pagemap.h |   5 +-
 include/linux/pagevec.h |   4 -
 mm/filemap.c            | 275 +++++++++++++++++++++++++++-------------
 mm/internal.h           |   5 +
 mm/shmem.c              | 213 +++++++------------------------
 mm/swap.c               |  38 +-----
 mm/truncate.c           | 249 ++++++++++++++----------------------
 7 files changed, 335 insertions(+), 454 deletions(-)

-- 
2.28.0

