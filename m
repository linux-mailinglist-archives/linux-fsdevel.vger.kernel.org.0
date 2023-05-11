Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF046FF0DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbjEKMA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 08:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjEKMAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 08:00:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2321A9023
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f14ec8d72aso7552702e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806393; x=1686398393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbjvTSrc7JXib/jYCtsnbT8Pj+twUmj4f7HYrh8lbjo=;
        b=lVyXp4k3KTmo8RdF9FjbrH3Tv6c0bVkXtZywPccWNYeyjQtpi+z8J9YOLY5+sc8Eee
         9TxIZcqfBkHZCR5W/lS4SlBkIqbWGSAPlS7Lr3r/I9TrjHIt12ePBNQQByXKE9XA5W82
         Lp1d5/+LzKSwENiuYylfIRK6jrTQr4Zv4h1kXRVaE4hxsuTMNFh3hlQ2qHWkX+6kY0EG
         T5bDIgWzHhDoq1MM/WpZ20V/MaFu2pz8FMs/SVRMPgnQO5dguxAOe06YAfd7vgPdzNUJ
         UXbg5YSTuY6yxPVV9orezsqTc3SK9pkouhcNBUYohSwcaCiNBsVhx46K7y7sjmIKo1cO
         FxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806393; x=1686398393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbjvTSrc7JXib/jYCtsnbT8Pj+twUmj4f7HYrh8lbjo=;
        b=c3A3kQ091penI1hht659DkTHj9Qv7acYXvdpW9NX+x6ddrYgG5dORve2q+sfB1P2AF
         NSTsNvRljUZXVU/rUctQcqqXP4AwHN4hZUJNfVagExTcx0ZeOFXohIygvUsnsA7Gterm
         GQdtS6YJZE3t+hg8TbY+o1bIX1HRKM+yx3C6zJiircbpOhkgXiONnCOGBMGtJ41IRX+R
         vZPCQ9IOHt8k5Isti7quf+sOrEP9eH1MPy7qU8QJwtQNhiCRBnOcMcu5ezkn4kQJrWeg
         H8xGWtXgS0Fuy1qrPuTYXHcSdVc/M2yHUXIQ1l97Pzc96biU52KdbLbIPkRzu6kVD12O
         3UAQ==
X-Gm-Message-State: AC+VfDyWeXmGF6SQI1zNRAiZr25g3ewYqhs72oH9xKp+/L7OZImZQjnt
        E7BJlPU6Dbrhg6yuT9qCh5T1zw==
X-Google-Smtp-Source: ACHHUZ6yAIRSU1J7hff/jjZVil2cXfRcnI2cjw81Jl+2uJZmlGorTrbKTJFSuRdrBVeZHWDMCRrMKw==
X-Received: by 2002:ac2:4f8e:0:b0:4f1:3eea:eaf9 with SMTP id z14-20020ac24f8e000000b004f13eeaeaf9mr2642443lfs.24.1683806393661;
        Thu, 11 May 2023 04:59:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:24 +0200
Subject: [PATCH 07/12] netfs: Pass a pointer to virt_to_page()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-7-6c4698dcf9c8@linaro.org>
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
 fs/netfs/iterator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 8a4c86687429..0431ec4a7298 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -240,7 +240,7 @@ static ssize_t netfs_extract_kvec_to_sg(struct iov_iter *iter,
 			if (is_vmalloc_or_module_addr((void *)kaddr))
 				page = vmalloc_to_page((void *)kaddr);
 			else
-				page = virt_to_page(kaddr);
+				page = virt_to_page((void *)kaddr);
 
 			sg_set_page(sg, page, len, off);
 			sgtable->nents++;

-- 
2.34.1

