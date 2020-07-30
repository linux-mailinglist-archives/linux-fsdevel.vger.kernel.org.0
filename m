Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1396C2334E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgG3PB2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:01:28 -0400
Received: from relay.sw.ru ([185.231.240.75]:46850 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgG3PB2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:01:28 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k1A3O-0004lX-J4; Thu, 30 Jul 2020 18:01:06 +0300
Subject: Re: [PATCH 00/23] proc: Introduce /proc/namespaces/ directory to
 expose namespaces lineary
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        areber@redhat.com, serge@hallyn.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <87k0yl5axy.fsf@x220.int.ebiederm.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <56928404-f194-4194-5f2a-59acb15b1a04@virtuozzo.com>
Date:   Thu, 30 Jul 2020 18:01:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0yl5axy.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 30.07.2020 17:34, Eric W. Biederman wrote:
> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> 
>> Currently, there is no a way to list or iterate all or subset of namespaces
>> in the system. Some namespaces are exposed in /proc/[pid]/ns/ directories,
>> but some also may be as open files, which are not attached to a process.
>> When a namespace open fd is sent over unix socket and then closed, it is
>> impossible to know whether the namespace exists or not.
>>
>> Also, even if namespace is exposed as attached to a process or as open file,
>> iteration over /proc/*/ns/* or /proc/*/fd/* namespaces is not fast, because
>> this multiplies at tasks and fds number.
> 
> I am very dubious about this.
> 
> I have been avoiding exactly this kind of interface because it can
> create rather fundamental problems with checkpoint restart.

restart/restore :)

> You do have some filtering and the filtering is not based on current.
> Which is good.
> 
> A view that is relative to a user namespace might be ok.    It almost
> certainly does better as it's own little filesystem than as an extension
> to proc though.
> 
> The big thing we want to ensure is that if you migrate you can restore
> everything.  I don't see how you will be able to restore these files
> after migration.  Anything like this without having a complete
> checkpoint/restore story is a non-starter.

There is no difference between files in /proc/namespaces/ directory and /proc/[pid]/ns/.

CRIU can restore open files in /proc/[pid]/ns, the same will be with /proc/namespaces/ files.
As a person who worked deeply for pid_ns and user_ns support in CRIU, I don't see any
problem here.

If you have a specific worries about, let's discuss them.

CC: Pavel Tikhomirov CRIU maintainer, who knows everything about namespaces C/R.
 
> Further by not going through the processes it looks like you are
> bypassing the existing permission checks.  Which has the potential
> to allow someone to use a namespace who would not be able to otherwise.

I agree, and I wrote to Christian, that permissions should be more strict.
This just should be formalized. Let's discuss this.

> So I think this goes one step too far but I am willing to be persuaded
> otherwise.
> 
> Eric
> 
> 
> 
> 
>> This patchset introduces a new /proc/namespaces/ directory, which exposes
>> subset of permitted namespaces in linear view:
>>
>> # ls /proc/namespaces/ -l
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'cgroup:[4026531835]' -> 'cgroup:[4026531835]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'ipc:[4026531839]' -> 'ipc:[4026531839]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531840]' -> 'mnt:[4026531840]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026531861]' -> 'mnt:[4026531861]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532133]' -> 'mnt:[4026532133]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532134]' -> 'mnt:[4026532134]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532135]' -> 'mnt:[4026532135]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'mnt:[4026532136]' -> 'mnt:[4026532136]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'net:[4026531993]' -> 'net:[4026531993]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'pid:[4026531836]' -> 'pid:[4026531836]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'time:[4026531834]' -> 'time:[4026531834]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'user:[4026531837]' -> 'user:[4026531837]'
>> lrwxrwxrwx 1 root root 0 Jul 29 16:50 'uts:[4026531838]' -> 'uts:[4026531838]'
>>
>> Namespace ns is exposed, in case of its user_ns is permitted from /proc's pid_ns.
>> I.e., /proc is related to pid_ns, so in /proc/namespace we show only a ns, which is
>>
>> 	in_userns(pid_ns->user_ns, ns->user_ns).
>>
>> In case of ns is a user_ns:
>>
>> 	in_userns(pid_ns->user_ns, ns).
>>
>> The patchset follows this steps:
>>
>> 1)A generic counter in ns_common is introduced instead of separate
>>   counters for every ns type (net::count, uts_namespace::kref,
>>   user_namespace::count, etc). Patches [1-8];
>> 2)Patch [9] introduces IDR to link and iterate alive namespaces;
>> 3)Patch [10] is refactoring;
>> 4)Patch [11] actually adds /proc/namespace directory and fs methods;
>> 5)Patches [12-23] make every namespace to use the added methods
>>   and to appear in /proc/namespace directory.
>>
>> This may be usefull to write effective debug utils (say, fast build
>> of networks topology) and checkpoint/restore software.
>> ---
>>
>> Kirill Tkhai (23):
>>       ns: Add common refcount into ns_common add use it as counter for net_ns
>>       uts: Use generic ns_common::count
>>       ipc: Use generic ns_common::count
>>       pid: Use generic ns_common::count
>>       user: Use generic ns_common::count
>>       mnt: Use generic ns_common::count
>>       cgroup: Use generic ns_common::count
>>       time: Use generic ns_common::count
>>       ns: Introduce ns_idr to be able to iterate all allocated namespaces in the system
>>       fs: Rename fs/proc/namespaces.c into fs/proc/task_namespaces.c
>>       fs: Add /proc/namespaces/ directory
>>       user: Free user_ns one RCU grace period after final counter put
>>       user: Add user namespaces into ns_idr
>>       net: Add net namespaces into ns_idr
>>       pid: Eextract child_reaper check from pidns_for_children_get()
>>       proc_ns_operations: Add can_get method
>>       pid: Add pid namespaces into ns_idr
>>       uts: Free uts namespace one RCU grace period after final counter put
>>       uts: Add uts namespaces into ns_idr
>>       ipc: Add ipc namespaces into ns_idr
>>       mnt: Add mount namespaces into ns_idr
>>       cgroup: Add cgroup namespaces into ns_idr
>>       time: Add time namespaces into ns_idr
>>
>>
>>  fs/mount.h                     |    4 
>>  fs/namespace.c                 |   14 +
>>  fs/nsfs.c                      |   78 ++++++++
>>  fs/proc/Makefile               |    1 
>>  fs/proc/internal.h             |   18 +-
>>  fs/proc/namespaces.c           |  382 +++++++++++++++++++++++++++-------------
>>  fs/proc/root.c                 |   17 ++
>>  fs/proc/task_namespaces.c      |  183 +++++++++++++++++++
>>  include/linux/cgroup.h         |    6 -
>>  include/linux/ipc_namespace.h  |    3 
>>  include/linux/ns_common.h      |   11 +
>>  include/linux/pid_namespace.h  |    4 
>>  include/linux/proc_fs.h        |    1 
>>  include/linux/proc_ns.h        |   12 +
>>  include/linux/time_namespace.h |   10 +
>>  include/linux/user_namespace.h |   10 +
>>  include/linux/utsname.h        |   10 +
>>  include/net/net_namespace.h    |   11 -
>>  init/version.c                 |    2 
>>  ipc/msgutil.c                  |    2 
>>  ipc/namespace.c                |   17 +-
>>  ipc/shm.c                      |    1 
>>  kernel/cgroup/cgroup.c         |    2 
>>  kernel/cgroup/namespace.c      |   25 ++-
>>  kernel/pid.c                   |    2 
>>  kernel/pid_namespace.c         |   46 +++--
>>  kernel/time/namespace.c        |   20 +-
>>  kernel/user.c                  |    2 
>>  kernel/user_namespace.c        |   23 ++
>>  kernel/utsname.c               |   23 ++
>>  net/core/net-sysfs.c           |    6 -
>>  net/core/net_namespace.c       |   18 +-
>>  net/ipv4/inet_timewait_sock.c  |    4 
>>  net/ipv4/tcp_metrics.c         |    2 
>>  34 files changed, 746 insertions(+), 224 deletions(-)
>>  create mode 100644 fs/proc/task_namespaces.c
>>
>> --
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

