Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7DE1D3EEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgENUWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 16:22:00 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:40878 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgENUV7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 16:21:59 -0400
Received: by mail-oo1-f65.google.com with SMTP id r1so1012676oog.7;
        Thu, 14 May 2020 13:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlIQF5j5vsfBPOtZybt4E5c1BhvLEXxG3/+FEaTp6cQ=;
        b=DumUi0JZRpcBebsYX6Et40ImnssPFQE5Ipg7MSQoZyKi0jH71bysjM5tykoybrC+Om
         Pu/1P0663FeGAc0i5kwned78sR5rFX84RxAUNjqVUa0EmlB8j/9bIgM6KVTHSCsohp0Z
         84P6B/UpYKwY9Qz5hyqCVBz4UEsZ24U/np3w8+QtLaQmgYJ6qqyDnyT3PgSDPbuy6Vsa
         mrmM0DPk9wbd3JpoebUBFTRtgBGnq+TSna80qu0EuGQWTF5w5LK9U7RyvISYXHZtj4VT
         vTUH4gj90oliEHk57uWdqIIsSJ5SeoNIJYUhP6KhlW+PM+S7mGjLlYXBGXqZFKa+DVG0
         Ib9g==
X-Gm-Message-State: AOAM533qQ9hwEoVmg2PmNH70k1egCjsPxbqoSCIZNhb7jJQh26oiF7Ht
        u/QpEyZS8p3FHf601x2xAGJTbr6rhMjqbe74Gns=
X-Google-Smtp-Source: ABdhPJwHZYLoAUW61n9j258U9+ByCYD6QyGX6G3qS+2hqB9LkqYOP+sHVtDrwpGhxf2U+Oq5OCAoTbA4VCmhRTC+280=
X-Received: by 2002:a4a:d44a:: with SMTP id p10mr5187382oos.11.1589487717414;
 Thu, 14 May 2020 13:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200509234124.GM23230@ZenIV.linux.org.uk> <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
 <CGME20200509234610eucas1p258be307cde10392b26c322354db78a9b@eucas1p2.samsung.com>
 <20200509234557.1124086-11-viro@ZenIV.linux.org.uk> <6f89732b-fba9-a947-6c61-5d1680747f3b@samsung.com>
 <20200514140720.GB23230@ZenIV.linux.org.uk> <f6fcfa46-6271-45ea-37c2-62bcf0a607cb@samsung.com>
 <20200514174131.GD23230@ZenIV.linux.org.uk>
In-Reply-To: <20200514174131.GD23230@ZenIV.linux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 May 2020 22:21:46 +0200
Message-ID: <CAMuHMdV78Y2Y_vkvbs2nt5LjM7D9te3ozr71_o2uGoNHSK4u=Q@mail.gmail.com>
Subject: Re: [PATCH 11/20] amifb: get rid of pointless access_ok() calls
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

On Thu, May 14, 2020 at 7:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, May 14, 2020 at 04:25:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Thank you for in-detail explanations, for this patch:
> >
> > Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >
> > Could you also please take care of adding missing checks for {get,put}_user()
> > failures later?
>
> Umm...  OK; put_user() side is trivial -  the interesting part is what to do
> about get_user() failures halfway through.  Right now it treats them as
> "we'd read zeroes".  On anything else I would say "screw it, memdup_user()
> the damn thing on the way in and copy from there", but... Amiga has how
> much RAM, again?

In theory, up to 3.5 GiB ;-)
In practice, 16 MiB is already a lot (mine has 12).

> OTOH, from my reading of that code it does appear to be limited to
> 4Kb of data to copy, so it's probably OK...  Hell knows - I'm really
> confused by those #ifdef __mc68000__ in there; the driver *is*
> amiga-only:
> obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p_planar.o
> config FB_AMIGA
>         tristate "Amiga native chipset support"
>         depends on FB && AMIGA
> and AMIGA is defined only in arch/m68k/Kconfig.machine.  So how the
> hell can it *not* be true?  OTOH, it looks like hand-optimized
> asm equivalents of C they have in #else, so that #else might be
> meant to document what's going on...

These #ifdefs are relics from APUS (Amiga Power-Up System), which
added a PPC board.  APUS support was killed off a long time ago,
when arch/ppc/ was still king, but these #ifdefs were missed, because
they didn't test for CONFIG_APUS.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
