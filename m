Return-Path: <linux-fsdevel+bounces-58592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A111FB2F52C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A2B1C84A2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F052F5333;
	Thu, 21 Aug 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="M2sHXqfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C2D47FB;
	Thu, 21 Aug 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755771736; cv=none; b=BtBGnB9/nbjSaaOlhL3KyQ0DvdlCevsG6rFKgjzlGHe833Bzti+wcA1/0cIbJIDnmF0QxGYPzSqQzL3rK8UmrBed4y9qFGIsep0om5DGkWqFZipywVOm8rIVSkpG1t/qf/G5lgSsMXpN7U8DzOhGC92dKaDes6Tpc4cqWOusJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755771736; c=relaxed/simple;
	bh=m9IefUb6PEzTegog7shwN73RsUXkUdNQIqQ/PkqJ+7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ocQKwyRkkIrH2eLq1zRn3cBKBVOssVdHrKkOuL1ZWn38WWY+aZlz1goO3lzm5TBueUJFnw5ujt1x1PqHdeB3GnmRrDYd2Gob/Kb7jCe363/tP5y0KmYDj/FgxGTNA8YhhBqDlwy6ZQ2lZuoNE6wv17yBJq9cxZoMMBhjapf/JGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=M2sHXqfv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5fAj2cSbhfdyl5wHRo8bodfmrhTv6+ffnCJX2SNkoj4=; b=M2sHXqfvSZ0Xbt0+4tJpX5Vgqu
	azYJNE9aicGjX/G54/xT9PSWa1l68fPWtER5Dgfm+zxrtwGOviydnOnxZCMilJmC/dXszDBIsXSaS
	BfaofoeTPPaRj2L65W6VxMDz+kV+VxqADd3IlHW33XebnKohuzZ9axvc7eEOKqgcPu+gO11N/21fG
	YxGJv9EPnNZtZry9q2xZUqlBig8K42MXV9F7TR8HJXuTd58Hlu0nNJKFw4+WaOMv+fY08/Myhxkv7
	nCLMxTPzh+dKbzb6WatptwO30pRffs/pprgcQsFDHg9gRsxeUjNVc/RgCPaJmUgsS6zVtVXVQqIs4
	dJM65gpA==;
Received: from [223.233.68.152] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1up2Qk-00HBmV-9u; Thu, 21 Aug 2025 12:22:02 +0200
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
Subject: [PATCH v8 0/5] Add support for long task name
Date: Thu, 21 Aug 2025 15:51:47 +0530
Message-Id: <20250821102152.323367-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v7:
================
- v7 can be seen here: https://lore.kernel.org/all/20250811064609.918593-1-bhupesh@igalia.com/
- As suggested by Andy used '--base' option with git-format to indicate the version of
  'linux-next/master' this patchset is rebased on. Also used the 'Link'
  tag in the commit log.
- Also added a new [PATCH 5/5] to replace BUILD_BUG_ON() with static_assert() inside
  'set_task_comm()'.

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

Bhupesh (5):
  exec: Remove obsolete comments
  include: Set tsk->comm length to 64 bytes
  treewide: Replace 'get_task_comm()' with 'strscpy_pad()'
  treewide: Switch memcpy() users of 'task->comm' to a more safer
    implementation
  include: Replace BUILD_BUG_ON with static_assert in 'set_task_comm()'

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
 include/linux/sched.h                         | 51 ++++++++++++-------
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
 40 files changed, 92 insertions(+), 83 deletions(-)


base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
-- 
2.38.1


