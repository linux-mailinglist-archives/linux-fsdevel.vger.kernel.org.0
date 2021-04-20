Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11631365400
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhDTIXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:23:24 -0400
Received: from jptosegrel01.sonyericsson.com ([124.215.201.71]:7263 "EHLO
        JPTOSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229749AbhDTIXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:23:24 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Feng Tang <feng.tang@intel.com>, <linux-doc@vger.kernel.org>
CC:     Peter Enderborg <peter.enderborg@sony.com>
Subject: [PATCH 2/2 V6] lib/show_mem.c:  Add dma-buf counter to show_mem dump.
Date:   Tue, 20 Apr 2021 10:22:20 +0200
Message-ID: <20210420082220.7402-3-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210420082220.7402-1-peter.enderborg@sony.com>
References: <20210420082220.7402-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=DLnxHBFb c=1 sm=1 tr=0 a=fZcToFWbXLKijqHhjJ02CA==:117 a=3YhXtTcJ-WEA:10 a=iox4zFpeAAAA:8 a=z6gsHLkEAAAA:8 a=BIgLedd4eyWhQ11BBNUA:9 a=WzC6qhA0u3u7Ye7llzcV:22 a=d-OLMTCWyvARjPbQ-enb:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On system where dma-buf is used it can be many clients that adds up
to a lot of memory. This can be relevant for OOM handling when
running out of memory or how system handle this memory. It may be to free
with a kill.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 lib/show_mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/show_mem.c b/lib/show_mem.c
index 1c26c14ffbb9..ec4748c64353 100644
--- a/lib/show_mem.c
+++ b/lib/show_mem.c
@@ -7,6 +7,7 @@
 
 #include <linux/mm.h>
 #include <linux/cma.h>
+#include <linux/dma-buf.h>
 
 void show_mem(unsigned int filter, nodemask_t *nodemask)
 {
@@ -41,4 +42,8 @@ void show_mem(unsigned int filter, nodemask_t *nodemask)
 #ifdef CONFIG_MEMORY_FAILURE
 	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
 #endif
+#ifdef CONFIG_DMA_SHARED_BUFFER
+	printk("%lu pages dma-buf\n", dma_buf_allocated_pages());
+#endif
+
 }
-- 
2.17.1

