Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A917BA010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjJEOcy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 5 Oct 2023 10:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjJEOba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:31:30 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526B586A2;
        Thu,  5 Oct 2023 01:11:47 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59f4f80d084so6936157b3.1;
        Thu, 05 Oct 2023 01:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493506; x=1697098306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ey3mu0cYa/bhtbEBQ1BIB9STmNOx3N6SafWjGpaN/7o=;
        b=ZOyjygg3GUumYg9yDyOz6SZZuyYwFZ9A98Nnvlgmh9+X365JiXTlmMxMHe40aLBFQH
         d4EwSoQB++invakhlD/oTKTQOmk53v4b8yk267AZnSgNhK4GF+xqmr8GWHN8/SyZ1kMI
         pYWJCqkpKJhZkaaclrMzJEgb4AeaENTK7B9nsWeyi4NIeLRmWqpruEK1m38RZRuHeTKZ
         yF4mON9Tl5Grt/mF101iGe1gcov6oaGcCnT1Hu9RKUaeqntHvv6On+0cXlp29v592BYq
         nZ2szla2DhPeqm2azwRRlLaQswPN+ahYZ2c6ayorWUgQwof87N8iSuSfNSQa2ZZPmj5S
         E8UQ==
X-Gm-Message-State: AOJu0YyLKfuQLS9UTlvV7kBM/4JHClZuFCuU6U3+7fN2X9HKPggRqYKu
        bs7Z7CJT3m4qlhiX/jCoqSZBzGYUm8UNGg==
X-Google-Smtp-Source: AGHT+IErovl4GsmqwzdyaD91ebnxhzBvD4rddXJGCptI3O5ZVpa17U84HpI9S7jORC1taC7Fh+aigg==
X-Received: by 2002:a81:928e:0:b0:59f:519e:3e7c with SMTP id j136-20020a81928e000000b0059f519e3e7cmr5542216ywg.24.1696493505932;
        Thu, 05 Oct 2023 01:11:45 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id n1-20020a0dcb01000000b0059293c8d70csm343716ywd.132.2023.10.05.01.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 01:11:45 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f4bc88f9fso6878497b3.2;
        Thu, 05 Oct 2023 01:11:45 -0700 (PDT)
X-Received: by 2002:a81:8246:0:b0:58d:f1fe:5954 with SMTP id
 s67-20020a818246000000b0058df1fe5954mr4952101ywf.32.1696493505212; Thu, 05
 Oct 2023 01:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231004165317.1061855-1-willy@infradead.org> <20231004165317.1061855-10-willy@infradead.org>
In-Reply-To: <20231004165317.1061855-10-willy@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 5 Oct 2023 10:11:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUv-iALRvpBacsKOAo3P1Rgpf5g=taWqdt=5t-1Xjg9Rw@mail.gmail.com>
Message-ID: <CAMuHMdUv-iALRvpBacsKOAo3P1Rgpf5g=taWqdt=5t-1Xjg9Rw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] m68k: Implement xor_unlock_is_negative_byte
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        torvalds@linux-foundation.org, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 4, 2023 at 6:53 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Using EOR to clear the guaranteed-to-be-set lock bit will test the
> negative flag just like the x86 implementation.  This should be
> more efficient than the generic implementation in filemap.c.  It
> would be better if m68k had __GCC_ASM_FLAG_OUTPUTS__.
>
> Coldfire doesn't have a byte-sized EOR, so we test bit 7 after the
> EOR, which is a second memory access, but it's slightly better than
> the current C code.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
