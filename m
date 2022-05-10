Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C856522583
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiEJUc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiEJUcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 16:32:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2901D2FED;
        Tue, 10 May 2022 13:32:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so139673pji.3;
        Tue, 10 May 2022 13:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGfl4tySzp7alFhccaOml+d9CvpyhEwjlT3yjUxnaGM=;
        b=oyecuH2qIUB2Fn7kgYRrw4VNjuLMH1LgyyzcuskJbpv8K9b50xQtbfsaLyDw3vNr8k
         hf15D+OK5TZyzPRGlLajNp2rk62uDJVZoJ/UjCpnCJOTFJ5anwCkL62If8oZuGpdxwbU
         ZXZKM8ZaedmGH2PUnAdMMvryrgVR0WMJlE3Q8flaehfjvIYFjYpHBoERbn+dzRBJhz/M
         aegxNq59fonJxoX8M1jRfKm4h9CmToH9D+wDA2rZW8mIeE8uWpNyunVz843kyWjA9bzh
         xLuQ+hcfovSLXMruI2t9LA3BXkGXshZy6KfcstL05HopjRCl9obBYfeFu+fsrSpGKKBj
         QtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGfl4tySzp7alFhccaOml+d9CvpyhEwjlT3yjUxnaGM=;
        b=3mOF4V36DhAAQZokJ1ZZ26ypZE2A6QaMybq+2vQxU9Il85Eax8G9Wzwd99dcGQLOMi
         NdgCFf2Jkblt1ht3MjK+SSqKKcNIHWE01+rMkgWFrrEbbiv2hJRiyObxltx17CwT+Xia
         Xywex0PzhxWbLBEQ+TmNkgUTMR1cP5lWpWXXV2Lc6Sx/2IUeJnvVDmYUDmLyODotFfFz
         0pcQwKKiV9KA7DrHqvmmUDg0vK12uPe9iHexvuHdKtEwwAqh+eUyztat6dmcQsghLEyG
         ZC5dKSGf097y7+PvA/jUfLjEwqkkH3js8T6MtD5pR80LcALwPUnig7oFC8mfYK8LNq1q
         mV+w==
X-Gm-Message-State: AOAM533mRSs/UQ9RT9lXSSEivU134FxxYLJRmReWQSREk3agonUtDUeN
        4chS5wu4u0H0n2yhGDnp0yk=
X-Google-Smtp-Source: ABdhPJyViXcJ5aaAcoYE0zU3KvjlbGjVfyBwnobcIlCyWD1xAGHGjKSFQ99xQcrrqlIdbgCnn9NMRg==
X-Received: by 2002:a17:90b:35cb:b0:1dc:7905:c4c1 with SMTP id nb11-20020a17090b35cb00b001dc7905c4c1mr1630769pjb.95.1652214762733;
        Tue, 10 May 2022 13:32:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id v17-20020a1709028d9100b0015e8d4eb1d4sm58898plo.30.2022.05.10.13.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 13:32:42 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        linmiaohe@huawei.com, songliubraving@fb.com, riel@surriel.com,
        willy@infradead.org, ziy@nvidia.com, tytso@mit.edu,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4 PATCH 3/8] mm: khugepaged: skip DAX vma
Date:   Tue, 10 May 2022 13:32:17 -0700
Message-Id: <20220510203222.24246-4-shy828301@gmail.com>
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

The DAX vma may be seen by khugepaged when the mm has other khugepaged
suitable vmas.  So khugepaged may try to collapse THP for DAX vma, but
it will fail due to page sanity check, for example, page is not
on LRU.

So it is not harmful, but it is definitely pointless to run khugepaged
against DAX vma, so skip it in early check.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Song Liu <song@kernel.org>
Acked-by: Vlastmil Babka <vbabka@suse.cz>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index dc8849d9dde4..a2380d88c3ea 100644
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

