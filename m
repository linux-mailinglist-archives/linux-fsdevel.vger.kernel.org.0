Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCEC4C7EE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiB1X7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiB1X7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:59:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7092136EF1;
        Mon, 28 Feb 2022 15:58:26 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so649926pjw.5;
        Mon, 28 Feb 2022 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8qThGmR6qWWYZNQEqh4yIj3Ne/feg2xUmJaASesT2M=;
        b=LcgiviPPtKQf+Yoyq7Ym1LQh5IjQuQxUzZMQnQbNObkY79MjvEU+0kT6e2d2QOYJ28
         tmpc48fdX2xECAAqffdE8n4vm5kr12od2ZdR6uC5+gf7A48Ht9EdyR+1YOjiyugwFLrm
         5W4ivZBBhe+WR1ochAVmnUXIQZqGo592s0Kc6Pojz1QdmoYvfgESOIMeu/AgXzb0B7Ao
         VUCwG/TqnODlUmhIKslMesq9l8MNCzhovKjS1Nd0KBgSbVc8TAjwo4zmQa5io6BrNT2+
         NT+4fl2mPyYMgZXW3z5h8oE3c+Ds5tKm+K7yegxLhKtChJShB9U7Gs7AAco/a80ERQgu
         ES0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8qThGmR6qWWYZNQEqh4yIj3Ne/feg2xUmJaASesT2M=;
        b=ULTvVe2PtbMw3C4hmyrW5+dxanpq5s5/znQ46+v7hDZs64mr7OeGXpOLSS/mbjKXa+
         2vZGP3nsvDXPvKetg2oVCUC7y/xkj2AMAQVDjGnDMtmYoCGfgir/1QwLMmWJLLNVl3wn
         vOOuheOlakuieLXjRxgmNUDMHWEnNAlGH/BZwzjlLW/A9EZeBOgEOeDTu2BhH9y+mvvA
         to2Zws4aHq9hokBenPavQRznsGCzES/heTicw5qskygfTHH9xBDnR0ScHdrdBU+o0npE
         k6TADA29O417CxsHSwb6xKHKS1YMKsywCJoV0QexW98RoXkb2Re5dWYNSk3oOk86ccTN
         rXFg==
X-Gm-Message-State: AOAM531l9vX5/hjgPwkz7YDNUTVr7UO2ghkh74GW8GiHoFYWgGXw8m/6
        4jhL1Sfd66ZoCCpEV57zp+o=
X-Google-Smtp-Source: ABdhPJyFc6bKerDrlYwteOuLB48KU0sCJ2MnBiYTLqL/dBe2GXiIupe81JUUbwoTRmj9GFlCEYKzlQ==
X-Received: by 2002:a17:90b:3b4d:b0:1bc:a5a7:b389 with SMTP id ot13-20020a17090b3b4d00b001bca5a7b389mr18923376pjb.148.1646092706213;
        Mon, 28 Feb 2022 15:58:26 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:25 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] mm: khugepaged: introduce khugepaged_enter_file() helper
Date:   Mon, 28 Feb 2022 15:57:40 -0800
Message-Id: <20220228235741.102941-8-shy828301@gmail.com>
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

The following patch will have filesystems code call khugepaged_enter()
to make readonly FS THP collapse more consistent.  Extract the current
implementation used by shmem in khugepaged_enter_file() helper so that
it could be reused by other filesystems and export the symbol for
modules.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/khugepaged.h |  6 ++++++
 mm/khugepaged.c            | 11 +++++++++++
 mm/shmem.c                 | 14 ++++----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index 54e169116d49..06464e9a1f91 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -21,6 +21,8 @@ extern void khugepaged_fork(struct mm_struct *mm,
 extern void khugepaged_exit(struct mm_struct *mm);
 extern void khugepaged_enter(struct vm_area_struct *vma,
 			     unsigned long vm_flags);
+extern void khugepaged_enter_file(struct vm_area_struct *vma,
+				  unsigned long vm_flags);
 
 extern void khugepaged_min_free_kbytes_update(void);
 #ifdef CONFIG_SHMEM
@@ -53,6 +55,10 @@ static inline void khugepaged_enter(struct vm_area_struct *vma,
 				    unsigned long vm_flags)
 {
 }
+static inline void khugepaged_enter_file(struct vm_area_struct *vma,
+					 unsigned long vm_flags)
+{
+}
 static inline void khugepaged_enter_vma_merge(struct vm_area_struct *vma,
 					      unsigned long vm_flags)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 4cb4379ecf25..93c9072983e2 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -577,6 +577,17 @@ void khugepaged_enter(struct vm_area_struct *vma, unsigned long vm_flags)
 			__khugepaged_enter(vma->vm_mm);
 }
 
+void khugepaged_enter_file(struct vm_area_struct *vma, unsigned long vm_flags)
+{
+	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
+	    khugepaged_enabled() &&
+	    (((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
+	     (vma->vm_end & HPAGE_PMD_MASK)))
+		if (hugepage_vma_check(vma, vm_flags))
+			__khugepaged_enter(vma->vm_mm);
+}
+EXPORT_SYMBOL_GPL(khugepaged_enter_file);
+
 static void release_pte_page(struct page *page)
 {
 	mod_node_page_state(page_pgdat(page),
diff --git a/mm/shmem.c b/mm/shmem.c
index a09b29ec2b45..c2346e5d2b24 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2233,11 +2233,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-			(vma->vm_end & HPAGE_PMD_MASK)) {
-		khugepaged_enter(vma, vma->vm_flags);
-	}
+
+	khugepaged_enter_file(vma, vma->vm_flags);
+
 	return 0;
 }
 
@@ -4132,11 +4130,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	vma->vm_file = file;
 	vma->vm_ops = &shmem_vm_ops;
 
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-			((vma->vm_start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK) <
-			(vma->vm_end & HPAGE_PMD_MASK)) {
-		khugepaged_enter(vma, vma->vm_flags);
-	}
+	khugepaged_enter_file(vma, vma->vm_flags);
 
 	return 0;
 }
-- 
2.26.3

