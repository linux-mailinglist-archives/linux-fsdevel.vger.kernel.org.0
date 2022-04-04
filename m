Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F364F1AF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Apr 2022 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379324AbiDDVTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Apr 2022 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380407AbiDDUFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:05:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F15E30576;
        Mon,  4 Apr 2022 13:03:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p17so9028094plo.9;
        Mon, 04 Apr 2022 13:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Byfy9VbIfRqB/lMq9E6coezN6yPt+vkfM62rVKg8Ao=;
        b=AxElP8EkjsWu9uFPszBvkLOkxsuJWaGma6j/kzg1J45uxCQnKl53MKPLXM3bzLcB+I
         UwsfPob2VOt2V0XPQHOnu7TAxvVCTNSE6KuScOlC36TWg6HJUDLUHa3UKvMJ9tgVEMxM
         9mCufQX3uNL8r407B9+wD7q4K36WEcTb94BSQY1zv4p3JQmfLZ+CfjlQOg0dLcMIL1xq
         u/37RX8brDJ70ogZGKbqWohxUI4JqurrzTqjcOhQQuCP0Ts7lmMczbesU4zwZch+8Nfe
         YJib5ZcU28w7VIwuyZk4D/d6e8f3uSR1N1molGoJqNfbFIIpiMh3azZJOiAIyidZztZT
         MxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Byfy9VbIfRqB/lMq9E6coezN6yPt+vkfM62rVKg8Ao=;
        b=gTrDsvwfNSMoTrzFwQhih+AcVt3tPnBmEB4wJ9+GP4knSuk0aKIJkqueWChVy//m8h
         hp8kdQQBEVaVAYG8EDQDgu9eRZGcDD1iYC5sZPaYH2IxmnCBtCfRCDaBEEX6Hg0y3Kwc
         p9Ei7hD2rSoAKbr3x+BcIW4GPQ1iCEtp8tXT6vfxe78d6VGFinIvObQUjC5yf4a1Unpd
         w56LxHBHdKjNkrqdhltboyw2nRCT9pTQEU/MdagV7BQHLPbOoQXd1E5nVMZZn5W31e9j
         SNxEatWZW1Rw4TYbnTy1WhxNYaKcEkU3rdFGTOIe0ijbpiSG7ua20l3uQBkaUiIF0eo/
         5ckg==
X-Gm-Message-State: AOAM533aWCqhS4OpLv0r2odYGm3jGVPaedYVkrGJCb8ikTFKLjLl/6S5
        Im4uP/zCgR7IrrkjxK2PeO0=
X-Google-Smtp-Source: ABdhPJwDGZ1eLAnRqgsHcj4iCzKkBHl8n8iAS//8VpbDXoJE+obiPqKFFGMKejpUxqvN5w0R05aYZA==
X-Received: by 2002:a17:90a:888:b0:1ca:a9ac:c866 with SMTP id v8-20020a17090a088800b001caa9acc866mr857483pjc.203.1649102587116;
        Mon, 04 Apr 2022 13:03:07 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id bw17-20020a056a00409100b004fadad3b93esm12779295pfb.142.2022.04.04.13.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:03:06 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v3 PATCH 3/8] mm: khugepaged: skip DAX vma
Date:   Mon,  4 Apr 2022 13:02:45 -0700
Message-Id: <20220404200250.321455-4-shy828301@gmail.com>
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

The DAX vma may be seen by khugepaged when the mm has other khugepaged
suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
it will fail due to page sanity check, for example, page is not
on LRU.

So it is not harmful, but it is definitely pointless to run khugepaged
against DAX vma, so skip it in early check.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7d197d9e3258..964a4d2c942a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -447,6 +447,10 @@ static bool hugepage_vma_check(struct vm_area_struct *vma,
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

