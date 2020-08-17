Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4824680F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgHQOKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:10:30 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45466 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728981AbgHQOKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=7a3mQcEQYLMtjY6U/koWkESRRECCeXLzk+bt2NSvZuo=;
        b=STcCTApvARX7/qTWzXc7LUk8F/H/7/7npIbCape2gNEChRDH0Kr1XpuqLF71VWm1QtySji
        AY7dDt/+rDguzW9tYUlWlNURZYQeUoCV3e8hgX5E761IxQspgVhsb7C2miznV0pOWSi0zG
        0oAg84X9mtDqS3qcqjuYIKJzY592XZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-qadAukWcOu-r2yAAMxOy1w-1; Mon, 17 Aug 2020 10:10:13 -0400
X-MC-Unique: qadAukWcOu-r2yAAMxOy1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA55818686C2;
        Mon, 17 Aug 2020 14:10:11 +0000 (UTC)
Received: from llong.com (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFCDD19C4F;
        Mon, 17 Aug 2020 14:10:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 8/8] memcg: Add over-high action prctl() documentation
Date:   Mon, 17 Aug 2020 10:08:31 -0400
Message-Id: <20200817140831.30260-9-longman@redhat.com>
In-Reply-To: <20200817140831.30260-1-longman@redhat.com>
References: <20200817140831.30260-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new memcontrol.rst documentation file is added to document the new
prctl(2) interface for setting the over-high mitigation action parameters
and retrieving them.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/userspace-api/index.rst      |   1 +
 Documentation/userspace-api/memcontrol.rst | 174 +++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 Documentation/userspace-api/memcontrol.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 69fc5167e648..1c0fc7a7f4ec 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -23,6 +23,7 @@ place where this information is gathered.
    accelerators/ocxl
    ioctl/index
    media/index
