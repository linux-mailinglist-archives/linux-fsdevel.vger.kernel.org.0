Return-Path: <linux-fsdevel+bounces-55151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D70FB075DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C0E1892B8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2112F530B;
	Wed, 16 Jul 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Dc82ryHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2A19CC37;
	Wed, 16 Jul 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669597; cv=none; b=lNkD8lHUpNi47qRo0c8ZFeqg/3iPBVuDF5hs6+1m+C06wKbzqNskDPHyfb/xkUFXpyeNJAx7vlXbiM1pYR5DUP8JqBykV/RVmqFmz5ogwBbmK8Ttmpj3u9z6hgFBTeUQhuTAsr1SZDnAI+JveL0tXRk784+n3AYKR+dos5mfZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669597; c=relaxed/simple;
	bh=ciov7ehAjBjREuTpZUcsqXWJtPxPQ5hAirxi/yh5GH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N9FrZM26m8QaTIS8kRmu/gt15RElOemH4HOrabyd75Eq0Sm360782u7dydtOpw5BZq/KJdZdJzA8R4dozmaJiw7iUBSHUNnme2DqLs3tFsFZ6t2wTrJshMlocPH/54Ea3s8INHYUnp+3TskxiGsY1H4MY9DGoATUpr3I5BCAt9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Dc82ryHz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WxtQsAj1GDvGzyz67FLJJ/sJh6tOfzGHe6iz6EfWQaQ=; b=Dc82ryHz4DrgMI1c7c5pAHLF2e
	0UZJw7dqr96ryh4mY4vD50skzSL5q6YCve8aVi+QN1n2TxoChUl32+Rx3E9mlleAlNbKte0ElyEH2
	1vToEsK1Qb+QLlAIlXkiSC0rNNNgJ/vM+lXxgKIrnRfNK5XVz6Hi3Xor1OVuVTWEA87VlcCy4rSiZ
	oY4Elw4TV9wCI+Q1ODazw1rqfuIgghImjpv4DvTX5kyxu4v1yq0Q5uAcL5PGvyCRqLxj+ViE1PDyl
	acHQyWD5QN9bdOW6idXoqgZcFiHcBKUod2DTDilljCy1tQDmJMSjg8jAzCev2dEHdonQoq/egkzs1
	o50Jj01w==;
Received: from [223.233.66.171] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uc1QB-00HJWV-Q0; Wed, 16 Jul 2025 14:39:40 +0200
From: Bhupesh <bhupesh@igalia.com>
To: akpm@linux-foundation.org
Cc: bhupesh@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	oliver.sang@intel.com,
	lkp@intel.com,
	laoar.shao@gmail.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl,
	peterz@infradead.org,
	willy@infradead.org,
	david@redhat.com,
	viro@zeniv.linux.org.uk,
	keescook@chromium.org,
	ebiederm@xmission.com,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	kees@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v5 0/3] Add support for long task name
Date: Wed, 16 Jul 2025 18:09:13 +0530
Message-Id: <20250716123916.511889-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v4:
================
- v4 can be seen here: https://lore.kernel.org/lkml/20250507110444.963779-1-bhupesh@igalia.com/
- As suggested by Kees, replaced tsk->comm with tsk->comm_str, inside 'task_struct'
  where TASK_COMM_EXT_LEN is 64-bytes.

Changes since v3:
================
- v3 can be seen here: https://lore.kernel.org/lkml/20250507110444.963779-1-bhupesh@igalia.com/
- As suggested by Petr and Steven, used 'comm_ext' name instead of
  'real_comm'. Correspondingly the macro name is changed to 'TASK_COMM_EXT_LEN'
  for the 64-byte extended comm.
- Rebased this patchset on linux-next/master, which contain the following patch from
  Steven now:
       155fd6c3e2f0 ("tracing/sched: Use __string() instead of fixed lengths for task->comm")
- Accordingly, v4 drops the changes done for 'trace/sched' events in v3,
  but retains the 'safe' memcpy' changes for other kernel trace users.

Changes since v2:
================
- v2 can be seen here: https://lore.kernel.org/lkml/20250331121820.455916-1-bhupesh@igalia.com/
- As suggested by Yafang and Kees, picked Linus' suggested approach for
  this version (see: <https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/>).
- Dropped kthreads patch from this version. It would be sent out
  separately, if we have a consensus on this approach.

Changes since v1:
================
- v1 can be seen here: https://lore.kernel.org/lkml/20250314052715.610377-1-bhupesh@igalia.com/
- As suggested by Kees, added [PATCH 3/3] to have a consistent
  'full_name' entry inside 'task_struct' which both tasks and
  kthreads can use.
- Fixed the commit message to indicate that the existing ABI
  '/proc/$pid/task/$tid/comm' remains untouched and a parallel
  '/proc/$pid/task/$tid/full_name' ABI for new (interested) users.

While working with user-space debugging tools which work especially
on linux gaming platforms, I found that the task name is truncated due
to the limitation of TASK_COMM_LEN.

Now, during debug tracing, seeing truncated names is not very useful,
especially on gaming platforms where the number of tasks running can
be very high.

This patchset does not touch 'TASK_COMM_LEN' at all, i.e.
'TASK_COMM_LEN' and the 16-byte design remains untouched.

Via this patchset, as Kees suggested 'tsk->comm' is replaced
with 'tsk->comm_str', inside 'task_struct':
       union {
               char    comm_str[TASK_COMM_EXT_LEN];
       };

where TASK_COMM_EXT_LEN is 64-bytes.

And then 'get_task_comm()' to pass 'tsk->comm_str'
to the existing users.

