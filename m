Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7768B45AD30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 21:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbhKWUYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 15:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbhKWUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:24:24 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5770C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 12:21:15 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id t83so393937qke.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Nov 2021 12:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sv8dZOgkLz4pzZcirFR8OEduIrUn10MfD2A65S0FiyI=;
        b=KKDwkzPfFtQufPKypaOMvjY0ke+j4fkXx5gw7BJL19xhnlyjpaQim8uCPBVM2Q1hAb
         ZGELoJrVysc1/ZmthijxUpu0kdIyNe8LfhK/q4RsE+bKDgWChPDYzfT86X+vqcvgMRIs
         xXZFKIWJmdiMUMtXp7LOiBl+6PSPlRpN2LCC+aV4EQvlWfIAc/7pKTtuCnWrmVEpScxd
         jcd7UCM3VkNbgI42926mvMoSjGOVRtkoZEzB/iitAvsEd4wOAPSP7L0DKP4ZM2uDm2Ut
         fjkQ3Nz3qQAI64NbajpPn0nJV0rmEQ0nGvlxpKwgqitu1ux9BkGN4NI2cz9esg65ipOm
         ld8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sv8dZOgkLz4pzZcirFR8OEduIrUn10MfD2A65S0FiyI=;
        b=7Ukm1pi8efR/A/DmAtuTWVwsHXiTdoV99IMOQ4dUATCOECGak64zzoqDSKm5rj0cpq
         aip6xbENEnE4QySRh+okgHt3LetGeJ4BJ6xCmFy8AUcAKWSEiznIIS977a7c/lXSZ494
         CbBh+vMSP6vxCjAbegIEVrGJsjCn/T4USXvlApKlKfYWhzY+Ir6Ay0AhGhtglPmDB0wH
         apfLqVtCyFeb0jkWj/+yXsPsfl+Pj22earcMuj7Le2dGRdq74gVR49FlQ5kV46s0cDzW
         5de+K2wkZKBOT9hbuKySneiNmXY6YUH9t66dwmIz5MtLxywTyRZDVSqW07X+JpqUcG0j
         xG1g==
X-Gm-Message-State: AOAM533HM+pXUlQaInaZaWbgVBnm6z8Szdq9kecpKq/VLAI1IDX/Ffea
        okR9r9BIkfywd0CCa8HNdvYDsg==
X-Google-Smtp-Source: ABdhPJz3bN7DStJiaIhvGWzBXaKWfUJjhgYvgHjR/bheZkW33pOjLCkK5ZoWaJI5YwwmYPCEYtAjDg==
X-Received: by 2002:a05:620a:4712:: with SMTP id bs18mr157664qkb.246.1637698874876;
        Tue, 23 Nov 2021 12:21:14 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id g19sm6812301qtg.82.2021.11.23.12.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 12:21:14 -0800 (PST)
Date:   Tue, 23 Nov 2021 15:21:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
Message-ID: <YZ1NObN6HkxLwLmb@cmpxchg.org>
References: <20211120045011.3074840-1-almasrymina@google.com>
 <YZvppKvUPTIytM/c@cmpxchg.org>
 <YZwjJjccnlL1SDSN@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZwjJjccnlL1SDSN@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 03:09:26PM -0800, Roman Gushchin wrote:
