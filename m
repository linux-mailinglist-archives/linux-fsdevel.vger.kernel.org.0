Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E6E2DCB64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 04:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgLQDqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 22:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgLQDqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 22:46:15 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A5DC0617B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:45:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m5so3306001pjv.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Dec 2020 19:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4lGSGZVjS2zM9d6QEvl1MhzyKEShz6mJMJJf7kQ2hE=;
        b=RNf3Dpg13GyOC+Rnz6oHHcpZJm6x4wLec34gX8LW2PY+tgTEHYPASoLI3SjWpyuvpr
         PJKZITynoHyKerkjOraWy8X6GU1t/uh7J7krDDvDGTvX8NMpdMupZuMDenJknjMQrxIO
         gqsUZf1p6a1RnIjVIuCggKuEkiRmD6t1nCPPWA/q5BtIcwjxJJcwwEDPKzWA3NMR8r1T
         sF6dtSg5yKKij6ZsXMchNYGUrP/54jW5LFsMCzMpl8AlrDas2jXmN61q10diZCpGe0oJ
         HZ94nYZ0FNWOK/3oGaxwNf5gL2oWaf19zJ90XfdN7aZkgrl9n9EkcRwCWNn8wrFblc7E
         sdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o4lGSGZVjS2zM9d6QEvl1MhzyKEShz6mJMJJf7kQ2hE=;
        b=YRi0RVfe2GddANfp8pSKdsG/GlwLMEY4HW++DpHB3OA+eJvxqiewoPhDyvDBf2ll/F
         aNQgIuZSJOpMbUZWH2LFOTT7NYFLbkISsQqdoTZOo6AP3y7vu7IDrp4EZcenzsIOZ/rc
         PiAVR+HA6QhidgRHJ5FArg0I7E0xu/jzEqBNQU8QZKVlwodxmrKd3jeYlDjjsZDgvyMx
         vqWEqUijVmYWSZfrG7lM3aRpvImuL+FQfvJhCTw4KZgbc8Oafu3G/4A8s0+BmiH+H0tD
         qEkcIAGuiAzD6LXV+Z3JflbJn7nrB87M/+bsO6pa+2eOJTvhr/UlWorTeKDeoJxUfhYs
         VPUQ==
X-Gm-Message-State: AOAM533mxkXbPgpN2hVtzw9WaBaQWPWNp8DZh/WnKDuLYQU0waNKzSiN
        fvv5p5ymBY8KTi9qRLEPKbFvJQ==
X-Google-Smtp-Source: ABdhPJxLSVMDVAZYEz3Ed50Gw3WMb56PvS+zSziMjU8RzLK8WmLR9X058TqqCeEh1d6UY/e6Mof2zg==
X-Received: by 2002:a17:902:76c2:b029:dc:1aa4:28f1 with SMTP id j2-20020a17090276c2b02900dc1aa428f1mr4474288plt.79.1608176734812;
        Wed, 16 Dec 2020 19:45:34 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b2sm3792412pfo.164.2020.12.16.19.45.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 19:45:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 0/7] Convert all THP vmstat counters to pages
Date:   Thu, 17 Dec 2020 11:43:49 +0800
Message-Id: <20201217034356.4708-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is aimed to convert all THP vmstat counters to pages.

The unit of some vmstat counters are pages, some are bytes, some are
HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
counters to the userspace, we have to know the unit of the vmstat counters
is which one. When the unit is bytes or kB, both clearly distinguishable
by the B/KB suffix. But for the THP vmstat counters, we may make mistakes.

For example, the below is some bug fix for the THP vmstat counters:

  - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
  - The first commit in this series ("fix NR_ANON_THPS accounting in charge moving")

This patch series can make the code clear. And make all the unit of the THP
vmstat counters in pages. Finally, the unit of the vmstat counters are
pages, kB and bytes. The B/KB suffix can tell us that the unit is bytes
or kB. The rest which is without suffix are pages.

In this series, I changed the following vmstat counters unit from HPAGE_PMD_NR
to pages. However, there is no change to the print format of output to user
space.

  - NR_ANON_THPS
  - NR_FILE_THPS
  - NR_SHMEM_THPS
  - NR_SHMEM_PMDMAPPED
  - NR_FILE_PMDMAPPED

Doing this also can make the statistics more accuracy for the THP vmstat
counters. This series is consistent with 8f182270dfec ("mm/swap.c: flush lru
pvecs on compound page arrival").

Because we use struct per_cpu_nodestat to cache the vmstat counters, which
leads to inaccurate statistics expecially THP vmstat counters. In the systems
with hundreads of processors it can be GBs of memory. For example, for a 96
CPUs system, the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will add 512 worth of
memory in one go) so skipping the batching seems like sensible. Although every
THP stats update overflows the per-cpu counter, resorting to atomic global
updates. But it can make the statistics more accuracy for the THP vmstat
counters. From this point of view, I think that do this converting is
reasonable.

Thanks Hugh for mentioning this. This was inspired by Johannes and Roman.
Thanks to them.

Changes in v4 -> v5:
  - Add motivation to each patch. Thanks to Michal.
  - Replace some HPAGE_PMD_NR to thp_nr_pages(). Thanks to Matthew.

Changes in v3 -> v4:
  - Rename the first commit subject to "mm: memcontrol: fix NR_ANON_THPS
    accounting in charge moving".
  - Fix /proc/vmstat printing. Thanks to Johannes points out that.

Changes in v2 -> v3:
  - Change the series subject from "Convert all vmstat counters to pages or bytes"
    to "Convert all THP vmstat counters to pages".
  - Remove convert of KB to B.

Changes in v1 -> v2:
  - Change the series subject from "Convert all THP vmstat counters to pages"
    to "Convert all vmstat counters to pages or bytes".
  - Convert NR_KERNEL_SCS_KB account to bytes.
  - Convert vmstat slab counters to bytes.
  - Remove {global_}node_page_state_pages.

Muchun Song (7):
  mm: memcontrol: fix NR_ANON_THPS accounting in charge moving
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: make the slab calculation consistent

 drivers/base/node.c    |  27 +++++-----
 fs/proc/meminfo.c      |  10 ++--
 include/linux/mmzone.h |  14 ++++++
 mm/filemap.c           |   4 +-
 mm/huge_memory.c       |  11 +++--
 mm/khugepaged.c        |   6 ++-
 mm/memcontrol.c        | 132 +++++++++++++++++++++++--------------------------
 mm/page_alloc.c        |   7 ++-
 mm/rmap.c              |  26 ++++++----
 mm/shmem.c             |   2 +-
 mm/vmstat.c            |  11 ++++-
 11 files changed, 139 insertions(+), 111 deletions(-)

-- 
2.11.0

