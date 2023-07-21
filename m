Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7881075C279
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 11:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjGUJH3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGUJH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:07:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AED2D7F;
        Fri, 21 Jul 2023 02:07:26 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6kBk5PNsztR9d;
        Fri, 21 Jul 2023 17:04:14 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.26) by
 dggpeml100024.china.huawei.com (7.185.36.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 17:07:23 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <mcgrof@kernel.org>,
        <keescook@chromium.org>, <yzaikin@google.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <xiujianfeng@huawei.com>
Subject: [PATCH -next] perf/core: Rename perf_proc_update_handler for readability
Date:   Fri, 21 Jul 2023 09:06:07 +0000
Message-ID: <20230721090607.172002-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like other sysctl handlers of perf, rename it to
perf_event_max_sample_rate_handler, minor readability improvement.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/linux/perf_event.h | 2 +-
 kernel/events/core.c       | 4 ++--
 kernel/sysctl.c            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2166a69e3bf2..681cb44249c4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1556,7 +1556,7 @@ extern int sysctl_perf_cpu_time_max_percent;
 
 extern void perf_sample_event_took(u64 sample_len_ns);
 
-int perf_proc_update_handler(struct ctl_table *table, int write,
+int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fd9272eec6e..8db4c5f6328f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -449,8 +449,8 @@ static void update_perf_cpu_limits(void)
 
 static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc);
 
-int perf_proc_update_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+int perf_event_max_sample_rate_handler(struct ctl_table *table, int write,
+				       void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
 	int perf_cpu = sysctl_perf_cpu_time_max_percent;
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 354a2d294f52..2b6585751891 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1983,7 +1983,7 @@ static struct ctl_table kern_table[] = {
 		.data		= &sysctl_perf_event_sample_rate,
 		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
 		.mode		= 0644,
-		.proc_handler	= perf_proc_update_handler,
+		.proc_handler	= perf_event_max_sample_rate_handler,
 		.extra1		= SYSCTL_ONE,
 	},
 	{
-- 
2.34.1

