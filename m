Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09E413BAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbhIUUr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 16:47:57 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33520 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234465AbhIUUr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:47:57 -0400
Received: from dread.disaster.area (pa49-195-238-16.pa.nsw.optusnet.com.au [49.195.238.16])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 9EE88FAB5D4;
        Wed, 22 Sep 2021 06:46:22 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mSmej-00FAQB-3k; Wed, 22 Sep 2021 06:46:21 +1000
Date:   Wed, 22 Sep 2021 06:46:21 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Remove dependency on congestion_wait in mm/
Message-ID: <20210921204621.GY2361455@dread.disaster.area>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920085436.20939-1-mgorman@techsingularity.net>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=DzKKRZjfViQTE5W6EVc0VA==:117 a=DzKKRZjfViQTE5W6EVc0VA==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=Eazbco4TDQp801Hdg9MA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 09:54:31AM +0100, Mel Gorman wrote:
> Cc list similar to "congestion_wait() and GFP_NOFAIL" as they're loosely
> related.
> 
> This is a prototype series that removes all calls to congestion_wait
> in mm/ and deletes wait_iff_congested. It's not a clever
> implementation but congestion_wait has been broken for a long time
> (https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
> Even if it worked, it was never a great idea. While excessive
> dirty/writeback pages at the tail of the LRU is one possibility that
> reclaim may be slow, there is also the problem of too many pages being
> isolated and reclaim failing for other reasons (elevated references,
> too many pages isolated, excessive LRU contention etc).
> 
> This series replaces the reclaim conditions with event driven ones
> 
> o If there are too many dirty/writeback pages, sleep until a timeout
>   or enough pages get cleaned
> o If too many pages are isolated, sleep until enough isolated pages
>   are either reclaimed or put back on the LRU
> o If no progress is being made, let direct reclaim tasks sleep until
>   another task makes progress
> 
> This has been lightly tested only and the testing was useless as the
> relevant code was not executed. The workload configurations I had that
> used to trigger these corner cases no longer work (yey?) and I'll need
> to implement a new synthetic workload. If someone is aware of a realistic
> workload that forces reclaim activity to the point where reclaim stalls
> then kindly share the details.

Got a git tree pointer so I can pull it into a test kernel so I can
see what impact it has on behaviour before I try to make sense of
the code?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
