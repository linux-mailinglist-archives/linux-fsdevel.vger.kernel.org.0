Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6F12C2237
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 10:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgKXJ5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKXJ5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:57:16 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69760C061A4D
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:15 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so10430710plr.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s5A1WGxjr1FnragMjsAXSXENwZtbX/VCL9QpT/2OWj4=;
        b=Teew9GvubUfF7KXPZ0vrHLrrdljg0Jw0SHTS0miGJ+H6HSyJHNWx1gygUfRYCkCrw+
         EFlGXQHbhIpnw8VIJKvVn4N3/oQ/DX9sOoWurp6agSO9mb8j7HwAT5HTBnBH1IQVvsna
         fDeuYUqOhNQomskdJzjwkVHcasMWrx3FEUjTx3ntf1w2c+IiqrHinlQ3zoo6pFATvJ1G
         K45S4R7n1zZbkYNmNDSvo2Lc5p4+HIJ5CL1tSne7ARclcUu/D609C3ImDl6jiPGuS9ZX
         gXvkFgnL1TrHD1X2zyk+ZphWPFsdUlyNF1qz7TBA6lPcHVBeCqRT5PHJO4KwXbDrDI+v
         9u0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5A1WGxjr1FnragMjsAXSXENwZtbX/VCL9QpT/2OWj4=;
        b=j+SViZZ9+KGbS0b6vPn8e056amJdh4lhoY8jVVT1aNwaXwfto+HDvN1edVbVIfy7Xu
         uMNngfQAkCMfT5ZAiBrG1TOiXVz1FY9brVGQe2mKXhtRU0kvziQXI2Gwyp6hAZ5V27MN
         ZOys390ZHauvPt15aWtxPKDsb2cWvR+/DyGPYt6Gg4Sq7sdMISJTdKV/hMyHM6POE03u
         UU0/6hyEIV4K+NxtDY5Y8d9Y0+En9I7sf6IlC/GDtw9AW/RUV1iiFvrD6mDaovA2SIFK
         t335neZUJe+1m79f+nBQqG+i8dMpegN1LO8DkG0zgBDAYIj4W+akzmYgaef2fNWDxPfS
         hqZw==
X-Gm-Message-State: AOAM531wJbyshS/EC6OrckTM1fpqA4bmzVRcwvpdhKrz4uoPqD0bNyw3
        aa0OqS/0kvJ6dqKhqbGp5djd3w==
X-Google-Smtp-Source: ABdhPJzwWHwqGMfwuSes+ofTOYpFZkuqkNbGuqv07A6D+lBpddBbGPWVNDBt6EKW68EcbG3uetJiWA==
X-Received: by 2002:a17:902:b192:b029:d7:ca4a:4ec1 with SMTP id s18-20020a170902b192b02900d7ca4a4ec1mr3406894plr.76.1606211834998;
        Tue, 24 Nov 2020 01:57:14 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.57.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:57:14 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 03/16] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Tue, 24 Nov 2020 17:52:46 +0800
Message-Id: <20201124095259.58755-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated
with HugeTLB pages. And this is just for dependency check. Now only
support x86.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index 976e8b9033c4..4961dd488444 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,20 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  When using HUGETLB_PAGE_FREE_VMEMMAP, the system can save up some
+	  memory from pre-allocated HugeTLB pages when they are not used.
+	  6 pages per 2MB HugeTLB page and 4094 per 1GB HugeTLB page.
+
+	  When the pages are going to be used or freed up, the vmemmap array
+	  representing that range needs to be remapped again and the pages
+	  we discarded earlier need to be rellocated again.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

