Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FDD2EBF8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAFOXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 09:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbhAFOXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:23:08 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED3FC06134C
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 06:22:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z21so2327593pgj.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 06:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hon7HPngFu4HxwS2zmocIDkYMNnjiKlEfAxske+w4FE=;
        b=iciEoCytjnsQuJQ571GJQqBQ22jYCalqVs50SCci/1P44qwKKY+jwidPqJ61xNPXUi
         FpqiDh2S7zbs7j3i7H0XWY3oJHCb4JdRWj2nnP824eHaeFsIhwTxgtDJg1l6HOkNUh4l
         UKv1T5eheNxUlWvWhqS9S1kzqJl421isbJiJDw21bzod8orUZ8OQ9d3OKblQucyggBFA
         t8ZzXKf1M1ahcWqFedSzB0w0U/8cZSa6UMDmlPc10mGBQXQkPwft3hkwetlbb+bE3X8V
         z2t4DPVuFppIwkVtsIgZzTY1FSUeo0iBkX6FIvAcodXlzxlOGYbrxEA9xsgvsb17yNzn
         3PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hon7HPngFu4HxwS2zmocIDkYMNnjiKlEfAxske+w4FE=;
        b=nn5Rc3+mq9x8htYpR3Bkxs5wN5G+gdiNPNcp+56ASENcnmoIYo/aC3nIdk7B+hW0vQ
         z+4TR9LlTRhAtAbtjQO6o9Debfk9IwrvdimaGOOfUV7KEcdGTAHj8pUtwN9+7dne8wtU
         rV3l03vyerksf+Z0hUD/ZCPOFCqyODL1Peqf1v7aOwW0LQ+0H606s31gvV+w7/C9m4rt
         +Y+7BYB4n+0vDSP8GV1l6I1YvfFuRTMBFZeUORhs07FpWEOkZpKpxlGDB9B1Oe9KtRzu
         k9AHdVFRAUEz/jGPTH//+6etxS869grjXWZ5B8QThQ4jpxoEwwovlry3EBbFU4Sv3mDD
         U47A==
X-Gm-Message-State: AOAM530m0Fc2ySNTWOEEX9Un3CM9CTn2ulxolZbF8jeu1X+FaEKnbfSg
        YGhsny8HBr25qaDhTsrPIGkheA==
X-Google-Smtp-Source: ABdhPJyHRzzmuLLYBccWbr5cuOP/iD1HKyoOjXtsLKUxObinuJ6v5dc8Cys4VvrK22eHqCDVTPR24g==
X-Received: by 2002:aa7:9ac9:0:b029:19e:19b6:6e09 with SMTP id x9-20020aa79ac90000b029019e19b66e09mr4071404pfp.49.1609942948040;
        Wed, 06 Jan 2021 06:22:28 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id a29sm2831730pfr.73.2021.01.06.06.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 06:22:27 -0800 (PST)
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
Subject: [PATCH v12 13/13] mm/hugetlb: Optimize the code with the help of the compiler
Date:   Wed,  6 Jan 2021 22:19:31 +0800
Message-Id: <20210106141931.73931-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106141931.73931-1-songmuchun@bytedance.com>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
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
index 05fd2db09b78..b685bc4d79d5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -792,7 +792,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
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

