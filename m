Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD8299036
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782698AbgJZOzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:55:35 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35178 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782695AbgJZOzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:35 -0400
Received: by mail-pl1-f196.google.com with SMTP id 1so4855664ple.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQjSxa0vgrMKs1nc5hHxeb6UL3PMbzirmN9WN1F+L+w=;
        b=sS0qpWkVdEPdgngeOsrYhiQVP6KT6GAYEydbg+7iPp4NUd663Z/WBhkZOXM4p7JpDf
         c4U76TvolSKmcZSk4o4nwJO+bDqhP9SVkwbuPlVHXOCyUJeh8bTjbdNcjjxx6y32CGKm
         /747wH8lp0Gd3FO9frbbxnpgZbiYdo+MTPvxRn1UqYkY/wKl8Rw+DXrN10Ye9jk8JAxU
         QnfEOytvwtl9h6ppfBiRbGJVGG8ddXjCeSe63ZwngjUagvkoRs8WzKWRepDPmkmI8il2
         2C7juFxzFE6ZPdtQYty2ry5YPs7Qe7bbqLUDc3eyjmxIt7CETm57AI8QqK/EpMAW1/QF
         tpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQjSxa0vgrMKs1nc5hHxeb6UL3PMbzirmN9WN1F+L+w=;
        b=SZ7UKx80KkqZoMqqF7mO/0pGmXYZmznG5b+sATJVWzrOrrKRZLUzkXHHq11Bt1H1UP
         BgUCvve7OrcKnTdRjqeQeur2jNVyUlKXLiLu8vZn3YIw8jp2EhLyXu47SPQJqg4rn49E
         W9TBlP3SNIPDYTIcbS7DMvPkrEMuyRN3YMvew7HqSVfSEL+XeccoVp2NA8fVfxDollxy
         rGG3eO6ovxeiaT0M4hMjzN4M18PRwvWfWGvwhY8XBRdY3wLZYTV6SQ6Xy6nwerTrFiXl
         MbDsI9VDyt8smPkVLWnwWePOhvVbxjPd7zrfAe4EJsxF72Nylw3Q+1HxRWFBwyMcRJ0x
         /3Gw==
X-Gm-Message-State: AOAM532Ft+fxhanTbuH5lz4sy0UL6LRREUFn8xv0a3tgUd/ogV8E3VEe
        EqFxtFCm5koPoZRX+mBI/US0Vw==
X-Google-Smtp-Source: ABdhPJzYBx8uKgWDPT/IrXY+67Z4zkfgsSTHp+RACa1Qief/BJV8T+0YeuuI35ggbaOgFelblsnJPQ==
X-Received: by 2002:a17:90a:7303:: with SMTP id m3mr22378101pjk.190.1603724134499;
        Mon, 26 Oct 2020 07:55:34 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.55.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:55:33 -0700 (PDT)
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
Subject: [PATCH v2 15/19] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Mon, 26 Oct 2020 22:51:10 +0800
Message-Id: <20201026145114.59424-16-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 7198bd9bdce5..509de0732d9f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1807,6 +1807,11 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
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
@@ -1869,6 +1874,10 @@ static inline void free_gigantic_page_comm(struct hstate *h, struct page *page)
 	spin_lock(&hugetlb_lock);
 }
 
+static inline void flush_free_huge_page_work(void)
+{
+}
+
 static inline bool subpage_hwpoison(struct page *head, struct page *page)
 {
 	return true;
@@ -2443,6 +2452,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	bool need_flush = false;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -2474,10 +2484,19 @@ int dissolve_free_huge_page(struct page *page)
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

