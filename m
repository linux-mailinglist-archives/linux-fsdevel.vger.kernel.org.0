Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9036D50E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbhD1Jyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbhD1Jyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:54:44 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B91C06138A
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:00 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a12so1056660pfc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Apr 2021 02:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XVjixsLTLJGSFLESUPSKkiw4I4YXcT+TC9FDzs+gCA=;
        b=blgKr4FouT87ImEPqykKfSgJEIDTXvFoVNhAWBB5zIo8uOISObsgHvReBYKdv5GCtv
         rib0aeZCZbvNKbiQx9ldgpPQ5QerZp199KxpeuB5dFpzGi1r4Z6lLwDppS0Fx0qPnvTS
         DIRgGVBL1EOlxF73vE45CEmcYRrmBYnu/XBwkKMC5nDm4XRfwrgUz3yMfx11RbaYNq5s
         BkJhr+hZd9jZhn4bqig1cd9lgRo3AqlH27H1UlTHdF6upDQZnMkfTyVG1SHoalkzHFno
         vE3U7HIQ0R67RpYBZScYZCAd87Au3FEmQxeJkCPwiw4ZWzAUuGM8BucDwrraxHqoDIzI
         o8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XVjixsLTLJGSFLESUPSKkiw4I4YXcT+TC9FDzs+gCA=;
        b=d36y1aeSTApu+fNRXDk15t4jcLLVUaoZ9BOeGbyoJ9a2+KqHckDmoc2qgWcJHmXHQQ
         stdRHpQXwvtNVNQKbsjqWqLeAnlQNTyN0ukdwr10zkFNV31U2wRMaoVi4/OnQasdCW2Q
         2jrc6RsEZJBBDfPGHAyImJ85t03VfXCjcPsp23oQ8sS0fg3jh+FvMqcBtKIEk8U0y9ll
         NXiJvSBXBuh3zKMejTJCG24mxws3JXRF8oZQ/vKgOeFuR/xv5A0q6P28t1YnZ4VxWlRw
         jIxeGHz4PRchkk0zx/MZz7ltor+vf29MbRSaI0YyCC6onS9DGLOoHadYdj5Wc/oFBaws
         TaHA==
X-Gm-Message-State: AOAM533T0qupQgx5qghhQwLQbH5LY7FlsgfLY4EjUIG2Oqqa53QamPRS
        28Dv5g90jKES9Y4WdsWoi5xnWQ==
X-Google-Smtp-Source: ABdhPJy7eMSsqpg9mqBYwGXKqweBIOvNTR20P0fg58PUahgtl2RvSFLbuwlpkiW9nkThOcGpuD+u/w==
X-Received: by 2002:a63:6387:: with SMTP id x129mr2578387pgb.58.1619603639829;
        Wed, 28 Apr 2021 02:53:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id x77sm4902365pfc.19.2021.04.28.02.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 02:53:59 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/9] Shrink the list lru size on memory cgroup removal
Date:   Wed, 28 Apr 2021 17:49:40 +0800
Message-Id: <20210428094949.43579-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In our server, we found a suspected memory leak problem. The kmalloc-32
consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
memory.

After our in-depth analysis, the memory consumption of kmalloc-32 slab
cache is the cause of list_lru_one allocation.

  crash> p memcg_nr_cache_ids
  memcg_nr_cache_ids = $2 = 24574

memcg_nr_cache_ids is very large and memory consumption of each list_lru
can be calculated with the following formula.

  num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)

There are 4 numa nodes in our system, so each list_lru consumes ~3MB.

  crash> list super_blocks | wc -l
  952

Every mount will register 2 list lrus, one is for inode, another is for
dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
MB (~5.6GB). But the number of memory cgroup is less than 500. So I
guess more than 12286 containers have been deployed on this machine (I
do not know why there are so many containers, it may be a user's bug or
the user really want to do that). But now there are less than 500
containers in the system. And memcg_nr_cache_ids has not been reduced
to a suitable value. This can waste a lot of memory. If we want to reduce
memcg_nr_cache_ids, we have to reboot the server. This is not what we
want.

So this patchset will dynamically adjust the value of memcg_nr_cache_ids
to keep healthy memory consumption. In this case, we may be able to restore
a healthy environment even if the users have created tens of thousands of
memory cgroups and then destroyed those memory cgroups. This patchset also
contains some code simplification.

Muchun Song (9):
  mm: list_lru: fix list_lru_count_one() return value
  mm: memcontrol: remove kmemcg_id reparenting
  mm: list_lru: rename memcg_drain_all_list_lrus to
    memcg_reparent_list_lrus
  mm: memcontrol: remove the kmem states
  mm: memcontrol: move memcg_online_kmem() to mem_cgroup_css_online()
  mm: list_lru: support for shrinking list lru
  ida: introduce ida_max() to return the maximum allocated ID
  mm: memcontrol: shrink the list lru size
  mm: memcontrol: rename memcg_{get,put}_cache_ids to
    memcg_list_lru_resize_{lock,unlock}

 include/linux/idr.h        |   1 +
 include/linux/list_lru.h   |   2 +-
 include/linux/memcontrol.h |  15 ++----
 lib/idr.c                  |  40 +++++++++++++++
 mm/list_lru.c              |  89 +++++++++++++++++++++++++--------
 mm/memcontrol.c            | 121 +++++++++++++++++++++++++--------------------
 6 files changed, 183 insertions(+), 85 deletions(-)

-- 
2.11.0

