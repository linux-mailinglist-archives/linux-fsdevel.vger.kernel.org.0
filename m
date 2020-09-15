Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDD26A5CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgIONBu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 09:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgIONAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:00:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE18AC061355
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:00:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d9so1901088pfd.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKZjA2WR/MuI4xnBSdt7iJDqwitKA94z026RIC3Xp+k=;
        b=TPZHG4d9thnMIaeHQMiw11eDPphSU9QQLKK161nNllaQuX7diistYPpLf5nXLM474H
         dcvgWwtXeY7lLIcB2GIZMFyvZBSaheAlDnFLWsTq6LDwMEziKoiqBiWsxQcJ2NTSmUdN
         b//8QI1aA2VOfpnCItZ3RCHeMR61GcQ62VXf6H+1ShMG4qMYxz+6TdXxN3xrmupVXOdO
         KObrLikmjbeUN3lxbQ09j25BtM3g3Fjs7PIdnV/9xYQGJcwiqO8TLLXi4jGBdBwww1Pe
         U1ixG1aXNbnmG7ln03iol/QRKEkZJFO6/xtH0RWCuzSW9V5Wz4NLkvkO6vyHvw5IqTYJ
         Yrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKZjA2WR/MuI4xnBSdt7iJDqwitKA94z026RIC3Xp+k=;
        b=WvpzvGjxldrm/312NwIwgoQZBOWlVX2pORDRFxErYmXtdBrbwNo2fml5zo3eBdyj+n
         ndf50lZ81lirnB7vDv8Xq1zDFZkeQZz1WhNTJIp1a3nmfnf4+eIg8rakkOijUfCIsTr7
         n/quKQnQjJUWBLWnrJDfU2HScxVYcXJcoLJ7OU4wdUb7mi21UNaf63416RDEr+QxT3yD
         2ABLR452Vkqx14kQcgH6sU025JbRrWT6bLlf3rMhdenr4NTBhKuM0MqI+SLJccAz8acp
         cTg4iJzL+X8qcraicTeFp9xeLMMyV/W+0oBXQPqQ8bfqo8fmvqCucTLfXqLeR+peBkOu
         GecA==
X-Gm-Message-State: AOAM5313M+L2XNJpCnUQ3mWJl4kd8TUVyo23sEXFBNByNq62FpudgTO4
        C1gon1GuNFDr0EJpB8cjndBShw==
X-Google-Smtp-Source: ABdhPJxZZ9ygdTPbozDf1+EUar6et0CWIkjxwPo6KIduNnqBdi+TNOPMzVwjrdBNCWrgb7wYvkHqvQ==
X-Received: by 2002:a62:178d:0:b029:13e:d13d:a0f8 with SMTP id 135-20020a62178d0000b029013ed13da0f8mr18083078pfx.20.1600174838496;
        Tue, 15 Sep 2020 06:00:38 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.00.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:00:38 -0700 (PDT)
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
Subject: [RFC PATCH 03/24] mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
Date:   Tue, 15 Sep 2020 20:59:26 +0800
Message-Id: <20200915125947.26204-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The purpose of introducing HUGETLB_PAGE_FREE_VMEMMAP is to configure
whether to enable the feature of freeing unused vmemmap associated
with HugeTLB pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 976e8b9033c4..61e9c08096ca 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,6 +245,21 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+config HUGETLB_PAGE_FREE_VMEMMAP
+	bool "Free unused vmemmap associated with HugeTLB pages"
+	default n
+	depends on HUGETLB_PAGE
+	depends on SPARSEMEM_VMEMMAP
+	depends on HAVE_BOOTMEM_INFO_NODE
+	help
+	  There are many struct page structure associated with each HugeTLB
+	  page. But we only use a few struct page structure. In this case,
+	  it waste some memory. It is better to free the unused struct page
+	  structures to buddy system which can save some memory. For
+	  architectures that support it, say Y here.
+
+	  If unsure, say N.
+
 config MEMFD_CREATE
 	def_bool TMPFS || HUGETLBFS
 
-- 
2.20.1

