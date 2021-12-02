Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C95E4668AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 17:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359744AbhLBQzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 11:55:48 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:51153 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241758AbhLBQzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:55:47 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 14FD9CABB3
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 16:52:23 +0000 (GMT)
Received: (qmail 30231 invoked from network); 2 Dec 2021 16:52:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Dec 2021 16:52:22 -0000
Date:   Thu, 2 Dec 2021 16:52:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211202165220.GZ3366@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 02, 2021 at 08:30:51AM -0800, Shakeel Butt wrote:
> Hi Mel,
> 
> On Thu, Dec 2, 2021 at 7:07 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Mike Galbraith, Alexey Avramov and Darrick Wong all reported similar
> > problems due to reclaim throttling for excessive lengths of time.
> > In Alexey's case, a memory hog that should go OOM quickly stalls for
> > several minutes before stalling. In Mike and Darrick's cases, a small
> > memcg environment stalled excessively even though the system had enough
> > memory overall.
> >
> > Commit 69392a403f49 ("mm/vmscan: throttle reclaim when no progress is being
> > made") introduced the problem although commit a19594ca4a8b ("mm/vmscan:
> > increase the timeout if page reclaim is not making progress") made it
> > worse. Systems at or near an OOM state that cannot be recovered must
> > reach OOM quickly and memcg should kill tasks if a memcg is near OOM.
> >
> 
> Is there a reason we can't simply revert 69392a403f49 instead of adding
> more code/heuristics? Looking more into 69392a403f49, I don't think the
> code and commit message are in sync.
> 
> For the memcg reclaim, instead of just removing congestion_wait or
> replacing it with schedule_timeout in mem_cgroup_force_empty(), why
> change the behavior of all memcg reclaim. Also this patch effectively
> reverts that behavior of 69392a403f49.
> 

It doesn't fully revert it but I did consider reverting it. The reason
why I preserved it because the intent originally was to throttle somewhat
when progress is not being made to avoid a premature OOM and I wanted to
preserve that charactersistic. Right now, this is the least harmful way
of doing it.

As more memcg, I removed the NOTHROTTLE because the primary reason why a
memcg might fail to make progress is excessive writeback and that should
still throttle. Completely failing to make progress in a memcg is most
likely due to a memcg-OOM.

> For direct reclaimers under global pressure, why is page allocator a bad
> place for stalling on no progress reclaim? IMHO the callers of the
> reclaim should decide what to do if reclaim is not making progress.

Because it's a layering violation and the caller has little direct control
over the reclaim retry logic. The page allocator has no visibility on
why reclaim failed only that it did fail.

-- 
Mel Gorman
SUSE Labs
