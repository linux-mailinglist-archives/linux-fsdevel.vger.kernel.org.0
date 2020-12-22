Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB802E0BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 15:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgLVOcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 09:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgLVOcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:32:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EB3C0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:31:34 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id r4so7503868pls.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Dec 2020 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzS1srauFLdS7N6FaDP6UmV3KONPJLbFcZMdSU+F95w=;
        b=Lts37J0+3a2+gZxXrxIlmZsq95Q5atD4QwQiIzeJWwob3euyPog2S4lryq1WXf5hyc
         NCaQeZhkJrmH58b2gZybUS3oJlbFTtdpGM+qce4CtwbeAn1ahp3WzpJ0vTZSu0lfbnmB
         cVaMG8N4hFI0uw/+NFbL7XR7c2b7ikU7NvzH2zoSIRXHMNG19+dFYQ/qXqF679zcq6VH
         Bt+6xbRRGxx8/5jjqzJGP6NnwgnytuTrxp7vDe8IJRChjOZ3xZwOvBzaaMgGIkTYTkCm
         nz1m8RjpiY90rLrUmPsE/sUVmAjMmncCNmWsh8TAhB0CCtu9zW51z3eNF2KZ/wheaEH0
         R09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzS1srauFLdS7N6FaDP6UmV3KONPJLbFcZMdSU+F95w=;
        b=h5GdfHP+Kg5tkspuyAD30RaADzvNZftMwLFmVO2U6tYyXTRAJ6bg6/sggMHsF6VFAM
         TmR4tVDsHCeq6jOToHXpSfZKiKmhvbKXmK+gOTygPS/omoirFOYPb1wEc1KIRCDYbM6G
         8knjUK0oEIxAT2xqCTlEk/L/Lf0CDuEd1FKY/8SFPywmNTkXr+ZbjkmZqnXpLDyUeqQi
         RMuTiPKeeBZff9v2bhEI133RUmfVYnvS5Vam/a+CtfHSw3RbDcJt/MYaJ71UBPk1XW37
         gfpRCwmnqnp+yKQkqoYAm70YmTZ/BuLBsZtI8TSxFMM3rHOhUfGkbCeQcF50NIWOe98Q
         ueAg==
X-Gm-Message-State: AOAM531DK+EJiWYhOKYhzAcb18P0lylTMcB4Mb2wDjNRClLR0OhgHzHV
        /YEsr+Fz2gsnJXxoGv1Zb9/Tcg==
X-Google-Smtp-Source: ABdhPJy8DyVGhNGlLTRjXJsqd1MUxY4ju29rgjY632JH4g9tOkY13BOMltdn/B0pI2vP/UgK9jgUcQ==
X-Received: by 2002:a17:902:7592:b029:dc:3c87:1c63 with SMTP id j18-20020a1709027592b02900dc3c871c63mr10339125pll.47.1608647494418;
        Tue, 22 Dec 2020 06:31:34 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a31sm21182088pgb.93.2020.12.22.06.31.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 06:31:33 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v11 11/11] mm/hugetlb: Optimize the code with the help of the compiler
Date:   Tue, 22 Dec 2020 22:24:40 +0800
Message-Id: <20201222142440.28930-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201222142440.28930-1-songmuchun@bytedance.com>
References: <20201222142440.28930-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot optimize if a "struct page" crosses page boundaries. If
it is true, we can optimize the code with the help of a compiler.
When free_vmemmap_pages_per_hpage() returns zero, most functions are
optimized by the compiler.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 3 ++-
 mm/hugetlb_vmemmap.c    | 7 +++++++
 mm/hugetlb_vmemmap.h    | 5 +++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7295f6b3d55e..adc17765e0e9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -791,7 +791,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6b8f7bb2273e..5ea12c7507a6 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -250,6 +250,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
+	/*
+	 * The compiler can help us to optimize this function to null
+	 * when the size of the struct page is not power of 2.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return;
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 8fd9ae113dbd..e8de41295d4d 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -17,11 +17,12 @@ void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
- * to the buddy allocator.
+ * to the buddy allocator. The checking of the is_power_of_2() aims to let
+ * the compiler help us optimize the code as much as possible.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return h->nr_free_vmemmap_pages;
+	return is_power_of_2(sizeof(struct page)) ? h->nr_free_vmemmap_pages : 0;
 }
 #else
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
-- 
2.11.0

