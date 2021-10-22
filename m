Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA42A4373BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJVIlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:41:50 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:40023 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231984AbhJVIlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:41:47 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 5798F1C47B0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 09:39:29 +0100 (IST)
Received: (qmail 28203 invoked from network); 22 Oct 2021 08:39:29 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2021 08:39:29 -0000
Date:   Fri, 22 Oct 2021 09:39:27 +0100
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
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Message-ID: <20211022083927.GI3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <163486531001.17149.13533181049212473096@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163486531001.17149.13533181049212473096@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 12:15:10PM +1100, NeilBrown wrote:
> On Tue, 19 Oct 2021, Mel Gorman wrote:
> > Changelog since v3
> > o Count writeback completions for NR_THROTTLED_WRITTEN only
> > o Use IRQ-safe inc_node_page_state
> > o Remove redundant throttling
> > 
> > This series is also available at
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-reclaimcongest-v4r2
> > 
> > This series that removes all calls to congestion_wait
> > in mm/ and deletes wait_iff_congested. 
> 
> Thanks for this.
> I don't have sufficient expertise for a positive review, but it seems to
> make sense with one exception which I have commented on separately.
> 

A test battering NFS would still be nice!

> In general, I still don't like the use of wake_up_all(), though it won't
> cause incorrect behaviour.
> 

Removing wake_up_all would be tricky. Ideally it would be prioritised but
more importantly, some sort of guarantee should exist that enough wakeup
events trigger to wake tasks before the timeout. That would need careful
thinking about each reclaim reason. For example, if N tasks throttle on
NOPROGRESS, there is no guarantee that N tasks are currently in reclaim
that would wake each sleeping task as progress is made. It's similar
for writeback, are enough pages under writeback to trigger each wakeup?
A more subtle issue is if each reason should be strict if waking tasks one
at a time. For example, a task sleeping on writeback might make progress
for other reasons such as the working set changing during reclaim or a
large task exiting. Of course the same concerns exist for the series as
it stands but the worst case scenarios are mitigated by wake_up_all.

> I would prefer the first patch would:
>  - define NR_VMSCAN_THROTTLE
>  - make reclaim_wait an array
>  - spelled nr_reclaim_throttled as nr_writeback_throttled
> 
> rather than leaving those changes for the second patch.  I think that
> would make review easier.
> 

I can do this. Normally I try structure series from least-to-most
controversial so that it can be cut at any point and still make sense
so the array was defined in the second patch because that's when it is
required. However, I already had defined the enum in patch 1 for the
tracepoint so I might as well make it an array too.

-- 
Mel Gorman
SUSE Labs
