Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3022B19A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgKMLJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgKMLGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:06:38 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F862C061A4B
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:04:57 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id cp9so4400190plb.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l9UdRDVTVA9p+ZXsVGnKTJDsCrdBiTFetvlG+i4H0yc=;
        b=AS+sztqaorePlJ6XZc9emmP6jtL7Eyohp2JdsVut2PX0qLCIhzXU6ZdcJNpPT2gjOe
         +Upw+iEiBZHarM+fDYKJ24SteIFOnAxkt0PnoSN9xIN+zKMt6XsBfFJst8vLxfPbvaaZ
         3HckQ+Q1gdNF7ujCbFtJv3uZ663GT/F+DlFdAGfuCDSDhUdo39cI2ocg9Zbk7PC+8S6R
         SF+j5BdZAwEeaifFMgIKWevLMFqE5W82s4o+s3+i3M2wJ2su6gKMyxDi2HGeX2RgZMFQ
         JI3/Zs3B81JEDn9BoL/g6z8C02w7I8hiSmC6NUvWLgQjb2XHmALoyUA1IvWAVASMiGKR
         usWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l9UdRDVTVA9p+ZXsVGnKTJDsCrdBiTFetvlG+i4H0yc=;
        b=U4lyPpBWcuXeHFaBHoHJhx3fdA35zV0E7KHzVA4Rmjr0LRn1Kuduu4YPT4yT4SajDf
         aBKUlm+2r7ByZaIaQRayUkQcNxR7utMV7hMKCuinL8mmU/aut38lTl5SiOYGKPF2HFAI
         mqRxFK9gaF8g5PJjQJuP6ov6p2hpfaMm+TH/tD/7apkl03/6WiyxywjfKRUAv4npQxzv
         dq206Z8A22CSkUrBMmh1Ck89Qsd6CJkp0sYy/4Jv5RxhsFKUhmAhFoPP93KzLCGxrooi
         xTjm7uHFOFOF7b65pqDj+HeQtRsHoEfCGmGArxVBiNpgkvbbZsfytSr6+Oq7+xXurFYm
         brhg==
X-Gm-Message-State: AOAM531lgPdKj2Re9g0cBoiRjiK4RvWc8MkzfzvFHunzqHxkKlRNeHQD
        4dbQrSwy+rjUZGx0iHvIIAC48g==
X-Google-Smtp-Source: ABdhPJxzUgobcNi9dq/vlyFNji/6h++fpZQcRbnQtl2TuCezjK46BhKasiCuxIhitc0mAP75n+y8iw==
X-Received: by 2002:a17:902:9a48:b029:d6:e0ba:f301 with SMTP id x8-20020a1709029a48b02900d6e0baf301mr1794976plv.30.1605265496908;
        Fri, 13 Nov 2020 03:04:56 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.04.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:04:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 21/21] mm/hugetlb: Disable freeing vmemmap if struct page size is not power of two
Date:   Fri, 13 Nov 2020 18:59:52 +0800
Message-Id: <20201113105952.11638-22-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We only can free the unused vmemmap to the buddy system when the
size of struct page is a power of two.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f67aec6e3bb1..a0a5df9dba6b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -635,7 +635,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
-	if (hugetlb_free_vmemmap_disabled) {
+	if (hugetlb_free_vmemmap_disabled ||
+	    !is_power_of_2(sizeof(struct page))) {
 		h->nr_free_vmemmap_pages = 0;
 		pr_info("disable free vmemmap pages for %s\n", h->name);
 		return;
-- 
2.11.0

