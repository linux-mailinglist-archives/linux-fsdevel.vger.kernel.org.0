Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0F2D01A8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 09:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgLFI0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 03:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgLFI0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:26:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0BCC0613D1
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 00:25:26 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b26so6923889pfi.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94t92p220d3blDFDgpx+1JH+mQKvnsugZ3wYNVpL5Pc=;
        b=aPEbZU4OyEStT3F68E8ntmWaoqDSzRPfxpNag1nustiini6Rf/h8SsWgNHnv4nMhTc
         R5+L+leR3yh0p1Z46A9wM4d+nzaY/GgZwJyBPEZPXBgMmUXiV5wBRVBZSxvRYxmjxtLd
         v6lQLZXZNUK0DIQFDR2uuU3dQVm3JJDOD6FYURZgGlVg+xMUJhlcxhvFjvsg8lWGFxJA
         kfXZFS/lzxEWbrwnrtvgXNPh/EKiZqJEIv6TnJu1UodsK0tRvuYxzOJQqSBbIBLxFmXR
         3fhfx5Shes7y2EfZXI2Wc1yj+ikUveMtDJd2DyrJNw9155Ig/QQ4g8lwQh8IyrOAfG8a
         nFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94t92p220d3blDFDgpx+1JH+mQKvnsugZ3wYNVpL5Pc=;
        b=gUEdX5fL87Fw2CpFhuPXuPcl3YM3Ca7u7ZYDD53htNcf7kLia83peTtl7JCbEhA4dC
         FtDRY4NVowBjZZUbCf89w3F4hLUWdBsp21jHfLG73AG1EeODiViLhIp+12fp0dmyI64X
         5OHdvv6NOw68+5RhcJP0KymSZIrAeDfIgPry1ODbd7ObxylcUw0BpTJ4H7fwRljgm+Fn
         r+gTg5sKB3pLbTzitG1/3ikH9dmTRRuba4rGVO/SFqKpgtq101cXEXqe6nND4dk3dOu9
         BbgkQ/qNewhONP/95WvYHpS6S4BoKuK5R+cRoT/Kyf9UIRgrPXMeLWgALWDBT3RBk07h
         n1XQ==
X-Gm-Message-State: AOAM532tbMhk34Zgrkr5Ln7jmQ0EXM5QQFvGld8wbcO0nezw/O6/Uq5o
        xse20zm0iArwD+sOU2PX8bxdJA==
X-Google-Smtp-Source: ABdhPJx9N52V9X/vLGy1rmg1UsEWFvMmYT4HwbKlcPc26xtBH3Uc9GcECnSQRz8S83pEQJd6sID7Iw==
X-Received: by 2002:a63:48f:: with SMTP id 137mr14064045pge.172.1607243125546;
        Sun, 06 Dec 2020 00:25:25 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:25:24 -0800 (PST)
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
Subject: [PATCH v2 00/12] Convert all vmstat counters to pages or bytes
Date:   Sun,  6 Dec 2020 16:22:57 +0800
Message-Id: <20201206082318.11532-1-songmuchun@bytedance.com>
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

