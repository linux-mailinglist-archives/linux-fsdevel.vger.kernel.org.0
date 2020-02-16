Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F3516065F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgBPUiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 15:38:46 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPUiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:38:46 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MOzCW-1ipDBY1olw-00PNZ6; Sun, 16 Feb 2020 21:38:44 +0100
Received: by mail-qt1-f170.google.com with SMTP id i14so3495619qtv.13;
        Sun, 16 Feb 2020 12:38:44 -0800 (PST)
X-Gm-Message-State: APjAAAVQB1ZFqPArWJxfpy4FpDX1QO9LhlLggNsaxKs94ip8V/b368LQ
        TiKErzLRSXkRtCLKgcAMFtLXd3BGz4ysNm2OnoU=
X-Google-Smtp-Source: APXvYqzGbYZ4aYpEY0TUWZN5AxiKnI5sM7fs3pGtoCEgh1lCGT2r9R0o04dDMj4EezabIIFY8gGD+8mZfxHFiF3300Y=
X-Received: by 2002:ac8:3a27:: with SMTP id w36mr10771015qte.204.1581885523228;
 Sun, 16 Feb 2020 12:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com>
 <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
 <CAMuHMdVpTngVXUnLzpS3hZWuVg97GVTf2Y3X8md--41AtaD1Ug@mail.gmail.com> <TYAPR01MB228505DD9E7C85F9FA4AA785B7170@TYAPR01MB2285.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB228505DD9E7C85F9FA4AA785B7170@TYAPR01MB2285.jpnprd01.prod.outlook.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 16 Feb 2020 21:38:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Za8dthPE7czQs+rK+xUq+ZZC4Sbj8QF5YjXvtfzop4Q@mail.gmail.com>
Message-ID: <CAK8P3a3Za8dthPE7czQs+rK+xUq+ZZC4Sbj8QF5YjXvtfzop4Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Chris Paterson <Chris.Paterson2@renesas.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gZxUUnC0/X551f/KUXxXG4ss9wKBh5msR+xhojKXYS/iO5TX7gk
 O/rtvx0vGNDeDzfLKmXEY7KuXuzu6OTPM1VaTDkxEuXBIFHgdnmgPDth+HOE8s9fC31Bp5Y
 lMs5YGUBVi6Mi8CTrj53jHgJemDj0khciXVQDEx2mCjcPC+poBoXoEkM2E2FGteEMEYAkFL
 T7JXvloaDe4GtZzauy3kA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x/TUiPaEJdA=:YqkHjNVh9qsbDacAgIEJ3A
 8Keqiv3TPpTAyvzlkFHOVAaw16hGQqCAvh3ZpFda2UYn3U9xNVNzIMIW3mnQWFj34QGMEXsiA
 uFmB8UQQZr7qa0o/J1UbP502x5tTo542lyGzInP7EYtAlfOAaYoleGX1zrPq2PQ6rd3sXtU+X
 lc3RjDfbaKmhueN2R1gw/8QY9kOTqn0DwLfZyDIunV7GU1Hjwwy64pYuwhcj3Mhq9tGF/CpNG
 kV6N80IcqMmKgrGRKudWnxa0xYV8NEGvDE6kYG3NH+iXW4EfGKZHjObNuf9iSrk8fyj+O+NG7
 ACAmz3MDRqpCZ90Q1V5Zd4J+v42HI7g2zImvhmrOZa+gQgGqw47+7Zdpr2MzxaQ/NJLamZ64C
 u9vCLATX5Mf3UO3eNN//0ZAznM4dS83XYGO5fTxEd1tyldf3MKp0HoOyin+TWJ/y9dz4e9XgF
 7SznfrvnVkCum76q1I2N82TaM4qZQ7WXqN/Q6w8Oc10n0Qzvedzvln1Hzqgpmki3ZM1fEWFN7
 qqsJ+ZVvEKYFC2IAB74rqaVVCqUmVQWT/eJQdrRokT7vMfmJmBRQ/KDWuTSIefsVnktBqHSHW
 l9ripVws+aVcD1HGijn4cjz5x1SvGcfSwqz0ReEnrc81U+07IRlZlY5rJqZnEp1bXd+8tzrhr
 QDJynW8XRKKQKw1cvUqIN/4tqqAd5E1U7oxFIEaYk/LNUpp2gAhG5EJ3rrwg+aLKR8KcTCr8h
 0eXVjzKbqvEt8gYpo6Wv+ZCP+cyLf/l0samyt7tWmOTbuUtrSZwH9fK+QzZ9hCAeFwedb9Pr8
 OKXc+U7bUoDuCLcJF100zQrEky4V/kO0ehn1YJort+zzNnhitY=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 16, 2020 at 8:54 PM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Arnd, Geert,
>
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 16 February 2020 09:45
> > To: Arnd Bergmann <arnd@arndb.de>
> >
> > Hi Arnd,
> >
> > On Sat, Feb 15, 2020 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Feb 15, 2020 at 12:25 PM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Thu, Feb 13, 2020 at 5:54 PM Arnd Bergmann <arnd@arndb.de>
> > wrote:
> > > > > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > The CIP-supported RZ/G1 SoCs can have up to 4 GiB, typically split (even
> > > > for 1 GiB or 2 GiB configurations) in two parts, one below and one above
> > > > the 32-bit physical limit.
>
> Yep. One example is r8a7743-iwg20m.dtsi.

This one has 2x512MB, with half above the 4GiB limit. This means it needs
LPAE to address high physical addresses (which is fine), but it does not need
highmem if one uses an appropriate CONFIG_VMSPLIT_* option.

> > > Good to know. I think there are several other chips that have dual-channel
> > > DDR3 and thus /can/ support this configuration, but this rarely happens.
> > > Are you aware of commercial products that use a 4GB configuration, aside
> > from
> > > the reference board?
>
> iWave Systems make a range of SOM modules using the RZ/G1 SoCs.
> I believe there are options for some of these to use 4 GB, although 1 or 2 GB is
> used in the boards we've upstreamed support for.
>
> There are also other SOM vendors (e.g. Emtrion) and end users of RZ/G1,
> but I'm not sure of the details.

Both iWave and Emtrion only seem to list boards with 2GB or less on their
websites today (with up to 15 year availability). My guess is that they had
the same problem as everyone else in finding the right memory chips in
the required quantities and/or long-term availability. iWave lists "By default
1GB DDR3 and 4GB eMMC only supported. Contact iWave for memory
expansion support." on some boards, but that doesn't mean they ever
shipped a 4GB configuration.

       Arnd
