Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88FD2CFCA0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgLEQxA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgLEQsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:48:21 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C985C094240
        for <linux-fsdevel@vger.kernel.org>; Sat,  5 Dec 2020 05:02:44 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id j13so4775267pjz.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Dec 2020 05:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rn/xJo/gyofLtl+hMU5/+p5RPWpj2PYm655A9wivV4I=;
        b=uba4FH2KhW8Vj9ZYwLUzGFQb0rHgkyFMDpdk3RQHbve17Sp28OLnmrjvqmSb7sYkVZ
         GM2sEhv8//q4hMDDw9bSK+KF1xViMm8tK+G62u/ihXhQtDR6S3MrhvCimce8xo/v1yJc
         bg3/PyxdoGBF2fi20Nbuv+ATPqryNxDZ9soMAkuMxesk34ZbmkQaPxkCzT1BRg3imlEF
         kHEnEc6Y3U3Yo7Oz6xkqjTlFZivTKMRGE7SfVIN3QNGkJTujq9fRG70Z4Kun2RCad9XO
         X4JErJiw7JPjNFWAM6zaHsdGTbDzc6tcn0DKBJmA+DptSICQMiH/IjugkoJWDToHLNgH
         pnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rn/xJo/gyofLtl+hMU5/+p5RPWpj2PYm655A9wivV4I=;
        b=uQXMSbp4t5CyjRSW2tNuAqz5NIRS0UdzJPQHuARCqhnwokCx5UIa4NuFbFGe/FDkqb
         XYXIDDlmaATmeQglrwoQ69kDh/c56C/32M5qRxe2eJYjp4kGmk9Nt/fvU0nnndzh43OS
         VsF5EhbBAfynEwINxX0szpuita75UxWXH9Abxti56By9z40hNSnPMb7ii6nLHKfBmluU
         Gpy9gSe9QnGv+P6AvXvdj0ezo9LfRsSac5lyLcdVLX7bszORONmL0qBUsEC2jcyR39c4
         PT2l4PfVIr+DGCk1GAjB6R+FVkYcP1pQMkjo7v4xJE9ijL5Nqdv8RS/bWrX8yzJ9L+bR
         shWg==
X-Gm-Message-State: AOAM532a6j02bpBC1mmt1hkbPELZm390PWsMs+QcDpI2XJXfVlnRSOVY
        0gaDCuCpn1B5xoROa1c/AI/8oA==
X-Google-Smtp-Source: ABdhPJzesxeGGDvJ6298vhkaq+apmgQA98LkQl9wETTVy6v3xPgS/qblIYX2OypmegrKOQWCvLnThg==
X-Received: by 2002:a17:902:a504:b029:d8:ebc7:a864 with SMTP id s4-20020a170902a504b02900d8ebc7a864mr8059651plq.60.1607173363065;
        Sat, 05 Dec 2020 05:02:43 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:02:42 -0800 (PST)
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
Subject: [PATCH 0/9] Convert all THP vmstat counters to pages
Date:   Sat,  5 Dec 2020 21:02:15 +0800
Message-Id: <20201205130224.81607-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This patch series is aimed to convert all THP vmstat counters to pages
and the kernel stack vmstat counter to bytes.

The unit of some vmstat counters are pages, the unit of some vmstat counters
are bytes, the unit of some vmstat counters are HPAGE_PMD_NR, and the unit
of some vmstat counters are KiB. When we want to expose these vmstat counters
to the userspace, we have to know the unit of the vmstat counters is which
one. It makes the code complex.

This patch series can make the code simple. And the unit of the vmstat
counters are either pages or bytes.

This was inspired by Johannes and Roman. Thanks to them.

Muchun Song (9):
  mm: vmstat: fix stat_threshold for NR_KERNEL_STACK_KB
  mm: memcontrol: fix NR_ANON_THPS account
  mm: memcontrol: convert kernel stack account to byte-sized
  mm: memcontrol: convert NR_ANON_THPS account to pages
  mm: memcontrol: convert NR_FILE_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_THPS account to pages
  mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
  mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
  mm: memcontrol: make the slab calculation consistent

 drivers/base/node.c    |  17 +++---
 fs/proc/meminfo.c      |  12 ++---
 include/linux/mmzone.h |   2 +-
 kernel/fork.c          |   8 +--
 mm/filemap.c           |   4 +-
 mm/huge_memory.c       |   9 ++--
 mm/khugepaged.c        |   4 +-
 mm/memcontrol.c        | 139 +++++++++++++++++++++++++------------------------
 mm/page_alloc.c        |   9 ++--
 mm/rmap.c              |  19 ++++---
 mm/shmem.c             |   3 +-
 mm/vmstat.c            |   4 ++
 12 files changed, 120 insertions(+), 110 deletions(-)

-- 
2.11.0

