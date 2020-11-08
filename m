Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA452AAB6A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgKHOMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgKHOMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:12:42 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6702C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:12:42 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id f21so3260791plr.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu3H5eYwcDByY9yS9k1fn3ciqLRHmKRE4UBx/XbnYY0=;
        b=e4eqV9yhEUExSYRbWzCm21PsnGh1NEdrGDRdhhON+gDaZXLXHbsoNIT10oEewPnDC3
         KypcDjoL93yGqT97HyT/56XgfSJIO027PvlTaYhtIyFIz1jTWWuOJFKxhISAtIcJ0EJe
         ZzDYbEVVmzvoiCFzIHimXr5M8qJpM9KubOdqnRCmPAy6mb5xjAGNaYfkKexKH29qJvkl
         TXu2TvOMGTuz5MTO5p43xUqbBRf9y3qq880Bz3yhcY+KAnquSGpcfggfiefcg+xKNvJN
         oJWQNpqRsAnp6dvafg2SiyuWh1o8b1QyntftLS9TypI8e17lVR/xAncsFwrYzUvRqfn6
         WBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu3H5eYwcDByY9yS9k1fn3ciqLRHmKRE4UBx/XbnYY0=;
        b=IA8pCxTn2DPSumGwqVDpI5YWqLNwBZ5Ero+pzq4iNYfMdb7plICsWcaS6lq4PKcmDE
         eY7fLTQgOahgG1wt/Q1rrqnpauE2lXIexaup46F7hgqF66xiLeBouaqzpBYYtfzpzMM0
         4znO4jOBJVbQXvOquOTzaN8YCgUmr4kmKpD0BKWGEVvlzppvoIaJ39qQic5bCAbv2EjW
         dXuLUTFxOXF23bk44FTw/nTFaL6wrY/M7Ueoh2tmO7g52eyjwXYfcALcCZUHVTON1zwj
         P15lU0/eQz6sIEQx2AHn/bHiBfKNkEO5m5V3LJhz9KmDO0FCokjL6mNnQL3NJqw5xGc8
         Jiow==
X-Gm-Message-State: AOAM532YQsulXV/OygHa8cm2BCv1cc2rfBEvZVrZJ7Ztcdv0nQYVr0NI
        NwOzCz0utX8nx1l2Wu4hn/lrtw==
X-Google-Smtp-Source: ABdhPJzxCPLnV3mJOn9u75dG9TeuUrTa2poVJDVNY2XGCBu5/a6Jfk4nU4IOFOx8xMTHQwQ0HIv1Ng==
X-Received: by 2002:a17:902:9347:b029:d3:b2c6:1500 with SMTP id g7-20020a1709029347b02900d3b2c61500mr9248406plp.5.1604844762246;
        Sun, 08 Nov 2020 06:12:42 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.12.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:12:41 -0800 (PST)
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
Subject: [PATCH v3 06/21] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Sun,  8 Nov 2020 22:10:58 +0800
Message-Id: <20201108141113.65450-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
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
 include/linux/bootmem_info.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
index 4ed6dee1adc9..ce9d8c97369d 100644
--- a/include/linux/bootmem_info.h
+++ b/include/linux/bootmem_info.h
@@ -3,6 +3,7 @@
 #define __LINUX_BOOTMEM_INFO_H
 
 #include <linux/mmzone.h>
+#include <linux/mm.h>
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
@@ -22,6 +23,30 @@ void __init register_page_bootmem_info_node(struct pglist_data *pgdat);
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
+	__SetPageReserved(page);
+	adjust_managed_page_count(page, -1);
+}
 #else
 static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
-- 
2.11.0

