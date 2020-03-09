Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF217E145
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgCINdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 09:33:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:53183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgCINdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:33:46 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mft3h-1jrX2P2EMT-00gDOE; Mon, 09 Mar 2020 14:33:44 +0100
Received: by mail-qv1-f53.google.com with SMTP id m2so4309429qvu.13;
        Mon, 09 Mar 2020 06:33:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2cGAClHxhhKYxLdxfmsD+WXhy1WPw1CGiz4PpyJrVPFMQhm1vZ
        gxUOAsFjnRqYkKxWoVVmtYkFkSBzVSkA5bYA5zg=
X-Google-Smtp-Source: ADFU+vsS4g4CC/jX/g0SgAYUCTcdMUWjdRoIcEGypTKOhZlhcLLVL+lmJ8nsucH78bEHlCzzMXlxQq29RStvENsZj44=
X-Received: by 2002:a0c:f647:: with SMTP id s7mr14720813qvm.4.1583760823316;
 Mon, 09 Mar 2020 06:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com> <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
 <7c4c1459-60d5-24c8-6eb9-da299ead99ea@oracle.com> <20200306203439.peytghdqragjfhdx@kahuna>
 <CAK8P3a0Gyqu7kzO1JF=j9=jJ0T5ut=hbKepvke-2bppuPNKTuQ@mail.gmail.com> <20200308141923.GI25745@shell.armlinux.org.uk>
In-Reply-To: <20200308141923.GI25745@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Mar 2020 14:33:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Gz5H_fcNtW0yCCjO1cRNa0nyd568sDYR0nNphu49YqQ@mail.gmail.com>
Message-ID: <CAK8P3a2Gz5H_fcNtW0yCCjO1cRNa0nyd568sDYR0nNphu49YqQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
X-Provags-ID: V03:K1:4Uk+eoxAdYLQYHRtietrYb/hTUc9UW68fZ0BAFbzJwMndYqTN4Y
 sTOPub1ZgVM71gXs3eC8FIDH0TINzzRgwsAbaNrajuJNM8rOOm+L5YzOyby0c2wyVccUHbS
 wvM2hT/dKoAJqHTNDktPnQmeRsPrd0uzzuqgJFJeAKkD+5iv7Er0Bp9nXGMn5MPodnNyptz
 gPERQcI/KqH3hodQSIklQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H87OSnfdRG0=:3Huc2lYEQZdXcoQyysvwu/
 MAAnJcFQsh7prCScZjCUCeiKCR14VSlb333panzZgcBxJAD2uCYrcZlk855x/hV/CoJY3jB5S
 PIbzwXAPWyb0iWqwH6ASOSNT8CduNHk3JQqdF5HWk7jhvHblMPjltBtU2PzToD7HhYgSOMjI7
 Hn9ttSzzgQARATgxNtTmzDCmc91V4u84BSf6NRle04a8gvGmFU76fxdXk71UGDLSRhpQa3clg
 GqRxgn8w4TxBCmGZX6slaYcyHYKqe77Jdb1xYXAcuVVnMGqyWcYfsQaHdwpOnZLjIhmhGKKK2
 /CbUu1MaRoat9o16AMShuyB+vYAqTcONL2pFPtW0+BUtAK7ZDl5IsaZv+/YgFpjo/MVAAKQTT
 R5Q2TF3c9b1n6kbWYNWGYo3mMjjcQIjf16meh9Hx+oMEdl5w+kPH5T269PZ1GvL2b9UJPMoDK
 0+SdJZyP5Bgedn2COyuPlunE6Kyg1Oq4bslI4U48OyO7M4DKUFcEXrNfZRtzQT5YAUU9u9MTU
 1eOuRu894Wc2tlJzylqH0lvsG6QZsukyJ5ZwcSN/JPMEVpdStFgfSQneRiGrOoI8aERZAS6ak
 JdSgN+jsLsO+M7m/G9qoDIFP8qH9V6KP0m0BGuPRszLZlUZgaKTVKY+6O4pNzetH97w9rIoAD
 9ugEDpjccUr6wYECB76ZMdz1oSDdEYN0AePLPptxXIN5Oxwu+fOJVZUDXngIPrOSqPRvY4VBU
 +8rcPB4kJUA1r+HMyJjBivMwSPNM3+lIvUXOt/pjpURU8Hb6wrbU90B3YN3NiWKvdsKpCalGo
 7XVzyBzrmdDtDpJKubwKCqqB5Q03xmGDsnypK3l5VBB5Eukits=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 8, 2020 at 3:20 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Sun, Mar 08, 2020 at 11:58:52AM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 6, 2020 at 9:36 PM Nishanth Menon <nm@ti.com> wrote:
> > > On 13:11-20200226, santosh.shilimkar@oracle.com wrote:
>
> > - extend zswap to use all the available high memory for swap space
> >   when highmem is disabled.
>
> I don't think that's a good idea.  Running debian stable kernels on my
> 8GB laptop, I have problems when leaving firefox running long before
> even half the 16GB of swap gets consumed - the entire machine slows
> down very quickly when it starts swapping more than about 2 or so GB.
> It seems either the kernel has become quite bad at selecting pages to
> evict.
>
> It gets to the point where any git operation has a battle to fight
> for RAM, despite not touching anything else other than git.
>
> The behaviour is much like firefox is locking memory into core, but
> that doesn't seem to be what's actually going on.  I've never really
> got to the bottom of it though.
>
> This is with 64-bit kernel and userspace.

I agree there is something going wrong on your machine, but I
don't really see how that relates to my suggestion.

> So, I'd suggest that trading off RAM available through highmem for VM
> space available through zswap is likely a bad idea if you have a
> workload that requires 4GB of RAM on a 32-bit machine.

Aside from every workload being different, I was thinking of
these general observations:

- If we are looking at a future without highmem, then it's better to use
  the extra memory for something than not using it. zswap seems like
  a reasonable use.

- A lot of embedded systems are configured to have no swap at all,
  which can be for good or not-so-good reasons. Having some
  swap space available often improves things, even if it comes
  out of RAM.

- A particularly important case to optimize for is 2GB of RAM with
  LPAE enabled. With CONFIG_VMSPLIT_2G and highmem, this
  leads to the paradox -ENOMEM when 256MB of highmem are
  full while plenty of lowmem is available. With highmem disabled,
  you avoid that at the cost of losing 12% of RAM.

- With 4GB+ of RAM and CONFIG_VMSPLIT_2G or
  CONFIG_VMSPLIT_3G, using gigabytes of RAM for swap
  space would usually be worse than highmem, but once
  we have VMSPLIT_4G_4G, it's the same situation as above
  with 6% of RAM used for zswap instead of highmem.

       Arnd
