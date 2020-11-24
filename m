Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC72C2268
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgKXJ7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731797AbgKXJ7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:59:31 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C825BC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:59:30 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b63so17972593pfg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bynt/1YGSIdeJG2cOcgImXpzmEpwnUEaY6/7f6Ae/g4=;
        b=fU4syUhxdPJXkfQh34bMos1Y3zr1DCPrRNdijHklOltKrH8VvpAXtOADs20QwQcEjW
         A2lK/GIaljVc1gKpKY+vWKXPR9OX02jV7LL2OxqKTKdW4TMY9bWP+fnxOuc6z68yESqq
         gPQsJIyUY3JrkeRY5zHkeN2Y8rM6TmLsRERR3l+Scp4P6MJ+uxijHnXpyVuclcExnT3i
         gzDQQIfKE2CNH1P5PIdE0F04T9wEPhqMpEHIzsrjT1bfyLdmVV1Yc+Rcj7e9TKtK/A6B
         43CvqdjuVYMGBrGRpCljlvKSDsJaaJr0BCU5Ev8i5DzEfhLX4j3RvZAfincG31o5Ls53
         GL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bynt/1YGSIdeJG2cOcgImXpzmEpwnUEaY6/7f6Ae/g4=;
        b=Elm5AzPblJ1U+7d1JduojKF1Al0sl4SyC7IrC35nh8zmmSJNaNY51fHmjaimB1ajwj
         h7tSxVSAhdvqavWFRNjnKviyhBXFpNXOYyZT6l2hkosKCMvO+gbLOEuA7afrrPwRxj2O
         CuXcSv1GlgNgSWy0TOYnraxzPDu2TElyiipuLRF/3wXrMHr2pp4tYv9YjNr+fQJ4XIWW
         QZCtBJyPspSnVYNWhsExQhHTLSfc1iCm48Lp0nmh0z64N4NuHsfo+C37K8BAb19wGKRp
         rMltYTDGOIi0Xc3iKkGD7nAo9OOoyikdZDVzUcOAb9LlrLJgAbCJoB9qQ6OdoknrjLgm
         nP0g==
X-Gm-Message-State: AOAM53331boUsRG87cavbi9bCXagi9iPTHI0dHJKczRvnIlmpI+8MVJw
        Iqo9H0FqGiFKEchKUM9JCUsUzQ==
X-Google-Smtp-Source: ABdhPJy1pVteQcfd7t6pUTOEaOSYXhdcK1qTpL/2aKqFlzz5VS2SYxybBYu983LImuXmPOsDkOMJAQ==
X-Received: by 2002:a63:f857:: with SMTP id v23mr3071328pgj.174.1606211970431;
        Tue, 24 Nov 2020 01:59:30 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.59.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:59:29 -0800 (PST)
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
Subject: [PATCH v6 16/16] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Tue, 24 Nov 2020 17:52:59 +0800
Message-Id: <20201124095259.58755-17-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are only `RESERVE_VMEMMAP_SIZE / sizeof(struct page)` struct pages
can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so add a BUILD_BUG_ON
to catch this invalid usage of tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b2222f8d1245..d2c013582110 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -338,6 +338,9 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int order = huge_page_order(h);
 	unsigned int vmemmap_pages;
 
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!is_power_of_2(sizeof(struct page)) ||
 	    !hugetlb_free_vmemmap_enabled) {
 		pr_info("disable freeing vmemmap pages for %s\n", h->name);
-- 
2.11.0

