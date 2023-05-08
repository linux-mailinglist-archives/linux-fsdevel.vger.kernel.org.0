Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F076FA030
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjEHGyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 02:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHGyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 02:54:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96983A5DE;
        Sun,  7 May 2023 23:54:48 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QFBkj5rRmzpSyw;
        Mon,  8 May 2023 14:50:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 14:54:45 +0800
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
        <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 01/12] mm: page_alloc: move mirrored_kernelcore into mm_init.c
Date:   Mon, 8 May 2023 15:11:49 +0800
Message-ID: <20230508071200.123962-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Since commit 9420f89db2dd ("mm: move most of core MM initialization
to mm/mm_init.c"), mirrored_kernelcore should be moved into mm_init.c,
as most related codes are already there.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/mm_init.c    | 2 ++
 mm/page_alloc.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 7f7f9c677854..da162b7a044c 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -259,6 +259,8 @@ static int __init cmdline_parse_core(char *p, unsigned long *core,
 	return 0;
 }
 
+bool mirrored_kernelcore __initdata_memblock;
+
 /*
  * kernelcore=size sets the amount of memory for use for allocations that
  * cannot be reclaimed or migrated.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index af9c995d3c1e..d1086aeca8f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -23,7 +23,6 @@
 #include <linux/interrupt.h>
 #include <linux/pagemap.h>
 #include <linux/jiffies.h>
-#include <linux/memblock.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/kasan.h>
@@ -374,8 +373,6 @@ int user_min_free_kbytes = -1;
 int watermark_boost_factor __read_mostly = 15000;
 int watermark_scale_factor = 10;
 
-bool mirrored_kernelcore __initdata_memblock;
-
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
 EXPORT_SYMBOL(movable_zone);
-- 
2.35.3

