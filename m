Return-Path: <linux-fsdevel+bounces-55183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8080AB07C89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 20:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47C8189F6F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BC290D97;
	Wed, 16 Jul 2025 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJFiJm8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956428FA93;
	Wed, 16 Jul 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752689448; cv=none; b=Cf184Ir90WIbiQeXc09aOD9qd6QTkwvp6FionILcwUnBcStjG7LAAyd2dOm7oAqrkiQK5VxZ+GJYWdXFo6hHKQEuelaRqfIVVitCgvJvY3Xi9V3i7y2eu5R/kaxZli5/f7P9JfoM88gQMDaNKlH3ZAjuvZ16LXvHBB2S3eEqQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752689448; c=relaxed/simple;
	bh=PAXQZ4RAY5sxHa0qn+/IPFA/Kj1m4XLj8ZNFqYjocbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JfBjpq42mvDC7/T3OBqGir8NJilCyexz8i4g9M+prSCDm0/7jOBVqZvOKouwzqkrLN2lfF0f+jaUHuo46Rgep0SONcPwpsoEzmpHY4PDq4e0eJrZDoagPb/K82xJMqEsFmg9xLKPJhSOtobTBRZdV1zthUnJprK62IPUNUFIrcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJFiJm8I; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31329098ae8so186156a91.1;
        Wed, 16 Jul 2025 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752689446; x=1753294246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nPLDzt8OaNCeZXVo+jqqenY1sk4GVXTkfMw9ymIdMY=;
        b=MJFiJm8IFWv42xgZRlrVsXrr7OWhzKiyJPPURKQMtRXQpN+i2K0vRqz2oyJmqlUBsk
         jsIdpaoHBir3hEygYmdWhk2v/hqc1BoL+QSUMlaerh90nrjRzWvOab8dl5FFxcolMvft
         j8/d5NVKLk7RW+yX+P2pTy9qGqYwxVTm/Iu5CkBch04aXKZi+SIOg4hDSR7sUcXfrFnT
         4yv5rGWlJarh3CYGM70+IKhdAnGzf+so9MAjngSqJ2/dtgAMDmou3zQqsIbyzqPSv4iA
         pVltpXwOJppz/7/qF4L0FTiOyhVbGcAK8mAPiGfn9rORb9PMV2utNvFVkSC3bwcd1ipR
         Pgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752689446; x=1753294246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nPLDzt8OaNCeZXVo+jqqenY1sk4GVXTkfMw9ymIdMY=;
        b=FubksUT17daCHLHwIXXtaw1ncvJpnDTXRnubt2f4Ze3uga5JF5CseobH8IBHKmLRww
         tx40wreXvMkU0v0rcu4YIIIP9tuE95RhHNBpTwiZy+psjIkajxJW37zrelB+Tg6Rj6q6
         ey1ApSN6nSjKleIVYYWQcS4qidAbnKxQTCI9cUR5mD38T7QLsh7N8ZreRStMPMYLipo9
         LTE06D8qHWSO4KZaUxvj35iZPSpuujWANA4IYS4U5Nci1qDqIJxPeg3AeuIHITK7xmd0
         ErF3k7Wxlz9CdJnmE9+xkYu5PJ3ecZ1Lg96HWjcuHsvlTtCxvZQlo6S/zWnohADmfQp6
         vy2w==
X-Forwarded-Encrypted: i=1; AJvYcCWPTa9nMHydTK24xx9ZLU6NSzJZKQ7/V8AO2b6CdKwDP3WIcs7euFuRSmruzdoEbzDscdPduDS2uPCB1l5xh8IKyA==@vger.kernel.org, AJvYcCWoBQCpUcCtXkdoxZxPnsjjLfk1dlCQ5Imvye9sk4fR1wBLaImCjUp+0/aYwUy1LCF0posakSFBBiPXsZwQbzw0n+gX@vger.kernel.org, AJvYcCX9dXv2oyo9H1FHHLYtr94db932msFePf2QJKzPSG8Rz/QHam7lUZXvJ7PLKhl6F+GR43lXBYl3PV63QIqn@vger.kernel.org, AJvYcCXUxjNCRUCgreBIQkCsa+4MGNlS1j1MpYgeeTJStRRsb9Wz6JoLi9/yZunGwltgd54feF0=@vger.kernel.org, AJvYcCXgulG4zyHOzxboGncngH68Mxlzo1oO44ww0KtRuwOVAcXl7LtT6s4RsFm6mZv/ocU//UatNolaPWaSzkEcjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/iDa8YdSyiRgyqW1Tj09nCGijEHSbbXEdc2AovWBe4qj3z23/
	tA0UG1QFw+17hF4kxNvqKOe9xCPch3gZVxWbfhkuVu3Pi7HMgQaibB5+u5P2LDagVeUQMradK1I
	prFpNPtIXRu/PNIzoqNGBoLhGdA8+TwM=
