Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BE12CC50D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 19:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgLBS2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 13:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgLBS2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:28:24 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22159C0613D4;
        Wed,  2 Dec 2020 10:27:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o5so1588693pgm.10;
        Wed, 02 Dec 2020 10:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPUJqKT+rkHACEMpGAQum8di0Ws4JYffAd5w5aHw2rI=;
        b=ElyLCjlAQAduXezNjqhhuefSlpuw1NkvEd5SjEqiJnHNYqvcUUF99AnicMJUJcVPEe
         QvGdSBsy0R45S+QJsdkxMinwtn2S2BRQpA0OAQUjbgWUxlbXy0TMCOG9XtA42tkJlLQe
         7C3NwJxhLG/Fz5WRXjy09HQBv2AaB46RV5LnW1jNkP4CvhBzeNe1dhpviwSSwvwVtboE
         0Ne8ux9AKjgd6z/XkPiZte+qqpD7vlW29sTg2Rv96rWx3QSpx2EwVHM5svu9CuTj/9yD
         +R+MYbEZq+jq39YfPn7L0TMTS0F9yoNKJJEl+i8faQ80tYN8lU9R1TmnLx0VxMNTZxTZ
         s7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPUJqKT+rkHACEMpGAQum8di0Ws4JYffAd5w5aHw2rI=;
        b=CYQMzBM8pQPE7aJe9xlD+ICV6PDDQ1gBpju7wopeP2bJxIfI+lmobehuRxeL9iHLHN
         1g/8Uiu1eObDp7o2dKuuhRwffzJU2ao3uWxgvv4f/MCV4GqG3/2DhLPJvx7PpijyCeye
         aYHfq/7b0flFxnK4d1qr//H7nxJn83r2I1PWhIiMi5Ey9x6Jbcn2sR+QLirikewr5NKz
         m7pK3FyLSkOSTjqdv3dgfJCU+qEIMe6iL5aH0/Ep3NoB6z4tiJQ/lI1+zkY/3y17imhP
         2VpxYY3Vl+dzKM8mWy/7l14l7j1X3QZMLnLGP+MWynYLVIZa6Y4wO/cA/UY4IMhhsMKL
         K5PQ==
X-Gm-Message-State: AOAM531MGtBbzUDpzUol0uLEbt1v8DwI/spEKdtICP49lY8N399y2q6K
        B379DS2mpjt9khk6XingY/Y=
X-Google-Smtp-Source: ABdhPJwYWGE7dLKsWpSZmFuQx6d97dcM5aQ/qOsjvjSurQHw4pRNyPNc27xhud8+yIlEICAB2bY4yw==
X-Received: by 2002:a63:5322:: with SMTP id h34mr1044243pgb.95.1606933663610;
        Wed, 02 Dec 2020 10:27:43 -0800 (PST)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id c6sm396906pgl.38.2020.12.02.10.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:27:42 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     guro@fb.com, ktkhai@virtuozzo.com, shakeelb@google.com,
        david@fromorbit.com, hannes@cmpxchg.org, mhocko@suse.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] Make shrinker's nr_deferred memcg aware
Date:   Wed,  2 Dec 2020 10:27:16 -0800
Message-Id: <20201202182725.265020-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
it turned out there were huge amount accumulated nr_deferred objects seen by the
shrinker.

On our production machine, I saw absurd number of nr_deferred shown as the below
tracing result: 

<...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
9300 cache items 1667 delta 11 total_scan 833

There are 2.5 trillion deferred objects on one node, assuming all of them
are dentry (192 bytes per object), so the total size of deferred on
one node is ~480TB. It is definitely ridiculous.

I managed to reproduce this problem with kernel build workload plus negative dentry
generator.

First step, run the below kernel build test script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

cd /root/Buildarea/linux-stable

