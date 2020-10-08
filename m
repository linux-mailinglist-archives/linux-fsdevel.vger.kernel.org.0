Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E016328701A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgJHHzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgJHHyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:54:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BFC0613D3;
        Thu,  8 Oct 2020 00:54:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so3296584pfo.12;
        Thu, 08 Oct 2020 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IEHhXQUdY1ZNSJ6cw3hAQj1j8oPXbE4ltFHOuzAEm/k=;
        b=NYkyGdYYBu2sahdkP3l459Nd8euDPH28LupNgJ0OWQcTZQwjp/PhiM/4h1TJ5gx3gq
         b41NeP0TNtOBG5zqIdShwail8eMLCKNazBvRAPChNLIBefQyGiguYt0zP3kD3PGdXC5e
         gnUbY82y+GsG7YD/z91+bF/ZrBRE2twZmTBpIJzcUzaf4kG+9QCL3Ng8+SKLwLrknZ6b
         KMyAB901/+dVpdYMDm0f/UyxXCABztevhmhXbJeu41BjyzipwOvZWHmfHqVW9wkd+tCe
         2BLv9OLJO4RF7vReMUHxtZjapseku4xEx6hI/gO7ruPwQlmZ5pgIwTRffBJ0ZIb9qYqz
         dq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IEHhXQUdY1ZNSJ6cw3hAQj1j8oPXbE4ltFHOuzAEm/k=;
        b=hoeL3g2tTHGVW+qQ1suhWO4J7pzmV12k6cKCmsothBuVbKM3RTcBVv6wrqZhq/O0qT
         L/JSD7EbvBZtWMppp6CMdst1OiD5/RQbiZHUzzLC/qUJhmBfFIoHLo9U/dZJDANbj4JJ
         +mv/0m9KC3dFycXv9CaONx9cE9MOhZpRuyqSUceuuNEtiXP6AfCz4FpgAbsAMeJDG/z0
         MQVHvSw0+WQjKfkEsXyulvkEKkYDpasrRF+NBiAhXhLBRALZq3z00fLrAEy/5J6uDrIB
         mKI0sKfZZGfU6s+zAjTBH4kPoJhlj8qKI83VqQ/fSsVgj410n8LaWjXt6BOjLet8jvq/
         MDhQ==
X-Gm-Message-State: AOAM5308i2ZUCEGvF2GluypuW4Xn6y90LioegmdYA/XVFwp19SdcC39w
        brBlzCmWZFWvcg4LDJsyWwc=
X-Google-Smtp-Source: ABdhPJw4ya66Pmv8cUGWpsNxBGAxWYEcWj94HSID9RKL8qBVRY4KlAMcSwWGEk2h7qmlCK1fhYxgPg==
X-Received: by 2002:a17:90a:cf8b:: with SMTP id i11mr7006668pju.181.1602143689231;
        Thu, 08 Oct 2020 00:54:49 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:54:48 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
Subject: [PATCH 14/35] mm, dmem: dmem-pmd vs thp-pmd
Date:   Thu,  8 Oct 2020 15:54:04 +0800
Message-Id: <ba67a6820a16327db236bd2217344a01b24645a2.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

A dmem huge page is ultimately not a transparent huge page. As we
decided to use pmd_special() to distinguish dmem-pmd from thp-pmd,
we should make some slightly different semantics between pmd_special()
and pmd_trans_huge(), just as pmd_devmap() in upstream. This distinction
is especially important in some mm-core paths such as zap_pmd_range().

Explicitly mark the pmd_trans_huge() helpers that dmem needs by adding
pmd_special() checks. This method could be reused in many mm-core paths.

Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 arch/x86/include/asm/pgtable.h | 10 +++++++++-
 include/linux/pgtable.h        |  5 +++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ea4554a728bc..e29601cad384 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -260,7 +260,7 @@ static inline int pmd_large(pmd_t pte)
 /* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
-	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
+	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP|_PAGE_DMEM)) == _PAGE_PSE;
 }
 
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
@@ -276,6 +276,14 @@ static inline int has_transparent_hugepage(void)
 	return boot_cpu_has(X86_FEATURE_PSE);
 }
 
+#ifdef CONFIG_ARCH_HAS_PTE_DMEM
+static inline int pmd_special(pmd_t pmd)
+{
+	return (pmd_val(pmd) & (_PAGE_SPECIAL | _PAGE_DMEM)) ==
+		(_PAGE_SPECIAL | _PAGE_DMEM);
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_PTE_DEVMAP
 static inline int pmd_devmap(pmd_t pmd)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 45d4c4a3e519..1fe8546c0a7c 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1134,6 +1134,11 @@ static inline pmd_t pmd_mkdmem(pmd_t pmd)
 {
 	return pmd;
 }
+
+static inline int pmd_special(pmd_t pmd)
+{
+	return 0;
+}
 #endif
 
 #ifndef pmd_read_atomic
-- 
2.28.0

