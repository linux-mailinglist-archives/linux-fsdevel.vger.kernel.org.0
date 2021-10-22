Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA402437386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhJVIOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:14:23 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:48969 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232139AbhJVIOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:14:22 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 7CAA721F2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 09:12:04 +0100 (IST)
Received: (qmail 16221 invoked from network); 22 Oct 2021 08:12:04 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2021 08:12:04 -0000
Date:   Fri, 22 Oct 2021 09:12:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmscan: Centralise timeout values for
 reclaim_throttle
Message-ID: <20211022081202.GG3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <20211019090108.25501-7-mgorman@techsingularity.net>
 <163486477387.17149.7808824931340167601@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163486477387.17149.7808824931340167601@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:06:13PM +1100, NeilBrown wrote:
> On Tue, 19 Oct 2021, Mel Gorman wrote:
> ...
> > +	switch(reason) {
> > +	case VMSCAN_THROTTLE_NOPROGRESS:
> > +	case VMSCAN_THROTTLE_WRITEBACK:
> > +		timeout = HZ/10;
> > +
> > +		if (atomic_inc_return(&pgdat->nr_writeback_throttled) == 1) {
> > +			WRITE_ONCE(pgdat->nr_reclaim_start,
> > +				node_page_state(pgdat, NR_THROTTLED_WRITTEN));
> 
> You have introduced a behaviour change that wasn't flagged in the commit
> message.
> Previously nr_writeback_throttled was only incremented for
> VMSCAN_THROTTLE_WRITEBACK, now it is incremented for
> VMSCAN_THROTTLE_NOPROGRESS as well.  
> 
> Some justification would be good.
> 

This is the result of rebase near the end of a day going sideways. There
is no justification, it's just wrong.

I'm rerunning the entire series, will update the leader and resend the
series.

--8<--
mm/vmscan: Centralise timeout values for reclaim_throttle -fix

Neil Brown spotted the fallthrough-logic for reclaim_throttle was wrong --
only VMSCAN_THROTTLE_WRITEBACK affects pgdat->nr_writeback_throttled. This
was the result of a rebase going sideways and only happens to sometimes
work by co-incidence.

This is a fix to the mmotm patch
mm-vmscan-centralise-timeout-values-for-reclaim_throttle.patch

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/vmscan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1f5c467dc83c..64c38979b7df 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1032,7 +1032,6 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	 * of the inactive LRU.
 	 */
 	switch(reason) {
-	case VMSCAN_THROTTLE_NOPROGRESS:
 	case VMSCAN_THROTTLE_WRITEBACK:
 		timeout = HZ/10;
 
@@ -1041,6 +1040,9 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 				node_page_state(pgdat, NR_THROTTLED_WRITTEN));
 		}
 
+		break;
+	case VMSCAN_THROTTLE_NOPROGRESS:
+		timeout = HZ/10;
 		break;
 	case VMSCAN_THROTTLE_ISOLATED:
 		timeout = HZ/50;
@@ -1055,7 +1057,7 @@ void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason)
 	ret = schedule_timeout(timeout);
 	finish_wait(wqh, &wait);
 
-	if (reason == VMSCAN_THROTTLE_ISOLATED)
+	if (reason == VMSCAN_THROTTLE_WRITEBACK)
 		atomic_dec(&pgdat->nr_writeback_throttled);
 
 	trace_mm_vmscan_throttled(pgdat->node_id, jiffies_to_usecs(timeout),
