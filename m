Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23170F3E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjEXKPC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjEXKO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 06:14:28 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25AF19C;
        Wed, 24 May 2023 03:14:01 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-563b1e5f701so7030367b3.3;
        Wed, 24 May 2023 03:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684923241; x=1687515241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dz+M1KSdnKMmcmYWNiYwzrnxigtUcBsMNIJcHfr8PAI=;
        b=EODiHjt3saZs4hjXdJNhncDhUm3GP1vzlSbpZoLSx/2MB/lvlKuACl3+m0Vyf60VZt
         hb74BrPNr6fqm6I+9R50SQoDXcFGCFu74Ygp2qNvqXi2GKbE5i/jDYJNnJpcv3Orzs4c
         GNc8U1+dpomTCqV7cGW4g76rMYpe9/bL8h71YkhLRfqBZCkjJ5k/iq4D/TDqHGKuou3a
         p/iQQU0XIZkHow3ZVC0TaRgE3aFKBtXjtrhY0HI2w359vkmX04SVfjs7QmD0VP0wrzE1
         DgmT0+LEgwQYYFWyIJ8M91B4X+701FEXFx22k/YGKU9Fj8QEf3kU6YumLuYHsqAphYoX
         6HAA==
X-Gm-Message-State: AC+VfDwUO84Z0rVKdXUZDn1NxzZ5GzdN1f5iFnAcQzxmLYEWiLRhZ6m3
        cgxWkJr85k5dGikyEaIpgeJv0fBr2v3qDA==
X-Google-Smtp-Source: ACHHUZ5brofOMn3v4R6LKJ2U1YBCt/oycnds4IROPRMg0s9JfkHzha4IpGPIJ6sTKk7MZq7w5oiwZQ==
X-Received: by 2002:a0d:ea82:0:b0:55a:dd:9d2a with SMTP id t124-20020a0dea82000000b0055a00dd9d2amr15901097ywe.52.1684923240693;
        Wed, 24 May 2023 03:14:00 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id z18-20020a0dd712000000b0054c0a8ceb2fsm3587427ywd.28.2023.05.24.03.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 03:13:59 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-563b1e5f701so7030217b3.3;
        Wed, 24 May 2023 03:13:59 -0700 (PDT)
X-Received: by 2002:a81:5ac3:0:b0:565:347a:46ee with SMTP id
 o186-20020a815ac3000000b00565347a46eemr6575440ywb.7.1684923239253; Wed, 24
 May 2023 03:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org> <20230503-virt-to-pfn-v6-4-rc1-v3-12-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-12-a16c19c03583@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 12:13:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVFX6vtiiNgZyXTLmhcxdsyOwRL3kb3tDZ4E_LUN2MaeA@mail.gmail.com>
Message-ID: <CAMuHMdVFX6vtiiNgZyXTLmhcxdsyOwRL3kb3tDZ4E_LUN2MaeA@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] m68k/mm: Make pfn accessors static inlines
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>, linux-mm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
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

On Tue, May 23, 2023 at 4:05 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> Making virt_to_pfn() a static inline taking a strongly typed
> (const void *) makes the contract of a passing a pointer of that
> type to the function explicit and exposes any misuse of the
> macro virt_to_pfn() acting polymorphic and accepting many types
> such as (void *), (unitptr_t) or (unsigned long) as arguments
> without warnings.
>
> For symmetry, do the same with pfn_to_virt().
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
