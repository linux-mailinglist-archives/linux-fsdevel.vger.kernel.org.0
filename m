Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64CB1B19A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDTWlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTWlX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:41:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84352C061A0C;
        Mon, 20 Apr 2020 15:41:23 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c16so10125395qtv.1;
        Mon, 20 Apr 2020 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYVGKptuNao3T/Cw5MVydseWWvnB3P8P6bY7urNsYE4=;
        b=ZTvAXfQirkhPYwWin4gaTNuQ42l+Obs3whqemoax3hucfHKWlC19ImBWdeBO0MYz9S
         KrjfYP5kNdW+Sg5lblu5swpCyPtMN/naDZ2SlCHqd+5jkTR7aMofBNTfCBzhFPcxS3TB
         tbPix1/O9HErM8CNUqIyTj8QqgF3AO4ZCfjCAKlc3HLIj5a0cYQ68ebLK8yX3baCZihs
         L0iJTd31iGBMC91rn/1DaFPSOakptQYq5ZT5FC16X+JZTM2GMDNsZ34n93sI1+2FybVF
         NxG/Rqg8po4ejbaExawn8ZKMfICTrgTxHOBJOAGW85lEjsUcfSf9AgItY4xRQvkI+Nm+
         dpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYVGKptuNao3T/Cw5MVydseWWvnB3P8P6bY7urNsYE4=;
        b=nx07pM4s/AynQQIhdFNIqt68+qUIaGelLikkq0AO0aApJHNig/g13VIMXtFKQWqsS7
         sPfBhJrRQxIK08Q9tsnce2z9dWQi5vIG7tUckiJixI5yRS5ZuUig2mVtqABfwqGZM015
         uNTBrRwYarW6/dytvlAjEZsRAQ4DY1wIBODIrD7i4GzQrt9TE28Noak1O3Qa9UFVL+ut
         zGW/k+txTjDe0HEyBPSOx+HKI7eeIwbDfP2ie//eIvdpZvPonqLaoEoN9Y2ufi9GfZiO
         Zq/I4QOOqDSc4z/Z7ahpI8jDjnLrQiK5zh7/4d+3ycUW4FU756xfLpGS1ga8lUboDQ2D
         RbFw==
X-Gm-Message-State: AGi0PuZeCu2lHMXiqHBddUbllegsIVe3XOYibJHfAYBno+BNAK1HULQP
        iCfajYJMh/Vj/QyOUyjMHaI=
X-Google-Smtp-Source: APiQypLCIw7/eZknDKLM+t8IKYdj7N+Co65p6dBEo98Q2IzOK0LygWK0Y7J1AaH2soSrsIhgmgtdEA==
X-Received: by 2002:ac8:19fd:: with SMTP id s58mr18784474qtk.354.1587422482527;
        Mon, 20 Apr 2020 15:41:22 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:b0d9])
        by smtp.gmail.com with ESMTPSA id j90sm511052qte.20.2020.04.20.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:41:21 -0700 (PDT)
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
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH 0/4] Charge loop device i/o to issuing cgroup
Date:   Mon, 20 Apr 2020 18:39:28 -0400
Message-Id: <20200420223936.6773-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Dan Schatzberg (4):
  loop: Use worker per cgroup instead of kworker
  mm: support nesting memalloc_use_memcg()
  mm: Charge active memcg when no mm is set
  loop: Charge i/o to mem and blk cg

 drivers/block/loop.c                 | 246 ++++++++++++++++++++++-----
 drivers/block/loop.h                 |  14 +-
 fs/buffer.c                          |   6 +-
 fs/notify/fanotify/fanotify.c        |   5 +-
 fs/notify/inotify/inotify_fsnotify.c |   5 +-
 include/linux/memcontrol.h           |   6 +
 include/linux/sched/mm.h             |  28 +--
 kernel/cgroup/cgroup.c               |   1 +
 mm/memcontrol.c                      |  11 +-
 mm/shmem.c                           |   4 +-
 10 files changed, 246 insertions(+), 80 deletions(-)

-- 
2.24.1

