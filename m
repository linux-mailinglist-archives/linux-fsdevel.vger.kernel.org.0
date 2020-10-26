Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472E3299012
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782267AbgJZOyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:54:12 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36017 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782260AbgJZOyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:09 -0400
Received: by mail-pj1-f66.google.com with SMTP id d22so1875578pjz.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xbcz6YL/V2+vBJkP0RuPn1EYocXGKAfrd+QWEMaxAUM=;
        b=IRRFd2yt30K7UWwAWf/Q82GX3WBnc6X+qTIICwjWofKf6vFUm6pwfwIvfi1s9bw++q
         e1P5IvW7nKfIMrhuP8P0OSFyhSvYc3xN/fomg1uJ2U0Shh6i7Yl+Im3vi2dF0PX2/7y5
         yd2hvYq8tS41R2ZnqebZtXWxfwevXqTvU9fZEzsy8sTCwNZqXm2I6IM4bYGCmgFPIzi7
         IZEKxn+mio5nqWRa1xEktiumpYz8ZDyXHYZcYJcBYStHBBUPEBdVuSZBdoF79ck4Xfxx
         3W9JNjMe2pSlbBxy5RZuUBTYigKpFpQn0PKCDfH7JLexkvHB4Dj83cQOzhBxSYP2LBZo
         mDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xbcz6YL/V2+vBJkP0RuPn1EYocXGKAfrd+QWEMaxAUM=;
        b=fn7hLvdSo1CNwK8StNnRgnJuZoQVAVLxop0xTWfVdRZaBkxnAe/YRJc0jDF80MInVu
         iXXB99Nx0Hi/k5vqkch2doPc76oWyXUUA27ISL5kFMHC/j5SSP3m9VIu89Yfmv899Zy0
         tw5kCFseaCZdun6ecGwlP6QBSg5uUORrtTWe5V+S/C8R9gGVL6XWhABhYZ1R3zcJ8wBa
         HvVTYRSpLb6EvThbZ301gj92b08ykFzilp7TccIwsLaWC8GM9sMiozzlJ/d0CRAmC+Zk
         mDMZjD/+GOEUwcXoJZzguAsOIYWswUYGA/Vz284xz5n7OO7fo3zqVKQk9YITlR7aFUkR
         7pJA==
X-Gm-Message-State: AOAM5316GdVUlegDymP3KuiyRRqDUBmn3WIBwRXzHbudXyHGwgslnRnS
        SwvKxqUVDQv/I6PIjx3xdL5huw==
X-Google-Smtp-Source: ABdhPJwQ+NzECLBLitEBGku4AyEjgQ+G6AOMSJGIK+DdtJQb2yJulJzS0YNUQZMRraaOqw3eOC8UWg==
X-Received: by 2002:a17:90a:1b6e:: with SMTP id q101mr17226690pjq.79.1603724048581;
        Mon, 26 Oct 2020 07:54:08 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:54:08 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 06/19] mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
Date:   Mon, 26 Oct 2020 22:51:01 +0800
Message-Id: <20201026145114.59424-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
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
2.20.1