> On Mon, Nov 22, 2021 at 02:04:04PM -0500, Johannes Weiner wrote:
> > On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
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
> > > ‘memcg=/path/to/memcg’ mount option for filesystems:
> > > directing all the memory of the file system to be ‘remote charged’ to
> > > cgroup provided by that memcg= option.
> > > 
> > > Caveats:
> > > 
> > > 1. One complication to address is the behavior when the target memcg
> > > hits its memory.max limit because of remote charging. In this case the
> > > oom-killer will be invoked, but the oom-killer may not find anything
> > > to kill in the target memcg being charged. Thera are a number of considerations
> > > in this case:
> > > 
> > > 1. It's not great to kill the allocating process since the allocating process
> > >    is not running in the memcg under oom, and killing it will not free memory
> > >    in the memcg under oom.
> > > 2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
> > >    somehow. If not, the process will forever loop the pagefault in the upstream
> > >    kernel.
> > > 
> > > In this case, I propose simply failing the remote charge and returning an ENOSPC
> > > to the caller. This will cause will cause the process executing the remote
> > > charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pagefault
> > > path.  This will be documented behavior of remote charging, and this feature is
> > > opt-in. Users can:
> > > - Not opt-into the feature if they want.
> > > - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
> > >   abort if they desire.
> > > - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue their
> > >   operation without executing the remote charge if possible.
> > > 
> > > 2. Only processes allowed the enter cgroup at mount time can mount a
> > > tmpfs with memcg=<cgroup>. This is to prevent intential DoS of random cgroups
> > > on the machine. However, once a filesysetem is mounted with memcg=<cgroup>, any
> > > process with write access to this mount point will be able to charge memory to
> > > <cgroup>. This is largely a non-issue because in configurations where there is
> > > untrusted code running on the machine, mount point access needs to be
> > > restricted to the intended users only regardless of whether the mount point
> > > memory is deterministly charged or not.
> > 
> > I'm not a fan of this. It uses filesystem mounts to create shareable
> > resource domains outside of the cgroup hierarchy, which has all the
> > downsides you listed, and more:
> > 
> > 1. You need a filesystem interface in the first place, and a new
> >    ad-hoc channel and permission model to coordinate with the cgroup
> >    tree, which isn't great. All filesystems you want to share data on
> >    need to be converted.
> > 
> > 2. It doesn't extend to non-filesystem sources of shared data, such as
> >    memfds, ipc shm etc.
> > 
> > 3. It requires unintuitive configuration for what should be basic
> >    shared accounting semantics. Per default you still get the old
> >    'first touch' semantics, but to get sharing you need to reconfigure
> >    the filesystems?
> > 
> > 4. If a task needs to work with a hierarchy of data sharing domains -
> >    system-wide, group of jobs, job - it must interact with a hierarchy
> >    of filesystem mounts. This is a pain to setup and may require task
> >    awareness. Moving data around, working with different mount points.
> >    Also, no shared and private data accounting within the same file.
> > 
> > 5. It reintroduces cgroup1 semantics of tasks and resouces, which are
> >    entangled, sitting in disjunct domains. OOM killing is one quirk of
> >    that, but there are others you haven't touched on. Who is charged
> >    for the CPU cycles of reclaim in the out-of-band domain?  Who is
> >    charged for the paging IO? How is resource pressure accounted and
> >    attributed? Soon you need cpu= and io= as well.
> > 
> > My take on this is that it might work for your rather specific
> > usecase, but it doesn't strike me as a general-purpose feature
> > suitable for upstream.
> > 
> > 
> > If we want sharing semantics for memory, I think we need a more
> > generic implementation with a cleaner interface.
> > 
> > Here is one idea:
> > 
> > Have you considered reparenting pages that are accessed by multiple
> > cgroups to the first common ancestor of those groups?
> > 
> > Essentially, whenever there is a memory access (minor fault, buffered
> > IO) to a page that doesn't belong to the accessing task's cgroup, you
> > find the common ancestor between that task and the owning cgroup, and
> > move the page there.
> > 
> > With a tree like this:
> > 
> > 	root - job group - job
> >                         `- job
> >             `- job group - job
> >                         `- job
> > 
> > all pages accessed inside that tree will propagate to the highest
> > level at which they are shared - which is the same level where you'd
> > also set shared policies, like a job group memory limit or io weight.
> > 
> > E.g. libc pages would (likely) bubble to the root, persistent tmpfs
> > pages would bubble to the respective job group, private data would
> > stay within each job.
> > 
> > No further user configuration necessary. Although you still *can* use
> > mount namespacing etc. to prohibit undesired sharing between cgroups.
> > 
> > The actual user-visible accounting change would be quite small, and
> > arguably much more intuitive. Remember that accounting is recursive,
> > meaning that a job page today also shows up in the counters of job
> > group and root. This would not change. The only thing that IS weird
> > today is that when two jobs share a page, it will arbitrarily show up
> > in one job's counter but not in the other's. That would change: it
> > would no longer show up as either, since it's not private to either;
> > it would just be a job group (and up) page.

These are great questions.

> In general I like the idea, but I think the user-visible change will be quite
> large, almost "cgroup v3"-large.

I wouldn't quite say cgroup3 :-) But it would definitely require a new
mount option for cgroupfs.

> Here are some problems:
> 1) Anything shared between e.g. system.slice and user.slice now belongs
>    to the root cgroup and is completely unaccounted/unlimited. E.g. all pagecache
>    belonging to shared libraries.

Correct, but arguably that's a good thing:

Right now, even though the libraries are used by both, they'll be held
by one group. This can cause two priority inversions: hipri references
don't prevent the shared page from thrashing inside a lowpri group,
which could subject the hipri group to reclaim pressure and waiting
for slow refaults of the lowpri groups; if the lowpri group is the
hotter user of this page, this could sustain. Or the page ends up in
the hipri group, and the lowpri group pins it there even when the
hipri group is done with it, thus stealing its capacity.

Yes, a libc page used by everybody in the system would end up in the
root cgroup. But arguably that makes much more sense than having it
show up as exclusive memory of system.slice/systemd-udevd.service.
And certainly we don't want a universally shared page be subjected to
the local resource pressure of one lowpri user of it.

Recognizing the shared property and propagating it to the common
domain - the level at which priorities are equal between them - would
make the accounting clearer and solve both these inversions.

> 2) It's concerning in security terms. If I understand the idea correctly, a
>    read-only access will allow to move charges to an upper level, potentially
>    crossing memory.max limits. It doesn't sound safe.

Hm. The mechanism is slightly different, but escaping memory.max
happens today as well: shared memory is already not subject to the
memory.max of (n-1)/n cgroups that touch it.

So before, you can escape containment to whatever other cgroup is
using the page. After, you can escape to the common domain. It's
difficult for me to say one is clearly worse than the other. You can
conceive of realistic scenarios where both are equally problematic.

Practically, they appear to require the same solution: if the
environment isn't to be trusted, namespacing and limiting access to
shared data is necessary to avoid cgroups escaping containment or
DoSing other groups.

> 3) It brings a non-trivial amount of memory to non-leave cgroups. To some extent
>    it returns us to the cgroup v1 world and a question of competition between
>    resources consumed by a cgroup directly and through children cgroups. Not
>    like the problem doesn't exist now, but it's less pronounced.
>    If say >50% of system.slice's memory will belong to system.slice directly,
>    then we likely will need separate non-recursive counters, limits, protections,
>    etc.

I actually do see numbers like this in practice. Temporary
system.slice units allocate cache, then their cgroups get deleted and
the cache is reused by the next instances. Quite often, system.slice
has much more memory than its subgroups combined.

So in a way, we have what I'm proposing if the sharing happens with
dead cgroups. Sharing with live cgroups wouldn't necessarily create a
bigger demand for new counters than what we have now.

I think the cgroup1 issue was slightly different: in cgroup1 we
allowed *tasks* to live in non-leaf groups, and so users wanted to
control the *private* memory of said tasks with policies that were
*different* from the shared policies applied to the leaves.

This wouldn't be the same here. Tasks are still only inside leafs, and
there is no "private" memory inside a non-leaf group. It's shared
among the children, and so subject to policies shared by all children.

> 4) Imagine a production server and a system administrator entering using ssh
>    (and being put into user.slice) and running a big grep... It screws up all
>    memory accounting until a next reboot. Not a completely impossible scenario.

This can also happen with the first-touch model, though. The second
you touch private data of some workload, the memory might escape it.

It's not as pronounced with a first-touch policy - although proactive
reclaim makes this worse. But I'm not sure you can call it a new
concern in the proposed model: you already have to be careful with the
data you touch and bring into memory from your current cgroup.

Again, I think this is where mount namespaces come in. You're not
necessarily supposed to see private data of workloads from the outside
and access it accidentally. It's common practice to ssh directly into
containers to muck with them and their memory, at which point you'll
be in the appropriate cgroup and permission context, too.

However, I do agree with Mina and you: this is a significant change in
behavior, and a cgroupfs mount option would certainly be warranted.
