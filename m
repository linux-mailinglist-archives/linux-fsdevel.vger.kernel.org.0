Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F58C1824AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 23:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgCKWVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 18:21:20 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:50763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbgCKWVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:21:20 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MfYHQ-1jniWk46VU-00g00q; Wed, 11 Mar 2020 23:21:19 +0100
Received: by mail-qk1-f170.google.com with SMTP id f3so3803357qkh.1;
        Wed, 11 Mar 2020 15:21:18 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1NrVE1szSl2hCxhmSdG53rWyaQCTZZHUSFzuAvOX7qz9FlmnF+
        FKpe+9KgM7wU5O4JEd9eVVyBlyY95z4mRI9ndsM=
X-Google-Smtp-Source: ADFU+vtUX6596ckwbsQtKLPYKkjWdRNNv2OExbN7pWVykWRKgnRWddSMydtufZDaxYnGmzl5giJGitq9nSLOAiz/v+U=
X-Received: by 2002:a37:8707:: with SMTP id j7mr2513764qkd.394.1583965277788;
 Wed, 11 Mar 2020 15:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
 <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com> <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com> <20200309160919.GM25745@shell.armlinux.org.uk>
 <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com>
 <20200311142905.GI3216816@arrakis.emea.arm.com> <CAK8P3a2RC+sg2Tz4M8mkQ_d78FTFdES+YsucUzDFx=UK+L8Oww@mail.gmail.com>
 <20200311172631.GN3216816@arrakis.emea.arm.com>
In-Reply-To: <20200311172631.GN3216816@arrakis.emea.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Mar 2020 23:21:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0QTKsqoxE7HS7aNrASSHOfFJHfp3+KZNTVoQ12wHi3VQ@mail.gmail.com>
Message-ID: <CAK8P3a0QTKsqoxE7HS7aNrASSHOfFJHfp3+KZNTVoQ12wHi3VQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-team@fb.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Y0fVglcNi3gC72aK5fXtxypkAayJT+12w8tKLgShmO81/UTcoGJ
 NdV/92mYk8imJkqroooPsdEHiKdRRN6F6UWDDjRr8+bYhc5r4TIZ8WmnatiYiN/Kg5yr1M/
 UbHjNq/hbtQbj/6+qkvyNKI17QCXz12qQ+d9JGjmlQin9Ezop/VL7stF0tRA2/xPKpmofuX
 M5f18TPitTjgFno3DmrZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sKJPphkq4EU=:s0gkVx3Zr91ZibRaHVQ6T/
 Bx8qEqbhocegEone2+WgCDYZxhn76WohWqU0SDLTtKHCR43POf57Tf3V3ZG5qvdShaZH2saWT
 9c/h9McjfTbNrnwr7DEjlVE3/R0c97BQkA8TLFDnZYbYP268BHe9Kg8OZlHcsVdD4d6+TAUCs
 xf8OWwH9BdY/cbBSp+zrturUtr2K35c76uOVGPACWaf4xPjCRI9BnzvxobPiP7UP2w659Q+sC
 7FdYkx0UPJTgeoeoREOBKODGMXQunqlZJqgTkrEXquJAQTdKNEB83gbf9Hcgwjhyppy4/tqa3
 akkuLAOvHM3GcRco3ahM3Le3IAcA3vWLUGMxt7bCqp/os1B7KNZ5YZLOgXiaaDwhFEn/Gw4zv
 XM113yRMdhImu3iDti7OfwGUa05JZYAy9Nll1mwi1MsnjOWf+k6erTmQ62Gfm6K19N6x4BM97
 i6DOpdVI5fGlypTbHVF49Qbi2rBcTx5UI/U4mUj0vcp3mAze9bOcHeGnXqzEwHAlGtv+VxIel
 DWp0mwQBglh5NPtiNazlec1dBFHNx9ssGPbMkqr92HLp4EA3+/jVl6EKnMzEHemFmO+3pVyZJ
 3+y0wXpOp/8hgUhHqOXUTq28EP6996iCf+NzM2d1qEHIyt3na19BBl9bpCtNRHhb5hLlZkgja
 YK0MvMJwRmZ7osBuNW55IRjuX8adIzLY/hKRhX9hFNI7c+thIT7q1uToHb0tQi/3HSlti/xQf
 huMxHQy/crOq5HKWWAar/Sc6wAEN+v1C0y3+FjA+2EYT2dFD4wZrU1WDUmd+gLe/Uv7Q6NQY3
 UwHZ2s00xnp47xalH6ACgrI14db+S11O2zzm/D9pic+xBS6wwQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 6:26 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Mar 11, 2020 at 05:59:53PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 11, 2020 at 3:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Do you have an estimate of how long writing to TTBR0_64 takes on Cortex-A7
> > and A15, respectively?
>
> I don't have numbers but it's usually not cheap since you need an ISB to
> synchronise the context after TTBR0 update (basically flushing the
> pipeline).

Ok.

> > Another way might be to use a use a temporary buffer that is already
> > mapped, and add a memcpy() through L1-cache to reduce the number
> > of ttbr0 changes. The buffer would probably have to be on the stack,
> > which limits the size, but for large copies get_user_pages()+memcpy()
> > may end up being faster anyway.
>
> IIRC, the x86 attempt from Ingo some years ago was using
> get_user_pages() for uaccess. Depending on the size of the buffer, this
> may be faster than copying twice.

I guess the tradeoffs for that were rather different, as x86 back
then had no ASIDs, so changing the page tables required a full
TLB flush.

         Arnd
