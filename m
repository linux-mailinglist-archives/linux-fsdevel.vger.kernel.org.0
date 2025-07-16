Return-Path: <linux-fsdevel+bounces-55187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEAFB07F1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 22:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5553D4A6E18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E7289E15;
	Wed, 16 Jul 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdFPs7UK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365944A06;
	Wed, 16 Jul 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698848; cv=none; b=uMylxamQLhkb9xJPTJRiY6ZqQRFIoj+BaCgGRSLoWqD9vDWjN95w/0c00uk78e3XVOyzFza4mbxYHKaBKJTq5zFKL5EME4ZV9xzbJtssbThC3GOScx6ON+qYzNc2gB0PvgPZ2a/UU+e0gvHjre1Y5q3p27fwMeSGjr8OZqR1dpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698848; c=relaxed/simple;
	bh=3T4TM5zPbTcVbBZ0F/1W4imNxL6RtnT1EAGJE6R3rDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBWOtvqOYXwok4ama7NLqPMEsWlxJbmcLZJG0dySOV46iJ3BY8U+eI2wMtowXD826Dij9705/1Di6b+QdHRxqpsqw94Ykf3f9LpJks0WBdPoyILLdBCtNVCR4G5sxNTMJHfytDqgOLDkYvQ6pFNuyCNUqehLxQYWVTck4H0RrSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdFPs7UK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-313cde344d4so353223a91.0;
        Wed, 16 Jul 2025 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752698846; x=1753303646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfwkMeGXYqzQAGqk8KkRHnOsvdBHdZtOcGBtO2IOIII=;
        b=OdFPs7UKPkewgTF9FdQexnIWsVT6FIs9cu40dA0pAxhjtSJpLgLuoloCs+r9A0EdSX
         gspb57WdMvqkpQzf7lJ7IxWKN9Bh++CGzAR09BF1PrKWopYmkDL94k4HASi42aQnzYba
         GdUuTK5yx5XQ2YU095mzidfSYvaiv10fzNFgevA67MyEbK/mzOWIRBE3C+WqGBALko8v
         HkRVoeAN6hb9gxctSqEeEAUqQcbwE1UN3uamgbWrdFQIZm2OXrzLNpAs6qao9+BtXrV0
         Ot/ki9NYQ+s+LJXahbuZAE75efwWNoHYAoHBMd8Ss2cUUTLV0VXRd9jeYt/MwqLkQeNv
         Qc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752698846; x=1753303646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfwkMeGXYqzQAGqk8KkRHnOsvdBHdZtOcGBtO2IOIII=;
        b=Tzh2N7sf9WSkefJMSi/9kWK1uLjEtdxK6yF5rK3QLp1WPAzteZeicvhXprWphNUErg
         E0SAMkiwTnYDkJ4PAD/57vtu0IZLH/CGLwgUsl42WOagpxoBqIUoaQcZPRRh9XlGy+iC
         Z78kbFvvj0ZabbMcV4iowJGc+U60viQKuFC/izYe4GeV2FQhQWv84jfkxGXDxy8be4Af
         icNhW7HWSOK+NdxQnE8SjFrS+NYSoWOEbZpZuuqS1YaCEIRwpPlc2SkkFjKiJnHHHFo2
         gQGvqlTIHsbK3VShJqoPalruSL5v32lqZWR5eHJWY6o/r1bJbHOoTL4ZEK1hPRdh3Jh8
         21fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWZ/7o5vjr5Sbl+MlJ3/iS3pl6oXpg0mbax8CQCtzwscSKksZoJSeGvSECF2vQeQBcx7ZUN837I573+iCt@vger.kernel.org, AJvYcCUYOcXSKlEC4qjWlnDTOyl/A1VqwMTzf89LorCCDKxAYmpmrGyi1ptR2Uk5zkpTqv+O34bZd7dXsJdsKRRkX7OZuQ==@vger.kernel.org, AJvYcCUlmRD/a2hZVmwoLPu6YWgiZf81TW8aznmJL4dUH9xbSDxyXeCdCLvX6U6qNnGQU7P2LcY=@vger.kernel.org, AJvYcCWB1QgpCz9EZPXBWaZ/WDIHE28c6T1+uRKQmY1xBFvxmZj2hKVgkbTTe1lPkAmhZc7M9GzzUv4hLwAn5o/uIw==@vger.kernel.org, AJvYcCWrMCdHIynHUMsEql1OGLj8ER3h5cZTq5V3KpTwbx431GqMzQkL+QrhjYd0rod66SSvtLSlupVkq7iCI+4XYgnPCKcn@vger.kernel.org
