Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6771521DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 22:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBDVUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 16:20:03 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59526 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbgBDVUD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:20:03 -0500
Received: from dread.disaster.area (pa49-181-161-120.pa.nsw.optusnet.com.au [49.181.161.120])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4E9EC3A2B57;
        Wed,  5 Feb 2020 08:19:55 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iz5bu-0005hq-5b; Wed, 05 Feb 2020 08:19:54 +1100
Date:   Wed, 5 Feb 2020 08:19:54 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] protect page cache from freeing inode
Message-ID: <20200204211954.GA20584@dread.disaster.area>
References: <1578499437-1664-1-git-send-email-laoar.shao@gmail.com>
 <CALOAHbAs7d7UhO6cd5_6vTm0cgcdTiwNNMSfFX4D0hdMc+CaEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAs7d7UhO6cd5_6vTm0cgcdTiwNNMSfFX4D0hdMc+CaEg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=SkgQWeG3jiSQFIjTo4+liA==:117 a=SkgQWeG3jiSQFIjTo4+liA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=Sa-qTvfxgUUOiSiq2jIA:9
        a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 22, 2020 at 09:46:57PM +0800, Yafang Shao wrote:
> On Thu, Jan 9, 2020 at 12:04 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On my server there're some running MEMCGs protected by memory.{min, low},
> > but I found the usage of these MEMCGs abruptly became very small, which
> > were far less than the protect limit. It confused me and finally I
> > found that was because of inode stealing.
> > Once an inode is freed, all its belonging page caches will be dropped as
> > well, no matter how may page caches it has. So if we intend to protect the
> > page caches in a memcg, we must protect their host (the inode) first.
> > Otherwise the memcg protection can be easily bypassed with freeing inode,
> > especially if there're big files in this memcg.
> > The inherent mismatch between memcg and inode is a trouble. One inode can
> > be shared by different MEMCGs, but it is a very rare case. If an inode is
> > shared, its belonging page caches may be charged to different MEMCGs.
> > Currently there's no perfect solution to fix this kind of issue, but the
> > inode majority-writer ownership switching can help it more or less.
> >
> > - Changes against v2:
> >     1. Seperates memcg patches from this patchset, suggested by Roman.
> >        A separate patch is alreay ACKed by Roman, please the MEMCG
> >        maintianers help take a look at it[1].
> >     2. Improves code around the usage of for_each_mem_cgroup(), suggested
> >        by Dave
> >     3. Use memcg_low_reclaim passed from scan_control, instead of
> >        introducing a new member in struct mem_cgroup.
> >     4. Some other code improvement suggested by Dave.
> >
> >
> > - Changes against v1:
> > Use the memcg passed from the shrink_control, instead of getting it from
> > inode itself, suggested by Dave. That could make the laying better.
> >
> > [1]
> > https://lore.kernel.org/linux-mm/CALOAHbBhPgh3WEuLu2B6e2vj1J8K=gGOyCKzb8tKWmDqFs-rfQ@mail.gmail.com/
> >
> > Yafang Shao (3):
> >   mm, list_lru: make memcg visible to lru walker isolation function
> >   mm, shrinker: make memcg low reclaim visible to lru walker isolation
> >     function
> >   memcg, inode: protect page cache from freeing inode
> >
> >  fs/inode.c                 | 78 ++++++++++++++++++++++++++++++++++++++++++++--
> >  include/linux/memcontrol.h | 21 +++++++++++++
> >  include/linux/shrinker.h   |  3 ++
> >  mm/list_lru.c              | 47 +++++++++++++++++-----------
> >  mm/memcontrol.c            | 15 ---------
> >  mm/vmscan.c                | 27 +++++++++-------
> >  6 files changed, 143 insertions(+), 48 deletions(-)
> >
> 
> Dave,  Johannes,
> 
> Any comments on this new version ?

Sorry, I lost track of this amongst travel and conferences mid
january. Can you update and post it again once -rc1 is out?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