This would mean that ABI is maintained while ensuring that:

- Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm_str'
  truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
- New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
 'tsk->comm_str' supported for a maximum of 'TASK_COMM_EXTLEN' (64-bytes).

Note, that the existing users have not been modified to migrate to
'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
dealing with only a 'TASK_COMM_LEN' long 'tsk->comm_str'.

After this change, gdb is able to show full name of the task, using a
simple app which generates threads with long names [see 1]:
  # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
  # cat log

  NameThatIsTooLongForComm[4662]

[1]. https://github.com/lostgoat/tasknames

Bhupesh (3):
  exec: Remove obsolete comments
  treewide: Switch memcpy() users of 'task->comm' to a more safer
    implementation
  treewide: Switch from tsk->comm to tsk->comm_str which is 64 bytes
    long

 arch/arm64/kernel/traps.c        |  2 +-
 arch/arm64/kvm/mmu.c             |  2 +-
 block/blk-core.c                 |  2 +-
 block/bsg.c                      |  2 +-
 drivers/char/random.c            |  2 +-
 drivers/hid/hid-core.c           |  6 +++---
 drivers/mmc/host/tmio_mmc_core.c |  6 +++---
 drivers/pci/pci-sysfs.c          |  2 +-
 drivers/scsi/scsi_ioctl.c        |  2 +-
 drivers/tty/serial/serial_core.c |  2 +-
 drivers/tty/tty_io.c             |  8 ++++----
 drivers/usb/core/devio.c         | 16 ++++++++--------
 drivers/usb/core/message.c       |  2 +-
 drivers/vfio/group.c             |  2 +-
 drivers/vfio/vfio_iommu_type1.c  |  2 +-
 drivers/vfio/vfio_main.c         |  2 +-
 drivers/xen/evtchn.c             |  2 +-
 drivers/xen/grant-table.c        |  2 +-
 fs/binfmt_elf.c                  |  2 +-
 fs/coredump.c                    |  4 ++--
 fs/drop_caches.c                 |  2 +-
 fs/exec.c                        |  8 ++++----
 fs/ext4/dir.c                    |  2 +-
 fs/ext4/inode.c                  |  2 +-
 fs/ext4/namei.c                  |  2 +-
 fs/ext4/super.c                  | 12 ++++++------
 fs/hugetlbfs/inode.c             |  2 +-
 fs/ioctl.c                       |  2 +-
 fs/iomap/direct-io.c             |  2 +-
 fs/jbd2/transaction.c            |  2 +-
 fs/locks.c                       |  2 +-
 fs/netfs/internal.h              |  2 +-
 fs/proc/base.c                   |  2 +-
 fs/read_write.c                  |  2 +-
 fs/splice.c                      |  2 +-
 include/linux/coredump.h         |  3 ++-
 include/linux/filter.h           |  2 +-
 include/linux/ratelimit.h        |  2 +-
 include/linux/sched.h            | 17 ++++++++++-------
 include/trace/events/block.h     |  5 +++++
 include/trace/events/oom.h       |  1 +
 include/trace/events/osnoise.h   |  1 +
 include/trace/events/signal.h    |  1 +
 include/trace/events/task.h      |  2 ++
 init/init_task.c                 |  2 +-
 ipc/sem.c                        |  2 +-
 kernel/acct.c                    |  2 +-
 kernel/audit.c                   |  4 ++--
 kernel/auditsc.c                 | 10 +++++-----
 kernel/bpf/helpers.c             |  2 +-
 kernel/capability.c              |  4 ++--
 kernel/cgroup/cgroup-v1.c        |  2 +-
 kernel/cred.c                    |  4 ++--
 kernel/events/core.c             |  2 +-
 kernel/exit.c                    |  6 +++---
 kernel/fork.c                    |  9 +++++++--
 kernel/freezer.c                 |  4 ++--
 kernel/futex/waitwake.c          |  2 +-
 kernel/hung_task.c               | 10 +++++-----
 kernel/irq/manage.c              |  2 +-
 kernel/kthread.c                 |  2 +-
 kernel/locking/rtmutex.c         |  2 +-
 kernel/printk/printk.c           |  2 +-
 kernel/sched/core.c              | 22 +++++++++++-----------
 kernel/sched/debug.c             |  4 ++--
 kernel/signal.c                  |  6 +++---
 kernel/sys.c                     |  6 +++---
 kernel/sysctl.c                  |  2 +-
 kernel/time/itimer.c             |  4 ++--
 kernel/time/posix-cpu-timers.c   |  2 +-
 kernel/tsacct.c                  |  2 +-
 kernel/workqueue.c               |  6 +++---
 lib/dump_stack.c                 |  2 +-
 lib/nlattr.c                     |  6 +++---
 mm/compaction.c                  |  2 +-
 mm/filemap.c                     |  4 ++--
 mm/gup.c                         |  2 +-
 mm/memfd.c                       |  2 +-
 mm/memory-failure.c              | 10 +++++-----
 mm/memory.c                      |  2 +-
 mm/mmap.c                        |  4 ++--
 mm/oom_kill.c                    | 18 +++++++++---------
 mm/page_alloc.c                  |  4 ++--
 mm/util.c                        |  2 +-
 net/core/sock.c                  |  2 +-
 net/dns_resolver/internal.h      |  2 +-
 net/ipv4/raw.c                   |  2 +-
 net/ipv4/tcp.c                   |  2 +-
 net/socket.c                     |  2 +-
 security/lsm_audit.c             |  4 ++--
 90 files changed, 184 insertions(+), 165 deletions(-)

-- 
2.38.1