for i in `seq 1500`; do
        cgcreate -g memory:kern_build
        echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes

        echo 3 > /proc/sys/vm/drop_caches
        cgexec -g memory:kern_build make clean > /dev/null 2>&1
        cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1

        cgdelete -g memory:kern_build
done

Then run the below negative dentry generator script:

NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`

mkdir /sys/fs/cgroup/memory/test
echo $$ > /sys/fs/cgroup/memory/test/tasks

for i in `seq $NR_CPUS`; do
        while true; do
                FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
                cat $FILE 2>/dev/null
        done &
done

Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
showed:

	kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
	kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928

There were huge number of deferred objects before the shrinker was called, the behavior
does match the code but it might be not desirable from the user's stand of point.

The excessive amount of nr_deferred might be accumulated due to various reasons, for example:
    * GFP_NOFS allocation
    * Significant times of small amount scan (< scan_batch, 1024 for vfs metadata)

However the LRUs of slabs are per memcg (memcg-aware shrinkers) but the deferred objects
is per shrinker, this may have some bad effects:
    * Poor isolation among memcgs. Some memcgs which happen to have frequent limit
      reclaim may get nr_deferred accumulated to a huge number, then other innocent
      memcgs may take the fall. In our case the main workload was hit.
    * Unbounded deferred objects. There is no cap for deferred objects, it can outgrow
      ridiculously as the tracing result showed.
    * Easy to get out of control. Although shrinkers take into account deferred objects,
      but it can go out of control easily. One misconfigured memcg could incur absurd 
      amount of deferred objects in a period of time.
    * Sort of reclaim problems, i.e. over reclaim, long reclaim latency, etc. There may be
      hundred GB slab caches for vfe metadata heavy workload, shrink half of them may take
      minutes. We observed latency spike due to the prolonged reclaim.

These issues also have been discussed in https://lore.kernel.org/linux-mm/20200916185823.5347-1-shy828301@gmail.com/.
The patchset is the outcome of that discussion.

So this patchset makes nr_deferred per-memcg to tackle the problem. It does:
    * Have memcg_shrinker_deferred per memcg per node, just like what shrinker_map
      does. Instead it is an atomic_long_t array, each element represent one shrinker
      even though the shrinker is not memcg aware, this simplifies the implementation.
      For memcg aware shrinkers, the deferred objects are just accumulated to its own
      memcg. The shrinkers just see nr_deferred from its own memcg. Non memcg aware
      shrinkers still use global nr_deferred from struct shrinker.
    * Once the memcg is offlined, its nr_deferred will be reparented to its parent along
      with LRUs.
    * The root memcg has memcg_shrinker_deferred array too. It simplifies the handling of
      reparenting to root memcg.
    * Cap nr_deferred to 2x of the length of lru. The idea is borrowed from Dave Chinner's
      series (https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/)

The downside is each memcg has to allocate extra memory to store the nr_deferred array.
On our production environment, there are typically around 40 shrinkers, so each memcg
needs ~320 bytes. 10K memcgs would need ~3.2MB memory. It seems fine.

We have been running the patched kernel on some hosts of our fleet (test and production) for
months, it works very well. The monitor data shows the working set is sustained as expected.

Yang Shi (9):
      mm: vmscan: simplify nr_deferred update code
      mm: vmscan: use nid from shrink_control for tracepoint
      mm: memcontrol: rename memcg_shrinker_map_mutex to memcg_shrinker_mutex
      mm: vmscan: use a new flag to indicate shrinker is registered
      mm: memcontrol: add per memcg shrinker nr_deferred
      mm: vmscan: use per memcg nr_deferred of shrinker
      mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
      mm: memcontrol: reparent nr_deferred when memcg offline
      mm: vmscan: shrink deferred objects proportional to priority

 include/linux/memcontrol.h |   9 +++++
 include/linux/shrinker.h   |   8 ++++
 mm/memcontrol.c            | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 mm/vmscan.c                | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 4 files changed, 274 insertions(+), 74 deletions(-)

