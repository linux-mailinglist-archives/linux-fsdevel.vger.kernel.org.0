Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7249F4F1AE6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379303AbiDDVTG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380410AbiDDUFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F6130576;
        Mon,  4 Apr 2022 13:03:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t13so9201615pgn.8;
        Mon, 04 Apr 2022 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=299dhLN8fZQaqsT9OGmphjyBEYT6w3EQIbst3RvXrxI=;
        b=pNHjfPkGU3nk4TyLoHEURVpFplmDQJP/QKBA1MTf9iPA+5O96M5KmGbjPNHgH3kGdo
         PB8MP/4BFQMW8iZUT0rXAvH6ICgHnflXm0yZiIGUM7ObvsZjlYZ1kOzxdSYTQ8oKUlcD
         cyxjX9o+hs4GHpbvU7N2kQhZtmPKCBsWlLx0CuJIf+mTLae52Gt2eRcr7K83q0NUB28Y
         5ztyPyaLXwKf5AcFHDFb/wXTRVMhRIA5p7kNnRPfO85xZkwHO/SKyosZrLqhwLQsDT8W
         hNrKMR2Ofm3nfe4E6BIpLMjFYbX0PQryTsa8GkPDukq569Dkfw3xpXh7ltx8WWQNiRp9
         ND+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=299dhLN8fZQaqsT9OGmphjyBEYT6w3EQIbst3RvXrxI=;
        b=oi7OFuwS2vbcJ7nlzWAb2j37XOWPBhzaP+P6IPnxEvLDGIvloDRNXPp7S7SOTuAf/l
         CaTW6ZXkkiHFIX233/QvhGLa9UcSSFvVUJV7Xh5tASEKnurfED90tDsXM6AlZKbJMyuG
         0rH4HGJZCgZy6sHjmNrHMjHHJHI2aqebl90ZFIVJ/PhsuvYHHTKgbODy0d35M9gYLmBm
         7MJp5Eq57Dh8P/ip28sHCmLZOvNrz6l7KSNBaKNSNTXLRolpYWxHTQvaWo3G0GpGhdbi
         52fO+vNVOVnq0SnT6AJsSndOvombK2sIyw/IPNNFzc/xEj3OTM4OJufXtctKYt9DI3KO
         aJZg==
X-Gm-Message-State: AOAM531muh3UC5UgLKjyrhrC5ymtbp62axNTahdrz2p+dRfjexeHoSru
        2mLer/BSq0KxAQt4+h7bqG4=
X-Google-Smtp-Source: ABdhPJznJU9yE4ofpoTqB4D8WgSLsYOq7fqnscvbG/DJjVa+BvOJgo1PB6ZgI+8pMnraeasjO3kvtg==
X-Received: by 2002:a63:4a5d:0:b0:399:5cd:1589 with SMTP id j29-20020a634a5d000000b0039905cd1589mr1293015pgl.22.1649102591800;
        Mon, 04 Apr 2022 13:03:11 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:11 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 6/8] mm: khugepaged: move some khugepaged_* functions to khugepaged.c
Date:   Mon,  4 Apr 2022 13:02:48 -0700
Message-Id: <20220404200250.321455-7-shy828301@gmail.com>
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

To reuse hugepage_vma_check() for khugepaged_enter() so that we could
remove some duplicate code.  But moving hugepage_vma_check() to
khugepaged.h needs to include huge_mm.h in it, it seems not optimal to
bloat khugepaged.h.

And the khugepaged_* functions actually are wrappers for some non-inline
functions, so it seems the benefits are not too much to keep them inline.

So move the khugepaged_* functions to khugepaged.c, any callers just
need to include khugepaged.h which is quite small.  For example, the
following patches will call khugepaged_enter() in filemap page fault path
for regular filesystems to make readonly FS THP collapse more consistent.
The  filemap.c just needs to include khugepaged.h.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h | 37 ++++++-------------------------------
 mm/khugepaged.c            | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 0423d3619f26..6acf9701151e 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -2,10 +2,6 @@
 #ifndef _LINUX_KHUGEPAGED_H
 #define _LINUX_KHUGEPAGED_H
 
-#include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
-#include <linux/shmem_fs.h>
-
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
 
@@ -16,6 +12,12 @@ extern void __khugepaged_enter(struct mm_struct *mm);
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
@@ -33,36 +35,9 @@ static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
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
index b69eda934d70..ec5b0a691d87 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -556,6 +556,26 @@ void __khugepaged_exit(struct mm_struct *mm)
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

