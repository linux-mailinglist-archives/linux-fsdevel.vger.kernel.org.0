Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977E84F1B33
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379509AbiDDVTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380406AbiDDUFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A430576;
        Mon,  4 Apr 2022 13:03:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id o20so3309569pla.13;
        Mon, 04 Apr 2022 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjgpRMK0NYimSGrt6nJpOa6PTGJdKr7+fAKLKjoWSDA=;
        b=IECkqfJQKLLWFdbYM3okONxP8OCi2B/qhAroDXHSWfm5bYnfJL/3ruGjY7jjefY0Gl
         L5WjDq/N9jwBTvcrJCsT4J0fzr2xjvuh8bWlexy6BVuINn3TpgJJBr3tFnwRqKaSbXQk
         UYJi5I759jd55kj8vaDvPYhYuuRuxJrwRLhlVhmuNcZgQQxWNw03wVSIYlfZopIore1n
         Tt8mE/Gd9OPxT4FZm62VVyFVklJsp0cXJdXN7OoL2bdskeBCGMfODwfLgV3uYuYcubAa
         Q/M/j+t5uN2t9sdXHQticavAavTRY2vjlqVVwxtzg9HpDw8PcXGrXbh7M9fdlwtfra5I
         AU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjgpRMK0NYimSGrt6nJpOa6PTGJdKr7+fAKLKjoWSDA=;
        b=qakfGMyHe1n3bm/gekWuFWEXJvYp8lZthgoKFlqSCLHzUZgZaU9b3FdBcDdyimQqOp
         hhEdTzrAn7f8EaKeUhccFiDlTvcTjWucREi34xDt5lQCe21FLfthS0x6DPVsVzRlHXnL
         rwwRnvE6VnhYtFGVc3uZG3o7B1c2KK4ZGTIK1FJOnXumbQNSi2vNwGajuPdsE7CoqFJG
         +9413gOWf2a0AhrCQ+iMe1LXiLTYnukjKgNrCYf+VNsmRqE2WXw2ww8duwxGXjUnozk0
         ckBEi2A0Om7xhwk5dsnWJWv+KKqbeHg9e44zSSgc7yYWJTqPpKzVuvbJlGpt6UDs37tt
         JzVQ==
X-Gm-Message-State: AOAM5324Cl7jjK2bIPfh/zaLjzfJt62oL04ZpcVW6jq4PGZYy28ekpfO
        6wPsYEU7c1N1tYnw5/WAa0SLW7loiOY=
X-Google-Smtp-Source: ABdhPJwmqyYOoY4I6R15zAUVTjRG2/sPdiZ1ExIttI9HW/6wIEkHQfrDPIEksQO0dehGXzHTVVqHfA==
X-Received: by 2002:a17:90b:1b4f:b0:1c6:d91b:9d0 with SMTP id nv15-20020a17090b1b4f00b001c6d91b09d0mr920843pjb.72.1649102585569;
        Mon, 04 Apr 2022 13:03:05 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:05 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/8] mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
Date:   Mon,  4 Apr 2022 13:02:44 -0700
Message-Id: <20220404200250.321455-3-shy828301@gmail.com>
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

The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
in hugepage_vma_check() up.

More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
definitely not a hot path, so cleaner code does outweigh.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a4e5eaf3eb01..7d197d9e3258 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -365,8 +365,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
 		 * register it here without waiting a page fault that
 		 * may not happen any time soon.
 		 */
-		if (!(*vm_flags & VM_NO_KHUGEPAGED) &&
-				khugepaged_enter_vma_merge(vma, *vm_flags))
+		if (khugepaged_enter_vma_merge(vma, *vm_flags))
 			return -ENOMEM;
 		break;
 	case MADV_NOHUGEPAGE:
@@ -445,6 +444,9 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (!transhuge_vma_enabled(vma, vm_flags))
 		return false;
 
+	if (vm_flags & VM_NO_KHUGEPAGED)
+		return false;
+
 	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
 				vma->vm_pgoff, HPAGE_PMD_NR))
 		return false;
@@ -470,7 +472,8 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
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

