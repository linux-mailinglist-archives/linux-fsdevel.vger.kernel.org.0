Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0D6FF0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 14:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjEKMAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 08:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbjEKMAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 08:00:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882A98A7D
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f139de8cefso45702537e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806394; x=1686398394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp9YXKX/mdPfR3Groy/h2+S4HOih/XO/GthWPwB3ikY=;
        b=VET6NG7wZTvecZWmT897hwjurDC79ewy9skuHZ0BAg8j6WG0HpKT+cKQYjlNZZqhS9
         ZBHD1UegBUAZIn6kmSpxYJxUFcYOnfNE4nWrjQj8Sh+Uyggour6jRxMf7LS9/IF5rBFy
         W4iB0k1o3MdtFYsa9QEggKETjWUSzFkIw+N/2yuZwaQ++xxuXjedgdW2WIuJ65DMFPN/
         e/9mK8nx3Y3hIAMMKkRttccO2avl3pany6MQBtJ/no8qfzNa5YL3EsRjrPJBi0xnB1Ix
         DgFTea1Sh8U9UP6E0E8bSwiu4w89Knjloaax/XSVZRxAotV+hiMJu+jl4YaOwMPz+gGa
         V0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806394; x=1686398394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xp9YXKX/mdPfR3Groy/h2+S4HOih/XO/GthWPwB3ikY=;
        b=Ou88LEtRbspPKUe9L+NW/Kb3c5zkWxD2Kq2llhMS7uJ9nre0AM6vPkuzY231kI2v2i
         +P+U+3fGZ2iHibA7hq3LZ4jBys+477X66yNGRYF17glJ/anFY0SyAcS9D6TN+8iasAq/
         8QTSnLjsTEHHtaiJ99Qklq2PjOOocP++TkGiFTjbCXHi1xr9kyS7rDlbh4XDlhzOr9iv
         02lL2nF1g/hnIOHPpjqjogDb2UJTvAUwpo792ejM/qWP6lOd8bZMeCJMLrIe2nZbD/we
         1bAM/uL3/LGfUmTS/DwkAV2WBYZdQ+udYfH/lS5x/1CxQK7bYEX7VzPJHdu62wcAsVPP
         xyvQ==
X-Gm-Message-State: AC+VfDxHPYogTfkryNaKrbqkTUh/SmvJYIct8X8Ohfk+GrHkSShSTeK6
        0kfCsQKCTkS8VoTs+gzV1zsrfA==
X-Google-Smtp-Source: ACHHUZ6xiVVkKCB96YSXNRCjX6NTy5gQRqNaBw4Zi8UyRnMiRA1OZALXLSyHrKhvlITGQwt4AiY7kw==
X-Received: by 2002:ac2:4d03:0:b0:4ef:ebbb:2cf5 with SMTP id r3-20020ac24d03000000b004efebbb2cf5mr3050896lfi.17.1683806394609;
        Thu, 11 May 2023 04:59:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:25 +0200
Subject: [PATCH 08/12] arm64: vdso: Pass (void *) to virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-8-6c4698dcf9c8@linaro.org>
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

Like the other calls in this function virt_to_page() expects
a pointer, not an integer.

However since many architectures implement virt_to_pfn() as
a macro, this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix this up with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm64/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 0119dc91abb5..d9e1355730ef 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -288,7 +288,7 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	memcpy((void *)(vdso_page + 0x1000 - kuser_sz), __kuser_helper_start,
 	       kuser_sz);
-	aarch32_vectors_page = virt_to_page(vdso_page);
+	aarch32_vectors_page = virt_to_page((void *)vdso_page);
 	return 0;
 }
 

-- 
2.34.1

