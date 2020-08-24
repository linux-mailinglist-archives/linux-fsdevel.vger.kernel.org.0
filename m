Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAA250142
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHXPhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHXPhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:37:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD18C061573;
        Mon, 24 Aug 2020 08:37:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so3898423qvk.6;
        Mon, 24 Aug 2020 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+WnIm5e3oaEHejxIohJMS0+jhs86DYl8gpbwJYmAik=;
        b=SRNEANR+EJUu/Zk2lbQct/0WbyEkqf2pDiydLArXO1FjTP3+dyQbZb5cme0fCcadXc
         OiFYofGExGKW448nn7uE+JN14cRscm1+HaD8u86lr15zUszZGT9Pcd+acpXYZV/p+vKL
         E51D0SLFRHLJcLebrCRFqIuWZCjtfYAl6CMo9rhWPV4MnTmMM7r+aca3EyM64nyOwYT6
         pDp2BEydP35vDC0pbt3gzjsa9AiW4VqaKmzVoaCLi03yhZe1aL430W3wWlkDKVLHMq8t
         eIjW/ApOprDE/v2vKEJgj7tOW7L1ZV8eFFsHj6BmSxI13i4G+85BRhLUMHFRq00I05E5
         Vbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R+WnIm5e3oaEHejxIohJMS0+jhs86DYl8gpbwJYmAik=;
        b=J+t/rQymt2BI4crCsI2RvmjNgPeIF++scdBk4OuuaamdPHyXsMTYEMFi6C+zwy/ADa
         XLQFO9EBIZrTKqEwtMAKvJEZbbCsnYpOD5x8enFIeivO2G5irmZ4n0nN3v7EVwklFdfm
         YMS1T54lnVecASncJos2vB58KJoqlXzdsDlWrGuhA98veiTfIY3VsplU0uPTJYGMHEN+
         8seXPyvHMNi4qx5eiQ196QKr0sjGMbrxahLCpWTnvncxzq52jT2RIHo+vPwTSfgvoCeE
         SPBzZxXllplpgv1DfTd6PUeNC0xEGVIcs5mW/YOSxQg1aZERoH6XilDve/6v4VRfg7Ay
         4FjQ==
X-Gm-Message-State: AOAM532SLEIZ8yE4xzoKtKyQUozpjo2K9MphXZazI17kWaccwINWqhNT
        A92D2Xf+mOcma3ueU6XjEXg=
X-Google-Smtp-Source: ABdhPJyCkEYCo3MtdQiF5GUBFIBN/888a4pv+196Xxoe+h/IaEsTQWgG71kxxVvbnJOBBJJdhoRpKA==
X-Received: by 2002:ad4:5812:: with SMTP id dd18mr5401314qvb.23.1598283450715;
        Mon, 24 Aug 2020 08:37:30 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.thefacebook.com ([2620:10d:c091:480::1:dd21])
        by smtp.gmail.com with ESMTPSA id m17sm10942758qkn.45.2020.08.24.08.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:37:29 -0700 (PDT)
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
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michel Lespinasse <walken@google.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list),
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)),
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-mm@kvack.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Subject: [PATCH v7 0/4] Charge loop device i/o to issuing cgroup
Date:   Mon, 24 Aug 2020 11:35:58 -0400
Message-Id: <20200824153607.6595-1-schatzberg.dan@gmail.com>
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

Note that patch 2 in this series (mm: support nesting
memalloc_use_memcg()) has also been submitted by Roman Guschchin to
the mm tree and can be seen here:
http://lkml.iu.edu/hypermail/linux/kernel/2008.2/09214.html - I
include it here for completeness, but this series works with either
version of the patch.

Changes since V7:

* Rebased against linus's branch

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

 drivers/block/loop.c                 | 248 ++++++++++++++++++++++-----
 drivers/block/loop.h                 |  15 +-
 fs/buffer.c                          |   6 +-
 fs/notify/fanotify/fanotify.c        |   5 +-
 fs/notify/inotify/inotify_fsnotify.c |   5 +-
 include/linux/memcontrol.h           |   6 +
 include/linux/sched/mm.h             |  28 +--
 kernel/cgroup/cgroup.c               |   1 +
 mm/memcontrol.c                      |  17 +-
 mm/shmem.c                           |   4 +-
 10 files changed, 253 insertions(+), 82 deletions(-)

-- 
2.24.1

