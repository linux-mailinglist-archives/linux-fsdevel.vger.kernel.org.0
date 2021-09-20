Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ED74111C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhITJPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 05:15:34 -0400
Received: from outbound-smtp14.blacknight.com ([46.22.139.231]:46319 "EHLO
        outbound-smtp14.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236759AbhITJPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:15:16 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp14.blacknight.com (Postfix) with ESMTPS id A52EA1C535E
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 09:54:47 +0100 (IST)
Received: (qmail 26556 invoked from network); 20 Sep 2021 08:54:47 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 20 Sep 2021 08:54:47 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Date:   Mon, 20 Sep 2021 09:54:31 +0100
Message-Id: <20210920085436.20939-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc list similar to "congestion_wait() and GFP_NOFAIL" as they're loosely
related.

This is a prototype series that removes all calls to congestion_wait
in mm/ and deletes wait_iff_congested. It's not a clever
implementation but congestion_wait has been broken for a long time
(https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
Even if it worked, it was never a great idea. While excessive
dirty/writeback pages at the tail of the LRU is one possibility that
reclaim may be slow, there is also the problem of too many pages being
isolated and reclaim failing for other reasons (elevated references,
too many pages isolated, excessive LRU contention etc).

This series replaces the reclaim conditions with event driven ones

o If there are too many dirty/writeback pages, sleep until a timeout
  or enough pages get cleaned
o If too many pages are isolated, sleep until enough isolated pages
  are either reclaimed or put back on the LRU
o If no progress is being made, let direct reclaim tasks sleep until
  another task makes progress

This has been lightly tested only and the testing was useless as the
relevant code was not executed. The workload configurations I had that
used to trigger these corner cases no longer work (yey?) and I'll need
to implement a new synthetic workload. If someone is aware of a realistic
workload that forces reclaim activity to the point where reclaim stalls
then kindly share the details.

-- 
2.31.1

Mel Gorman (5):
  mm/vmscan: Throttle reclaim until some writeback completes if
    congested
  mm/vmscan: Throttle reclaim and compaction when too may pages are
    isolated
  mm/vmscan: Throttle reclaim when no progress is being made
  mm/writeback: Throttle based on page writeback instead of congestion
  mm/page_alloc: Remove the throttling logic from the page allocator

 include/linux/backing-dev.h      |   1 -
 include/linux/mmzone.h           |  12 ++++
 include/trace/events/vmscan.h    |  38 +++++++++++
 include/trace/events/writeback.h |   7 --
 mm/backing-dev.c                 |  48 --------------
 mm/compaction.c                  |   2 +-
 mm/filemap.c                     |   1 +
 mm/internal.h                    |  11 ++++
 mm/memcontrol.c                  |  10 +--
 mm/page-writeback.c              |  11 +++-
 mm/page_alloc.c                  |  26 ++------
 mm/vmscan.c                      | 110 ++++++++++++++++++++++++++++---
 mm/vmstat.c                      |   1 +
 13 files changed, 180 insertions(+), 98 deletions(-)

-- 
2.31.1

