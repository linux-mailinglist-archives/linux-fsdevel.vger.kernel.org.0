Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF21C312C96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBHI5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 03:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhBHIy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:54:56 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC8BC06121F
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 00:53:11 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id u143so3057015pfc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 00:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ddnoFs6SJKJ44dTXaXAudubzeNwXAb3aaNf0hJnNL8=;
        b=RZxJYvmH9c+M8pGTOJDGBnvNyCYjMMi77RjhX02JRcPuvl8HCKcpy1FUMcEp8TxbhZ
         tiYExfz/n/VZ6kHsrgzKuTHEbKzeOSc4iodrNycSW3e2sgDjO/VpzkAzMPEKHI+Emlug
         5A1EZLcH8/y5g91up1JbUqJuHjfXFZbKYZrX0MMlGVMxfwJF/GuimYluAyIeJnKMvoYz
         NQBHG35M1aHu3GubYqkoipUZ+iY9+V000x/4DTOjR/mzmivErCf6hFBPNpJEXaGPWAwf
         SoU9K4uXmadmQVVML6sjC7etvIkjgTXHezHN44iRIZBoarz09n0kgMqTf0wlriEwppDy
         kNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ddnoFs6SJKJ44dTXaXAudubzeNwXAb3aaNf0hJnNL8=;
        b=b3SvGsBi/0TVlI+XERxTCSCK9rwBJ4G1asMiTkgka7CsXmRwFUhBqYNGcUQ9Klt0GL
         RbiTn3dOwUrVSscDIavPpktmeSnSIsIxZiPV+EPiE3Jf6luHf48Q09ICdQiIpkiYaMlp
         odmnXpiscBOBQMSyz5lpH8u0eb1YGLO8kNka4ndeIjw33F2GT6wRx8FIylDy7PMdcyC1
         Sb3auc303Zfua/e4bW1KNPNP2oc0FtcdM8m2b1v5bvObRKvc4H07L3qinXosDD6VR6Nw
         dRRIYRZKbh6CVPUoVNYb6RMUrNk/E9XXS5LUNsbXt/1JZc/lm+a0XlRrws06oWyDWM0n
         Zdjw==
X-Gm-Message-State: AOAM533P8AfLl1JziLhq5EAN1fdmkE8IJNlmHfYn8STvdcE5ZVOOgmOg
        LauoYD55/uFQv/C6TMx80H2eEQ==
X-Google-Smtp-Source: ABdhPJw711jMv/FRKLM0spGFLN4dqzWmY1GRnUYQt1WzCv4/BhSOuZH/lPt7qHGh14TWeo8TI5yS7Q==
X-Received: by 2002:a62:190d:0:b029:1bd:e11c:4eff with SMTP id 13-20020a62190d0000b02901bde11c4effmr16997438pfz.22.1612774391056;
        Mon, 08 Feb 2021 00:53:11 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id g15sm17205179pfb.30.2021.02.08.00.52.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 00:53:10 -0800 (PST)
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
Subject: [PATCH v15 6/8] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Mon,  8 Feb 2021 16:50:11 +0800
Message-Id: <20210208085013.89436-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210208085013.89436-1-songmuchun@bytedance.com>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
field in the hstate to indicate how many vmemmap pages associated with
a HugeTLB page that can be freed to buddy allocator. And initialize it
in the hugetlb_vmemmap_init(). This patch is actual enablement of the
feature.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 30 ++++++++++++++++++++++++++----
 mm/hugetlb_vmemmap.h    |  5 +++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ad249e56ac49..775aea53669a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -560,6 +560,9 @@ struct hstate {
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
index 69dcbaa2e6db..89b500075d1f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3220,6 +3220,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 2fa6fff9f5dd..ac29753fb297 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -208,13 +208,10 @@ early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
  * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return 0;
+	return h->nr_free_vmemmap_pages;
 }
 
 static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
@@ -269,3 +266,28 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	 */
 	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	if (!hugetlb_free_vmemmap_enabled)
+		return;
+
+	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * allocator, the other pages will map to the first tail page, so they
+	 * can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
+	 * on some architectures (e.g. aarch64). See Documentation/arm64/
+	 * hugetlbpage.rst for more details.
+	 */
+	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+
+	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
+		h->name);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index e5547d53b9f5..9bc35d328ddf 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_init(struct hstate *h);
 #else
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
@@ -22,5 +23,9 @@ static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
+
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

