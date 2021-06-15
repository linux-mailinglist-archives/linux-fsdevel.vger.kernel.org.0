Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE883A79E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFOJRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 05:17:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhFOJRE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:17:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61B1F61417;
        Tue, 15 Jun 2021 09:14:55 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:14:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin <hpa@zytor.com>, Rafael J. Wysocki " 
        <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/4] cgroup/cpuset: Allow cpuset to bound displayed cpu
 info
Message-ID: <20210615091451.afmrpuk3sbh7wjbc@wittgenstein>
References: <20210614152306.25668-1-longman@redhat.com>
 <YMe/cGV4JPbzFRk0@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMe/cGV4JPbzFRk0@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 04:43:28PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jun 14, 2021 at 11:23:02AM -0400, Waiman Long wrote:
> > The current container management system is able to create the illusion
> > that applications running within a container have limited resources and
> > devices available for their use. However, one thing that is hard to hide
> > is the number of CPUs available in the system. In fact, the container
> > developers are asking for the kernel to provide such capability.
> > 
> > There are two places where cpu information are available for the
> > applications to see - /proc/cpuinfo and /sys/devices/system/cpu sysfs
> > directory.
> > 
> > This patchset introduces a new sysctl parameter cpuset_bound_cpuinfo
> > which, when set, will limit the amount of information disclosed by
> > /proc/cpuinfo and /sys/devices/system/cpu.
> 
> The goal of cgroup has never been masquerading system information so that
> applications can pretend that they own the whole system and the proposed
> solution requires application changes anyway. The information being provided
> is useful but please do so within the usual cgroup interface - e.g.
> cpuset.stat. The applications (or libraries) that want to determine its
> confined CPU availability can locate the file through /proc/self/cgroup.

Fyi, there's another concurrent push going on to provide a new file
/proc/self/meminfo that is a subset of /proc/meminfo (cf. [1]) and
virtualizes based on cgroups as well.

But there it's a new file not virtualizing exisiting files and
directories so there things seem to be out of sync between these groups
at the same company.

In any case I would like to point out that this has a complete solution
in userspace. We have had this problem of providing virtualized
information to containers since they started existing. So we created
LXCFS in 2014 (cf. [2]) a tiny fuse fileystem to provide a virtualized
view based on cgroups and other information for containers.

The two patchsets seems like they're on the way trying to move 1:1 what
we're already doing in userspace into the kernel. LXCFS is quite well
known and widely used so it's suprising to not see it mentioned at all.

And the container people will want more then just the cpu and meminfo
stuff sooner or later. Just look at what we currently virtualize:

/proc/cpuinfo
/proc/diskstats
/proc/meminfo
/proc/stat
/proc/swaps
/proc/uptime
/proc/slabinfo
/sys/devices/system/cpu

## So for example /proc/cpuinfo
#### Host
brauner@wittgenstein|~
> grep ^processor /proc/cpuinfo
processor       : 0
processor       : 1
processor       : 2
processor       : 3
processor       : 4
processor       : 5
processor       : 6
processor       : 7

#### Container
brauner@wittgenstein|~
> lxc exec f1 -- grep ^processor /proc/cpuinfo
processor       : 0
processor       : 1

## and for /sys/devices/system/cpu
#### Host
brauner@wittgenstein|~
> ls -al /sys/devices/system/cpu/ | grep cpu[[:digit:]]
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu0
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu1
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu2
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu3
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu4
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu5
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu6
drwxr-xr-x 10 root root    0 Jun 14 21:22 cpu7

#### Container
brauner@wittgenstein|~
> lxc exec f1 -- ls -al /sys/devices/system/cpu/ | grep cpu[[:digit:]]
drwxr-xr-x  2 nobody nogroup   0 Jun 15 09:07 cpu3
drwxr-xr-x  2 nobody nogroup   0 Jun 15 09:07 cpu4

We have a wide variety of users from various distros.

[1]: https://lore.kernel.org/containers/f62b652c-3f6f-31ba-be0f-5f97b304599f@metux.net
[2]: https://github.com/lxc/lxcfs
