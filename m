Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86114598085
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbiHRJFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 05:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiHRJFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:05:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADB35C964;
        Thu, 18 Aug 2022 02:05:00 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M7f5D5Qk6z1N7L1;
        Thu, 18 Aug 2022 17:01:36 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:04:58 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 18 Aug 2022 17:04:57 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <corbet@lwn.net>, <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <songmuchun@bytedance.com>,
        <mike.kravetz@oracle.com>, <osalvador@suse.de>,
        <surenb@google.com>, <mawupeng1@huawei.com>, <rppt@kernel.org>,
        <charante@codeaurora.org>, <jsavitz@redhat.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 1/2] mm: Cap zone movable's min wmark to small value
Date:   Thu, 18 Aug 2022 17:04:29 +0800
Message-ID: <20220818090430.2859992-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818090430.2859992-1-mawupeng1@huawei.com>
References: <20220818090430.2859992-1-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Since min_free_kbytes is based on gfp_zone(GFP_USER) which does not include
zone movable. However zone movable will get its min share in
__setup_per_zone_wmarks() which does not make any sense.

And like highmem pages, __GFP_HIGH and PF_MEMALLOC allocations usually
don't need movable pages, so there is no need to assign min pages for zone
movable.

Let's cap pages_min for zone movable to a small value here just link
highmem pages.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d3f62316c137..4f62e3d74bf2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8638,7 +8638,7 @@ static void __setup_per_zone_wmarks(void)
 
 	/* Calculate total number of !ZONE_HIGHMEM pages */
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
+		if (!is_highmem(zone) && zone_idx(zone) != ZONE_MOVABLE)
 			lowmem_pages += zone_managed_pages(zone);
 	}
 
@@ -8648,7 +8648,7 @@ static void __setup_per_zone_wmarks(void)
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
 		do_div(tmp, lowmem_pages);
-		if (is_highmem(zone)) {
+		if (is_highmem(zone) || zone_idx(zone) == ZONE_MOVABLE) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
 			 * need highmem pages, so cap pages_min to a small
-- 
2.25.1

