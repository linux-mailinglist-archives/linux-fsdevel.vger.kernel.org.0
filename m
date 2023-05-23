Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6470DE86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbjEWOHO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjEWOHM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:07:12 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999C3188
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:49 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f3b39cea1eso4337159e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850748; x=1687442748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2CPc/Vm/Ur0JOy8kF/L6fs0qWXc+VKBrwCqiZQE3hiQ=;
        b=DHx5ZxV7p8BhGcgtHBETWYRJd1dP/RkZ+YUCwCVosoC2AbBpe5sHXnMZMwMfxH0y90
         XzQe0bQlxKytbPkvQ7V2w5JMdAcALyzlLbnEu6FgCRgXy4OrpPkT/mSWek9ZWrsZAiWH
         t18h2rnk6uTfqGPlKFgZORYwPzN9BqAyYgP2fxRMHyNsWSDezmeWQlLl3RvNoS0at2N4
         zwQ3dB33a/q/dRZ6aJBGgNr9dIXjla+n0UxG3C1sJgM5T6M4GTED+bWcwU/Qj9vEwFAM
         ENMA+EKO7SMaOA+g+taxuDmYjq5EjwmFMZZGZfVYtGGJEuSMfUR23VvC7Y2vQbS5i/pL
         sqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850748; x=1687442748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CPc/Vm/Ur0JOy8kF/L6fs0qWXc+VKBrwCqiZQE3hiQ=;
        b=UZA5nGv+u10Mjn51m38kyV6GuXi4d3IUVYlCJI0EVkbttrkJBfgH8xhrcO/c4p2u3v
         pL0LGNhAQmeyiG4sztmJdVBb0RSMuqj6edHJbA3fZ+WSFGU05GooMHIAMTk9LeGjpOPm
         9n+0NyMtxyTng/cVISedw9fxeAL9o0h/6SXlbeTCi3T1W5+C3Oq0OmV18pjGT2L3Rux0
         qz5Bmtn9a0AffNnvvVH7WTNEKKikQOqQney0TsPnCMRgZrH3YSbdaKvZfBEhFdFIJfrM
         r4ioFUabBKMh2ZS3R2AhhZhhtVttAhIsOWhNYWAOj4KSOSzEaok9seGhjRkSAoy/0q6f
         a7AQ==
X-Gm-Message-State: AC+VfDy2eiEBEbPtQeg76diynzVgp78P6HacIgkD5UKwyIQoDsN7MSXx
        ct2MfGgArnWGn1DtWDasKM1EaQ==
X-Google-Smtp-Source: ACHHUZ5pbGMO+sh/phzIMr8IiKndfXiVK4utpsmGDrzwNTNHRToknMEuuC5d/vlugDZ8cv2eNOF/ag==
X-Received: by 2002:a05:6512:259:b0:4f0:1124:8b2a with SMTP id b25-20020a056512025900b004f011248b2amr4733118lfo.46.1684850747942;
        Tue, 23 May 2023 07:05:47 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:27 +0200
Subject: [PATCH v3 03/12] ARC: init: Pass a pointer to virt_to_pfn() in
 init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-3-a16c19c03583@linaro.org>
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

Functions that work on a pointer to virtual memory such as
virt_to_pfn() and users of that function such as
virt_to_page() are supposed to pass a pointer to virtual
memory, ideally a (void *) or other pointer. However since
many architectures implement virt_to_pfn() as a macro,
this function becomes polymorphic and accepts both a
(unsigned long) and a (void *).

Fix up the offending call in arch/arc with an explicit cast.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 2b89b6c53801..9f64d729c9f8 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -87,7 +87,7 @@ void __init setup_arch_memory(void)
 	setup_initial_init_mm(_text, _etext, _edata, _end);
 
 	/* first page of system - kernel .vector starts here */
-	min_low_pfn = virt_to_pfn(CONFIG_LINUX_RAM_BASE);
+	min_low_pfn = virt_to_pfn((void *)CONFIG_LINUX_RAM_BASE);
 
 	/* Last usable page of low mem */
 	max_low_pfn = max_pfn = PFN_DOWN(low_mem_start + low_mem_sz);

-- 
2.34.1

