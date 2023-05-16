Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5370453A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjEPGWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 02:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjEPGV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 02:21:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD05468F;
        Mon, 15 May 2023 23:21:40 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QL5cb0cKzzqSMx;
        Tue, 16 May 2023 14:17:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:37 +0800
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
Subject: [PATCH v2 13/13] mm: page_alloc: move is_check_pages_enabled() into page_alloc.c
Date:   Tue, 16 May 2023 14:38:21 +0800
Message-ID: <20230516063821.121844-14-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
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

The is_check_pages_enabled() only used in page_alloc.c, move it into
page_alloc.c, also use it in free_tail_page_prepare().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/internal.h   | 5 -----
 mm/page_alloc.c | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5fdf930a87b5..bb6542279599 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -208,11 +208,6 @@ extern char * const zone_names[MAX_NR_ZONES];
 /* perform sanity checks on struct pages being allocated or freed */
 DECLARE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
-static inline bool is_check_pages_enabled(void)
-{
-	return static_branch_unlikely(&check_pages_enabled);
-}
-
 extern int min_free_kbytes;
 
 void setup_per_zone_wmarks(void);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e8680669388..1023f41de2fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -983,6 +983,11 @@ static inline bool free_page_is_bad(struct page *page)
 	return true;
 }
 
+static inline bool is_check_pages_enabled(void)
+{
+	return static_branch_unlikely(&check_pages_enabled);
+}
+
 static int free_tail_page_prepare(struct page *head_page, struct page *page)
 {
 	struct folio *folio = (struct folio *)head_page;
@@ -994,7 +999,7 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 	 */
 	BUILD_BUG_ON((unsigned long)LIST_POISON1 & 1);
 
-	if (!static_branch_unlikely(&check_pages_enabled)) {
+	if (!is_check_pages_enabled()) {
 		ret = 0;
 		goto out;
 	}
-- 
2.35.3

