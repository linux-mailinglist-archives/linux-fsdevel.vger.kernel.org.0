Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7607F181E91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgCKRAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:00:13 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgCKRAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:00:13 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MMY9X-1ivvRM2DLD-00Jcd8; Wed, 11 Mar 2020 18:00:11 +0100
Received: by mail-qt1-f182.google.com with SMTP id l13so2077776qtv.10;
        Wed, 11 Mar 2020 10:00:11 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2SxjATqTQC6mtTtIrXmjGSy1f5MNAZ2iMO52RzX+KIMu/mGUVQ
        5v6IFyZeDSWkBKc1LLX6TBympTxZWkDV006ADzE=
X-Google-Smtp-Source: ADFU+vu9fVJOAF+9P6CbsNSvk6tSClNpCucHRIY2BueNHAFfNflfKP7sKJEZulP0d/np9ao6uI0PuseGoAEvcwJyhAc=
X-Received: by 2002:ac8:16b8:: with SMTP id r53mr3575245qtj.7.1583946010319;
 Wed, 11 Mar 2020 10:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com> <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com> <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
 <20200309155945.GA4124965@arrakis.emea.arm.com> <20200309160919.GM25745@shell.armlinux.org.uk>
 <CAK8P3a2yyJLmkifpSabMwtUiAvumMPwLEzT5RpsBA=LYn=ZXUw@mail.gmail.com> <20200311142905.GI3216816@arrakis.emea.arm.com>
In-Reply-To: <20200311142905.GI3216816@arrakis.emea.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Mar 2020 17:59:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2RC+sg2Tz4M8mkQ_d78FTFdES+YsucUzDFx=UK+L8Oww@mail.gmail.com>
Message-ID: <CAK8P3a2RC+sg2Tz4M8mkQ_d78FTFdES+YsucUzDFx=UK+L8Oww@mail.gmail.com>
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
X-Provags-ID: V03:K1:KDAXYoW2MxfxD7Sj0ctMmZ5aMLMVbtt5fi0P1ZQqIYgqgIK2MMv
 qkCLT0wBmUi+ZlPtBTPkWkci1XkrRMaJe1fdGGGQ2wglRIb/CCB6+84elXs1o14Cct2h0hy
 zkRsS5njtlvMVDe1P6BkcmY/43+4Q4rqr2V2OyiuG/NIEhrgW4xwmXcvaAGN3JZ+TR/04xi
 SFMS7sKzb0fv6ruHUvmqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nqV3Nz4NHWI=:N/KXbDYH0Kj/MG16jop7Qw
 deCeyFqWaIsJssrMr8e4A41NSSvVAxxdX+0fMASw7lWg2Us62NopEeybtACbFNLij84KJt0W+
 D/+ln4Qsy0qhPsnXN9Xd7oqCRBN2Y5K011oKgVyjkQlhWmgDwOP1A7Y1ckiwtAgI60gMXoUXm
 fNDCgtXsV/FhuVVXLTkV73MQdjb5krQaduwqajjkU7BZfbrADtrxN0tJF57LfoMWvceDFLtsI
 xWCwI19926M0pTdzb9Hbh5MxHniLtOJebm9JYHl4hBp03SZ3XWqKmCfKu0RD0RfflHUghqk6H
 2OcEP1iZO0PTY0o9NxRqrU/d2qcGIqbb0dKhtit+1m54fOSTVxQ5hLhEnkq/rQXyZ5YJdFfCX
 GvKPng8Ffkc67GcRnpzOJtovpO4BcczQUO+TfrIVP3DBPB8b72pAi5DtH+b0jxbGpYKJWx6pA
 25EBH4Z0keVEvX0AVyr5imYhMnpex7i8Tc7DxbxLN6tmzvADWmb1OUGLsgLwb+m7OcUYJEpa0
 FsTc65cGA7g+cmSJ5Ja/eHYHwqgAIctN+1QeygPa4OUUBfPXi3qPpIZRxsoSc6DUA/oEVS2bX
 ydU0BUmtlKntQFalMHY2IDvuH69+3svMDkSoh1b6/nuYPwbV6fVRj7wH08x4nixdhO4jyevD5
 GydfviNUlbdORr0nN7MNNZEmY15Y9t1n2RZtLQlHdxM7S8O9erG8iGKsXDp5cqDVoSJyj4NLI
 I1tvWvJ6C861SZZipYvZcRfx8GxgtjoxVPo8dFW7CiaU0eafJDZ+s2hSWRCCxa7wwClHBbfpC
 aSx6DxeK3BZkYv/EHxzd5v7byjzReRo/OFwboxdg0jJxmmCEn8=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 3:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:

> > - Flip TTBR0 on kernel entry/exit, and again during user access.
> >
> > This is probably more work to implement than your idea, but
> > I would hope this has a lower overhead on most microarchitectures
> > as it doesn't require pinning the pages. Depending on the
> > microarchitecture, I'd hope the overhead would be comparable
> > to that of ARM64_SW_TTBR0_PAN.
>
> This still doesn't solve the copy_{from,to}_user() case where both
> address spaces need to be available during copy. So you either pin the
> user pages in memory and access them via the kernel mapping or you
> temporarily map (kmap?) the destination/source kernel address. The
> overhead I'd expect to be significantly greater than ARM64_SW_TTBR0_PAN
> for the uaccess routines. For user entry/exit, your suggestion is
> probably comparable with SW PAN.

Good point, that is indeed a larger overhead. The simplest implementation
I had in mind would use the code from arch/arm/lib/copy_from_user.S and
flip ttbr0 between each ldm and stm (up to 32 bytes), but I have no idea
of the cost of storing to ttbr0, so this might be even more expensive. Do you
have an estimate of how long writing to TTBR0_64 takes on Cortex-A7
and A15, respectively?

Another way might be to use a use a temporary buffer that is already
mapped, and add a memcpy() through L1-cache to reduce the number
of ttbr0 changes. The buffer would probably have to be on the stack,
which limits the size, but for large copies get_user_pages()+memcpy()
may end up being faster anyway.

      Arnd
