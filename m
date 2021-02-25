Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130E3325076
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 14:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhBYN2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 08:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhBYNZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:25:51 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436BC061797
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:25:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e9so3535793pjj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Feb 2021 05:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ALjwDjgfUCiRRnXNhxLFUeqrygsVEGlc9yJ4oh1b9U=;
        b=r7vMI9nuwloCcNdm4J58arhY9tNRTBqTiQSwQJBN59w7gi4btn70OWjmOooR0x6thC
         lZhEGaY9aNmJQZxZoxHZOGD/5p+pk9/pjZ72jo8ld/ETlJm5E+kC2LnLvFvaFXPaa3Wp
         xmADPF4HQynTcJwZ9lWHOB8ulgRkiBQDARs8rhVrkVEBHMHpazOEP2PHjcFDY5rtuxu2
         Q0aIyo5WPKczq+9RJPndJLumrbzv6BD9p4wJfjIbvdGArSZ5n4k60QgERyD/gOSQacwM
         T8NcZlacEJrFiyXHItA+/S7jmjuO/bkegFQPahWMxQl+VMVmfIJQb44E2R6jP5qYWQ9x
         KdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ALjwDjgfUCiRRnXNhxLFUeqrygsVEGlc9yJ4oh1b9U=;
        b=E6V4/e4+F2y2b4ifm5je+crTy9+iD7jy+bXfMjQ5sWalwx1SmNEszYJqr9cW5ISLa/
         v8px0mw9U0XoWN311J8DLDXY1b6tXdq39iDAsJboqDayM2FdSteWOLtafXfUNcAeaAp8
         CYWrDX0eGwEddAxfHCZoSbTEh+2mst8p8Y8YC8dUWMq4m31hcE4A4eFWCIWj+i15V+LH
         I0M5Fe+dvZ1WyixoxsJsf099Do08SD96i0puqJCdNjbcq2WLlI3ktpdSYSE/VpjBpXtA
         nK+Hs+9rJscs7gsxCNhyKqM0aGh4kg64p1u516t6CxclZ5OTdwMEcXF4f10HCggf5GWY
         wk9Q==
X-Gm-Message-State: AOAM533d9dZctaYGk5TFRjGh0G+0Kh1r8hyJUtGIGXBUu9obwGS8GwN4
        rhMxB12mLdATzlUUzPDT8OfnaQ==
X-Google-Smtp-Source: ABdhPJwodtMHyxCaWlFm4HG/tefNqA2c4tpqqCz0R5x4J0cuYwd0UrCSIiS6CvzL8+BRIkAnfUbndg==
X-Received: by 2002:a17:90a:4a8c:: with SMTP id f12mr3327933pjh.71.1614259514605;
        Thu, 25 Feb 2021 05:25:14 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id x190sm6424676pfx.166.2021.02.25.05.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:25:14 -0800 (PST)
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
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v17 9/9] mm: hugetlb: optimize the code with the help of the compiler
Date:   Thu, 25 Feb 2021 21:21:30 +0800
Message-Id: <20210225132130.26451-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the "struct page size" crosses page boundaries we cannot
make use of this feature. Let free_vmemmap_pages_per_hpage()
return zero if that is the case, most of the functions can be
optimized away.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/hugetlb.h | 3 ++-
 mm/hugetlb_vmemmap.c    | 7 +++++++
 mm/hugetlb_vmemmap.h    | 6 ++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c70421e26189..333dd0479fc2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -880,7 +880,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 33e42678abe3..1ba1ef45c48c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -265,6 +265,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
+	/*
+	 * The compiler can help us to optimize this function to null
+	 * when the size of the struct page is not power of 2.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return;
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..29aaaf7b741e 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -21,6 +21,12 @@ void hugetlb_vmemmap_init(struct hstate *h);
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
+	/*
+	 * This check aims to let the compiler help us optimize the code as
+	 * much as possible.
+	 */
+	if (!is_power_of_2(sizeof(struct page)))
+		return 0;
 	return h->nr_free_vmemmap_pages;
 }
 #else
-- 
2.11.0

