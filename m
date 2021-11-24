Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C04445CB01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 18:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhKXRaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 12:30:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58594 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKXRaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:30:21 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9B67C218D6;
        Wed, 24 Nov 2021 17:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637774830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPvlbKR4kZT2jRAX1s7R2qtncoIoU2QMFLhEg5TGPuQ=;
        b=XI21Un0ENn/nes6vC2Zp/n1uFn/pvDR0YD1PGlrzMr9tQ+1T7/eS70MnTJaDdJH5jeuFPT
        JmWPXSCrRNHo2Tos6vsHxga7hEQfBRtQ3LTyjZCiLa6QBdHdMHuUX5VrAOQrySfOi4t8Ml
        pnCdAXAhpZi+MQGTKxluwJGPTNRCGAE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4E613A3B84;
        Wed, 24 Nov 2021 17:27:10 +0000 (UTC)
Date:   Wed, 24 Nov 2021 18:27:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
Message-ID: <YZ517SgokdzY/+8r@dhcp22.suse.cz>
References: <20211120045011.3074840-1-almasrymina@google.com>
 <YZvppKvUPTIytM/c@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZvppKvUPTIytM/c@cmpxchg.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 14:04:04, Johannes Weiner wrote:
[...]
> I'm not a fan of this. It uses filesystem mounts to create shareable
> resource domains outside of the cgroup hierarchy, which has all the
> downsides you listed, and more:
> 
> 1. You need a filesystem interface in the first place, and a new
>    ad-hoc channel and permission model to coordinate with the cgroup
>    tree, which isn't great. All filesystems you want to share data on
>    need to be converted.
> 
> 2. It doesn't extend to non-filesystem sources of shared data, such as
>    memfds, ipc shm etc.
> 
> 3. It requires unintuitive configuration for what should be basic
>    shared accounting semantics. Per default you still get the old
>    'first touch' semantics, but to get sharing you need to reconfigure
>    the filesystems?
> 
> 4. If a task needs to work with a hierarchy of data sharing domains -
>    system-wide, group of jobs, job - it must interact with a hierarchy
>    of filesystem mounts. This is a pain to setup and may require task
>    awareness. Moving data around, working with different mount points.
>    Also, no shared and private data accounting within the same file.
> 
> 5. It reintroduces cgroup1 semantics of tasks and resouces, which are
>    entangled, sitting in disjunct domains. OOM killing is one quirk of
>    that, but there are others you haven't touched on. Who is charged
>    for the CPU cycles of reclaim in the out-of-band domain?  Who is
>    charged for the paging IO? How is resource pressure accounted and
>    attributed? Soon you need cpu= and io= as well.
> 
> My take on this is that it might work for your rather specific
> usecase, but it doesn't strike me as a general-purpose feature
> suitable for upstream.

I just want to reiterate that this resonates with my concerns expressed
earlier and thanks for expressing them in a much better structured and
comprehensive way, Johannes.

[btw. a non-technical comment. For features like this it is better to
 not rush into newer versions posting until there is at least some
 agreement for the feature. Otherwise we have fragments of the
 discussion spread over several email threads]

> If we want sharing semantics for memory, I think we need a more
> generic implementation with a cleaner interface.
> 
> Here is one idea:
> 
> Have you considered reparenting pages that are accessed by multiple
> cgroups to the first common ancestor of those groups?
> 
> Essentially, whenever there is a memory access (minor fault, buffered
> IO) to a page that doesn't belong to the accessing task's cgroup, you
> find the common ancestor between that task and the owning cgroup, and
> move the page there.
> 
> With a tree like this:
> 
> 	root - job group - job
>                         `- job
>             `- job group - job
>                         `- job
> 
> all pages accessed inside that tree will propagate to the highest
> level at which they are shared - which is the same level where you'd
> also set shared policies, like a job group memory limit or io weight.
> 
> E.g. libc pages would (likely) bubble to the root, persistent tmpfs
> pages would bubble to the respective job group, private data would
> stay within each job.
> 
> No further user configuration necessary. Although you still *can* use
> mount namespacing etc. to prohibit undesired sharing between cgroups.
> 
> The actual user-visible accounting change would be quite small, and
> arguably much more intuitive. Remember that accounting is recursive,
> meaning that a job page today also shows up in the counters of job
> group and root. This would not change. The only thing that IS weird
> today is that when two jobs share a page, it will arbitrarily show up
> in one job's counter but not in the other's. That would change: it
> would no longer show up as either, since it's not private to either;
> it would just be a job group (and up) page.
> 
> This would be a generic implementation of resource sharing semantics:
> independent of data source and filesystems, contained inside the
> cgroup interface, and reusing the existing hierarchies of accounting
> and control domains to also represent levels of common property.
> 
> Thoughts?

This is an interesting concept. I am not sure how expensive and
intrusive (code wise) this would get but that is more of an
implementation detail.

Another option would be to provide a syscall to claim a shared resource.
This would require a cooperation of the application but it would
establish a clear responsibility model.

-- 
Michal Hocko
SUSE Labs
