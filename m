Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8304C7ED5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiB1X64 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiB1X6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:58:50 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F124DF4B;
        Mon, 28 Feb 2022 15:58:08 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z4so12920593pgh.12;
        Mon, 28 Feb 2022 15:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+7utIe6zwoBoauJ2NDcsB651FtDL3xoIf2xpV9Lf8S0=;
        b=qXcrsfxt+hvAbzaB5ZB/MyAxUI9xoo6HoxydYwNc3CkF77+DBqZC8T5imRGPWrcRAA
         esh99RrRkr7bWkbYvpNi9XG4kEFjKk26aEuhEQ/J2Iu8zksxCUbIAmUrNU7+waOfM9lM
         yfphxzALZU1B1wD/dqWHXYoL+DYtJ8io1U1jAf70r+taKnzydII+k6v084eL8SSkYMue
         c/qRxVY6MuheK7tBR1u/mxmKUtMTqzKqdCy1Qp/R2wVHpWQUGVniSyRZBa5c6c6fO0A3
         5mVx8u6UxkZ+0YSiav8lTwmXy40ZD5wmo7tyzS5539mlw0GPSZRBGbghOu2hFqm0mI1y
         vrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7utIe6zwoBoauJ2NDcsB651FtDL3xoIf2xpV9Lf8S0=;
        b=7N94TMYYdTH/NMoIe24PvuveNoK2nhgSCP8gwZMvKgjhYlYy4doOLGecpG0ZUFJFCp
         5WtcDU2N+P/mb0/qI4M22crDTsim7NExg1GdcEqqXQZgerPVXPaVJ3n3JqmlMbx72aZA
         pd/fwn4VOwh4IBlKFLw6XjRdOgi4TrnIzxUhtP0IMVll+0H5hl1Qb/XfrgtCRENGZeSJ
         C8GPgVgOONpAw1SWxr1a/Q+Ro70e0rQAidsAIESEFGtZLw/SRWoLVVOTDo5ZVU5mgE9z
         ot5peW+Wt/nJ/NSepFcjkwijZgjbLKaVoJBtWtrRkt2ZoTOZ/bfXAobmbomAXL9djNqE
         LPUQ==
X-Gm-Message-State: AOAM533ciM6WDrmSlrgmL6+ovVu8JgBijjobbqoKb2v3xt0aD4RiKbHa
        fWEaDYbHOfX8EmShPKQDNyo=
X-Google-Smtp-Source: ABdhPJyUkJBFxZjHIgqTERZs6mkUNDMkgNt9kOSA3xlCm6y1IkyOi4wDqhot8eXP8IdFiudmtbtypw==
X-Received: by 2002:a65:63d6:0:b0:375:7cc6:2b63 with SMTP id n22-20020a6563d6000000b003757cc62b63mr19289215pgv.598.1646092688435;
        Mon, 28 Feb 2022 15:58:08 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:07 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
Date:   Mon, 28 Feb 2022 15:57:35 -0800
Message-Id: <20220228235741.102941-3-shy828301@gmail.com>
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

The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
in hugepage_vma_check() up.

More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
definitely not a hot path, so cleaner code does outweigh.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 131492fd1148..82c71c6da9ce 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -366,8 +366,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
 		 * register it here without waiting a page fault that
 		 * may not happen any time soon.
 		 */
-		if (!(*vm_flags & VM_NO_KHUGEPAGED) &&
-				khugepaged_enter_vma_merge(vma, *vm_flags))
+		if (khugepaged_enter_vma_merge(vma, *vm_flags))
 			return -ENOMEM;
 		break;
 	case MADV_NOHUGEPAGE:
@@ -446,6 +445,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
 
+	if (vm_flags & VM_NO_KHUGEPAGED)
+		return false;
+
 	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
 				vma->vm_pgoff, HPAGE_PMD_NR))
 		return false;
@@ -471,7 +473,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 		return false;
 	if (vma_is_temporary_stack(vma))
 		return false;
-	return !(vm_flags & VM_NO_KHUGEPAGED);
+
+	return true;
 }
 
 int __khugepaged_enter(struct mm_struct *mm)
-- 
2.26.3

