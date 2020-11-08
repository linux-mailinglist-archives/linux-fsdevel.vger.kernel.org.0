Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43BC2AAB60
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgKHOMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbgKHOML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:12:11 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FFC0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:12:11 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id z1so3249888plo.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7V5l6iVptpyNChOEqgaC9UYBunmQshAPJJMGH6oVOO8=;
        b=o0HEIRih4qIk8FKiaCrU/8jPPZ5TYT6PQWg9ap++vRxQ08ObrhpaevX4214Ob2VCY2
         bHwFHgK7NR9A1or3FsJjDVthim8iB3WkhekAJ3nEByhI9pBN6luYwVbGAUs/2G+uay5s
         gooJjeKFBKWzlkf2GamyV+vc4R6VeS43+OqoTKNV73tC1vCFejqm9W4GiKyrG5+yHeM3
         xd7pwh2QL62pQA13zHEZhVG27MtZ23E0H1cdnwbg4gAxNqun3pYYuoLtce5HF2bN6yCH
         HE4blj+ArUxxMH33jBUNT0HzpGNcmth0I2XO7RFjfCMZqNitjz16k+F4CXTTflMWN6uF
         mbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7V5l6iVptpyNChOEqgaC9UYBunmQshAPJJMGH6oVOO8=;
        b=EhU9hHMnQHZzuo7ExADzyi1uJdDWrbNb1y47IfHrbPdreNV+dzHZJI4u98AE4gWtMT
         vN9bRQDlofp4ZQBLniaGaGGlyxWFLfjMlNGRr1sF/UkvSutHdZh2L8yFDQFEop57hPpS
         5XyFYwtOhpIARbzAlKB6fqFuo0sTcF+eInwr4jv5JnjCFCAeJHPWhV2M2bJZ1tt6vm6o
         +qEHveucbYonf5p8WO3aUPnDFiT2b4XEGrRM2YSdGrwBqMw1F2aiz/a5C80ESI5UTg+D
         m3NTXlWAElb3hSvdUZG/VaAKPTdKFAgrGQSpfFTehVhXpgrjj5t/UETS6oIBvigBsEAy
         FC4g==
X-Gm-Message-State: AOAM533nl52CZKWMsHGpO5ghh2Rtf7fWWmahSOnzBXYSMthe0hUeYrV4
        anwvQ7yUZbgAAtosz0KufaRaFw==
X-Google-Smtp-Source: ABdhPJwKM/CCRKYOI1UvT8sA6mZlrIw7idUpNoiTVHntW3fTsKokmQ5P/+hpT6dCP1V9Wu+5WLqwkg==
X-Received: by 2002:a17:902:7049:b029:d7:e413:8aba with SMTP id h9-20020a1709027049b02900d7e4138abamr284690plt.30.1604844731474;
        Sun, 08 Nov 2020 06:12:11 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.12.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:12:10 -0800 (PST)
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
Subject: [PATCH v3 03/21] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Sun,  8 Nov 2020 22:10:55 +0800
Message-Id: <20201108141113.65450-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated
with HugeTLB pages. Now only support x86.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 16 ++++++++++++++++
 mm/bootmem_info.c     |  3 +--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a45f062826e..0435bee2e172 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
 
 static void __init register_page_bootmem_info(void)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
 	int i;
 
 	for_each_online_node(i)
diff --git a/fs/Kconfig b/fs/Kconfig
index 976e8b9033c4..21b8d39a9715 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,22 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	bool "Free unused vmemmap associated with HugeTLB pages"
+	default y
+	depends on X86
+	depends on HUGETLB_PAGE
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  There are many struct page structures associated with each HugeTLB
+	  page. But we only use a few struct page structures. In this case,
+	  it wastes some memory. It is better to free the unused struct page
+	  structures to buddy system which can save some memory. For
+	  architectures that support it, say Y here.
+
+	  If unsure, say N.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
index d276e96e487f..fcab5a3f8cc0 100644
--- a/mm/bootmem_info.c
+++ b/mm/bootmem_info.c
@@ -10,8 +10,7 @@
 #include <linux/bootmem_info.h>
 #include <linux/memory_hotplug.h>
 
-void get_page_bootmem(unsigned long info,  struct page *page,
-		      unsigned long type)
+void get_page_bootmem(unsigned long info, struct page *page, unsigned long type)
 {
 	page->freelist = (void *)type;
 	SetPagePrivate(page);
-- 
2.11.0

