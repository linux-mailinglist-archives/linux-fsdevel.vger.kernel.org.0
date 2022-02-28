Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFFA4C7EE9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiB1X7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiB1X7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:59:10 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C2F13573F;
        Mon, 28 Feb 2022 15:58:23 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d187so12535614pfa.10;
        Mon, 28 Feb 2022 15:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+Z88nKMaMfnoSMNb28nSkaCjqMBUKAv77UuVBn2dOA=;
        b=Y/eAj4zOI32uQO07S2u9fw4pyH5VUHMWjTICZaR2LXS1QNnXSUZWy8gwZObI0JlAuT
         eV7p0ri47A+rjBcmwwR0YL1tP8tc7DgO9DSTYR3BFkxLcKOec3g/0ZKKLLrLHbLuSTDJ
         1t3XLM3wv3r6DoCOg4FiXvLqtLPe8epceOXb7JXhjc2NQ9H14MlP/qxYUVORZzEsy0vc
         PxP/F2Uslq/UxPlOvY9swJgpq7Easigg3RYr0FLqZ4wHbLvFMQMaiQbEIwmCazkhxHUp
         AyEhW8Shpi8rx1XYpm/lisIWpPZQpD1WPyXPU8sLHszlNGHtFo+kWUoz7BuMO94Uy5WG
         PIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+Z88nKMaMfnoSMNb28nSkaCjqMBUKAv77UuVBn2dOA=;
        b=AULGKj2BVtFbAM/FzRRDayUf/auvy+2DI17IWtzY7gmJnPfD5GyAnwz2eWc2f/mF7N
         b7UUShmnOTThUZ70Th4+AUGNdNJYIV0gMDcrbhNZ6CjsSlZvolkX3K4FBt0QJTP+bnyq
         1kq2tQDBznaaJWsLaElZRYLcW+dOIKR0HIkIKv2jH+queYShf9pKhkHWScw+q/ZhitI9
         hid759xLDpzTGv6K9JebsmgLDqi0dX9IDxlBre8fvLIbCzEBbhL9lG4zEB1J7SI8BPpK
         lLsWwE0yhpZFcqSowc6EBf14TsPpuC5GPHmfMn1bGN9cq9LT3UXvh1Wz7QKd7Q95IuQp
         1wQA==
X-Gm-Message-State: AOAM530iur5uNhuZ7tX48sge3ndcu3JYB2RprNQQrgGz5mhDJuhqvjfb
        yuAxezClpinjU3nlVyqQ61I=
X-Google-Smtp-Source: ABdhPJxBLejg9ODYXcpvvGlLqL7Xi68l/FsoGoG/EIgU1d8hoBFNE9JpZGiFHfRFdlAWUyzpUpx/8Q==
X-Received: by 2002:a63:790d:0:b0:373:cc0b:5b6a with SMTP id u13-20020a63790d000000b00373cc0b5b6amr19448962pgc.119.1646092703220;
        Mon, 28 Feb 2022 15:58:23 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:22 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] mm: khugepaged: move some khugepaged_* functions to khugepaged.c
Date:   Mon, 28 Feb 2022 15:57:39 -0800
Message-Id: <20220228235741.102941-7-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220228235741.102941-1-shy828301@gmail.com>
References: <20220228235741.102941-1-shy828301@gmail.com>
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

This move also makes the following patches easier.  The following patches
will call khugepaged_enter() for regular filesystems to make readonly FS
THP collapse more consistent.  They need to use some macros defined in
huge_mm.h, for example, HPAGE_PMD_*, but it seems not preferred to
polute filesystems code with including unnecessary header files.  With
this move the filesystems code just need include khugepaged.h, which is
quite small and the use is quite specific, to call khugepaged_enter()
to hook mm with khugepaged.

And the khugepaged_* functions actually are wrappers for some non-inline
functions, so it seems the benefits are not too much to keep them inline.

This also helps to reuse hugepage_vma_check() for khugepaged_enter() so
that we could remove some duplicate checks.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h | 33 ++++++---------------------------
 mm/khugepaged.c            | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 0423d3619f26..54e169116d49 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -16,6 +16,12 @@ extern void __khugepaged_enter(struct mm_struct *mm);
 extern void __khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 				       unsigned long vm_flags);
+extern void khugepaged_fork(struct mm_struct *mm,
+			    struct mm_struct *oldmm);
+extern void khugepaged_exit(struct mm_struct *mm);
+extern void khugepaged_enter(struct vm_area_struct *vma,
+			     unsigned long vm_flags);
+
 extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
 extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
@@ -33,36 +39,9 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
 #define khugepaged_always()				\
 	(transparent_hugepage_flags &			\
 	 (1<<TRANSPARENT_HUGEPAGE_FLAG))
-#define khugepaged_req_madv()					\
-	(transparent_hugepage_flags &				\
-	 (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
 #define khugepaged_defrag()					\
 	(transparent_hugepage_flags &				\
 	 (1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG))
-
-static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
-{
-	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
-		__khugepaged_enter(mm);
-}
-
-static inline void khugepaged_exit(struct mm_struct *mm)
-{
-	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
-		__khugepaged_exit(mm);
-}
-
-static inline void khugepaged_enter(struct vm_area_struct *vma,
-				   unsigned long vm_flags)
-{
-	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags))
-		if ((khugepaged_always() ||
-		     (shmem_file(vma->vm_file) && shmem_huge_enabled(vma)) ||
-		     (khugepaged_req_madv() && (vm_flags & VM_HUGEPAGE))) &&
-		    !(vm_flags & VM_NOHUGEPAGE) &&
-		    !test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
-			__khugepaged_enter(vma->vm_mm);
-}
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b87af297e652..4cb4379ecf25 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -557,6 +557,26 @@ void __khugepaged_exit(struct mm_struct *mm)
 	}
 }
 
+void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	if (test_bit(MMF_VM_HUGEPAGE, &oldmm->flags))
+		__khugepaged_enter(mm);
+}
+
+void khugepaged_exit(struct mm_struct *mm)
+{
+	if (test_bit(MMF_VM_HUGEPAGE, &mm->flags))
+		__khugepaged_exit(mm);
+}
+
+void khugepaged_enter(struct vm_area_struct *vma, unsigned long vm_flags)
+{
+	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
+	    khugepaged_enabled())
+		if (hugepage_vma_check(vma, vm_flags))
+			__khugepaged_enter(vma->vm_mm);
+}
+
 static void release_pte_page(struct page *page)
 {
 	mod_node_page_state(page_pgdat(page),
-- 
2.26.3

