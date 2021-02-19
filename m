Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962D331F7AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 11:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhBSKxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 05:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhBSKxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:53:24 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABBCC06178C
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 02:52:20 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b21so3758924pgk.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Feb 2021 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z4/inaUQyi6A7ziFBiSuphvc4zlbtBFhhYbLAw/G34=;
        b=dTHGW2GrZQlpZCCgS5ZGbbONBlwQ67ce+8mCMu/g5KK3ueEVcctzYjxaprsXTtbPGJ
         Yq9NXwoiKFoDETUkpr+m96ZD2lg7P1WqXsUavgtl2ohvjVdJ9cfbsGBovwDhldFU91Cf
         +1OUoo4ftVwOJpwt0oWmAc6yldLkuY2HEdz5TGqzKWHCSk3LKNruRlqm4EIdkzbc6xEP
         9GZt9M9HlBL16qyEF49t82HbU+nV60t7h5e26EDBC5VhON1kDSQEXXizdaQB154IOWDN
         piK3eDp6mKC45Z0WnuMNi/vpyTQC7h4JIzSMJvoDIA0InFn+88jIfH/kI11xEyB76OnD
         nc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z4/inaUQyi6A7ziFBiSuphvc4zlbtBFhhYbLAw/G34=;
        b=sN2g+JosY6zbxDnfHS1YUtViBEgfu5A02dWg+NvKGQtj1ZlADqSNCI+s30PmNW8/FE
         B6o8sXZEEvA4e20s7CLAFhiqo/1RqEOURtDzEFvWBGfbMkLWtWz76NRVWfdaH7+V8fPW
         yarZjOVmx96BmbzRkd4c9cXGzRIgJfyG4/i56blsxG1iAivoSKw+CvkfGbZpGbRxZg5B
         9IPKTnN1ZIiVOGo5wicIAE1lguNnk7E2Zg8i0qOLHSZHlU28VVHgyb+H1/3m+66w+gtg
         5vWYquNiTmY8AyN409SCZYOfkKbip0i/jH56S6fcDdtGhSoRIxB4ClrAdsmPX88DFdec
         h5qQ==
X-Gm-Message-State: AOAM533F0565Dw2dUvSC1gPsflakxevIjvm+Lz3F4ThAE9Gsw1XUjxc6
        iBiYuEXRAnXlUPbUZNEZS56MMw==
X-Google-Smtp-Source: ABdhPJwOmS9HqudSELeMjO7sH1YZWGFBDRQ+Usrfu04u4QL8cAeQ4UBBNVPlDp0EZzgLb+Zm8DkQIQ==
X-Received: by 2002:a62:8fd4:0:b029:1de:d484:e1f7 with SMTP id n203-20020a628fd40000b02901ded484e1f7mr8781404pfd.78.1613731940261;
        Fri, 19 Feb 2021 02:52:20 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id x1sm9662193pgj.37.2021.02.19.02.52.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Feb 2021 02:52:19 -0800 (PST)
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
Subject: [PATCH v16 2/9] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Fri, 19 Feb 2021 18:49:47 +0800
Message-Id: <20210219104954.67390-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210219104954.67390-1-songmuchun@bytedance.com>
References: <20210219104954.67390-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
some vmemmap pages associated with pre-allocated HugeTLB pages.
For example, on X86_64 6 vmemmap pages of size 4KB each can be
saved for each 2MB HugeTLB page. 4094 vmemmap pages of size 4KB
each can be saved for each 1GB HugeTLB page.

When a HugeTLB page is allocated or freed, the vmemmap array
representing the range associated with the page will need to be
remapped. When a page is allocated, vmemmap pages are freed
after remapping. When a page is freed, previously discarded
vmemmap pages must be allocated before remapping.

The config option is introduced early so that supporting code
can be written to depend on the option. The initial version of
the code only provides support for x86-64.

Like other code which frees vmemmap, this config option depends on
HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
used to register bootmem info. Therefore, make sure
register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
is defined.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/mm/init_64.c | 2 +-
 fs/Kconfig            | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index 97e7b77c9309..de87f234f1e9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -237,6 +237,12 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

