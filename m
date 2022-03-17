Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A284DD150
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiCQXuH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiCQXt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:49:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598B2AA86E;
        Thu, 17 Mar 2022 16:48:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q1-20020a17090a4f8100b001c6575ae105so4587516pjh.0;
        Thu, 17 Mar 2022 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=30LWLJQV8dYXosutckVn4XhId3NQkyArrNjeupviuTU=;
        b=QAVrMWYYLggwaur7/Slf6NucuIwOCNCO6CoeQBthKAHyKZvkgx+a7sm2sHBPqQ0opF
         4Ki5b6Z0eXLr3PGCm9qtgaAY/ODWDKMdlFmdYoeEq0N1GBRlIz2z2tIICaXP45MUsac/
         f69JzjhxHzv8Bsf0K8UnOYG82Z8vsMetYba3YirBpAPXzyPHEbiwKSpahVFE7gDZoOY5
         FvLg3msNOHnXsZsKaVFyPHJUUWR7ZAq2C7JZIPlQMklTIZjjvHOCDAnKEEpMlUeDhOW2
         3TEalbREksSCv5UTseNYULzPHRoNQN60aTvVm/fgh8TzEUmBAhlMjIDjE5EqZkvYj82d
         J7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30LWLJQV8dYXosutckVn4XhId3NQkyArrNjeupviuTU=;
        b=fS4eJo7A3VI0IYEO+178w7GRqfZLwmcGP1CAvoRSCPTAtdglFgQTNllHMc7hc7+p3o
         2NG/nEtWR1d1CrO3KuL5xEawBTBxyERa85Vfl83qe0czdHqYt0IYYpH5v3j0TCfkeJ/M
         0kUEW3ZFVrYJysl4oy0zbqpS6Wt93W7fmBnDvCwVr0aAB7K1FS+6vWvte6RV1wPXn8uX
         AUGX6NPK4qYNB9pFzE5DctfgZp+4N/58d2lmdnWSDc+6GlUvWPrf9kBaF6+F9yrHS7x4
         LICHsf95ZH5NJzz+IRuHZJta6J5fx+mpk++L0JmczT0I1bczVD9x9mn8BPt9p3ieFGC6
         f/NA==
X-Gm-Message-State: AOAM531I1KkrTYy3kq6n+NtQnrrCT0efIOJnGY4xbmv9Yy0CvsDsfpLs
        FhMq6mH0tmlxs5fYW3EdgW0=
X-Google-Smtp-Source: ABdhPJyiE6aP96mN2Z6JWDNGGQUqnYvg1jk7rBq+HLDBH4ccEO+al+eqvAHhq16+7YAPwjWxn2X9Ng==
X-Received: by 2002:a17:90a:ba07:b0:1bc:a0fd:faf with SMTP id s7-20020a17090aba0700b001bca0fd0fafmr8254608pjr.194.1647560921021;
        Thu, 17 Mar 2022 16:48:41 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm8581329pfp.45.2022.03.17.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:48:40 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/8] mm: khugepaged: skip DAX vma
Date:   Thu, 17 Mar 2022 16:48:22 -0700
Message-Id: <20220317234827.447799-4-shy828301@gmail.com>
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

The DAX vma may be seen by khugepaged when the mm has other khugepaged
suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
it will fail due to page sanity check, for example, page is not
on LRU.

So it is not harmful, but it is definitely pointless to run khugepaged
against DAX vma, so skip it in early check.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
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

