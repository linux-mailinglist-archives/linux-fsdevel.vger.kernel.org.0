Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD0A6FF0E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 14:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbjEKMAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 08:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbjEKMAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 08:00:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA37A246
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:54 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4eff50911bfso9475279e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 May 2023 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683806392; x=1686398392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zblD5qwa4O4tbk0UyG8/FxNMnBSv353Htd3W/ogLXhE=;
        b=wyPzOAzNl7rmMFYBpuSvqF8bhrq6s9qC3HUK0XdF1bjiigB5tF7/avNAx4obqKnEQ1
         5XDdVWTgJzXsRWcpD0IeKxuCUkF11nwjWijBb+G6T5OPprRNKDhkDqc9xd5QVgMzyrYY
         L4pIzqOjfuQxI7o931I1eoHt0E6G0OHcTKzBzLCxA+U45bYiMjQdWdAzAsrvS2ny+0vb
         k7hlG5IBE0zSUhp1t5xXUTTwH3SO9y19gebdMieRe9lXFfVvvxSdJSGDOae/gEYPgSY9
         RwLKQo1r9DKn1ZNPuZYIw5CEheKyIccgqvPNEdgrxsVlTPsrWGQMtl/h5sx8pPqkpO6r
         g93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806392; x=1686398392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zblD5qwa4O4tbk0UyG8/FxNMnBSv353Htd3W/ogLXhE=;
        b=f2ZwYYFF5yyIDOGrY7wWjeg082l13FwEmd0nRDfZFqrPFHjQjCirHVE1g2n/U6xAXc
         /fVmqNzl4MbL3QKgHbMWdRWjKUNKZt8fscjYGjzA3R06N1SlGMNAyuChungmJGF93aNK
         fCOKC0lOAevUH8pz0TvOsCAtnwY90NdnyVG/QjIl8CRUjT2jI6RQqXGB0Wg5wHWJlDGz
         5IIh8nOr/MMMmIiuL2A6ZIjP3M8wJsbvn6bN9fivA2hjdvDJQ7f4SqmjvBkno0vKBTGi
         rBrfq3kLmcnZdQaju2IoKOfja1mLsQ0uCgjwcpfksJC+8hKx9ylW9xXSwUFZ44dL4v2R
         vkjw==
X-Gm-Message-State: AC+VfDxGZme1sYIO8OKeM1lPOayA8756wiJLwGvjukfZPxQAACN6FWO3
        8INxo6Vj2YmVFurHn1NZMeyaGw==
X-Google-Smtp-Source: ACHHUZ59KkD2PbSzrX68GhVPYYRxuWgdwfVNkMLT9EHS/L7M9SxIxBIJEQpBkI5jMhVr75d7lMVL9w==
X-Received: by 2002:a19:f605:0:b0:4f2:53fb:187 with SMTP id x5-20020a19f605000000b004f253fb0187mr2361851lfe.68.1683806392694;
        Thu, 11 May 2023 04:59:52 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f16-20020ac25090000000b004cb23904bd9sm1100841lfm.144.2023.05.11.04.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:59:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 May 2023 13:59:23 +0200
Subject: [PATCH 06/12] cifs: Pass a pointer to virt_to_page() in cifsglob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v1-6-6c4698dcf9c8@linaro.org>
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
 fs/cifs/cifsglob.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 414685c5d530..3d29a4bbbc40 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -2218,7 +2218,7 @@ static inline void cifs_sg_set_buf(struct sg_table *sgtable,
 		} while (buflen);
 	} else {
 		sg_set_page(&sgtable->sgl[sgtable->nents++],
-			    virt_to_page(addr), buflen, off);
+			    virt_to_page((void *)addr), buflen, off);
 	}
 }
 

-- 
2.34.1

