Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2B4347A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhJTJLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 05:11:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhJTJLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:11:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43A7F21A99;
        Wed, 20 Oct 2021 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634720948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzT2qLfgG2YscoUI3YxI8UvAi7PcCu5x/9bxVFCIq4Y=;
        b=L/b71nckSReAW33br6iQV/D3eWZe+zZam/HeZAB7HEH8mEr2zRLZfzDAuYI9dj8FUIdC+6
        aCbzJCsDVpxsWew0OwDp6xm39XRNiV/0G5jaGz5tmxst4ijN2YgQnP1iwWu8RZODJXz4RG
        JYpB2Ud9leVEYpiCFrpqNdOTT0LNwGY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9611FA3C38;
        Wed, 20 Oct 2021 09:09:07 +0000 (UTC)
Date:   Wed, 20 Oct 2021 11:09:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Roman Gushchin <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, cgroups@vger.kernel.org,
        riel@surriel.com
Subject: Re: [RFC Proposal] Deterministic memcg charging for shared memory
Message-ID: <YW/cs51K/GyhhJDk@dhcp22.suse.cz>
References: <CAHS8izMpzTvd5=x_xMhDJy1toV-eT3AS=GXM2ObkJoCmbDtz6w@mail.gmail.com>
 <YW13pS716ajeSgXj@dhcp22.suse.cz>
 <CAHS8izMnkiHtNLEzJXL64zNinbEp0oU96dPCJYfqJqk4AEQW2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMnkiHtNLEzJXL64zNinbEp0oU96dPCJYfqJqk4AEQW2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 07:31:58, Mina Almasry wrote:
> On Mon, Oct 18, 2021 at 6:33 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 13-10-21 12:23:19, Mina Almasry wrote:
> > > Below is a proposal for deterministic charging of shared memory.
> > > Please take a look and let me know if there are any major concerns:
> > >
> > > Problem:
> > > Currently shared memory is charged to the memcg of the allocating
> > > process. This makes memory usage of processes accessing shared memory
> > > a bit unpredictable since whichever process accesses the memory first
> > > will get charged. We have a number of use cases where our userspace
> > > would like deterministic charging of shared memory:
> > >
> > > 1. System services allocating memory for client jobs:
> > > We have services (namely a network access service[1]) that provide
> > > functionality for clients running on the machine and allocate memory
> > > to carry out these services. The memory usage of these services
> > > depends on the number of jobs running on the machine and the nature of
> > > the requests made to the service, which makes the memory usage of
> > > these services hard to predict and thus hard to limit via memory.max.
> > > These system services would like a way to allocate memory and instruct
> > > the kernel to charge this memory to the client’s memcg.
> > >
> > > 2. Shared filesystem between subtasks of a large job
> > > Our infrastructure has large meta jobs such as kubernetes which spawn
> > > multiple subtasks which share a tmpfs mount. These jobs and its
> > > subtasks use that tmpfs mount for various purposes such as data
> > > sharing or persistent data between the subtask restarts. In kubernetes
> > > terminology, the meta job is similar to pods and subtasks are
> > > containers under pods. We want the shared memory to be
> > > deterministically charged to the kubernetes's pod and independent to
> > > the lifetime of containers under the pod.
> > >
> > > 3. Shared libraries and language runtimes shared between independent jobs.
> > > We’d like to optimize memory usage on the machine by sharing libraries
> > > and language runtimes of many of the processes running on our machines
> > > in separate memcgs. This produces a side effect that one job may be
> > > unlucky to be the first to access many of the libraries and may get
> > > oom killed as all the cached files get charged to it.
> > >
> > > Design:
> > > My rough proposal to solve this problem is to simply add a
> > > ‘memcg=/path/to/memcg’ mount option for filesystems (namely tmpfs):
> > > directing all the memory of the file system to be ‘remote charged’ to
> > > cgroup provided by that memcg= option.
> >
> > Could you be more specific about how this matches the above mentioned
> > usecases?
> >
> 
> For the use cases I've listed respectively:
> 1. Our network service would mount a tmpfs with 'memcg=<path to
> client's memcg>'. Any memory the service is allocating on behalf of
> the client, the service will allocate inside of this tmpfs mount, thus
> charging it to the client's memcg without risk of hitting the
> service's limit.
> 2. The large job (kubernetes pod) would mount a tmpfs with
> 'memcg=<path to large job's memcg>. It will then share this tmpfs
> mount with the subtasks (containers in the pod). The subtasks can then
> allocate memory in the tmpfs, having it charged to the kubernetes job,
> without risk of hitting the container's limit.

There is still a risk that the limit is hit for the memcg of shmem
owner, right? What happens then? Isn't any of the shmem consumer a
DoS attack vector for everybody else consuming from that same target
memcg? In other words aren't all of them in the same memory resource
domain effectively? If we allow target memcg to live outside of that
resource domain then this opens interesting questions about resource
control in general, no? Something the unified hierarchy was aiming to
fix wrt cgroup v1.

You are saying that it is hard to properly set limits for
respective services but this would simply allow to hide a part of the
consumption somewhere else. Aren't you just shifting the problem
elsewhere? How do configure the target memcg?

Do you have any numbers about the consumption variation and how big of a
problem that is in practice?

> 3. We would need to extend this functionality to other file systems of
> persistent disk, then mount that file system with 'memcg=<dedicated
> shared library memcg>'. Jobs can then use the shared library and any
> memory allocated due to loading the shared library is charged to a
> dedicated memcg, and not charged to the job using the shared library.

This is more of a question for fs people. My understanding is rather
limited so I cannot even imagine all the possible setups but just from
a very high level understanding bind mounts can get really interesting.
Can those disagree on the memcg? 

I am pretty sure I didn't get to think through this very deeply, my gut
feeling tells me that this will open many interesting questions and I am
not sure whether it solves more problems than it introduces at this moment.
I would be really curious what others think about this.
-- 
Michal Hocko
SUSE Labs
