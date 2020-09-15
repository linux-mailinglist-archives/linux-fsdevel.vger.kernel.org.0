Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E7726A5CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgIONBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgIONA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:00:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F527C06178C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:00:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f18so1871146pfa.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKEqqYxLMCCV7YILHWcPfLsNzogWUGmkwXoJBs8HDY0=;
        b=E0PsDVeSYmlyIy70MIh5m0hXMwHWvwLKrDYK5X1wkQ8FBA2P3oE8f7JK5FEAyzBh6V
         pGJ5DHyLYlCaEV0d+66igOqnGYHN1U/vN2wDGiEd2OiAhPcrmeJczLyYK8s6RU6pOfaP
         egYXUEevR3/zofar2Rn0FAgZ997gEWeaj4Se6MhyrbgWvpOHE1e2ONo/PJNOFDYz0BLa
         XIHMFYPITNrSAktssfEoAIrl+y28Ig7vi14OUQ0pJ4PkaoKoh7DGEUhazgYrxJsyu1zg
         EyB+Qo/EYrNJafh7GJRw6ckJ/KjXrDg6v7sMLOqSADxaAgNLJDW1T1qik6fjnjK0tPdx
         xtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKEqqYxLMCCV7YILHWcPfLsNzogWUGmkwXoJBs8HDY0=;
        b=JAnb75HQy8Eg7oMf+V5fcaMWN5A1Re8/M/lFjbXSJH49dRTVAIHFSG0ReA7tR3gm9J
         1TZCRvbaRJaDrnWSqAib7YPN1GrqjJMTyh1bqeHN9mHcl8YLc48x0ESCwJP2KKJxJpmS
         /tyKmvO84nE08Au1CA2UU+WtNTIWtgBwHgRYtqopeoQfVHvJeAPqaBzFao6u5cOfjAxS
         ackX2X02Tb66mm4lKHf3ZCw4b1FICeut6GTeIeUC1vbTYJRGwnOvv+aDVaR28Ph/ZSCA
         25PtRHDpgdzrxWGtDjRMD65oJp3sjagS8XWyIxYaHZob08m1D/BpAzSC++UKUxuhna86
         qRFw==
X-Gm-Message-State: AOAM532pm0rZn829+xWzbeWE5T41pcrGHjAgbKBgBLjn/1zM1jhbclKf
        mAxvLR+prN8qy5P8MuQ1kJjlXQ==
X-Google-Smtp-Source: ABdhPJxlSQz9UBnN/6SxzywlbRtzg8E1L0Sk6hjaz2n+M2tJkehWJQpoFBxhfBG7Rd9G4EYxwFksNA==
X-Received: by 2002:a62:1c81:0:b029:13e:d13d:a0fa with SMTP id c123-20020a621c810000b029013ed13da0famr17739633pfc.22.1600174857496;
        Tue, 15 Sep 2020 06:00:57 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.00.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:00:57 -0700 (PDT)
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
Subject: [RFC PATCH 05/24] mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
Date:   Tue, 15 Sep 2020 20:59:28 +0800
Message-Id: <20200915125947.26204-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the size of hugetlb page is 2MB, we need 512 struct page structures
(8 pages) to be associated with it. As far as I know, we only use the
first 3 struct page structures and only read the compound_dtor members
of the remaining struct page structures. For tail page, the value of
compound_dtor is the same. So we can reuse first tail page. We map the
virtual addresses of the remaining 6 tail pages to the first tail page,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

So we introduce a new nr_free_vmemmap_pages field in the hstate to
indicate how many vmemmap pages associated with a hugetlb page that we
can free to buddy system.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index d5cc5f802dd4..eed3dd3bd626 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -492,6 +492,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81a41aa080a5..f1b2b733b49b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1292,6 +1292,39 @@ static inline void destroy_compound_gigantic_page(struct page *page,
 						unsigned int order) { }
 #endif
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+#define RESERVE_VMEMMAP_NR	2U
+
+static inline unsigned int nr_free_vmemmap(struct hstate *h)
+{
+	return h->nr_free_vmemmap_pages;
+}
+
+static void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int order = huge_page_order(h);
+	unsigned int vmemmap_pages;
+
+	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page not free to buddy system,
+	 * the others page will map to the first tail page. So there are
+	 * (@vmemmap_pages - RESERVE_VMEMMAP_NR) pages can be freed.
+	 */
+	if (vmemmap_pages > RESERVE_VMEMMAP_NR)
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+	else
+		h->nr_free_vmemmap_pages = 0;
+
+	pr_info("HugeTLB: can free %d vmemmap pages for %s\n",
+		h->nr_free_vmemmap_pages, h->name);
+}
+#else
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+#endif
+
 static void update_and_free_page(struct hstate *h, struct page *page)
 {
 	int i;
@@ -3285,6 +3318,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	hugetlb_vmemmap_init(h);
+
 	parsed_hstate = h;
 }
 
-- 
2.20.1

