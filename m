Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828D312C86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhBHIz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 03:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhBHIxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:53:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14269C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 00:52:21 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 189so257081pfy.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 00:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/z4/inaUQyi6A7ziFBiSuphvc4zlbtBFhhYbLAw/G34=;
        b=JUZ4MFsdXR4hp+BnnV2hi08VuIcdttJcd2cotNmYKQrT7TAG4RkefVd88CspsB3P9R
         zldr02H9XiwWjb1lPWuO/7Py20dVcmwOt1otZKIxB4NSlJ3Evef7aXNUQJUCb14U8btD
         erfyH7/Mu8CWDYm2pMi4vynL20XecWeJEoGOLQpdADOdBhtimJWYauQowkW29tkyCmME
         YuSXX8myWvUeBBDE7Zh5Bi9sCWYa28mZknE45EWmlwMXt2zoWruExJrIT/3eNWLn+WiM
         PPR8+ytSROYBaioUoaPB2nsRVUnrrZc8St9u+lbczcXt/XOE2MlE7d2Va6dLBsV6KWYv
         Uttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/z4/inaUQyi6A7ziFBiSuphvc4zlbtBFhhYbLAw/G34=;
        b=jBVh+GdNJpO8Lcv1wQkQYUmVjHyS7I8fBk/FRqbmC93khfF3xkb5hrleMfj69BwR9d
         lEkEN9RZOM36AUAEzx7PiTFikTQ26kWyI66lrOeBlXVnyYeINzM1gFmUwQvco2ievkLn
         PPwUXDj07O6NqR1zD60XXxz429Lilx39H32vsY5y9swExb672Mzljbmv3K9Ukddn1gUF
         WXOxNIxnjkffhrXkGsJzrEhhwsTqjEXCGJLcScx3hskO24RvJeqlqrtzkXDlXozCz0c5
         i+llsm+TR+s+75BHjm95eZmEI0AjlAw1Uke05LyYQldwiIatg6n9xY0GnzN0gLA/Pdkw
         0biQ==
X-Gm-Message-State: AOAM533f8INSHkKA8TLWMQiT15Q9pof28RMccnEoXVyTZ1J3RPlag+ir
        O9c6WNza8jbpuEnYKhvhwZUN1w==
X-Google-Smtp-Source: ABdhPJyIBc3e1Ab4xPqcnD0UvQ16vZjx4Sk7aRqUuMiWvLTpD06jfwOwndhVTsG0YDjiBQsI4X/EpA==
X-Received: by 2002:a63:cb4c:: with SMTP id m12mr15899771pgi.51.1612774340664;
        Mon, 08 Feb 2021 00:52:20 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id g15sm17205179pfb.30.2021.02.08.00.52.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 00:52:20 -0800 (PST)
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
Subject: [PATCH v15 2/8] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon,  8 Feb 2021 16:50:07 +0800
Message-Id: <20210208085013.89436-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210208085013.89436-1-songmuchun@bytedance.com>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
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

