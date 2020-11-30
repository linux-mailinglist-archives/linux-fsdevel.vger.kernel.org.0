Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056B72C87D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 16:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgK3PWf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgK3PWe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:22:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6AC061A47
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:54 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so1533397pjr.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 07:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuUKX8d4nSr1QpzefkNAk3vJpwlYcNoKqBePERxkILM=;
        b=K3OBTqgXSNp5EAH2ATyadig7W4nsC8UODJccBFE53y6L9s/8TLLOcoz+75HFYiNLab
         3M/YhR3GwxtJAVVwcar9pVLNNPkWXTz4CN3/fYBm6Z7IAlpc8SSj3mPd+rnH51McUlVd
         +pxfL7D1MX0zOkGAMCDEVG5dLv2UZM29t+Ba60eazD2nl6LUg4gToJZATV3576mryTaG
         C+JZppYloYDZw9GnaItvp79nNrEai4JVjsrBvDdoKIGZA+7DNpPwrigco0kci6dPmbG+
         bUGZNgPF9tk6CCUWwbl327grbi0FpNJ4Y4BOM7Me4RBcaBcapG2ahQtc5nORyDgybimY
         KGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuUKX8d4nSr1QpzefkNAk3vJpwlYcNoKqBePERxkILM=;
        b=Vc1kOHNscH0T6Bz1EkYJJ2zSn+SQSVJaBHEmDTOOzBoKagegyTr4La7/UmZ4e4yQYv
         30vXYonMYqOujdjj+M282tASrm2ZUcZQSuc60G0rsoJq0Y8yHgD1C8ZKEvVEdz8n+ODl
         hFoY5AoqrPIb8aObhXF8kt+UHqoj/1kVoTW2GUsrF2Ub979b005hpd2Wo8DKB8lyxx5b
         G0zhWSroNa1diRS2VRAWUZBIdHdNZn1xBA4duySDGbXSOAitSKqO2qIuueuuVZeaytX8
         lfxDJ0LeZZX7hK2IFzjsWIniT+0kbOo62NFfqhvX37XSXTM2AtAyuPS72lLxcolexqUd
         1Flg==
X-Gm-Message-State: AOAM531sjLAKMGGHwpvFokOROp8z3b/ujiOvWQtw81cXkxKZhGN75bul
        T8uTdwxJCTkswdfFwKaUTBCwrw==
X-Google-Smtp-Source: ABdhPJz6JFlCGHeRqTkVb9tcu3nTa7vPf8NBGUJescRklNe13RCi1870SqkANDzcdyEXLfM5aG8X4w==
X-Received: by 2002:a17:902:c154:b029:d6:efa5:4ce7 with SMTP id 20-20020a170902c154b02900d6efa54ce7mr19258396plj.73.1606749713784;
        Mon, 30 Nov 2020 07:21:53 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.221.68])
        by smtp.gmail.com with ESMTPSA id q12sm16201660pgv.91.2020.11.30.07.21.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 07:21:53 -0800 (PST)
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
Subject: [PATCH v7 15/15] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Mon, 30 Nov 2020 23:18:38 +0800
Message-Id: <20201130151838.11208-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
References: <20201130151838.11208-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are only `RESERVE_VMEMMAP_SIZE / sizeof(struct page)` struct pages
can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so add a BUILD_BUG_ON
to catch this invalid usage of tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ebc710d148e4..3328de88819e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -340,6 +340,9 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!is_power_of_2(sizeof(struct page)) ||
 	    !hugetlb_free_vmemmap_enabled) {
 		pr_info("disable freeing vmemmap pages for %s\n", h->name);
-- 
2.11.0

