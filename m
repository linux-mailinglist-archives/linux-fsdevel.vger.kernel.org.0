Return-Path: <linux-fsdevel+bounces-19387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1AF8C45C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 19:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7298F282330
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B11CFA0;
	Mon, 13 May 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redpanda.com header.i=@redpanda.com header.b="jrnDXyg1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F71CAAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620292; cv=none; b=nSvjJBch98J/nB7rPtdHuewV1LOXnraW7rJFtC5kZcvauhIzPBCXGB8GmFgyC5mycpj9XJJRxa1fGGtch5H9P31jUcVCh7/swzJGniGANbBiviZdS+Hgf47DqEiYwzGIyEOVZP8CpHYB4qE170gw4wqLH83kPbf1Z7TQa3ZBFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620292; c=relaxed/simple;
	bh=r3KCbusKl6HYFEm0pXq7CJVKxD1XjgCkzEh2P62hrK0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Z/M/4VECeGGw1ZX5klF1EhilQ0eUp0U3cc2duU+m7GrYVfXQJkCJCwO6K7ZsDvYFlKazYgohRIBRJ9V0+kbdzM2fXyX/B7eTPb1aKetcBLiwN01jPyXIKc/yOqkuKj5JVWfCJsK/Rwi50VPMov15EIxritAf11xXIWrXh68S5WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redpanda.com; spf=pass smtp.mailfrom=redpanda.com; dkim=pass (2048-bit key) header.d=redpanda.com header.i=@redpanda.com header.b=jrnDXyg1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redpanda.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee38966529so37967725ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redpanda.com; s=google; t=1715620289; x=1716225089; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w+gzUNlbH9+Yu9hkxBCy0Pv01cGyEpaMwAhrpdG1PYk=;
        b=jrnDXyg1DX2f13L2dpf3avMDdx+DJHhGzPircHWGYpaiC6RsneNLoWdCnrNNAftuRt
         YSjv5682hg9B63l+KHePLOL+8ywDFImi+/30i5BnTvzVF2zfCV0J1EPf7YzkHTQy3g7X
         sJK5LvtTtQOsG+BL0uXTLtNy51DAf3vPqdfy7z0fHupco3wWRl9isM4Wwqj0/XQvQix7
         ni7Z2ivreFR5zLSf4WDwpkhnMKE4mHL8+POffWb3B8DWSgHjfqik08tYYPdj7fr/bJ4L
         Xb5c3zs+KYYNtt+GPrMqLG5WnsYO1BmhCbdeaZWF1UCu9foZ67uIuxX6xLcH/MAwblSN
         6E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620289; x=1716225089;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+gzUNlbH9+Yu9hkxBCy0Pv01cGyEpaMwAhrpdG1PYk=;
        b=AfmLdXj2jgCKHEQ1HI/ndwGvsI3I1383o83n/7t/DboNf3mLsjDHe3t6OkiA7WYskR
         7C6Fk3ReKhqe5X3w1y4f5fVSg6ck5gidpMZwsaVyCIFkWUgD3SFE8NPDGtSjGTzxzYyZ
         gDPaXGQasvMniD+bABGDfVfgBLofPc2d2EWyCscIblvfGYB1AjGUj6FXD4Qyss/tXUnN
         YpB45zXGVnZJlNh4cHreTcZofO/Obvj9TbFRNTaGYcjcoPpP1mmMzaROv5W5J2EUGV+/
         VXbe3ObtWimYMqIWnMqjsDaVI2pxuwe8yegAu4qk5gdjwvOA3xN4vXYEc5KrwFP+V6Hz
         Pq0Q==
X-Gm-Message-State: AOJu0YxvUJ2N9GYxcH3e46/8beHki5+XUXUhfKenfFcZHxnhlmjl5LLe
	imn40ae52iVne7FY5/KbUQQ4zX7e6nE1SskycE0STEu9vsMRTpm1L7wfWAe1wF8MxYw+R8EJYnB
	BkcZpN6LvgCAMBJV4DV5oe+lmwXdGdndWFdoaALcHu2ALIFOUZDS8LU4wdlz/ZyJyQoEc41HFrM
	UUYsL9EZHTOUUA0jqN7JuDXsKtJo4dLJWNLakNj/kVJm0=
X-Google-Smtp-Source: AGHT+IGdntRBJn2Z3pJ7BJsMGKtiur4o6OSBH+msbtqOkFkzgt0/MytuPGRy0Az6lIgxd2iiXNVNRiqJpVuIXEqfRTE=
X-Received: by 2002:a17:90a:af86:b0:2b5:91d1:3ae8 with SMTP id
 98e67ed59e1d1-2b6c711009cmr16055010a91.14.1715620289338; Mon, 13 May 2024
 10:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Stephan Dollberg <stephan@redpanda.com>
