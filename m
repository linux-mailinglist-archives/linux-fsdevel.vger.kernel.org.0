Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C6852258C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiEJUdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiEJUcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:55 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B68B255089;
        Tue, 10 May 2022 13:32:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w17-20020a17090a529100b001db302efed6so136188pjh.4;
        Tue, 10 May 2022 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2zZRYMCn2b2gDLpYI5z0secDrQJa1a/mRP4v8GDdaI=;
        b=WFhOORKCopujXevIEId5Pou5+f06pmdKjIe9jKkQl6fsJfPMy2ZxbNmrBw/2Yml9o9
         MoS9B2R084AHZT40mOyNfmDmn+do82XYuo+DrjNwUZHbtLDt+HC6/KCbTs9BsGY6xLZI
         02uFB4QsRjxxaDGTmrwBMMkq6RjAyY0qzhY4N4Mw5ltluWRLsQzPevqYMNIuYFXmQLsh
         YWBRKj8FxJM0bvYtfLdWexGP2Bqn9TXxRkyBrizdT9yvs5VQeu45FQcNdzUG/IQ7j7qe
         vdGuWvwsWudDK5+hkjCfIuu6aksOU7DDtw5iskC+jRcQQO/3xQzqGFyK7G+O0uHJ33/N
         jaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2zZRYMCn2b2gDLpYI5z0secDrQJa1a/mRP4v8GDdaI=;
        b=nYihOBs5PHcxP3gjWk/Bwyil6FzW8Ipv+VnxV6azvyku6gwFNfeV8ulNOmdOMEmpxW
         IKLVLphxXzyIGuTEhUpdGCFJPsX+9VJr1fBxhRKo5cvpAha7U09y6ZfGv9LbGDRVJcDi
         F/L2USaLs7PJRGEbuRIAqq75Kqnev5CIjDS7n/dgKdgHpUtzsVgnibMsiuaDiVbpM8Ik
         okv3OT5ZZU9Lts/5uB4VBOfnP3Sux4Byt0QGfOysSafNm36ibkIbOMwNZAYHzgCt93cu
         oMNmOdhq60RaLVP/XbPdD97ZAMIZ9QpsE7qmnYrWHorb9PMS9jKRIw520oqi78OK5xCS
         cnoA==
X-Gm-Message-State: AOAM532WlywxE2be9cQv4eysDE9/7FSpL1+GZfuyS/qnBtipVIhuE0Kt
        yF0QG/K6NKmrFg7yju8rys4=
X-Google-Smtp-Source: ABdhPJyF3jtsrDiJCOCcE0BCnoWu8584chaVsDcym+NHrrec7AOOrK4v54yoEsWhmn+5HTcoIBdieA==
X-Received: by 2002:a17:903:2312:b0:15e:a6c8:a313 with SMTP id d18-20020a170903231200b0015ea6c8a313mr22095118plh.122.1652214770262;
        Tue, 10 May 2022 13:32:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:49 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 8/8] mm: mmap: register suitable readonly file vmas for khugepaged
Date:   Tue, 10 May 2022 13:32:22 -0700
Message-Id: <20220510203222.24246-9-shy828301@gmail.com>
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

The readonly FS THP relies on khugepaged to collapse THP for suitable
vmas.  But the behavior is inconsistent for "always" mode (https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/).

The "always" mode means THP allocation should be tried all the time and
khugepaged should try to collapse THP all the time. Of course the
allocation and collapse may fail due to other factors and conditions.

Currently file THP may not be collapsed by khugepaged even though all
the conditions are met. That does break the semantics of "always" mode.

So make sure readonly FS vmas are registered to khugepaged to fix the
break.

Registering suitable vmas in common mmap path, that could cover both
readonly FS vmas and shmem vmas, so removed the khugepaged calls in
shmem.c.

Still need to keep the khugepaged call in vma_merge() since vma_merge()
is called in a lot of places, for example, madvise, mprotect, etc.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Vlastmil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/mmap.c  | 6 ++++++
 mm/shmem.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 34ff1600426c..6d7a6c7b50bb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2745,6 +2745,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		i_mmap_unlock_write(vma->vm_file->f_mapping);
 	}
 
+	/*
+	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
diff --git a/mm/shmem.c b/mm/shmem.c
index 89f6f4fec3f9..67a3f3b05fb2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -34,7 +34,6 @@
 #include <linux/export.h>
 #include <linux/swap.h>
 #include <linux/uio.h>
-#include <linux/khugepaged.h>
 #include <linux/hugetlb.h>
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
@@ -2232,7 +2231,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
-	khugepaged_enter_vma(vma, vma->vm_flags);
 	return 0;
 }
 
@@ -4133,8 +4131,6 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
 
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
 	return 0;
 }
 
-- 
2.26.3

