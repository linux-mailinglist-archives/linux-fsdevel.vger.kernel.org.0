Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886A70B5B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 09:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjEVHBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjEVHBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 03:01:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D9ED
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:00:49 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2af290cf9b7so31170601fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 00:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684738847; x=1687330847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1mJE8PBb75X4TbUyJXZ6L55Fw+NsuGtTu+nI/l3Cvc=;
        b=FMR+Qlxwuc8HLvz2Un+03lMzADefhZtZYcE4XHeTZEM0NlyayLDLr/ghrIPr4wOfsn
         hd18jrfSt0sSLwyi2R+kpdFTUKZrJ+BZ/C8tqM3Dro15MT0Bz2r43LqkO6JTuURAVyjo
         Hb5ibuaMMZUbyrbu0TGj+c4eZkPKyBY2Q7Hmx1HpmabTY9nj/7nqGyXR7uNb2h4G+5o+
         IbpEDIbdkQb08eN8cpfyD7jW1r5UTuEKzmsjHWQMxcDTMqfGNaZaaT25Z3ATIrIWcChT
         9UniGw6vl1lHpSHdcRd6BKV3duDmePJf14FnN89u8aN1cFzRNUW+g2/WjLxXlTSI3LHB
         9xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684738847; x=1687330847;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1mJE8PBb75X4TbUyJXZ6L55Fw+NsuGtTu+nI/l3Cvc=;
        b=QaQ+C9Oo9wrZ6OzovuOfUShzy9JJ7ufcE6bDZ8BHsnfLzmi1DKXgjG7W8HB33hmtPg
         jADsrvo06qeBCQi3DdNudph3yiEo/ci92v1s7VZPo9282q/iZwtuWtnG0bdgLkoiwtcX
         84Yl1fl9OQdaGzwHM7cow8tkA3ueHC75Pki7JXhlTYkKtrC/oHmvbuSD60TZ0a3i62td
         JD5ktY8nqPxobkxyzdPp+U8JPoKTvmOeV70hT/lMBZ8skYEwVhV9duQt4irrOQer/l1+
         B32UowzzD4qbLITXyeVNSFmS2Sg7/7jV/wIeL3QkbV70OWB6lzwSrWItGynU0hEg7oJb
         5tVw==
X-Gm-Message-State: AC+VfDxK0PenMibSTNmjkFKTZy1bdGsKgPgbuGGIblTWys4SOsVgZ/Kh
        SuUXleU3UzR+d3k/BLXAOlz61A==
X-Google-Smtp-Source: ACHHUZ7XAOeJkx3YfYjjDjWz6wE7VkRRqoG7K82VPNW1yh4/nnHy6HvJwsWKnI+O4aT1Pb2S2e5j6A==
X-Received: by 2002:a2e:a40d:0:b0:2a8:a5b8:184a with SMTP id p13-20020a2ea40d000000b002a8a5b8184amr3297249ljn.40.1684738847083;
        Mon, 22 May 2023 00:00:47 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e8744000000b002adb98fdf81sm1010187ljj.7.2023.05.22.00.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 00:00:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:00:43 +0200
Subject: [PATCH v2 08/12] arm64: vdso: Pass (void *) to virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v2-8-0948d38bddab@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v2-0-0948d38bddab@linaro.org>
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
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
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

