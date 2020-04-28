Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A81BC4C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgD1QPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 12:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgD1QPV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:15:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EBFC03C1AB;
        Tue, 28 Apr 2020 09:15:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e17so14335095qtp.7;
        Tue, 28 Apr 2020 09:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k3R5gkJ3ThXa/sxWlKmei/8r5dAQaHYp0uZa9XHTdo=;
        b=uGSupcYCQmVXHJYLwbPxSYic57xfSrLkCxz0QnALa4gnsTo3F0Wc0GLYWaarIVvq/8
         rERW42Q1IwlW1gQ7AgrwvUpZSd/ex3/bSnKLxXxbG1wePqhfH+GxeXrWNAZxkMcmB4/E
         sw2+x+jJvRmyB6K0GwEt5rekChvp+7kHgLYDpbAGOV3HvPFh4w4oUDf9L5geFoRCEOzc
         iU6s6S7KV8Uf7yVZbiv/DnDFjMULeN5A7GCNEfVYvzYJBMFKY1EedjHjs9p0bmsJ7nFh
         qn9pnjA8qU3EcUwJM22kliMwSu8r3mvNr7Ti0K1gCNF6mGR/ErEfOmjj4ZZh5mpq+L5L
         pl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+k3R5gkJ3ThXa/sxWlKmei/8r5dAQaHYp0uZa9XHTdo=;
        b=O9/wfPNMV8WMbo5LCe6IBJdx1JwtnoI6w7bRhARSFdTS0dOhAqMz+p+WgyS4IzpHLu
         2BL8V8gwaxWVDA0LcdgXOlu1yXGe9Z8jVmssGodlgByunJhaU+4YmHR3k9aI6i7HzsJu
         t6noWRJy3bccrv+TFD/79AC61cl7HNWzJOPqewwUwc1qsQRRh/yqGi4ZLspYHp4XffQm
         ksaR2V0aI5ZNH0HRSTaVBIlpm1+u+bSqgHXNQG91Q4Dlq+jIkCiKBZ0C9YfmkT/Xx/+V
         wk/0LUQdtrpBubgffAW3Zp4QKCfivXx5x0JQKyug8DhoRbeqD1Hiz5m2jLpWWkupECBg
         DMkw==
X-Gm-Message-State: AGi0Puas4QVJrXJ8ulFEx9ZdbzTPlqd1RbtfZe4BP94nkStyIlQChiNt
        hT0BD2E5pRdMGyvQevnxFLU=
X-Google-Smtp-Source: APiQypLu2y08gRjZA8/C0Up38Umb9v/JQk+D6QuLE/UmWOCPxIzZlATRtCWbuOeIEGgKHpF5NAWlkA==
X-Received: by 2002:ac8:27ed:: with SMTP id x42mr29217040qtx.231.1588090520087;
        Tue, 28 Apr 2020 09:15:20 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:3e4a])
        by smtp.gmail.com with ESMTPSA id z2sm14087421qkc.28.2020.04.28.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:15:19 -0700 (PDT)
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v5 0/4] Charge loop device i/o to issuing cgroup
Date:   Tue, 28 Apr 2020 12:13:46 -0400
Message-Id: <20200428161355.6377-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since V5:

* Fixed a missing css_put when failing to allocate a worker
* Minor style changes

Changes since V4:

Only patches 1 and 2 have changed.

* Fixed irq lock ordering bug
* Simplified loop detach
* Added support for nesting memalloc_use_memcg

Changes since V3:

* Fix race on loop device destruction and deferred worker cleanup
* Ensure charge on shmem_swapin_page works just like getpage
* Minor style changes

Changes since V2:

* Deferred destruction of workqueue items so in the common case there
  is no allocation needed

Changes since V1:

* Split out and reordered patches so cgroup charging changes are
  separate from kworker -> workqueue change

* Add mem_css to struct loop_cmd to simplify logic

The loop device runs all i/o to the backing file on a separate kworker
thread which results in all i/o being charged to the root cgroup. This
allows a loop device to be used to trivially bypass resource limits
and other policy. This patch series fixes this gap in accounting.

A simple script to demonstrate this behavior on cgroupv2 machine:

'''
#!/bin/bash
set -e

CGROUP=/sys/fs/cgroup/test.slice
LOOP_DEV=/dev/loop0

if [[ ! -d $CGROUP ]]
then
    sudo mkdir $CGROUP
fi

grep oom_kill $CGROUP/memory.events

# Set a memory limit, write more than that limit to tmpfs -> OOM kill
sudo unshare -m bash -c "
echo \$\$ > $CGROUP/cgroup.procs;
echo 0 > $CGROUP/memory.swap.max;
echo 64M > $CGROUP/memory.max;
mount -t tmpfs -o size=512m tmpfs /tmp;
dd if=/dev/zero of=/tmp/file bs=1M count=256" || true

grep oom_kill $CGROUP/memory.events

# Set a memory limit, write more than that limit through loopback
# device -> no OOM kill
sudo unshare -m bash -c "
echo \$\$ > $CGROUP/cgroup.procs;
echo 0 > $CGROUP/memory.swap.max;
echo 64M > $CGROUP/memory.max;
mount -t tmpfs -o size=512m tmpfs /tmp;
truncate -s 512m /tmp/backing_file
losetup $LOOP_DEV /tmp/backing_file
dd if=/dev/zero of=$LOOP_DEV bs=1M count=256;
losetup -D $LOOP_DEV" || true

grep oom_kill $CGROUP/memory.events
'''

Naively charging cgroups could result in priority inversions through
the single kworker thread in the case where multiple cgroups are
reading/writing to the same loop device. This patch series does some
minor modification to the loop driver so that each cgroup can make
forward progress independently to avoid this inversion.

With this patch series applied, the above script triggers OOM kills
when writing through the loop device as expected.

Dan Schatzberg (3):
  loop: Use worker per cgroup instead of kworker
  mm: Charge active memcg when no mm is set
  loop: Charge i/o to mem and blk cg

Johannes Weiner (1):
  mm: support nesting memalloc_use_memcg()

 drivers/block/loop.c                 | 248 ++++++++++++++++++++++-----
 drivers/block/loop.h                 |  14 +-
 fs/buffer.c                          |   6 +-
 fs/notify/fanotify/fanotify.c        |   5 +-
 fs/notify/inotify/inotify_fsnotify.c |   5 +-
 include/linux/memcontrol.h           |   6 +
 include/linux/sched/mm.h             |  28 +--
 kernel/cgroup/cgroup.c               |   1 +
 mm/memcontrol.c                      |  11 +-
 mm/shmem.c                           |   4 +-
 10 files changed, 248 insertions(+), 80 deletions(-)

-- 
2.24.1

