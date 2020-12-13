Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1E62D8E60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437321AbgLMPsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 10:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437302AbgLMPsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 10:48:35 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0772C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:54 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id iq13so4865687pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 07:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UoePNyFzH81/Y50VNftfnwrNjalzBPSKlZ0P7dMLO04=;
        b=1AFD/oCkXSNirCm2p+m1rpWm9khOCZCufBu5Tgmajurx7K4I6b6BCsqvL8xc77/fzI
         kat3IN3qqNJLwR5zlWxCcHC9H7EK30fIxvRibG0MljEmYIctFLgBm3jXkiiANLngQbra
         sM9VHAalxMBkHdOi9UkjZO9JUmxlxMe4zyBNC/mDTEa6L1kQrKtcZcdk8s4cG72A4Vu1
         3QVIGXoR5/8YOLoLPm3BReuLDqVZG8Zpd8Jb5908r6Gfp2O+tL24XF0X91A5r7vV9VdE
         mEY7cDuI5NsCsbTQx9IkCk3ixalom1VzliZpNElCCACXDQ+QvpuQtcvdFNb2XaVxq0Is
         IctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UoePNyFzH81/Y50VNftfnwrNjalzBPSKlZ0P7dMLO04=;
        b=C4Sn2BRC+ld6qtJwHM+xkOL56w+nxBJGTS3VCMKYSRJpyXTPDIKPEJMRt+i8coOgk3
         mXk0r/oJm5ANdcTWRh0Ku/tMa0Avozme5nEkEwbXnFJ5oGf7pcES/kr7PEKmk3pFV+FK
         g5mjhwaQjXUN1JfrZR2v7kutnWd6VPavADNd9vk1w07jTnloBXKVpMtl8/fqABrN9TWy
         2XRcpsjzZQpHAxOIay+uRjq/o1gy9uO97CGaJx5vrIiUqHrGBpbEZd3Ows1zott8nUvd
         iyytAOifaL2vTIxCUAdle4PfzXUXOA4BoAk4MR2doHl8ydybSntzv7fbS3eQUW0aiSLJ
         Knkw==
X-Gm-Message-State: AOAM532X2mE7r5zvsPjvpQmllJ8qoQmEl1bIMx8BKOgNBGhnRwY/xr9R
        bMS8rnob+SX+v/Bj6WsSWyZfVw==
X-Google-Smtp-Source: ABdhPJyR6EfcfvwbKvCNayYwEIKpv0lDCQTOqO5hOY0ffty4yveTg5ZvseKOhu8KgsQdcCyOeKc9Xw==
X-Received: by 2002:a17:902:d34a:b029:da:861e:ecd8 with SMTP id l10-20020a170902d34ab02900da861eecd8mr18872343plk.45.1607874474534;
        Sun, 13 Dec 2020 07:47:54 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.66])
        by smtp.gmail.com with ESMTPSA id e24sm13113753pjt.16.2020.12.13.07.47.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Dec 2020 07:47:54 -0800 (PST)
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
Subject: [PATCH v9 09/11] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Sun, 13 Dec 2020 23:45:32 +0800
Message-Id: <20201213154534.54826-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201213154534.54826-1-songmuchun@bytedance.com>
References: <20201213154534.54826-1-songmuchun@bytedance.com>
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
index b0847b2ce01d..2b45235a70e9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3323,6 +3323,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 64ad929cac61..d3b4c39f67c0 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -184,6 +184,10 @@ bool hugetlb_free_vmemmap_enabled;
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
+	/* We cannot optimize if a "struct page" crosses page boundaries. */
+	if (!is_power_of_2(sizeof(struct page)))
+		return 0;
+
 	if (!buf)
 		return -EINVAL;
 
@@ -222,3 +226,28 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 	vmemmap_remap_reuse(vmemmap_addr + RESERVE_VMEMMAP_SIZE,
 			    free_vmemmap_pages_size_per_hpage(h));
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
index b2c8d2f11d48..8fd9ae113dbd 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,17 +13,15 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_init(struct hstate *h);
 
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
 #else
 static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
@@ -38,5 +36,9 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
 }
+
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
 #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
 #endif /* _LINUX_HUGETLB_VMEMMAP_H */
-- 
2.11.0

