Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9919D4C7EDB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiB1X7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiB1X7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:59:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE34A4F460;
        Mon, 28 Feb 2022 15:58:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id s11so2189902pfu.13;
        Mon, 28 Feb 2022 15:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVRCwJsnXRapubfoKiJlcGvRUl3JFnCz5Si7tbrZLpI=;
        b=LPc9yKE7q4GUZk+StLd67GP4m3Wy74Y/4FO2wtG0pHgA9+i6BhG5pSo3LIXwy+kN/2
         ytsJ6UjvwHuhTIhaUSwtm/andOpYZtnta0CknadHD4T+bAQrLhYKdm9hkDohw/HLl10e
         KhtiWm7dDcIOVueaxOvjjmPsnJPw8OOZo88af1mNJs5GRMHwajphoBIii3bb2fB8cJAl
         Tiu9j4DsmPyFLindLKcapatb/57mYkm/H6uwcJl3cIqzjUppbP48jpVh1g259tXyB3vg
         8fh0mI+AYeim7dcwv/oESfglqvrA2KeXw5J7SspnPhAILjJ+opx+IOzlH+kLgJhEuOTE
         TWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVRCwJsnXRapubfoKiJlcGvRUl3JFnCz5Si7tbrZLpI=;
        b=e5MkzMvK2qRaPo8sQyPKgkZ4aiAK32E5zosZJDxRsPf4FDDe1HnXMNKrvvVja7MfcV
         SosYoRxxklLq1LsWLBLWFZDqCOJ9XlxAh8nrBsPzo1gBrOrQOSSSxONLvgeGPicHS0A3
         2LREGlKTVFk48Nf15sZuaJjNydgzhrAYvrG/xTHPqybW2R0oEzFsO56qmHMV4W4gT5er
         rRazze6yadcwC0yuwHySXVm8jseWasJ9BUY6eLG4BuISPB2fRTkPnf9Dk1BW9eXMFpKa
         1ZVycNZfU7+WYdX5KGlXGO/QcqI4uccd1XRlNNOZo6e8F5ZiLYUvg6am5E5ET5DcneS/
         J6rQ==
X-Gm-Message-State: AOAM530yg7MS/G0qCQCHbmYHZ6T/blLOQFdVcx7c2+IuM7XrpoWTnXmg
        0p9kxEbYmkvSorXNCgethNQ=
X-Google-Smtp-Source: ABdhPJyuOTDdsUnt1yb7WW+NRJmeVFGOWeL67LCaX3vde5vYx61mSkUMtKzLTWNpTwg6F1RLu5vGwA==
X-Received: by 2002:a05:6a00:134c:b0:4e1:75b:ca4b with SMTP id k12-20020a056a00134c00b004e1075bca4bmr24166481pfu.37.1646092695126;
        Mon, 28 Feb 2022 15:58:15 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:14 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] mm: thp: only regular file could be THP eligible
Date:   Mon, 28 Feb 2022 15:57:37 -0800
Message-Id: <20220228235741.102941-5-shy828301@gmail.com>
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

Since commit a4aeaa06d45e ("mm: khugepaged: skip huge page collapse for
special files"), khugepaged just collapses THP for regular file which is
the intended usecase for readonly fs THP.  Only show regular file as THP
eligible accordingly.

And make file_thp_enabled() available for khugepaged too in order to remove
duplicate code.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/huge_mm.h |  9 +++++++++
 mm/huge_memory.c        | 11 ++---------
 mm/khugepaged.c         |  9 ++-------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e4c18ba8d3bf..e6d867f72458 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -172,6 +172,15 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool file_thp_enabled(struct vm_area_struct *vma)
+{
+	struct inode *inode = vma->vm_file->f_inode;
+
+	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) && vma->vm_file &&
+	       (vma->vm_flags & VM_EXEC) &&
+	       !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
+}
+
 bool transparent_hugepage_active(struct vm_area_struct *vma);
 
 #define transparent_hugepage_use_zero_page()				\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..a87b3df63209 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -64,13 +64,6 @@ static atomic_t huge_zero_refcount;
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
@@ -82,8 +75,8 @@ bool transparent_hugepage_active(struct vm_area_struct *vma)
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
index a0e4fa33660e..3dbac3e23f43 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -465,13 +465,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
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

