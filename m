Return-Path: <linux-fsdevel+bounces-49558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB49ABEBE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCDF1B67494
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 06:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B21F233D88;
	Wed, 21 May 2025 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fq2evgm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF631E9B19;
	Wed, 21 May 2025 06:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747808643; cv=none; b=WrrV55J9M0Mb1gXoGC3DH/jber0qkk3jG510eOT7vMrbObDTcVOXSiCPCrQ+WlJb5yzCpfLQnEVaagLgfUwv8FGMJT97L4N2F7Bw1ShdTGAy9Pqzk3BZPdDmDEN5f7JNdtXhK2BlMMzzsGvvDsah1iW1eZ4ir/H9w/JgQqt0M30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747808643; c=relaxed/simple;
	bh=0Vq9at/OYdOLMKZalD7R5Zkb+jm93cyO2v94IEXBflM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B45kGMFdNLH3nk8uXjhhoRIi44/0ywx5+Br7rkLUz8McB2UR1x6lcIfkSsC/NQGTToncHEzj1t7RfqsdRrBsF20HkFo2B4/BBWDkp/4tSxoRr+/FdPItuvLVeUEz/8lAtR7UCEyPvmOwen2FEZlerIem80FqiwgeLHm1e07GQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fq2evgm+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1n/3IFWy+0LWJpNhuy9Hz5x+4AMFxJjBU/fPUdAjQPI=; b=fq2evgm+8aHHlVo2DpQEvrySSt
	GO2vp2fKXtO2g0nV9hEiG9hYdjkigt7zTWE3O0j0gJBjVRLaydX4+pFf4K5zpdF2PfjTprkErWDUi
	qDS50gNVmRRsXRFILzfFbW55oKZhR8+kLnt5Lg/C0unLciOTzqECfQuNkvaSGjvuvKs3VfIkjugkr
	B70hJKa59NDjmQVnsBtL0OslaH6honTZblyqsH3I22LDdxQIYv+ZW/DSLurlonMtrQm5rc09l4BaV
	0CS1mdNszFf0ahjBioD2m71swBrp44r1AHBYXq/tVmQv2aW/nPO+eQtLuRydoe3JL7XZSh0tRXS9X
	miwX7g1g==;
Received: from [223.233.70.209] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHcrm-00B3oN-8q; Wed, 21 May 2025 08:23:50 +0200
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
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] Add support for long task name
Date: Wed, 21 May 2025 11:53:34 +0530
Message-Id: <20250521062337.53262-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Via this patchset, as Linus suggested, we can add the
following union inside 'task_struct':
       union {
               char    comm[TASK_COMM_LEN];
               char    comm_ext[TASK_COMM_EXT_LEN];
       };

and then modify '__set_task_comm()' to pass 'tsk->comm_ext'
to the existing users.

So, eventually:
- users who want the existing 'TASK_COMM_LEN' behavior will get it
  (existing ABIs would continue to work),
- users who just print out 'tsk->comm' as a string will get the longer
  new "extended comm",
- users who do 'sizeof(->comm)' will continue to get the old value
  because of the union.

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
  exec: Add support for 64 byte 'tsk->comm_ext'

 fs/exec.c                      |  6 +++---
 include/linux/coredump.h       |  3 ++-
 include/linux/sched.h          | 14 ++++++++------
 include/trace/events/block.h   |  5 +++++
 include/trace/events/oom.h     |  1 +
 include/trace/events/osnoise.h |  1 +
 include/trace/events/signal.h  |  1 +
 include/trace/events/task.h    |  2 ++
 8 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.38.1


