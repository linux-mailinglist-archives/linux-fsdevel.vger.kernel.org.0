Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F65449E97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhKHWNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 17:13:38 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48493 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236838AbhKHWNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 17:13:37 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3779B88A346;
        Tue,  9 Nov 2021 09:10:48 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mkCql-006Vr8-Sv; Tue, 09 Nov 2021 09:10:47 +1100
Date:   Tue, 9 Nov 2021 09:10:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
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
Message-ID: <20211108221047.GE418105@dread.disaster.area>
References: <20211108211959.1750915-1-almasrymina@google.com>
 <20211108211959.1750915-2-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108211959.1750915-2-almasrymina@google.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=epq8cqlX c=1 sm=1 tr=0 ts=6189a06b
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=N7MhG7qYPJZj-3uz0y4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 08, 2021 at 01:19:55PM -0800, Mina Almasry wrote:
> Add memcg= option to shmem mount.
> 
> Users can specify this option at mount time and all data page charges
> will be charged to the memcg supplied.
.....
> +/*
> + * Returns the memcg to charge for inode pages.  If non-NULL is returned, caller
> + * must drop reference with css_put().  NULL indicates that the inode does not
> + * have a memcg to charge, so the default process based policy should be used.
> + */
> +static struct mem_cgroup *
> +mem_cgroup_mapping_get_charge_target(struct address_space *mapping)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (!mapping)
> +		return NULL;
> +
> +	rcu_read_lock();
> +	memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);

Anything doing pointer chasing to obtain static, unchanging
superblock state is poorly implemented. The s_memcg_to_charge value never
changes, so this code should associate the memcg to charge directly
on the mapping when the mapping is first initialised by the
filesystem. We already do this with things like attaching address
space ops and mapping specific gfp masks (i.e
mapping_set_gfp_mask()), so this association should be set up that
way, too (e.g. mapping_set_memcg_to_charge()).

And because this memcg pointer is static and unchanging for the entire
life of the superblock, the superblock *must* pin the memcg into
memory and that means we can elide the rcu locking altogether in the
fast path for all filesystems that don't support this functionality.
i.e. we can simply do:

	if (!mapping || !mapping->memcg_to_charge)
		return NULL;

And then only if there is a memcg to charge, we do the slow path
locking and lookup stuff...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
