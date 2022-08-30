Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D95A6671
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiH3Oix (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 10:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiH3Oiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:38:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44FDE0FC9;
        Tue, 30 Aug 2022 07:38:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n8-20020a17090a73c800b001fd832b54f6so9409954pjk.0;
        Tue, 30 Aug 2022 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+WWXeCfdm+lqRyWFtrO2ZMX5GRcuZpyATp0YkUKDlZs=;
        b=L22XTCwb3gBWEdWMOqBCzNgfGrbHsi8YbXB+0Zg/f8vi5w3xLaOS8pKKnylF7FoAk/
         XbHCedKSpnhO1YGTRVLo0cYAb0vzdYhwzItm9/MlohEeq15jwNG2YFxC35nnEwhL1fZ1
         5Ous3kzthMx4hs+a2FaHL8KX1Dbo7MbC5R3k03e7NrOZ7PeXcqMaSiLcB0yKOFEOs9hZ
         uWQItefPfH3J9vUNfg0EVbAdDTB+0MOlzUhGL9QHm6T8xv644UbCO/OFsdL1tXFGeAtl
         KWEtqESP29K76dx2yGGM1fnixLHa2NbAHgdIbQ55RY8P6ZcZpPHyacq0oXJ9mYdt9t0w
         Nmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+WWXeCfdm+lqRyWFtrO2ZMX5GRcuZpyATp0YkUKDlZs=;
        b=XyRpsAwZzyC+fFXAIB59HQ0UC+Vz12ZYZIob7RSyLig+w/YF9C+aOmJ0PXnZZfXQcp
         LJOjeyS4aprLCjtkYZQ8/oFipBiO2rfn3asGn4xKKPsT6Smv3IdAWGFAXS2XN5bnoDZZ
         ShVkzdj5oMGzOTdN7gNNg3bziPYxUo7wwZFVr+bZTjkDESzIvnoqCYBbobfM5FmPzCC+
         58JzBWW+vQP6rGNahZV18K+wyzIqnJA1Lpsso/IRjeAIR08aae/Bt7BGi3lSvkZVQGT2
         6gZy+QaUesaYASyn2g4n7QneNXOG2M7ci3jHfQqUYbMPNu48DLYVCE1/5TUgWDFjwRDB
         4ahA==
X-Gm-Message-State: ACgBeo2yz34uqxlwg0WNgLTJCSo8KB9f3MTS58eyXqB0FQDa0LqRgBMD
        xdsmP/hmvFwcLMilRjorgiy4CdweAFc=
X-Google-Smtp-Source: AA6agR75QeEcSlzOeQFOnHGWqP9a4dvLA8n1Q2//O7MSaKlP82AAk3IMN3Szxv8UR9wQv0uMWnAZuw==
X-Received: by 2002:a17:902:e94e:b0:16d:12b6:b9fe with SMTP id b14-20020a170902e94e00b0016d12b6b9femr21156102pll.152.1661870328579;
        Tue, 30 Aug 2022 07:38:48 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q11-20020a170903204b00b001708b189c4asm9669206pla.137.2022.08.30.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:38:48 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, willy@infradead.org
Cc:     bagasdotme@gmail.com, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH v5 1/2] ksm: count allocated ksm rmap_items for each process
Date:   Tue, 30 Aug 2022 14:38:38 +0000
Message-Id: <20220830143838.299758-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830143731.299702-1-xu.xin16@zte.com.cn>
References: <20220830143731.299702-1-xu.xin16@zte.com.cn>
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

So we add a new interface /proc/<pid>/ksm_stat for each process in which
the value of ksm_rmap_itmes is only shown now and so more values can be
added in future.

So similarly, we can calculate the ksm profit approximately for a single
process by:

	profit =~ ksm_merging_pages * sizeof(page) - ksm_rmap_items *
		 sizeof(rmap_item);

where ksm_merging_pages is shown at /proc/<pid>/ksm_merging_pages, and
ksm_rmap_items is shown in /proc/<pid>/ksm_stat.

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
index 4ead8cf654e4..c66ac538eda4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3199,6 +3199,19 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
 	return 0;
 }
+static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(task);
+	if (mm) {
+		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
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
+	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
 };
 
@@ -3671,6 +3685,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_stat",  S_IRUSR, proc_pid_ksm_stat),
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index fb53717d571c..bd0993d20a20 100644
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
+		unsigned long ksm_rmap_items;
 #endif
 #ifdef CONFIG_LRU_GEN
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index e34cc21d5556..0c76b3e004b7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -387,6 +387,7 @@ static inline struct rmap_item *alloc_rmap_item(void)
 static inline void free_rmap_item(struct rmap_item *rmap_item)
 {
 	ksm_rmap_items--;
+	rmap_item->mm->ksm_rmap_items--;
 	rmap_item->mm = NULL;	/* debug safety */
 	kmem_cache_free(rmap_item_cache, rmap_item);
 }
@@ -2234,6 +2235,7 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
 	if (rmap_item) {
 		/* It has already been zeroed */
 		rmap_item->mm = mm_slot->mm;
+		rmap_item->mm->ksm_rmap_items++;
 		rmap_item->address = addr;
 		rmap_item->rmap_list = *rmap_list;
 		*rmap_list = rmap_item;
-- 
2.25.1

