Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4772F9360
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Jan 2021 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbhAQPO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Jan 2021 10:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbhAQPOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:14:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44736C0613ED
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:13:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id b3so8687263pft.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Jan 2021 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ntojA21L7AWHHQRUBdhZHwBioWXg1bVrcDP2ArBhkkY=;
        b=Ea92toZH/1l0FNhx1nYmpPDeMydz/IKBkjQNccA4JqlaQPi/3Hu7gQ+VMm6zzsAlvz
         AEPxfJbUcsBRQ/K72F17e5DJy+XSBlPDcFg+yOHm9bZCaxpwuGmq7436uQ3VgxPB6b7F
         BcGJ7sVKe1WKZbF34ZFO80YezkJaRfz1IlIUL5QduSqo7EI5ifnDybPjYy6FMoMCs0TN
         DbWgBtJnx8ZU04vNOUTtdXotGgWbbzZRb5jIVaoukR8rnv6/p/9+pwVgJNNKulSFr1/a
         hcA8Lxw1XnfXxzP0tExT7KFk9sqmACYVhZRtBblbQ8fe0Qcczny3sVq4hnxCmxdSO3+/
         PP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ntojA21L7AWHHQRUBdhZHwBioWXg1bVrcDP2ArBhkkY=;
        b=cP84rPq4kmoxTDjU8OIt1aH5ZT8/ZlfOmGnacJgIVUlBT3YFE+CgXCRFDalY/ymRAY
         vKnOaI3+FU7sPc7p0y2K8z8+uICBe1dx8DLNf+7cNhSZ4wOIIeJx0T6I7NkqufrTAAtg
         wOE4Uy3o1rKBCfX0iyh5AxqyrorW9Fktr2Y/BDa/OwGcapEN3Ax6BMOJSogZ/LU2XxKf
         kjNlt6/0SAW1+CnFklCPZUVzdud5qB7jQE4jqe+GxMvJ2Z4iFqP0YVcis+RxesYn/ptn
         epFR4jkO5FBppTnl5IVN2zyX4ozNviDbIOh6KrlVOrsS3Yqf20hvJqLRomqUE/6qDjI2
         dsiw==
X-Gm-Message-State: AOAM5306m9na+Ap6cfbj/di7zZ8Go5PH4PdUaA4pTXKcIl7+CBOYayQS
        KVhX3F2vHdRVpbcsrj+pg9mgqw==
X-Google-Smtp-Source: ABdhPJylD4KONe3SPQrZ2L10bXdihiwZcjTG3YitmaxUO2lbiyLsg5iYrSq+a5GgBs8/6xFFDzNMFQ==
X-Received: by 2002:a63:a804:: with SMTP id o4mr6213615pgf.67.1610896404686;
        Sun, 17 Jan 2021 07:13:24 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id i22sm9247915pjv.35.2021.01.17.07.13.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:13:24 -0800 (PST)
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
Subject: [PATCH v13 02/12] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Sun, 17 Jan 2021 23:10:43 +0800
Message-Id: <20210117151053.24600-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210117151053.24600-1-songmuchun@bytedance.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
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

