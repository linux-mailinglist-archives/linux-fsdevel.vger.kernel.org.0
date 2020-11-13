Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E4D2B19E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKMLSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgKMLCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:55 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFABC08E85E
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:27 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q5so7330043pfk.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cn1eur0hRRQaGJzuu65rghQYy8+1f9C2xe6gNwoWm68=;
        b=Qs7/EY2O7pRYN07lxQyNdfBkhlRaUWLkq0EuDrDXsHifqGUSi5pr8HXyqf8Xst8cLQ
         dSzl5OUZ0F4lAkTKSBFUZ9l+yO63guzHlT+LZZieFQoWkpTyJ9Ss6Dz0f/1grscLe8ai
         Qp45KvGwqMIQQJ5/l5iDlIkabIi14mdtPEDbVDoIOXOPxcg9QCxeocUYZ36ndhTv5zHO
         mJrd7MeM2yQawQnn1CrJaLMepWz2dNjx+V1h9paZUAySAdU0JaAeoYI+8fPlwBC1wwnS
         d4UwcY6yLfjtZrr8DORBjA/dI0KVQpXavlyny76UGOejpABWicFbHCoJyI4pO0pM7zXV
         bvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cn1eur0hRRQaGJzuu65rghQYy8+1f9C2xe6gNwoWm68=;
        b=PiCanvlZmgdouR+hfk6cygRtIJ/Gchu516cPHfQV4IzFYeLNwCuyxF6fRWpJuU1hcQ
         VB7lb74GPyvilYwCO/QNk1sCbruu15icWOjXAUDFSU50FgzAQMqigJ+Rk6Jxb5/UMNh0
         s3uhZ5KEljbIFBFW1uxG+7l2Nixjo5hi1mDCVD1GLnF/UeA6/kwLxTpee1NlUKwiNMXZ
         bmBnsxzqbe6HmhHQF8JH+dId4M1n/Jxo+XJPwCZgpxK1Xv767z/S8/3adf1uCaHJJGjV
         bQljXZ/FLglfvAo6MifaETvLjpToe/Xkp9WzSnhJof57CSrddepqTcVMcb50MysYyaXZ
         BHWA==
X-Gm-Message-State: AOAM530zkEJ9ajL/mUFF/ZJfruT5yTS8fRs8lFUlSyREoHyYhQ/yxCt6
        2DkMAfAilRZ3OVKV2mfnyekynQ==
X-Google-Smtp-Source: ABdhPJzfdPOUWv4x55loz+dkhdJH7Hla0oplT8khLvEfFiSk7stTfJ/zpEiwFwrNbNgwR3+YM3+COA==
X-Received: by 2002:a63:2f41:: with SMTP id v62mr1647071pgv.10.1605265347250;
        Fri, 13 Nov 2020 03:02:27 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:02:26 -0800 (PST)
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
Subject: [PATCH v4 08/21] mm/hugetlb: Initialize page table lock for vmemmap
Date:   Fri, 13 Nov 2020 18:59:39 +0800
Message-Id: <20201113105952.11638-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the later patch, we will use the vmemmap page table lock to
guard the splitting of the vmemmap PMD. So initialize the vmemmap
page table lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b7dfa97b4ea9..332c131c01a8 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -71,6 +71,8 @@
  */
 #define pr_fmt(fmt)	"HugeTLB Vmemmap: " fmt
 
+#include <linux/pagewalk.h>
+#include <linux/mmzone.h>
 #include <linux/list.h>
 #include <asm/pgalloc.h>
 #include "hugetlb_vmemmap.h"
@@ -179,3 +181,70 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	pr_debug("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
 		 h->name);
 }
+
+static int __init vmemmap_pud_entry(pud_t *pud, unsigned long addr,
+				    unsigned long next, struct mm_walk *walk)
+{
+	struct page *page = pud_page(*pud);
+
+	/*
+	 * The page->private shares storage with page->ptl. So make sure
+	 * that the PG_private is not set and initialize page->private to
+	 * zero.
+	 */
+	VM_BUG_ON_PAGE(PagePrivate(page), page);
+	set_page_private(page, 0);
+
+	BUG_ON(!pmd_ptlock_init(page));
+
+	return 0;
+}
+
+static void __init vmemmap_ptlock_init_section(unsigned long start_pfn)
+{
+	unsigned long section_nr;
+	struct mem_section *ms;
+	struct page *memmap, *memmap_end;
+	struct mm_struct *mm = &init_mm;
+
+	const struct mm_walk_ops ops = {
+		.pud_entry	= vmemmap_pud_entry,
+	};
+
+	section_nr = pfn_to_section_nr(start_pfn);
+	ms = __nr_to_section(section_nr);
+	memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
+	memmap_end = memmap + PAGES_PER_SECTION;
+
+	mmap_read_lock(mm);
+	BUG_ON(walk_page_range_novma(mm, (unsigned long)memmap,
+				     (unsigned long)memmap_end,
+				     &ops, NULL, NULL));
+	mmap_read_unlock(mm);
+}
+
+static void __init vmemmap_ptlock_init_node(int nid)
+{
+	unsigned long pfn, end_pfn;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+
+	pfn = pgdat->node_start_pfn;
+	end_pfn = pgdat_end_pfn(pgdat);
+
+	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION)
+		vmemmap_ptlock_init_section(pfn);
+}
+
+static int __init vmemmap_ptlock_init(void)
+{
+	int nid;
+
+	if (!hugepages_supported())
+		return 0;
+
+	for_each_online_node(nid)
+		vmemmap_ptlock_init_node(nid);
+
+	return 0;
+}
+core_initcall(vmemmap_ptlock_init);
-- 
2.11.0