Date: Mon, 13 May 2024 18:11:18 +0100
Message-ID: <CAM9ScsHJ1zQ4j+0J+jQ1fUyRvxTMCF9OKC9kcvD5uyQZKxN1Pg@mail.gmail.com>
Subject: Context-switch storm caused by contended dio kernel thread
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Gm-Spam: 0
X-Gm-Phishy: 0

Hi fsdevel,

I wanted to get your opinion on the following scenario where we are running into
disk/iops perf issues because the dio kernel worker thread is being cpu starved.
Please also let me know if you think there is a better place to ask this than
this mailing list.

Originally we stumbled upon this when running Redpanda in kubernetes but the
problem is fairly reproducible by using fio.

k8s creates a cgroup (hierarchy) in which it spawns its pods. On an N-core
system it assigns a cgroup cpu.weight of N times the default weight to the root
of the cgroup. Hence tasks running in that cgroup get about N times more runtime
than other tasks (including kernel threads).

In a scenario when using direct io this can cause performance issues as the dio
thread that handles the dio completions gets excessively preempted and hence
effectively falls behind.

Outside of a k8s environment we can reproduce it like the following.

Setup a cgroup (assuming a cgroups v2 system):

--
cgcreate -g cpu:/kubepods
cgset -r cpu.weight=1000 kubepods
--

Now compare fio running outside of the cgroup and inside it. Test system is:

 - Amazon Linux 2023 / 6.1 Linux
 - i3en.3xlarge instance / 200k IOPS@4K write
 - XFS filesystem

Outside / good:

--
taskset -c 11 fio --name=write_iops --directory=/mnt/xfs --size=10G
--time_based --runtime=1m --ramp_time=10s \
  --ioengine=libaio --direct=1 --verify=0 --bs=4K --iodepth=128
--rw=randwrite --group_reporting=1  --iodepth_batch_submit=128
--iodepth_batch_complete_max=128
...
   iops        : min=200338, max=200944, avg=200570.37, stdev=60.93, samples=120
...
--

We see that we reach the full 200k IOPS.

Now compare to running inside the cgroup:

--
cgexec -g cpu:kubepods -- taskset -c 11 fio --name=write_iops
--directory=/mnt/xfs --size=10G --time_based --runtime=1m \
  --ramp_time=10s --ioengine=libaio --direct=1 --verify=0 --bs=4K
--iodepth=128 --rw=randwrite --group_reporting=1
--iodepth_batch_submit=128  --iodepth_batch_complete_max=128
...
   iops        : min=113589, max=120554, avg=116073.72, stdev=1334.46,
samples=120
...
--

As you can see we have lost almost 50% of our IOPS.

Comparing cpu time and context switches we see that in the bad case we are
context switching a lot more. Overall the core is running at 100% in the bad
case while only at something like 50% in the good case.

no-cgroup: task clock of fio:

--
perf stat -e task-clock -p 27393 -- sleep 1

 Performance counter stats for process id '27393':

            442.62 msec task-clock                       #    0.442
CPUs utilized

       1.002110208 seconds time elapsed
--

no cgroup: context switches on that core:

--
perf stat -e context-switches -C 11  -- sleep 1

 Performance counter stats for 'CPU(s) 11':

            103001      context-switches

       1.001048841 seconds time elapsed
--

Using the cgroup: task clock of fio:

--
perf stat -e task-clock -p 27456 -- sleep 1

 Performance counter stats for process id '27456':

            695.30 msec task-clock                       #    0.695
CPUs utilized

       1.001112431 seconds time elapsed
--

Using the cgroup: context switches on that core:

--
perf stat -e context-switches -C 11  -- sleep 1

 Performance counter stats for 'CPU(s) 11':

            243755      context-switches

       1.001096517 seconds time elapsed
--

So we are doing about 2.5x more context switches in the bad case. Doing the math
at about ~120k IOPS we see that for every IOP we are doing two interrupts (in
and out).

Finally we can also look at some perf sched traces to get an idea for what is
happening (sched_stat_runtime calls omitted):

The general pattern in the good case seems to be:

