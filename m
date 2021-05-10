Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97686377A63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 05:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhEJDGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 23:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhEJDGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 23:06:09 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DAFC061573
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 May 2021 20:05:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c17so12635136pfn.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 May 2021 20:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BSt4jr/FgxsKxy0rJUn/jcFY7fK0AWKq0d7UvJGgtz0=;
        b=iq+/6o0tpRCjdYwUIR9yw2jfNGRHiFzv5jpu5lwn5oAmP1MiDjU3vj5MdnEY9th7m2
         Yhf5crX5cl2jk0lP8DBrqUlK+Ac0uSTDpkIjTUXC7sdKzGMA2MesGoddXNlcb38YRGlp
         2MREvSi055DN03/UuCKnQHp7XMuppYMmW6kQj7Zs7AH5OSHBlmvhORHH74COpqMadN8c
         uoXXZOXThoNwG+U+kdjeK0DPgxI6cyhfcV9eli9uFG/0+4RjAyoJKVfVcAqJUGSONwRC
         VLyEPu0O0ceOkNAe5YQIjeB5HiiRmRavlN05OgnepYBSC0Owt5HaCKf4bKnCETxadY4t
         eKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BSt4jr/FgxsKxy0rJUn/jcFY7fK0AWKq0d7UvJGgtz0=;
        b=fafMQzSPlrV9QktsceWrh3Ls4J///JMpxCl4ooY5mx5dCey03h22HK8z1KT8akaORc
         rEKs4VuJskkHgUxsPyzEi875eDLWYE5OYbW3icGYesk0VEwinB0G0Ec1cuhL3bakPd//
         98bPnpm94CEHs4JE01OxZEFTCHT3z7nqylrMKrprrMuVS8ilxCZNdzGtsz5SEZvusUnC
         DazC/UV4f/WGuzuwHI/7uAzZ1Ig5C64tcye50n99ZVhqt0AH65v4P+VE4y/zTffcbPn1
         3ww26yWZB0CrsUWLQ2UY1aj94hFfS4dPFqUiJxXWipL91yrNteB2UWdHZXuhm+sWybTm
         SyGA==
X-Gm-Message-State: AOAM531NfFyafzF1mGsz6wbdPSm+yPbMfmYxnEt0ISnyO9lnElMgalJZ
        jHo9OFh07KGGdIcwhGREGLtEQQ==
X-Google-Smtp-Source: ABdhPJyzMyV7PSUjaYsq7n9HZo4EdymQsSu5368s23As2YdNTXBAXghICe5lY9T6+wajPeZ3t/FoiQ==
X-Received: by 2002:a05:6a00:87:b029:28d:f62f:a749 with SMTP id c7-20020a056a000087b029028df62fa749mr22984759pfj.54.1620615903686;
        Sun, 09 May 2021 20:05:03 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id a128sm9777003pfd.115.2021.05.09.20.04.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 May 2021 20:05:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v23 9/9] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Mon, 10 May 2021 11:00:27 +0800
Message-Id: <20210510030027.56044-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210510030027.56044-1-songmuchun@bytedance.com>
References: <20210510030027.56044-1-songmuchun@bytedance.com>
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

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 33 +++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 10 ++++++----
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3258177f6494..e078db25cf3b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -602,6 +602,9 @@ struct hstate {
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
index 6e43ee6bca33..d11b41de9e07 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3517,6 +3517,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3070e1465b1b..f9f9bb212319 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -262,3 +262,36 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	SetHPageVmemmapOptimized(head);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
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
index a37771b0b82a..cb2bef8f9e73 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,17 +13,15 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
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
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
@@ -35,6 +33,10 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
-- 
2.11.0

