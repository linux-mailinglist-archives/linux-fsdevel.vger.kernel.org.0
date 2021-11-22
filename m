Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19310459726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 23:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbhKVWNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 17:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbhKVWND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 17:13:03 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FD1C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 14:09:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z26so25327612iod.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 14:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RIlD62miMbzZn12/Kgwlc/RowOKN6DZhvcu78eFq1AU=;
        b=JLTGLRuyYCB7VkcDH95/Fc5RG/CY9iUl/N+535ZnzSm04bQoNpo+ubyYYlyCFbrHA2
         Q+thhFZGpgFSkPizJvk3Na+BMuZ3bpi8X/3sHGh6t8J5ELfZbQ4QEgAXJm0WrJKA0asa
         BYIElsb/0gyT0Kzo1HVBlq1MWO0y/pa1x5XRJg9Z54BG/2Eg3lMYcYW4BZPDfzj6EeMH
         utJf2yIQqz6/Sgz1ze2XLaPXbWLym9pAyGXNM2zb50qDgrLQDkEPd414g/HPN2gebps8
         9yeT4FVo/Mz7Zyxk7+FukSsmkl492NEVLeeUEnVwgTLE8GrIdFHFDTAtCv7vzoC1dLQB
         0xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RIlD62miMbzZn12/Kgwlc/RowOKN6DZhvcu78eFq1AU=;
        b=Be9h6hzQbOPTw/uzH9MJdQBVaejw3gkxdCZdB+KRECEWTH2EC4RsECE5jQzyezl72z
         vC/0vyT2vaTUiAPaCy+h0NruY99tycMl+F4Y1Lcc/nPGTx5sybG4lasyYIQbMrECkXyQ
         Wn42Hu8cVjPMpHCm1tdaUg5loXYZ4uKKoU95on2voajSn40RIEna7+KNrTtGkvSFI9y7
         g299lii1+GtIrLhGb4lNb6Qan1H4ZtH/kf/EBM1VtCiHRzZ55BHo2goURwZkOENhlxDk
         oSdjT161hHp+EVyPQa6aUfRJsbMu0pfNvGwOwE6e4HLtx/IULlBtyu0Swd/RN2oQXQxJ
         1rbQ==
X-Gm-Message-State: AOAM533Ipe2gYXDIUMAh5NCm1Q3FY4PZQ98/0T3Lyle6DhpaYvVvd/rT
        MAnIRNuPN/w4denylt/LFhq6QHliMwJt8hafqTlzpA==
X-Google-Smtp-Source: ABdhPJyUBmOn2KEY0n/5ZM4uzN4oybki5Fth5xLP/XHvE1gpnMnZGUhC94nrBsDioqr4LuBx36oxyAjrmGKwQyiM3og=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr131226ioc.91.1637618995703;
 Mon, 22 Nov 2021 14:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com> <YZvppKvUPTIytM/c@cmpxchg.org>
