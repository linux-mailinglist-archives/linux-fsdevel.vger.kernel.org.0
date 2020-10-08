Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6474287057
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgJHH5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgJHHzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:55:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63774C0613D5;
        Thu,  8 Oct 2020 00:55:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so3596156pgk.4;
        Thu, 08 Oct 2020 00:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q63UGNU50PxJwBeAw35OlXFM2zT0ydG7N+0qP8I/gHo=;
        b=SQ2f9dH1UsoGi1f/XZ7ldaen6tWpM4BB3XGMmJ7K/NG22QSMmTLZu6+XrO8owZNNCA
         Sag8KMDiI/xIiMonNj2iFUHigJcVao+uCWBhgm2p9aLuin9Lp9hRdEJEtTpqu9oNuo2x
         nLMeX5Z+LjndXkm7XET64/pO6fW7Hmid8g0nOkftuuslqiWXTlOPP/+D5mnT56ARk4Sl
         FBI3YJulFj83gaDSMHT4/GS3HBbcLKb8v8f+CdQ4co7oFUQEyPk1L3foWAcn+VyVhAl5
         cIJrejQMadXEQC6kWkYMlQNj9k4aNiM5cVwDpsCbhpNTSQ09QMLbQGkpsg8ku5AjhKsZ
         KIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q63UGNU50PxJwBeAw35OlXFM2zT0ydG7N+0qP8I/gHo=;
        b=fetPs220nvH1vHD6nZpkyVd74iLFO92IHsNnwc1hwOG97j4qFWMp7X9Le08aFDbGAs
         0jBKvKIpgsA/MUpa0oss3WQA0E1E5gi7E29VjdwkIQIXaAroU+M9hg/3k1+zZIfEdcwV
         83PQdhXqJXkjGys3GRn72E3PFvZzDp9AfUEm0h8vdXC8BF6aid6kvCyCUrULhk1eMmW5
         ogWa+PehnDawNfYWufdPqAa9O4chOfkA5JVLKmnXVNDiyXa4vVEWiVDS07BuQVJl8WN8
         /iJTDa2OQc6vTYAVWge8uwnNrHAOdo+yLaxPliVKGfcbYAXd/dHyBg3hx8jW1tAGBjeA
         gveg==
X-Gm-Message-State: AOAM533x/TIXAupN/TW6Z6scFKXxYKnNMNOwsFHUgNuVUQuVCRK9lHO+
        SXE5gkN7IxyVPND5HYktRBA=
X-Google-Smtp-Source: ABdhPJxpDi+MtXox+1vt3agOi/zxClZUn41exKjvJWiEd5KpI2sW06SKrQRX7PWXhlZeBzN93ix7PA==
X-Received: by 2002:a17:90a:a88:: with SMTP id 8mr6844949pjw.105.1602143723037;
        Thu, 08 Oct 2020 00:55:23 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:55:22 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 22/35] kvm, x86: Distinguish dmemfs page from mmio page
Date:   Thu,  8 Oct 2020 15:54:12 +0800
Message-Id: <b2b6837785f6786575823c919788464373d3ee05.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Dmem page is pfn invalid but not mmio. Support cacheable
dmem page for kvm.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/kvm/mmu/mmu.c | 5 +++--
 include/linux/dmem.h   | 7 +++++++
 mm/dmem.c              | 7 +++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 71aa3da2a0b7..0115c1767063 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -41,6 +41,7 @@
 #include <linux/hash.h>
 #include <linux/kern_levels.h>
 #include <linux/kthread.h>
+#include <linux/dmem.h>
 
 #include <asm/page.h>
 #include <asm/memtype.h>
@@ -2962,9 +2963,9 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 			 */
 			(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
 
-	return !e820__mapped_raw_any(pfn_to_hpa(pfn),
+	return (!e820__mapped_raw_any(pfn_to_hpa(pfn),
 				     pfn_to_hpa(pfn + 1) - 1,
-				     E820_TYPE_RAM);
+				     E820_TYPE_RAM)) || (!is_dmem_pfn(pfn));
 }
 
 /* Bits which may be returned by set_spte() */
diff --git a/include/linux/dmem.h b/include/linux/dmem.h
index 8682d63ed43a..59d3ef14fe42 100644
--- a/include/linux/dmem.h
+++ b/include/linux/dmem.h
@@ -19,11 +19,18 @@ dmem_alloc_pages_vma(struct vm_area_struct *vma, unsigned long addr,
 		     unsigned int try_max, unsigned int *result_nr);
 
 void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr);
+bool is_dmem_pfn(unsigned long pfn);
 #define dmem_free_page(addr)	dmem_free_pages(addr, 1)
 #else
 static inline int dmem_reserve_init(void)
 {
 	return 0;
 }
+
+static inline bool is_dmem_pfn(unsigned long pfn)
+{
+	return 0;
+}
+
 #endif
 #endif	/* _LINUX_DMEM_H */
diff --git a/mm/dmem.c b/mm/dmem.c
index 2e61dbddbc62..eb6df7059cf0 100644
--- a/mm/dmem.c
+++ b/mm/dmem.c
@@ -972,3 +972,10 @@ void dmem_free_pages(phys_addr_t addr, unsigned int dpages_nr)
 }
 EXPORT_SYMBOL(dmem_free_pages);
 
+bool is_dmem_pfn(unsigned long pfn)
+{
+	struct dmem_node *dnode;
+
+	return !!find_dmem_region(__pfn_to_phys(pfn), &dnode);
+}
+EXPORT_SYMBOL(is_dmem_pfn);
-- 
2.28.0

