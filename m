Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE7246804
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 16:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgHQOJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 10:09:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbgHQOJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597673393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+lmlYQx2uz53YfMyFrKjqL1FinoRZitUJmdbvkIY3+4=;
        b=Ub9sSy7Gkb9a+rM2UYcuI4QRAkKvNE8qYS0Lrn6jxINpF5XFnAANn3W/M2Gb/qan+DC1Cd
        Z1xo2spaI5gwUdPa1G+Gppzp+9GcuIa4ScuEd6XpH6RcTVUkEuDPOzvrwu5Hi4JTXLbW9E
        81nFyr6nPUAM3qn8330qUUAdcQR0Ogg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-z0VJS0sDPW6M5J-0AMqYtA-1; Mon, 17 Aug 2020 10:09:49 -0400
X-MC-Unique: z0VJS0sDPW6M5J-0AMqYtA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCE281F001;
        Mon, 17 Aug 2020 14:09:47 +0000 (UTC)
Received: from llong.com (ovpn-118-35.rdu2.redhat.com [10.10.118.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 11C7926323;
        Mon, 17 Aug 2020 14:09:38 +0000 (UTC)
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
Subject: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory control
Date:   Mon, 17 Aug 2020 10:08:23 -0400
Message-Id: <20200817140831.30260-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Memory controller can be used to control and limit the amount of
physical memory used by a task. When a limit is set in "memory.high" in
a v2 non-root memory cgroup, the memory controller will try to reclaim
memory if the limit has been exceeded. Normally, that will be enough
to keep the physical memory consumption of tasks in the memory cgroup
to be around or below the "memory.high" limit.

Sometimes, memory reclaim may not be able to recover memory in a rate
that can catch up to the physical memory allocation rate. In this case,
the physical memory consumption will keep on increasing.  When it reaches
"memory.max" for memory cgroup v2 or when the system is running out of
free memory, the OOM killer will be invoked to kill some tasks to free
up additional memory. However, one has little control of which tasks
are going to be killed by an OOM killer. Killing tasks that hold some
important resources without freeing them first can create other system
problems down the road.

Users who do not want the OOM killer to be invoked to kill random
tasks in an out-of-memory situation can use the memory control
facility provided by this new patchset via prctl(2) to better manage
the mitigation action that needs to be performed to various tasks when
the specified memory limit is exceeded with memory cgroup v2 being used.

The currently supported mitigation actions include the followings:

 1) Return ENOMEM for some syscalls that allocate or handle memory
 2) Slow down the process for memory reclaim to catch up
 3) Send a specific signal to the task
 4) Kill the task

The users that want better memory control for their applicatons can
either modify their applications to call the prctl(2) syscall directly
with the new memory control command code or write the desired action to
the newly provided memctl procfs files of their applications provided
that those applications run in a non-root v2 memory cgroup.

Waiman Long (8):
  memcg: Enable fine-grained control of over memory.high action
  memcg, mm: Return ENOMEM or delay if memcg_over_limit
  memcg: Allow the use of task RSS memory as over-high action trigger
  fs/proc: Support a new procfs memctl file
  memcg: Allow direct per-task memory limit checking
  memcg: Introduce additional memory control slowdown if needed
  memcg: Enable logging of memory control mitigation action
  memcg: Add over-high action prctl() documentation

 Documentation/userspace-api/index.rst      |   1 +
 Documentation/userspace-api/memcontrol.rst | 174 ++++++++++++++++
 fs/proc/base.c                             | 109 ++++++++++
 include/linux/memcontrol.h                 |   4 +
 include/linux/sched.h                      |  24 +++
 include/uapi/linux/prctl.h                 |  48 +++++
 kernel/fork.c                              |   1 +
 kernel/sys.c                               |  16 ++
 mm/memcontrol.c                            | 227 +++++++++++++++++++++
 mm/mlock.c                                 |   6 +
 mm/mmap.c                                  |  12 ++
 mm/mprotect.c                              |   3 +
 12 files changed, 625 insertions(+)
 create mode 100644 Documentation/userspace-api/memcontrol.rst

-- 
2.18.1

