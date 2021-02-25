Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17287325062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhBYNZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbhBYNY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:24:56 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F771C06178C
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:23:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id t26so3783470pgv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRxLQEtAZMF7ynint68drnOS3AOgo+lUwQuMfO8HfyU=;
        b=bGWvFZrSNsgfHLr0ndyhmQ/W8MpRAjEhFK16bykd8rK0MPQMSNokOfsjdCXRosek+b
         BgQhCIjQRXjEL0D96Sl+/WL9GKQ+xSLO4g2eSz6Ps4Ox7p1wtAbpaQZNpLa6cTyIcx/A
         cF2IdS7GUwez0O2ziSwCFvuQuGj60r98Cinnj5FOTo0MKT2jG/k8/Sz4GjkZE58Oo/zk
         H5bJ8FtASUuYskjULgTa0DrjEq+mfIXLy3XPUlJbGNp/xcGqtDHTS/q5RMrO0Cgo/2ki
         ezGlWDRrD0HqmyBHu8YE8OLGrpbYfdQMXzW2f3CjtpS6RdcFmUvhKjGVpEw3yFkcoW9v
         Ow0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRxLQEtAZMF7ynint68drnOS3AOgo+lUwQuMfO8HfyU=;
        b=NlNvixRj/AeGXoiVD7L0UraK2vYczXJI4D6b6A/mBWgOSxXKcyfjVz+l7wB3mEJiDE
         aFhz9j3nf6LjHU9d2CfN3zBLXX5+T3L2Mv72CECKiyzrICEzEX6T6dGhX924cZc/1BTS
         ZlBwo6EJOfpoowxHZJKVGUggMZFZ5FNs3TFuzMUYd2sQS5cXE6xQHMf8ljz3xSZf8W7I
         wLZzWiyrNnntj2VqVGx4U6urUtqPOLjwe2N2z/OmaAeBWRP0DqfA3hRumX0aAoC4a44z
         R2SURzZ6NvM5w7ClqrssLxcG0kpr2zZ44tf0BCO0QHH0YUzxfWh1OWE6XV266ouy+qhK
         ZfLA==
X-Gm-Message-State: AOAM533J+1ZdRdjuTLxrgKNIpUbouVaw21BdmvRrX3/65Cj5I6wDt6TY
        f7bFd8J4TWb0AUxS/V15RtWXsw==
X-Google-Smtp-Source: ABdhPJwFfKYHCSSTYgjRwYWqzJHWCMHhEBoS+v9+A+Fh/MnSpP9c6ac19THyCKs92XLKFiiS1L2msg==
X-Received: by 2002:aa7:973c:0:b029:1ee:193b:6092 with SMTP id k28-20020aa7973c0000b02901ee193b6092mr2682444pfg.59.1614259436992;
        Thu, 25 Feb 2021 05:23:56 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id x190sm6424676pfx.166.2021.02.25.05.23.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:23:56 -0800 (PST)
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
Subject: [PATCH v17 2/9] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Thu, 25 Feb 2021 21:21:23 +0800
Message-Id: <20210225132130.26451-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
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
index eccbcf1e3f2e..b5dcc68aab25 100644
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

