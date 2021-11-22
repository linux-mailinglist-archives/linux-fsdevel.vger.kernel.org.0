Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798AF459545
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 20:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhKVTHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 14:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237126AbhKVTHO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:07:14 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE453C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 11:04:06 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t83so19232700qke.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 11:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9nYbwee9dwTTMA5Npe3OVsEJCXk4RA71Ql0QtnWfjU0=;
        b=JtHUo6A8zLkK/EpyOJKz5ZT20MGUUz0mZp1LI9C5ZnspXeCN9IBcawDymrkBCLDcwP
         7GQgF/V3Xod3sS1OGKANSKUslAY1mCVrIEacf0GEDq61py7vOSeUJcv/95Rqy62HoXpB
         JEoFlpN+KQ/Vxgw1b1AEGUKgORx+Y9KZJqCYHfyRvC8zMurFmgaCnX64KcWPj4gmIwYU
         YViqW2vGFAhe9nd3DcS0drL3NVuh0wTI7/E0cHtKS0aanSEPsWHbDdbUacrYPcRy9D8N
         B55Yu/A4Au7aejvADkDGZ+5w8IuQDGCjGG2iqWoBme66j/m2v3XsTu/MoO/GPE5o/xD5
         BPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9nYbwee9dwTTMA5Npe3OVsEJCXk4RA71Ql0QtnWfjU0=;
        b=v+VDq2aMdkDAvRHMiHFAdFTuXc8DawTq9CGJ+C3ZpXYPwVta0AEcUUim+h3Tyu1+Oi
         6pMbYxsE8n2iSjGO51VurZyk/M9pbXLC6Kp6US1mXogg9vL2K8yddnjHehT9KtSY8DtD
         ljRxKwmUcr57U+BffVplCbDwxq1CpQlxqIPSIH/VIKYioXLDYihd9RaXbwJd5PF+gQoe
         NCEP4MHPodtIzlSP8dxKVkh9T7JxgMgWAS++P4oZAyjUTJTw335E5yFU1i2/9DmL1Voz
         IL57JjITg1fOH9i+yzrq3gomT6zTvfgYnERw5II32quuDOWaghbcm26JhC/uN7LdX28U
         QLdw==
X-Gm-Message-State: AOAM5304Erz8TWgtMG5QfuMxOeq97EIe/0VQZYDlWgPw3NB2J7ES0HKh
        BQDSGsdQv5z86a/DfigqYsVMqQ==
X-Google-Smtp-Source: ABdhPJy8w/1BGtWyFliVVZQGLy3CiRBXUPhP0AMM9nOZznVLVuNxI3M3+zeQqTveob9SqROfgHjdUA==
X-Received: by 2002:a05:620a:4722:: with SMTP id bs34mr12518875qkb.181.1637607846007;
        Mon, 22 Nov 2021 11:04:06 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id 2sm2829781qkr.126.2021.11.22.11.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:04:05 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:04:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mina Almasry <almasrymina@google.com>
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
        Roman Gushchin <guro@fb.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 0/4] Deterministic charging of shared memory
