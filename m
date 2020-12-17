Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A6E2DD14F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgLQMRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 07:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgLQMRe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:17:34 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439DC0611CB
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 04:16:54 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 11so18912524pfu.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 04:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Efs9O+Tk92ClTQOdI0RWD/KsiOR71gsSXX4XHfsyAk=;
        b=L1Q1eYqYKO0zvPjCfjSIfHHGcNAqhDIG3lJs221961ERQ4S1SnUpxQ4jIl0FQ1/cJo
         F0XEMgxmJHC5FBc6NiaU3juWZHGz1Yfe4Oh9JKJgs5p4VZ9wiVlwG+DjdawOAXyxKETw
         6IgSmVsZmZI2WMVBN/nfgbLgWXGSTx3dkvL/LgRgMNspfYmxHPOtfCOxURuAA6b1u+LD
         dNHlLpuiPnFl3ySPxcOKI8Bgjvt9p03vfZT/oYu0uxjVdHal33zbDpJwwZnIS9VgYXNh
         A1yOHox9HRMeStuqBsbzsgmUCMxSSdsGoYEf7f0ViPcf+7SoV7A2/ACN5fIc39Ocd5Lp
         Bf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Efs9O+Tk92ClTQOdI0RWD/KsiOR71gsSXX4XHfsyAk=;
        b=Xp3A0c4qTgHBoeIw7YZYChU6b3aniXElR8Acd3/OYyQ+oZkvxrNclGPi5aOyZkUwGS
         LW8DlC/VWh1JK+EZXR7/74Qbrw38TUVyUvuizo2dnIqTxhvm9wmKqO5fHfUVI9dOQkTe
         PJ/mNDbkRI7x8RoDM8w9/0hsAtWMfJYof9eRi24XB9HKaq5kVm1pLMAM30V0UTuHJjMo
         3kWO2jBWgXgUESYuOVF0RJDM8x/FJx2aPTqcF7JvDvUQwQrzYbx+QiTfVumw15HksNdb
         icVSG6xObqeUGrsB7+dpY6EyMiOEIvZNaVTTs8FFWHpk2cFaPlUmiuEEPI01TxXkfALR
         CkHQ==
X-Gm-Message-State: AOAM530SNzkVjQwSXjOvguksc9VIUVTkNfzrA6rOZTGWzECZafR3mcao
        AJsA0kXL1i/FZ7crCBXy9A9XJw==
X-Google-Smtp-Source: ABdhPJwyGVM/3sUL3COu58Gvvs0SsTRi1P30cejz730zCZtUr41jShPb2zwAFvYAnO682bytBUeJ6Q==
X-Received: by 2002:a62:2c9:0:b029:19d:d3f7:7dba with SMTP id 192-20020a6202c90000b029019dd3f77dbamr7619121pfc.40.1608207414203;
        Thu, 17 Dec 2020 04:16:54 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n15sm2775691pgl.31.2020.12.17.04.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 04:16:53 -0800 (PST)
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
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v10 07/11] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Thu, 17 Dec 2020 20:12:59 +0800
Message-Id: <20201217121303.13386-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217121303.13386-1-songmuchun@bytedance.com>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should flush work when dissolving a hugetlb page to make sure that
the hugetlb page is freed to the buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f15aa9b19b6e..fea8a96dd718 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1326,6 +1326,12 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
 }
 static DECLARE_WORK(hpage_update_work, update_hpage_vmemmap_workfn);
 
+static inline void flush_hpage_update_work(struct hstate *h)
+{
+	if (free_vmemmap_pages_per_hpage(h))
+		flush_work(&hpage_update_work);
+}
+
 static inline void __update_and_free_page(struct hstate *h, struct page *page)
 {
 	/* No need to allocate vmemmap pages */
@@ -1864,6 +1870,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	struct hstate *h = NULL;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -1877,8 +1884,9 @@ int dissolve_free_huge_page(struct page *page)
 
 	if (!page_count(page)) {
 		struct page *head = compound_head(page);
-		struct hstate *h = page_hstate(head);
 		int nid = page_to_nid(head);
+
+		h = page_hstate(head);
 		if (h->free_huge_pages - h->resv_huge_pages == 0)
 			goto out;
 
@@ -1892,6 +1900,14 @@ int dissolve_free_huge_page(struct page *page)
 	}
 out:
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * We should flush work before return to make sure that
+	 * the HugeTLB page is freed to the buddy.
+	 */
+	if (!rc && h)
+		flush_hpage_update_work(h);
+
 	return rc;
 }
 
-- 
2.11.0

