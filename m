Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB259B8C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 07:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiHVFhC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 01:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiHVFhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:37:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40425C43;
        Sun, 21 Aug 2022 22:36:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bf22so9863756pjb.4;
        Sun, 21 Aug 2022 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=p9b3HF7NOO+RGMYMFh1iU6dTss0goYi3FrKED6tvlcI=;
        b=R4z8h19vGmoWgMalE+Csm4ISmIjwSwIFYcqGhUV1/f6isNdEiwlOuDT6pH1AAS0HkM
         UYxEDcnavfzk8uSEPZqxsLr9jy2yJ8xpGRnDtT271Nu0zJQ9a1NUbwmMwycLkHx0dEtT
         U7DPL8MdobB5I4vGacq2PKdeu7+RptHHNIAYAVI4ls2TlX8wvEw/TW6bBk0f4zWSncFV
         1Ht+Oh0SDdUoYDkw4m9dCVpmSF8jnlhXkCz7z8PgESLnvoXEq/mkmKs33jDPExDj4LGm
         rHiTMQ0ZJSIvLIuNO+XrX3+QoIaeZPFegHC0gykFz2Sh3i1ipF00yejDsBtcGzZu5U0o
         hOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=p9b3HF7NOO+RGMYMFh1iU6dTss0goYi3FrKED6tvlcI=;
        b=oe4CtT3Oz++FJF8K5cHcDqM8tFultNpQuI8R17q4SGyFmoVZos8IIk/izfQEIQaN3f
         JHAeN51vDPqplLowvlLrHPpmE5YMeSSSPXVjuPg/ug5Taa3zIhzV9N97DS5wRkbNXO3V
         LgYwfYc+i8zzrccHJwRpc4tEmWxqV+Dn5P/IW7hNr2J/V9x7C2na3PM9twQrasCQEXeB
         ixeca8kb6ezTSyqqR83/IGDuHvuOkmMDjPPqlhxHogAWCKvD9n7CgTK9iKXCUxj+Z004
         ZQwqvR8kantE8mxctNaDOeVNuVGe+eFUdQl9Gl62mfQZdrOd9KEL16BKSVCs033bXdU1
         zeig==
X-Gm-Message-State: ACgBeo2YSPqxzjbIfnaHyW7OljY0ENzHu/iKOXGillJ9vxu41ONAEAzF
        KSs2gEydN2iONeJZQt14wvE=
X-Google-Smtp-Source: AA6agR5Ww4o26uoqIbG6IVhMRsgZLAx2riNOYto8gOgOZcu6mYdhoN4+8wXvBPXZo+xpg2PT0f4M1Q==
X-Received: by 2002:a17:90b:4a07:b0:1f5:1aff:4ab with SMTP id kk7-20020a17090b4a0700b001f51aff04abmr27387328pjb.216.1661146619187;
        Sun, 21 Aug 2022 22:36:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b00172f3b76625sm435597plh.161.2022.08.21.22.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:36:58 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] ksm: count allocated ksm rmap_items for each process
Date:   Mon, 22 Aug 2022 05:36:53 +0000
Message-Id: <20220822053653.204150-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

KSM can save memory by merging identical pages, but also can consume
additional memory, because it needs to generate rmap_items to save
each scanned page's brief rmap information. Some of these pages may
be merged, but some may not be abled to be merged after being checked
several times, which are unprofitable memory consumed.

The information about whether KSM save memory or consume memory in
system-wide range can be determined by the comprehensive calculation
of pages_sharing, pages_shared, pages_unshared and pages_volatile.
A simple approximate calculation:

	profit ≈ pages_sharing * sizeof(page) - (all_rmap_items) *
	         sizeof(rmap_item);

where all_rmap_items equals to the sum of pages_sharing, pages_shared,
pages_unshared and pages_volatile.

But we cannot calculate this kind of ksm profit inner single-process wide
because the information of ksm rmap_item's number of a process is lacked.
For user applications, if this kind of information could be obtained,
it helps upper users know how beneficial the ksm-policy (like madvise)
they are using brings, and then optimize their app code. For example,
one application madvise 1000 pages as MERGEABLE, while only a few pages
are really merged, then it's not cost-efficient.

So we add a new interface /proc/<pid>/ksm_alloced_items for each
process to indicate the total allocated ksm rmap_items of this process.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/proc/base.c           | 15 +++++++++++++++
 include/linux/mm_types.h |  5 +++++
 mm/ksm.c                 |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..b6317981492a 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3196,6 +3196,19 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
 	return 0;
 }
+static int proc_pid_ksm_rmp_items(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(task);
+	if (mm) {
+		seq_printf(m, "%lu\n", mm->ksm_rmp_items);
+		mmput(mm);
+	}
+
+	return 0;
+}
 #endif /* CONFIG_KSM */
 
 #ifdef CONFIG_STACKLEAK_METRICS
@@ -3331,6 +3344,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
 #endif
 };
 
@@ -3668,6 +3682,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index cf97f3884fda..0b9e76275ea7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -671,6 +671,11 @@ struct mm_struct {
 		 * merging.
 		 */
 		unsigned long ksm_merging_pages;
+		/*
+		 * Represent how many pages are checked for ksm merging
+		 * including merged and not merged.
+		 */
+		unsigned long ksm_rmp_items;
 #endif
 	} __randomize_layout;
 
diff --git a/mm/ksm.c b/mm/ksm.c
index 478bcf26bfcd..fc9879d7049f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -421,6 +421,7 @@ static inline struct rmap_item *alloc_rmap_item(void)
 static inline void free_rmap_item(struct rmap_item *rmap_item)
 {
 	ksm_rmap_items--;
+	rmap_item->mm->ksm_rmp_items--;
 	rmap_item->mm = NULL;	/* debug safety */
 	kmem_cache_free(rmap_item_cache, rmap_item);
 }
@@ -2265,6 +2266,7 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
 	if (rmap_item) {
 		/* It has already been zeroed */
 		rmap_item->mm = mm_slot->mm;
+		rmap_item->mm->ksm_rmp_items++;
 		rmap_item->address = addr;
 		rmap_item->rmap_list = *rmap_list;
 		*rmap_list = rmap_item;
-- 
2.25.1

