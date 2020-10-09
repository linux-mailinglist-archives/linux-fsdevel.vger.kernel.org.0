Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03A828880C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbgJILtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388164AbgJILtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:49:13 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520DC0613D2;
        Fri,  9 Oct 2020 04:49:12 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s66so8734634otb.2;
        Fri, 09 Oct 2020 04:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FC42SUkcezRphfcD8WLweSfGw44RXCucv/pNfOMEb2U=;
        b=RQ2sYXBaSgqVdgJSTEM1/zK3srNGSSiELmYM8/efK8uXnyUtSJRXIG6ZL7+KR08Kl9
         MHeWHnWGABdcnBzxukCPPQBAfWQo981nSeYjoGEox1rARpa3Zm2ZaZlZfRbhZtyXUWr8
         ICuLeEVuyK8gVfxXFfIp/hlhySENB80dFoHRxo0iNVAXdJPx7ETTgEUPxWKo7azIHFAG
         Z0n2ln5PGy1qjzpesazITQSoLu2Cwd+pdiYiGmPOmKdVrw3uohHOnWkEe5IZS2fVamwK
         9FVOOWcqkDiKTeXGtg+pNqsX5Bfax73gC0n+v15J19VC0jofnoCCwTgqhcTggHNo7WqU
         el/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FC42SUkcezRphfcD8WLweSfGw44RXCucv/pNfOMEb2U=;
        b=bMutn07em9EX6IIy94dILwuqX7mWiAR6t9End4OzQE4yCxKVzpwbuxJkHfm7iE2TB1
         n3xAcq+iJDopVzK3x842d4pG8vzvu6zhkN+Q80QD7soEKu4CWIdT8TEBa4Y8FHT44Pph
         p+/KhnhMGgb18Hh2quC4e+J5aFWGHU69q7/opbp3YSk1+IHzMVUTNKV0nro7zdtoVrwG
         yNcI4VKPFSnjpaG4JupLvj/iRsZSO7AD1nVXQHYHfWi3iYfAZDEb80a14fF4ZKwXpjYp
         l42O1+dezDhFrbUxrdThmByvTYRjrzMtIMIfbDjwzdCDBUZHOYzYNLT/s7c5Qq+xAnU3
         QfRA==
X-Gm-Message-State: AOAM5320fi8ZYfspMiNNCknZch+9Ae/L+T6srCiaSvQCkCHHQSweT2bX
        69XL7yDn+45+WR8eHmwpSy97323+r5W1OK6zipE=
X-Google-Smtp-Source: ABdhPJwSscbH17qEWjQ+QOyJ9UHDr426Viyrbk2OgRZn5SC1adi8UHAJieGfd9m3/m3aQMrFuIiKNraGShgW7xhRYtY=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr4056211otq.304.1602244152286;
 Fri, 09 Oct 2020 04:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <c53436d969cd70fd67b3eb8e02b75e138c364e91.1602093760.git.yuleixzhang@tencent.com>
 <2babfe21-beb8-762b-8ede-15f3467ca841@infradead.org>
In-Reply-To: <2babfe21-beb8-762b-8ede-15f3467ca841@infradead.org>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Fri, 9 Oct 2020 19:49:01 +0800
Message-ID: <CACZOiM2goO0hhHdnYNkaSNiO2bfL+xwWY=RbVytXuhO+s1D7-g@mail.gmail.com>
Subject: Re: [PATCH 08/35] dmem: show some statistic in debugfs
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, Paolo Bonzini <pbonzini@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks, Randy. I will follow the instructions to modify the patches.

On Fri, Oct 9, 2020 at 4:23 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/8/20 12:53 AM, yulei.kernel@gmail.com wrote:
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index e1995da11cea..8a67c8933a42 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -235,6 +235,15 @@ config DMEM
> >         Allow reservation of memory which could be dedicated usage of dmem.
> >         It's the basics of dmemfs.
> >
> > +config DMEM_DEBUG_FS
> > +     bool "Enable debug information for direct memory"
> > +     depends on DMEM && DEBUG_FS
> > +     def_bool n
>
> Drop the def_bool line. 'n' is the default anyway and the symbol is
> already of type bool from 2 lines above.
>
> > +     help
> > +       This option enables showing various statistics of direct memory
> > +       in debugfs filesystem.
> > +
> > +#
>
>
> --
> ~Randy
>
