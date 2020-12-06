Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB582D0283
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgLFKRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgLFKRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:17:37 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257DC0613D4
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:16:51 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so6439558pga.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94t92p220d3blDFDgpx+1JH+mQKvnsugZ3wYNVpL5Pc=;
        b=OwCooS6JnoVJtx0PMPgjcjea2S32p4mWIdoGUfK10OCc8UcA/uXphkjEoq3G+vtn0f
         ianhMPygjhbaQE/k3V2OaW1BPCvnRiB7c60kjzCNDiznenvRfo3NRkDbFvzppX7T45bG
         +S/GHPYj8t8D7DyK5Fnez4Lxt+PBYFWYnE5TtDmGXwXhcyG1D4aT8uet+hzDH3Gz2mL1
         M5pqeyrxjAReO81aNkaTykF1LM8ROq5hBYICb/mxcKNOxUw/yj3JRV6zPOVUsbEzFon+
         mk4KW7TwzPPkNKJJC1tN9AE4eFhUEtIOmpEjVxmXWyl4309sOwlCpJCYw4cq/unUV0Gl
         SIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94t92p220d3blDFDgpx+1JH+mQKvnsugZ3wYNVpL5Pc=;
        b=Km6lFaQM2Zo4sewwmevGhMAGM06D7IdlPLFaEZ25pT9F1E8eCKwHtOsHhmf6bB6MjO
         uOWqMu0fp1lsl3IaWQmPBZwnPQkQ7J22SvLQ+n2FHY4UT/msIiyIKCQQnkCrs29cBFTQ
         1xkikOBzx6FXraLM4PGIqRAINihiPzyio2i1VEJzI3dQ/9voEohN53HZ9XcbvsEu7ju6
         fgsv1TLxF/Y4yb6u8C5GvJkyxC9g4/lBOhOdMkdLQ+Tn627br3VmVM1hZtXu/FXR9eS4
         Aj8lJXrtVMrtqZQtJOXChUxxz4UQQSEA5yejskd3AfQKm33QyjXdhqSyXyj4hjQ0QGNC
         s+5A==
X-Gm-Message-State: AOAM533zSqthLHYdUME57UgfHUiWFHhLPH2a2EVypsjxra7mrPvtQL6U
        EGw02a2F82azGIe0pFyl7BD4tw==
X-Google-Smtp-Source: ABdhPJygi0JR4oQvLA7NT1ZSMHqOoMM6z5pDKFhQ8bzTpyhVcLfaZ3u1c4zB04B4MWkNDwT3gXvHwQ==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr14380078pgm.169.1607249811143;
        Sun, 06 Dec 2020 02:16:51 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id g16sm10337657pfb.201.2020.12.06.02.16.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 02:16:50 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RESEND PATCH v2 00/12] Convert all vmstat counters to pages or bytes
Date:   Sun,  6 Dec 2020 18:14:39 +0800
Message-Id: <20201206101451.14706-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series is aimed to convert all THP vmstat counters to pages
and some KiB vmstat counters to bytes.

The unit of some vmstat counters are pages, some are bytes, some are
HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
counters to the userspace, we have to know the unit of the vmstat counters
is which one. It makes the code complex. Because there are too many choices,
the probability of making a mistake will be greater.

For example, the below is some bug fix:
  - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
  - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")

This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
And make the unit of the vmstat counters are either pages or bytes. Fewer choices
means lower probability of making mistakes :).

This was inspired by Johannes and Roman. Thanks to them.

Changes in v1 -> v2:
  - Change the series subject from "Convert all THP vmstat counters to pages"
    to "Convert all vmstat counters to pages or bytes".
  - Convert NR_KERNEL_SCS_KB account to bytes.
  - Convert vmstat slab counters to bytes.
  - Remove {global_}node_page_state_pages.

Muchun Song (12):
  mm: memcontrol: fix NR_ANON_THPS account
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: convert kernel stack account to bytes
  mm: memcontrol: convert NR_KERNEL_SCS_KB account to bytes
  mm: memcontrol: convert vmstat slab counters to bytes
  mm: memcontrol: scale stat_threshold for byted-sized vmstat
  mm: memcontrol: make the slab calculation consistent
  mm: memcontrol: remove {global_}node_page_state_pages

 drivers/base/node.c     |  25 ++++-----
 fs/proc/meminfo.c       |  22 ++++----
 include/linux/mmzone.h  |  21 +++-----
 include/linux/vmstat.h  |  21 ++------
 kernel/fork.c           |   8 +--
 kernel/power/snapshot.c |   2 +-
 kernel/scs.c            |   4 +-
 mm/filemap.c            |   4 +-
 mm/huge_memory.c        |   9 ++--
 mm/khugepaged.c         |   4 +-
 mm/memcontrol.c         | 131 ++++++++++++++++++++++++------------------------
 mm/oom_kill.c           |   2 +-
 mm/page_alloc.c         |  17 +++----
 mm/rmap.c               |  19 ++++---
 mm/shmem.c              |   3 +-
 mm/vmscan.c             |   2 +-
 mm/vmstat.c             |  54 ++++++++------------
 17 files changed, 161 insertions(+), 187 deletions(-)

-- 
2.11.0

