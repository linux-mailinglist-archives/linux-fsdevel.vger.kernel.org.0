Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B290D70DEA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjEWOIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbjEWOHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:07:24 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315CDE59
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:58 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso8197618e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850756; x=1687442756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=721W88MgL2sNJMPnk6EOnDreN0TGHiKcLljkK4k+Xz4=;
        b=fzeFctH+wspWO49TnIPElwVca6DLjWLQwYxkWmX/Iy1UmULCTqkJMiM0qA8MXZ/96E
         Dtzvq/Nx1wNuktXBNrc7rb+BddK3eOpeRmaIEM+nRheV+Bmapv0H53LUZOJqTGNjV3bP
         zWDe7Noi+kppHqm/7HwhlAvjZPM0NdHk76Cr/uat1pZJDm0mz4HCGb4uRkPCQwNqiDYu
         JW0aKwNZrkes49GmhKEiOFOCDjns4pmVJcNZeTw7Y/+UpIuTv7ewPTXRg18mgR0J2Qx3
         I7hqjEkHLpYieL/NE9aRDNlp28sfW4e7RnZIt0ZnBTCL9b1MxLrV2Xk0Mrq3ZmPvUUoO
         qQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850756; x=1687442756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=721W88MgL2sNJMPnk6EOnDreN0TGHiKcLljkK4k+Xz4=;
        b=cYgqhcwuu4HWfES1jI+lc9kjE+CUaymLq6A7092XyA2x8lPqk+k2sRE+sXd59az1vN
         gxVhKl8s7bfzdThZHCRnnaLXzf2TAV0P+IV5hj/TPAUEwy11LGp6inBRn98Riz8+EXaS
         x43I41mZNYFBtnoCneYAixNzlLhGRI3UHQStWSoK38mFCafOi7lRc65WJTQ5rLWjaUhf
         okGjHf+k9cdAN5waTZljsITwSVfEmFLL+HE7RkVacC+RVSlvr1Og7v4TBj0vuqBux05G
         XSEHAoEFucDyKDOvbwAbWWdcygDZkgtpkcEHRd+e2rYNGgo6oENqBIsuMQ6tNJU5ulAm
         nL3A==
X-Gm-Message-State: AC+VfDyXvpafdKvvvPPrIRhQ8AioM1EilVMEuldy3UNCUET6zMu0U/+8
        2aF9//du7qQ8hwKpmT+5dU/0Lw==
X-Google-Smtp-Source: ACHHUZ5UFM6na3wkD054/zYIWV2BKg/wO+VAD3UUEzInrp7pevvoaoeYweWFaAj8kQad51xlmVIoxg==
X-Received: by 2002:ac2:44c8:0:b0:4f1:b3ab:cd61 with SMTP id d8-20020ac244c8000000b004f1b3abcd61mr3958413lfm.61.1684850756424;
        Tue, 23 May 2023 07:05:56 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:56 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:35 +0200
Subject: [PATCH v3 11/12] arm64: memory: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-11-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

Since arm64 is using <asm-generic/memory_model.h> to provide
__phys_to_pfn() we need to move the inclusion of that header
up, so we can resolve the static inline at compile time.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/include/asm/memory.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c735afdf639b..4d85212b622e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -331,6 +331,14 @@ static inline void *phys_to_virt(phys_addr_t x)
 	return (void *)(__phys_to_virt(x));
 }
 
+/* Needed already here for resolving __phys_to_pfn() in virt_to_pfn() */
+#include <asm-generic/memory_model.h>
+
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __phys_to_pfn(virt_to_phys(kaddr));
+}
+
 /*
  * Drivers should NOT use these either.
  */
@@ -339,7 +347,6 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define __pa_nodebug(x)		__virt_to_phys_nodebug((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
-#define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
 /*

-- 
2.34.1