--
fio 28143 [011]  2038.648954:       sched:sched_waking:
comm=kworker/11:68 pid=27489 prio=120 target_cpu=011
        ffffffff9f0d7ba3 try_to_wake_up+0x2b3 ([kernel.kallsyms])
        ffffffff9f0d7ba3 try_to_wake_up+0x2b3 ([kernel.kallsyms])
        ffffffff9f0b91d5 __queue_work+0x1d5 ([kernel.kallsyms])
        ffffffff9f0b93a4 queue_work_on+0x24 ([kernel.kallsyms])
        ffffffff9f3bb04c iomap_dio_bio_end_io+0x8c ([kernel.kallsyms])
        ffffffff9f53749d blk_mq_end_request_batch+0xfd ([kernel.kallsyms])
        ffffffff9f7198df nvme_irq+0x7f ([kernel.kallsyms])
        ffffffff9f113956 __handle_irq_event_percpu+0x46 ([kernel.kallsyms])
        ffffffff9f113b14 handle_irq_event+0x34 ([kernel.kallsyms])
        ffffffff9f118257 handle_edge_irq+0x87 ([kernel.kallsyms])
        ffffffff9f033eee __common_interrupt+0x3e ([kernel.kallsyms])
        ffffffff9fa023ab common_interrupt+0x7b ([kernel.kallsyms])
        ffffffff9fc00da2 asm_common_interrupt+0x22 ([kernel.kallsyms])
        ffffffff9f297a4b internal_get_user_pages_fast+0x10b ([kernel.kallsyms])
        ffffffff9f591bdb __iov_iter_get_pages_alloc+0xdb ([kernel.kallsyms])
        ffffffff9f591ef9 iov_iter_get_pages2+0x19 ([kernel.kallsyms])
        ffffffff9f5269af __bio_iov_iter_get_pages+0x5f ([kernel.kallsyms])
        ffffffff9f526d6d bio_iov_iter_get_pages+0x1d ([kernel.kallsyms])
        ffffffff9f3ba578 iomap_dio_bio_iter+0x288 ([kernel.kallsyms])
        ffffffff9f3bab72 __iomap_dio_rw+0x3e2 ([kernel.kallsyms])
        ffffffff9f3baf8e iomap_dio_rw+0xe ([kernel.kallsyms])
        ffffffff9f45ff58 xfs_file_dio_write_aligned+0x98 ([kernel.kallsyms])
        ffffffff9f460644 xfs_file_write_iter+0xc4 ([kernel.kallsyms])
        ffffffff9f39c876 aio_write+0x116 ([kernel.kallsyms])
        ffffffff9f3a034e io_submit_one+0xde ([kernel.kallsyms])
        ffffffff9f3a0960 __x64_sys_io_submit+0x80 ([kernel.kallsyms])
        ffffffff9fa01135 do_syscall_64+0x35 ([kernel.kallsyms])
        ffffffff9fc00126 entry_SYSCALL_64_after_hwframe+0x6e ([kernel.kallsyms])
                   3ee5d syscall+0x1d (/usr/lib64/libc.so.6)
              2500000025 [unknown] ([unknown])

fio 28143 [011]  2038.648974:       sched:sched_switch: prev_comm=fio
prev_pid=28143 prev_prio=120 prev_state=R ==> next_comm=kworker/11:68
next_pid=27489 next_prio=120
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d3aa schedule+0x5a ([kernel.kallsyms])
        ffffffff9f135a36 exit_to_user_mode_prepare+0xa6 ([kernel.kallsyms])
        ffffffff9fa050fd syscall_exit_to_user_mode+0x1d ([kernel.kallsyms])
        ffffffff9fa01142 do_syscall_64+0x42 ([kernel.kallsyms])
        ffffffff9fc00126 entry_SYSCALL_64_after_hwframe+0x6e ([kernel.kallsyms])
                   3ee5d syscall+0x1d (/usr/lib64/libc.so.6)
              2500000025 [unknown] ([unknown])

kworker/11:68-d 27489 [011]  2038.648984:       sched:sched_switch:
prev_comm=kworker/11:68 prev_pid=27489 prev_prio=120 prev_state=I ==>
next_comm=fio next_pid=28143 next_prio=120
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d3aa schedule+0x5a ([kernel.kallsyms])
        ffffffff9f0ba249 worker_thread+0xb9 ([kernel.kallsyms])
        ffffffff9f0c1559 kthread+0xd9 ([kernel.kallsyms])
        ffffffff9f001e02 ret_from_fork+0x22 ([kernel.kallsyms])
--

fio is busy submitting aio events and gets interrupted from the nvme interrupts
at which point control is yielded to the dio thread which handles the completion
and yields back to fio.

Looking at the bad case there now seems to be some form of ping pong:

