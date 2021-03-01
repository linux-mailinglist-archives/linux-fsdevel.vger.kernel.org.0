Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C35C32A4EE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343528AbhCBLgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346447AbhCAXrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 18:47:52 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0524C06178A
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Mar 2021 15:47:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id jx13so665125pjb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Mar 2021 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hOQErYBU0Jmcx6o4VWiTnlJfnMT/JJge44014ba2W/0=;
        b=PvDM4zpGo+maq3h18zbqqSLr4xfAHbrF2Y4A8p3mm843j9+T6FQYsPTKKsGBLI7MnE
         Co6cVVTonKIE8uQRpG5dX35uHM2V1meu0KbFCWLG06Ujwv0UpDTwzTepYtOmN3vad2Zm
         bkccmXI1xvxTCWkbTycKNmqRVHSs1+h6qdJy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hOQErYBU0Jmcx6o4VWiTnlJfnMT/JJge44014ba2W/0=;
        b=SZrBjkhwlLKsaFZDOAI2RZKCR+lfZL31HHzAC+yUWJ3l313RwF27kAFBZ0/lxOKxGy
         CbjAt7m+QsG6O8wm96vq9hnqlMEHEle64RL6Gm40VgIC8DoS9r4s8ab8q1oVtVIuLLDW
         7c76SRsbsQ8PDXImIs/7RVET+6dVwFyx/S0ddri/ICFKaoCdGOgukj7qnMtOe92vTsv4
         QUxHiJygSQ0xQ700N2HXyo1Dn7I0jE/2gczW1zWIh03cPO52PUSiSKQTh6MK1kAyKlI1
         kcYscRZ1sZZMqLTuz6qaGGBLSLwW3XmoCDCjeejy5eJ0HcNDIkq6NyTA3uD3cotw1HL/
         +Mog==
X-Gm-Message-State: AOAM531jE75AS5RsFOl6Rn4BgrKx0GQhE8b8wUD5+2jrS4lubhk8k372
        p2xJ8iogvYe/gIddXOL+u/QmSuYfxYJuog==
X-Google-Smtp-Source: ABdhPJwTbQ9pc38LCgPpVbkkulTN41F1Od+84KaTOP1mJpwQL15bFyw9h0q5Y3c/7j7HRiU4Mh/ynA==
X-Received: by 2002:a17:902:b70d:b029:e3:6c97:d180 with SMTP id d13-20020a170902b70db02900e36c97d180mr17932232pls.40.1614642432145;
        Mon, 01 Mar 2021 15:47:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a136sm18685061pfa.66.2021.03.01.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 15:47:11 -0800 (PST)
Date:   Mon, 1 Mar 2021 15:47:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sysctl: use min() helper for namecmp()
Message-ID: <202103011546.9AA6D832@keescook>
References: <20210104083221.21184-1-masahiroy@kernel.org>
 <CAK7LNARXy_puE7KZp2vjzn_KcW5uZ_ba3O5zFX46yGULjNhpZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARXy_puE7KZp2vjzn_KcW5uZ_ba3O5zFX46yGULjNhpZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 28, 2021 at 04:44:22PM +0900, Masahiro Yamada wrote:
> (CC: Andrew Morton)
> 
> A friendly reminder.
> 
> 
> This is just a minor clean-up.
> 
> If nobody picks it up,
> I hope perhaps Andrew Morton will do.
> 
> This patch:
> https://lore.kernel.org/patchwork/patch/1360092/
> 
> 
> 
> 
> 
> On Mon, Jan 4, 2021 at 5:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Make it slightly readable by using min().
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

Feel free to take this via your tree Masahiro. Thanks!

-Kees

> > ---
> >
> >  fs/proc/proc_sysctl.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index 317899222d7f..86341c0f0c40 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -94,14 +94,9 @@ static void sysctl_print_dir(struct ctl_dir *dir)
> >
> >  static int namecmp(const char *name1, int len1, const char *name2, int len2)
> >  {
> > -       int minlen;
> >         int cmp;
> >
> > -       minlen = len1;
> > -       if (minlen > len2)
> > -               minlen = len2;
> > -
> > -       cmp = memcmp(name1, name2, minlen);
> > +       cmp = memcmp(name1, name2, min(len1, len2));
> >         if (cmp == 0)
> >                 cmp = len1 - len2;
> >         return cmp;
> > --
> > 2.27.0
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Kees Cook

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
