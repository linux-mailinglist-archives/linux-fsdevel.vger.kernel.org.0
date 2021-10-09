Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF86F427B27
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Oct 2021 17:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhJIPPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Oct 2021 11:15:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233728AbhJIPPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:15:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 199EBilE009991;
        Sat, 9 Oct 2021 11:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=U9ICzRSemhXpQ8Gs+IIYn/ZqK8DXxn+HFppPLXabDOs=;
 b=fN7KxCITg5KNpdtbt7R7vrdHZ+xbeDV0CqbVRdH6SYSbVNMyBdGL5/VjA7O6FlTuLETZ
 DnAnE2GWYzf29+cSo30RMyQ7sOsdy/ms1HcPknYOD08vsG38XbcMC95Xok4yp38XYz+R
 u2ALPIIyvNDNp9OujvkE65DoVh+ckH06D90y9wG6ArlhkhU7Z+5OmhirzVSltqPpsfnz
 fLIiiMXO2Z4fG7LNX4/hlpzFTlfNIbqACfzbEEDN8/aEeWrurDcQdQZ3DVcYAV9BRfCx
 yutF/713YuO00vO+f7ZzzQ1MDABbm9FuVyz82gFZZq/38ebQ0+qv8Tf+vdysttJyTpgA dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bkcmkgndc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:12:55 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 199F912l010953;
        Sat, 9 Oct 2021 11:12:54 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bkcmkgnd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 11:12:54 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 199FCcUc003681;
        Sat, 9 Oct 2021 15:12:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3bk2q99yb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Oct 2021 15:12:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 199F7NKv49479974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 9 Oct 2021 15:07:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98DC04203F;
        Sat,  9 Oct 2021 15:12:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1EA42041;
        Sat,  9 Oct 2021 15:12:44 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.17.147])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  9 Oct 2021 15:12:44 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     bristot@redhat.com, christian@brauner.io, ebiederm@xmission.com,
        lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, containers@lists.linux.dev,
        containers@lists.linux-foundation.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 0/5] kernel: Introduce CPU Namespace
Date:   Sat,  9 Oct 2021 20:42:38 +0530
Message-Id: <20211009151243.8825-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uSf8C7KYpar7LFJGHciupFpk9gpxBgfi
X-Proofpoint-GUID: Osx1UPDLW3-reZU1zxNaH_GJifF8QgVh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-09_04,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110090109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An early prototype of to demonstrate CPU namespace interface and its
mechanism.

The kernel provides two ways to control CPU resources for tasks
1. cgroup cpuset:
   A control mechanism to restrict CPUs to a task or a
   set of tasks attached to that group
2. syscall sched_setaffinity:
   A system call that can pin tasks to a set of CPUs

The kernel also provides three ways to view the CPU resources available
to the system:
1. sys/procfs:
   CPU system information is divulged through sys and proc fs, it
   exposes online, offline, present as well as load characteristics on
   the CPUs
2. syscall sched_getaffinity:
   A system call interface to get the cpuset affinity of tasks
3. cgroup cpuset:
   While cgroup is more of a control mechanism than a display mechanism,
   it can be viewed to retrieve the CPU restrictions applied on a group
   of tasks

Coherency of information
------------------------
The control and the display interface is fairly disjoint with each
other. Restrictions can be set through control interfaces like cgroups,
while many applications legacy or otherwise get the view of the system
through sysfs/procfs and allocate resources like number of
threads/processes, memory allocation based on that information.

This can lead to unexpected running behaviors as well as have a high
impact on performance.

Existing solutions to the problem include userspace tools like LXCFS
which can fake the sysfs information by mounting onto the sysfs online
file to be in coherence with the limits set through cgroup cpuset.
However, LXCFS is an external solution and needs to be explicitly setup
for applications that require it. Another concern is also that tools
like LXCFS don't handle all the other display mechanism like procfs load
stats.

Therefore, the need of a clean interface could be advocated for.

Security and fair use implications
----------------------------------
In a multi-tenant system, multiple containers may exist and information
about the entire system, rather than just the resources that are
restricted upon them can cause security and fair use implications such
as:
1. A case where an actor can be in cognizance of the CPU node topology
   can schedule workloads and select CPUs such that the bus is flooded
   causing a Denial Of Service attack
2. A case wherein identifying the CPU system topology can help identify
   cores that are close to buses and peripherals such as GPUs to get an
   undue latency advantage from the rest of the workloads

A survey RFD discusses other potential solutions and their concerns are
listed here: https://lkml.org/lkml/2021/7/22/204

This prototype patchset introduces a new kernel namespace mechanism --
CPU namespace.

The CPU namespace isolates CPU information by virtualizing logical CPU
IDs and creating a scrambled virtual CPU map of the same.
It latches onto the task_struct and is the cpu translations designed to
be in a flat hierarchy this means that every virtual namespace CPU maps
to a physical CPU at the creation of the namespace. The advantage of a
flat hierarchy is that translations are O(1) and children do not need
to traverse up the tree to retrieve a translation.