X-Gm-Message-State: AOJu0YybPeTUKpQaTJtbp5bvkJFLCRsZp7xiA971RVlu522zD+JMkg+L
	iUZ2P01XVvgqZmh2KsmDVt8nQ5VtKCA3j86vYSW0Eps9dl+pD4906HufELktbOiqEki1zD1+mrB
	5rl2GlXCF7pJDuq//TJcZdFaF3IJaUfc=
X-Gm-Gg: ASbGncsIDssXzJkilc2pCrDvo1SmtoX8DVhha6ul23GUkpfIYAosqWb06R41ki5Y0tZ
	SpzO1ptfaECG6kxZprThrIgFBzodo/Dp8UXjYLSlDrp4PROQESOCj4VfU3Ng0yHisjTU256bivC
	fEDrJiE8SRWNHila/KWVeHXyF/N6hnFcFg8Cl5QCjN6rzacR4MCsH1Nn4Pw83Rjr4Sl/bbobS30
	vI0xw==
X-Google-Smtp-Source: AGHT+IFeFCZTHwQq6CWNE4DeVyMG40lwDfFF0lAyew534oOu3sXQDYX/YiTMj9puYV6XchTRtToJMlDgmQp2I20b5wI=
X-Received: by 2002:a17:90b:270b:b0:312:e8ed:763 with SMTP id
 98e67ed59e1d1-31c9f42412cmr4868436a91.22.1752698846319; Wed, 16 Jul 2025
 13:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
 <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com> <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com>
In-Reply-To: <c6a0b682-a1a5-f19c-acf5-5b08abf80a24@igalia.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Jul 2025 13:47:14 -0700
X-Gm-Features: Ac12FXzdMIUrwTNSRAbXY9z4R-Vg46K1zjuhZoodouCKkxjzhdaHWwCSZWFsfng
Message-ID: <CAEf4BzaJiCLH8nwWa5eM4D+n1nyCn3X-v0+W4-CwLg7hB2Wthg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Bhupesh Sharma <bhsharma@igalia.com>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:18=E2=80=AFPM Bhupesh Sharma <bhsharma@igalia.com=
> wrote:
>
> On 7/16/25 11:40 PM, Andrii Nakryiko wrote:
> > On Wed, Jul 16, 2025 at 5:40=E2=80=AFAM Bhupesh <bhupesh@igalia.com> wr=
ote:
> >> Historically due to the 16-byte length of TASK_COMM_LEN, the
> >> users of 'tsk->comm' are restricted to use a fixed-size target
> >> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
> >>
> >> To fix the same, Kees suggested in [1] that we can replace tsk->comm,
> >> with tsk->comm_str, inside 'task_struct':
> >>         union {
> >>                 char    comm_str[TASK_COMM_EXT_LEN];
> >>         };
> >>
> >> where TASK_COMM_EXT_LEN is 64-bytes.
> > Do we absolutely have to rename task->comm field? I understand as an
> > intermediate step to not miss any existing users in the kernel
> > sources, but once that all is done, we can rename that back to comm,
> > right?
> >
> > The reason I'm asking is because accessing task->comm is *very common*
> > with all sorts of BPF programs and scripts. Yes, we have way to deal
> > with that with BPF CO-RE, but every single use case would need to be
> > updated now to work both with task->comm name on old kernels and
> > task->comm_str on new kernels (because BPF programs are written in
> > more or less kernel version agnostic way, so they have to handle many
> > kernel releases).
> >
> > So, unless absolutely necessary, can we please keep the field name the
> > same? Changing the size of that field is not really a problem for BPF,
> > so no objections against that.
>
> So, as a background we have had several previous discussions regarding
> renaming the 'tsk->comm' to 'task->comm_str' on the list (please see [1]
> and [2] for details), and as per Kees's recommendations we have taken
> this approach in the v5 patchset (may be Kees can add further details if
> I have missed adding something in the log message above).
>
> That being said, ideally one would not like to break any exiting ABI

