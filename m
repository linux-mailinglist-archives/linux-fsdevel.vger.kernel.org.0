Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBDF299004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782207AbgJZOxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:53:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33875 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782200AbgJZOxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:53:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id t14so6215390pgg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KfeEXuNnvlERaIlJyKUi/sIz8pfmKf7YjRp+KoglCMM=;
        b=PoYZwLxm0eGrh750Xf3UFJKkqRg/tw0tTLFmyzPDyATTZaqBPwiDbOtC3aBwWX38A7
         MJ40cUfE9bIYgoWlSnOBrG35JYysPqwha5nBQqTVVrYoW5Huq1t1wfPcD9PpFL+GU72Q
         AO3dMefE1BLvsWt71kpjm1sVwN265V3m5EIZF56G4hM/JB3G8jvpN3evC1isb8dJ5ewS
         IqarUWD5uNBApstxsdPSwEGH3Bhe38ZEreIomEV/jvUlYxCCCskndNbhOpF0rZim2toK
         BrDILlDJmG+/RI01mk6oupzqRV1zeKYWpk/mmx9O0liEjpikY/U+K36B8G6wAzzxI4pU
         LHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KfeEXuNnvlERaIlJyKUi/sIz8pfmKf7YjRp+KoglCMM=;
        b=kVd1kQBX53w4at+/HmIbY+yi3ewk90PoH7t167+6Tal6pG/kdDCZdTsOPZnDptQpCn
         mAzcS7osvbQtBC0kIZFxBxphBR/Pa4ktQldz9GDJEkI9+8y/m6vyFLEN6ix1+D01kzAV
         CSBj3hhUsjSqI6TxkyvqnHBt4kExl462NCiQVnVS/n2gyQhP5+MHLFmHn80ZjbNXDKzm
         EnYEHT0akckIGrqCO4Vx0D+beg/mn+nzw65wU83e22GQgjyHZdIl9WIY9kPC+nUEwUC9
         YTuuQNpm+DwHqP1J9nAwdLWCSFJgWS5+UxxClzn8zy5hZoMoo9m/OSbkvagQR2jXUMju
         Wlow==
X-Gm-Message-State: AOAM5333e14FIpKWanVOHC7pFlmmC0na9hqLdnXYoqHs6B6cRD1aT9OK
        6L4px0gpuD09e4Ql8IprjntgVQ==
X-Google-Smtp-Source: ABdhPJwe3g7LIncHQS+u6E35m8bv3L935tezAMVtRdtCGhLL9PGPFLFu3zLVDt62DdNOARtmrevWvw==
X-Received: by 2002:a63:2406:: with SMTP id k6mr13748236pgk.366.1603724021253;
        Mon, 26 Oct 2020 07:53:41 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:53:40 -0700 (PDT)
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
Subject: [PATCH v2 03/19] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon, 26 Oct 2020 22:50:58 +0800
Message-Id: <20201026145114.59424-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
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
 2 files changed, 17 insertions(+), 1 deletion(-)

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
index 976e8b9033c4..5a4265ff2a86 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,22 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	bool "Free unused vmemmap associated with HugeTLB pages"
+	default n
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
 
-- 
2.20.1

