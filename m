Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11A94F1B36
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379533AbiDDVTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380411AbiDDUFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:10 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0430F57;
        Mon,  4 Apr 2022 13:03:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b15so9992640pfm.5;
        Mon, 04 Apr 2022 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgKTSjMxp3AdwYz23ZAB1EJPIeK5nseej60E5OuWwX0=;
        b=Q1A3YlfgEbe8lLn0skK/++u9FqKcXEy32OnnDrIyJYpqURGO1hpoUykNLgw4agvXSP
         w7vqfhvAjNEbyICxsSt9wuLLGSKFFs3irFnCLN/eHA4nlKtz0V5Dx6+p0BEi2BgLwidF
         NcWLIMZ/iWj2y4M5XC7JxDZH8spQXT8QJxCnpJqOf/4O8O6tMAzWhbuCZUpVpZOb2AGM
         cyW4y0XBUDwtngu5qmWA1Dw5YE0H1fYD0uDhRHtnxT3mzcYt83eU9v7v5TUzahx3OeHw
         ejbXEJ3J5u3MzCi/ia0iLBqINzXhAiPh0SJk6/sg5j+I0pETLHMgbcd7VVpAzhwAuCFX
         pvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgKTSjMxp3AdwYz23ZAB1EJPIeK5nseej60E5OuWwX0=;
        b=qQ8fdrzmIKz0TnbUiG2B/q+hAcaNByVM0ifB1U5dGXvuFJ+G1RsYVh1oZJL3/JH0Dr
         F2XgJxZWT3wMwoqPhejBEtfYYjsV5CgqHVornN+CLIYWrf0i3ko4yG3+2KgIH22reXZl
         C1q9quK+FnLVM1OKDhzaoqKNnTibQZzmQwAzPdB8c8h8w4SzuxTT/R75bUwGlhx6Rgoa
         GQQQOOua5y7GC01R+EccnOti/V5FrGOvRcb778HkzTuAvAb36Vkdn15JVJUBdtLW9veq
         OLj952xqEKdDujdIxxwT3796rN1OvF9y/KqsTNTXM7ey36695+CVCAbOXcN3oIWo9Ls1
         qvAA==
X-Gm-Message-State: AOAM530Wm4/XTEJH2/SN4UAHuBaSpn14kjwkWp11nIU5RFM/S/gVxn9K
        Hv6Thir3M9Fc6nnU6KSO1TY=
X-Google-Smtp-Source: ABdhPJznqnP9rpTwiXQKLYVOrJeLRb7oT1LQF5qT/hkPokfJzaSck749CHWu+2vv9VToyaEKUJAX/w==
X-Received: by 2002:a63:8c2:0:b0:380:bfd8:9e10 with SMTP id 185-20020a6308c2000000b00380bfd89e10mr1275436pgi.422.1649102593484;
        Mon, 04 Apr 2022 13:03:13 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:13 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 7/8] mm: khugepaged: introduce khugepaged_enter_vma() helper
Date:   Mon,  4 Apr 2022 13:02:49 -0700
Message-Id: <20220404200250.321455-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220404200250.321455-1-shy828301@gmail.com>
References: <20220404200250.321455-1-shy828301@gmail.com>
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

The khugepaged_enter_vma_merge() actually does as the same thing as the
khugepaged_enter() section called by shmem_mmap(), so consolidate them
into one helper and rename it to khugepaged_enter_vma().

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h |  8 ++++----
 mm/khugepaged.c            | 26 +++++++++-----------------
 mm/mmap.c                  |  8 ++++----
 mm/shmem.c                 | 12 ++----------
 4 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 6acf9701151e..f4b12be155ab 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -10,8 +10,8 @@ extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
-extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-				       unsigned long vm_flags);
+extern void khugepaged_enter_vma(struct vm_area_struct *vma,
+				 unsigned long vm_flags);
 extern void khugepaged_fork(struct mm_struct *mm,
 			    struct mm_struct *oldmm);
 extern void khugepaged_exit(struct mm_struct *mm);
@@ -49,8 +49,8 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
 				    unsigned long vm_flags)
 {
 }
-static inline void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-					      unsigned long vm_flags)
+static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
+					unsigned long vm_flags)
 {
 }
 static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ec5b0a691d87..c5c3202d7401 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -365,7 +365,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
 		 * register it here without waiting a page fault that
 		 * may not happen any time soon.
 		 */
-		khugepaged_enter_vma_merge(vma, *vm_flags);
+		khugepaged_enter_vma(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
@@ -505,23 +505,15 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
-void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-			       unsigned long vm_flags)
+void khugepaged_enter_vma(struct vm_area_struct *vma,
+			  unsigned long vm_flags)
 {
-	unsigned long hstart, hend;
-
-	/*
-	 * khugepaged only supports read-only files for non-shmem files.
-	 * khugepaged does not yet work on special mappings. And
-	 * file-private shmem THP is not supported.
-	 */
-	if (!hugepage_vma_check(vma, vm_flags))
-		return;
-
-	hstart = (vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
-	hend = vma->vm_end & HPAGE_PMD_MASK;
-	if (hstart < hend)
-		khugepaged_enter(vma, vm_flags);
+	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
+	    khugepaged_enabled() &&
+	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
+	     (vma->vm_end & HPAGE_PMD_MASK)))
+		if (hugepage_vma_check(vma, vm_flags))
+			__khugepaged_enter(vma->vm_mm);
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..604c8dece5dd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1218,7 +1218,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 					 end, prev->vm_pgoff, NULL, prev);
 		if (err)
 			return NULL;
-		khugepaged_enter_vma_merge(prev, vm_flags);
+		khugepaged_enter_vma(prev, vm_flags);
 		return prev;
 	}
 
@@ -1245,7 +1245,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		}
 		if (err)
 			return NULL;
-		khugepaged_enter_vma_merge(area, vm_flags);
+		khugepaged_enter_vma(area, vm_flags);
 		return area;
 	}
 
@@ -2460,7 +2460,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	khugepaged_enter_vma_merge(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, vma->vm_flags);
 	validate_mm(mm);
 	return error;
 }
@@ -2538,7 +2538,7 @@ int expand_downwards(struct vm_area_struct *vma,
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	khugepaged_enter_vma_merge(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, vma->vm_flags);
 	validate_mm(mm);
 	return error;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 529c9ad3e926..92eca974771d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2239,11 +2239,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-			(vma->vm_end & HPAGE_PMD_MASK)) {
-		khugepaged_enter(vma, vma->vm_flags);
-	}
+	khugepaged_enter_vma(vma, vma->vm_flags);
 	return 0;
 }
 
@@ -4136,11 +4132,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
 
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-			(vma->vm_end & HPAGE_PMD_MASK)) {
-		khugepaged_enter(vma, vma->vm_flags);
-	}
+	khugepaged_enter_vma(vma, vma->vm_flags);
 
 	return 0;
 }
-- 
2.26.3

