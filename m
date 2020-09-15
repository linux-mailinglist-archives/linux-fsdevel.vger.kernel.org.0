Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0876726B86A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIPAnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIONB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:01:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA98C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bg9so1306418plb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1xA5Zo5Cz4t/QRWNMyKZ9/SLQQOd42+iCFRWcfd6Pao=;
        b=oRGDCwZRQ6h95N0FMYtWzeohLlxHf+tvqEMCR9b+bfmN66PI1duhmvDTZ8TlGCuBHs
         /MUW77EE7IDPPQ/0AJNYfbVfTyC4PmWmB4Iu5c//emNCMvApNE9v6mOvYVb67WYI6WbT
         ahYPJ8GfNIz/CzaXlUSZMFy2zV0hKJWnc2HGmocO952ivhDn594Toa/vhUHzcLL62/1q
         cWq59xzcwSZP1FjMei3f89Z8couHpG2Jb9pw6CjMiEmP55LSQ6Zj6vQzJWa6tvYRvoEs
         jJIQ8TWzLaWDg/v2TkZGhmpJtexiIzjwW7tJI1av5VPI6OyjBO8dKZcUVr/G9FRgLlCk
         wqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xA5Zo5Cz4t/QRWNMyKZ9/SLQQOd42+iCFRWcfd6Pao=;
        b=CIhmc/+Bzfw451Pmvhi+/lbDvutW4T8Vcl5vPtXPTcOWHwkLkTzIDoI+cK2tWeAEGH
         bnLr+OhkayFa4mDCrDnD1TNai9tl4Nye14KhfkuyLuQBRFhgePp+LRISkmruXXg4iD1N
         9hhkSrM6XqUUd2A6R2ZcqEtCpgQ6j4+iVbprLvxjpYxNx8dhMY8NTg7y9s1LnewOCVD8
         6kLD+LQvSctFQoAtvGUUAksllWN67tHfAKw3hcCnuTHirmDMXyyH8Ej6Kg+IQhNnRgSa
         MghYAhxBQsFrRBqs+Gh+tOq1vwZk5AT00A/chzBBUDV+1994AF+V6aYo11/AzGYBynoO
         0f0Q==
X-Gm-Message-State: AOAM533tozTP4cyDxQcsIvsl15NDtn7awzDSPQKx2NZAJI+Vufzl/Vpe
        5ySBfscTIfke9Y0qGe6Y7jIwew==
X-Google-Smtp-Source: ABdhPJylXgRgPVmLfSJ8EZxe2tlUYRohlc+NN9//Q+cjPIxAl32Wi0QDL88uhLkUFkuCqwNGmR/FBA==
X-Received: by 2002:a17:902:ba83:b029:d1:e5e7:be12 with SMTP id k3-20020a170902ba83b02900d1e5e7be12mr1623727pls.69.1600174915323;
        Tue, 15 Sep 2020 06:01:55 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id w185sm14269855pfc.36.2020.09.15.06.01.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:01:54 -0700 (PDT)
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
Subject: [RFC PATCH 11/24] mm/hugetlb: Add vmemmap_pmd_huge macro for x86
Date:   Tue, 15 Sep 2020 20:59:34 +0800
Message-Id: <20200915125947.26204-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200915125947.26204-1-songmuchun@bytedance.com>
References: <20200915125947.26204-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use pmd_large instead of pmd_huge on x86, so we implement the
vmemmap_pmd_huge macro.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/include/asm/hugetlb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index f5e882f999cd..7c3eb60c2198 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -4,10 +4,17 @@
 
 #include <asm/page.h>
 #include <asm-generic/hugetlb.h>
+#include <asm/pgtable.h>
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 #define VMEMMAP_HPAGE_SHIFT			PMD_SHIFT
 #define arch_vmemmap_support_huge_mapping()	boot_cpu_has(X86_FEATURE_PSE)
+
+#define vmemmap_pmd_huge vmemmap_pmd_huge
+static inline bool vmemmap_pmd_huge(pmd_t *pmd)
+{
+	return pmd_large(*pmd);
+}
 #endif
 
 #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
-- 
2.20.1

