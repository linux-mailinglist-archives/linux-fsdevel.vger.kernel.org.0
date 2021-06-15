Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47A93A7E5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFOMtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 08:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230208AbhFOMtY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:49:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2A7561465;
        Tue, 15 Jun 2021 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623761240;
        bh=xgSj/kXDBWf17HlcxQQ77y03nyFnFmGwqRefUcaDXUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpliuJi5xetqWcnbDfYSi+WI3nmumjirYu9Wa8tZ651pnlNpFTIeVKCUIixslT4id
         7F5NrcxBLCKALQn8C4RHgSXE3R3uqNvYOlqMASqqkqU3IC0NjMxbNgT+igzWScOfuw
         njs1jByWUZgV+7jsI/UDhaETqNI/6gOqNpWfdT5qZYArCPOwmSDgGSHfcXEyEQnLBC
         DsEkrmhPMqV0f3bxz78cWMrCLKHEEF760w+MwwbxNJIwkD1JIEbr/qQ6GTjcETzup5
         /AHoPRgwTjklroPTB22TilcmA/9g3iplGmSoTXr0J0c8t8fq9Yg8OXkpsbIWCWVYwS
         8UYct4tcAY2tA==
Date:   Tue, 15 Jun 2021 14:47:15 +0200
From:   Alexey Gladkov <legion@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org
Subject: Re: [PATCH v1] proc: Implement /proc/self/meminfo
Message-ID: <20210615124715.nzd5we5tl7xc2n2p@example.org>
References: <ac070cd90c0d45b7a554366f235262fa5c566435.1622716926.git.legion@kernel.org>
 <20210615113222.edzkaqfvrris4nth@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615113222.edzkaqfvrris4nth@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 01:32:22PM +0200, Christian Brauner wrote:
> On Thu, Jun 03, 2021 at 12:43:07PM +0200, legion@kernel.org wrote:
> > From: Alexey Gladkov <legion@kernel.org>
> > 
> > The /proc/meminfo contains information regardless of the cgroups
> > restrictions. This file is still widely used [1]. This means that all
> > these programs will not work correctly inside container [2][3][4]. Some
> > programs try to respect the cgroups limits, but not all of them
> > implement support for all cgroup versions [5].
> > 
> > Correct information can be obtained from cgroups, but this requires the
> > cgroups to be available inside container and the correct version of
> > cgroups to be supported.
> > 
> > There is lxcfs [6] that emulates /proc/meminfo using fuse to provide
> > information regarding cgroups. This patch can help them.
> > 
> > This patch adds /proc/self/meminfo that contains a subset of
> > /proc/meminfo respecting cgroup restrictions.
> > 
> > We cannot just create /proc/self/meminfo and make a symlink at the old
> > location because this will break the existing apparmor rules [7].
> > Therefore, the patch adds a separate file with the same format.
> 
> Interesting work. Thanks. This is basically a variant of what I
> suggested at Plumbers and in [1].

I made the second version of the patch [1], but then I had a conversation
with Eric W. Biederman offlist. He convinced me that it is a bad idea to
change all the values in meminfo to accommodate cgroups. But we agreed
that MemAvailable in /proc/meminfo should respect cgroups limits. This
field was created to hide implementation details when calculating
available memory. You can see that it is quite widely used [2].
So I want to try to move in that direction.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/legion/linux.git/log/?h=patchset/meminfo/v2.0
[2] https://codesearch.debian.net/search?q=MemAvailable%3A

> Judging from the patches sent by Waiman Long in [2] to also virtualize
> /proc/cpuinfo and /sys/devices/system/cpu this is a larger push to
> provide virtualized system information to containers.
> 
> Although somewhere in the thread here this veered off into apparently
> just being a way for a process to gather information about it's own
> resources. At which point I'm confused why looking at its cgroups
> isn't enough.

I think it's not enough. As an example:

$ mount -t cgroup2 none /sys/fs/cgroup

$ echo +memory > /sys/fs/cgroup/cgroup.subtree_control
$ mkdir /sys/fs/cgroup/mem0

$ echo +memory > /sys/fs/cgroup/mem0/cgroup.subtree_control
$ mkdir /sys/fs/cgroup/mem0/mem1

$ echo $$ > /sys/fs/cgroup/mem0/mem1/cgroup.procs

I didn't set a limit and just added the shell to the group.

$ cat /proc/self/cgroup 
0::/mem0/mem1
$ cat /sys/fs/cgroup/mem0/mem1/memory.max 
max
$ cat /sys/fs/cgroup/mem0/memory.max 
max

In this case we need to use MemAvailable from /proc/meminfo.

Another example:

$ mount -t cgroup2 none /sys/fs/cgroup

