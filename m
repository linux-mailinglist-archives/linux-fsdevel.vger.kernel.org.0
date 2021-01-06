Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EF22EBF61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jan 2021 15:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAFOVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 09:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbhAFOVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:21:22 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498E1C06135C
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 06:20:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n10so2296596pgl.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 06:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntojA21L7AWHHQRUBdhZHwBioWXg1bVrcDP2ArBhkkY=;
        b=KTNjoDoStOwAQ2Kk2ysIuwkG5LgYw/EAbJjgcFZXhRnbl/Hb8w9eHsrJawwmBRwZK3
         iSV0oIbsXlZYWxDRQIEBK/O29n/izo27tI3Zpj3AISGQtStJ0hgNIt3wApVxJXuvj0t7
         geelHt+3pJN6NUrRduI6+hFFq/devdbEDVzzUb8FSUEZlMfIkMy2KlQIGfLyIDfhK3zu
         hwimDW7wP1A2Ip0goHBTur2FCpXliCotlcJ6N/6j86p0YJBDce76+CjG8PM6aEn2gXVK
         Of3AAingK9HEFJV/ZQfHQg/m/phzzUz5IiMaMMAYWeogpoImUFznRu7EhbmQoOpfoopG
         LT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntojA21L7AWHHQRUBdhZHwBioWXg1bVrcDP2ArBhkkY=;
        b=cpQ3SdahrnLXjPaMBkAClwp55CnRAzELO1zjvt/aGrDjuVCrhDlpYoXZq/arSbMUi1
         s2jltJ1AsHb4gUq3Hw9v3FpuoSHnrr/GV1IGutejwoEU5b+6ZoG/Qvdd4+1bRyJLpW20
         QZ29wbBnCSbMFfJdRbZI+yyA3lJgQG4su6HbAWl4/A8V8XhSVBYgbylmGZzuUGNQ15VE
         6MZOmEd1lMHvw+FPKeKUnp+S9GFhnu/sMrUxSBz+BQOmKNDvd91zljA2X/P25evCNEn2
         8vWseleOnfkSHSYAzuKDn5aBoy/GkcwuFW3CFLiOcYWqT90fXCtRzgmHPx78Bi+orhAE
         e9xw==
X-Gm-Message-State: AOAM531Ccg/D2flCxj1GE8o7P/AoR84ZOyopRsJDOFtwvH8ZSBupKC+O
        ftOpG5dgTnDGxjZP9i6q9096aQ==
X-Google-Smtp-Source: ABdhPJw+LaSh1QWtnOoIu/erTP+GfsiFOFcLjLGQOEay8Ox9UEwpT0/LQiOo/wzq64rU794UCP4a9g==
X-Received: by 2002:a63:e24f:: with SMTP id y15mr4708316pgj.366.1609942822914;
        Wed, 06 Jan 2021 06:20:22 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id a29sm2831730pfr.73.2021.01.06.06.20.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 06:20:22 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 02/13] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Wed,  6 Jan 2021 22:19:20 +0800
Message-Id: <20210106141931.73931-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106141931.73931-1-songmuchun@bytedance.com>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The HUGETLB_PAGE_FREE_VMEMMAP option is used to enable the freeing
of unnecessary vmemmap associated with HugeTLB pages. The config
option is introduced early so that supporting code can be written
to depend on the option. The initial version of the code only
provides support for x86-64.

Like other code which frees vmemmap, this config option depends on
HAVE_BOOTMEM_INFO_NODE. The routine register_page_bootmem_info() is
used to register bootmem info. Therefore, make sure
register_page_bootmem_info is enabled if HUGETLB_PAGE_FREE_VMEMMAP
is defined.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/x86/mm/init_64.c |  2 +-
 fs/Kconfig            | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

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
index 976e8b9033c4..e7c4c2a79311 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,24 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  The option HUGETLB_PAGE_FREE_VMEMMAP allows for the freeing of
+	  some vmemmap pages associated with pre-allocated HugeTLB pages.
+	  For example, on X86_64 6 vmemmap pages of size 4KB each can be
+	  saved for each 2MB HugeTLB page.  4094 vmemmap pages of size 4KB
+	  each can be saved for each 1GB HugeTLB page.
+
+	  When a HugeTLB page is allocated or freed, the vmemmap array
+	  representing the range associated with the page will need to be
+	  remapped.  When a page is allocated, vmemmap pages are freed
+	  after remapping.  When a page is freed, previously discarded
+	  vmemmap pages must be allocated before remapping.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

