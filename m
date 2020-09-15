Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45A026B83E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIPAjv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgIONEs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:04:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92B0C061356
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:04:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so2692277pju.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jiL3ii4AJU2Njj/y/vFrTYFZ6QNs3Srg45f1FwlIOSw=;
        b=UCioyFq/nMf2pfW7YzyCEcx4LL4/jL1jJUkht2xjt+BMHebuzK/UKImXusybczC6tr
         hTRa9/L+br3pbdNipbSH20dV6etCd7/zplLBClKqkOe4p99jl807aGZocuBegTAKWegT
         qW2M0vOxaqwVOFS01ltZ94MXkaAN3yu7UcDSaUKd6lyuAbXXcRx6JaBNLO4WCBHrONrQ
         mI/sHDT9Q2NI5W8AOCu7XWmJSS7/IKrSpKT5OJnmwubKGNTLD2TMr7GFNW3wXS1xr9xB
         kQBgwh1xu2xzg1c75B4nGCznnkOnVs7OKDaGcFSPjqv8srW2nRfVyrrMT3OMOu6XNeyH
         5Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jiL3ii4AJU2Njj/y/vFrTYFZ6QNs3Srg45f1FwlIOSw=;
        b=o9LHq8C+WqkxowBczt57vwGFkrMgdFsB2dmpufsltXXGFLGbLFQKXQgvTbnNG5pzn9
         vFgk8c301IYbEGpjHoBKBcfqPXTqzbi0IU422SgqzjdxRnoJjAAPdYRgblNojIetx5yh
         kOS5Cxz/+fp0ehGqLt6eIZ9G2lOcQ38YKW4NWDhCmHl2ovj0sjKngRTKIqtyYcrg5Sjx
         f05i0zJixBvd6JmxxOGCCq2LmQePrTPpmGDXEGHW4kaCMu77NOhukfgHUdpY34L8rJli
         Sy1ZBEf9vUFE9s/A3yqb4H7c5pl14h8qYRJwLtD4pBV44wUMby4+aceD2LOWO2SzTbSg
         s8IQ==
X-Gm-Message-State: AOAM531Tm/KGp6tdtgcWdg4UUW/Ljx9SXWhD74KzaMP7yZGBR47GeKMb
        S4YdJJx+F3Hj1lcgebCsInMqZQ==
X-Google-Smtp-Source: ABdhPJzDjZ5u/kFp3j7KzOYJwm3WjE591cWhOwkG8OQSFmLJnogu52u+8IhXbjfuzBZdoCwfGeOYwQ==
X-Received: by 2002:a17:902:9887:b029:d1:e626:788d with SMTP id s7-20020a1709029887b02900d1e626788dmr1206774plp.53.1600175043242;
        Tue, 15 Sep 2020 06:04:03 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.03.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:04:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 24/24] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Tue, 15 Sep 2020 20:59:47 +0800
Message-Id: <20200915125947.26204-25-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are only `RESERVE_VMEMMAP_SIZE / sizeof(struct page)` struct pages
can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so add a BUILD_BUG_ON
to catch this invalid usage of tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e66c3f10c583..63995ba74b6b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3994,6 +3994,8 @@ static int __init hugetlb_init(void)
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 	BUILD_BUG_ON_NOT_POWER_OF_2(sizeof(struct page));
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 #endif
 
 	if (!hugepages_supported()) {
-- 
2.20.1

