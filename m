Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBE17D382
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 11:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHK7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 06:59:13 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgCHK7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:59:12 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mbj3e-1jlai033hm-00dEKm; Sun, 08 Mar 2020 11:59:10 +0100
Received: by mail-qk1-f174.google.com with SMTP id e16so6627426qkl.6;
        Sun, 08 Mar 2020 03:59:10 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2tx6nBbu9BZm/VaD/fTr4TtFrqC3GIVOZxN7EMTYWXNWntJKQZ
        zc+o8+fAWYojr+gWZYmaEcXHUZ3BLPyvp3okdOI=
X-Google-Smtp-Source: ADFU+vtLZCrqsvoVRLgLjaKncW5qncKt1oeFxxk4ajRHsCJw8gSTZvblgXUZetJgeQGkfwQsqjkOMZPRrTin3JkbS24=
X-Received: by 2002:a37:b984:: with SMTP id j126mr10069404qkf.3.1583665149525;
 Sun, 08 Mar 2020 03:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com> <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com> <20200306203439.peytghdqragjfhdx@kahuna>
In-Reply-To: <20200306203439.peytghdqragjfhdx@kahuna>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 8 Mar 2020 11:58:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
Message-ID: <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
X-Provags-ID: V03:K1:DheoUgROyUqGqcI4pA5GCMcqVMpjZnw/PkO7ntC55mREQOoV9L4
 WBFLPxlDsBzM+eNxaHnH9mbPs4MvCWGAN4dTsJqJ4gGPYS0YCQHu+LCqgRBVPwJmEAAhcQq
 0+j6SLlqfFXktNJQY1+F5SVRW2yRUVUklyXLqA2CO+C/fEXCdia+ytDo2EMv+8X/u9bL1aQ
 yfyzwT91oiDBce55wyAkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kpVgpSBnjp0=:P9TLuf2nR248rJ8L86D9iP
 +RrntFKmM6RoDUEE4PdJKFAY+Qm/Kl4/s1ujBSLuXSQKmDltLoJETpzA6Feiv+bqUo6UyE4Yg
 +h2xCM/v37Wo9EYGuIhRPU3AwXiPUBscwjZ0xFTNOnUYU9/Xyl/jeZkEIa5Hm3d3lZQYWWd4I
 mKPwi9CStKxjxjLBvU1aacACOT0RpAhhItc3/szQ9+SRbw4nzZP2u2TIWCl+9g9tXDekDwfbH
 QGZo627rcEMyqVgEVOtsUvhS4afpjf/r5l936nlFTLsQA0nkTlqME1J4fRhw7X1P+DewPL9xg
 H9p8B3IUNgBS9vULYmhCJsjKRb4v1VY7KouLymIWxwRiNXp92QM0J2TpRwyyWD5JN85y9xRuJ
 EiLBsumJ42Y9AfWHrdIWUOFSFb9pTnWCcRdl6vDI4TgyqGyVmOVtIl1vxPqih1seaxtsj+CXm
 1gcT6jaXgZnt2r23ZlHAttrLLJc+RsRnbR7bToQF9uZ+62+T23cL7zkQgv49oI42MSB9PFLW2
 dRzThnm0+JiGvyb6t/L+BXVwdklJqPcNAeumOHv0uum/NKJzCJJFilHwv4ldrojcv8cywbpGz
 L4XjxQVyDCtgZOdffNhu26UiznP5wFp2BiT1p/pVahnXBwDba3gnrtc2NI4OmRHJyFBhR/EY1
 GUyR0LWLci5rXjAlUYXfsxwJXt+Mgk8I3aooMw/oiqz6V6e47oMKjY6CxK0EgkCWA6vULoR/l
 wz9tODNKHpvug0cMqo9uzvdZpZAiwhBfJj8Lard3xYfEivXT67lVQczgvXMFExXVDPEVl1YfR
 FyjXlq039IuAs3Q0gsFs3O7Sac6QRjgaJRgJRgH0MzLgVk2c5c=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:36 PM Nishanth Menon <nm@ti.com> wrote:
> On 13:11-20200226, santosh.shilimkar@oracle.com wrote:

>
> ~few 1000s still relevant spread between 4G and 8G (confirmed that both
> are present, relevant and in use).
>
> I wish we could sunset, but unfortunately, I am told(and agree)
> that we should'nt just leave products (and these are long term
> products stuck in critical parts in our world) hanging in the air, and
> migrations to newer kernel do still take place periodically (the best
> I can talk in public forum at least).

Thank you for the clear answer!

I agree we should certainly not break any such use cases, and for the
8GB case there is not really a good replacement (using zram/zswap
instead of highmem could work for some new workloads, but would be a
rather risky change for an upgrade on already deployed systems).

I hope it's ok to ask the same question every few years until you are
reasonably sure that the users are ready to stop upgrading kernels
beyond the following LTS kernel version. We can also do the same
thing for the other 32-bit platforms that exceed the maximum amount
of lowmem, and document which ones are known.

In the meantime, it would seem useful to increase the amount of
lowmem that can be used by default, using a combination of some
of the changes mentioned earlier

- add a VMSPLIT_2G_OPT config option for non-LPAE ARM kernels
  to handle the common i.MX6 case with 2GB of RAM without highmem

- make VMSPLIT_2G_OPT (without LPAE) or VMSPLIT_2G (with
  LPAE) the default in most ARM defconfig files as well as distros,
  and disable highmem where possible, to see what breaks.

- extend zswap to use all the available high memory for swap space
  when highmem is disabled.

- revisit CONFIG_VMSPLIT_4G_4G for arm32 (and maybe mips32)
  to see if it can be done, and what the overhead is. This is probably
  more work than the others combined, but also the most promising
  as it allows the most user address space and physical ram to be used.

       Arnd
