Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0143327784
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 07:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhCAGZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 01:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhCAGZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 01:25:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C2C06178A
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Feb 2021 22:24:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id s23so11049121pji.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Feb 2021 22:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArNP2uMW7gBd9O3E1At2VYbyrloUhhFWuEfRdcUZEjk=;
        b=FmkE8GWV8yLmAy4FQqBaXkvB1sBv0RQ+xcane5Rs5Hhuz1tEJBH/X01FCxfS3oxZkR
         jVL8zzVXmCvfOqg7kIhSZ0sPFgYq2/eAHQJGVs6Iv6Y8r1MR+LzS1SpJh7M9HkHaqZdk
         /VjoRJgHDgOyH3AYuRAPnPlneUwZ9KE/MQbkyAQCFpZW17rhEc3FpJfx3qB7ogIBj/ZI
         FpJKZrKsugP43BKNm96zoNPgBtsPOcjUhk6pLv2UagTvzgyltWaQ6l0kYoW3IXeYxDuD
         hK7D1wt3himG81sb1Jpgi9YVhdc5tCS6BEiAvLAPvF7MU2ALb6hiEoowNrXu3VYSRfIa
         Ff2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ArNP2uMW7gBd9O3E1At2VYbyrloUhhFWuEfRdcUZEjk=;
        b=Hv8zhE9S8ZbppkLvwb/yfOt5QqasX2O6y8XS/zj+i5n6lwgnSm7ufZYhddQIKqCpeX
         v/sFOZcn4Je50aRSlIBVzPfWlSisvvXMuyhzajzDwCwRdg9cJVbp3RcpJZVmHk56Bzse
         eN8zmIiA9ErkhoE57SzJFW2qiIYCneydHalCe0oZS/UE0xSQo7omvsVN5+BNXlqTitEp
         WgwMlAu7BmsmElZi3lBjvx+0aTx7OogiM5N4GnKVxnRj9j+zdkEgkhhmc5aUi3PYpI/a
         Ua+EnKE4GTDJBODfZW6zGRHIcl+sSw/rSdAxJo/0DwnnTj7MZtfxxClX77Hs4GTOOe47
         zwlQ==
X-Gm-Message-State: AOAM532JK9hR2D+jLCIYkHVvg4qIE9eUAk2PNGZ9MO8LcFL4eglcDAUo
        KoJHV8u3AY0q2fTLhe/mDqiNIQ==
X-Google-Smtp-Source: ABdhPJxK+/+grHuuVMH/Q+Maq6CdxUlgQreML/kvOOFZmo8+o1ttYQO6LKfeje2r9vpdaoQVSalAzQ==
X-Received: by 2002:a17:90a:5302:: with SMTP id x2mr16503209pjh.232.1614579868545;
        Sun, 28 Feb 2021 22:24:28 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x6sm14304626pfd.12.2021.02.28.22.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Feb 2021 22:24:28 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     viro@zeniv.linux.org.uk, jack@suse.cz, amir73il@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, guro@fb.com, songmuchun@bytedance.com,
        alex.shi@linux.alibaba.com, alexander.h.duyck@linux.intel.com,
        chris@chrisdown.name, richard.weiyang@gmail.com, vbabka@suse.cz,
        mathieu.desnoyers@efficios.com, posk@google.com, jannh@google.com,
        iamjoonsoo.kim@lge.com, daniel.vetter@ffwll.ch, longman@redhat.com,
        walken@google.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com, keescook@chromium.org,
        krisman@collabora.com, esyr@redhat.com, surenb@google.com,
        elver@google.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com
Subject: [PATCH 0/5] Use obj_cgroup APIs to change kmem pages
Date:   Mon,  1 Mar 2021 14:22:22 +0800
Message-Id: <20210301062227.59292-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since Roman series "The new cgroup slab memory controller" applied. All
slab objects are changed via the new APIs of obj_cgroup. This new APIs
introduce a struct obj_cgroup instead of using struct mem_cgroup directly
to charge slab objects. It prevents long-living objects from pinning the
original memory cgroup in the memory. But there are still some corner
objects (e.g. allocations larger than order-1 page on SLUB) which are
not charged via the API of obj_cgroup. Those objects (include the pages
which are allocated from buddy allocator directly) are charged as kmem
pages which still hold a reference to the memory cgroup.

E.g. We know that the kernel stack is charged as kmem pages because the
size of the kernel stack can be greater than 2 pages (e.g. 16KB on x86_64
or arm64). If we create a thread (suppose the thread stack is charged to
memory cgroup A) and then move it from memory cgroup A to memory cgroup
B. Because the kernel stack of the thread hold a reference to the memory
cgroup A. The thread can pin the memory cgroup A in the memory even if
we remove the cgroup A. If we want to see this scenario by using the
following script. We can see that the system has added 500 dying cgroups.

	#!/bin/bash

	cat /proc/cgroups | grep memory

	cd /sys/fs/cgroup/memory
	echo 1 > memory.move_charge_at_immigrate

	for i in range{1..500}
	do
		mkdir kmem_test
		echo $$ > kmem_test/cgroup.procs
		sleep 3600 &
		echo $$ > cgroup.procs
		echo `cat kmem_test/cgroup.procs` > cgroup.procs
		rmdir kmem_test
	done

	cat /proc/cgroups | grep memory

This patchset aims to make those kmem pages drop the reference to memory
cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
of the dying cgroups will not increase if we run the above test script.

Patch 1-3 are using obj_cgroup APIs to charge kmem pages. The remote
memory cgroup charing APIs is a mechanism to charge kernel memory to a
given memory cgroup. So I also make it use the APIs of obj_cgroup.
Patch 4-5 are doing this.

Muchun Song (5):
  mm: memcontrol: introduce obj_cgroup_{un}charge_page
  mm: memcontrol: make page_memcg{_rcu} only applicable for non-kmem
    page
  mm: memcontrol: reparent the kmem pages on cgroup removal
  mm: memcontrol: move remote memcg charging APIs to CONFIG_MEMCG_KMEM
  mm: memcontrol: use object cgroup for remote memory cgroup charging

 fs/buffer.c                          |  10 +-
 fs/notify/fanotify/fanotify.c        |   6 +-
 fs/notify/fanotify/fanotify_user.c   |   2 +-
 fs/notify/group.c                    |   3 +-
 fs/notify/inotify/inotify_fsnotify.c |   8 +-
 fs/notify/inotify/inotify_user.c     |   2 +-
 include/linux/bpf.h                  |   2 +-
 include/linux/fsnotify_backend.h     |   2 +-
 include/linux/memcontrol.h           | 109 +++++++++++---
 include/linux/sched.h                |   6 +-
 include/linux/sched/mm.h             |  30 ++--
 kernel/bpf/syscall.c                 |  35 ++---
 kernel/fork.c                        |   4 +-
 mm/memcontrol.c                      | 276 ++++++++++++++++++++++-------------
 mm/page_alloc.c                      |   4 +-
 15 files changed, 324 insertions(+), 175 deletions(-)

-- 
2.11.0

