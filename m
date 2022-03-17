Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9193A4DD163
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiCQXuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiCQXuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:50:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C32B5EE5;
        Thu, 17 Mar 2022 16:48:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m22so6234506pja.0;
        Thu, 17 Mar 2022 16:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+Z88nKMaMfnoSMNb28nSkaCjqMBUKAv77UuVBn2dOA=;
        b=NOASi9NgJH/JhidTvkHtQlNha/nZlQouiv+VMSrwVtvNEwYlfFWCG+n2/7jjdRpBSm
         MY/X+xNVwdSloqJFf3LBUjzMllxCucZpqM9XZaVh9SCVlL5YIc8l3Ya6LRBD22kEwjuu
         dgnuWVgjO6iSnyFi4Z2IEO1E7EFhe1HtApOYrT/S2d7FQ0u2s5zwp53tgjQCg57iqBz/
         ID4ucyePPmJOTJcwhxzDjbN8SHnPxdRgOfWtE20nncuBfKLaF294ZhS+bxp4vKMj0Lmo
         uvQQJDiDTM8uxNZa62mz3YJEKqwfFEoCSqHkOSUvQA6r1I3W01MGxHi+uXPu8UrECc+v
         IaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+Z88nKMaMfnoSMNb28nSkaCjqMBUKAv77UuVBn2dOA=;
        b=uTqKgdvXkient94bJ96n4XkbvBxNyJ/aVecLaayco1IRoGgiybI8kL8jPSMQpoDxLK
         AepxbXBtysS5y63dT+MCYByuNx5ydv0WX/A23o0GlhoEZJ4y6OR/fD7nPJuIMi5kGZW8
         nMzuRlDl2u0isnsH3yWPMiTyM4VLGLQhlNm3Zhs6rYHEOgzuZccjq/M4iXoMRc8qt0X1
         kYmav5MLn53YRwykuPf4wZK9GuImxVtA9f6RtSpRJQ/i2hJq5xnr7zxLdGlJ62aYkBsk
         C4DTnuWEMM58kfsvoYuBsigvUE36z6rjPecQ3wFVRswWyaNjUi/iJuZDWBj/qK32YqG2
         XpuQ==
X-Gm-Message-State: AOAM532OYS7RrwXa0do54NsuQoA5XbLUEbQFekC3sXOFWjLcOrlpXdgj
        Wl4pJy9GZaSfgPoQbhMOuWA=
X-Google-Smtp-Source: ABdhPJxDC2A0C1V8B2FdGbOhYK6a94gMe52gtKBZcHpjue2Sw4OdOaK/2/qo2FvvMWbiqB7Gu8VYLw==
X-Received: by 2002:a17:902:f684:b0:151:93ab:3483 with SMTP id l4-20020a170902f68400b0015193ab3483mr7397253plg.4.1647560926315;
        Thu, 17 Mar 2022 16:48:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:45 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 6/8] mm: khugepaged: move some khugepaged_* functions to khugepaged.c
Date:   Thu, 17 Mar 2022 16:48:25 -0700
Message-Id: <20220317234827.447799-7-shy828301@gmail.com>
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

