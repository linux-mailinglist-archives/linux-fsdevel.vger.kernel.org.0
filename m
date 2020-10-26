Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306EC29902D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 15:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782660AbgJZOzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 10:55:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38950 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782655AbgJZOzQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:55:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id o7so6204283pgv.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mpciXNwuWcA5SxSfqhs9A4AXvA+acZr3rKf1/b+yZ4=;
        b=wxpBUBnO46XYx1IyrgXw8jKQbFTfCS8wmkAHMTfSnaTjj3luNYlMLPhMZetrgkwfvx
         macN5wvljeYhYqBA560CER6ZjGtMQvNn1j9+UjUuaRdetFNulNxaYRbh1j66KudSwQWI
         eDRXiIwG2Hht2uvTqtKe1iUTUE5PVzZy/hVr9ipDqvXbcxEryyzfHe7RnNsDVEEJ95v+
         lENGhvYH7S9+Jx72NaLpfo5QBPozjAIpU8u7V3pgpFLztrajR3ZMBMYE3IH+s5dtvJKN
         b8n3nFPnhOcCmq4Kf67F8IzSHOhCHkw3I5af0KzOV1gYUDtfBFis0u1qwULZH00Sn4f3
         WNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mpciXNwuWcA5SxSfqhs9A4AXvA+acZr3rKf1/b+yZ4=;
        b=AGvqaJgD0h2qRXikXHonXfqhR8VdP7+WDf8vESfQOPVM7RbzaJibTnB9KhBkhBr3y/
         ooO2O044zlTOBaRwXVR8pvYaXG+jaCObYJl/gv5UIV2W3z6UbFMfpt61UCpA4+wabCWF
         eGqfa3jm+Kvv0zLk09+JcHI66YpbbOvZZIWk/EHaW6RKL4/XnqYPWLTVmHbL9BTwpchN
         xCgMIqs6CgGHdSgbtHjzJfEgIbfaxYrLk13aga5gtNB1XcPIBI40hfSDXKW1zanitkXP
         qAxxCv3L+OTeZzPH3t6UTJtQTIBY+M2m+CREefBQOtYUV205dCqbhCRJd1VnaDK+yIOe
         ulBA==
X-Gm-Message-State: AOAM530iagKlWGQnoPOp5kdMv72R+/aOUY0wFKTLxql59EilieS0eZdc
        S30mlZygXjygMiuRmbe/ct2ZIg==
X-Google-Smtp-Source: ABdhPJyrrJjqBxDZ4gmy4W3o6g0P8TouDAMt8VykFlzg75jHTBFST4T1YJx4SFz6D7HN8IASwdyp1A==
X-Received: by 2002:a65:508a:: with SMTP id r10mr17564254pgp.307.1603724115200;
        Mon, 26 Oct 2020 07:55:15 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.55.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:55:14 -0700 (PDT)
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
Subject: [PATCH v2 13/19] mm/hugetlb: Add a BUILD_BUG_ON to check if struct page size is a power of two
Date:   Mon, 26 Oct 2020 22:51:08 +0800
Message-Id: <20201026145114.59424-14-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We only can free the unused vmemmap to the buddy system when the
size of struct page is a power of two. So add a BUILD_BUG_ON to
check the illegal case.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d98b55ad1a90..e3209fd2e6b2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3776,6 +3776,10 @@ static int __init hugetlb_init(void)
 {
 	int i;
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	BUILD_BUG_ON_NOT_POWER_OF_2(sizeof(struct page));
+#endif
+
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
 			pr_warn("HugeTLB: huge pages not supported, ignoring associated command-line parameters\n");
-- 
2.20.1