X-Gm-Gg: ASbGncv6oYV0O44is0EFF80XJzBzk2urYYhuYmUlz42WrIFGwwTdQ7kMpuIROXd+4s9
	sLT8Y53qmoJLNukBvYJHl2m6IFKla0TJPlHU4fBS8VxK0M9tVmlTpz4k/r27pCsZYcBwr02X3db
	Lqj7WYb1z29dIKF2ajY6n5y/dUIRvNJ36FHYx7xe750scjWj6d4upeIXZm7ej+6cJdg9xp3hGwJ
	WFGLg==
X-Google-Smtp-Source: AGHT+IHJlbpu3WRcygpiaRDlDw/e+VIPCJBjgw4iqNxFgRP6FRabw5/rvWyqRZpyKT6y3Ac9F3Ie0dVmp6jE5D45Muw=
X-Received: by 2002:a17:90b:4f4d:b0:31a:8dc4:b5bf with SMTP id
 98e67ed59e1d1-31caea3feaamr467632a91.17.1752689445698; Wed, 16 Jul 2025
 11:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123916.511889-1-bhupesh@igalia.com> <20250716123916.511889-4-bhupesh@igalia.com>
In-Reply-To: <20250716123916.511889-4-bhupesh@igalia.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 16 Jul 2025 11:10:33 -0700
X-Gm-Features: Ac12FXxkQF7EcMzWycD-nloRUfOkqsw4tlKLzrY1mRXYqv2TM-LS0bucIaJdoMY
Message-ID: <CAEf4BzaGRz6A1wzBa2ZyQWY_4AvUHvLgBF36iCxc9wJJ1ppH0g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] treewide: Switch from tsk->comm to tsk->comm_str
 which is 64 bytes long
To: Bhupesh <bhupesh@igalia.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 5:40=E2=80=AFAM Bhupesh <bhupesh@igalia.com> wrote:
>
> Historically due to the 16-byte length of TASK_COMM_LEN, the
> users of 'tsk->comm' are restricted to use a fixed-size target
> buffer also of TASK_COMM_LEN for 'memcpy()' like use-cases.
>
> To fix the same, Kees suggested in [1] that we can replace tsk->comm,
> with tsk->comm_str, inside 'task_struct':
>        union {
>                char    comm_str[TASK_COMM_EXT_LEN];
>        };
>
> where TASK_COMM_EXT_LEN is 64-bytes.

Do we absolutely have to rename task->comm field? I understand as an
intermediate step to not miss any existing users in the kernel
sources, but once that all is done, we can rename that back to comm,
right?

The reason I'm asking is because accessing task->comm is *very common*
with all sorts of BPF programs and scripts. Yes, we have way to deal
with that with BPF CO-RE, but every single use case would need to be
updated now to work both with task->comm name on old kernels and
task->comm_str on new kernels (because BPF programs are written in
more or less kernel version agnostic way, so they have to handle many
kernel releases).

So, unless absolutely necessary, can we please keep the field name the
same? Changing the size of that field is not really a problem for BPF,
so no objections against that.

