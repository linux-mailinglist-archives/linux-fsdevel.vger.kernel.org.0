Return-Path: <linux-fsdevel+bounces-55185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33749B07EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5637A4A7D4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC522C08A8;
	Wed, 16 Jul 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kmThNzHO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937DC2D1;
	Wed, 16 Jul 2025 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697121; cv=none; b=XxKgLJvOBysLZnoSaNLnWBi9sdRHQKPUfFSZehKeV8x63CJcU8Cw8TTR5tfnKf2WVH8kuPy2d+JpdZPaCA6wYQnm3i9GUm+ItNB3Zei9TNdmogxjEEpVYjRUKuS6LoBopaQ/r8oK3W07ltQzNOJ1X18SJduiHbB8SyBRZfVKKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697121; c=relaxed/simple;
	bh=H/xM4Z0MjVRix0+b1Fuw+636XMoUie55Y/s9OTooSgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSt9qpdFi1Pp/m3Onpah1yYXUon1ubHBUg9Ho5IAnyj5bN+KBsaTjxmpUAQ5QoH316GO+U6eudOO8cATvv5w+54kKSZfWzKFRoNqc783Lkk6N+gOnSsLaFDCEPdPHdTrWu2oQLq/L8FlQHA3sPVpIxtlcy+72paWtjLzb4jv8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kmThNzHO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hN5UcNOceAW9gJ/Y8MIabvr/9qWRaAS173z8GQgYkMI=; b=kmThNzHOvISsdaYQElDiHi8q5Q
	CwMCw5ANyqqa8r1lg+P+8naMfvfrJIkC/CWnWEQyqcFxuKeUJObRs7MriLA5B+cdBY9gPn1zIGH5E
	lnhtujB8iEsamDUPd7uNmY5vEFLqxUFpveusUW4xjZvcgeVxQ/pn0n9Mb5tHa4kilZXkEAFQ6XI42
	8vACu5Yd512HTgNJXam34PFAWkrLc+hEIrAT4qxyDoMF7GylRRZru68eUVyllh+TrBbxfHNn321E3
	O7CyIhXxOHXlRLYOyG227XMg+fwBp6x1lNWh/cFgFfeTvvLHtw3Bsy40e/GX9KVZE3v10/SSvZUQj
	NyRdXUjw==;
Received: from [223.233.66.171] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uc8aA-00HTUe-A4; Wed, 16 Jul 2025 22:18:26 +0200
Message-ID: <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com>
Date: Thu, 17 Jul 2025 01:48:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-trace-kernel@vger.kernel.org,
 kees@kernel.org, torvalds@linux-foundation.org
References: <20250716123916.511889-1-bhupesh@igalia.com>
 <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/16/25 11:40 PM, Andrii Nakryiko wrote:
> On Wed, Jul 16, 2025 at 5:40 AM Bhupesh <bhupesh@igalia.com> wrote:
>> Historically due to the 16-byte length of TASK_COMM_LEN, the
>> users of 'tsk->comm' are restricted to use a fixed-size target
>> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
>>
>> To fix the same, Kees suggested in [1] that we can replace tsk->comm,
>> with tsk->comm_str, inside 'task_struct':
>>         union {
>>                 char    comm_str[TASK_COMM_EXT_LEN];
>>         };
>>
>> where TASK_COMM_EXT_LEN is 64-bytes.
> Do we absolutely have to rename task->comm field? I understand as an
> intermediate step to not miss any existing users in the kernel
> sources, but once that all is done, we can rename that back to comm,
> right?
>
> The reason I'm asking is because accessing task->comm is *very common*
> with all sorts of BPF programs and scripts. Yes, we have way to deal
> with that with BPF CO-RE, but every single use case would need to be
> updated now to work both with task->comm name on old kernels and
> task->comm_str on new kernels (because BPF programs are written in
> more or less kernel version agnostic way, so they have to handle many
> kernel releases).
>
> So, unless absolutely necessary, can we please keep the field name the
> same? Changing the size of that field is not really a problem for BPF,
> so no objections against that.

So, as a background we have had several previous discussions regarding 
renaming the 'tsk->comm' to 'task->comm_str' on the list (please see [1] 
and [2] for details), and as per Kees's recommendations we have taken 
this approach in the v5 patchset (may be Kees can add further details if 
I have missed adding something in the log message above).

That being said, ideally one would not like to break any exiting ABI 
(which includes existing / older BPF programs). I was having a look at 
the BPF CO_RE reference guide (see [3]), and was able to make out that 
BPF CO_RE has a definition of |s||truct task_struct|which doesn't need 
to match the kernel's struct task_struct definition exactly (as [3] 
mentions -> only a necessary subset of fields have to be present and 
compatible):

|struct task_struct { intpid; charcomm[16]; struct 
task_struct*group_leader; } __attribute__((preserve_access_index)); |

So, if we add a check here to add  '|charcomm[16]' or||charcomm_str[16]' 
to BPF CO RE's internal 'struct task_struct' on basis of the underlying 
kernel version being used (something like using  'KERNEL_VERSION(x, y, 
0)' for example), will that suffice? I have ||used and seen these checks 
being used in the user-space applications (for example, see [4]) at 
several occasions.

Please let me know your views.

|[1]. https://lore.kernel.org/all/202505222041.B639D482FB@keescook/
[2]. 
https://lore.kernel.org/all/ba4ddf27-91e7-0ecc-95d5-c139f6978812@igalia.com/
[3]. https://nakryiko.com/posts/bpf-core-reference-guide/
[4]. 
https://github.com/crash-utility/crash/blob/master/memory_driver/crash.c#L41C25-L41C49

