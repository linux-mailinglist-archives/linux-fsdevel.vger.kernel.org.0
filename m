Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8CC1540DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 10:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgBFJIf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 04:08:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40332 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFJIe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:08:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id i6so4790107otr.7;
        Thu, 06 Feb 2020 01:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3+HaL0mMa5Ymai0xRUCfU92vYqWTyV3qW0zGR4Dk0o=;
        b=TcAr818vqjKZVL4/51CtBJBaezmFdcNM0/c0nNfkoBmEIVe5cQpWeJvh+lSTJLmzSr
         Am/5iDGyVm3CqYWmRYC2/7UsRL8Bdmdjxs7UOQ4JChv5aGbapRU8AibZFFGV3L6n/PGy
         JefsMgeetAt0r2xTyEmDKzi1x1lu/XpV0I7by/x2PtzDiPMedSHC6bUSKB4+q+n2Gqxw
         D6pNaEo0pusosLOaJ592PbmzNlftkEiKHV4YK6jCdIz6iUjwsBVCvY05VHXEvGs2eVg8
         yNYGOKabgwKlM8DuSQGfV81JuDXNDZjUYZrlqBCwQEP91YqHrtGwEC3lCSy/lZ8J+D+q
         EZ5w==
X-Gm-Message-State: APjAAAU45icAIBjKj4Y2zhaEv2TaRVq18ZEqaOq/djnkjQmhKyX+kmfU
        Fu3VQTgqecnSD+FJg6jsN3dYcgdeuFOEdGCQPt5lNhF+
X-Google-Smtp-Source: APXvYqwvjGuAJuSBAPSwrpyD3ZD5dZ7R9CuSb1K6yOoo54iS8ntKmeXBePPoOsb/IyrEro1R2xz7Xo5/LAalNRVsMNQ=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr29671803ots.250.1580980114141;
 Thu, 06 Feb 2020 01:08:34 -0800 (PST)
MIME-Version: 1.0
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
 <157528160980.22451.2034344493364709160.stgit@devnote2> <02b132dd-6f50-cf1d-6cc1-ff6bbbcf79cd@infradead.org>
 <20191209145009.502ece2e58ffab5e31430a0e@kernel.org> <20191209105403.788f492a@gandalf.local.home>
In-Reply-To: <20191209105403.788f492a@gandalf.local.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Feb 2020 10:08:22 +0100
Message-ID: <CAMuHMdWx4FmrGaefwkEBMGqCmJUSYxtAfkmFc7HM++fab2U-cw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 01/22] bootconfig: Add Extra Boot Config support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Steven,

On Mon, Dec 9, 2019 at 4:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 9 Dec 2019 14:50:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Sun, 8 Dec 2019 11:34:32 -0800
> > Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 12/2/19 2:13 AM, Masami Hiramatsu wrote:
> > > > diff --git a/init/Kconfig b/init/Kconfig
> > > > index 67a602ee17f1..13bb3eac804c 100644
> > > > --- a/init/Kconfig
> > > > +++ b/init/Kconfig
> > > > @@ -1235,6 +1235,17 @@ source "usr/Kconfig"
> > > >
> > > >  endif
> > > >
> > > > +config BOOT_CONFIG
> > > > + bool "Boot config support"
> > > > + select LIBXBC
> > > > + default y
> > >
> > > questionable "default y".
> > > That needs lots of justification.
> >
> > OK, I can make it 'n' by default.
> >
> > I thought that was OK because most of the memories for the
> > bootconfig support were released after initialization.
> > If user doesn't pass the bootconfig, only the code for
> > /proc/bootconfig remains on runtime memory.
>
> As 'n' is usually the default, I will argue this should be 'y'!
>
> This is not some new fancy feature, or device that Linus
> complains about "my X is important!". I will say this X *is* important!
> This will (I hope) become standard in all kernel configs. One could even
> argue that there shouldn't even be a config for this at all (forced
> 'y'). This would hurt more not to have than to have. I would hate to
> try to load special options only to find out that the kernel was
> compiled with default configs and this wasn't enabled.

Let's bite ;-)

If one could even argue that there shouldn't even be a config for this
at all, then why are there two? There's a visible BOOT_CONFIG config,
and an invisible LIBXBC config.

Are there other users planned for LIBXBC?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
