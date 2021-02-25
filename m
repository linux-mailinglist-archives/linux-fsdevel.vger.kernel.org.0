Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E348832506B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbhBYN1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBYNZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:25:14 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89EC061788
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:24:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id v200so3616862pfc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCS+yi4FQEcYV3QuXltaFkVQ0yQluHl+1qNlK3wFCCA=;
        b=erxLSBf5h20SirJAItdp/RRKXmAFqy0tCXbBdqAdA1U4hLCBOEzCEKjSZUpkJkRFPp
         bm+g0tnaeGA1+Jm0k4341aeyl7XuVIcRkAHW4vtwvzdM7sp+jJ/BGlmouwv3+1dAjnwq
         69c1nDI4DuNRwtiOUEIcgWSaFp+W/m/EHBJuKX72VYwRd3fcyWvsyBOsZnXpGPiYYRTJ
         W/jZDpqNtACw2kQBFADhBoEIqWAsdsuRnm4EibYa7ibDqNaD4MpsoekBJb+9r+4fB3WZ
         9IWjYRPvCJWaf/aY+sMr8wGweLc/6FvFqfIcecfxe9TwSuOU/MI1nRN8n+5UKHxeGz5t
         dsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCS+yi4FQEcYV3QuXltaFkVQ0yQluHl+1qNlK3wFCCA=;
        b=D5XEuENtIz9UjX47LimZqkDDCuCLhIaF3i5t65Pm6TQGBzS0VFhAvpOYLzwpnkCXi0
         V0bniHDpZmF8tF/sM2oGhgQlqLLPYRizeIXS7jYk8sKJQEpumP8/SXcqfdClVBEziNAs
         0XHKPwSG009LLNUZN2j/vxXFXHv8qdjqOoTmHWgCgUwO5f2CvWMSRe9HOVDsw+u/TgHH
         in2vjxNvfQbSNBz8wDq0nU6Ai8NNs61DTjutbtZ+4WpkamMmObYNqUZ7idkttkjIP+go
         2mOPrXTbsTbg9koz1EoYMCh55qVpDlVnCoERM7a4ASlsVtELoEC1OELNtcr5JO5SKweZ
         A01A==
X-Gm-Message-State: AOAM531BqvttIBK1FVSJaeCBF0HsYUecR+sjqD33Lpm96d2W+PDc9gSZ
        hSrFPRJKoSMAgZA+C1gf2qFIYA==
X-Google-Smtp-Source: ABdhPJw3y7ROzg9OQ2a0vx0Co7aebFMTYs2UosINX3/4J5/+VEb4/z5L8//VT0lad9XYnbmnNmyTDw==
X-Received: by 2002:a63:221b:: with SMTP id i27mr3009806pgi.44.1614259469960;
        Thu, 25 Feb 2021 05:24:29 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id x190sm6424676pfx.166.2021.02.25.05.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:24:29 -0800 (PST)
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
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v17 5/9] mm: hugetlb: set the PageHWPoison to the raw error page
Date:   Thu, 25 Feb 2021 21:21:26 +0800
Message-Id: <20210225132130.26451-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because we reuse the first tail vmemmap page frame and remap it
with read-only, we cannot set the PageHWPosion on some tail pages.
So we can use the head[4].private (There are at least 128 struct
page structures associated with the optimized HugeTLB page, so
using head[4].private is safe) to record the real error page index
and set the raw error page PageHWPoison later.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/hugetlb.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 72 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b6e4e3f31ad2..bccb6907833f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1304,6 +1304,74 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
+{
+	struct page *page;
+
+	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
+		return;
+
+	page = head + page_private(head + 4);
+
+	/*
+	 * Move PageHWPoison flag from head page to the raw error page,
+	 * which makes any subpages rather than the error page reusable.
+	 */
+	if (page != head) {
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (!PageHWPoison(head))
+		return;
+
+	if (free_vmemmap_pages_per_hpage(h)) {
+		set_page_private(head + 4, page - head);
+	} else if (page != head) {
+		/*
+		 * Move PageHWPoison flag from head page to the raw error page,
+		 * which makes any subpages rather than the error page reusable.
+		 */
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
+{
+	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
+		return;
+
+	set_page_private(head + 4, 0);
+}
+#else
+static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
+{
+}
+
+static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
+					struct page *page)
+{
+	if (PageHWPoison(head) && page != head) {
+		/*
+		 * Move PageHWPoison flag from head page to the raw error page,
+		 * which makes any subpages rather than the error page reusable.
+		 */
+		SetPageHWPoison(page);
+		ClearPageHWPoison(head);
+	}
+}
+
+static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
+{
+}
+#endif
+
 static int update_and_free_page(struct hstate *h, struct page *page)
 	__releases(&hugetlb_lock) __acquires(&hugetlb_lock)
 {
@@ -1357,6 +1425,8 @@ static int update_and_free_page(struct hstate *h, struct page *page)
 		return -ENOMEM;
 	}
 
+	hwpoison_subpage_deliver(h, page);
+
 	for (i = 0; i < pages_per_huge_page(h);
 	     i++, subpage = mem_map_next(subpage, page, i)) {
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
@@ -1801,14 +1871,7 @@ int dissolve_free_huge_page(struct page *page)
 			goto retry;
 		}
 
-		/*
-		 * Move PageHWPoison flag from head page to the raw error page,
-		 * which makes any subpages rather than the error page reusable.
-		 */
-		if (PageHWPoison(head) && page != head) {
-			SetPageHWPoison(page);
-			ClearPageHWPoison(head);
-		}
+		hwpoison_subpage_set(h, head, page);
 		list_del(&head->lru);
 		h->free_huge_pages--;
 		h->free_huge_pages_node[nid]--;
@@ -1818,6 +1881,7 @@ int dissolve_free_huge_page(struct page *page)
 			h->surplus_huge_pages--;
 			h->surplus_huge_pages_node[nid]--;
 			h->max_huge_pages++;
+			hwpoison_subpage_clear(h, head);
 		}
 	}
 out:
-- 
2.11.0

