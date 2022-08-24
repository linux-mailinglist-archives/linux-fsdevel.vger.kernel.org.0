Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272B859F254
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 06:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbiHXECE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 00:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHXECC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 00:02:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E453F71BFA;
        Tue, 23 Aug 2022 21:01:59 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x63-20020a17090a6c4500b001fabbf8debfso302036pjj.4;
        Tue, 23 Aug 2022 21:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6rqGt2HECmyWVySSRPmsVLXpDMjQHW89zdrF6Uaa9Go=;
        b=qNI+Wccmbs61DxivbeWnR1PjHf3zguDNC7LtoV1kGJKl47X802NludrCcVmEhX8ln+
         1wQu8kbrw0IgIxqNey60vBcraFpHVA33aVXBBGKss9e+zrYSIGS1tetTQkEbAwVHaQIt
         60veos1D8ou+tXlqwuRvWlx6/+L4xRn3vza4MstspX3coyHvXDna3c6oDG353Uuzzgxo
         OiLlCXqw65P9wJsN8nhiPee09D8dAa1Rh2mGkwlchVdQR2UdcvNn1hM+A4Fzoc/NXbPj
         tgpufNqW2dOjTgaE6SX5ujQZmOXBm4EhaotnPf/uw5cljbCKhqZi39GfSBeyDF4R/8Z7
         NB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6rqGt2HECmyWVySSRPmsVLXpDMjQHW89zdrF6Uaa9Go=;
        b=BScE749Eoedg4Pcjt2yn6H11e8pT+a/qMyf07exYfZGGcvyMJxAGVYFMvZvv4X6jWr
         fIXy3Esj/UfBh3N+B/YIzBHGJzdCfdNgq4qC+0rNb8xcjuWd+IzHCPc5soP+PsDvplyC
         4l9F6RA1Nr0lO5VkkrqxHBpyIIsKToYVrXL1tBxeYVgpjXL6GTmqojma9+M6Me6SV0Xc
         h+6vr6caVISr+nEZTL8jU9BBHfIeoLknqs9YD31DVw8xNIgbl0QlUu9L/zkwgFMNgxiP
         2MO6fPTdC6TaK+Gv3s2s34R2l9wxPdelhTSrX+UGGPu9d4aaaSjzG3w08SONCb63+eT0
         sIpA==
X-Gm-Message-State: ACgBeo3m7Vg32VVVmRRkmhwqkkh3leSDR5KPDlifFWW/US+QgMbpQgP4
        IMmWymW1/lYpTmFPNCQXb1I=
X-Google-Smtp-Source: AA6agR6dILThb7G09ug65nK1BovcekJnf2vbw8kik1d+rkwqW/XM/BP71zTpQFYe0ePfp9Lz/oqoKA==
X-Received: by 2002:a17:902:bd08:b0:16e:e00c:dd48 with SMTP id p8-20020a170902bd0800b0016ee00cdd48mr27294120pls.93.1661313719363;
        Tue, 23 Aug 2022 21:01:59 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bk2-20020a056a02028200b0041c0c9c0072sm9925880pgb.64.2022.08.23.21.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:01:59 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH v2 1/2] ksm: count allocated ksm rmap_items for each process
Date:   Wed, 24 Aug 2022 04:01:53 +0000
Message-Id: <20220824040153.215059-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824040036.215002-1-xu.xin16@zte.com.cn>
References: <20220824040036.215002-1-xu.xin16@zte.com.cn>
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