In-Reply-To: <YZvppKvUPTIytM/c@cmpxchg.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 22 Nov 2021 14:09:43 -0800
Message-ID: <CAHS8izM7xH8qoTTu3Fgq84xydxuK_3LKhX26-i72fHPhz95iNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:04 AM Johannes Weiner <hannes@cmpxchg.org> wrote=
:
>
> On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> > Problem:
> > Currently shared memory is charged to the memcg of the allocating
> > process. This makes memory usage of processes accessing shared memory
> > a bit unpredictable since whichever process accesses the memory first
> > will get charged. We have a number of use cases where our userspace
> > would like deterministic charging of shared memory:
> >
> > 1. System services allocating memory for client jobs:
> > We have services (namely a network access service[1]) that provide
> > functionality for clients running on the machine and allocate memory
> > to carry out these services. The memory usage of these services
> > depends on the number of jobs running on the machine and the nature of
> > the requests made to the service, which makes the memory usage of
> > these services hard to predict and thus hard to limit via memory.max.
> > These system services would like a way to allocate memory and instruct
> > the kernel to charge this memory to the client=E2=80=99s memcg.
> >
> > 2. Shared filesystem between subtasks of a large job
> > Our infrastructure has large meta jobs such as kubernetes which spawn
> > multiple subtasks which share a tmpfs mount. These jobs and its
> > subtasks use that tmpfs mount for various purposes such as data
> > sharing or persistent data between the subtask restarts. In kubernetes
> > terminology, the meta job is similar to pods and subtasks are
> > containers under pods. We want the shared memory to be
> > deterministically charged to the kubernetes's pod and independent to
> > the lifetime of containers under the pod.
> >
> > 3. Shared libraries and language runtimes shared between independent jo=
bs.
> > We=E2=80=99d like to optimize memory usage on the machine by sharing li=
braries
> > and language runtimes of many of the processes running on our machines
> > in separate memcgs. This produces a side effect that one job may be
> > unlucky to be the first to access many of the libraries and may get
> > oom killed as all the cached files get charged to it.
> >
> > Design:
> > My rough proposal to solve this problem is to simply add a
> > =E2=80=98memcg=3D/path/to/memcg=E2=80=99 mount option for filesystems:
> > directing all the memory of the file system to be =E2=80=98remote charg=
ed=E2=80=99 to
> > cgroup provided by that memcg=3D option.
> >
> > Caveats:
> >
> > 1. One complication to address is the behavior when the target memcg
> > hits its memory.max limit because of remote charging. In this case the
> > oom-killer will be invoked, but the oom-killer may not find anything
> > to kill in the target memcg being charged. Thera are a number of consid=
erations
> > in this case:
> >
> > 1. It's not great to kill the allocating process since the allocating p=
rocess
> >    is not running in the memcg under oom, and killing it will not free =
memory
> >    in the memcg under oom.
> > 2. Pagefaults may hit the memcg limit, and we need to handle the pagefa=
ult
> >    somehow. If not, the process will forever loop the pagefault in the =
upstream
> >    kernel.
> >
> > In this case, I propose simply failing the remote charge and returning =
an ENOSPC
> > to the caller. This will cause will cause the process executing the rem=
ote
> > charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the=
 pagefault
> > path.  This will be documented behavior of remote charging, and this fe=
ature is
> > opt-in. Users can:
> > - Not opt-into the feature if they want.
> > - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS=
 and
> >   abort if they desire.
> > - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue =
their
> >   operation without executing the remote charge if possible.
> >
> > 2. Only processes allowed the enter cgroup at mount time can mount a
> > tmpfs with memcg=3D<cgroup>. This is to prevent intential DoS of random=
 cgroups
> > on the machine. However, once a filesysetem is mounted with memcg=3D<cg=
roup>, any
> > process with write access to this mount point will be able to charge me=
mory to
> > <cgroup>. This is largely a non-issue because in configurations where t=
here is
> > untrusted code running on the machine, mount point access needs to be
> > restricted to the intended users only regardless of whether the mount p=
oint
> > memory is deterministly charged or not.
>
> I'm not a fan of this. It uses filesystem mounts to create shareable
> resource domains outside of the cgroup hierarchy, which has all the
> downsides you listed, and more:
>
> 1. You need a filesystem interface in the first place, and a new
>    ad-hoc channel and permission model to coordinate with the cgroup
>    tree, which isn't great. All filesystems you want to share data on
>    need to be converted.
>