$ echo +memory > /sys/fs/cgroup/cgroup.subtree_control
$ mkdir /sys/fs/cgroup/mem0
$ echo $(( 3 * 1024 * 1024 )) > /sys/fs/cgroup/mem0/memory.max

$ echo +memory > /sys/fs/cgroup/mem0/cgroup.subtree_control
$ mkdir /sys/fs/cgroup/mem0/mem1
$ echo $(( 3 * 1024 * 1024 * 1024 * 1024 )) > /sys/fs/cgroup/mem0/mem1/memory.max

$ echo $$ > /sys/fs/cgroup/mem0/mem1/cgroup.procs

$ head -3 /proc/meminfo  
MemTotal:        1002348 kB
MemFree:          972712 kB
MemAvailable:     968100 kB

$ cat /sys/fs/cgroup/mem0{,/mem1}/memory.max  
3145728
3298534883328

Now, I have cgroup limits, but you can write absolutely any value as a
limit. So how much memory is available to shell in this case? To get this
value, you need to take the minimum of MemAvailable and **/memory.max.
... or I fundamentally don't understand something.

> So /proc/self/meminfo seems to just be the start. And note the two
> approaches seem to diverge too. This provides a new file while the other
> patchset virtualizes existing proc files/folders.
> 
> In any case it seems you might want to talk since afaict you're all at
> the same company but don't seem to be aware of each others work (Which
> happens of course.).
> 
> For the sake of history such patchsets have been pushed for before by
> the Siteground people.
> 
> Chris and Johannes made a good point that the information provided in
> this file can be gathered from cgroups already. So applications should
> probably switch to reading those out of their cgroup and most are doing
> that already.
> 
> And reading values out of cgroups is pretty straightforward even with
> the differences between cgroup v1 and v2. Userspace is doing it all over
> the place all of the time and the code has now existed for years so the
> cgroup interface is a problem. And with cgroup v2 it keeps growing so
> much more useful metrics that looking at meminfo isn't really cutting it
> anyway.
> 
> So I think the argument that applications should start looking at their
> cgroup info if they want to find out detailed info is a solid argument
> that shouldn't be easily brushed aside.
> 
> What might be worth is knowing exactly what applications are looking at
> /proc/meminfo and /proc/cpuinfo and make decision based on that info.
> None of that is clearly outlined in the thread unfortunately.
> 
> So I immediately see two types of applications that could benefit from
> this patchset. The first ones are legacy applications that aren't aware
> of cgroups and aren't actively maintained. Introducing such
> functionality for these applications seems a weak argument.
> 
> The second type is new and maintained applications that look at global
> info such as /proc/meminfo and /proc/cpuinfo. So such applications have
> ignored cgroups for a decade now. This makes it very unconvincing that
> they will suddenly switch to a newly introduced file. Especially if the
> entries in a new file aren't a 1:1 mapping of the old file.
> 
> Johannes made another good point about it not being clear what
> applications actually want. And he's very right in that. It seems
> straightforward to virtualize things like meminfo but it actually isn't.
> And it's something you quite often discover after the fact. We have
> extensive experience implementing it in LXCFS in userspace. People kept
> and keep arguing what information exactly is supposed to go into
> calculating those values based on what best helps their use-case.
> 
> Swap was an especially contentious point. In fact, sometimes users want
> to turn of swap even though it exists on the host and there's a command
> line switch in LXCFS to control that behavior.
> 
> Another example supporting Johannes worry is virtualizing /proc/cpuinfo
> where some people wanted to virtualize cpu counts based on cpu shares.
> So we have two modes to virtualize cpus: based on cpuset alone or based
> on cpuset and cpu shares. And both modes are actively used. And that all
> really depends on application and workload.
> 
> Finally, although LXCFS is briefly referenced in the commit message but
> it isn't explained very well and what it does.
> 
> And we should consider it since this is a full existing userspace
> solution to the problem solved in this patchset including Dan's JRE
> use-case.
> 
> This is a project started in 2014 and it is in production use since 2014
> and it delivers the features of this patchset here and more.
> 
> For example, it's used in the Linux susbystem of Chromebooks, it's used
> by Alibaba (see [3]) and it is used for the JRE use-case by Google's
> Anthos when migrating such legacy applications (see [4]).
> 
> At first, I was convinced we could make use of /proc/self/meminfo in
> LXCFS which is why I held back but we can't. We can't simply bind-mount
> it over /proc/meminfo because it's not a 1:1 correspondence between all
> fields. We could potentially read some values we now calculate and
> display it in /proc/meminfo but we can't stop virtualizing /proc/meminfo
> itself. So we don't gain anything from this. When Alex asked me about it
> I tried to come up with good ways to integrate this but the gain is just
> too little for us.
> 
> Because our experience tells us that applications that want this type of
> virtualization don't really care about heir own resources. They care
> about a virtualized view of the system's resources. And the system in
> question is often a container. But it get's very tricky since we don't
> really define what a container is. So what data the user wants to see
> depends on the used container runtime, type of container, and workload.
> An application container has very different needs than a system
> container that boots systemd. LXCFS can be very flexible here and
> virtualize according to the users preferences (see the split between
> cpuset and cpuset + cpu shares virtualization for cpu counts).
> 
> In any case, LXCFS is a tiny FUSE filesystem which virtualizes various
> procfs and sysfs files for a container:
> 
> /proc/cpuinfo
> /proc/diskstats
> /proc/meminfo
> /proc/stat
> /proc/swaps
> /proc/uptime
> /proc/slabinfo
> /sys/devices/system/cpu/*
> /sys/devices/system/cpu/online
> 
> If you call top in a container that makes use of this it will display
> everything virtualized to the container (See [5] for an example of
> /proc/cpuinfo and /sys/devices/system/cpu/*.). And JRE will not
> overallocate resources. It's actively used for all of that.
> 
> Below at [5] you can find an example where 2 cpus out of 8 have been
> assigned to the container's cpuset. The container values are virtualized
> as you can see.
> 
> [1]: https://lkml.org/lkml/2020/6/4/951
> [2]: https://lore.kernel.org/lkml/YMe/cGV4JPbzFRk0@slm.duckdns.org
> [3]: https://www.alibabacloud.com/blog/kubernetes-demystified-using-lxcfs-to-improve-container-resource-visibility_594109
> [4]: https://cloud.google.com/blog/products/containers-kubernetes/migrate-for-anthos-streamlines-legacy-java-app-modernization
> [5]: ## /proc/cpuinfo
>      #### Host
>      brauner@wittgenstein|~
>      > ls -al /sys/devices/system/cpu/ | grep cpu[[:digit:]]
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu0
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu1
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu2
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu3
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu4
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu5
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu6
>      drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu7
>      
>      #### Container
>      brauner@wittgenstein|~
>      > lxc exec f1 -- ls -al /sys/devices/system/cpu/ | grep cpu[[:digit:]]
>      drwxr-xr-x  2 nobody nogroup   0 Jun 15 10:22 cpu3
>      drwxr-xr-x  2 nobody nogroup   0 Jun 15 10:22 cpu4
>      
>      ## /sys/devices/system/cpu/*
>      #### Host
>      brauner@wittgenstein|~
>      > grep ^processor /proc/cpuinfo
>      processor       : 0
>      processor       : 1
>      processor       : 2
>      processor       : 3
>      processor       : 4
>      processor       : 5
>      processor       : 6
>      processor       : 7
>      
>      #### Container
>      brauner@wittgenstein|~
>      > lxc exec f1 -- grep ^processor /proc/cpuinfo
>      processor       : 0
>      processor       : 1
> 
>      ## top
>      #### Host
>      top - 13:16:47 up 15:54, 39 users,  load average: 0,76, 0,47, 0,40
>      Tasks: 434 total,   1 running, 433 sleeping,   0 stopped,   0 zombie
>      %Cpu0  :  2,7 us,  2,4 sy,  0,0 ni, 94,5 id,  0,0 wa,  0,0 hi,  0,3 si,  0,0 st
>      %Cpu1  :  3,3 us,  1,3 sy,  0,0 ni, 95,3 id,  0,0 wa,  0,0 hi,  0,0 si,  0,0 st
>      %Cpu2  :  1,6 us,  9,1 sy,  0,0 ni, 89,3 id,  0,0 wa,  0,0 hi,  0,0 si,  0,0 st
>      %Cpu3  :  2,3 us,  1,3 sy,  0,0 ni, 96,4 id,  0,0 wa,  0,0 hi,  0,0 si,  0,0 st
>      %Cpu4  :  2,7 us,  1,7 sy,  0,0 ni, 95,7 id,  0,0 wa,  0,0 hi,  0,0 si,  0,0 st
>      %Cpu5  :  2,9 us,  2,9 sy,  0,0 ni, 94,1 id,  0,0 wa,  0,0 hi,  0,0 si,  0,0 st
>      %Cpu6  :  2,3 us,  1,0 sy,  0,0 ni, 96,3 id,  0,0 wa,  0,0 hi,  0,3 si,  0,0 st
>      %Cpu7  :  3,3 us,  1,3 sy,  0,0 ni, 95,4 id,  0,0 wa,  0,0 hi,  0,0 si,  0,0 st
> 
>      #### Container
>      top - 11:16:13 up  2:08,  0 users,  load average: 0.27, 0.36, 0.36
>      Tasks:  24 total,   1 running,  23 sleeping,   0 stopped,   0 zombie
>      %Cpu0  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
>      %Cpu1  :  0.0 us,  0.0 sy,  0.0 ni,100.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> 

-- 
Rgrds, legion

