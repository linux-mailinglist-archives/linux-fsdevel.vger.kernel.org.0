Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973F74EB5C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbiC2WVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiC2WVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:21:06 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80479B7C75
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:19:16 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r22so25316634ljd.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5OB5pHS7XJuBLYJkh+9Vs+P+P9M21m6mivUcEssFFI=;
        b=GlpBOFT/bsDCmj07YCY59rgZpXNEykhL6zCcAj9zH1EW6EoBPpHcAQz1yvylcfJKL2
         5Pr4pScdLIDktbIos7WlkIzgwlF6FmFxJ1pb8Mu+WJWvWFX6y+L9I5PjYmMMmHv17KVU
         L1lKmOMMBPwU08MLvKzZ/v45iwA8dE9DsaO6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5OB5pHS7XJuBLYJkh+9Vs+P+P9M21m6mivUcEssFFI=;
        b=SqD2bLCkXE2PfmtL4OiRuRG2X4nc/bB3tpS2wVnXaDt4TlvguCJeO7akWdSsNzvhYh
         nVqmB1biVB57DT+w6nD+Q8kBwcf9ZrC0cya3x/E5Psl2lOHOciX+iC9eU/OHEGtYRb0T
         YNdlnxId5k8isgTiHeDD+Q6hvyb03DbrrQgWUO5iYDu9efHp+QPfJUdUcK6l3X9qscJo
         67NtXBdWX7EycNCksT1rsPNHH2fjRNs/PG0UX57C06xFp69BvNOkvJ/wCnswW8UdwjPO
         ZK3raR1cy3pDlRf+oqrfDaRl0MGO0btiP9luIHPltvaKhCv5LyUlPos/dZDMb6ausfvq
         b4Hg==
X-Gm-Message-State: AOAM533pyjWriowzfM5SKfrf/ljSQqDYxeeNCo9Z0PlNpFWyzl3WW2bG
        Cl+BwUt8yNTxjQg/SUiZvFMo6IHFiVqKzeUc
X-Google-Smtp-Source: ABdhPJxHx4P7C2HrHtD/aPkwLOUladB1pRuH4l0U6yqJrxpymDBeEPp23Hj1oh2/izeWm8XJVWW/oA==
X-Received: by 2002:a2e:a58c:0:b0:249:7ecf:6075 with SMTP id m12-20020a2ea58c000000b002497ecf6075mr4321351ljp.460.1648592354385;
        Tue, 29 Mar 2022 15:19:14 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id t17-20020a192d51000000b0044a5a9960f9sm2122044lft.236.2022.03.29.15.19.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 15:19:13 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z12so18917494lfu.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 15:19:12 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr1173972lfu.449.1648592352243; Tue, 29
 Mar 2022 15:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
In-Reply-To: <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 15:18:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
Message-ID: <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     Fedor Pchelkin <aissur0002@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 29, 2022 at 2:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I will apply that ALIGN() thing since Christian could confirm it fixes
> things, and try to add a few more comments about how bitmaps are
> fundamentally in chunks of BITS_PER_LONG.

Ok, applied as commit 1c24a186398f ("fs: fd tables have to be
multiples of BITS_PER_LONG").

I tried to add reasonable commentary too, both to the commit and the
file.c code.

Christian already tested that added ALIGN() for his test-case (that's
obviously assuming the obvious patch was identical - it can go in
multiple places), but the more the merrier, of course.

                 Linus
