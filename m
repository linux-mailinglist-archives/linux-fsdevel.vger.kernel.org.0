Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1899645B8AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbhKXK4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 05:56:25 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:38925 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236364AbhKXK4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:56:24 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 5F42CC0FDD
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 10:53:14 +0000 (GMT)
Received: (qmail 23874 invoked from network); 24 Nov 2021 10:53:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Nov 2021 10:53:14 -0000
Date:   Wed, 24 Nov 2021 10:53:11 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mm/vmscan: Throttle reclaim when no progress is
 being made
Message-ID: <20211124105311.GF3366@techsingularity.net>
References: <20211022144651.19914-1-mgorman@techsingularity.net>
 <20211022144651.19914-4-mgorman@techsingularity.net>
 <20211124011912.GA265983@magnolia>
 <20211124103221.GD3366@techsingularity.net>
 <cbf91d44-8c8f-15b4-a093-58c04d668156@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <cbf91d44-8c8f-15b4-a093-58c04d668156@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 11:43:05AM +0100, Vlastimil Babka wrote:
> >> Any thoughts?  For now I can just hack around this by skipping
> >> reclaim_throttle if cgroup_reclaim() == true, but that's probably not
> >> the correct fix. :)
> >> 
> > 
> > No, it wouldn't be but a possibility is throttling for only 1 jiffy if
> > reclaiming within a memcg and the zone is balanced overall.
> > 
> > The interruptible part should just be the patch below. I need to poke at
> > the cgroup limit part a bit
> 
> As the throttle timeout is short anyway, will the TASK_UNINTERRUPTIBLE vs
> TASK_INTERRUPTIBLE make a difference for the (ability to kill? AFAIU
> typically this inability to kill is because of a loop that doesn't check for
> fatal_signal_pending().
> 

Yep, and the fatal_signal_pending() is lacking within reclaim in general
but I'm undecided on how much that should change in the context of reclaim
throttling but at minimum, I don't want the signal delivery to be masked
or delayed.

-- 
Mel Gorman
SUSE Labs
