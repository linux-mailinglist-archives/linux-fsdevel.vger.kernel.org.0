Return-Path: <linux-fsdevel+bounces-55941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39316B10A52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D431B1893EE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAF22D23BD;
	Thu, 24 Jul 2025 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oKKf19rc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3B2D12E2;
	Thu, 24 Jul 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753360603; cv=none; b=N2c8ASvKAinHW2pc5rqluZNbHPFe9cHsmf/PYydXx1I93p49R0oUtwsuC2iytSexbXpImSzNd7p6xyQhs5js9xUGMRZt498BHO/8V5+/7u/+RLnrrMxYeXs5O67hJgWsfSBb0s7X4jrGYcJy1hdJrrnz/wlWVTLrdIoxcj06hGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753360603; c=relaxed/simple;
	bh=p7zaguJl0jOOEfM8gRKljVBTfrRIt+bLNBe08BQu42c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JZIwoqRLtE/HDw1nIzRwxjChrNPI+1x/dRYntv3ovahcxDLmnH+7ACSCL1xlkdzejQ8U7NYmUCPa7wvGJ0Zm0gs0eP0Zw9piQPvuOBdK7J3e5WE4SmKZbkDcyWZlACWg2+nxWKCiwL/SxzHMu4/kGZ2Y5u9/hkHahiz/qdP7iQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oKKf19rc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kTMLqhd8ACCARh9s+Oizrnftx6KSLEeKOV2ICyEnYoY=; b=oKKf19rcSSkXTmh1MA4PBQ476N
	Dv3eNo+L1JatFoA7T5mrN2+0OjQpe9OOPJeq+sLXSTrhk1TnBydE5RZQfkN722JNdB79sqWpM/S/k
	SIBrZlAONRmg1WSKBvqyRC/RxwEYhSxCQF6b6z7TwiE8egFWj/r02JlskgE0vh6BWhOCzakc61IKE
	e80rAKtvATtYf6XkZ3nbtIbfiRbic7M/JoxsKYtuMxugNwJTADNPT6JCwx44KstSCLVdWH5aqjQcO
	lHDHjmRULKVLzCGI5kDyND0+Uz8TE5nsLCM1RnktS+EKRpEzC3OIkBNRIAXv+r0HQd3g47yrH9Mv3
	mn74TWMg==;
Received: from [223.233.78.24] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uevBR-003BPU-D2; Thu, 24 Jul 2025 14:36:25 +0200
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
Subject: [PATCH v6 0/3] Add support for long task name
Date: Thu, 24 Jul 2025 18:06:09 +0530
Message-Id: <20250724123612.206110-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Bhupesh (3):
  exec: Remove obsolete comments
  treewide: Switch memcpy() users of 'task->comm' to a more safer
    implementation
  include: Set tsk->comm length to 64 bytes

 include/linux/coredump.h       |  3 ++-
 include/linux/sched.h          | 15 +++++++++------
 include/trace/events/block.h   |  5 +++++
 include/trace/events/oom.h     |  1 +
 include/trace/events/osnoise.h |  1 +
 include/trace/events/signal.h  |  1 +
 include/trace/events/task.h    |  2 ++
 7 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.38.1


