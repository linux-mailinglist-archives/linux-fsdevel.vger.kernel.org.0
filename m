Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8EE26B84F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgIPAla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgIONDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:03:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03FBC06121F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so1975894pgl.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pILI1DDrFe/b2Xrn63/srspFkYH22+x7evVHRLCQbNs=;
        b=aV3A/QCSeKx/M6lxiGM69I2x22wWXM5E8xYjTXWvW5FmYeJhqDzAMXLFwr+IlVywrd
         OaHxAqWmnINT8f3NrR+Am89Tusaw27BZ5R8rsk7NnDBqP/+hoRH3B+4d3yGBclXVaBhW
         DZMwNl7z/XjVPQaKBP9LXodEGaBFjxhm86jA3yT9TLez0jAJ57CLBdMXfobRNs0SUjar
         ElqNnd+J7SUQWAhjfCR6wWTokDIUS335J42n1QMGV/wD92djIwR5OFoCZm1USSnA5p+p
         yMoFm9hJhk+WQXlXykrLNJrO/kr0gNbyGT/fxDAbO/DLWVGbtcIqz9lUlWJSt1ikLvly
         wZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pILI1DDrFe/b2Xrn63/srspFkYH22+x7evVHRLCQbNs=;
        b=Va15gTtH/4wkJzewhz/DjJeDPRXVN8sit/notpFRtrrFsYhR0vaT2EroP5vxcxiuQ5
         2uLRZZqchydt77W05RRvac0+ABlJNrElOvBHh9re0FCgBC1EMTSdccR6DxJ7/4LCsi30
         vbj9Zku4xfUv67urbl/v1hvD5c7BzeEg3+aBr27T9UgqGSygthMzqdOS9hWjIIPxM3a8
         XplkHOMtpomMuhmfJ0d+nuz6yV7bYmE3dMu/EPZYO12z40AgpyibWGpwmun+yswJ+C9h
         YpOD/4ueCSAVdObCLmMj726vYsjKmRjSFCpE1b2yN77n4zvEIBPEEu6FDS5A7jnLLoe0
         q0WA==
X-Gm-Message-State: AOAM532SkmkQoZ+HkA9clrC7aG7WBM1fb0W2HSEftWpwGnS2TZl9HGAz
        bPC9KYLytJUOUkQKaSApqKddzA==
X-Google-Smtp-Source: ABdhPJwdj/8EX6dbyD+Wrkpe396z326LshE9196SheOxP4atV9x9XuoP4OWtAZUey/v+ouqG80JBaQ==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr14668403pgj.111.1600174996425;
        Tue, 15 Sep 2020 06:03:16 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.03.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:03:15 -0700 (PDT)
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
Subject: [RFC PATCH 19/24] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Tue, 15 Sep 2020 20:59:42 +0800
Message-Id: <20200915125947.26204-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should flush work when dissolving a hugetlb page to make sure that
the hugetlb page is freed to the buddy.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8666cedf9a7b..56c0bf2370ed 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1848,6 +1848,11 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 	free_gigantic_page(page, huge_page_order(h));
 }
 
+static inline void flush_free_huge_page_work(void)
+{
+	flush_work(&hpage_update_work);
+}
+
 static inline bool subpage_hwpoison(struct page *head, struct page *page)
 {
 	return page_private(head + 4) == page - head;
@@ -1910,6 +1915,10 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 	spin_lock(&hugetlb_lock);
 }
 
+static inline void flush_free_huge_page_work(void)
+{
+}
+
 static inline bool subpage_hwpoison(struct page *head, struct page *page)
 {
 	return true;
@@ -2484,6 +2493,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	bool need_flush = false;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -2515,10 +2525,19 @@ int dissolve_free_huge_page(struct page *page)
 		h->free_huge_pages_node[nid]--;
 		h->max_huge_pages--;
 		update_and_free_page(h, head);
+		need_flush = true;
 		rc = 0;
 	}
 out:
 	spin_unlock(&hugetlb_lock);
+
+	/*
+	 * We should flush work before return to make sure that
+	 * the hugetlb page is freed to the buddy.
+	 */
+	if (need_flush)
+		flush_free_huge_page_work();
+
 	return rc;
 }
 
-- 
2.20.1

