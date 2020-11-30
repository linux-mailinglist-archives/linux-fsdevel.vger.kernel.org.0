Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86182C87A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgK3PUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgK3PUu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:20:50 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1008EC0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:19:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so10626343pfn.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s5A1WGxjr1FnragMjsAXSXENwZtbX/VCL9QpT/2OWj4=;
        b=2RhaWzxGXNZnya4RQPVLYlTnC7p3ZJDfJBjoHJOKw1nuorEtEwtoefBftJvHjLcflk
         kPYdC5SwmiucMjvq4oiRjhYikOhX9BF1E3oNIf4x4Bv7w5n1dCgtIQvu/hrOYoDK7RMT
         pa0Klx+p9AdLAk69s5ykJFlLNGtySFPARC3mdi2/ty3Y0cpML7NB7/97SK6lXtcLBPM+
         VALfqV8XVPl9DbXTj7k3Cr8vvTU/pmX9IEiwDsSU76BJllQQ5cJEtCdAKtYzWYuDDq93
         PW44EpYKpW9tEG2fQqZPNlefbJ0r/rX48FObKp8vOJOw+QM8Suyx4kejZtq54Lzl8KGU
         awLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s5A1WGxjr1FnragMjsAXSXENwZtbX/VCL9QpT/2OWj4=;
        b=a28SEJ8UH6gBU3v195EaY5nSAeCY5s407rKovTJnEiLvGvULsk3hF3ombRbfDJiVip
         UP++9XokK1F7Cq+Ct2wSdRnCIFm6/abwgA7qp5TE/QDEuLW19dayAnO1KjgEmhAKi8k+
         vyMJPuWeftKmYMpn7kfs2ZjJ1+UlpumYnjDONoi1FSidifDXNV8OddD5olPO5ZsMvJtT
         9V012vyLxuwu6EdhGvz1sqU1In+KvOCGAgazNN2ShQInDEsA26jkW8xGdlbmgrJb/3CL
         iQnZTSSI/13BZqXZPiSDEaPrsOmmMN8klahXlQuvO59bYSraMozAxj8AoV1IXSss8gs8
         n6NQ==
X-Gm-Message-State: AOAM532IMzZT+gyBb+kYsLdx+2/6zKFsqGpjXaMGIEm6SJeiYXyhJ8ic
        fhebFdjSZgzpy9bkit4wOmvcDA==
X-Google-Smtp-Source: ABdhPJx9gSDS4GWuDavFvp1c4l+QTjvwTBoXyiVDOJlXic9chR+sTx650tLab9Bjlxv0+Rv8nxRWQg==
X-Received: by 2002:a62:ce4c:0:b029:198:1f1:8743 with SMTP id y73-20020a62ce4c0000b029019801f18743mr19245889pfg.79.1606749592623;
        Mon, 30 Nov 2020 07:19:52 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.19.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:19:52 -0800 (PST)
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
Subject: [PATCH v7 03/15] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon, 30 Nov 2020 23:18:26 +0800
Message-Id: <20201130151838.11208-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
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

