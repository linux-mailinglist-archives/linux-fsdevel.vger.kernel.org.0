Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0534F1B1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379141AbiDDVTk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380412AbiDDUFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9906130576;
        Mon,  4 Apr 2022 13:03:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w7so9961097pfu.11;
        Mon, 04 Apr 2022 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UG1sy1iNDRLB0uN0cB6h3KgifvWMYW6S1PnONIaP3Qs=;
        b=bnyhwFA2JenCWTOWzQqWYVxa9U6bgYLgMEzDgfNWHGyZsV/BIcrzi093QQp94ckdhr
         Uw8gXhPnm8EuKl/5kb5GqXeC3lGRqiOLu9IvMiBPkwR4H0Ox20Wgtkdm7WK4E0FFoW7p
         wBwJ4LVJJbbzN5VkYE7c1wBpW+agLiIyWjn4uBQfG9gXmt4xRAypdwfzxiB5ZaojQqk2
         miEKZA17rtUekHkwxJf4j57ZKUr/cvVqaMRt1mi5xuwpogTpPjzRWKaLpFWJfAafCj5H
         izyLOdxXzfD3wtidP2aNkn5eO5R5SVaFkrQE9Hxs7MyYzSHQ6jXu89Vin4glfydzoCMV
         9u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UG1sy1iNDRLB0uN0cB6h3KgifvWMYW6S1PnONIaP3Qs=;
        b=b01SCSKJCIDu0g1WqRvbUB/8PYI0DlnevFlUkgpF/O3c3EkAbY24elPny1hWOrKFQl
         qR+T+Ny/nkNDKhni7EF/hmpcAPaKsd2gLKCMqFz5LSeUEMGEs/KEF6M+mi147ybq8xz6
         D4/z2oX8OFPFzuefiGyZa9RpsgWdehCSEktfdCm/7CzLWH2EhpLMzxIkNkMAsUlS9Nft
         is+LraH7GirgUc7Z2GN8j870gukWCaMCKmDuhY7kOMCDLT55WTyIu6MOpuSOAE34uIVI
         vIEK6gzzOWrNv54i2hMSwsQU/r+f0fF08qfuNhKiUQ3PJjNdOSZOKvMaS1iP8vBfNPPB
         HrfA==
X-Gm-Message-State: AOAM530n8JS3toJHrf40dLrbqVHhc2tgOGm4KYQrWBwKbWNe+c4cvxhl
        xxmoGTRZ5uHX2zBDXPRuHmk=
X-Google-Smtp-Source: ABdhPJyDNRgC+2cRPyN77hk18FFO+ZRAYgMHHVdxa0JbddzqzK8q+SgHKF/+4FYmXT2hQ1FHod/anw==
X-Received: by 2002:a63:4862:0:b0:385:fb1d:fc54 with SMTP id x34-20020a634862000000b00385fb1dfc54mr1284620pgk.57.1649102595118;
        Mon, 04 Apr 2022 13:03:15 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:14 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 8/8] mm: mmap: register suitable readonly file vmas for khugepaged
Date:   Mon,  4 Apr 2022 13:02:50 -0700
Message-Id: <20220404200250.321455-9-shy828301@gmail.com>
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

The readonly FS THP relies on khugepaged to collapse THP for suitable
vmas.  But it is kind of "random luck" for khugepaged to see the
readonly FS vmas (https://lore.kernel.org/linux-mm/00f195d4-d039-3cf2-d3a1-a2c88de397a0@suse.cz/)
since currently the vmas are registered to khugepaged when:
  - Anon huge pmd page fault
  - VMA merge
  - MADV_HUGEPAGE
  - Shmem mmap

If the above conditions are not met, even though khugepaged is enabled
it won't see readonly FS vmas at all.  MADV_HUGEPAGE could be specified
explicitly to tell khugepaged to collapse this area, but when khugepaged
mode is "always" it should scan suitable vmas as long as VM_NOHUGEPAGE
is not set.

So make sure readonly FS vmas are registered to khugepaged to make the
behavior more consistent.

Registering suitable vmas in common mmap path, that could cover both
readonly FS vmas and shmem vmas, so removed the khugepaged calls in
shmem.c.

Still need to keep the khugepaged call in vma_merge() since vma_merge()
is called in a lot of places, for example, madvise, mprotect, etc.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/mmap.c  | 6 ++++++
 mm/shmem.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 604c8dece5dd..616ebbc2d052 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1842,6 +1842,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	}
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
+
+	/*
+	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
diff --git a/mm/shmem.c b/mm/shmem.c
index 92eca974771d..0c448080d210 100644
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
@@ -2239,7 +2238,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
-	khugepaged_enter_vma(vma, vma->vm_flags);
 	return 0;
 }
 
@@ -4132,8 +4130,6 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
 
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
 	return 0;
 }
 
-- 
2.26.3

