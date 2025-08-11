Return-Path: <linux-fsdevel+bounces-57249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D920AB1FF82
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 08:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E936A169A69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347F2D6634;
	Mon, 11 Aug 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n9X43tgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDBF29CEB;
	Mon, 11 Aug 2025 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754894799; cv=none; b=hSEql6olz7BTVtysBDB60ODxq6Q3T8xWKfsQMEkTopYsbjt8NkL2sB0jPa8E+7LvNjcomCtjeKHC1EV8gt/Ss/bYsxGYyDPC9BdHmvsz6HYW9+YdG+er52O/7WbjK+jMrU2jvSbSeWjb9oNSN9drgWqSP+s4RgO/IRxA7T94dpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754894799; c=relaxed/simple;
	bh=n0a7b4JAwxure5Hrb5kN5KOagiOIhYfShhtLZY8mNE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=moCWM89k2uJkVje2/BdhYxK6yiT95de8LWFm8VLU8E1Ja/tB17BakJeRslxFNsQw0WVR+jsro5W96nFv7+RRtlA5+bigWaouU+y32g9+Qrp8B/bXuINPGSz5ANT11VnM26H1YY17Vri5Ahd1CcXdI7pbmOM40kj4nGkQ3cLcR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n9X43tgx; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kbvwlNZUn0Q7xGqd2td/p5wrTa01tYFtoJ3G9wHE7i0=; b=n9X43tgxYR31C4cKiAzLXMY6Co
	6yQPeegFMzxG1w66CbnCCZvVEIIFMyqBdZfyAArl0Cg3xE40xucrDzkTqY+mUEjZtqVyPLgMFxwKU
	cSct/cbsmeilH656OUb5FBU+nlbn2I6EJqr76OkcslpQmRfe1QXb9EpmQTtA/C+40tSHA7fdP7aLt
	lusqiBGmjevyUK8LozbceXxtULYAJkCzsqRAsZcKXRF+xSgCrxi2g9zOmyNQAOR4Cgg7HleTo+a34
	xralwBwKEoooA7s5PykDrjAfuz08Y7NqoZ+wB21Fl3/b8fzyLs2nHcRZZGlnO87WSybnGWQIo5Z9N
	1lB0rz+A==;
Received: from [223.233.69.163] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ulMIZ-00Cdun-Hh; Mon, 11 Aug 2025 08:46:23 +0200
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
Subject: [PATCH v7 0/4] Add support for long task name
Date: Mon, 11 Aug 2025 12:16:05 +0530
Message-Id: <20250811064609.918593-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v6:
================
- v6 can be seen here: https://lore.kernel.org/all/20250724123612.206110-1-bhupesh@igalia.com/
- As suggested by Linus, we got rid of 'get_task_comm()' entirely and replaced it with
  'strscpy_pad()' implementation.
- Also changed the current memcpy() use-cases which use 'current->comm' to copy the task name over
  to local copies, to call a wrappper like "get_task_array()".
- Collected 'Reviewed-by' from Kees for [PATCH 1/4].

Changes since v5:
================
- v5 can be seen here: https://lore.kernel.org/lkml/20250716123916.511889-1-bhupesh@igalia.com/ 
- As suggested by Linus, replaced 'tsk->comm' with 'tsk->comm_str' locally, and verified basic
  thread names and then changed 'tsk->comm_str' back to 'tsk->comm'. So essentially now 'tsk->comm'
  is TASK_COMM_EXT_LEN i.e. 64-bytes long.

Changes since v4:
================
- v4 can be seen here: https://lore.kernel.org/lkml/20250521062337.53262-1-bhupesh@igalia.com/ 
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

Via this patchset, Linus suggested 'tsk->comm' is made 64-byte long
and equal to TASK_COMM_EXT_LEN.

To avoid any surprises / bug,s I replaced 'tsk->comm' with
'tsk->comm_str' locally inside 'task_struct' and checked compilation
of code and basic working of thread names:

       struct task_struct {
	       ..............
               char    comm_str[TASK_COMM_EXT_LEN];
	       ..............
       };

       where TASK_COMM_EXT_LEN is 64-bytes.

Once done, I changed the name back to 'tsk->comm'.

To ensure that the existing ABI and userspace continues to work
as intended, we ensure that:

- Existing users of 'get_task_comm'/ 'set_task_comm' will get 'tsk->comm'
  truncated to a maximum of 'TASK_COMM_LEN' (16-bytes) to maintain ABI,
- New / Modified users of 'get_task_comm'/ 'set_task_comm' will get
 'tsk->comm' supported up to a maximum of 'TASK_COMM_EXT_LEN' (64-bytes).

Note, that the existing users have not been modified to migrate to
'TASK_COMM_EXT_LEN', in case they have hard-coded expectations of
dealing with only a 'TASK_COMM_LEN' long 'tsk->comm_str'.

After this change, gdb is able to show full name of the task, using a
simple app which generates threads with long names [see 1]:
  # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
  # cat log

  NameThatIsTooLongForComm[4662]

[1]. https://github.com/lostgoat/tasknames

Bhupesh (4):
  exec: Remove obsolete comments
  include: Set tsk->comm length to 64 bytes
  treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
  treewide: Switch memcpy() users of 'task->comm' to a more safer
    implementation

 drivers/connector/cn_proc.c                   |  2 +-
 drivers/dma-buf/sw_sync.c                     |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c  |  2 +-
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  2 +-
 drivers/gpu/drm/lima/lima_ctx.c               |  2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  2 +-
 drivers/gpu/drm/panthor/panthor_gem.c         |  2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  2 +-
 drivers/hwtracing/stm/core.c                  |  2 +-
 drivers/tty/tty_audit.c                       |  2 +-
 fs/bcachefs/thread_with_file.c                |  2 +-
 fs/binfmt_elf.c                               |  2 +-
 fs/binfmt_elf_fdpic.c                         |  2 +-
 fs/ocfs2/cluster/netdebug.c                   |  1 -
 fs/proc/array.c                               |  2 +-
 include/linux/coredump.h                      |  2 +-
 include/linux/sched.h                         | 50 ++++++++++++-------
 include/linux/tracepoint.h                    |  4 +-
 include/trace/events/block.h                  | 10 ++--
 include/trace/events/oom.h                    |  2 +-
 include/trace/events/osnoise.h                |  2 +-
 include/trace/events/sched.h                  | 13 +++--
 include/trace/events/signal.h                 |  2 +-
 include/trace/events/task.h                   |  4 +-
 kernel/audit.c                                |  6 ++-
 kernel/auditsc.c                              |  6 ++-
 kernel/sys.c                                  |  2 +-
 mm/kmemleak.c                                 |  6 ---
 net/bluetooth/hci_sock.c                      |  2 +-
 net/netfilter/nf_tables_api.c                 |  2 +-
 security/integrity/integrity_audit.c          |  3 +-
 security/ipe/audit.c                          |  2 +-
 security/landlock/domain.c                    |  2 +-
 security/lsm_audit.c                          |  7 +--
 tools/bpf/bpftool/pids.c                      |  6 +--
 .../bpf/test_kmods/bpf_testmod-events.h       |  2 +-
 40 files changed, 91 insertions(+), 83 deletions(-)

-- 
2.38.1


