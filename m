Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23C2330B28
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 11:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhCHKbG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 05:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhCHKap (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:30:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E42EC061760
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 02:30:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id kx1so2766496pjb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 02:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pi8muCvZVllAVCnyVEL0G4NWBwvpjkgAMqOjInVB5Rs=;
        b=m1DYIpUIdXYvOmeam2IaF1ERCJFhbpXPO7mFrO5AX+Qx6zGA/6W9GLTKH9yQAKqOqZ
         f7SQBMW4ko5ozaKJ7E47yNLdRhQhASjXntciReMid+QnzJ9JwaN0CxUYqS4dJibN5HOw
         k8TuYMLzOIgDB289mG7wSoADafEUmPPDeM+bq/REwrUV4BznVbKMAJ5EnlDu4ejKAsN9
         joGV3VC2YR67izYXzEH1KWIb1Npn1+Ju9OD6kNWfstyX+HnTrfcLvTTgs37j++CXyHZk
         ZANspXfya0XiI2ip274nslHwgfDmtAd/tcecX86RR6B6FMN30pgHOG62RhGOczlZk58E
         LWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pi8muCvZVllAVCnyVEL0G4NWBwvpjkgAMqOjInVB5Rs=;
        b=P5sXediNbgt8+prkrbUpsBC7MqIgAodJHucw4egSSnuERhvXmcMuFlLcF6+0QXPU/t
         v1KeDRza/fz0OE/KrTAO792yNbauFAoZT+Ow2K+aORsireAB6HiPkVaxLAHTVapdtKf3
         eUvxYAb0JK4ODp+bRw71hS89L6hLbBpzSZtTikCfmtCW6/AUQGkG4jOFE1OYTUBul7hm
         Z20dov5xHliRkCvrP9cNTyobf4GHir/cPBRvyW6JOcY89gncbq99/d8NkvLlYXHc6lnN
         uYbB//5+hsl3gY+Drg93dFW7gfLd9G516Qw13hdjXAQACLTJOjGnFXxYvQ45QPoLVnOP
         en9Q==
X-Gm-Message-State: AOAM531Lw7+Mz8O33u3Kxk0TECUvQIVR39pkzoaBAYs2Ft0var27h1zf
        KmhkTnFuewAplIuI0bSCnB1vxg==
X-Google-Smtp-Source: ABdhPJxj5tSQfanstZ9wIIAYIVMr4T8+owGM68HM35oumBr8VyX3BhDSWk8EQQyLKDEHuMMBnQco+A==
X-Received: by 2002:a17:90a:8901:: with SMTP id u1mr23617449pjn.21.1615199445087;
        Mon, 08 Mar 2021 02:30:45 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id ge16sm10744705pjb.43.2021.03.08.02.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:30:44 -0800 (PST)
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
Subject: [PATCH v18 2/9] mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Mon,  8 Mar 2021 18:28:00 +0800
Message-Id: <20210308102807.59745-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210308102807.59745-1-songmuchun@bytedance.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
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
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
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

