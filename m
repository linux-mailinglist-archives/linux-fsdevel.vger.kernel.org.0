Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0E2D5251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 05:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgLJD7z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 22:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbgLJD7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:59:48 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C7CC061793
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:59:08 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 131so2776831pfb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXEM/oAgRB8SPb1GBM6JgFCy32b9gAgKVaY2cNUX5bc=;
        b=t/PQvvxLvOVtqYNrE/8+ZXwVXT0apX4/Hj49KPwi1q8WFm2QE4Ds/rzhEIJQ3sXpn7
         05v2fJoDvPGcb07p7Cot+ADazISgVAfffDX7GRaKI2i3+dwDTAz2Sw7h1kZhi6OT5Fyh
         EpAge96UAF2ZrY4RX/HQGASumSQ6s9DbyVApII0DZsXL2Ry2WtgRkMtZ9Z1nrkaizodm
         37N4tCODgUQ2osiMTl9m21HxW3lvTTXro9rDkSt+8B2kBBhhr+R2e06B3zd324Qxpk/d
         sradaXafAsHYC1zxNTrq9Oi7VNWwmUmz40He3QuapJZ5FIH6innzpgVoMU3o94LAM64W
         o1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXEM/oAgRB8SPb1GBM6JgFCy32b9gAgKVaY2cNUX5bc=;
        b=k9ogZ4OPVql8EPbwnRE7xr2TbqC3K8rzbgugtHvJVmWxDBOPTkC+c5fn1SNmh+oslq
         CpArd/qmSTcajiYbXadFbCAe9jaXKgxeXc4ikCZS4UTs2CyAmQB8LVduTA5iIGEi4RNq
         9BSgurzde7ZZThaJiTBLDeroGEEImEYo3ogU1eytlc1J/uXJFZ2iBu9yoOZoHoVwGIR9
         ki5yDezCu2sEsBz4hvkLElUg/JlEHwf5XjbS6Xa4KKH+Q/Gp0yNTsoMh6Feppw9blHcC
         vPeKIvAKiZTGnHE115O9HOzAOiz4LsNhSEVqALWvtpW+1DxH/dUrfj3Xp6QzBTZt/0y4
         NA1Q==
X-Gm-Message-State: AOAM5320aNHVSSdou78G6RBtFL/FX7kVEoE2xKrR2SQViCVfMxde4OmO
        4L2LOSH8GO9MXtN9FLSMKQeKTw==
X-Google-Smtp-Source: ABdhPJwCdiHPHlcmtfk+GCubiq+fr68sz4WohtRe5uALUzjQHi9/NtYpB3850BNZ9mnXnYskq8JBig==
X-Received: by 2002:a17:90a:1b0d:: with SMTP id q13mr5262615pjq.21.1607572748392;
        Wed, 09 Dec 2020 19:59:08 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:59:07 -0800 (PST)
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
Subject: [PATCH v8 10/12] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Thu, 10 Dec 2020 11:55:24 +0800
Message-Id: <20201210035526.38938-11-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
field in the hstate to indicate how many vmemmap pages associated with
a HugeTLB page that we can free to buddy allocator. And initialize it
in the hugetlb_vmemmap_init(). This patch is actual enablement of the
feature.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 29 +++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 10 ++++++----
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7f47f0eeca3b..66d82ae7b712 100644
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
index 2e7a59b44364..6440367a71b6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3327,6 +3327,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f0926b382338..36a2e2db7913 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -421,3 +421,32 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	free_vmemmap_page_list(&vmemmap_pages);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	/* We cannot optimize if a "struct page" crosses page boundaries. */
+	if (!is_power_of_2(sizeof(struct page)))
+		return;
+
+	if (!hugetlb_free_vmemmap_enabled)
+		return;
+
+	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * system, the others page will map to the first tail page. So there
+	 * are the remaining pages that can be freed.
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
index 8fd57c49e230..0a1c0d33a316 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -11,21 +11,23 @@
 #include <linux/hugetlb.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+void hugetlb_vmemmap_init(struct hstate *h);
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
  * to the buddy allocator.
- *
- * Todo: Now it is zero, because all infrastructure is not ready. Once all the
- * infrastructure is ready, we will rework this function to support the feature.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return 0;
+	return h->nr_free_vmemmap_pages;
 }
 #else
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
-- 
2.11.0

