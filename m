Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9546FF0EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjEKMBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 08:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbjEKMAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 08:00:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4F3901F
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f22908a082so6545671e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806395; x=1686398395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldVw9wlzEkzEKLn5PMVleGqWnYMQxC7MlxWwEOwXVk4=;
        b=sersNdtzW5iLzGVupNMmSJvBYmwrZ//xZBxoOUDkXI1JTW4CI6ctj4FhudGratDn9k
         cRnkGze5UhsFvb3lR7Z7ykzxMMc0MSELwIy7erx+30m7guaXslAKu512vsaLide2fBN8
         bzO6LMr/4P01YQk5JchLInzlvvtZaYnfs9CHAIEYLUvt9rNDqzoX36kf+ZRPAeMUF63R
         CCLsu72Nt/qnplWuj/eGGivCt82mEPHLpvvAQfOpT7G7x9ZKs78aN4p4kFH/Q3ORHnfo
         F+xP25avZTDsQROtfUVMJN8MesmV4EWv4hDtLKEn2U2w6S7bTHItXBK0WvgvggA3JEzW
         4KRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806395; x=1686398395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldVw9wlzEkzEKLn5PMVleGqWnYMQxC7MlxWwEOwXVk4=;
        b=AL0/xdOfixO78xX0pZRjdLtrgfa3ODX7rkAzZS+UA7ugm8BgiVK1Tbv51XBcDUV0eC
         C8A+0YnWR8JfS8BOsItz++ZxS0Htry+mpho28i8duxDnzDFPqa3WY8BZ09mrH5skqlAH
         hBaipZC42tvLAQOi2vcclCbh+vjiI+oxQMznX7ShBtUGjj1EDK8BXub94GLwmmWcV8eG
         jwywpod3QL4WirduRomcTIl2wWlXveTHUFZdz4l9oZNkcVpFKlwTg0uto4JyAoPjb8I0
         udssiKGL6vUWSi9cnnZm2v+qwwUFlxRGNbRvrZXjQNy20ACRwzkE1IaTRI1553sr5jA0
         5nNQ==
X-Gm-Message-State: AC+VfDwRbiFIDdwOcfUPcwnie6TvFBEvug0XankUT2Ob+5YIZTG9SljX
        fK2Cz2kUpP3jvQuLE9SDOMB+xA==
X-Google-Smtp-Source: ACHHUZ6cUHNYU0J4SZMS7pZsEER32rUvhWP5SmpZGGTwBMJBiTrayLkP7UYjW+7FVQQ8Tu7K7BVxbQ==
X-Received: by 2002:ac2:5339:0:b0:4ef:f725:ae2f with SMTP id f25-20020ac25339000000b004eff725ae2fmr3438930lfh.37.1683806395538;
        Thu, 11 May 2023 04:59:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:55 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:26 +0200
Subject: [PATCH 09/12] asm-generic/page.h: Make pfn accessors static
 inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-9-6c4698dcf9c8@linaro.org>
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

For symmetry we do the same change for pfn_to_virt.

Immediately define virt_to_pfn and pfn_to_virt to the static
inline after the static inline since this style of defining
functions is used for the generic helpers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/asm-generic/page.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
index c0be2edeb484..e8ef12bb858c 100644
--- a/include/asm-generic/page.h
+++ b/include/asm-generic/page.h
@@ -74,8 +74,16 @@ extern unsigned long memory_end;
 #define __va(x) ((void *)((unsigned long) (x)))
 #define __pa(x) ((unsigned long) (x))
 
-#define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)	__va((pfn) << PAGE_SHIFT)
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+#define virt_to_pfn virt_to_pfn
+static inline void * pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn) << PAGE_SHIFT;
+}
+#define pfn_to_virt pfn_to_virt
 
 #define virt_to_page(addr)	pfn_to_page(virt_to_pfn(addr))
 #define page_to_virt(page)	pfn_to_virt(page_to_pfn(page))

-- 
2.34.1

