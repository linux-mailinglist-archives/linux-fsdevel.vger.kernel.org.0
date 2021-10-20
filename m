Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312A443472A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 10:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJTIqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 04:46:23 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:36839 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhJTIqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:46:22 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id C342A1C3D26
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Oct 2021 09:44:06 +0100 (IST)
Received: (qmail 14541 invoked from network); 20 Oct 2021 08:44:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Oct 2021 08:44:06 -0000
Date:   Wed, 20 Oct 2021 09:44:03 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
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
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Message-ID: <20211020084403.GE3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <20211019150025.c62a0c72538d1f9fa20f1e81@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211019150025.c62a0c72538d1f9fa20f1e81@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:00:25PM -0700, Andrew Morton wrote:
> On Tue, 19 Oct 2021 10:01:00 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
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
> > in mm/ and deletes wait_iff_congested. It's not a clever
> > implementation but congestion_wait has been broken for a long time
> > (https://lore.kernel.org/linux-mm/45d8b7a6-8548-65f5-cccf-9f451d4ae3d4@kernel.dk/).
> 
> The block layer doesn't call clear_bdi_congested() at all.  I never
> knew this until recent discussions :(
> 
> So this means that congestion_wait() will always time out, yes?
> 

Unfortunately, yes except for filesystems that call
[set_clear]_bdi_congested. For the test case in the series leader,
congestion_wait always hit the full timeout.

> > Even if congestion throttling worked, it was never a great idea.
> 
> Well.  It was a good idea until things like isolation got added!
> 

Well, true to an extent although it was always true that reclaim could fail
to make progress for reasons other than pages under writeback.  But you're
right, saying it was "never a great idea" is overkill.  congestion_wait
used to work and I expect it was particularly helpful before IO-less write
throttling, accurate dirty page tracking and immediate reclaim existed.

> > While
> > excessive dirty/writeback pages at the tail of the LRU is one possibility
> > that reclaim may be slow, there is also the problem of too many pages
> > being isolated and reclaim failing for other reasons (elevated references,
> > too many pages isolated, excessive LRU contention etc).
> > 
> > This series replaces the "congestion" throttling with 3 different types.
> > 
> > o If there are too many dirty/writeback pages, sleep until a timeout
> >   or enough pages get cleaned
> > o If too many pages are isolated, sleep until enough isolated pages
> >   are either reclaimed or put back on the LRU
> > o If no progress is being made, direct reclaim tasks sleep until
> >   another task makes progress with acceptable efficiency.
> > 
> > This was initially tested with a mix of workloads that used to trigger
> > corner cases that no longer work.
> 
> Mix of workloads is nice, but a mix of devices is more important here. 

I tested as much as I could but as well as storage devices, different
memory sizes are also relevant.

> I trust some testing was done on plain old spinning disks?  And USB
> storage, please!  And NFS plays with BDI congestion.  Ceph and FUSE also.
> 

Plain old spinning disk was tested. Basic USB testing didn't show many
problems although given it was my desktop machine, it might have had too
memory as no amount of IO to the USB key triggered a problem where reclaim
failed to make progress and get throttled. There was basic NFS testing
although I didn't try running stutterp over NFS. Given the original thread
motivating this was NFS-related and they are cc'd, I'm hoping they'll
give it a realistic kick.  I don't have a realistic setup for ceph and
didn't try fuse.

> We've had complaints about this stuff forever.  Usually of the form of
> interactive tasks getting horridly stalled by writeout/swap activity.

I know and there is no guarantee it won't happen again. The main problem
I was trying to solve was that congestion-based throttling is not suitable
for mm/.

From reclaim context, there isn't a good way of detecting "interactive"
tasks. At best, under reclaim pressure we could try tracking allocation
rates and throttle heavy allocators more than light allocators but I
didn't want to introduce complexity prematurely.

-- 
Mel Gorman
SUSE Labs
