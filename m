Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573FA2C2244
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbgKXJ5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbgKXJ5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:57:47 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF32C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:46 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so18005653pfn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHH3/jV+QgVymFROaAhyfWbEGBmLguB5hGi6rHX+6Xk=;
        b=tIraSHcGfsyLsDtWBE3f6AbmDLC7hMtycXi3qi3o3exCsJUurK5k90ln0isM5Drjro
         DB3XS0aPqP3k6MAuAEVkri+xicJsmaoBVJ6XcZdWf8bJSsOSZ+4lKenrLm+w/1Hl8vqf
         tOk3a9jGCBOgRSLz+QSj9jE2Cn6cwR3NOsMBDXeJjikoBRbZqjJTCH/zd9viZZRoNDeN
         KbNVk81Mtl72BMRuaz22/mNFA91Rf2fvN2O6zk32JPUzAltYH9HoWnvWrsY96Hb5ULYA
         mHCgOqrC+bIuwKv1R0RntDu8DmcEb0G2EVW6bSQp02sUOQyIxIFHjEe++uDDOc5ZkbBd
         YtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHH3/jV+QgVymFROaAhyfWbEGBmLguB5hGi6rHX+6Xk=;
        b=c9FhN5rYHXnPkjG6YyyjllrC9DbAfDkvnsR2CDVp0guyKFBM46aEvlpFupdrc7OsDC
         /veOQdbEk6vc9wxrYZo9ekmv58INTHWUlmtP8PMA5NWYMMacqi4RlEk2BAfBTU62Bvwj
         LL8p+BjAnxg6b2k5X7Qxd82+4vtFWxEl06rD2UKUc061Ym+htnTWq8i8QYz3LRmHVSUX
         4RYGoQ6jNZuZUXDSjkY/OKu8mYV5cThlVBCC5j9W0CA8Yi/lCEysrRgWNV9UIaT/It3k
         gdLq5Sc+SEr647mdwby0QdRkB5Yd8MOfD0om5olCEJHp5X7YwZx4UrgCVDO2V0OC8g+j
         NV9A==
X-Gm-Message-State: AOAM533ET3bsafXYA+5EFCgaSPzfH/uKhZs3nt5snpPdudYi8CmtozhN
        mMRGRD0ykAtOrq456JzDa0m9Jg==
X-Google-Smtp-Source: ABdhPJysdofJSVH3w1/BPgZk3TLFnf6hemKsSPCvyi4+CmocLeKlIa0h4pckqN8WwHQ4tU+2hvxHEQ==
X-Received: by 2002:a62:2a81:0:b029:18c:310f:74fe with SMTP id q123-20020a622a810000b029018c310f74femr3356086pfq.50.1606211866326;
        Tue, 24 Nov 2020 01:57:46 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.57.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:57:45 -0800 (PST)
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
Subject: [PATCH v6 06/16] mm/hugetlb: Disable freeing vmemmap if struct page size is not power of two
Date:   Tue, 24 Nov 2020 17:52:49 +0800
Message-Id: <20201124095259.58755-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We only can free the tail vmemmap pages of HugeTLB to the buddy allocator
when the size of struct page is a power of two.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index fad760483e01..fd60cfdf3d40 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -111,6 +111,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	if (!is_power_of_2(sizeof(struct page))) {
+		pr_info("disable freeing vmemmap pages for %s\n", h->name);
+		return;
+	}
+
 	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page and the first tail page are not to be freed to buddy
-- 
2.11.0

