Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D598F1BDA93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD2L2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:28:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59125 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgD2L2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:28:31 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MdNoW-1iuh7V0QCm-00ZRuF; Wed, 29 Apr 2020 13:28:29 +0200
Received: by mail-qt1-f182.google.com with SMTP id 71so1431749qtc.12;
        Wed, 29 Apr 2020 04:28:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuaeMu9/AjuDipLfLN315tZJAwUZQqGbnk7VJog+jkad7KXDSoyO
        VebC0GhF2CCjsTjSnKx/99gRhDgXWbgz1M/7Eqg=
X-Google-Smtp-Source: APiQypIa6TSw8+yjWo4LgdZcN78VVZq03VH3fd8N9jMLAVbifbgVTqRdEAU1CxrmrW/DkCSQUjz/sA0LJeq7jFPcccQ=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr33266506qtn.18.1588159707900;
 Wed, 29 Apr 2020 04:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200428074827.GA19846@lst.de> <20200428195645.1365019-1-arnd@arndb.de>
 <20200429064458.GA31717@lst.de> <CAK8P3a1YD3RitSLLRsM+e+LwAxg+NS6F071B4zokwEpiL0WvrA@mail.gmail.com>
 <20200429094201.GA2557@lst.de>
In-Reply-To: <20200429094201.GA2557@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 13:28:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1+DU+juB_SxAAK6WAMHwi7vGQS7T_Yw0Gvo4P4M8jggg@mail.gmail.com>
Message-ID: <CAK8P3a1+DU+juB_SxAAK6WAMHwi7vGQS7T_Yw0Gvo4P4M8jggg@mail.gmail.com>
Subject: Re: [PATCH] fixup! signal: factor copy_siginfo_to_external32 from copy_siginfo_to_user32
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0pgJ5+AUr0ZyAZ0GWg4eqDI1TnA/whWfuLpkrrMSvxYAWjINppE
 a7v/Ni2HcIVXKKwWpO6EnpmvcyOe0F5Ar+DzumTtjDwkyvsoWUEDtYRfZrJrzooiSz/8GjQ
 qiXdDOaE0kundOZXs40d686yOrTu1CHCpwIPasAhVGLbC9IZGTEU2/fhf11HAbf4YtVV8i6
 g/qyC1yHRA4zl1bYvXA6w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uZLu5qNCOnI=:SkzXkn6DWZomBu4HZnQGBD
 2kgdRSn4t5CJI8Wsq9jLbwCEr6+MpFosTMnh2L3Bag9xsujcFudbhIAy4KGCnj3+9dCqG42PA
 X6oT+a5dy/u6nGvKRvfgkkwPe9usVTHypWqyMmS8cTiK+IUyWd2m/eyEN9pqz2G3iJuKcXUby
 cl17xihPdmxb8W7AX2P+jEN6NNle9VtLW/tZepA2fyUQOPEQ5zGWd1wtXyrBsM1oP3GiQNiLi
 o2zV26/liDzNGtEQWPrhJN/NZjESzGtAdZoW/pO0+IHUAgRsSXtWrmbBH5kSy4Fso5LCmOw7k
 rgf7a/EADdwfzg8OAEF5ZqlYsJxWf/NK5YMAC/n6Iw/ncPEHrSDMJ4u6LffvPhDyy9MWt3CcG
 Tn5jxqkP1EUD68kJmOF6pCm6nCTArhm5VjmADtD6yx0Sy1zXXztP4ZsNdFIQBeDtyBOhDqFKK
 zfhMywjnem/aO0xoJOesgzvzEGKYpoYbMpbNQ2fPnpjzpe1PZePIRRSQElmSaQV2t0J0IxFZi
 PBTOmCGajnrkNy8CG9RVy+QDtKPjg3k7IuFGnrFNq/Hx5ROjALOxqZY4vq9mZBE+ZIm8aJNxz
 /RtsHAor6ldAP/sR9+JEjhxIeHm+2Slhfh0lp92JieGeITFM4t4IKobyGIZAitVO+1xtSDz55
 nAX6CkUyjn94xfXYpRjirE8G/YEDxQLOFx/6Opq12qrt8lxPRiVv7RXjFL7n/x6dEUiNvf1wc
 qqwslQVvSgpE1WP2pB1aB5ZZVLJFH4Rvphw/Jxn1yzk2fWuwBclynm8ZZExl8guqNwfIAd5gz
 kH2bRaxVSlXjTkybabnvVuijWDVuipq4UvhRsk/aFlAm5ZGdcU=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Apr 29, 2020 at 10:07:11AM +0200, Arnd Bergmann wrote:
> > > What do you think of this version?  This one always overrides
> > > copy_siginfo_to_user32 for the x86 compat case to keep the churn down,
> > > and improves the copy_siginfo_to_external32 documentation a bit.
> >
> > Looks good to me. I preferred checking for X32 explicitly (so we can
> > find and kill off the #ifdef if we ever remove X32 for good), but there is
> > little difference in the end.
>
> Is there any realistic chance we'll get rid of x32?

When we discussed it last year, there were a couple of users that replied
saying they actively use it for a full system, and some others said they run
specific programs built as x32 as it results in much faster (10% to 20%)
execution of the same binaries compared to either i686 or x86_64.

I expect both of these to get less common over time as stuff bitrots
and more of the workloads that benefit most from the higher
performance (cross-compilers, hpc) run out of virtual address space.
Debian popcon numbers are too small to be reliable but they do show
a trend at https://popcon.debian.org/stat/sub-x32.png

I would just ask again every few years, and eventually we'll decide
it's not worth keeping any more. I do expect most 32-bit machines
to stop getting kernel updates before 2030 and we can probably
remove a bunch of architectures including x32 before then, though
at least armv7 users will have to get kernel updates for substantially
longer.

      Arnd
