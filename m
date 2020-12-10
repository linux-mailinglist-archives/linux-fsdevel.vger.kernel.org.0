Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4122D528C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 05:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbgLJD6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 22:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731982AbgLJD6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:58:46 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A2C06138C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:57:43 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t37so2954808pga.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qsAVJu/9vqouKcThrGhG8OM4QgmEtPOs8IzBVJC9Eg=;
        b=ua/Fz9eUeVlu2LpIMKy0UOp+uHaI0sfBs3FQrHbm0HvPvH4eWkRaeLlEEU92efDxsO
         4mxJ6tCq22SubFJ7d1ufXsth5IMIAV+SCBJ8kcRaqL2SzFr+x5xOSXJZr6rRr3OzelgG
         wQ3c+xQn9VbbdkGGnBdcQU/ookizH62Nbm4/R2dawbEcdGmcCleAvVfzjUzt5wQPUqDY
         BPQxFRo+2I4EikkbTZxG0BHAnR2NCyE6Uea97IloorcM08f35h5e4w1q9mTbjYxpCZka
         w5sHfFoCWXM6oDqWxA0R6XT7LZekiJs/l1rOEnnALJzemecI9TY0ifD7nQ1cUPCbOJA4
         43XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qsAVJu/9vqouKcThrGhG8OM4QgmEtPOs8IzBVJC9Eg=;
        b=rOJ7cXLaVbaPPKczdSwwLfVaR0Y/TUe0dRhx/RGNruOcLMNjNjnumDn0WOWTTHvPw6
         9CmKdPpEMD+vWJqqFLQvem/IVljJ0PfnlcDbSSqQLqnrvFSxuWjlI/Wj+aVO//87h3HC
         pUYmZrhytoscpSvmShO0Ebajt+qj/ehMEG2Mym5CqB9AabEqmHbHl8WjpD8YTvMDvtQM
         d97rHnKxD6P9vG3hcdnYyU/UhNho1K3ztjgkKBWzQV/k6gCG80aJfzezPqAHJn4rHu4f
         V+9Atc2pVzIK3/LTg01AxdLlg0PdcTlDKxjGYqEZh3o2mbZ706unJM2tpT66/RUmpfrx
         qN7w==
X-Gm-Message-State: AOAM532RP8EzV+/YbN1TQmN67MP68kfp4sIpkdEaunYbG+M6OiUmgmSw
        qsHluVrPcY5pWlaJhvfCVZxiJQ==
X-Google-Smtp-Source: ABdhPJx/Ck6c2ehZvQUGVZALGx1Bsbfx7bY1n+3IGy+I8VAHFhkKSZcDPMjin5LESQmUuueirc4iAg==
X-Received: by 2002:a62:27c1:0:b029:196:59dc:8e6 with SMTP id n184-20020a6227c10000b029019659dc08e6mr4932935pfn.72.1607572663461;
        Wed, 09 Dec 2020 19:57:43 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.57.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:57:42 -0800 (PST)
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
Subject: [PATCH v8 02/12] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Thu, 10 Dec 2020 11:55:16 +0800
Message-Id: <20201210035526.38938-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated with
HugeTLB pages. And this is just for dependency check. Now only support
x86-64.

Because this config depends on HAVE_BOOTMEM_INFO_NODE. And the function
of the register_page_bootmem_info() is aimed to register bootmem info.
So we should register bootmem info when this config is enabled.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index 976e8b9033c4..4c3a9c614983 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,21 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
+	  memory from pre-allocated HugeTLB pages when they are not used.
+	  6 pages per HugeTLB page of the pmd level mapping and (PAGE_SIZE - 2)
+	  pages per HugeTLB page of the pud level mapping.
+
+	  When the pages are going to be used or freed up, the vmemmap array
+	  representing that range needs to be remapped again and the pages
+	  we discarded earlier need to be rellocated again.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

