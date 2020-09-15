Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6026B844
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIPAks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgIONDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0123C061226
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:45 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m15so1305958pls.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sz6P1Q0kau3GSnlYNyXI0z5mzhU/+ZiSkY10ScUrzyk=;
        b=LPFGIiaOonFtAsxKer4O1k4VDV/21wx6IGQBP/yW9jfBQCdIAz+nqS5J+q/bUqf1If
         PxixgYwuqbNpW7u/oclZ3AwhyIwiahOwnzbqvso+VW0dseDH++h8Sm68KIxO6fybwu1y
         2W2atiKWeVJ78swW8ou9DyBrzIUeFQVHFU50PO7At9ZNrwfMyZuXvXIpIKk+/K4nC3WL
         nsVRCcm1tI11TDeDMHaQf4ISI9bDV+JtqFxIFIFkFsUWbbe+DJ60tSjxcU1GcEFLVMRh
         k5Uah3dz5Cee6AHxCCYK6C3aSYmyjOsx2nAhQmWIXlDXlEQ7NgVVy7GObE49ohiQ+vmo
         h8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sz6P1Q0kau3GSnlYNyXI0z5mzhU/+ZiSkY10ScUrzyk=;
        b=II7Y3wpM3GiQYKsv3ok/HU8wf3A/G0hpAiJ0gJRpsxWkPx2LZFaE9dUd4pGEO/3qGY
         CCl5dRMb9ROF2cSU3IgLJKzTFTQFzAnKg3W0Vqk+a2GyJd8XGq5tt/6xZKT1Y6dRTgre
         QmlUMCNpvgVuVNommyVtcDCxb7n/0b9M4PKiXuQ5It7Py2QBIg+IJgeB2Qwru1oMMzVA
         KYCXC5aohyjPMfY+meJYHW9/v0FhXM5baXtLEAEmca71G5b3LLTi/Qfe32o0SiSXDKNF
         E8+ClCMLV/lTntkOyJslO9vOSE2XJhAqW5uXVIGWS2hfbZqC+8F7eL1h+LDpvfOIsZcM
         CoQw==
X-Gm-Message-State: AOAM532NxMJrnjZrObo+t+gsqU1h45k/jKsTU2YRNmEbvcnqRYy0L+64
        TwWui1o7wz/Wj2Ikcv0o4BT/zA==
X-Google-Smtp-Source: ABdhPJyoZylboM7Gk4ZA72/1F4sZ9fvO9eKvsVO0QDYpNOSzflVchD8LbsJYKSeiSua9Y3Pi+z1jXQ==
X-Received: by 2002:a17:90a:1f43:: with SMTP id y3mr3977140pjy.28.1600175025206;
        Tue, 15 Sep 2020 06:03:45 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:03:44 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 22/24] mm/hugetlb: Implement vmemmap_pmd_mkhuge macro
Date:   Tue, 15 Sep 2020 20:59:45 +0800
Message-Id: <20200915125947.26204-23-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In vmemmap_populate_hugepages(), we use PAGE_KERNEL_LARGE for
huge page mapping. So we can inplement vmemmap_pmd_mkhuge macro
to do that.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index 7c3eb60c2198..9f9e19dd0578 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -15,6 +15,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
 {
 	return pmd_large(*pmd);
 }
+
+#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
+static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
+{
+	pte_t entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_LARGE);
+
+	return __pmd(pte_val(entry));
+}
 #endif
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
-- 
2.20.1