kernel-internal data structures are not ABI to BPF programs, even
though they do look into kernel internals routinely for observability
and other reasons, so there is no ABI/API stability issue here.

Having said that, unless absolutely necessary, renaming something so
commonly used as task->comm is just an unnecessary widespread
disruption, which ideally we just avoid, unless absolutely necessary.


> (which includes existing / older BPF programs). I was having a look at
> the BPF CO_RE reference guide (see [3]), and was able to make out that
> BPF CO_RE has a definition of |s||truct task_struct|which doesn't need
> to match the kernel's struct task_struct definition exactly (as [3]
> mentions -> only a necessary subset of fields have to be present and
> compatible):
>
> |struct task_struct { intpid; charcomm[16]; struct
> task_struct*group_leader; } __attribute__((preserve_access_index)); |
>
> So, if we add a check here to add  '|charcomm[16]' or||charcomm_str[16]'
> to BPF CO RE's internal 'struct task_struct' on basis of the underlying
> kernel version being used (something like using  'KERNEL_VERSION(x, y,
> 0)' for example), will that suffice? I have ||used and seen these checks
> being used in the user-space applications (for example, see [4]) at
> several occasions.
>

It's simpler on BPF side, we can check the existence of task_struct's
comm field, and handle either task->comm or task->comm_str
accordingly. This has been done many times for various things that
evolved in the kernel.

But given how frequently task->comm is referenced (pretty much any
profiler or tracer will capture this), it's just the widespread nature
of accessing task->comm in BPF programs/scripts that will cause a lot
of adaptation churn. And given the reason for renaming was to catch
missing cases during refactoring, my ask was to do this renaming
locally, validate all kernel code was modified, and then switch the
field name back to "comm" (which you already did, so the remaining
part would be just to rename comm_str back to comm). Unless I'm
missing something else, of course.

