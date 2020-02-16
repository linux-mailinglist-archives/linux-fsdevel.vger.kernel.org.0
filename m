Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B165F16032E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2020 10:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgBPJo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Feb 2020 04:44:56 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41631 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPJo4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Feb 2020 04:44:56 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so13279248otc.8;
        Sun, 16 Feb 2020 01:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wxad/rW0ARD7ILkeeK41v/OzIsUc8vRXWXFBEAQPs0M=;
        b=ZTBvD/AFYZIQgiWXwyhy0A+I34zglPuLyv+30dzVibBq+OBjXyn3UuTz0odwhnf5nB
         j2xASm7scX6DfxSOJSGPG2pcOIov0+IxJjwr3HyyYbQXyNMhPPEFOAVvTPTbEGWNB9GE
         DhNfBbH4oiJyW68R3lsbdQLdz7Zs3rttr7/OA0BUwkuUh7abGn5FWYCTuNBm1BpmZjMj
         laaFqE8flXA/zy3ct/gXqVZoYkH+Kkfqu3Df6DcYbaH3kH9Ywl+YTlvNKW9hbehm1tFd
         CxgkgkFwGq99i31oVqMh5Ot+Cw2WTE7J0S8Nr/hjPmNQFKm11d+lIIzf3mp70yF2pBoV
         qLgw==
X-Gm-Message-State: APjAAAWH/hRjrclubD6DJ6pqDxld+o57cjW1wtQkrSlNNZeF9vpZ0hmC
        8yeul0aoG2zmyCVywdi62zTI8X9oxRC+9vVF4fI=
X-Google-Smtp-Source: APXvYqxGgw2AMExBCXV20bfh1/5LPO7zAfx126+WuiZFxkn1B98Q92ANdmMo6uPnqnouDbk/Nip7wbyNSUuEMPTQI4c=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr8308018oth.145.1581846294102;
 Sun, 16 Feb 2020 01:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <CAMuHMdV8-=dj5n-FM1nHjXq1DhkJVOh4rLFxERt33jAQmU4h_A@mail.gmail.com> <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0m574dHYuKBPLf6q2prnbFxX1w7xe4-JX-drN6dqH6TQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 16 Feb 2020 10:44:42 +0100
Message-ID: <CAMuHMdVpTngVXUnLzpS3hZWuVg97GVTf2Y3X8md--41AtaD1Ug@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Arnd Bergmann <arnd@arndb.de>
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Arnd,

On Sat, Feb 15, 2020 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Feb 15, 2020 at 12:25 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Feb 13, 2020 at 5:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> >
> > The CIP-supported RZ/G1 SoCs can have up to 4 GiB, typically split (even
> > for 1 GiB or 2 GiB configurations) in two parts, one below and one above
> > the 32-bit physical limit.
>
> Good to know. I think there are several other chips that have dual-channel
> DDR3 and thus /can/ support this configuration, but this rarely happens.
> Are you aware of commercial products that use a 4GB configuration, aside from
> the reference board?

Unfortunately I don't know.
Chris Paterson might know.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
