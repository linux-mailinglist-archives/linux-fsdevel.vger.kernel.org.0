Return-Path: <linux-fsdevel+bounces-48349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D81AADCEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6683C4A0AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039923534D;
	Wed,  7 May 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pmnPzs+o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9A21638A;
	Wed,  7 May 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615914; cv=none; b=F+P/uxDQtRcSTt3syNJu1zcEjtrqCBxQAjb6tNpfWdO1vxfHqSnSd+ctuM6AApvhY4ygXs72tafV7/mo0m584VwbdWeU8GPGKe/QG7emhuJmvF4Tad9los9bnHGopj/lr0ovlBZjBm/OYoCDlGLafAgmRTgCNp+A5KSAPNDA+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615914; c=relaxed/simple;
	bh=oAjgwVvpitMkp7q7yT4OppvdYEEh8USxLK/nmFRK9x8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCd5Hcxa+Dyyuhvy2uLyYE7jVjLcCZSLkBZczkzT9ajK5xLm0Eo0u2kv5sXrm0gX5QGN0tmBZnPgUsXWKpHXGY2Rr3V/aZBJxsBQUnZRhNVpAtD8gHgpp1LjPmjL2a8XodugyHgydyVBH+pdjlZm7m5vyyHBj4M2mQQoQbGoXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pmnPzs+o; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MWniPNd5Htz13/JraQ6uRQSWXj4Du7d719u+dg9Yg0M=; b=pmnPzs+oEfcW1E8ldrUF6E89Qu
	r0GAuK4AXFSZL5Blg/ri5/lMRPYKLLgRRcR1xQLcRFFSMbeoDwTzidxF1zSajffPHijhLBnBnhKnh
	vVWidQCYQLgKCpymomEn2BjCgiGoQU1Od9pGzEuBJ+hBoNlvZOQ4n2fB6It+my4q4uGei5qz1dzBQ
	X6xXg6jcHo8gTMTEl79pRtzm/YlCCt9YzKdAo9DEdWwCeAbNtYT9BNbiNSLzPQTbsi0DsMeAvj5dw
	d2sIZvfTyetwjTwnlnCOreUxTt+Nb5eaAwS5+0swYqVm5cWzNpoPUd5TNhhu1cgArZBa5mxX00NLR
	37NxD27w==;
Received: from [223.233.66.62] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uCcWN-004fhg-T3; Wed, 07 May 2025 13:04:58 +0200
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
	vschneid@redhat.com
Subject: [PATCH v3 0/3] Add support for long task name
Date: Wed,  7 May 2025 16:34:41 +0530
Message-Id: <20250507110444.963779-1-bhupesh@igalia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

This patch does not touch 'TASK_COMM_LEN' at all, i.e.
'TASK_COMM_LEN' and the 16-byte design remains untouched.

In this version, as Linus suggested, we can add the
following union inside 'task_struct':
       union {
               char    comm[TASK_COMM_LEN];
               char    real_comm[REAL_TASK_COMM_LEN];
       };

and then modify '__set_task_comm()' to pass 'tsk->real_comm'
to the existing users.

So, eventually:
- users who want the existing 'TASK_COMM_LEN' behavior will get it
  (existing ABIs would continue to work),
- users who just print out 'tsk->comm' as a string will get the longer
  new "real comm",
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
  exec: Add support for 64 byte 'tsk->real_comm'

 fs/exec.c                      |  6 +++---
 include/linux/coredump.h       |  3 ++-
 include/linux/sched.h          | 14 ++++++++------
 include/trace/events/block.h   |  5 +++++
 include/trace/events/oom.h     |  1 +
 include/trace/events/osnoise.h |  1 +
 include/trace/events/sched.h   | 13 +++++++++++++
 include/trace/events/signal.h  |  1 +
 include/trace/events/task.h    |  2 ++
 9 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.38.1


