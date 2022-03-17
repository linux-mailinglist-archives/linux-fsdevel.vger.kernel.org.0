Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CA4DD15B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiCQXuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiCQXuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:50:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D02A5A85;
        Thu, 17 Mar 2022 16:48:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n15so5765283plh.2;
        Thu, 17 Mar 2022 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8qThGmR6qWWYZNQEqh4yIj3Ne/feg2xUmJaASesT2M=;
        b=Q8u/tgbEZte1l+GJAkZCMz3Ct5k4Nu5o8GV+SvDdYg7FPjhtRQ4S6BthMj0tx6333x
         CNQuCEPSL3r1/gAm7gZ3BvPAHQu/VIQhP548H716jpthOj1bvkeHftkCgd+iir4u5Wb/
         7QWlt6efJHKZJatCDSMMLkYyCk9YWhoclsbWlJP04Q93Yvxe/B9AG86U35LbVlxuTZE8
         JutmKy2dyY9KA51e5m6N3o9gH6/XfzVlA1lI7LRdNn53bxGlRH/u9FhrTAbji6rxuDGq
         mZTT1gAywfZuHm247vqURRsIUcEa6NOKt+fnFQgEGI4oP4xEGbtL/qCbZSEg+FiUurEh
         Ei7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8qThGmR6qWWYZNQEqh4yIj3Ne/feg2xUmJaASesT2M=;
        b=ES0AxqUtvDIMJ/YJ4DcNTSuxxqcb/+xWGj+UjeiRvKdCAGMjAMMZjJrml8jkKsx6au
         mmYelxOCJwUdHyVymL/ce+5EpqVlZEC2ouzZ1smOIgvLDd5nbpDmoRYw8XwefJZwo0nG
         pWLNFK9LHOgnC/KHKHQYCa6P964vJulAVxeb2EiKKwjXePAvEGiYapRic2b9zyPUO7pk
         VxxX04emjotgDViDOPrvfddcXhAIphBvK8lzLyzRXTDuy7yvmWE4Yd1seEGvopz5YSoH
         snm7LTiop6GIzB340JgkF345lbYseD0tIkuxUP1nDFVkawqpgeb+bs/FABpNPB/bHxKb
         TZig==
X-Gm-Message-State: AOAM532noN0eAswGCwLA1XaGkf1DOSZ1UYEBaIUUE6iT863bOoPQowGM
        Gy2H86qSV1oyjt6wqIQlK/k=
X-Google-Smtp-Source: ABdhPJyp8fZ/A0uESg9v+zKNEb0Mpr9NlB5MF0RbJ0fvxFGMYc0TTPAaDF54pFiTc/DyCZMv8jCtSg==
X-Received: by 2002:a17:902:dad2:b0:151:f895:9c31 with SMTP id q18-20020a170902dad200b00151f8959c31mr7666608plx.93.1647560928254;
        Thu, 17 Mar 2022 16:48:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:47 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 7/8] mm: khugepaged: introduce khugepaged_enter_file() helper
Date:   Thu, 17 Mar 2022 16:48:26 -0700
Message-Id: <20220317234827.447799-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220317234827.447799-1-shy828301@gmail.com>
References: <20220317234827.447799-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following patch will have filesystems code call khugepaged_enter()
to make readonly FS THP collapse more consistent.  Extract the current
implementation used by shmem in khugepaged_enter_file() helper so that
it could be reused by other filesystems and export the symbol for
modules.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h |  6 ++++++
 mm/khugepaged.c            | 11 +++++++++++
 mm/shmem.c                 | 14 ++++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 54e169116d49..06464e9a1f91 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -21,6 +21,8 @@ extern void khugepaged_fork(struct mm_struct *mm,
 extern void khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter(struct vm_area_struct *vma,
 			     unsigned long vm_flags);
+extern void khugepaged_enter_file(struct vm_area_struct *vma,
+				  unsigned long vm_flags);
 
 extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
@@ -53,6 +55,10 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
 				    unsigned long vm_flags)
 {
 }
+static inline void khugepaged_enter_file(struct vm_area_struct *vma,
+					 unsigned long vm_flags)
+{
+}
 static inline void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4cb4379ecf25..93c9072983e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -577,6 +577,17 @@ void khugepaged_enter(struct vm_area_struct *vma, unsigned long vm_flags)
 			__khugepaged_enter(vma->vm_mm);
 }
 
+void khugepaged_enter_file(struct vm_area_struct *vma, unsigned long vm_flags)
+{
+	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
+	    khugepaged_enabled() &&
+	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
+	     (vma->vm_end & HPAGE_PMD_MASK)))
+		if (hugepage_vma_check(vma, vm_flags))
+			__khugepaged_enter(vma->vm_mm);
+}
+EXPORT_SYMBOL_GPL(khugepaged_enter_file);
+
 static void release_pte_page(struct page *page)
 {
 	mod_node_page_state(page_pgdat(page),
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..c2346e5d2b24 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2233,11 +2233,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-			(vma->vm_end & HPAGE_PMD_MASK)) {
-		khugepaged_enter(vma, vma->vm_flags);
-	}
+
+	khugepaged_enter_file(vma, vma->vm_flags);
+
 	return 0;
 }
 
@@ -4132,11 +4130,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
 
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-			(vma->vm_end & HPAGE_PMD_MASK)) {
-		khugepaged_enter(vma, vma->vm_flags);
-	}
+	khugepaged_enter_file(vma, vma->vm_flags);
 
 	return 0;
 }
-- 
2.26.3