--
fio 28517 [011]  2702.018634:       sched:sched_switch: prev_comm=fio
prev_pid=28517 prev_prio=120 prev_state=S ==> next_comm=kworker/11:68
next_pid=27489 next_prio=120
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d3aa schedule+0x5a ([kernel.kallsyms])
        ffffffff9f39de89 read_events+0x119 ([kernel.kallsyms])
        ffffffff9f39e042 do_io_getevents+0x72 ([kernel.kallsyms])
        ffffffff9f39e689 __x64_sys_io_getevents+0x59 ([kernel.kallsyms])
        ffffffff9fa01135 do_syscall_64+0x35 ([kernel.kallsyms])
        ffffffff9fc00126 entry_SYSCALL_64_after_hwframe+0x6e ([kernel.kallsyms])
                   3ee5d syscall+0x1d (/usr/lib64/libc.so.6)
             11300000113 [unknown] ([unknown])

kworker/11:68+d 27489 [011]  2702.018639:       sched:sched_waking:
comm=fio pid=28517 prio=120 target_cpu=011
        ffffffff9f0d7ba3 try_to_wake_up+0x2b3 ([kernel.kallsyms])
        ffffffff9f0d7ba3 try_to_wake_up+0x2b3 ([kernel.kallsyms])
        ffffffff9f0fa9d1 autoremove_wake_function+0x11 ([kernel.kallsyms])
        ffffffff9f0fbb90 __wake_up_common+0x80 ([kernel.kallsyms])
        ffffffff9f0fbd23 __wake_up_common_lock+0x83 ([kernel.kallsyms])
        ffffffff9f39f9df aio_complete_rw+0xef ([kernel.kallsyms])
        ffffffff9f0b9c35 process_one_work+0x1e5 ([kernel.kallsyms])
        ffffffff9f0ba1e0 worker_thread+0x50 ([kernel.kallsyms])
        ffffffff9f0c1559 kthread+0xd9 ([kernel.kallsyms])
        ffffffff9f001e02 ret_from_fork+0x22 ([kernel.kallsyms])

kworker/11:68+d 27489 [011]  2702.018642:       sched:sched_switch:
prev_comm=kworker/11:68 prev_pid=27489 prev_prio=120 prev_state=R+ ==>
next_comm=fio next_pid=28517 next_prio=120
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d002 __schedule+0x282 ([kernel.kallsyms])
        ffffffff9fa0d4cb preempt_schedule_common+0x1b ([kernel.kallsyms])
        ffffffff9fa0d51c __cond_resched+0x1c ([kernel.kallsyms])
        ffffffff9f0b9c56 process_one_work+0x206 ([kernel.kallsyms])
        ffffffff9f0ba1e0 worker_thread+0x50 ([kernel.kallsyms])
        ffffffff9f0c1559 kthread+0xd9 ([kernel.kallsyms])
        ffffffff9f001e02 ret_from_fork+0x22 ([kernel.kallsyms])
--

fio is sleeping in io_getevents waiting for all events to complete. The dio
worker thread gets scheduled in handling aio completions one by one. This allows
fio to wake as there are some amount of completions ready for it to process. Now
because of the high weight of the fio process the kernel worker only gets a
short amount of runtime and gets preempted by the scheduler yielding back to fio
(notice the stack and R+ in the above trace). However because fio is waiting for
all aios to complete it wakes up and goes straight back to sleep again. This
ping pong continues.

Note that because we run with `--iodepth_batch_submit=128
--iodepth_batch_complete_max=128` io_getevents won't actually return to
userspace until all 128 events have completed. However even if we were to return
after just one event (i.e.: calling io_getevents with min_nr=1) that might just
make it worse as the application spin loop around io_getevents is likely even
more expensive.

The issue can be avoided by renicing the dio kernel worker thread to a higher
priority. However from my understanding there is no way to do this reliably as
these worker threads are ephemeral?

I am wondering whether you have any thoughts on the above and/or can think of
any workarounds that we could apply?

Note I did also test this on Ubuntu 24.04 / Linux 6.8 which seems to
behave a lot
better. I am only seeing a 1.2-1.3x regression in the amount of context
switches in the bad case. I assume the new EEVDF scheduler handles this scenario
better? So this might be a solution but it will obviously take a while until
that kernel version is more widespread in production deployments.

Possibly also commit 71eb6b6b0ba93b1467bccff57b5de746b09113d2 (fs/aio: obey
min_nr when doing wakeups) is helping here but as described previously avoiding
the wakupe if min_nr isn't reached doesn't help in more realistic scenarios
where we are polling with min_nr=1 anyway.

Thanks,
Stephan

