Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0810E428A9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 12:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhJKKNf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 06:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235726AbhJKKNe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E73960E74;
        Mon, 11 Oct 2021 10:11:27 +0000 (UTC)
Date:   Mon, 11 Oct 2021 12:11:24 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Pratik R. Sampat" <psampat@linux.ibm.com>
Cc:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, pratik.r.sampat@gmail.com
Subject: Re: [RFC 0/5] kernel: Introduce CPU Namespace
Message-ID: <20211011101124.d5mm7skqfhe5g35h@wittgenstein>
References: <20211009151243.8825-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211009151243.8825-1-psampat@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 09, 2021 at 08:42:38PM +0530, Pratik R. Sampat wrote:
> An early prototype of to demonstrate CPU namespace interface and its
> mechanism.
> 
> The kernel provides two ways to control CPU resources for tasks
> 1. cgroup cpuset:
>    A control mechanism to restrict CPUs to a task or a
>    set of tasks attached to that group
> 2. syscall sched_setaffinity:
>    A system call that can pin tasks to a set of CPUs
> 
> The kernel also provides three ways to view the CPU resources available
> to the system:
> 1. sys/procfs:
>    CPU system information is divulged through sys and proc fs, it
>    exposes online, offline, present as well as load characteristics on
>    the CPUs
> 2. syscall sched_getaffinity:
>    A system call interface to get the cpuset affinity of tasks
> 3. cgroup cpuset:
>    While cgroup is more of a control mechanism than a display mechanism,
>    it can be viewed to retrieve the CPU restrictions applied on a group
>    of tasks
> 
> Coherency of information
> ------------------------
> The control and the display interface is fairly disjoint with each
> other. Restrictions can be set through control interfaces like cgroups,
> while many applications legacy or otherwise get the view of the system
> through sysfs/procfs and allocate resources like number of
> threads/processes, memory allocation based on that information.
> 
> This can lead to unexpected running behaviors as well as have a high
> impact on performance.
> 
> Existing solutions to the problem include userspace tools like LXCFS
> which can fake the sysfs information by mounting onto the sysfs online
> file to be in coherence with the limits set through cgroup cpuset.
> However, LXCFS is an external solution and needs to be explicitly setup
> for applications that require it. Another concern is also that tools
> like LXCFS don't handle all the other display mechanism like procfs load
> stats.
> 
> Therefore, the need of a clean interface could be advocated for.
> 
> Security and fair use implications
> ----------------------------------
> In a multi-tenant system, multiple containers may exist and information
> about the entire system, rather than just the resources that are
> restricted upon them can cause security and fair use implications such
> as:
> 1. A case where an actor can be in cognizance of the CPU node topology
>    can schedule workloads and select CPUs such that the bus is flooded
>    causing a Denial Of Service attack
> 2. A case wherein identifying the CPU system topology can help identify
>    cores that are close to buses and peripherals such as GPUs to get an
>    undue latency advantage from the rest of the workloads
> 
> A survey RFD discusses other potential solutions and their concerns are
> listed here: https://lkml.org/lkml/2021/7/22/204
> 
> This prototype patchset introduces a new kernel namespace mechanism --
> CPU namespace.
> 
> The CPU namespace isolates CPU information by virtualizing logical CPU
> IDs and creating a scrambled virtual CPU map of the same.
> It latches onto the task_struct and is the cpu translations designed to
> be in a flat hierarchy this means that every virtual namespace CPU maps
> to a physical CPU at the creation of the namespace. The advantage of a
> flat hierarchy is that translations are O(1) and children do not need
> to traverse up the tree to retrieve a translation.
> 
> This namespace then allows both control and display interfaces to be
> CPU namespace context aware, such that a task within a namespace only
> gets the view and therefore control of its and view CPU resources
> available to it via a virtual CPU map.
> 
> Experiment
> ----------
> We designed an experiment to benchmark nginx configured with
> "worker_processes: auto" (which ensures that the number of processes to
> spawn will be derived from resources viewed on the system) and a
> benchmark/driver application wrk
> 
> Nginx: Nginx is a web server that can also be used as a reverse proxy,
> load balancer, mail proxy and HTTP cache
> Wrk: wrk is a modern HTTP benchmarking tool capable of generating
> significant load when run on a single multi-core CPU
> 
> Docker is used as the containerization platform of choice.
> 
> The numbers gathered on IBM Power 9 CPU @ 2.979GHz with 176 CPUs and
> 127GB memory
> kernel: 5.14
> 
> Case1: vanilla kernel - cpuset 4 cpus, no optimization
> Case2: CPU namespace kernel - cpuset 4 cpus
> 
> 
> +-----------------------+----------+----------+-----------------+
> |        Metric         |  Case1   |  Case2   | case2 vs case 1 |
> +-----------------------+----------+----------+-----------------+
> | PIDs                  |      177 |        5 |        172 PIDs |
> | mem usage (init) (MB) |    272.8 |    11.12 |          95.92% |
> | mem usage (peak) (MB) |    281.3 |    20.62 |          92.66% |
> | Latency (avg ms)      |    70.91 |    25.36 |          64.23% |
> | Requests/sec          | 47011.05 | 47080.98 |           0.14% |
> | Transfer/sec (MB)     |    38.11 |    38.16 |           0.13% |
> +-----------------------+----------+----------+-----------------+
> 
> With the CPU namespace we see the correct number of PIDs spawning
> corresponding to the cpuset limits set. The memory utilization drops
> over 92-95%, the latency reduces by 64% and the the throughput like
> requests and transfer per second is unchanged.
> 
> Note: To utilize this new namespace in a container runtime like docker,
> the clone CPU namespace flag was modified to coincide with the PID
> namespace as they are the building blocks of containers and will always
> be invoked.
> 
> Current shortcomings in the prototype:
> --------------------------------------
> 1. Containers also frequently use cfs period and quotas to restrict CPU
>    runtime also known as millicores in modern container runtimes.
>    The RFC interface currently does not account for this in
>    the scheme of things.
> 2. While /proc/stat is now namespace aware and userspace programs like
>    top will see the CPU utilization for their view of virtual CPUs;
>    if the system or any other application outside the namespace
>    bumps up the CPU utilization it will still show up in sys/user time.
>    This should ideally be shown as stolen time instead.
>    The current implementation plugs into the display of stats rather
>    than accounting which causes incorrect reporting of stolen time.
> 3. The current implementation assumes that no hotplug operations occur
>    within a container and hence the online and present cpus within a CPU
>    namespace are always the same and query the same CPU namespace mask
> 4. As this is a proof of concept, currently we do not differentiate
>    between cgroup cpus_allowed and effective_cpus and plugs them into
>    the same virtual CPU map of the namespace
> 5. As described in a fair use implication earlier, knowledge of the
>    CPU topology can potentially be taken an misused with a flood.
>    While scrambling the CPUset in the namespace can help by
>    obfuscation of information, the topology can still be roughly figured
>    out with the use of IPI latencies to determine siblings or far away
>    cores
> 
> More information about the design and a video demo of the prototype can
> be found here: https://pratiksampat.github.io/cpu_namespace.html

