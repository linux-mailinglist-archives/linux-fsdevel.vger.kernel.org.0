Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52D14C7AAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiB1UmK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 15:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiB1UmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:42:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC94220F6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 12:41:30 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qa43so723458ejc.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qhbC6eV8gO++7ErI4p8jtmcwHU0MP2/Ov9cpdMFArow=;
        b=WVa5dIiqx38h7wrDwDC1XUsKJKiBFCag4a2cDDwm9PX3cUtT8qqZ7IT4jQUgf/P4m+
         SFGMe+WsS02R4cGzO91FNZKGdT/lUA2soxV9cxmDWvmKG61T36jSK+GypeHu4wmj47J3
         J2dEWo9WRu5EKgz1ZgjNDbSUreOeJ25KIOWY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qhbC6eV8gO++7ErI4p8jtmcwHU0MP2/Ov9cpdMFArow=;
        b=35dFHCndl2DYxLONcpxQHaW1rdAURGbwUSocf7ikTGfv80ulikDcdRrN0l+QwQMPKZ
         iBO9wlm9QxPPPtAjS2hN/e7DTxBaxSsoqqnIzVVpPPqjtRggJldf1kdWpwNJRwnbfLRQ
         uzTyFVv0S/Hgyc0JskwxCM7DXII/DO2sHjIJNkdV3mTqB3jtKEMs4V0CundRcMAQJdLF
         znWCwxaRU1OLpSu6WbJefhzULun7esqe8EleBywl8Qccr1SuinsYD2IQRALJhnmQyNxM
         BRjxzK92uAEi7udwh9RMmnFuUNGh5oxbMxBAb2ttf5lmRFLp8vDnu4RbOEqSf0e8F6QL
         yqhA==
X-Gm-Message-State: AOAM533jrRYUJ7oM2R2NSl7nIkn1HZzvUv69e9hF7WEon8P6loTpZQTi
        7BnF7VKjlNHcv7J2KSx30yMhHkuHPfg49w9LI/4=
X-Google-Smtp-Source: ABdhPJyVP7IvKTL0OB8r6EVkJW2znl2zc10JEdpAlIlRmJRR9xhP+BSII9okJWRa17iFz7IEfPGYPQ==
X-Received: by 2002:a17:906:ae07:b0:6b8:f4ba:4421 with SMTP id le7-20020a170906ae0700b006b8f4ba4421mr16736772ejb.692.1646080889019;
        Mon, 28 Feb 2022 12:41:29 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id n24-20020a509358000000b00410bedd9eb4sm6599958eda.88.2022.02.28.12.41.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:41:28 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id r10so17326573wrp.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 12:41:28 -0800 (PST)
X-Received: by 2002:a05:6512:e8a:b0:443:7b8c:579a with SMTP id
 bi10-20020a0565120e8a00b004437b8c579amr13784522lfb.687.1646080877791; Mon, 28
 Feb 2022 12:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
 <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
 <Yh0tl3Lni4weIMkl@casper.infradead.org> <e3bb7d0632f8ef60f18c19976d57330e1ef00584.camel@sipsolutions.net>
In-Reply-To: <e3bb7d0632f8ef60f18c19976d57330e1ef00584.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 12:41:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNgWNa9njuBJEoafc-cRV3SbzZfh3m5YfxcZxdCw3+XQ@mail.gmail.com>
Message-ID: <CAHk-=wjNgWNa9njuBJEoafc-cRV3SbzZfh3m5YfxcZxdCw3+XQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
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

On Mon, Feb 28, 2022 at 12:29 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> If we're willing to change the API for the macro, we could do
>
>   list_for_each_entry(type, pos, head, member)
>
> and then actually take advantage of -Wshadow?

See my reply to Willy. There is no way -Wshadow will ever happen.

I considered that (type, pos, head, member) kind of thing, to the
point of trying it for one file, but it ends up as horrendous syntax.
It turns out that declaring the type separately really helps, and
avoids crazy long lines among other things.

It would be unacceptable for another reason too - the amount of churn
would just be immense. Every single use of that macro (and related
macros) would change, even the ones that really don't need it or want
it (ie the good kinds that already only use the variable inside the
loop).

So "typeof(pos) pos" may be ugly - but it's a very localized ugly.

                    Linus
