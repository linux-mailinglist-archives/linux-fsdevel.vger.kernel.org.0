Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6378C4F1B20
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356016AbiDDVTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380408AbiDDUFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3400730576;
        Mon,  4 Apr 2022 13:03:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b13so10057017pfv.0;
        Mon, 04 Apr 2022 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXLHEFwxWdm5e2nqHirZ7xmXS6hF3uNKov0CWo+0WO8=;
        b=YHcz6zZf1ucCYQxs+BMo39i9t7OYROE0FpXZIgsWDaCsFsP9IDsqC4+3466mFNuIoG
         XKIxMX/EeLaGaDSkKXYDFXgr8HlDPlMuePpgvGfBZZzWdJZVhx0N+ih7KKqf5szrrHnG
         U2wo/VL4ygXkXvcglMVPrPHRDkifd17EqbT23AB19ccgs8/Bx2WixuZmCXKcJXjImMCi
         9pRUoe3dQlpums5on1sx94iJXwq3mFhiR9L5ujIOE0fwiTJFVJbx9Nq/TPSCPK9/I2yE
         laPfy1lMXdXzUfgdglhd6cCi38CCqOWi0XfaDResSt6TIo2znuOjhuUfNN/4SJFyrfBA
         f7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXLHEFwxWdm5e2nqHirZ7xmXS6hF3uNKov0CWo+0WO8=;
        b=db5Pk4OZchByTCLXVe0f7bB4eG1qzZiVmT/WlcNLNF04KN/p7u/pFC783QihU9rNRK
         vPGN2O3DyuikCU0On6LpViget67OHF10KiR2nFvFZx2TOTpiL+QxePq7zi6iuzSjL3kN
         Fn0NoMEi8ly1Gnj2OqtR3vgNZuXJU2CsZynD535ijSMETYJcqXF85C8GD+YHlJxjfxM5
         6zQiIvuwt5zKZXLq4b4LA6708f+TRVIKnqKH/3e70uoZZzWJAn+41z22lfzLPHPuAr2W
         kEVoZ6mWREkuHgaqqrELYisrl8t1v2rfTDqPu5L2zYl5uVoO+d2aH7maWuljdewcGSPf
         Ri0w==
X-Gm-Message-State: AOAM530RcO35zbW6Evn3+qZ9ak+3nziEm4Hi7OEHqvH1oUaKXxh1PNSR
        OOZPC0wDjHAsHiU6lRXj5kw=
X-Google-Smtp-Source: ABdhPJyagGXZMLfLFwAcYGG46fuX5fs53R3Ia/YY5p1GvsQ1lu5ZQE6+/01O8gqaGg7avP+BtQr8dA==
X-Received: by 2002:a63:2ad0:0:b0:398:31d7:9955 with SMTP id q199-20020a632ad0000000b0039831d79955mr1273444pgq.198.1649102588645;
        Mon, 04 Apr 2022 13:03:08 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:08 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/8] mm: thp: only regular file could be THP eligible
Date:   Mon,  4 Apr 2022 13:02:46 -0700
Message-Id: <20220404200250.321455-5-shy828301@gmail.com>
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

Since commit a4aeaa06d45e ("mm: khugepaged: skip huge page collapse for
special files"), khugepaged just collapses THP for regular file which is
the intended usecase for readonly fs THP.  Only show regular file as THP
eligible accordingly.

And make file_thp_enabled() available for khugepaged too in order to remove
duplicate code.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h | 14 ++++++++++++++
 mm/huge_memory.c        | 11 ++---------
 mm/khugepaged.c         |  9 ++-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2999190adc22..62a6f667850d 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -172,6 +172,20 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool file_thp_enabled(struct vm_area_struct *vma)
+{
+	struct inode *inode;
+
+	if (!vma->vm_file)
+		return false;
+
+	inode = vma->vm_file->f_inode;
+
+	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) &&
+	       (vma->vm_flags & VM_EXEC) &&
+	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
+}
+
 bool transparent_hugepage_active(struct vm_area_struct *vma);
 
 #define transparent_hugepage_use_zero_page()				\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2fe38212e07c..183b793fd28e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -68,13 +68,6 @@ static atomic_t huge_zero_refcount;
 struct page *huge_zero_page __read_mostly;
 unsigned long huge_zero_pfn __read_mostly = ~0UL;
 
-static inline bool file_thp_enabled(struct vm_area_struct *vma)
-{
-	return transhuge_vma_enabled(vma, vma->vm_flags) && vma->vm_file &&
-	       !inode_is_open_for_write(vma->vm_file->f_inode) &&
-	       (vma->vm_flags & VM_EXEC);
-}
-
 bool transparent_hugepage_active(struct vm_area_struct *vma)
 {
 	/* The addr is used to check if the vma size fits */
@@ -86,8 +79,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
 		return __transparent_hugepage_enabled(vma);
 	if (vma_is_shmem(vma))
 		return shmem_huge_enabled(vma);
-	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS))
-		return file_thp_enabled(vma);
+	if (transhuge_vma_enabled(vma, vma->vm_flags) && file_thp_enabled(vma))
+		return true;
 
 	return false;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 964a4d2c942a..609c1bc0a027 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -464,13 +464,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 
 	/* Only regular file is valid */
-	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
-	    (vm_flags & VM_EXEC)) {
-		struct inode *inode = vma->vm_file->f_inode;
-
-		return !inode_is_open_for_write(inode) &&
-			S_ISREG(inode->i_mode);
-	}
+	if (file_thp_enabled(vma))
+		return true;
 
 	if (!vma->anon_vma || vma->vm_ops)
 		return false;
-- 
2.26.3

