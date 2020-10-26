Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34913299008
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782218AbgJZOxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:53:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42339 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782214AbgJZOxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:53:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id x13so6313442pfa.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TwhoZYWAAJ4spxaYU005zizG4WXJst9HQa0pZQSSI5A=;
        b=ofh1BOhygl+Z4Ve3iyKHhCVRLjYR73IhevmV5pUJPTbOlI9V+UlgHoCY/fnYxlYIBS
         bi1vVrQObFpYy+toe0NkkdToVhZEgjiajB99aafIinCd+oNUTTfoZydyQzs/DQMa6jTp
         EhhP+JgFF0E+Jsw1lewEwwvTcjvyCcPro/Wj4RsbD9r4YxRn0yqvgw743s5SfPkO3Edz
         b3mqXxu8vFsg5PlYg6XXfMYJUyfpkSVGasVFysYIiasSGe1R9unkzTNZR9AGeAQRXt4Z
         00dVHXQnuymG93iT5HapQ66CAMNvJZV7As7ToW4bipnwqJRSdXWY9bZ2blcIgZkfttc6
         eH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TwhoZYWAAJ4spxaYU005zizG4WXJst9HQa0pZQSSI5A=;
        b=Bf/jgQ1d979bDtG3PponibyhHEZUvjG0hKX48VY7CUi5Yx+03ylxcKuUS9bhPMnNTu
         5DA55FmWfWWlEODKxIXwEIrV5TD1DuHtju2hYgE9COiGR3N4Qpyp/tnPTjiBE0QpwCXl
         EfREazyUT2suEFv9IGrVcEQCdNFzvZCOzRHzkfEADE+NaIchMhXbQBEnxNaYhXwLO+ra
         w0d+quE5g+DEcSCC3DxpvNu50itG2PTxTd0z1zV30e5QHpP/RcwPoe29JWOfUSD76JB0
         wdiU6UuHSS1294te6dh/Mp1GyfsOtd0HlnXH3XfgbcpEmQFZSrjhaMq+Id+rmCIMSYTX
         ZFWg==
X-Gm-Message-State: AOAM532ocQ7na4QKDavJnmyUm5ITtRHza5sUpbusIQYn8Ghb3oprZMe7
        htPOxZYDqIFkU+795nbqIImUQA==
X-Google-Smtp-Source: ABdhPJzVBaOtI8wZ67M0F/n/oeOrM0XQSDD8qgPgCcDxJxEI1BmEr6EJaVeRlqEpSvVra05uHaefCg==
X-Received: by 2002:a63:7e4f:: with SMTP id o15mr13919567pgn.428.1603724030714;
        Mon, 26 Oct 2020 07:53:50 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:53:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 04/19] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Mon, 26 Oct 2020 22:50:59 +0800
Message-Id: <20201026145114.59424-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the size of hugetlb page is 2MB, we need 512 struct page structures
(8 pages) to be associated with it. As far as I know, we only use the
first 4 struct page structures.

For tail pages, the value of compound_dtor is the same. So we can reuse
first page of tail page structs. We map the virtual addresses of the
remaining 6 pages of tail page structs to the first tail page struct,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

So we introduce a new nr_free_vmemmap_pages field in the hstate to
indicate how many vmemmap pages associated with a hugetlb page that we
can free to buddy system.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..eed3dd3bd626 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -492,6 +492,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81a41aa080a5..f1b2b733b49b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,6 +1292,39 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#define RESERVE_VMEMMAP_NR	2U
+
+static inline unsigned int nr_free_vmemmap(struct hstate *h)
+{
+	return h->nr_free_vmemmap_pages;
+}
+
+static void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int order = huge_page_order(h);
+	unsigned int vmemmap_pages;
+
+	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page not free to buddy system,
+	 * the others page will map to the first tail page. So there are
+	 * (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
+	 */
+	if (vmemmap_pages > RESERVE_VMEMMAP_NR)
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+	else
+		h->nr_free_vmemmap_pages = 0;
+
+	pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
+		h->nr_free_vmemmap_pages, h->name);
+}
+#else
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+#endif
+
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
@@ -3285,6 +3318,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	hugetlb_vmemmap_init(h);
+
 	parsed_hstate = h;
 }
 
-- 
2.20.1

