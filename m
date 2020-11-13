Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D548B2B1986
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKMLDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgKMLCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:46 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C91C0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so7302758pfq.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=VXie40CJ/fHrNIqDxNTz1GZQ9IUwdONiHU7BNAkIY8B2uU8hpqGGZFFGMkRMjvUHxM
         bnwwM0lkwcuOxrSnvs0tEfBJS8l0MqOb+zmKW2JGLjAgfvn54whcocRtiQNLzGFVF+4D
         Hov8wnJwOFJa0AXkTfmtTsgXBJ1QGaQyNs1QqmydTXHXH/kY4VPmnLIM66LxcvsPPuRb
         auD5GVm6SIHHjS3IdC4oC/JNZznkRbWzWnUqDZfIWxBSYVSNZpsA2HQH7sCsuDtnprw6
         L+21F7cWT+Doj8Kxmr9kKjJ9dPaP6PE7rxydgtjMrWsz6e/cZglYP4WQKQm3JXnOOwbX
         6Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=FYTz7FfKO4wLerouFcUn5BH2aEZgCLGhrsuGJXh9poKhPDBN+vWwS4GZixUqYVY4p7
         Lt1HsdBhFAYTfpAZWXw8AfqMgnW3lcpK+5JTKfG1r9ObA8sYyJf6JE/tdfY73Q3kAJWE
         GKVPMaTGMNvRyznLQ6wf261rDMI0xG0ckX6t3bco1w+8dRaOAwFJ/hEPSBqHwkR9sygE
         LHR3ADtRGqGnC0LLohgVLFRZRi8S6VcK0aPV6rXCbRVipax3KMmbJUiB6qmhLd2g7SkY
         /RCO6TbY7kgrm155QZ5bWC/QCyFgv+KHh7MoB3S2zkZsXzkCr+xrbA+c7b79clTz5QIf
         m3/w==
X-Gm-Message-State: AOAM533fBPHcRuuATyDPzms5ZADJzh1+VbwnrimgbSDZlkztFx8HWJyX
        26a13LdRTL7qGcemOG/s9h7G9Q==
X-Google-Smtp-Source: ABdhPJxbg1v/KZquALQzR8zC1f8a2UHGf7V/31l5O4xTMJCYuYdRHE2ig6g4Zrdc9lqZDjdhP6lnLg==
X-Received: by 2002:aa7:970a:0:b029:18b:5773:13e6 with SMTP id a10-20020aa7970a0000b029018b577313e6mr1665133pfg.34.1605265324421;
        Fri, 13 Nov 2020 03:02:04 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:02:03 -0800 (PST)
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
Subject: [PATCH v4 06/21] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Fri, 13 Nov 2020 18:59:37 +0800
Message-Id: <20201113105952.11638-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201113105952.11638-1-songmuchun@bytedance.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the later patch, we can use the free_vmemmap_page() to free the
unused vmemmap pages and initialize a page for vmemmap page using
via prepare_vmemmap_page().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/bootmem_info.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 4ed6dee1adc9..239e3cc8f86c 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -22,6 +23,29 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
 void get_page_bootmem(unsigned long info, struct page *page,
 		      unsigned long type);
 void put_page_bootmem(struct page *page);
+
+static inline void free_vmemmap_page(struct page *page)
+{
+	VM_WARN_ON(!PageReserved(page) || page_ref_count(page) != 2);
+
+	/* bootmem page has reserved flag in the reserve_bootmem_region */
+	if (PageReserved(page)) {
+		unsigned long magic = (unsigned long)page->freelist;
+
+		if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
+			put_page_bootmem(page);
+		else
+			WARN_ON(1);
+	}
+}
+
+static inline void prepare_vmemmap_page(struct page *page)
+{
+	unsigned long section_nr = pfn_to_section_nr(page_to_pfn(page));
+
+	get_page_bootmem(section_nr, page, SECTION_INFO);
+	mark_page_reserved(page);
+}
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-- 
2.11.0

