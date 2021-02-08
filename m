Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A153312C99
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBHI5r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 03:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBHIzB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:55:01 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8BC061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 00:53:34 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o21so8360982pgn.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 00:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V1vqZme5dUkJLXAIFa1FOp/NT03yErdrlnVUsdRukuU=;
        b=bx5T3ZXOiy8/mkGPTZZ4aQ1Ov6xqOxnsHxA6UjYIT/8cnon18UmMPPugV3JAE5y22i
         7IjEechfqZhELNm+4KnooZUM/lYKrPFgCpNa2i7QYFBb9DuHg2z4zthizo06KK13S+J1
         C0i7YwqWW6mAtoE+rQk/SWvcVGK2t3K2nta7D77XxmJMNHaYjXJnwleRTjgV5k0wiafQ
         L9J14T5tnvR0Q1Vnl/9Ryv+UE8YhBjktbk1MSgZHelAP+fnjLZ1IiTkTkU0Ywr9YHSjX
         wwf7nog71P0Y0JpsoQLnT+434CnMB6Ab93s9nMPaLS44W/3Rtr1kU3A6t+b9k35thHZj
         2H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V1vqZme5dUkJLXAIFa1FOp/NT03yErdrlnVUsdRukuU=;
        b=P5zAiuDMk7Ni+FkLpADtDIhKPlhZfEnXGIHz+8J74JsnwoLwHANNr6PbwMkxa87JOn
         Q1WSVTTcCX9WvE1wTJUWiM7HMEKhpm1FwiYH6Cy9/1q1Kln4DqYWGtwOyy8yu2O8/f5s
         yT7J9HbqLPS/9KYDAi+RUdFTjVWBgys8L1YvOLzmUy8CpoZKu+XliJHxun0cMOkKYBGJ
         mJtzVdrAnOGW+w2JJWgqgkc6H05PaslMq3jqtybNQdbPAO1rWSTHxBveeHbSsBS6wcZi
         B4f0AmaZkbkaKOIFC4/gfMfuHp8g52mBvSLNhv4+sygPKfxcd1vHj/dgHnTjqTCVCFh2
         TWjA==
X-Gm-Message-State: AOAM530hHwTCy81WDlVhDq8SXmEzeEZzk0HSpEowunvIbNL/l6KL5Aoc
        g/TaMHMkcltWQHiJJznWV0EDKg==
X-Google-Smtp-Source: ABdhPJz4JFIa9ciPD9g3DtSL6o+xw6dNMHhz3p4nYEJpmhwDnzOBGHNd3JN6X6Q9Ym/a63A95a8Hqw==
X-Received: by 2002:aa7:8ad5:0:b029:1df:5a5a:80e1 with SMTP id b21-20020aa78ad50000b02901df5a5a80e1mr651280pfd.52.1612774413913;
        Mon, 08 Feb 2021 00:53:33 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id g15sm17205179pfb.30.2021.02.08.00.53.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 00:53:33 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v15 8/8] mm: hugetlb: optimize the code with the help of the compiler
Date:   Mon,  8 Feb 2021 16:50:13 +0800
Message-Id: <20210208085013.89436-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210208085013.89436-1-songmuchun@bytedance.com>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the "struct page size" crosses page boundaries we cannot
make use of this feature. Let free_vmemmap_pages_per_hpage()
return zero if that is the case, most of the functions can be
optimized away.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h |  3 ++-
 mm/hugetlb_vmemmap.c    | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 822ab2f5542a..7bfb06e16298 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -878,7 +878,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index a67301a9d19a..2e7e1d6ee458 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -211,6 +211,12 @@ early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
+	/*
+	 * This check aims to let the compiler help us optimize the code as
+	 * much as possible.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return 0;
 	return h->nr_free_vmemmap_pages;
 }
 
@@ -280,6 +286,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
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
 
-- 
2.11.0

