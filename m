Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C356700464
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240090AbjELJ5v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 05:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjELJ5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 05:57:47 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EE118C;
        Fri, 12 May 2023 02:57:20 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b9d8b458e10so12375654276.1;
        Fri, 12 May 2023 02:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683885440; x=1686477440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27/Fbt6wOw+aeS9WaGgothEj3OntQ06F+YuUTxkvogA=;
        b=dbx3Y1x+1axQQiceI8mRcHF3mG3OLNwLg+fpbFOaET0DgQZyGXO7CkO4H8ZG864zpP
         Q1XIoRsTPm7WmrzNvHfZrJHAbUQbwOA4bMCIRSB/dGAQYWArCUH6tWlRUxbhZDM1jMKo
         L+kpkhZd8i7+3Z9G0wslPz1Nk0mCM3o/v9XZxorWKviFYRLaDI430iC4eD1VaaRHBNE+
         pnIvojaFvzsUTfy88FwjqA8GO6WtIdIorfXmHM+8Pi74DIXoa0A8x7+JPbf9BvjETPPE
         DCSNWuaHdRDZzUpC7hoD4BH5o/LdOan9K7/J/l25sZJGNYZ5x/SIcxln199Mx4zcT3Tz
         XH2w==
X-Gm-Message-State: AC+VfDzQP5V/KD1UuPWYeyacAMeyuMwggkVcoipkYp/VU3AZzhEwtK8X
        pjLxIlz1Bmx6KhuHZM+71vam/vpeqcYwQQ==
X-Google-Smtp-Source: ACHHUZ4nvxb66LO8i55+ytZu+CRJGw/iJFOOXvDV853cmI5MvRBZdR3yRjlolrljqqZk0DX+5930Lg==
X-Received: by 2002:a25:844:0:b0:b9d:9f01:770a with SMTP id 65-20020a250844000000b00b9d9f01770amr23732825ybi.37.1683885439871;
        Fri, 12 May 2023 02:57:19 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id a205-20020a254dd6000000b00b8f54571fc0sm5008404ybb.5.2023.05.12.02.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 02:57:18 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-55a44a2637bso143308887b3.2;
        Fri, 12 May 2023 02:57:18 -0700 (PDT)
X-Received: by 2002:a0d:e209:0:b0:555:cbdc:c6 with SMTP id l9-20020a0de209000000b00555cbdc00c6mr23583778ywe.9.1683885438128;
 Fri, 12 May 2023 02:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 11:57:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwusgUqBuERm1=y7fwC5CERuX8VPGdaKcJiu3fM1oNuw@mail.gmail.com>
Message-ID: <CAMuHMdVwusgUqBuERm1=y7fwC5CERuX8VPGdaKcJiu3fM1oNuw@mail.gmail.com>
Subject: Re: [PATCH 00/12] arch: Make virt_to_pfn into a static inline
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On Thu, May 11, 2023 at 1:59 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> This is an attempt to harden the typing on virt_to_pfn()
> and pfn_to_virt().
>
> Making virt_to_pfn() a static inline taking a strongly typed
> (const void *) makes the contract of a passing a pointer of that
> type to the function explicit and exposes any misuse of the
> macro virt_to_pfn() acting polymorphic and accepting many types
> such as (void *), (unitptr_t) or (unsigned long) as arguments
> without warnings.
>
> For symmetry, we do the same with pfn_to_virt().
>
> The problem with this inconsistent typing was pointed out by
> Russell King:
> https://lore.kernel.org/linux-arm-kernel/YoJDKJXc0MJ2QZTb@shell.armlinux.org.uk/
>
> And confirmed by Andrew Morton:
> https://lore.kernel.org/linux-mm/20220701160004.2ffff4e5ab59a55499f4c736@linux-foundation.org/
>
> So the recognition of the problem is widespread.
>
> These platforms have been chosen as initial conversion targets:
>
> - ARC
> - ARM
> - ARM64/Aarch64
> - asm-generic (including for example x86)
> - m68k

Thanks, builds fine on m68k with MMU, and boots fine on ARAnyM,
with the extra changes I replied on patch 2/12.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
