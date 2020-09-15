Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6526B85A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIPAmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIONC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2212C061351
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x123so1890170pfc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNchCXlujHVbLKrDly+nb0OZuzhDeUp4zy0iJXX+zts=;
        b=lc0/0lOXMXW6CqInlrV1vRTsQtfbMiUBOwP4cPSQ/2UvctoSkPq85BGm4npwx+3wUc
         VqUklikLospgrLDQ4wlW3z7rPyOBrciyG1K0DugATR9FIHAYeCTZSiXDv5SOiU8HNN4e
         z2S6v7c0SeINkiwtNed/vqPdtCGDDopnBEbxbRUw/oWYqcgtnq9kg/b1BUUAABcHlhTb
         rDilY8ZLwf2qRc9VvcjtsCtmKcBoZ5vkzsG7FvnWeB2eqtXZGodOHGHj9GslKqG4bjbz
         DcbPgKTU/Gucf9acbpdx0Zpf0x9H+UEafA7kwQVLDGAd7Ilj/oVoLIVGpKR30LL2G/7m
         Bspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNchCXlujHVbLKrDly+nb0OZuzhDeUp4zy0iJXX+zts=;
        b=VOIs0vg8201a8acOgsltrJNxX3wEP/rAMrnitrd7tdkSuyZIO2DA2Hgte3OqkWgthD
         XcbYFRXyvGoPyjgElaolUbTo4LV/mVxFeOx7FxhmlPWeStxJjPpEzCNaTTJDOzKy+rta
         KzwF/H4EKLxS4exR6WStnqZVk6A9wrNXMNwiTTvaieVJAQhtaXUvQF3CbNmJfP43K7EF
         dN0M3IcfOBWrSTdFY3SjjRattzcoRjcmI9LzyBrqgnsEh4FmYD8+B6cm/FfFi7ifRQQq
         u1Xfp715A111RyQJEw6mcY3zvahyoyzCj15rlm7rHR1M/S8kDwuSHHOTVnByutzFwOcp
         iTfA==
X-Gm-Message-State: AOAM532kBTfhZRr35dTMGeU/nHdvJKo7RUtslEnBGdV/Jp+vPPOm/ui0
        mqxa0gL6vdFUqGoYp7h0C9vtuw==
X-Google-Smtp-Source: ABdhPJwmk58xJFs7bVQwlQ8TOo6QNgpQumZzCogF3iD2x+NuPWVnOo/NDEmSo5qdwcLGuncUFiCQYA==
X-Received: by 2002:a62:7ed5:0:b029:13e:d13d:a086 with SMTP id z204-20020a627ed50000b029013ed13da086mr17607925pfc.29.1600174975269;
        Tue, 15 Sep 2020 06:02:55 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.02.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:54 -0700 (PDT)
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
Subject: [RFC PATCH 17/24] mm/hugetlb: Add a BUILD_BUG_ON to check if struct page size is a power of two
Date:   Tue, 15 Sep 2020 20:59:40 +0800
Message-Id: <20200915125947.26204-18-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
index 7072b849af3d..34706cec21ec 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3817,6 +3817,10 @@ static int __init hugetlb_init(void)
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

