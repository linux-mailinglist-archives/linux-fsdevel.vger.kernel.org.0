Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F6E46E5FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhLIJ6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 04:58:30 -0500
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:41867 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhLIJ63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:58:29 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id 6E628FABC1
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Dec 2021 09:54:55 +0000 (GMT)
Received: (qmail 28472 invoked from network); 9 Dec 2021 09:54:55 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Dec 2021 09:54:55 -0000
Date:   Thu, 9 Dec 2021 09:54:53 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: vmscan: reduce throttling due to a failure to make
 progress -fix
Message-ID: <20211209095453.GM3366@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hugh Dickins reported the following

	My tmpfs swapping load (tweaked to use huge pages more heavily
	than in real life) is far from being a realistic load: but it was
	notably slowed down by your throttling mods in 5.16-rc, and this
	patch makes it well again - thanks.

	But: it very quickly hit NULL pointer until I changed that last
	line to

        if (first_pgdat)
                consider_reclaim_throttle(first_pgdat, sc);

The likely issue is that huge pages are a major component of the test
workload. When this is the case, first_pgdat may never get set if
compaction is ready to continue due to this check

        if (IS_ENABLED(CONFIG_COMPACTION) &&
            sc->order > PAGE_ALLOC_COSTLY_ORDER &&
            compaction_ready(zone, sc)) {
                sc->compaction_ready = true;
                continue;
        }

If this was true for every zone in the zonelist, first_pgdat would never
get set resulting in a NULL pointer exception.

This is a fix to the mmotm patch
mm-vmscan-reduce-throttling-due-to-a-failure-to-make-progress.patch

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4c4d5f6cd8a3..700434db5735 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3530,7 +3530,8 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 		shrink_node(zone->zone_pgdat, sc);
 	}
 
-	consider_reclaim_throttle(first_pgdat, sc);
+	if (first_pgdat)
+		consider_reclaim_throttle(first_pgdat, sc);
 
 	/*
 	 * Restore to original mask to avoid the impact on the caller if we
