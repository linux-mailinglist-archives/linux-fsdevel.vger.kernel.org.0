Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9BE2BA2AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 07:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgKTGtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 01:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgKTGtj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:49:39 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5FC0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:49:37 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so6936861pfd.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 22:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SdvvqKnmPQDzzEKZQavt4aA9vX77aS/RCbk9rPPVeB4=;
        b=H2aA2xaoiWnwW6nf39Kv1EUsqrKNerzQbrslq/NI7IVdIRJqgVKSNb1QLSqFeexpQM
         s2W0bOQA2Z64MXFCeBPxIhsqOPs/fle/YtmNMi/7ymQt8cIMHdL2FqrPekNTKBVqwmXJ
         XFDSPuJ1TaON1L0Hee6XRFlcq2QRhwzojGlwxWgbZiM4xfDN1mM0UzgJia6txEDmnfl6
         ZUBSo75B0Qdjne4F2h4rdu0tuC79BS6n+m8abxUxiRMbbYPpGvcpqJKU6sE5stAVk5wM
         wt29LVkQUPffCEZn/FBagi1xtxYlpnhHFdv4TlqFdBDgiAJFAmz4i2qEBSI/2RAq/K6V
         ezpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SdvvqKnmPQDzzEKZQavt4aA9vX77aS/RCbk9rPPVeB4=;
        b=BirGkFGJiN1jGkYnu4pP+ElqcR73u9Yvci3slH9U7MkiabqnrSAjYt1d5oyFu6GpU7
         Tj3aeVtakpWXtyhC5JKDOHGCekEqemNtTxkBrd92puj+N0+UkpTa3+vzSu7KoIJFM8z8
         3fqRPIaoYU6Upy4eLH+GfU8d6KL01FpNvZLULL2ijNp0nmFAGlOS2i5edm5Ytg3eY7HD
         0ILIM1Kj4mku3GQ2rd2pB+w8Kbve5Fudsf/qYyqqwXUVt/9E3jWjxuEnZ9yt1j0IwdpS
         PWr1gWB/HXIdHQezq8NIlc4G+qwmFFWAZoeh8ZNeWScRljKPz0FxdU9/yYXo2Vl5VWyK
         EoZw==
X-Gm-Message-State: AOAM532guCOTqnhRM2L/mwNhHqjg7kyI3YuGrMxLVPT7s5VuUV6dN0W3
        ME6+OsibDj+fKd2x7Id/1GOiJw==
X-Google-Smtp-Source: ABdhPJzHqJGyY5pbu9G4vQoTS2YSYmL0vWhnJb+/ViUAprblRJ1z84SdXKgyNJ2fDva3na3APIqFKg==
X-Received: by 2002:a63:1445:: with SMTP id 5mr15580297pgu.357.1605854977294;
        Thu, 19 Nov 2020 22:49:37 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id 23sm2220278pfx.210.2020.11.19.22.49.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 22:49:36 -0800 (PST)
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
Subject: [PATCH v5 21/21] mm/hugetlb: Disable freeing vmemmap if struct page size is not power of two
Date:   Fri, 20 Nov 2020 14:43:25 +0800
Message-Id: <20201120064325.34492-22-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We only can free the unused vmemmap to the buddy system when the
size of struct page is a power of two.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index c3b3fc041903..7bb749a3eea2 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -671,7 +671,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
-	if (hugetlb_free_vmemmap_disabled) {
+	if (hugetlb_free_vmemmap_disabled ||
+	    !is_power_of_2(sizeof(struct page))) {
 		pr_info("disable free vmemmap pages for %s\n", h->name);
 		return;
 	}
-- 
2.11.0

