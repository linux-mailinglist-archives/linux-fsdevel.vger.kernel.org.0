Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2942AAB8A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgKHOOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 09:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgKHOOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:14:36 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D8C0613D2
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2020 06:14:36 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q5so2537746pfk.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2020 06:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xGk99oWPGnpN4FYpAClZ/sbMfd7MuDXDW58bOTmCGl0=;
        b=c3HHOTtr5JYnv2lobf+qA/PZ2JxtIPFBh4I5RRXOVSoFqdiIYGFRs6L0u4GAhrbiMP
         /fVfbaeQr7GtAw4max524LNMjZM9SnaGVZ0wxp9locWREhOP0c7sF/Oo3/1tAA7lQS0X
         mC6IUUyrhrNEA9PYsPqGEbhQAMlWa3DyHT8ZSyl3QqHQAEy/Hfo+aBiFkRHXjyp5SM7r
         3PYei7eAs/A31qw2IwtrQdKKgfAAk1gr96RwfvdGCmst5oE4nuq6V8lrPpiijk0rlAXW
         NdAeva3pL7oy6fXrl/513LBYtt0UkRjG09ST0KrCP9vsh9LTBt5E3ou92oxbwm5yxYlN
         bAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xGk99oWPGnpN4FYpAClZ/sbMfd7MuDXDW58bOTmCGl0=;
        b=SWIvTwZW65VxuZ1hUE6dyAmy06rPmBUYvoPpZHs+1auqPc9DXdfS1VmQgm/ZhPERaO
         RsRzXOjhkTzm25ZI4PXWIBwME62oyeL3y58V0kqEzszu/Id+MJ4Tg8C3NHSHasJ71/jb
         GB94YPkY38712ukWCt/wASdSp0er5z3qShJ44ARZCUEeFmPrQ/JS38zz5t49SCPDoHPm
         9rinHuTTYAg+SkOt6I0Eevl8dAkMe4CsP9xdwG0xYOu8YSjDIBfcxQPKNdRANaKfdYoP
         nCtg+4nfjZMLRMB4jNRUdbJoZoZHxh/pdaRi9yR+PPBwu7DpomN2jP2t6RRA+RgE7E5G
         BH6Q==
X-Gm-Message-State: AOAM530D1VJSq9W+d7YJcJTxaxzmGI+ZgLb5CMiK/o9aXb+B3kmN6vtC
        IGfXE0yHGjtpnNFfQsUEcZU+aw==
X-Google-Smtp-Source: ABdhPJwmnI9wz7z84dpkmVCHu+Ytsny1UtEsSs+pwgtK14zj7vbi2Q4mYaBE7cbCcEKatyzvawKt1w==
X-Received: by 2002:a63:7408:: with SMTP id p8mr9184214pgc.273.1604844876138;
        Sun, 08 Nov 2020 06:14:36 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.14.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:14:35 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 17/21] mm/hugetlb: Flush work when dissolving hugetlb page
Date:   Sun,  8 Nov 2020 22:11:09 +0800
Message-Id: <20201108141113.65450-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
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
index 00a6e97629aa..4cd2f4a6366a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1795,6 +1795,11 @@ static inline void free_gigantic_page(struct hstate *h, struct page *page)
 	__free_gigantic_page(page, huge_page_order(h));
 }
 
+static inline void flush_free_huge_page_work(void)
+{
+	flush_work(&hpage_update_work);
+}
+
 static inline void subpage_hwpoison_deliver(struct page *head)
 {
 	struct page *page = head;
@@ -1865,6 +1870,10 @@ static inline void free_gigantic_page(struct hstate *h, struct page *page)
 	spin_lock(&hugetlb_lock);
 }
 
+static inline void flush_free_huge_page_work(void)
+{
+}
+
 static inline void subpage_hwpoison_deliver(struct page *head)
 {
 }
@@ -2439,6 +2448,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
 int dissolve_free_huge_page(struct page *page)
 {
 	int rc = -EBUSY;
+	bool need_flush = false;
 
 	/* Not to disrupt normal path by vainly holding hugetlb_lock */
 	if (!PageHuge(page))
@@ -2463,10 +2473,19 @@ int dissolve_free_huge_page(struct page *page)
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
2.11.0

