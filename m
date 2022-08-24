Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F83959FA3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiHXMq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiHXMqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:46:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0AD8275E;
        Wed, 24 Aug 2022 05:46:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w138so13755683pfc.10;
        Wed, 24 Aug 2022 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3ofBEgoOVULXRx9YcQITS6kJlSwXHxOcRDY8bmuQ+uo=;
        b=NYC0P+VvC3h/qTsakz1cthPNN6d0FSa/CYEhKgFHhMVQFz5I0VHJw5acQMB+cJxtdg
         nnU/tDqXG6W2Y0nMwoO00ADoUZDT2fX7FJdTXFMHlhVsvg7iZFacy3t2TV5/FjURCLzo
         HylQLQN259LAegfiak5+uqCcTPMABKgl3yBrMJ3UFKZEwEpqi4AszeZODfyApIV4pimQ
         ++ROAvmiK0Uw7LuoQMle0VTrFC9XJCHu5ATLXebq9z+I+qLHqNSuNToy/mGdlZNFqbnN
         fY2WhXGJn+7WmztHZUhW1rLBf8akcWKn6nDTf60IkUBdSvMA3wJrarhuuFbB9i9pNvfk
         1Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3ofBEgoOVULXRx9YcQITS6kJlSwXHxOcRDY8bmuQ+uo=;
        b=OSGPm3QBSmnLdSISCvdkSScC0dI/ZR5JdRyPmKJWnnioUQmmTRfEtNXG2f8wuUv7lE
         yWtrgk4QhqllKbCS972F9SCqpoFqfym70HPXs8jEAEJPfretzqRGbGkhvGbrI+dYVU6/
         qThfMXKyZ5AbnBdStS6nNz3CsXVBDznCOFBL1vDuhBfISMbtLq2JGPnwjrHPKHugrl0V
         CcgeMzIsY4ai2FQOpwfZA6BA9eCbm8EQ0ThQ1zbPGpQzMAzHnNpws072/tntzg1NGzJ8
         z63/MCWDKMHGesWrrQ0kg5LRqIjCUjKbExX16oDCSZzx1qFahVyf4vVGMHZCo+d69ex1
         2/QQ==
X-Gm-Message-State: ACgBeo2DMYknfeFf7ePlbJYL/IlBMqzVBIyJIOpHQ5s7HfOanqnnmhCR
        JhZxCdeEoGRwkVNNRqoLBoA=
X-Google-Smtp-Source: AA6agR7CoO2D9s/3qmn9/iCPy26WOtaYDVN7fIrc2I5o2V7sIFjhhRlUaQG/0F3Z41g231kvMm6D+w==
X-Received: by 2002:a63:8a4b:0:b0:42a:5144:a44 with SMTP id y72-20020a638a4b000000b0042a51440a44mr18608141pgd.164.1661345181365;
        Wed, 24 Aug 2022 05:46:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id rw13-20020a17090b2c4d00b001fb3522d53asm1271613pjb.34.2022.08.24.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:46:21 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     bagasdotme@gmail.com, adobriyan@gmail.com, willy@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH v4 1/2] ksm: count allocated ksm rmap_items for each process
Date:   Wed, 24 Aug 2022 12:46:15 +0000
Message-Id: <20220824124615.223158-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824124512.223103-1-xu.xin16@zte.com.cn>
References: <20220824124512.223103-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
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

	profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
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

So we add a new interface /proc/<pid>/ksm_rmp_items for each process to
indicate the total allocated ksm rmap_items of this process. Similarly,
we can calculate the ksm profit approximately for a single-process by:

	profit =~ ksm_merging_pages * sizeof(page) - ksm_rmp_items *
		 sizeof(rmap_item);

where ksm_merging_pages and ksm_rmp_items are both under /proc/<pid>/.

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
index 4ead8cf654e4..9977e17885c2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3199,6 +3199,19 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
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
@@ -3334,6 +3347,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
 #endif
 };
 
@@ -3671,6 +3685,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6ec33438dc1..a2a8da1ccb31 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -656,6 +656,11 @@ struct mm_struct {
 		 * merging.
 		 */
 		unsigned long ksm_merging_pages;
+		/*
+		 * Represent how many pages are checked for ksm merging
+		 * including merged and not merged.
+		 */
+		unsigned long ksm_rmp_items;
 #endif
 #ifdef CONFIG_LRU_GEN
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index a98bc3beb874..66d686039010 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -387,6 +387,7 @@ static inline struct rmap_item *alloc_rmap_item(void)
 static inline void free_rmap_item(struct rmap_item *rmap_item)
 {
 	ksm_rmap_items--;
+	rmap_item->mm->ksm_rmp_items--;
 	rmap_item->mm = NULL;	/* debug safety */
 	kmem_cache_free(rmap_item_cache, rmap_item);
 }
@@ -2231,6 +2232,7 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
 	if (rmap_item) {
 		/* It has already been zeroed */
 		rmap_item->mm = mm_slot->mm;
+		rmap_item->mm->ksm_rmp_items++;
 		rmap_item->address = addr;
 		rmap_item->rmap_list = *rmap_list;
 		*rmap_list = rmap_item;

base-commit: 68a00424bf69036970ced7930f9e4d709b4a6423
-- 
2.25.1