My understanding is that this problem exists today with tmpfs-shared
memory, regardless of memcg=3D support or not. I.e. for processes to
share memory via tmpfs the sys admin needs to limit access to the
mount point to the processes regardless of which cgroup[s] the
processes are in for the machine to be properly configured, or risk
unintended data access and a security violation. So existing tmpfs
shared memory would/should already have these permissions in place,
and (I'm hoping) we can piggy back or that and provide deterministic
charging.

> 2. It doesn't extend to non-filesystem sources of shared data, such as
>    memfds, ipc shm etc.
>

I was hoping - if possible - to extend similar APIs/semantics to other
shared memory sources, although to be honest I'll concede I haven't
thoroughly thought of how the implementation would look like.

> 3. It requires unintuitive configuration for what should be basic
>    shared accounting semantics. Per default you still get the old
>    'first touch' semantics, but to get sharing you need to reconfigure
>    the filesystems?
>

Yes, this is indeed an explicit option that needs to be configured by
the sys admin. I'm not so sure about changing the default in the
kernel and potentially breaking existing accounting like you mention
below. I think the kernel also automagically trying to figure out the
proper memcg to deterministically charge has its own issues (comments
on the proposal below).

> 4. If a task needs to work with a hierarchy of data sharing domains -
>    system-wide, group of jobs, job - it must interact with a hierarchy
>    of filesystem mounts. This is a pain to setup and may require task
>    awareness. Moving data around, working with different mount points.
>    Also, no shared and private data accounting within the same file.
>

Again, my impression/feeling here is that this is a generic problem
with tmpfs shared memory, and maybe shared memory in general, which
folks find very useful already despite the existing shortcomings.
Today AFAIK we don't have interfaces to say 'this is shared memory and
it's shared between processes in cgroups A, B, and C'. Instead we say
this is shared memory and the tmpfs access permissions or visibility
decree who can access the shared memory (and the permissions are
oblivious to cgroups) and the memory charging is first touch based and
not deterministic.

> 5. It reintroduces cgroup1 semantics of tasks and resouces, which are
>    entangled, sitting in disjunct domains. OOM killing is one quirk of
>    that, but there are others you haven't touched on. Who is charged
>    for the CPU cycles of reclaim in the out-of-band domain?  Who is
>    charged for the paging IO? How is resource pressure accounted and
>    attributed? Soon you need cpu=3D and io=3D as well.
>

I think the allocating task is charged for cpu and io resources and
I'm not sure I see a compelling reason to change that. I think the
distinction is that memory is shared but charged to the one faulting
it which is maybe not really fair or can be deterministically
predicted by the sys admin setting limits on the various cgroups. I
don't see that logic extending to cpu, but perhaps to io maybe.

> My take on this is that it might work for your rather specific
> usecase, but it doesn't strike me as a general-purpose feature
> suitable for upstream.
>
>
> If we want sharing semantics for memory, I think we need a more
> generic implementation with a cleaner interface.
>

My issue here is that AFAICT in the upstream kernel there is no way to
deterministically charge the shared memory other than preallocation
which doesn't work so well on overcommitted systems and requires
changes in the individual tasks that are allocating the shared memory.
I'm definitely on board with any proposal that achieves what we want,
although there are issues with the specific proposal you mentioned.
(and thanks for reviewing and suggesting alternatives!)

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
>         root - job group - job
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

2 issues I see here:
1. This is a default change, somewhat likely to break existing accounting.
2. I think we're trying to make the charging deterministic, and this
makes it even harder to a priori predict where memory is charged:
(a) memory is initially charged to the allocating task, which forces
the sys admin to over provision cgroups that access shared memory,
because what if they pre-allocate the shared memory and get charged
for all of it?
(b) The shared memory will only land "where it's supposed to land" if
the sys admin has correctly set the permissions of the shared memory
(tmpfs file system permissions/visibility for example). If the mount
access is incorrectly configured and accessed by a bad actor the
memory will likely be reparented to root, which is likely worse than
causing ENOSPC/SIGBUS in the current proposal. Hence, it's really an
implicit requirement for the shared memory permissions to be correct
for this to work, in which case memcg=3D seems better to me since it
doesn't suffer from issue (a).

I'm loosely aware of past conversations with Shakeel where it was
recommended to charge the first common ancestor, mainly to side-step
issues with the oom-killer not finding anything to kill. IMO I quite
like memcg=3D approach because you can:
1. memcg=3D<first common ancestor cgroup>, and not deal with potential
SIGBUS/ENOSPC
2. memcg=3D<remote cgroup>, and deal with potential SIGBUS/ENOSPC.

And the user has flexibility to decide. But regardless of the
proposal, I see it as an existing/orthogonal problem that shared
memory permissions be 'correct', and AFAICT existing shared memory
permission models are completely oblivious to cgroups, so there is
work for the sys admin to do anyway to make sure that processes in the
intended processes only are able to access the shared memory.
