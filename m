Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776A6522584
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiEJUdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiEJUcy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A681FC7E7;
        Tue, 10 May 2022 13:32:47 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv2so246564pjb.4;
        Tue, 10 May 2022 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qd2V4gYzSQy9/AY2gyoqLCp31tKNiHFMo2KNXlpicIc=;
        b=nnkjdEyWUoaYouv5dBAoGcvMsB87vwqUX748f2MsldAO7yY2nJU4YYvQv7c2KBgswg
         tJs67T7a9GYnD6yfXc0BrOiQvzpX93PsvRUnk8L1FLg5mOY7so3PMu9dNQsBnjcJh8gQ
         NG9gh/QcWXwoeOubR/w9wI+JMA/K/3/iyv3UvszSqPTEJa9KwXDp8zde+LXoHI7yvoid
         Xu6TP07Fpxw1KtaX8FkDQqbO68QHiWqxZsAuHuU0Pn2Uxs7VtX7L46oPgndAYLcHGX+R
         EV2ssx29fWm6xMW65GB6Pm3lXH1BFltML328WqhU0glpcmuAog2eLaj6KdLUSWgT9lGh
         P90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qd2V4gYzSQy9/AY2gyoqLCp31tKNiHFMo2KNXlpicIc=;
        b=0k5YuRlaVyZvHixleEnq6Pgkal63JsO3OwGp2x+uGsJ47kjCybmLKFZ3koCCOgpJb6
         hPdZCf28XPltm+G+I3S8hb8CpKi0msyQeRlgzovfVL26DwRY9Grmsd3x5Yo6LVqKgfEX
         FQ4R1wNYoI7pcFPXTWyk+zmFS1B1atLyko4gY4oqQNHZKDIijXALDIgKHoQr933gUe1E
         5yTnco30tDhlbV3eLEXEDubJEO+6Gcsr2g01VIV470A4xwmUTo32DTYJjOhU3tMoHdB8
         ryFHttUgcKhyfxu8L8VGcQ693e9m6I5QrBJVaJYo7rv9jRakAGuhhyoQoHKNDIbz/ls1
         w9BA==
X-Gm-Message-State: AOAM533jV7My6MBy3WqTmWxqdnyE5v6HUZrGFzi6K55kZDUEvD4vfdef
        zXDIETXtGL6x9J+pwiqOySA=
X-Google-Smtp-Source: ABdhPJyJfGQKpSGT3s9qaPsV4W+cAXWw7gFsDEedVDpmC7IxU3X+gl0uNVAXM3FDMXRcdZNwCPJvkw==
X-Received: by 2002:a17:90b:4a03:b0:1dc:756a:2463 with SMTP id kk3-20020a17090b4a0300b001dc756a2463mr1673723pjb.68.1652214767036;
        Tue, 10 May 2022 13:32:47 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:46 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 6/8] mm: khugepaged: make hugepage_vma_check() non-static
Date:   Tue, 10 May 2022 13:32:20 -0700
Message-Id: <20220510203222.24246-7-shy828301@gmail.com>
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

The hugepage_vma_check() could be reused by khugepaged_enter() and
khugepaged_enter_vma_merge(), but it is static in khugepaged.c.
Make it non-static and declare it in khugepaged.h.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h | 14 ++++++--------
 mm/khugepaged.c            | 25 +++++++++----------------
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 0423d3619f26..c340f6bb39d6 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -3,8 +3,6 @@
 #define _LINUX_KHUGEPAGED_H
 
 #include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
-#include <linux/shmem_fs.h>
-
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
@@ -12,6 +10,8 @@ extern struct attribute_group khugepaged_attr_group;
 extern int khugepaged_init(void);
 extern void khugepaged_destroy(void);
 extern int start_stop_khugepaged(void);
+extern bool hugepage_vma_check(struct vm_area_struct *vma,
+			       unsigned long vm_flags);
 extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
@@ -55,13 +55,11 @@ static inline void khugepaged_exit(struct mm_struct *mm)
 static inline void khugepaged_enter(struct vm_area_struct *vma,
 				   unsigned long vm_flags)
 {
-	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
-		if ((khugepaged_always() ||
-		     (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
-		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
-		    !(vm_flags & VM_NOHUGEPAGE) &&
-		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
+	    khugepaged_enabled()) {
+		if (hugepage_vma_check(vma, vm_flags))
 			__khugepaged_enter(vma->vm_mm);
+	}
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7815218ab960..dec449339964 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -437,8 +437,8 @@ static inline int khugepaged_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
-static bool hugepage_vma_check(struct vm_area_struct *vma,
-			       unsigned long vm_flags)
+bool hugepage_vma_check(struct vm_area_struct *vma,
+			unsigned long vm_flags)
 {
 	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
@@ -508,20 +508,13 @@ void __khugepaged_enter(struct mm_struct *mm)
 void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 			       unsigned long vm_flags)
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
+	     (vma->vm_end & HPAGE_PMD_MASK))) {
+		if (hugepage_vma_check(vma, vm_flags))
+			__khugepaged_enter(vma->vm_mm);
+	}
 }
 
 void __khugepaged_exit(struct mm_struct *mm)
-- 
2.26.3