+   memcontrol
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/memcontrol.rst b/Documentation/userspace-api/memcontrol.rst
new file mode 100644
index 000000000000..0cfcc72ad5f0
--- /dev/null
+++ b/Documentation/userspace-api/memcontrol.rst
@@ -0,0 +1,174 @@
+==============
+Memory Control
+==============
+
+Memory controller can be used to control and limit the amount of
+physical memory used by a task. When a limit is set in "memory.high" in
+a v2 non-root memory cgroup, the memory controller will try to reclaim
+memory if the limit has been exceeded. Normally, that will be enough
+to keep the physical memory consumption of tasks in the memory cgroup
+to be around or below the "memory.high" limit.
+
+Sometimes, memory reclaim may not be able to recover memory in a rate
+that can catch up to the physical memory allocation rate. In this case,
+the physical memory consumption will keep on increasing.  For memory
+cgroup v2, when it is reaching "memory.max" or the system is running
+out of free memory, the OOM killer will be invoked to kill some tasks
+to free up additional memory. However, one has little control of which
+tasks are going to be killed by an OOM killer. Killing tasks that hold
+some important resources without freeing them first can create other
+system problems.
+
+Users who do not want the OOM killer to be invoked to kill random
+tasks in an out-of-memory situation can use the memory control facility
+provided by :manpage:`prctl(2)` to better manage the mitigation action
+that needs to be performed to an individual task when the specified
+memory limit is exceeded with memory cgroup v2 being used.
+
+The task to be controlled must be running in a non-root memory cgroup
+as no limit will be imposed on tasks running in the root memory cgroup.
+
+There are two prctl commands related to this:
+
+ * PR_SET_MEMCONTROL
+
+ * PR_GET_MEMCONTROL
+
+
+PR_SET_MEMCONTROL
+-----------------
+
+PR_SET_MEMCTROL controls what action should be taken when the memory
+limit is exceeded.
+
+The arg2 of :manpage:`prctl(2)` sets the desired mitigation action. The
+action code consists of three different parts:
+
+ * Bits 0-7: action command
+
+ * Bits 8-15: signal number
+
+ * Bits 16-31: flags
+
+The currently supported action commands are:
+
+====== ================== ================================================
+Value  Define             Description
+====== ================== ================================================
+0      PR_MEMACT_NONE     Use the default memory cgroup behavior
+1      PR_MEMACT_ENOMEM   Return ENOMEM for selected syscalls that try to
+                          allocate more memory when the preset memory limit
+                          is exceeded
+2      PR_MEMACT_SLOWDOWN Slow down the process for memory reclaim to
+                          catch up when memory limit is exceeded
+3      PR_MEMACT_SIGNAL   Send a signal to the task that has exceeded
+                          preset memory limit
+4      PR_MEMACT_KILL     Kill the task that has exceeded preset memory
+                          limit
+====== ================== ================================================
+
+The currently supports flags are:
+
+====== ==================== ================================================
+Value  Define               Description
+====== ==================== ================================================
+0x01   PR_MEMFLAG_SIGCONT   Send a signal on every allocation request instead
+                            of a one-shot signal
+0x02   PR_MEMFLAG_DIRECT    Check per-task memory limit irrespective of cgroup
+                            setting
+0x04   PR_MEMFLAG_LOG       Log any actions taken to the kernel ring buffer
+0x10   PR_MEMFLAG_RSS_ANON  Check process anonymous memory
+0x20   PR_MEMFLAG_RSS_FILE  Check process page caches
+0x40   PR_MEMFLAG_RSS_SHMEM Check process shared memory
+0x70   PR_MEMFLAG_RSS       Equivalent to (PR_MEMFLAG_RSS_ANON |
+                            PR_MEMFLAG_RSS_FILE | PR_MEMFLAG_RSS_SHMEM)
+====== ==================== ================================================
+
+If the action command is PR_MEMACT_SIGNAL, bits 16-23 of the action
+code contains the signal number to be used when the memory limit is
+exceeded. By default, the signal number is reset after delivery so
+that the signal will be delivered only once. Another PR_SET_MEMCONTROL
+command will have to be issued to set the signal again.  If the user
+want a non-fatal signal to be delivered every time when the memory
+limit is breached without doing another PR_SET_MEMCONTROL call, the
+PR_MEMFLAG_SIGCONT flag can be set.
+
+The arg3 of :manpage:`prctl(2)` sets the additional memory cgroup
+limit that will be added to the value specified in the "memory.high"
+control file to get the real limit over which action specified in the
+action command will be triggered. This is to make sure that mitigation
+action will only be taken when the kernel memory reclaim facility fails
+to limit the growth of physical memory usage.
+
+If any of the PR_MEMFLAG_RSS* flag is specified, arg4 contains the
+per-process memory limit that will be used to compare against the sum
+of the specified RSS memory consumption of the process to determine
+if action will be taken provided that overall memory consumption has
+exceeded the "memory.high" + arg3 limit when the PR_MEMFLAG_DIRECT flag
+isn't set.
+
+If the PR_MEMFLAG_DIRECT flag is set, however, the cgroup memory limit
+is ignored and a memory-over-limit check will be performed on each
+memory allocation request, if applicable. This is reserved for special
+use case and is not recommended for general use.
+
+
+PR_GET_MEMCONTROL
+-----------------
+
+PR_GET_MEMCONTROL returns the parameters set by a previous
+PR_SET_MEMCONTROL command.
+
+The arg2 of :manpage:`prctl(2)` sets type of parameter that is to be
+returned. The possible values are:
+
+====== =================== ================================================
+Value  Define              Description
+====== =================== ================================================
+0      PR_MEMGET_ACTION    Return the action code - command, flags & signal
+1      PR_MEMGET_CLIMIT    Return the additional cgroup memory limit (in bytes)
+2      PR_MEMGET_PLIMIT    Return the process memory limit for PR_MEMFLAG_RSS*
+====== =================== ================================================
+
+
+/proc/<pid>/memctl
+------------------
+
+PR_GET_MEMCONTROL only returns memory control setting about the
+task itself. To find those information about other tasks, the
+/proc/<pid>/memctl file can be read. This file reports three integer
+parameters:
+
+ * action code
+
+ * cgroup additional memory limit
+
+ * process memory limit for PR_MEMFLAG_RSS* flags
+
+These are the same values that will be returned if the task is
+calling :manpage:`prctl(2)` with PR_GET_MEMCONTROL command and the
+PR_MEMGET_ACTION, PR_MEMGET_CLIMIT and PR_MEMGET_PLIMIT arguments
+respectively.
+
+Privileged users can also write to the memctl file directly to modify
+those parameters for a given task.
+
+This procfs file is present for each of the running threads of a process.
+So multiple writes to each of them are needed to update the parameters
+for all the threads within a running process.
+
+Affected Syscalls
+-----------------
+
+The following system calls have additional check for the over-high
+memory usage flag that is set by the above memory control facility.
+
+ * :manpage:`brk(2)`
+
+ * :manpage:`mlock(2)`
+
+ * :manpage:`mlock2(2)`
+
+ * :manpage:`mlockall(2)`
+
+ * :manpage:`mmap(2)`
-- 
2.18.1

