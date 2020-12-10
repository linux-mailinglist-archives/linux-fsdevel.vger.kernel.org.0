Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9B2D5255
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 05:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgLJEAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 23:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732260AbgLJEAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:00:09 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C011AC06138C
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 19:59:29 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w16so2950880pga.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 19:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1l4xMSE0KQnA71H//bDmskGduWipXvDa6Vox+ZjNms=;
        b=hMRBPFb96XJumXLHyGTTwBklAUnIrxY7ck3bVW6zB94E5E1bc8M4k6wRlkORblzegV
         U5lvw2LfOIBvWm70vSuLDEgphWueRmLtAcavEysLQ5ehechfmSU3Ipi0TQWhQxUh3fHU
         enQTfmCl5wcAOp4vSyEMwEiXSHozesuQAfXUZ6fBkXFMzThmMoahvOptGtxCChZaB4XP
         20mAdPoysLnFwGnxcQGOb5pWjsSUWLErW/qIG10Grlgi3RBcVRbvDii7ytREaV09QuxP
         79KAVZ1RimWNnqGRmifxuj5st5dcIkCJG/ehffyI5jMdPmllwYixCXtBDTnsPx3b4BOl
         kbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1l4xMSE0KQnA71H//bDmskGduWipXvDa6Vox+ZjNms=;
        b=d4asggLr52xSaYRsl/2c95Rt8tLdxvlihOZPXkzLUouJ/CffCLUvJmbJpAyD/T5gyQ
         BmaM3zMrjEUEBILSrikrnb60QsPAMKDMmMYGAmkOAHDDM7t8EQ2t/3GkvoeuuFRZs8Kq
         Mk6lq3c2/XFwPjPV8rGxfCG28G6BOweKcVCMwIZkbR9gyhP2//k7r4aPvCI0X2cPRXhX
         SnHVIqgT7LfFemlitFruh1zdJI++dL+N/6rT1IkwsRwlVygHZdlG1ZaRd83Q6HoB2LrM
         hFZOWPn9EhQQ4lZnhKcw1ljgteb0nZ78n5uoxBTIqMUkvsbEohCW3ovF2U1nPoD5okAA
         UiTw==
X-Gm-Message-State: AOAM532HUEFEy29VGFJ++KXV6bgewpnaajKr1tZB/imN72Rj8AH5ihdz
        VLYZeR9wZASB/selJHrLDVdmBQ==
X-Google-Smtp-Source: ABdhPJydwdYQo79U6PP08VNvTBIzTtWxejp8DNMvx8xTTULpe736PdBuGNl589ah44qPUz1qAf8ZKw==
X-Received: by 2002:a17:90a:c306:: with SMTP id g6mr5511722pjt.104.1607572769408;
        Wed, 09 Dec 2020 19:59:29 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.85])
        by smtp.gmail.com with ESMTPSA id f33sm4266535pgl.83.2020.12.09.19.59.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 19:59:28 -0800 (PST)
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
        david@redhat.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v8 12/12] mm/hugetlb: Optimize the code with the help of the compiler
Date:   Thu, 10 Dec 2020 11:55:26 +0800
Message-Id: <20201210035526.38938-13-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201210035526.38938-1-songmuchun@bytedance.com>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We cannot optimize if a "struct page" crosses page boundaries. If
it is true, we can optimize the code with the help of a compiler.
When free_vmemmap_pages_per_hpage() returns zero, most functions are
optimized by the compiler.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h | 3 ++-
 mm/hugetlb_vmemmap.c    | 3 +++
 mm/hugetlb_vmemmap.h    | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 7295f6b3d55e..adc17765e0e9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -791,7 +791,8 @@ extern bool hugetlb_free_vmemmap_enabled;
 
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
 {
-	return hugetlb_free_vmemmap_enabled;
+	return hugetlb_free_vmemmap_enabled &&
+	       is_power_of_2(sizeof(struct page));
 }
 #else
 static inline bool is_hugetlb_free_vmemmap_enabled(void)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 7f0b9e002be4..819ab9bb9298 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -208,6 +208,9 @@ bool hugetlb_free_vmemmap_enabled;
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
+	if (!is_power_of_2(sizeof(struct page)))
+		return 0;
+
 	if (!buf)
 		return -EINVAL;
 
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 0a1c0d33a316..5f5e90c81cd2 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -21,7 +21,7 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head);
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return h->nr_free_vmemmap_pages;
+	return h->nr_free_vmemmap_pages && is_power_of_2(sizeof(struct page));
 }
 #else
 static inline void hugetlb_vmemmap_init(struct hstate *h)
-- 
2.11.0

