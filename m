Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BFE622CF5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 14:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKIN5Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 9 Nov 2022 08:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKIN5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:57:23 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62729A1AC;
        Wed,  9 Nov 2022 05:57:22 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id f8so10935799qkg.3;
        Wed, 09 Nov 2022 05:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlCICaMl7bVoWfbHUbXFE6WjK/mpRfkQ1BpJ4tD81wg=;
        b=hYAyJrJrprd7b0VJs4fu9izwePkRd6u3kCLEH0ucaDYLowYUqvMI9cVgsX1ZV2lfTI
         lJiwXL8+J6BXYbfREn1al8CFChSx0JZ+N6X6XVVuY3W4DUnCTnQupDxZ6s+p6hNUeRZG
         puyzAzR3DA5D1rUXe/2PaWXPolRmDMt/+x8RZGEwpUcjLKvN+RSwSDTxUkUP203O62A+
         YtKC6aQ9YbvkfHQz3Pj4hwrki2+H4H5+Q3xNlxMZl2T2kcazNt3mX7WyZ762ZJlzXhrl
         8GW9oGSiTfLcysE8fbNiSXQUtGU2g/8BI3lQDCqR1RohVq/52XR260bYdrRm8Xc2cb/f
         vpbQ==
X-Gm-Message-State: ACrzQf3OxnDSwOlIgBiKAX9wAeSRbMjmdh2SgdBVaqSNz6+bTT1yF6V9
        6SEaA7HCdI0qXOjCWYoObQt1ysyPQ0FUgg==
X-Google-Smtp-Source: AMsMyM750pznucp7md3lSwY7NlWmE4AfNBaGyscG+QYT36cSHCpD2cxupqOG3MBq9nwNLkvVZl0zkw==
X-Received: by 2002:a05:620a:4447:b0:6c6:c438:1ced with SMTP id w7-20020a05620a444700b006c6c4381cedmr45021187qkp.658.1668002241345;
        Wed, 09 Nov 2022 05:57:21 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id a185-20020ae9e8c2000000b006fa0d98a037sm10987120qkg.87.2022.11.09.05.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 05:57:20 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-368edbc2c18so162343457b3.13;
        Wed, 09 Nov 2022 05:57:19 -0800 (PST)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr55685175yws.316.1668002239320; Wed, 09
 Nov 2022 05:57:19 -0800 (PST)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV>
 <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com> <CA+icZUVXvMM-sK41oz_Ne4HyRGxXHNz=fPqy+1AYXmXPiE_=Rw@mail.gmail.com>
In-Reply-To: <CA+icZUVXvMM-sK41oz_Ne4HyRGxXHNz=fPqy+1AYXmXPiE_=Rw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Nov 2022 14:57:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTHi35MwFt=x+soc1XdYH09DYfHxzjexKG8swR1K40Zw@mail.gmail.com>
Message-ID: <CAMuHMdUTHi35MwFt=x+soc1XdYH09DYfHxzjexKG8swR1K40Zw@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     sedat.dilek@gmail.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Tue, Oct 4, 2022 at 8:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Tue, Oct 4, 2022 at 2:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Oct 3, 2022 at 4:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > One variant would be to revert the original patch, put its
> > > (hopefully) fixed variant into -next and let it sit there for
> > > a while.  Another is to put this incremental into -next and
> > > merge it into mainline once it gets a sane amount of testing.
> >
> > Just do the incremental fix. It looks obvious enough ("oops, we need
> > to get the pos _after_ we've done any skip-lseeks on the core file")
> > that I think it would be just harder to follow a "revert and follow up
> > with a fix".
> >
> > I don't think it needs a ton of extra testing, with Okajima having
> > already confirmed it fixes his problem case..
> >
> >                 Linus
>
> [ CC Geert ]
>
> There was another patch from Geert concerning the same coredump changes:
>
> [PATCH] coredump: Move dump_emit_page() to kill unused warning
>
> If CONFIG_ELF_CORE is not set:
>
>     fs/coredump.c:835:12: error: ‘dump_emit_page’ defined but not used
> [-Werror=unused-function]
>       835 | static int dump_emit_page(struct coredump_params *cprm,
> struct page *page)
>           |            ^~~~~~~~~~~~~~
>
> Fix this by moving dump_emit_page() inside the existing section
> protected by #ifdef CONFIG_ELF_CORE.
>
> Fixes: 06bbaa6dc53cb720 ("[coredump] don't use __kernel_write() on
> kmap_local_page()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Please, check yourself!

The build issue is still present in today's linux-next.
Al, can you please apply my fix, so Greg can backport all of this to stable?
https://lore.kernel.org/all/YzxxtFSCEsycgXSK@kroah.com

Thanks!

> [1] https://lore.kernel.org/all/20221003090657.2053236-1-geert@linux-m68k.org/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