Thank your for providing a new approach to this problem and thanks for
summarizing some of the painpoints and current solutions. I do agree
that this is a problem we should tackle in some form.

I have one design comment and one process related comments.

Fundamentally I think making this a new namespace is not the correct
approach. One core feature of a namespace it that it is an opt-in
isolation mechanism: if I do CLONE_NEW* that is when the new isolation
mechanism kicks. The correct reporting through procfs and sysfs is
built into that and we do bugfixes whenever reported information is
wrong.

The cpu namespace would be different; a point I think you're making as
well further above:

> The control and the display interface is fairly disjoint with each
> other. Restrictions can be set through control interfaces like cgroups,

A task wouldn't really opt-in to cpu isolation with CLONE_NEWCPU it
would only affect resource reporting. So it would be one half of the
semantics of a namespace.

We do already have all the infra in place to isolate/delegate cpu
related resources in the form of cgroups. The cpu namespace would then
be a hack on top of this to fix non-virtualized resource reporting.

In all honesty, I think cpu resource reporting through procfs/sysfs as
done today without taking a tasks cgroup information into account is a
bug. But the community has long agreed that fixing this would be a
regression.

I think that either we need to come up with new non-syscall based
interfaces that allow to query virtualized cpu information and buy into
the process of teaching userspace about them. This is even independent
of containers.
This is in line with proposing e.g. new procfs/sysfs files. Userspace
can then keep supplementing cpu virtualization via e.g. stuff like LXCFS
until tools have switched to read their cpu information from new
interfaces. Something that they need to be taught anyway.

Or if we really want to have this tied to a namespace then I think we
should consider extending CLONE_NEWCGROUP since cgroups are were cpu
isolation for containers is really happening. And arguably we should
restrict this to cgroup v2.

From a process perspective, I think this is something were we will need
strong guidance from the cgroup and cpu crowd. Ultimately, they need to
be the ones merging a feature like this as this is very much into their
territory.

Christian
