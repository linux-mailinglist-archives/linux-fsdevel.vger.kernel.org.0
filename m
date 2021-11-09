Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0716E44A36A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 02:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243170AbhKIB0z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 20:26:55 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:45754 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242039AbhKIBV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:21:29 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 36ED110498F2;
        Tue,  9 Nov 2021 12:18:39 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mkFmX-006Yyg-Kx; Tue, 09 Nov 2021 12:18:37 +1100
Date:   Tue, 9 Nov 2021 12:18:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Roman Gushchin <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v1 1/5] mm/shmem: support deterministic charging of tmpfs
Message-ID: <20211109011837.GF418105@dread.disaster.area>
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com>
 <20211108221047.GE418105@dread.disaster.area>
 <YYm1v25dLZL99qKK@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYm1v25dLZL99qKK@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=6189cc72
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=Om1FtI2GXO6ST26aLOMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 11:41:51PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 09, 2021 at 09:10:47AM +1100, Dave Chinner wrote:
> > > +	rcu_read_lock();
> > > +	memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
> > 
> > Anything doing pointer chasing to obtain static, unchanging
> > superblock state is poorly implemented. The s_memcg_to_charge value never
> > changes, so this code should associate the memcg to charge directly
> > on the mapping when the mapping is first initialised by the
> > filesystem. We already do this with things like attaching address
> > space ops and mapping specific gfp masks (i.e
> > mapping_set_gfp_mask()), so this association should be set up that
> > way, too (e.g. mapping_set_memcg_to_charge()).
> 
> I'm not a fan of enlarging struct address_space with another pointer
> unless it's going to be used by all/most filesystems.  If this is
> destined to be a shmem-only feature, then it should be in the
> shmem_inode instead of the mapping.

Neither am I, but I'm also not a fan of the filemap code still
having to drill through the mapping to the host inode just to check
if it needs to do special stuff for shmem inodes on every call that
adds a page to the page cache. This is just as messy and intrusive
and the memcg code really has no business digging about in the
filesystem specific details of the inode behind the mapping.

Hmmm. The mem_cgroup_charge() call in filemap_add_folio() passes a
null mm context, so deep in the guts it ends getting the memcg from
active_memcg() in get_mem_cgroup_from_mm(). That ends up using
current->active_memcg, so maybe a better approach here is to have
shmem override current->active_memcg via set_active_memcg() before
it enters the generic fs paths and restore it on return...

current_fsmemcg()?

> If we are to have this for all filesystems, then let's do that properly
> and make it generic functionality from its introduction.

Fully agree.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
