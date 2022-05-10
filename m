Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D77522587
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiEJUc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiEJUcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EE41D8101;
        Tue, 10 May 2022 13:32:44 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q4so14899844plr.11;
        Tue, 10 May 2022 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+fBA/niEzyMz/dVLkAQq7D2wtbVcVqUWXIX9SvJc74=;
        b=bmMV7n1Zd+0zJjtyvRqCG2AEpBXxPGKK9NySmncUY9Xq3S2vqznztNrSjK7iz5cTdO
         7HsPHxuKJrQYaBvDH0MVxJyhEj+HeiC0+CvQYyQh9V1qooj8xAf9QmbVflLnlkb2995g
         W3tsDXC5LYnGI1/GnGBqiW6+BaCMAk1jc4zXq0t6o8k4YWQrGnU02WJ6rttAJkegH1LF
         MKa6RFMg2R+Z/LpxRPJH/hWhFv9rx1IQMjTdTOyCPfXOFCf4Q2wOzH65PaJPB9nOoPsJ
         B+2+1U/DAYiU2q9nt7UKR4sL55Q7eRQ8O0gZWdSBQkr4hMcjwP9MbO5Te/CG03IJFw/Y
         mEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+fBA/niEzyMz/dVLkAQq7D2wtbVcVqUWXIX9SvJc74=;
        b=B25rUxd026SpxogkYNj1Tw8cxhguD5PFL90blBD1K8WIdoZsSgzJuNQWcALBRB9pF2
         QQNhhP5UDpWrGS2NrZYkZZi9nM746uV2uvGKNC1PNFNfaG1oXb2yHUq7ej7F5zUtmpyR
         Wm5kyLdvKRZhb6b1yuNkG5zCfANrby5xTk78feKz3gKKi9qwHvkjLSsV9MpyOGeR32Pr
         CHwfKcT9A/3HozPhn2ogA/z/9agW9PuuFReovfhZ5QE994kqmqwEZk6HJqehM4/GbwC1
         KpW18UiEO2hw9bUm5WsbujvjhGCEUJ5Hg9su8DKqM5BBrJ/VxwQQs8PmyAuraXhi0GxY
         PkWQ==
X-Gm-Message-State: AOAM533PnAyCglirRVsw2UMGQ/bzdoC/J48e4YJC0KKAcLemytkyvUoa
        RdeAf1opTv4KLxP7Vvhz6Y8=
X-Google-Smtp-Source: ABdhPJwI0XJpTDCvRLHH0Oz4A3G+1R0BD+GuNT2gqg7+DLCFYM/pa9ZmQMp7JZgjuxzoaWEXGggZEA==
X-Received: by 2002:a17:90b:4b51:b0:1dc:9172:f344 with SMTP id mi17-20020a17090b4b5100b001dc9172f344mr1676754pjb.130.1652214764273;
        Tue, 10 May 2022 13:32:44 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:43 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 4/8] mm: thp: only regular file could be THP eligible
Date:   Tue, 10 May 2022 13:32:18 -0700
Message-Id: <20220510203222.24246-5-shy828301@gmail.com>
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

Since commit a4aeaa06d45e ("mm: khugepaged: skip huge page collapse for
special files"), khugepaged just collapses THP for regular file which is
the intended usecase for readonly fs THP.  Only show regular file as THP
eligible accordingly.

And make file_thp_enabled() available for khugepaged too in order to remove
duplicate code.

Acked-by: Song Liu <song@kernel.org>
Acked-by: Vlastmil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h | 14 ++++++++++++++
 mm/huge_memory.c        | 11 ++---------
 mm/khugepaged.c         |  9 ++-------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fbf36bb1be22..de29821231c9 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -173,6 +173,20 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
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
index d0c26a3b3b17..82434a9d4499 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -69,13 +69,6 @@ static atomic_t huge_zero_refcount;
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
@@ -87,8 +80,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
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
index a2380d88c3ea..c0d3215008ba 100644
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
 
 	if (!vma->anon_vma || !vma_is_anonymous(vma))
 		return false;
-- 
2.26.3

