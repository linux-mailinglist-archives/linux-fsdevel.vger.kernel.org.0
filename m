Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043912C2241
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgKXJ5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 04:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgKXJ5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:57:36 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C1C0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:36 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 5so10430060plj.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=XLegzWPaw4syhictcJDtdO8UlkWiQesAIDyjezsiGhWLYuWMqEXoinK2ALJ8vmvQSZ
         BvUt+1LFjXIBzla2PEW+QARNYV9h7cyU9JD1U2M1q36WdZQk3IUrcFT19L7vp4lT8DMq
         BZUyc42SDVQmpNFqRg7Tdjw1YHFvUTpN8afa+VvcqJHp7Yk4E1ogM+NIkAPfiOs29t0K
         qkYlWJblARlDVzKPsJTzyqtP7URpFQRJ244SGxw3ExqgNtZdWk6qWjkA+cz01UAE8jjW
         c+HeVQYFmzstVWSkSGecvWrwt3U7ILbmZGi2kEA5YajcZKL8YGfmIginV+jTZ3Cl1i3N
         4esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VN22FTK/cp8gibu50+JlwycxClP9nhjODvnGGV4tug=;
        b=eLYQvkb0Nls770bLVksWz7Y9TaiHRtrcezdyg6YewHSspsYSHJhshJQb1zuue6nns3
         E3vphSvd9rQ1LiMutLbNqYdOlIC9sCZKNK1KepEo5BiP3JGMgvu/VDZlXcz9lXxZMk9J
         wconHoUkFyg7ASZzzyLZFNIgao2GtBlFKmjWx+dHW2Oa1PPcEM4eH470Jt6wDBUB0wZA
         Kx035SfZqtNtuORRwSsnGtJhDbsDS1LUfg9mstJfFTUUvNfQi55HWkGeYcNWR7fwLRai
         xclU2TLsFShvxFXcHHoqGPa4AcLcnsqCzEckLttRzXPLPLmJNkZpLIlHj7xkxcmPpTSi
         c6GQ==
X-Gm-Message-State: AOAM532J4TeOibK5E8mPdncZxwa9+SgH12RgJp51j1Y/xSIzGmt+UnjN
        vvjcp8beLL4DRaKdOlr27DCPXg==
X-Google-Smtp-Source: ABdhPJzkfWmZzIezFc+/XShwSpl+HYDK87BrOmp7V7j23AYWeRgU/oTmRV9QXDo9TveCXF8djbdG6Q==
X-Received: by 2002:a17:902:6949:b029:da:17d0:d10f with SMTP id k9-20020a1709026949b02900da17d0d10fmr3322210plt.71.1606211856275;
        Tue, 24 Nov 2020 01:57:36 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.57.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:57:35 -0800 (PST)
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
Subject: [PATCH v6 05/16] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Tue, 24 Nov 2020 17:52:48 +0800
Message-Id: <20201124095259.58755-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
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