>
> And then modify 'get_task_comm()' to pass 'tsk->comm_str'
> to the existing users.
>
> This would mean that ABI is maintained while ensuring that:
>
> - Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm_=
str'
>   truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
> - New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
>  'tsk->comm_str' supported for a maximum of 'TASK_COMM_EXTLEN' (64-bytes)=
.
>
> Note, that the existing users have not been modified to migrate to
> 'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
> dealing with only a 'TASK_COMM_LEN' long 'tsk->comm_str'.
>
> [1]. https://lore.kernel.org/all/202505231346.52F291C54@keescook/
>
> Signed-off-by: Bhupesh <bhupesh@igalia.com>
> ---
>  arch/arm64/kernel/traps.c        |  2 +-
>  arch/arm64/kvm/mmu.c             |  2 +-
>  block/blk-core.c                 |  2 +-
>  block/bsg.c                      |  2 +-
>  drivers/char/random.c            |  2 +-
>  drivers/hid/hid-core.c           |  6 +++---
>  drivers/mmc/host/tmio_mmc_core.c |  6 +++---
>  drivers/pci/pci-sysfs.c          |  2 +-
>  drivers/scsi/scsi_ioctl.c        |  2 +-
>  drivers/tty/serial/serial_core.c |  2 +-
>  drivers/tty/tty_io.c             |  8 ++++----
>  drivers/usb/core/devio.c         | 16 ++++++++--------
>  drivers/usb/core/message.c       |  2 +-
>  drivers/vfio/group.c             |  2 +-
>  drivers/vfio/vfio_iommu_type1.c  |  2 +-
>  drivers/vfio/vfio_main.c         |  2 +-
>  drivers/xen/evtchn.c             |  2 +-
>  drivers/xen/grant-table.c        |  2 +-
>  fs/binfmt_elf.c                  |  2 +-
>  fs/coredump.c                    |  4 ++--
>  fs/drop_caches.c                 |  2 +-
>  fs/exec.c                        |  8 ++++----
>  fs/ext4/dir.c                    |  2 +-
>  fs/ext4/inode.c                  |  2 +-
>  fs/ext4/namei.c                  |  2 +-
>  fs/ext4/super.c                  | 12 ++++++------
>  fs/hugetlbfs/inode.c             |  2 +-
>  fs/ioctl.c                       |  2 +-
>  fs/iomap/direct-io.c             |  2 +-
>  fs/jbd2/transaction.c            |  2 +-
>  fs/locks.c                       |  2 +-
>  fs/netfs/internal.h              |  2 +-
>  fs/proc/base.c                   |  2 +-
>  fs/read_write.c                  |  2 +-
>  fs/splice.c                      |  2 +-
>  include/linux/coredump.h         |  2 +-
>  include/linux/filter.h           |  2 +-
>  include/linux/ratelimit.h        |  2 +-
>  include/linux/sched.h            | 11 ++++++++---
>  init/init_task.c                 |  2 +-
>  ipc/sem.c                        |  2 +-
>  kernel/acct.c                    |  2 +-
>  kernel/audit.c                   |  4 ++--
>  kernel/auditsc.c                 | 10 +++++-----
>  kernel/bpf/helpers.c             |  2 +-
>  kernel/capability.c              |  4 ++--
>  kernel/cgroup/cgroup-v1.c        |  2 +-
>  kernel/cred.c                    |  4 ++--
>  kernel/events/core.c             |  2 +-
>  kernel/exit.c                    |  6 +++---
>  kernel/fork.c                    |  9 +++++++--
>  kernel/freezer.c                 |  4 ++--
>  kernel/futex/waitwake.c          |  2 +-
>  kernel/hung_task.c               | 10 +++++-----
>  kernel/irq/manage.c              |  2 +-
>  kernel/kthread.c                 |  2 +-
>  kernel/locking/rtmutex.c         |  2 +-
>  kernel/printk/printk.c           |  2 +-
>  kernel/sched/core.c              | 22 +++++++++++-----------
>  kernel/sched/debug.c             |  4 ++--
>  kernel/signal.c                  |  6 +++---
>  kernel/sys.c                     |  6 +++---
>  kernel/sysctl.c                  |  2 +-
>  kernel/time/itimer.c             |  4 ++--
>  kernel/time/posix-cpu-timers.c   |  2 +-
>  kernel/tsacct.c                  |  2 +-
>  kernel/workqueue.c               |  6 +++---
>  lib/dump_stack.c                 |  2 +-
>  lib/nlattr.c                     |  6 +++---
>  mm/compaction.c                  |  2 +-
>  mm/filemap.c                     |  4 ++--
>  mm/gup.c                         |  2 +-
>  mm/memfd.c                       |  2 +-
>  mm/memory-failure.c              | 10 +++++-----
>  mm/memory.c                      |  2 +-
>  mm/mmap.c                        |  4 ++--
>  mm/oom_kill.c                    | 18 +++++++++---------
>  mm/page_alloc.c                  |  4 ++--
>  mm/util.c                        |  2 +-
>  net/core/sock.c                  |  2 +-
>  net/dns_resolver/internal.h      |  2 +-
>  net/ipv4/raw.c                   |  2 +-
>  net/ipv4/tcp.c                   |  2 +-
>  net/socket.c                     |  2 +-
>  security/lsm_audit.c             |  4 ++--
>  85 files changed, 171 insertions(+), 161 deletions(-)
>

[...]

