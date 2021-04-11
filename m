Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80C735B4AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhDKNkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 09:40:13 -0400
Received: from condef-09.nifty.com ([202.248.20.74]:43935 "EHLO
        condef-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKNkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 09:40:11 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 09:40:11 EDT
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-09.nifty.com with ESMTP id 13BDVpsN009523
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Apr 2021 22:31:51 +0900
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 13BDVVVa024207;
        Sun, 11 Apr 2021 22:31:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 13BDVVVa024207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618147892;
        bh=6YwTKBbNoleuwW/G8t5rDVU9qUR+RbEgL+hiFtrsKVs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LkiGA8TvWpNqtWsDSinqFq7t+F9dy46aQ2rxTrd0R47jfQhHUQsMXUBZPZ9Sh6MAh
         kNiUvQWFb0i31P1WcVgtKh6VVhz+3mTNPlwKNZ4o3GKboBsrbj3ub+wV31oV/xiLTq
         6qzik8NAwcBO627UcZTRRfT7+H6aMATl0+Ng3V13GoJLdri2db2vXKWZCB/EhsnaFO
         sQKvU6eYKlj6XsnsPxP7NgEiuCd8GeNWHVhvuf94ST5Xut7czUyl1xeMKSTuFtSOE3
         LDWe6YOOuhbWeP+Xl8a2v8ATd19ek5fJIMZ+R7ZoAxs2D6kYOBzJtXMFQseeyxIcss
         dF/hq/eCHKfpg==
X-Nifty-SrcIP: [209.85.214.172]
Received: by mail-pl1-f172.google.com with SMTP id y2so4938957plg.5;
        Sun, 11 Apr 2021 06:31:32 -0700 (PDT)
X-Gm-Message-State: AOAM533Oye4OhFGf/2vU5vTtXVtY8K/mwU+KLpmjvVAOEbFSP/79CwSN
        0Y+iejjDT3AKejDxtf91OxHGoOJTqGc0ncPySnk=
X-Google-Smtp-Source: ABdhPJz/zO015Um0WHBYZpS4w2WRTzh/PGFAlI18DvqL4z8DHDt3CzMo8Fo5G4kLOulICfjgNhq5KCF7teX2JheZRjc=
X-Received: by 2002:a17:902:d645:b029:e8:ec90:d097 with SMTP id
 y5-20020a170902d645b02900e8ec90d097mr21674078plh.47.1618147891413; Sun, 11
 Apr 2021 06:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210104083221.21184-1-masahiroy@kernel.org> <CAK7LNARXy_puE7KZp2vjzn_KcW5uZ_ba3O5zFX46yGULjNhpZg@mail.gmail.com>
 <202103011546.9AA6D832@keescook>
In-Reply-To: <202103011546.9AA6D832@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 11 Apr 2021 22:30:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMdf0ZGaH3VN8S56OH2-K+ZgWzH83FXSJ-=s3qCimYyA@mail.gmail.com>
Message-ID: <CAK7LNARMdf0ZGaH3VN8S56OH2-K+ZgWzH83FXSJ-=s3qCimYyA@mail.gmail.com>
Subject: Re: [PATCH] sysctl: use min() helper for namecmp()
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 2, 2021 at 8:47 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Feb 28, 2021 at 04:44:22PM +0900, Masahiro Yamada wrote:
> > (CC: Andrew Morton)
> >
> > A friendly reminder.
> >
> >
> > This is just a minor clean-up.
> >
> > If nobody picks it up,
> > I hope perhaps Andrew Morton will do.
> >
> > This patch:
> > https://lore.kernel.org/patchwork/patch/1360092/
> >
> >
> >
> >
> >
> > On Mon, Jan 4, 2021 at 5:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > Make it slightly readable by using min().
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> Feel free to take this via your tree Masahiro. Thanks!
>
> -Kees
>
> > > ---
> > >
> > >  fs/proc/proc_sysctl.c | 7 +------
> > >  1 file changed, 1 insertion(+), 6 deletions(-)
> > >
> > > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > > index 317899222d7f..86341c0f0c40 100644
> > > --- a/fs/proc/proc_sysctl.c
> > > +++ b/fs/proc/proc_sysctl.c
> > > @@ -94,14 +94,9 @@ static void sysctl_print_dir(struct ctl_dir *dir)
> > >
> > >  static int namecmp(const char *name1, int len1, const char *name2, int len2)
> > >  {
> > > -       int minlen;
> > >         int cmp;
> > >
> > > -       minlen = len1;
> > > -       if (minlen > len2)
> > > -               minlen = len2;
> > > -
> > > -       cmp = memcmp(name1, name2, minlen);
> > > +       cmp = memcmp(name1, name2, min(len1, len2));
> > >         if (cmp == 0)
> > >                 cmp = len1 - len2;
> > >         return cmp;
> > > --
> > > 2.27.0
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
> --
> Kees Cook
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Applied to linux-kbuild.




-- 
Best Regards
Masahiro Yamada
