Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585C53BBC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jun 2022 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiFBPnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jun 2022 11:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiFBPnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:43:11 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5332A6880;
        Thu,  2 Jun 2022 08:43:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFBKBJM_1654184584;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VFBKBJM_1654184584)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jun 2022 23:43:05 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     changbin.du@intel.com
Cc:     sashal@kernel.org, akpm@linux-foundation.org, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: [PATCH] proc: export page young and skip_kasan_poison flag via kpageflags
Date:   Thu,  2 Jun 2022 23:43:02 +0800
Message-Id: <20220602154302.12634-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now the young and skip_kasan_poison flag are supported in
show_page_flags(), but we can not get them from /proc/kpageflags,
So there add them.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 fs/proc/page.c                    | 6 ++++++
 include/linux/kernel-page-flags.h | 2 ++
 tools/vm/page-types.c             | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9f1077d94cde..fd28e1d92c5c 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -220,6 +220,12 @@ u64 stable_page_flags(struct page *page)
 #ifdef CONFIG_64BIT
 	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
 #endif
+#if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
+	u |= kpf_copy_bit(k, KPF_YOUNG, PG_young);
+#endif
+#ifdef CONFIG_KASAN_HW_TAGS
+	u |= kpf_copy_bit(k, KPF_SKIP_KASAN_POSION, PG_skip_kasan_poison);
+#endif
 
 	return u;
 };
diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
index eee1877a354e..30aaa0ee4ca9 100644
--- a/include/linux/kernel-page-flags.h
+++ b/include/linux/kernel-page-flags.h
@@ -18,5 +18,7 @@
 #define KPF_UNCACHED		39
 #define KPF_SOFTDIRTY		40
 #define KPF_ARCH_2		41
+#define KPF_YOUNG		42
+#define KPF_SKIP_KASAN_POSION	43
 
 #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index b1ed76d9a979..2671b746d11f 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -79,6 +79,8 @@
 #define KPF_UNCACHED		39
 #define KPF_SOFTDIRTY		40
 #define KPF_ARCH_2		41
+#define KPF_YOUNG		42
+#define KPF_SKIP_KASAN_POSION	43
 
 /* [48-] take some arbitrary free slots for expanding overloaded flags
  * not part of kernel API
@@ -137,6 +139,8 @@ static const char * const page_flag_names[] = {
 	[KPF_UNCACHED]		= "c:uncached",
 	[KPF_SOFTDIRTY]		= "f:softdirty",
 	[KPF_ARCH_2]		= "H:arch_2",
+	[KPF_YOUNG]		= "y:young",
+	[KPF_SKIP_KASAN_POSION]	= "K:skip_kasan_posion",
 
 	[KPF_READAHEAD]		= "I:readahead",
 	[KPF_SLOB_FREE]		= "P:slob_free",
-- 
2.31.0