This namespace then allows both control and display interfaces to be
CPU namespace context aware, such that a task within a namespace only
gets the view and therefore control of its and view CPU resources
available to it via a virtual CPU map.

Experiment
----------
We designed an experiment to benchmark nginx configured with
"worker_processes: auto" (which ensures that the number of processes to
spawn will be derived from resources viewed on the system) and a
benchmark/driver application wrk

Nginx: Nginx is a web server that can also be used as a reverse proxy,
load balancer, mail proxy and HTTP cache
Wrk: wrk is a modern HTTP benchmarking tool capable of generating
significant load when run on a single multi-core CPU

Docker is used as the containerization platform of choice.

The numbers gathered on IBM Power 9 CPU @ 2.979GHz with 176 CPUs and
127GB memory
kernel: 5.14

Case1: vanilla kernel - cpuset 4 cpus, no optimization
Case2: CPU namespace kernel - cpuset 4 cpus


+-----------------------+----------+----------+-----------------+
|        Metric         |  Case1   |  Case2   | case2 vs case 1 |
+-----------------------+----------+----------+-----------------+
| PIDs                  |      177 |        5 |        172 PIDs |
| mem usage (init) (MB) |    272.8 |    11.12 |          95.92% |
| mem usage (peak) (MB) |    281.3 |    20.62 |          92.66% |
| Latency (avg ms)      |    70.91 |    25.36 |          64.23% |
| Requests/sec          | 47011.05 | 47080.98 |           0.14% |
| Transfer/sec (MB)     |    38.11 |    38.16 |           0.13% |
+-----------------------+----------+----------+-----------------+

With the CPU namespace we see the correct number of PIDs spawning
corresponding to the cpuset limits set. The memory utilization drops
over 92-95%, the latency reduces by 64% and the the throughput like
requests and transfer per second is unchanged.

Note: To utilize this new namespace in a container runtime like docker,
the clone CPU namespace flag was modified to coincide with the PID
namespace as they are the building blocks of containers and will always
be invoked.

Current shortcomings in the prototype:
--------------------------------------
1. Containers also frequently use cfs period and quotas to restrict CPU
   runtime also known as millicores in modern container runtimes.
   The RFC interface currently does not account for this in
   the scheme of things.
2. While /proc/stat is now namespace aware and userspace programs like
   top will see the CPU utilization for their view of virtual CPUs;
   if the system or any other application outside the namespace
   bumps up the CPU utilization it will still show up in sys/user time.
   This should ideally be shown as stolen time instead.
   The current implementation plugs into the display of stats rather
   than accounting which causes incorrect reporting of stolen time.
3. The current implementation assumes that no hotplug operations occur
   within a container and hence the online and present cpus within a CPU
   namespace are always the same and query the same CPU namespace mask
4. As this is a proof of concept, currently we do not differentiate
   between cgroup cpus_allowed and effective_cpus and plugs them into
   the same virtual CPU map of the namespace
5. As described in a fair use implication earlier, knowledge of the
   CPU topology can potentially be taken an misused with a flood.
   While scrambling the CPUset in the namespace can help by
   obfuscation of information, the topology can still be roughly figured
   out with the use of IPI latencies to determine siblings or far away
   cores

More information about the design and a video demo of the prototype can
be found here: https://pratiksampat.github.io/cpu_namespace.html

Pratik R. Sampat (5):
  ns: Introduce CPU Namespace
  ns: Add scrambling functionality to CPU namespace
  cpuset/cpuns: Make cgroup CPUset CPU namespace aware
  cpu/cpuns: Make sysfs CPU namespace aware
  proc/cpuns: Make procfs load stats CPU namespace aware

 drivers/base/cpu.c             |  35 ++++-
 fs/proc/namespaces.c           |   4 +
 fs/proc/stat.c                 |  50 +++++--
 include/linux/cpu_namespace.h  | 159 ++++++++++++++++++++++
 include/linux/nsproxy.h        |   2 +
 include/linux/proc_ns.h        |   2 +
 include/linux/user_namespace.h |   1 +
 include/uapi/linux/sched.h     |   1 +
 init/Kconfig                   |   8 ++
 kernel/Makefile                |   1 +
 kernel/cgroup/cpuset.c         |  57 +++++++-
 kernel/cpu_namespace.c         | 233 +++++++++++++++++++++++++++++++++
 kernel/fork.c                  |   2 +-
 kernel/nsproxy.c               |  30 ++++-
 kernel/sched/core.c            |  16 ++-
 kernel/ucount.c                |   1 +
 16 files changed, 581 insertions(+), 21 deletions(-)
 create mode 100644 include/linux/cpu_namespace.h
 create mode 100644 kernel/cpu_namespace.c

-- 
2.31.1

