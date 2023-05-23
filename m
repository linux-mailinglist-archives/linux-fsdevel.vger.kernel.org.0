Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7AD70DE7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbjEWOGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjEWOGu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:06:50 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD0133
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:47 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so8693094e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850746; x=1687442746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYHNj4xOB3A9+sRrGGyA+CHl8mr8r8wePJEdzxz75NA=;
        b=yi3hcBL/sMAfGA15PDa1P8NdEmww4HzJP2F/sUwI9IpWl8FAr9D8nzxcXs3kk9VZLg
         gqW+uTf0Quu6EKOMoBtewB5My0WXhMod0GC8z1ZbYL4s/yewGksiSDol/qQUkOAwxxUP
         tWgq8rOI0YG+2kzNAd6LFlZQnU/w/sUVfPTphub78KgJsbXLOjbr0epF5+oc5rNWTcLT
         4z9nAmfx1uJBTtHPDaWVenyL8i5pZQeTVRUJb52fjzXC6jarDxR7o0xXXXnUa9XVKQra
         c4l8ZCAV1hnrQiBJbDsUuYXenW29rw/An0d2CKxpWMKMbNQerNNefqEtiX0g0tIAPTZn
         73Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850746; x=1687442746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYHNj4xOB3A9+sRrGGyA+CHl8mr8r8wePJEdzxz75NA=;
        b=ZbHuTBWdNrsuxnV0cdJIZPFwGJBak+dA2aeYrGjSFi1yrtT24BJYYcEasEvOgiv42a
         EHEJPcBRs3Ek8SMvc7InlMEvg9brpaGgcRivv+fKHe2tJXIJ3quZ2E8eoorNViYVluiR
         ArIj6zXqU2lbNB5+1m9kKnjI4MTR5TmS5djRzdjpNpKmfIMo4kn5mLXepINqgBdAXMwE
         kY7pa5aPCf2YUi16A96/1oJaTaJmtQKRkelhxS2m6TfwKlTdbyBt85+RcBoDJwJypGsI
         eJr+ml7ZLZbLmRAQoslOgU0Fn9am0DEwtgV877PmduwIZxquEVhMBYFai7JY9p085j9S
         iWjQ==
X-Gm-Message-State: AC+VfDwWFswLIQRPqXM2q7HJn/k6YfFMBVH9PZ+XNmFzxzCkN9zKqB4s
        EOoveSdCMICNdxYHYqNBv+JTYQ==
X-Google-Smtp-Source: ACHHUZ7rLgS3uJwWiogUeDYb0+CYWWtRVMpUMIrByqwxVk0kXBZ79wUE4ySYqYt+Mam8+eVWY8llcQ==
X-Received: by 2002:ac2:43a2:0:b0:4f3:a1db:ad4 with SMTP id t2-20020ac243a2000000b004f3a1db0ad4mr4313623lfl.66.1684850745735;
        Tue, 23 May 2023 07:05:45 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:25 +0200
Subject: [PATCH v3 01/12] fs/proc/kcore.c: Pass a pointer to
 virt_addr_valid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-1-a16c19c03583@linaro.org>
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

The virt_addr_valid() should be passed a pointer, the current
code passing a long unsigned int is just exploiting the
unintentional polymorphism of these calls being implemented
as preprocessor macros.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 25b44b303b35..75708c66527f 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -199,7 +199,7 @@ kclist_add_private(unsigned long pfn, unsigned long nr_pages, void *arg)
 	ent->addr = (unsigned long)page_to_virt(p);
 	ent->size = nr_pages << PAGE_SHIFT;
 
-	if (!virt_addr_valid(ent->addr))
+	if (!virt_addr_valid((void *)ent->addr))
 		goto free_out;
 
 	/* cut not-mapped area. ....from ppc-32 code. */

-- 
2.34.1

