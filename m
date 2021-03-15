Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7981433AEB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbhCOJ07 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhCOJ0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:26:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AEBC061763
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:26:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so1663200pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Mar 2021 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9nTlzKqZFlWsUkZKn9oi/q21qUxZ65s/6xhXufEmb7c=;
        b=hWchwabdiuGTEDXT0RnHQWVCfKgdpTINIQpgIKJMmpUxPnLs5KZZWlLhwMQs66cy8L
         LaR47BUkauAlgULv7eOKGQzVhsCy0zcTAkS8egki6tUcz2QXlkB4iCbgPXQuHLxjqEKI
         HRf6kSRTnRdWGuli1mtWCGlDQE3BK2OdB/1yi0ovyl057cJSy0SSxf+POp8oqK7KHPTE
         CpsW46i7z1ECXMeDlmI27PGQ0uWMwKTdFMI1HRepf3DcEUZU2RAy24fKY7gFPyJMpSbM
         DzU/4uNtkANw5b7ry04Qg+pG5kOh++XJLJUuEc62zug6EAUGSwevWKoCN4VO+cv9tGRb
         IHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9nTlzKqZFlWsUkZKn9oi/q21qUxZ65s/6xhXufEmb7c=;
        b=djUUUyRPmiJ4yNYqf4FPli6E72NaTyKEqRyo729Fz2IlfctC9RWQTzpq9sNE2z857F
         8d8waxgrZz8gyTLKwbiQjW6Dnd3eNGxxkz2Iknp7BB4O1JJ+3M0DS7njli4VaCmAK5u8
         vbmZ1VSRL/jQSA/yip8kYf/s29ABbcz0uoTDbhXt5ZJq3NZXb23NA6QBQiWpdJmADO+s
         MIAacS2Pl4ILKocPhVXWaUz/aADeieUm7WLzRrwRjGh8Nh+lnn33CtE4S1SumGqDmzUh
         TLYOC0DCFydb2H5+OHbnPTnto0KwWxa5EE0tYILmFbDDlB0pYNd7+dqozQO0a7POvpOL
         YvRg==
X-Gm-Message-State: AOAM531tHCcxil3fnMreasfG6Ev2ceMsEo4R+ClfURmcy6AYvDP735Eu
        tvJFKZEsPeLkEVQXYsaTbplSFA==
X-Google-Smtp-Source: ABdhPJwXeYdwuYouTL7HqzYPkbaPF1vJwuTSZ8pT828C8BJTHKy/RHocXTIASW6rfNXVbC0YSqFHIA==
X-Received: by 2002:a17:90b:fd2:: with SMTP id gd18mr11805276pjb.115.1615800389353;
        Mon, 15 Mar 2021 02:26:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id gm10sm10607883pjb.4.2021.03.15.02.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:26:29 -0700 (PDT)
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
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>,
        Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v19 2/8] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon, 15 Mar 2021 17:20:09 +0800
Message-Id: <20210315092015.35396-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210315092015.35396-1-songmuchun@bytedance.com>
References: <20210315092015.35396-1-songmuchun@bytedance.com>
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

If config HAVE_BOOTMEM_INFO_NODE is enabled, the freeing vmemmap
page code denpend on it to free vmemmap pages. Otherwise, just
use free_reserved_page() to free vmemmmap pages. The routine
register_page_bootmem_info() is used to register bootmem info.
Therefore, make sure register_page_bootmem_info is enabled if
HUGETLB_PAGE_FREE_VMEMMAP is defined.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/x86/mm/init_64.c | 2 +-
 fs/Kconfig            | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index eccbcf1e3f2e..46fef1f721c0 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -237,6 +237,11 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	def_bool HUGETLB_PAGE
+	depends on X86_64
+	depends on SPARSEMEM_VMEMMAP
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.11.0

