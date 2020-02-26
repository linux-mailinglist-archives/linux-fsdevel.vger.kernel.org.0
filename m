Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E5C170A1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 22:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgBZVCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 16:02:11 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgBZVCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:02:11 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MlNcr-1jqJjw0fjZ-00lmUf; Wed, 26 Feb 2020 22:02:09 +0100
Received: by mail-qv1-f49.google.com with SMTP id ek2so510396qvb.0;
        Wed, 26 Feb 2020 13:02:08 -0800 (PST)
X-Gm-Message-State: APjAAAX0hEivxzwSz6t9taQ1csuTcF/zcaB0EJ6X0uDf1sl13W8oIjLL
        U2TiM2I4J3oNoCpbLdvHF01vZvwexH54w5qt5H4=
X-Google-Smtp-Source: APXvYqxhHS9U3+N/7qg1V3h6/lWCEHWUtHJQtbK71iP6fx7l2VUQMHsb2aYbd6SCMc7GfTj4m50SkWIR7eOfBWBERJg=
X-Received: by 2002:a05:6214:524:: with SMTP id x4mr1146649qvw.4.1582750927983;
 Wed, 26 Feb 2020 13:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
 <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
 <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
 <20200212085004.GL25745@shell.armlinux.org.uk> <CAK8P3a3pzgVvwyDhHPoiSOqyv+h_ixbsdWMqG3sELenRJqFuew@mail.gmail.com>
 <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
In-Reply-To: <671b05bc-7237-7422-3ece-f1a4a3652c92@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 26 Feb 2020 22:01:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
Message-ID: <CAK8P3a13jGdjVW1TzvCKjRBg-Yscs_WB2K1kw9AzRfn3G9a=-Q@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
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
        Santosh Shilimkar <ssantosh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:B0z8MNizJ7kia9aTxiE6iXCBlswXi3zwEcqfTJHoVMKZ6ErYXbE
 gp9J9teZYve2caR/jKAzBeFbWXOokwclyrbishs2Iowivr/BaRrXg0S1jTYEs0UMII1ZQ+Z
 uvap5jNCyXnghvWmjal06Ip9spD1yKLFco46EMboXYOFM88ItGGFkvohGR11QxVAUb0ACwR
 YWTOsWFaAPPbgdMGauv/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:K2vDLtCaXnw=:PNYIHzWGGEEBd0aqVSb3CV
 zOkvHEntYYIhHdS/oR5ZUVIUw8DEtHTE6HvnGR/7lxSWwEv7mEdD3serbMqm/exblu0v+Dxpm
 UbZg/MYcm2bKh+EpWRDicVrz8UuL8/qvI03EHJdkwvNe2TCsO7whgglwvwUjLbYfQ8rJHfw/+
 nt1l6uxEQG5F1qfxQpmJ2Tec3ICc5jLJKj3oKRiqd1y98DJoUqy8Jp+aX6P2Gr3b4pCwWiLqF
 YSvlHvXfcXYRWAln5Ue9NqubcHEJsi0kKUf41Ww/4i0audXtoN3h8PqbxD/OECmmfWhmBjctg
 SZFgaU1Eiyv8Q1/zD4Pq2j12vjFOUry6PdweK0g34Ypa2DmKXRw94Hfa4gk87uCNcCiY07QZR
 q4TM3Mg8RYIL8oeOt2nGCF22okBN9WwjdTiynzSdE3fUtjXTIRibRXFiSmYgngGGM/7U3o0sG
 ZdwPALqYomcrcbqoRHDX8H7Sj8iW+nV9jvsw9ArdeBlTqwgo+waI41JcgVpejafPbCTcndMo0
 Z+Zasl9MdpaNPhuc+DiMCMOuVCOgfR4XersXgqj68zEoFtApJFYYEds8qtxrSJk5ZE+9NR9h2
 r2pb4/NiUt53pefOd1E5/vWHj+oMUT10tO6Deodcff6hqzUo4dDltXDFfFdlcruH6BJgOfISY
 QOgMMxfvYwF2fvLpQzxx6SouFrsnJlK+2em/Mfs7JW3NMrGCRXvyWPQ6izuQu7DZKtpWYheU6
 KR1Whpy9BbahJ54LuwWfzWasGDIA68udw1Pw3Jt+ZAd2OG2JHhxJPyrUj8/rfBiiXbe+hILY5
 tzzqHQqyovwxKjvRQ1gyzP4H+vtTtPnr48ON81SMHaJVj4TX7Q=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 7:04 PM <santosh.shilimkar@oracle.com> wrote:
>
> On 2/13/20 8:52 AM, Arnd Bergmann wrote:
> > On Wed, Feb 12, 2020 at 9:50 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
>
> The Keystone generations of SOCs have been used in different areas and
> they will be used for long unless says otherwise.
>
> Apart from just split of lowmem and highmem, one of the peculiar thing
> with Keystome family of SOCs is the DDR is addressable from two
> addressing ranges. The lowmem address range is actually non-cached
> range and the higher range is the cacheable.

I'm aware of Keystone's special physical memory layout, but for the
discussion here, this is actually irrelevant for the discussion about
highmem here, which is only about the way we map all or part of the
available physical memory into the 4GB of virtual address space.

The far more important question is how much memory any users
(in particular the subset that are going to update their kernels
several years from now) actually have installed. Keystone-II is
one of the rare 32-bit chips with fairly wide memory interfaces,
having two 72-bit (with ECC) channels rather than the usual one
 or two channels of 32-bit DDR3. This means a relatively cheap
4GB configuration using eight 256Mx16 chips is possible, or
even a 8GB using sixteen or eighteen 512Mx8.

Do you have an estimate on how common these 4GB and 8GB
configurations are in practice outside of the TI evaluation
board?

       Arnd
