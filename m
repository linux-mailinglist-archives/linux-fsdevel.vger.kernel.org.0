Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C753026A5CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgIONBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgIONAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:00:51 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B06C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:00:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so1304951pll.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ph9Npx9Sc9T0289Sa+bHIQdTtsrfAT1jO6vE3p2NbQA=;
        b=KJWEmRh74MpS+BiJEmcfSUmams10jgYpmHOWHONrwDWFrjooYDHDyiRYhnMnOh+VvH
         Ty93H0BLab/qOFPkqwZAtkalYiEKAswo3uakzsrS4kepjFgxSQ7RsNb+5LEwpn8pOIlN
         8WcE6SBqdZ+KTgt/ZnU7xAqtXD29FYuKipqzPasecDeZxF2J000H2LHOEUoixY8onUxu
         xyW8ouRBL6mMCL9OCt2RVqaWSXtWesOFCJr0BX/OD1P83WlHpuvpzIBMSm3WVbYbesrO
         2qFxvf8ijooHQImhd2dzz/2SA1y0avrE1ON/+PxTnAASjGYoGYzX2ETddAO+mnNasE+B
         /zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ph9Npx9Sc9T0289Sa+bHIQdTtsrfAT1jO6vE3p2NbQA=;
        b=BvftJADikB1xp6gp1bzOm6gZb2rHJ/t0XERejVTeBREOglXaPTvM7Pz2tcdrR1JUjh
         MK54QrX7D06TGYH3RKFpbHl0DtF9oxUdCEca4Zq/h+zEQPul0cDHWrzgnbahBg+IWgj0
         Xn/gAjKu+G0W1dnv11n+AhdkLoIMkXWSabTwRm+ZuNrqpP3ASpFb1pfwinzGu3M1IMgj
         MEILbmQevZB8jpjrPh+ko8Vc1fxcl568B3z6cHrJdhUb5S4oFxXH0RZm1QIDNVbCsWUS
         SX9Fz9K3Y1SitGzM/mAja+fRXJ1YWZ4UtIqDnEAplyV+QDVENTQPJCuOmXFL5kJEaEx/
         67dQ==
X-Gm-Message-State: AOAM5321S8SK4sAfzSYHsBH2y35hJt7hQyV6rEeAjpLZrhKwmEXOhPOV
        iwOl1euWjow0rpkWAssYTEUkdA==
X-Google-Smtp-Source: ABdhPJwLaJ+aIVCorogq2CdD6Jk2kg3Rfgolvi723baFH8rkm/8wVxPlvYY+XFAEuzspsZb0g54KWg==
X-Received: by 2002:a17:90a:1548:: with SMTP id y8mr3968874pja.113.1600174848501;
        Tue, 15 Sep 2020 06:00:48 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.00.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:00:47 -0700 (PDT)
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
Subject: [RFC PATCH 04/24] mm/hugetlb: Register bootmem info when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
Date:   Tue, 15 Sep 2020 20:59:27 +0800
Message-Id: <20200915125947.26204-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use put_page_bootmem() to free the unused vmemmap pages associated with
each hugetlb page, so we need register bootmem info in advance, even if
!CONFIG_NUMA.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0a45f062826e..0435bee2e172 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1225,7 +1225,7 @@ static struct kcore_list kcore_vsyscall;
 
 static void __init register_page_bootmem_info(void)
 {
-#ifdef CONFIG_NUMA
+#if defined(CONFIG_NUMA) || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
 	int i;
 
 	for_each_online_node(i)
-- 
2.20.1

