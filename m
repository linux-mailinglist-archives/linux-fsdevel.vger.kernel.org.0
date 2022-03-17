Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAF64DD14D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiCQXuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiCQXt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:49:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58D1A844F;
        Thu, 17 Mar 2022 16:48:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q13so5721192plk.12;
        Thu, 17 Mar 2022 16:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKQspk4LAoVq0Cn8x51eh1PH1jIoAPLYMSrh0f750IY=;
        b=jFpvMyu8Lmr30lvoJVeQyn6l2I3hQx7c4LidmLWMeHE4pc9vJJjEZWCIvkxKg+angN
         IKSwRoWtxS2l+HwIpyduOicwl2cPw8BId1H8G1v857wETnyNwbCcD8rxkYN7IHnbM2jv
         2yh1znyUjEMD/yp7wB5tzUGvQ9qmp4T31S+grwxSZv1lsoZwjngjtovgzZVDcZokHo3g
         LyHy8HqznKKYKNlcp7xXBV9YLMUT+CNXT7N/eUh+CGOJJPl1dryMvjJ7YiSeiYh+gS7/
         IzlJm8QRKIDVl5EKLTbQIgRQyqa0RoX0GyQyIGZWYNQWnC1C1SUsLE+Vii5kQf4cSfrj
         vv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKQspk4LAoVq0Cn8x51eh1PH1jIoAPLYMSrh0f750IY=;
        b=nIgUqY4YDCcRa+87glr/ySl8kTjMsEHjd5w2CEnCA7qWiMHZUjY6uG5jauvb+kd+Dk
         gseKnTLy10QfTQDuC7Hh+HSGZLY1t857Zm/AXV1YKv4jS/dQsBlDyDHDV0MbwA2xf1ni
         RSJ1HWXIyB4182vUsp2ceDMe7lMf45bS4SS8YZkPe7w5fS48jLzdrkunrdgdVhocyywT
         tz/91FErl3GmnbI9Hmkz0yswIGXOFKc+3x7qnORYSUhWuuGQM9XHQ7i8uIaK9SpWSNLi
         8zQgnAbbuaVL6nwIdRjva80a86ed8u40DWmJem4tBH0mr/7nq0WaIryvclsZZeOih+Sp
         p+EA==
X-Gm-Message-State: AOAM5339b8rnt1RV6sqIvV2l+Lsae9Ki9Ko8V3KdTL+uM8Dm/fKWJg35
        E3U4A5PdX2yinmnjvL4uEXGj8h409zc=
X-Google-Smtp-Source: ABdhPJydZul27UYLlzwCg5wysvPkxxFiprMv7eHU1Yr/csXpk/Erca9BMe2mrozIbghvD/AKSU+PgQ==
X-Received: by 2002:a17:90a:aa83:b0:1b9:7c62:61e5 with SMTP id l3-20020a17090aaa8300b001b97c6261e5mr8263237pjq.118.1647560919231;
        Thu, 17 Mar 2022 16:48:39 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:38 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/8] mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
Date:   Thu, 17 Mar 2022 16:48:21 -0700
Message-Id: <20220317234827.447799-3-shy828301@gmail.com>
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

The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
in hugepage_vma_check() up.

More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
definitely not a hot path, so cleaner code does outweigh.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
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

