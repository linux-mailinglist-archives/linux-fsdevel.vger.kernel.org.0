Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDA4704516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 08:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEPGVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEPGVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 02:21:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E2726BF;
        Mon, 15 May 2023 23:21:31 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QL5f45G4jzLq2Y;
        Tue, 16 May 2023 14:18:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:28 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v2 00/13] mm: page_alloc: misc cleanup and refector
Date:   Tue, 16 May 2023 14:38:08 +0800
Message-ID: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is aim to reduce more space in page_alloc.c, also do some
cleanup, no functional changes intended.

This is based on next-20230515.

v2: 
- drop move of __pageblock_pfn_to_page(), suggested by Huang Ying
- move __show_mem() below the __show_free_areas() in patch4
- add new patch13
- add RB from Mike

Kefeng Wang (13):
  mm: page_alloc: move mirrored_kernelcore into mm_init.c
  mm: page_alloc: move init_on_alloc/free() into mm_init.c
  mm: page_alloc: move set_zone_contiguous() into mm_init.c
  mm: page_alloc: collect mem statistic into show_mem.c
  mm: page_alloc: squash page_is_consistent()
  mm: page_alloc: remove alloc_contig_dump_pages() stub
  mm: page_alloc: split out FAIL_PAGE_ALLOC
  mm: page_alloc: split out DEBUG_PAGEALLOC
  mm: page_alloc: move mark_free_page() into snapshot.c
  mm: page_alloc: move pm_* function into power
  mm: vmscan: use gfp_has_io_fs()
  mm: page_alloc: move sysctls into it own fils
  mm: page_alloc: move is_check_pages_enabled() into page_alloc.c

 include/linux/fault-inject.h   |   9 +
 include/linux/gfp.h            |  15 +-
 include/linux/memory_hotplug.h |   3 -
 include/linux/mm.h             |  87 ++--
 include/linux/mmzone.h         |  21 -
 include/linux/suspend.h        |   9 +-
 kernel/power/main.c            |  27 ++
 kernel/power/power.h           |   5 +
 kernel/power/snapshot.c        |  52 +++
 kernel/sysctl.c                |  67 ---
 lib/Makefile                   |   2 +-
 lib/show_mem.c                 |  37 --
 mm/Makefile                    |   4 +-
 mm/debug_page_alloc.c          |  59 +++
 mm/fail_page_alloc.c           |  66 +++
 mm/internal.h                  |  21 +-
 mm/mm_init.c                   |  32 ++
 mm/page_alloc.c                | 799 ++++-----------------------------
 mm/show_mem.c                  | 429 ++++++++++++++++++
 mm/swapfile.c                  |   1 +
 mm/vmscan.c                    |   2 +-
 21 files changed, 857 insertions(+), 890 deletions(-)
 delete mode 100644 lib/show_mem.c
 create mode 100644 mm/debug_page_alloc.c
 create mode 100644 mm/fail_page_alloc.c
 create mode 100644 mm/show_mem.c

-- 
2.35.3

