Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034B41E62F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390651AbgE1NzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 09:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390552AbgE1NzH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 09:55:07 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD4C08C5C6;
        Thu, 28 May 2020 06:55:07 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id z9so12886692qvi.12;
        Thu, 28 May 2020 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeTtPJIfmEr7+1bwUpo3zXUUHr8dPGmrm3c30JGLdGU=;
        b=ci2fVkIpO6vUrWQ+KPwvraonqaR1XyJziqp5JUW4sIW1Gu/NLvjcGlVKd/PaxQrttM
         ZGUhgzcdPxuWfC8HD+qVZ1dm11OS375pLyKbskIpwk+ddCBSsfzEOdG8PzPm1mb1ELun
         19U9X5BBJBlZhfOe5C14CJgk5ZhmI4ETE2BuPdfgUWNCKQa75nuuFWKOs506SqCTip9x
         PyWUeyZN5xK3HqfgrMWvVmwiW/Uv8NchdURxQWhkh+d+gJlB37nyXWmNI9VXJT87kYrv
         cLiLY8xpj+QPlxPt8c5RFGZ0HzNllWT/Ds/UcdzPsQRc6uNzzOkoN/kE0MXx6e8XsmBm
         fYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeTtPJIfmEr7+1bwUpo3zXUUHr8dPGmrm3c30JGLdGU=;
        b=N//wRnRq1jMxP9xplhdCDpUU/arJQam2sF6WV4tD8CvMNITuvhRE7YfYmxKgivxXCa
         gxWTgWb1si5LzVBbPQyUM9c761GX3Liimgs6BTZq76t2kHhHoZgJlAD1E2rERoF2QTi7
         ph4YMyQGvrK+Ue7dHAHssgIL4KBH24ofS3UYP4/AGFlWpWvJl2KrgJ2VFFUBZD+zKPK9
         VSumVKnLXdBb7xjOJPcBXPS4xeWW/ubBEDxfRLaTbS47MsLODUE8Z22G2r7Ki3Bg1M43
         PuAW+w4MVyVPnUtRR0Z1soRuthXiyjzyn9qSrVHoIJrYSCgTSYvReAzSwsYvZ3Zh6kV4
         2X8g==
X-Gm-Message-State: AOAM531XChY+j7eO4k6SVWVUfwC5duReLeH7sOE4n0N9yVn6NgaJ2IS4
        0MOwvONrK7xyJot1z9ykW+swnjqkC+E=
X-Google-Smtp-Source: ABdhPJw0I4eQ626R1lrou885QwlV5+buIMLht9Z1fnUA0WfY+zKV07/wltIpwOCR15oRJkrnVW9Tzg==
X-Received: by 2002:ad4:4c4f:: with SMTP id cs15mr2987571qvb.117.1590674106652;
        Thu, 28 May 2020 06:55:06 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:1cb7])
        by smtp.gmail.com with ESMTPSA id l186sm4890889qkf.89.2020.05.28.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:55:05 -0700 (PDT)
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
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v6 0/4] Charge loop device i/o to issuing cgroup
Date:   Thu, 28 May 2020 09:54:35 -0400
Message-Id: <20200528135444.11508-1-schatzberg.dan@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Much of the discussion about this has died down. There's been a
concern raised that we could generalize infrastructure across loop,
md, etc. This may be possible, in the future, but it isn't clear to me
how this would look like. I'm inclined to fix the existing issue with
loop devices now (this is a problem we hit at FB) and address
consolidation with other cases if and when those need to be addressed.

Changes since V6:

* Added separate spinlock for worker synchronization
* Minor style changes

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

 drivers/block/loop.c                 | 244 ++++++++++++++++++++++-----
 drivers/block/loop.h                 |  15 +-
 fs/buffer.c                          |   6 +-
 fs/notify/fanotify/fanotify.c        |   5 +-
 fs/notify/inotify/inotify_fsnotify.c |   5 +-
 include/linux/memcontrol.h           |   6 +
 include/linux/sched/mm.h             |  28 +--
 kernel/cgroup/cgroup.c               |   1 +
 mm/memcontrol.c                      |  11 +-
 mm/shmem.c                           |   4 +-
 10 files changed, 246 insertions(+), 79 deletions(-)

-- 
2.24.1

