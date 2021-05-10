Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7F377A60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 05:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhEJDF5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhEJDFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 23:05:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FEAC061573
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 May 2021 20:04:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p17so8935920pjz.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 May 2021 20:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BA9668HKYYv/ZfHQYvSqaMfgafLjye+7vnvy7Bq3uRE=;
        b=060tWM4SknVVj4PmMYSQ2IxObhiNmRqo7ozdaznfhk5TRXMe+OlBoY7QnoM4gImwsq
         vWlOaoTlZ3hnlngqYG4L9EL/7ZKL/dYFU7PteKGHeH7K9IjzKhDWbkejlSLwViZdcAoC
         YdaLNuDuToJGC4xCduGOEuRuKDPzeo21WdQLqV5Wscuhmit9WYmZq+nD9wP/gAFpc/pb
         oxYK6qhkVaEvINiJLaVqx5cUB68Cl/bDlX85OgJkXi0luSpbJs+XcdAGMgM+LjbjjaK4
         aqS+O70GkVyIf2sJfVnylcJ6j3aaT0eDHvZVziaBP5vsO/7NrlP+3FJtaRhnbF4gfwPT
         lu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BA9668HKYYv/ZfHQYvSqaMfgafLjye+7vnvy7Bq3uRE=;
        b=q1G5C+4vFpkc4pu8Ra5iGnpv8sZLL3mUfrRoc/0TqdSCPeeBe6j3NMkPlZWtbTa+1s
         6GFRX0PyGQpfx+aYeewY9Z82ezWmDKYL/qJukyNeFFOf7C34XQ4OKpMuAoMec+Dhghsu
         07ZCCgG+bjhj/EzSTUy6Hq/oTpzAL0OJe/OICyraE1likk8IpQnHN+tgAPo1x3BJJz+a
         zKO4BgM4qWZxrQ1I47DUneTxn6nNg9mwjY6ygixRtLUShOYlZWWPChi8xCLLMaiwpghX
         bYvzYLktHVl5KjIU1K3tH/uKlMIqfPAuuTRg8Vgy+GBGCYH6GlEm5jHD3Fle2eq0vDNw
         QNlA==
X-Gm-Message-State: AOAM531l4kIRqBPJoYwjYqIbl6Amo8Ru1OJHoF4BD1grwpj9y5U5p3Wd
        ws4TObohP1aT/udAdHlBsZS8JQ==
X-Google-Smtp-Source: ABdhPJyzbfdoceM7SMsg+3bcIByNqDvgId/AGxhociSIphuZ5UjakQIa6i0VPIDJp7E4KNdH7dm8hw==
X-Received: by 2002:a17:902:b28b:b029:ed:19aa:5dec with SMTP id u11-20020a170902b28bb02900ed19aa5decmr22866273plr.78.1620615890445;
        Sun, 09 May 2021 20:04:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id a128sm9777003pfd.115.2021.05.09.20.04.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 May 2021 20:04:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v23 8/9] mm: memory_hotplug: disable memmap_on_memory when hugetlb_free_vmemmap enabled
Date:   Mon, 10 May 2021 11:00:26 +0800
Message-Id: <20210510030027.56044-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210510030027.56044-1-songmuchun@bytedance.com>
References: <20210510030027.56044-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The parameter of memory_hotplug.memmap_on_memory is not compatible with
hugetlb_free_vmemmap. So disable it when hugetlb_free_vmemmap is
enabled.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
 drivers/acpi/acpi_memhotplug.c                  | 1 +
 mm/memory_hotplug.c                             | 1 +
 3 files changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3cc19cb78b85..8181345e996a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1638,6 +1638,10 @@
 			on:  enable the feature
 			off: disable the feature
 
+			This is not compatible with memory_hotplug.memmap_on_memory.
+			If both parameters are enabled, hugetlb_free_vmemmap takes
+			precedence over memory_hotplug.memmap_on_memory.
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
@@ -2904,6 +2908,10 @@
 			Note that even when enabled, there are a few cases where
 			the feature is not effective.
 
+			This is not compatible with hugetlb_free_vmemmap. If
+			both parameters are enabled, hugetlb_free_vmemmap takes
+			precedence over memory_hotplug.memmap_on_memory.
+
 	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 8cc195c4c861..0d7f595ee441 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -15,6 +15,7 @@
 #include <linux/acpi.h>
 #include <linux/memory.h>
 #include <linux/memory_hotplug.h>
+#include <linux/hugetlb.h>
 
 #include "internal.h"
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 16b3a7a1db8c..6512e6f641bb 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1052,6 +1052,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       populate a single PMD.
 	 */
 	return memmap_on_memory &&
+	       !is_hugetlb_free_vmemmap_enabled() &&
 	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-- 
2.11.0

