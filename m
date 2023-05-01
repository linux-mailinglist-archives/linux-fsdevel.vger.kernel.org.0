Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460DD6F3466
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjEAQ7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEAQ64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 12:58:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A49430E1
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 09:56:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7c45b8e1so4808580276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682960156; x=1685552156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ia0f0ycGZD+jM5YS+jW1bQxvUpAwQcUQoxrBuJXYMcE=;
        b=5JJhV76m95/YBoZ/xZu42cKOJXhgJORCHh7GQ1vgchybA9Jz2W8JB87J32lzEHqVAD
         5MpwShEQTLsgetTJKB81Ya9oYfauOk73A+wkcp3YnAqkuYR2uGLglMtljDk1oXUFeXUF
         eg/dqf1WTTeod1mNhPnzcjxqEJmrvwX1WQABkeXqhDWaPCFp/KOIQdT6Kd/lNmNqK8uA
         jO52yQ6iu7pCgMF+oglZnvEtlqmI75FROfYcJYL0lGgLhZXRGGNj8gM5KHULwpV7DXj0
         IQGmZzm/JuCCa0BNo8vc+UrvY2fi7yQcbqUa8T0x4PnakvTfaxlxsiA9vMtpl/EDSZYr
         7ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960156; x=1685552156;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ia0f0ycGZD+jM5YS+jW1bQxvUpAwQcUQoxrBuJXYMcE=;
        b=QNJGO2dT3o9GyfJtJ39ctdpaoQr3k6RGRDRMhvNJlEixtB6WT1rfgp0UwFNWavkSVn
         mSR1gszoKF8AbFmSe8eTCjmalGzeZx2HVakK3yHwXK/Y94PW7QSbfL8ONkkVo8ylpQF+
         KwbK6aGMiuE4jpccwcJu3JYQrGu9RbjwEdHSvQg5ih2qUnvuGVQzwNgrzEqwccBfYq3S
         oF2QCZZWMKbGkKArh1xUmVM5UfB4x3X5A2RMJA6s5QyUj7LUWd5EGrdgwdkmxlqDGF+G
         V6GAMshDWQezOZ4luI1tXCqdd39EWndy6SeAWLTPPeMw3oNVhlq25/RGQkR0lx0tXOYU
         Qatg==
X-Gm-Message-State: AC+VfDxYcB8l4AolAnY6yxOMkGhVq2E9jV6yLoD8naNsBg2yzd3RwBbq
        7trCkhxUGaS8SNoJ3+WRXm0pw2Cnb9c=
X-Google-Smtp-Source: ACHHUZ7AZgI8CesVN/W1kPgcDGVmfHbMCJ0zKZ8nFHzmTASKNb7LK9gLjq8w5luIVN/1afaizYlyRnGrI6c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:6d24:3efd:facc:7ac4])
 (user=surenb job=sendgmr) by 2002:a25:5d1:0:b0:b9d:52cf:4a6b with SMTP id
 200-20020a2505d1000000b00b9d52cf4a6bmr4308920ybf.1.1682960156135; Mon, 01 May
 2023 09:55:56 -0700 (PDT)
Date:   Mon,  1 May 2023 09:54:31 -0700
In-Reply-To: <20230501165450.15352-1-surenb@google.com>
Mime-Version: 1.0
References: <20230501165450.15352-1-surenb@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230501165450.15352-22-surenb@google.com>
Subject: [PATCH 21/40] mm/page_ext: enable early_page_ext when CONFIG_MEM_ALLOC_PROFILING_DEBUG=y
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        corbet@lwn.net, void@manifault.com, peterz@infradead.org,
        juri.lelli@redhat.com, ldufour@linux.ibm.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, peterx@redhat.com, david@redhat.com,
        axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
        nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
        muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
        pasha.tatashin@soleen.com, yosryahmed@google.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        andreyknvl@gmail.com, keescook@chromium.org,
        ndesaulniers@google.com, gregkh@linuxfoundation.org,
        ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com,
        glider@google.com, elver@google.com, dvyukov@google.com,
        shakeelb@google.com, songmuchun@bytedance.com, jbaron@akamai.com,
        rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
        surenb@google.com, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For all page allocations to be tagged, page_ext has to be initialized
before the first page allocation. Early tasks allocate their stacks
using page allocator before alloc_node_page_ext() initializes page_ext
area, unless early_page_ext is enabled. Therefore these allocations will
generate a warning when CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.
Enable early_page_ext whenever CONFIG_MEM_ALLOC_PROFILING_DEBUG=y to
ensure page_ext initialization prior to any page allocation. This will
have all the negative effects associated with early_page_ext, such as
possible longer boot time, therefore we enable it only when debugging
with CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled and not universally for
CONFIG_MEM_ALLOC_PROFILING.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_ext.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index eaf054ec276c..55ba797f8881 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -96,7 +96,16 @@ unsigned long page_ext_size;
 static unsigned long total_usage;
 struct page_ext *lookup_page_ext(const struct page *page);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING_DEBUG
+/*
+ * To ensure correct allocation tagging for pages, page_ext should be available
+ * before the first page allocation. Otherwise early task stacks will be
+ * allocated before page_ext initialization and missing tags will be flagged.
+ */
+bool early_page_ext __meminitdata = true;
+#else
 bool early_page_ext __meminitdata;
+#endif
 static int __init setup_early_page_ext(char *str)
 {
 	early_page_ext = true;
-- 
2.40.1.495.gc816e09b53d-goog

