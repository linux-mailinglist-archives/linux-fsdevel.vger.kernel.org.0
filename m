Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518FA15FF54
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2020 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBOQ7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Feb 2020 11:59:24 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:37753 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgBOQ7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Feb 2020 11:59:24 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MirX2-1jhrut2cnk-00erXF; Sat, 15 Feb 2020 17:59:19 +0100
Received: by mail-qt1-f169.google.com with SMTP id r5so9165819qtt.9;
        Sat, 15 Feb 2020 08:59:19 -0800 (PST)
X-Gm-Message-State: APjAAAUU7V/VEjh08tJsUgR9jtV806ehyTj0lohYm7hcYVBEQD2aiLeL
        DvdQZNNCger7oMDwEZay9s1jhh270/NuDvriPRQ=
X-Google-Smtp-Source: APXvYqyjkaMRW1i6+nG6Xmmiwkn07p7cDmjHpBuvGvwJKBe8csT7ZhEBB5nRrhRTCOtne+pNbnl2kdB0/zhmsFwcHpI=
X-Received: by 2002:ac8:1977:: with SMTP id g52mr6981067qtk.18.1581785958432;
 Sat, 15 Feb 2020 08:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com>
In-Reply-To: <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 15 Feb 2020 17:59:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
Message-ID: <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>, kernel-team@fb.com,
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
        Chris Paterson <Chris.Paterson2@renesas.com>,
        cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wnLkh62oA9Yjc9Ym349XbhSeygty7EwrKi7YllCXkP9M5H6i9wg
 F5Uua1nv3gvu0s2M9m2kK5vM6fYhZiwVW+nGqpySnfj4nBQscb4zTh3JPWdkL8QKFX/0Sta
 JLWwOwv+o/rDSB3AvfipOidUwmF9Ucpr6BgG6DSObtUt20mF2C0vwH/y4zeS14Hb93ZHNeZ
 eS93xr6yTncDZaD7uwr1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VHHCUnWwrnY=:eLDhdH48i9tz/1z7XjpRgv
 MJOz4odIDmTcTmYRYm5+EbzH6QJfTS7m0LJzkQt2ovwHy+FGOuqzr06qmEG6p5hvKN7f93ZY0
 f+kgqbdE37+Ru5WWssnThfH0qVYZvt4JEeNe960VxVZx4B2F4PvwMPzwJC7vVZ58IfqwnO1ZO
 RZgESkc5//k0yBFYkrvodcMLNQRsn2QyAYVPCRldX+T4zcxjrppBAibFj/krZdtaszvW1Jjpp
 uV1kWMfVHjnN9p0+uVKabu9KYf/xOFETX1L51/5d/z5HS0mSmDcVuTw7o7iqhYrYa+D83/u9D
 YhQvkJUkbtEyp5ytH1fCGZKcOCPFjN4ZiUttgmXQjPuqT6ARTsEKAFYN31bsqOoBua6RmFYWV
 yQvW3ems0wEObdVeTJqBMw8D+hJJuNgRYNwom+bcHVz3gbfcUXhMmRUIDfWqyNQP2X4z16Gx0
 4m6KuBlk2TPB0aSaEWOeq9gk1e6XjKlRVk3X/r+QkD/8NJHyEiQ/RIjGtCwlOKk5DEXY0CGvu
 jEk3V5h7FJJN7IeJ4cHRts3ehgiPYAmO/y3L+v3Q2nkRqa/DlnPr70ZNR35OgxcqsumbIF7nm
 nEUVn6H5cZYeT/uJ6tit3r37SjQWAatcKgpAKBf+WQ3TOcOiAiqGwf+Y3bCYZy2CG033R3cKO
 Dsl7ct/OhNCrkUN2K5hztoLFQpZYBX5+KUhIPPVwDYGuxQlH2bl8UjzA0ZVOd60k5WEsSmzFX
 zvPQ9+KaKdgGVq2dCEYfdMhkXPHnX43MCOo7llYtjTl6FzVpBvv47ziqtNofENZ32a+TA0Kzh
 kZm3asfEpHL+EcKD+ejbNwiHIRwXknR/EMZZGhe69OkEMREP+w=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 15, 2020 at 12:25 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Feb 13, 2020 at 5:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
>
> The CIP-supported RZ/G1 SoCs can have up to 4 GiB, typically split (even
> for 1 GiB or 2 GiB configurations) in two parts, one below and one above
> the 32-bit physical limit.

Good to know. I think there are several other chips that have dual-channel
DDR3 and thus /can/ support this configuration, but this rarely happens.
Are you aware of commercial products that use a 4GB configuration, aside from
the reference board?

For TI AM54x, there is apparently a variant of the Dragonbox Pyro with 4G,
which is said to be shipping in the near future, see
https://en.wikipedia.org/wiki/DragonBox_Pyra

     Arnd