Message-ID: <YZvppKvUPTIytM/c@cmpxchg.org>
References: <20211120045011.3074840-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211120045011.3074840-1-almasrymina@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:50:06PM -0800, Mina Almasry wrote:
> Problem:
> Currently shared memory is charged to the memcg of the allocating
> process. This makes memory usage of processes accessing shared memory
> a bit unpredictable since whichever process accesses the memory first
> will get charged. We have a number of use cases where our userspace
> would like deterministic charging of shared memory:
> 
> 1. System services allocating memory for client jobs:
> We have services (namely a network access service[1]) that provide
> functionality for clients running on the machine and allocate memory
> to carry out these services. The memory usage of these services
> depends on the number of jobs running on the machine and the nature of
> the requests made to the service, which makes the memory usage of
> these services hard to predict and thus hard to limit via memory.max.
> These system services would like a way to allocate memory and instruct
> the kernel to charge this memory to the client’s memcg.
> 
> 2. Shared filesystem between subtasks of a large job
> Our infrastructure has large meta jobs such as kubernetes which spawn
> multiple subtasks which share a tmpfs mount. These jobs and its
> subtasks use that tmpfs mount for various purposes such as data
> sharing or persistent data between the subtask restarts. In kubernetes
> terminology, the meta job is similar to pods and subtasks are
> containers under pods. We want the shared memory to be
> deterministically charged to the kubernetes's pod and independent to
> the lifetime of containers under the pod.
> 
> 3. Shared libraries and language runtimes shared between independent jobs.
> We’d like to optimize memory usage on the machine by sharing libraries
> and language runtimes of many of the processes running on our machines
> in separate memcgs. This produces a side effect that one job may be
> unlucky to be the first to access many of the libraries and may get
> oom killed as all the cached files get charged to it.
> 
> Design:
> My rough proposal to solve this problem is to simply add a
> ‘memcg=/path/to/memcg’ mount option for filesystems:
> directing all the memory of the file system to be ‘remote charged’ to
> cgroup provided by that memcg= option.
> 
> Caveats:
> 
> 1. One complication to address is the behavior when the target memcg
> hits its memory.max limit because of remote charging. In this case the
> oom-killer will be invoked, but the oom-killer may not find anything
> to kill in the target memcg being charged. Thera are a number of considerations
> in this case:
> 
> 1. It's not great to kill the allocating process since the allocating process
>    is not running in the memcg under oom, and killing it will not free memory
>    in the memcg under oom.
> 2. Pagefaults may hit the memcg limit, and we need to handle the pagefault
>    somehow. If not, the process will forever loop the pagefault in the upstream
>    kernel.
> 
> In this case, I propose simply failing the remote charge and returning an ENOSPC
> to the caller. This will cause will cause the process executing the remote
> charge to get an ENOSPC in non-pagefault paths, and get a SIGBUS on the pagefault
> path.  This will be documented behavior of remote charging, and this feature is
> opt-in. Users can:
> - Not opt-into the feature if they want.
> - Opt-into the feature and accept the risk of received ENOSPC or SIGBUS and
>   abort if they desire.
> - Gracefully handle any resulting ENOSPC or SIGBUS errors and continue their
>   operation without executing the remote charge if possible.
> 
> 2. Only processes allowed the enter cgroup at mount time can mount a
> tmpfs with memcg=<cgroup>. This is to prevent intential DoS of random cgroups
> on the machine. However, once a filesysetem is mounted with memcg=<cgroup>, any
> process with write access to this mount point will be able to charge memory to
> <cgroup>. This is largely a non-issue because in configurations where there is
> untrusted code running on the machine, mount point access needs to be
> restricted to the intended users only regardless of whether the mount point
> memory is deterministly charged or not.

I'm not a fan of this. It uses filesystem mounts to create shareable
resource domains outside of the cgroup hierarchy, which has all the
downsides you listed, and more:

1. You need a filesystem interface in the first place, and a new
   ad-hoc channel and permission model to coordinate with the cgroup
   tree, which isn't great. All filesystems you want to share data on
   need to be converted.

2. It doesn't extend to non-filesystem sources of shared data, such as
   memfds, ipc shm etc.

3. It requires unintuitive configuration for what should be basic
   shared accounting semantics. Per default you still get the old
   'first touch' semantics, but to get sharing you need to reconfigure
   the filesystems?

4. If a task needs to work with a hierarchy of data sharing domains -
   system-wide, group of jobs, job - it must interact with a hierarchy
   of filesystem mounts. This is a pain to setup and may require task
   awareness. Moving data around, working with different mount points.
   Also, no shared and private data accounting within the same file.

5. It reintroduces cgroup1 semantics of tasks and resouces, which are
   entangled, sitting in disjunct domains. OOM killing is one quirk of
   that, but there are others you haven't touched on. Who is charged
   for the CPU cycles of reclaim in the out-of-band domain?  Who is
   charged for the paging IO? How is resource pressure accounted and
   attributed? Soon you need cpu= and io= as well.

My take on this is that it might work for your rather specific
usecase, but it doesn't strike me as a general-purpose feature
suitable for upstream.


If we want sharing semantics for memory, I think we need a more
generic implementation with a cleaner interface.

Here is one idea:

Have you considered reparenting pages that are accessed by multiple
cgroups to the first common ancestor of those groups?

Essentially, whenever there is a memory access (minor fault, buffered
IO) to a page that doesn't belong to the accessing task's cgroup, you
find the common ancestor between that task and the owning cgroup, and
move the page there.

With a tree like this:

	root - job group - job
                        `- job
            `- job group - job
                        `- job

all pages accessed inside that tree will propagate to the highest
level at which they are shared - which is the same level where you'd
also set shared policies, like a job group memory limit or io weight.

E.g. libc pages would (likely) bubble to the root, persistent tmpfs
pages would bubble to the respective job group, private data would
stay within each job.

No further user configuration necessary. Although you still *can* use
mount namespacing etc. to prohibit undesired sharing between cgroups.

The actual user-visible accounting change would be quite small, and
arguably much more intuitive. Remember that accounting is recursive,
meaning that a job page today also shows up in the counters of job
group and root. This would not change. The only thing that IS weird
today is that when two jobs share a page, it will arbitrarily show up
in one job's counter but not in the other's. That would change: it
would no longer show up as either, since it's not private to either;
it would just be a job group (and up) page.

This would be a generic implementation of resource sharing semantics:
independent of data source and filesystems, contained inside the
cgroup interface, and reusing the existing hierarchies of accounting
and control domains to also represent levels of common property.

Thoughts?
