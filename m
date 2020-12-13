Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6415E2D8E62
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437304AbgLMPtK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437372AbgLMPs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:48:56 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E31C061248
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:48:15 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id s21so10417190pfu.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8PHQMDJVT/2kbWGLsVFJZvXcjqBWqkHm052KcpZafNs=;
        b=xoZ7TJtucKFyWd/KXHfwhMtbtS4gJ6sw9uzj7IqYvTpodH5CzDSwSgXuThA5h4Q6A+
         eZihdRRdqxg5NDapbLPVVgPCzSna72Ym4XfQXY6oSHt9a5RUQCNIh0qqBr7mAsuBCfoh
         8Kczq64LoXlGC0LpNaCTgeQD9aEe8/FBf9RY2n+DD2IWNpFwhGyEKpXKsYzygvQT0bhn
         Yh3PhLQdwuL7zMGzVhrd9JU3/4IXXL/poO5HC+z+5rkI7f/oiSOn+kFgDRuKIpFjcBXz
         8JPanJC3BkrKigzXcRTFANHdPnbkPk7SmCiDiUI3mzZogyAT6Qa9T7LzEzPWuvuXblWj
         1RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8PHQMDJVT/2kbWGLsVFJZvXcjqBWqkHm052KcpZafNs=;
        b=GmmSdltn/neLDUBMsm8UF9d1zoNblQzjzVlTZYr6OWw0W171moigOC6BDj7eiFy44U
         4UCjvgoTq5HKKUwIewFbBVnTRrO7nuDmv2WFHALixMFZvoOU6jDPsVJg5kRUeKRnHUWx
         ojUVjf3o3GRTuZ9Kn24RAvAnzS9ooN9rZJ5aXdW5vw59upf9kP0xuodhjRWrvYI56yWs
         nPje1voVy0hN1h4DVDG//mzYIet3OLuUIeAHql/agK8oYP8OXCXzL4V7CPEEj2K6EtL7
         5gV9XLbRopvU3j321vqY1I9jQfU4WEFr5fBCfwcPBlFxqQIJ7aItdngPjoplJ0FlybtI
         pbnQ==
X-Gm-Message-State: AOAM533A8w5T9aRMdqtO2xJDqFeNZ+IwlEu0aUJ1KHADgXhSbd7xOGl3
        yyBUaEEftc0eY961p72SbFb9Hw==
X-Google-Smtp-Source: ABdhPJxO8m6vbHvN+Y+6gAAGCOcfBgNQKWbes0jV8vWQBVVN5WQG3RTs7OvVcaoRVyAvV3yCN29fGQ==
X-Received: by 2002:a63:4e4c:: with SMTP id o12mr20238792pgl.348.1607874495455;
        Sun, 13 Dec 2020 07:48:15 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.48.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:48:14 -0800 (PST)
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
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 11/11] mm/hugetlb: Optimize the code with the help of the compiler
Date:   Sun, 13 Dec 2020 23:45:34 +0800
Message-Id: <20201213154534.54826-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
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
index bbcefd5fb7d1..e83c48c63a7b 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -240,6 +240,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
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
index 8fd9ae113dbd..1a29a80f9fe1 100644
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
+	return h->nr_free_vmemmap_pages && is_power_of_2(sizeof(struct page));
 }
 #else
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
-- 
2.11.0

