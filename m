Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D83522582
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiEJUcz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiEJUcm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3F519FF6F;
        Tue, 10 May 2022 13:32:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id j6so121091pfe.13;
        Tue, 10 May 2022 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XG6VTF0MKKyBvJ7LiNjeRAoppMqMyK0KQDU/n3DucWk=;
        b=PMhjaTnCNiBqvYANKcfUWI+ZsxV1u8tVoKwehsvBgPR2RO8ckI8e3lCcRt+GGQFVxq
         K+aNHihlxCeMd7YlipMUDpbilZ7k/WknqF1VpYC0ElnBfhKfuSDV0NQhLrepmM6O7fBl
         9uqv2lXcB3zE/Op1BjFkvflCXb5sMblUoAoACyX6Tgg9svJKMuCABXHPlntdP9V8MUwc
         OnNgmbK1aux9SskLR/NTo2Gp9nQNB7mkaBDgIg4cbPfpW3jFKiRUaVSDX0txy306jYi/
         Q0F5OJoRAg+orbNa3CPxZlNyYcEmwY5T3aX6ist/XLS7R5yHo78lSMS5A5Udyv8Mtlm0
         VA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XG6VTF0MKKyBvJ7LiNjeRAoppMqMyK0KQDU/n3DucWk=;
        b=QdnJuHb9y5VPS9ljbstjgDRBt7qvCvwpIpNQyjdcVSsb+ExDxbRm8K2x+4hIJtJhYP
         DvYedexg/GjdauArmXcjXiZ/B8mRfGkJnHfocmZO2gdeRWhoPSwj7n9FXK3+B2CcsGl4
         tocqE4FJPRW7knXeMvCktBgmbzZN4wHi7Zws7zxHDTfk81Sijd9gPE0k4l5umKOwkbbA
         2FW6hxQDUFPYkcudHWJMZ3Ya/Qp5QlaQ3ZIlrOVnmSP+UaApBAhakBiVga9jxjESEdEE
         53H2nVZGYTJMEtH2g03wUCEgAfprVthTR+mytg8PiaXwlNTNaNZPHmO8mtidpqi7Gn3K
         Nv2g==
X-Gm-Message-State: AOAM532jIfSODp/z92s6RaW2XqTmHTBEl9jrPzF7zSmloh5D+3Fd6Q48
        mCnWon4nMnLMIZAoAxSFgDA=
X-Google-Smtp-Source: ABdhPJxDBFjRdbGsSAuMlA39SdbMIa9m6FJbsVEC4ShwNFejY3QJzjUGmyo3GyjuRcco2U598+vqwg==
X-Received: by 2002:a63:2303:0:b0:3da:eae2:583a with SMTP id j3-20020a632303000000b003daeae2583amr4116533pgj.123.1652214761202;
        Tue, 10 May 2022 13:32:41 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:40 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/8] mm: khugepaged: remove redundant check for VM_NO_KHUGEPAGED
Date:   Tue, 10 May 2022 13:32:16 -0700
Message-Id: <20220510203222.24246-3-shy828301@gmail.com>
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

The hugepage_vma_check() called by khugepaged_enter_vma_merge() does
check VM_NO_KHUGEPAGED. Remove the check from caller and move the check
in hugepage_vma_check() up.

More checks may be run for VM_NO_KHUGEPAGED vmas, but MADV_HUGEPAGE is
definitely not a hot path, so cleaner code does outweigh.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Vlastmil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 76c4ad60b9a9..dc8849d9dde4 100644
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

