Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F3E330B40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 11:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhCHKcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhCHKcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:32:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B64C061760
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Mar 2021 02:32:11 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id ba1so4674324plb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Mar 2021 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aY0NbnJVPsl42xmrFkENKUxQVxT+8ZIx0+KwbznPFEU=;
        b=RZYYlyssXlfXIz6P+7rhDGXvwv5pwHKFRgNFTb8QAZG3y3UjgqBZGJUPo4kLAGFoWa
         tshCRhjYVGBvFgo4SCl0LiKmZ72SpgchicgPeCpqcrdDP/GcGSvnPthGhGULd2H/an9Z
         5dElejdsPIx6hpbOSkQNAealFTityYUlp68yxl7Atkw/eQxleeWvqFM5dgnwUuTyJ8gM
         RmDNvlpJLR93+NXcay0b4EXQwUdwxxqNaYDcaYFxaKvEmpcS38kqvP0/gm6eqbcdEa1A
         CFp5dIwSLEVR10NuLcPITjkbKQUt8nCqVZ1pzuWt9ZMUEGZdUN5ILydnpynvPUuJZPUq
         ClbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aY0NbnJVPsl42xmrFkENKUxQVxT+8ZIx0+KwbznPFEU=;
        b=rBTKZP5LS5d1NlptFr61LM+DzwhHjKp1XQTQHOhXgvzilc2uMpodYeCnxQNVOvoDe/
         bNPN2cv8/2tAwLzzNMYXJW5JqMXVNBDyemsKbHupQlYMCR7kHpzYGAeHqFvVz/ekd76D
         cU3eYxOvZKGo630SFufTBCXiibd6j1PaKDWahRU3iDr0dVINOGJT5RWY+7WeMOzoRmDU
         nJMbYOREAtrOqJcVpseLkDfUSRFMf2DI8mZiUUh9gtbFldsV449nRgfD57loDvR+SBxP
         j/dkKfTKpF7qzJwL4572oNCLq9WzHYjusSIz/3tVyOQeMkKqB8nTOTk3aT/7AXUzXZvW
         j3fw==
X-Gm-Message-State: AOAM5307PhT0c3Bczgpw6Ih0N2RXT5z4D9LS4t6/Lqm0i7GcpaxX6Hgu
        hVUmFB584XjF0v4dtbAQKXOuZg==
X-Google-Smtp-Source: ABdhPJyzwwbFKyrIViO1Oe9ntT+9Vbs003LaYTiFTB2VyU8H0Osnfkv23J28rce9x477g9COWu+x2A==
X-Received: by 2002:a17:90a:540c:: with SMTP id z12mr23402574pjh.163.1615199531552;
        Mon, 08 Mar 2021 02:32:11 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id ge16sm10744705pjb.43.2021.03.08.02.31.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Mar 2021 02:32:11 -0800 (PST)
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
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v18 9/9] mm: hugetlb: optimize the code with the help of the compiler
Date:   Mon,  8 Mar 2021 18:28:07 +0800
Message-Id: <20210308102807.59745-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210308102807.59745-1-songmuchun@bytedance.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
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
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
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

