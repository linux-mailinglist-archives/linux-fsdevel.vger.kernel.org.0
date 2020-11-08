Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0C2AAB85
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgKHOOQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgKHOOP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:14:15 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB7C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:14:15 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so3249259pls.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ENR30W+EQorPFupcfRUDbx6GljgYrLpkJikIXFtJu0Q=;
        b=NCpYibike1Vkd5HinU4cnqcgpw4ag8hM9Go2X7LHKTN0/j5OF+4dQIpP+Jk+NmmmdF
         FUokkNm9x+sDHmRECk50iMlxna64qhC6Z21XChzMLZRRjJN5N43DZkJKbxP66AZJKiJ+
         CFVUU0M4DJfqWj1f6EjPKqVNmKJ1fKdyuWlMSRDk7re9cOS3G98R8ejo7mquqex20X8l
         c5pOhg4g4A7AxHCOjyNGbY4gdqrOxv0WKX2pm4otrYsmJspaejQjEWfJG0RMm9taKb4m
         AYO22TVlrmXu1jxTqVHbHC8rM3gSedj41YSiD5N6r9Z+wy0VaZKEvClkXL0ED7asFs7H
         md3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ENR30W+EQorPFupcfRUDbx6GljgYrLpkJikIXFtJu0Q=;
        b=cf3LPIHUiE7jAuGcHLR9QGJwGySFnmSkmX8ZlDi6VG6jMJsn9Zw4+ao4hMpB2bE6iL
         LbkndewigynHWZ5AScGUF2uDTQ4hA0/gIBFQ+vg7LZnRqtGBrn4/18u7FZO526vT5u4h
         6lLbzfhVnqjPsodKf24WaPZ7QgmV7cW0ksisd0Yb3ktVo122GK0vRS2/aqdj8yu+Q9XU
         saBktOgwX0vcyxdzFRIMySNsKHIQFG2mLNVEksUWX1L+rwimo/LWIDu2VM8XV8+KaFwV
         vyBqSbkp5u8zz2mf4DAXFMdQab7lWIn0nIk/dquhWcIH5KakVrKDfWtcAabauOKgLQyU
         rncA==
X-Gm-Message-State: AOAM531JOYb65rZNZNi2aoGGnAxUE7puXYJLLYcdHazVlhx+woIXnbIX
        1kArT+o7kocfMdDjXq+UB0B2Cg==
X-Google-Smtp-Source: ABdhPJxjfNCxml6yFxCnotzbO6De4Cg/809K0G4G2C2mRKpmxr6iMJoZs0AWKO0UXf47Ab41LgC7eA==
X-Received: by 2002:a17:90a:c383:: with SMTP id h3mr8147517pjt.150.1604844855310;
        Sun, 08 Nov 2020 06:14:15 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.14.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:14:14 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 15/21] mm/hugetlb: Add a BUILD_BUG_ON to check if struct page size is a power of two
Date:   Sun,  8 Nov 2020 22:11:07 +0800
Message-Id: <20201108141113.65450-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We only can free the unused vmemmap to the buddy system when the
size of struct page is a power of two. So add a BUILD_BUG_ON to
check the illegal case.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ec0d33d2c426..5aaa274b0684 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3764,6 +3764,10 @@ static int __init hugetlb_init(void)
 {
 	int i;
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	BUILD_BUG_ON_NOT_POWER_OF_2(sizeof(struct page));
+#endif
+
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
 			pr_warn("HugeTLB: huge pages not supported, ignoring associated command-line parameters\n");
-- 
2.11.0

