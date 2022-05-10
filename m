Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400E3522580
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiEJUdB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiEJUcy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:54 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32829201C25;
        Tue, 10 May 2022 13:32:49 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c11so17773080plg.13;
        Tue, 10 May 2022 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FkmAy2Ymz4AwqTAeIx4CgD4TCwehEDHJukpdkFOQzQ=;
        b=S3no0u2ExtqBELoR4IiwVmiS8rE1/wSFCbQoP/VlwVfnVxYi1iSkOT2f+wekgSFcqN
         jCZtKJ7IhOFxMumWdLnmSIM1SojVhLmzixtKhDpZS5Opn0etBfh1gYixPeKKMCf81AoC
         0q+DLEPIP9yV2o9aqhhmUn48fnctKW3eYniWqkasdUZ5DUEjbKHNRD4JoftzRXVsdulD
         Iyyjp7BRtoN58fsGQVs2utbIlJ2LDrOMA+WzrkaSvw/P9EBcBRtxo1pVRPhs/LFG3Re+
         9MjRFR3lb8F8DjjpupiJU3HNZT7YZKXTqpLBoUGrwFaUptyR8VAalWhxCVl5L0/FFdOt
         Z22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FkmAy2Ymz4AwqTAeIx4CgD4TCwehEDHJukpdkFOQzQ=;
        b=k0lo5aIXeE+0l1Suewjq4Gr7vugItcahz/xO5SEJbW4i8rd8U9HDPLLpyh4ZGsjNIJ
         ZPGdfrN6xr93nfdsfyT64zE4HSq3y6WV7wVMBG/b097GF5eNF40ad0Y4cOjy3uE6AFWv
         wBNvfrOzbiMemBYlwDzlNI9fQRVdG7O0cv+Jobes078hD8z0WAx0Z5/VFpyMUzvtIDnL
         pU7VMSgwXEf8DBAqCnBi7QUhiwXL8caeZHhjRh+5mUXBWOi4HiCAU2g7bYngOya1aN2+
         LMd/US94x+YCM/k2089vswOgc4gW8lMg/kRSiFJXyqGeAZic2H+2BV37AVBay1XxhCtw
         95bQ==
X-Gm-Message-State: AOAM530q/gKtisoBNROkiUmdlZZ3ipnyecXw2agcyQLFe3lm5U0TP2uh
        +am0jDZF68vJUuqJp+6cp8g=
X-Google-Smtp-Source: ABdhPJwmyjvgMYxxCNpnJ0YhIIczNSpnId2smrKzWQlwP1GG4myYSir5NGIWA9p/smt5p0ZDzIquBg==
X-Received: by 2002:a17:902:b698:b0:158:faee:442f with SMTP id c24-20020a170902b69800b00158faee442fmr22821784pls.75.1652214768706;
        Tue, 10 May 2022 13:32:48 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:47 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 7/8] mm: khugepaged: introduce khugepaged_enter_vma() helper
Date:   Tue, 10 May 2022 13:32:21 -0700
Message-Id: <20220510203222.24246-8-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220510203222.24246-1-shy828301@gmail.com>
References: <20220510203222.24246-1-shy828301@gmail.com>
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

Acked-by: Vlastmil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h |  8 ++++----
 mm/khugepaged.c            |  6 +++---
 mm/mmap.c                  | 12 ++++++------
 mm/shmem.c                 | 12 ++----------
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index c340f6bb39d6..392d34c3c59a 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -14,8 +14,8 @@ extern bool hugepage_vma_check(struct vm_area_struct *vma,
 			       unsigned long vm_flags);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
-extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-				       unsigned long vm_flags);
+extern void khugepaged_enter_vma(struct vm_area_struct *vma,
+				 unsigned long vm_flags);
 extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
 extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
@@ -72,8 +72,8 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
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
index dec449339964..32db587c5224 100644
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
@@ -505,8 +505,8 @@ void __khugepaged_enter(struct mm_struct *mm)
 		wake_up_interruptible(&khugepaged_wait);
 }
 
-void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
-			       unsigned long vm_flags)
+void khugepaged_enter_vma(struct vm_area_struct *vma,
+			  unsigned long vm_flags)
 {
 	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
 	    khugepaged_enabled() &&
diff --git a/mm/mmap.c b/mm/mmap.c
index 3445a8c304af..34ff1600426c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1122,7 +1122,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 					 end, prev->vm_pgoff, NULL, prev);
 		if (err)
 			return NULL;
-		khugepaged_enter_vma_merge(prev, vm_flags);
+		khugepaged_enter_vma(prev, vm_flags);
 		return prev;
 	}
 
@@ -1149,7 +1149,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 		}
 		if (err)
 			return NULL;
-		khugepaged_enter_vma_merge(area, vm_flags);
+		khugepaged_enter_vma(area, vm_flags);
 		return area;
 	}
 
@@ -2046,7 +2046,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	khugepaged_enter_vma_merge(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, vma->vm_flags);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2127,7 +2127,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 		}
 	}
 	anon_vma_unlock_write(vma->anon_vma);
-	khugepaged_enter_vma_merge(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, vma->vm_flags);
 	return error;
 }
 
@@ -2635,7 +2635,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Actually expand, if possible */
 	if (vma &&
 	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(vma, vm_flags);
+		khugepaged_enter_vma(vma, vm_flags);
 		goto expanded;
 	}
 
@@ -3051,7 +3051,7 @@ static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
 			anon_vma_interval_tree_post_update_vma(vma);
 			anon_vma_unlock_write(vma->anon_vma);
 		}
-		khugepaged_enter_vma_merge(vma, flags);
+		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 29701be579f8..89f6f4fec3f9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2232,11 +2232,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 
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
 
@@ -4137,11 +4133,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
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

