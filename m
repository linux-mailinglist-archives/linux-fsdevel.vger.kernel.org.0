Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B554694F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 12:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbhLFL3S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 06:29:18 -0500
Received: from outbound-smtp03.blacknight.com ([81.17.249.16]:35933 "EHLO
        outbound-smtp03.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241793AbhLFL3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:29:17 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id DAA13C0F5A
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Dec 2021 11:25:47 +0000 (GMT)
Received: (qmail 7725 invoked from network); 6 Dec 2021 11:25:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Dec 2021 11:25:47 -0000
Date:   Mon, 6 Dec 2021 11:25:45 +0000
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
Message-ID: <20211206112545.GF3366@techsingularity.net>
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <CALvZod6am_QrZCSf_de6eyzbOtKnWuL1CQZVn+srQVt20cnpFg@mail.gmail.com>
 <20211202165220.GZ3366@techsingularity.net>
 <CALvZod5tiDgEz4JwxMHQvkzLxYeV0OtNGGsX5ZdT5mTQdUdUUA@mail.gmail.com>
 <20211203090137.GA3366@techsingularity.net>
 <CALvZod46SFiNvUSLCJWEVccsXKx=NwT4=gk9wS6Nt8cZd0WOgg@mail.gmail.com>
 <20211203190807.GE3366@techsingularity.net>
 <CALvZod5BmFVdosG=e2NcEzeuzv0W9WifSBmeD48xnn1k+SNRKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CALvZod5BmFVdosG=e2NcEzeuzv0W9WifSBmeD48xnn1k+SNRKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 05, 2021 at 10:06:27PM -0800, Shakeel Butt wrote:
> On Fri, Dec 3, 2021 at 11:08 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> [...]
> > > I am in agreement with the motivation of the whole series. I am just
> > > making sure that the motivation of VMSCAN_THROTTLE_NOPROGRESS based
> > > throttle is more than just the congestion_wait of
> > > mem_cgroup_force_empty_write.
> > >
> >
> > The commit that primarily targets congestion_wait is 8cd7c588decf
> > ("mm/vmscan: throttle reclaim until some writeback completes if
> > congested"). The series recognises that there are other reasons why
> > reclaim can fail to make progress that is not directly writeback related.
> >
> 
> I agree with throttling for VMSCAN_THROTTLE_[WRITEBACK|ISOLATED]
> reasons. Please explain why we should throttle for
> VMSCAN_THROTTLE_NOPROGRESS? Also 69392a403f49 claims "Direct reclaim
> primarily is throttled in the page allocator if it is failing to make
> progress.", can you please explain how?

It could happen if the pages on the LRU are being reactivated continually
or holding an elevated reference count for some reason (e.g. gup,
page migration etc). The event is probably transient, hence the short
throttling.

-- 
Mel Gorman
SUSE Labs