> Please let me know your views.
>
> |[1]. https://lore.kernel.org/all/202505222041.B639D482FB@keescook/
> [2].
> https://lore.kernel.org/all/ba4ddf27-91e7-0ecc-95d5-c139f6978812@igalia.c=
om/
> [3]. https://nakryiko.com/posts/bpf-core-reference-guide/
> [4].
> https://github.com/crash-utility/crash/blob/master/memory_driver/crash.c#=
L41C25-L41C49
>
> Thanks.
>
> >> And then modify 'get_task_comm()' to pass 'tsk->comm_str'
> >> to the existing users.
> >>
> >> This would mean that ABI is maintained while ensuring that:
> >>
> >> - Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->co=
mm_str'
> >>    truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain AB=
I,
> >> - New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
> >>   'tsk->comm_str' supported for a maximum of 'TASK_COMM_EXTLEN' (64-by=
tes).
> >>
> >> Note, that the existing users have not been modified to migrate to
> >> 'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
> >> dealing with only a 'TASK_COMM_LEN' long 'tsk->comm_str'.
> >>
> >> [1]. https://lore.kernel.org/all/202505231346.52F291C54@keescook/
> >>
> >> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> >> ---
> >>   arch/arm64/kernel/traps.c        |  2 +-
> >>   arch/arm64/kvm/mmu.c             |  2 +-
> >>   block/blk-core.c                 |  2 +-
> >>   block/bsg.c                      |  2 +-
> >>   drivers/char/random.c            |  2 +-
> >>   drivers/hid/hid-core.c           |  6 +++---
> >>   drivers/mmc/host/tmio_mmc_core.c |  6 +++---
> >>   drivers/pci/pci-sysfs.c          |  2 +-
> >>   drivers/scsi/scsi_ioctl.c        |  2 +-
> >>   drivers/tty/serial/serial_core.c |  2 +-
> >>   drivers/tty/tty_io.c             |  8 ++++----
> >>   drivers/usb/core/devio.c         | 16 ++++++++--------
> >>   drivers/usb/core/message.c       |  2 +-
> >>   drivers/vfio/group.c             |  2 +-
> >>   drivers/vfio/vfio_iommu_type1.c  |  2 +-
> >>   drivers/vfio/vfio_main.c         |  2 +-
> >>   drivers/xen/evtchn.c             |  2 +-
> >>   drivers/xen/grant-table.c        |  2 +-
> >>   fs/binfmt_elf.c                  |  2 +-
> >>   fs/coredump.c                    |  4 ++--
> >>   fs/drop_caches.c                 |  2 +-
> >>   fs/exec.c                        |  8 ++++----
> >>   fs/ext4/dir.c                    |  2 +-
> >>   fs/ext4/inode.c                  |  2 +-
> >>   fs/ext4/namei.c                  |  2 +-
> >>   fs/ext4/super.c                  | 12 ++++++------
> >>   fs/hugetlbfs/inode.c             |  2 +-
> >>   fs/ioctl.c                       |  2 +-
> >>   fs/iomap/direct-io.c             |  2 +-
> >>   fs/jbd2/transaction.c            |  2 +-
> >>   fs/locks.c                       |  2 +-
> >>   fs/netfs/internal.h              |  2 +-
> >>   fs/proc/base.c                   |  2 +-
> >>   fs/read_write.c                  |  2 +-
> >>   fs/splice.c                      |  2 +-
> >>   include/linux/coredump.h         |  2 +-
> >>   include/linux/filter.h           |  2 +-
> >>   include/linux/ratelimit.h        |  2 +-
> >>   include/linux/sched.h            | 11 ++++++++---
> >>   init/init_task.c                 |  2 +-
> >>   ipc/sem.c                        |  2 +-
> >>   kernel/acct.c                    |  2 +-
> >>   kernel/audit.c                   |  4 ++--
> >>   kernel/auditsc.c                 | 10 +++++-----
> >>   kernel/bpf/helpers.c             |  2 +-
> >>   kernel/capability.c              |  4 ++--
> >>   kernel/cgroup/cgroup-v1.c        |  2 +-
> >>   kernel/cred.c                    |  4 ++--
> >>   kernel/events/core.c             |  2 +-
> >>   kernel/exit.c                    |  6 +++---
> >>   kernel/fork.c                    |  9 +++++++--
> >>   kernel/freezer.c                 |  4 ++--
> >>   kernel/futex/waitwake.c          |  2 +-
> >>   kernel/hung_task.c               | 10 +++++-----
> >>   kernel/irq/manage.c              |  2 +-
> >>   kernel/kthread.c                 |  2 +-
> >>   kernel/locking/rtmutex.c         |  2 +-
> >>   kernel/printk/printk.c           |  2 +-
> >>   kernel/sched/core.c              | 22 +++++++++++-----------
> >>   kernel/sched/debug.c             |  4 ++--
> >>   kernel/signal.c                  |  6 +++---
> >>   kernel/sys.c                     |  6 +++---
> >>   kernel/sysctl.c                  |  2 +-
> >>   kernel/time/itimer.c             |  4 ++--
> >>   kernel/time/posix-cpu-timers.c   |  2 +-
> >>   kernel/tsacct.c                  |  2 +-
> >>   kernel/workqueue.c               |  6 +++---
> >>   lib/dump_stack.c                 |  2 +-
> >>   lib/nlattr.c                     |  6 +++---
> >>   mm/compaction.c                  |  2 +-
> >>   mm/filemap.c                     |  4 ++--
> >>   mm/gup.c                         |  2 +-
> >>   mm/memfd.c                       |  2 +-
> >>   mm/memory-failure.c              | 10 +++++-----
> >>   mm/memory.c                      |  2 +-
> >>   mm/mmap.c                        |  4 ++--
> >>   mm/oom_kill.c                    | 18 +++++++++---------
> >>   mm/page_alloc.c                  |  4 ++--
> >>   mm/util.c                        |  2 +-
> >>   net/core/sock.c                  |  2 +-
> >>   net/dns_resolver/internal.h      |  2 +-
> >>   net/ipv4/raw.c                   |  2 +-
> >>   net/ipv4/tcp.c                   |  2 +-
> >>   net/socket.c                     |  2 +-
> >>   security/lsm_audit.c             |  4 ++--
> >>   85 files changed, 171 insertions(+), 161 deletions(-)
> >>
> > [...]
>