Thanks.

>> And then modify 'get_task_comm()' to pass 'tsk->comm_str'
>> to the existing users.
>>
>> This would mean that ABI is maintained while ensuring that:
>>
>> - Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm_str'
>>    truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
>> - New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
>>   'tsk->comm_str' supported for a maximum of 'TASK_COMM_EXTLEN' (64-bytes).
>>
>> Note, that the existing users have not been modified to migrate to
>> 'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
>> dealing with only a 'TASK_COMM_LEN' long 'tsk->comm_str'.
>>
>> [1]. https://lore.kernel.org/all/202505231346.52F291C54@keescook/
>>
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
>> ---
>>   arch/arm64/kernel/traps.c        |  2 +-
>>   arch/arm64/kvm/mmu.c             |  2 +-
>>   block/blk-core.c                 |  2 +-
>>   block/bsg.c                      |  2 +-
>>   drivers/char/random.c            |  2 +-
>>   drivers/hid/hid-core.c           |  6 +++---
>>   drivers/mmc/host/tmio_mmc_core.c |  6 +++---
>>   drivers/pci/pci-sysfs.c          |  2 +-
>>   drivers/scsi/scsi_ioctl.c        |  2 +-
>>   drivers/tty/serial/serial_core.c |  2 +-
>>   drivers/tty/tty_io.c             |  8 ++++----
>>   drivers/usb/core/devio.c         | 16 ++++++++--------
>>   drivers/usb/core/message.c       |  2 +-
>>   drivers/vfio/group.c             |  2 +-
>>   drivers/vfio/vfio_iommu_type1.c  |  2 +-
>>   drivers/vfio/vfio_main.c         |  2 +-
>>   drivers/xen/evtchn.c             |  2 +-
>>   drivers/xen/grant-table.c        |  2 +-
>>   fs/binfmt_elf.c                  |  2 +-
>>   fs/coredump.c                    |  4 ++--
>>   fs/drop_caches.c                 |  2 +-
>>   fs/exec.c                        |  8 ++++----
>>   fs/ext4/dir.c                    |  2 +-
>>   fs/ext4/inode.c                  |  2 +-
>>   fs/ext4/namei.c                  |  2 +-
>>   fs/ext4/super.c                  | 12 ++++++------
>>   fs/hugetlbfs/inode.c             |  2 +-
>>   fs/ioctl.c                       |  2 +-
>>   fs/iomap/direct-io.c             |  2 +-
>>   fs/jbd2/transaction.c            |  2 +-
>>   fs/locks.c                       |  2 +-
>>   fs/netfs/internal.h              |  2 +-
>>   fs/proc/base.c                   |  2 +-
>>   fs/read_write.c                  |  2 +-
>>   fs/splice.c                      |  2 +-
>>   include/linux/coredump.h         |  2 +-
>>   include/linux/filter.h           |  2 +-
>>   include/linux/ratelimit.h        |  2 +-
>>   include/linux/sched.h            | 11 ++++++++---
>>   init/init_task.c                 |  2 +-
>>   ipc/sem.c                        |  2 +-
>>   kernel/acct.c                    |  2 +-
>>   kernel/audit.c                   |  4 ++--
>>   kernel/auditsc.c                 | 10 +++++-----
>>   kernel/bpf/helpers.c             |  2 +-
>>   kernel/capability.c              |  4 ++--
>>   kernel/cgroup/cgroup-v1.c        |  2 +-
>>   kernel/cred.c                    |  4 ++--
>>   kernel/events/core.c             |  2 +-
>>   kernel/exit.c                    |  6 +++---
>>   kernel/fork.c                    |  9 +++++++--
>>   kernel/freezer.c                 |  4 ++--
>>   kernel/futex/waitwake.c          |  2 +-
>>   kernel/hung_task.c               | 10 +++++-----
>>   kernel/irq/manage.c              |  2 +-
>>   kernel/kthread.c                 |  2 +-
>>   kernel/locking/rtmutex.c         |  2 +-
>>   kernel/printk/printk.c           |  2 +-
>>   kernel/sched/core.c              | 22 +++++++++++-----------
>>   kernel/sched/debug.c             |  4 ++--
>>   kernel/signal.c                  |  6 +++---
>>   kernel/sys.c                     |  6 +++---
>>   kernel/sysctl.c                  |  2 +-
>>   kernel/time/itimer.c             |  4 ++--
>>   kernel/time/posix-cpu-timers.c   |  2 +-
>>   kernel/tsacct.c                  |  2 +-
>>   kernel/workqueue.c               |  6 +++---
>>   lib/dump_stack.c                 |  2 +-
>>   lib/nlattr.c                     |  6 +++---
>>   mm/compaction.c                  |  2 +-
>>   mm/filemap.c                     |  4 ++--
>>   mm/gup.c                         |  2 +-
>>   mm/memfd.c                       |  2 +-
>>   mm/memory-failure.c              | 10 +++++-----
>>   mm/memory.c                      |  2 +-
>>   mm/mmap.c                        |  4 ++--
>>   mm/oom_kill.c                    | 18 +++++++++---------
>>   mm/page_alloc.c                  |  4 ++--
>>   mm/util.c                        |  2 +-
>>   net/core/sock.c                  |  2 +-
>>   net/dns_resolver/internal.h      |  2 +-
>>   net/ipv4/raw.c                   |  2 +-
>>   net/ipv4/tcp.c                   |  2 +-
>>   net/socket.c                     |  2 +-
>>   security/lsm_audit.c             |  4 ++--
>>   85 files changed, 171 insertions(+), 161 deletions(-)
>>
> [...]


