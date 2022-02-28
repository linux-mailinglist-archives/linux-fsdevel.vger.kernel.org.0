Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DD4C7ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiB1X7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiB1X6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:58:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F24D258;
        Mon, 28 Feb 2022 15:58:12 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h17so6498259plc.5;
        Mon, 28 Feb 2022 15:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8kDVzZeSF/gSse0fUjCfu4T2T1nlW4Umj0Wis3mUpc=;
        b=DtcxAF2YbSTtBa+NYkVVk8WdqZzc0TXAiOomstKNeYxOjPsnsVSIu8Trep2mjqdb6T
         jsLDhrJA39R4NAIZbYdTbTIhrI4ckIyWNXGzkPBt2C2niwCCOqSUV7wFrB3ISqJma8WL
         htd5qRu9kgUvXHxzxeL7RODzYPXvqmG8BHkIMbvDSsLcpnzN+/2htnU3Og2Ef9JsANgl
         bS7M1W3T7vOnGTGO8nKSku88gdZaBDVo3ZaM1qM46mlyzTnZ9+cq/oxfZiiTxklUgr4G
         f7BSoTKxcbhMlNvaPOPR6IDGpuEXv3DD54YgtamAD8PHO+GleKkbydY1IgzpNBF6ZjgM
         DHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8kDVzZeSF/gSse0fUjCfu4T2T1nlW4Umj0Wis3mUpc=;
        b=S9m/0rL4oAS39TlsuEPyuiOl1HDnmp0hPnSHViYVLUVxX43REFez50doUBXDIZmu6X
         IxtdDPm/g3FhMKqyV+W4Sj9oaWPHgGTvWP7QcspSj3I3lPbx2l+gwff3FdgkyE3XgCcm
         ZjVZUlpKtV2KSudu+sDqkaanll6w/SmQWv3Pfsc5NcZUKLzvmt6kCJPhtPGz3aQc3kzX
         OCKScS5zY0/dWwUbjsV0gmQ6FqSx9qi5bSZJSSP2FnuwhvhD3pu2OlmpS7ySrDGSCDgy
         0GWTtnd9cIK0XnsXbknEBAboqgBYurh4cOw0FsZlEbImHaNFBlOSjxcpBh5xXkenjFWv
         fh3Q==
X-Gm-Message-State: AOAM531e0g17GVxP8hgT/7Wl9WVIfiUiTXE22QZYUNLp/vceueVW7mNc
        Kg7dI43W+AQ5TSGT2Gh1xcU=
X-Google-Smtp-Source: ABdhPJyF4X1yuiU1rNjzj1hH5DMaMGbsoU0rLs4bppVSjZZfontbcTs0n4CH4W0cRbWUzlx+TYRyaA==
X-Received: by 2002:a17:902:a60d:b0:14f:b781:ccd7 with SMTP id u13-20020a170902a60d00b0014fb781ccd7mr23252925plq.2.1646092691740;
        Mon, 28 Feb 2022 15:58:11 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id on15-20020a17090b1d0f00b001b9d1b5f901sm396963pjb.47.2022.02.28.15.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:58:11 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        songliubraving@fb.com, linmiaohe@huawei.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] mm: khugepaged: skip DAX vma
Date:   Mon, 28 Feb 2022 15:57:36 -0800
Message-Id: <20220228235741.102941-4-shy828301@gmail.com>
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

The DAX vma may be seen by khugepaged when the mm has other khugepaged
suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
it will fail due to page sanity check, for example, page is not
on LRU.

So it is not harmful, but it is definitely pointless to run khugepaged
against DAX vma, so skip it in early check.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 82c71c6da9ce..a0e4fa33660e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -448,6 +448,10 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
 	if (vm_flags & VM_NO_KHUGEPAGED)
 		return false;
 
+	/* Don't run khugepaged against DAX vma */
+	if (vma_is_dax(vma))
+		return false;
+
 	if (vma->vm_file && !IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
 				vma->vm_pgoff, HPAGE_PMD_NR))
 		return false;
-- 
2.26.3

