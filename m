Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4E86FF0EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjEKMBN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbjEKMAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 08:00:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D54D053
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f26f437b30so501327e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806397; x=1686398397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJU163QagIQsrvP5Rw+8jaAtPEKkrWxHz6dgH9Ny+pM=;
        b=OVzygYKFGH1TTuxbFUj+CoSj3NrTaizXuR71JpjrxDkWl2PVUYhH5JT70fm6co/+NH
         tgSpK7iB7XOIFx/oZ27wrlRvxiiOU0TkhphL4Cjxz38b+G77ryH+u4qiryaQVZOcLNF0
         H0/G73Db2ZLdNZ+R+FwIBPtPTT8FO9chca9MkRhxDx0g0MNcweB6mimyP670IWhPwMJJ
         Zi33byy7BPYmwDP7tGDqy3rZxw7unhbkfjS7DQcxkZzUfpvfhpgVrM2yoH5+zUDj/FTE
         k6lQKniemblf8dnVu3vStZsdx03og3rxM39S2DuvQLZfuDbOnEOTZqUyvlVqW9qAn7Vc
         1b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806397; x=1686398397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJU163QagIQsrvP5Rw+8jaAtPEKkrWxHz6dgH9Ny+pM=;
        b=Oo4dDFoCiwCo9QQSpI9z5fK2oElxp8pKLh/gvELz6mZLJX88JRh7wy5xowQczOV3nR
         Pa6+S+EhOcdK0UfAoiz1wisM9qJntBNYFtMvFCs/WHw50bXIHZkccSJgRX/Qv7u1zu8e
         zvA6a7IXqBu5hME0McXLg9h2J+UeckyMxm3UQtMS8vlqyWyQ3xVHgjZLy466csEedGkM
         vYS7nRDl53XGAzNFwOixt5wwzWFNxxxAlP21crhOoT042tHJgd92U+SG0Kz8hQRCEltR
         Uh+sLY0DaRRo8L2qo69D3knlfgfOC/PbPHBlbNOJcaNwODTUImgkASX+ulKNSfZm28k1
         NrUQ==
X-Gm-Message-State: AC+VfDyeA+gmNqYayphIz0ofGKnFDWfho9Px1A/02D26fJi/cUIHj1Ek
        D63PdpIgE5IbIca2sSTfAOndCQ==
X-Google-Smtp-Source: ACHHUZ7ZE/nf3YvAX+fWh9Dbm/hshMVwzXisVNx+UvqRN2YZL2q+Z1orbXsbt6AiZ+R2G9hM4ez+dQ==
X-Received: by 2002:a19:ad43:0:b0:4ef:d5fb:c37c with SMTP id s3-20020a19ad43000000b004efd5fbc37cmr2214552lfd.69.1683806397378;
        Thu, 11 May 2023 04:59:57 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:57 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:28 +0200
Subject: [PATCH 11/12] arm64: memory: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-11-6c4698dcf9c8@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

