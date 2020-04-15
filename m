Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBD71A9621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635831AbgDOIUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 04:20:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635575AbgDOIUe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:20:34 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MBmDy-1jYZyi2Pim-00CBWW; Wed, 15 Apr 2020 10:20:28 +0200
Received: by mail-qk1-f169.google.com with SMTP id x66so16277004qkd.9;
        Wed, 15 Apr 2020 01:20:28 -0700 (PDT)
X-Gm-Message-State: AGi0PubsY62HfSF1eJ+otiDTNg4ql4GdP/xZ0eU6OLfMFVKliPbG/K6F
        6mDiGY1oYnh/CBBdHQ1wa4kTSfwvFSZyhUN5juk=
X-Google-Smtp-Source: APiQypKnMsiJ4Mmnsi8g+LtUb5Ci9aCZXZzn/1+vXXpOtQsnTWTgyLcCxEZm3G16DazfzLPj6j4dyGUhDCYzK7WylCI=
X-Received: by 2002:a37:9d08:: with SMTP id g8mr17919769qke.138.1586938827309;
 Wed, 15 Apr 2020 01:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de>
 <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com> <20200415074514.GA1393@lst.de>
In-Reply-To: <20200415074514.GA1393@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Apr 2020 10:20:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
Message-ID: <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ow0k2inKSLn3nPhAoKfksHR4JnqH2uqxoGGUElQEO3Ans+GOrFc
 uWpVrqz/Q4HhnLY1aHBHooquQWKQWupk+M0Raa2QFpqmQ7bfPZZ7aaOTDQKfqi/xVpJMNi/
 +CQmFTTzLZhWIby3serJqQb1pNoRv5aXVBlLpYPoBIbbfrRyS88GQi3cWj613NtGdqJo3J+
 dfJDxTPr4fuMz/o/IZ8tA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eeDRHJAEK0s=:g07cQPxn8AUelrINJMHWRy
 Nc4qtQc2qfjDsP8bUhAxd9kap5HG0lkFUUbDRlZEQOJdwBhBmqmY1XNvvlIWJiod3ZORod9Qu
 F7teraWaOOLEkDf6PAyfSZA499PwyGLmPFpmRl1aivyXvgKAhJIJDUeiFYL7leM83ZGJdAVPk
 Q8rs4PcMR9Ts3ki6KNFqZv9ffMnPfap0xr0qRIRFm1sxmgKwX6p7IA3X5d2RaSBbg8sJObJ8E
 Q45s7h0Cfwjal8I32rLIv0PWnbm1IreNa1q3CrMZPJGNZg2/+mS79MniwhN0S/HHSg73YYxYJ
 v0IZq0Sm0f4EA5iIV9zfDbHFKoVCFplJqvuJ0k7VyjDru4lufoo1o1uAi6Wl30V5AQYMcPXH2
 xdxx10KeRTpaZV+2CTvaDEWWfwoJGY9I0d2PmCKnqev4YeG5r7KTw6Hre6MuL5tfGG7NVpfdo
 uyVP+SKHNJiT+2J1/dnzrywJjBoQdvkeP3FtqvzxIakegjT+oWoc5A8yOyQ2jRg6lNt9Gxfth
 P32epezuaaZf1vExHSenokOmLm2ozX2uacA0sDo9qIyE+prEukRufbMDqdPDPkgUQBVxlznet
 W6FiO+yK4ZWHK93D3jXaZmyqUKKG3T6x7U52sNKyyvY36CVbx6mtvWepS0CsRlX+3uCyITMHl
 bWOG4JySO/P88R1wZk3gEb7M9j4J7YiQv8/I9j2xtpxE8y6bJD/QSDBdp03ciYOZznGpcSfw3
 RSad7tFbpgYLjrs8QegBJJ7drncs0c0h+9hBTZ5kRJxhpKsqA2Ceoap5QCoyHMmBlUXUPaXEH
 xCvKdHHJ1uFyE1JXhfI3FnYMuMAGIY3WWci5Xm33XlgBF750/M=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 9:45 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Apr 14, 2020 at 03:15:09PM +0200, Arnd Bergmann wrote:
> > I don't think you are changing the behavior here, but I still wonder if it
> > is in fact correct for x32: is in_x32_syscall() true here when dumping an
> > x32 compat elf process, or should this rather be set according to which
> > binfmt_elf copy is being used?
>
> The infrastructure could enable that, although it would require more
> arch hooks I think.

I was more interested in whether you can tell if it's currently broken
or not. If my feeling is right that the current code does the wrong thing
here, it would be good to at least put a FIXME comment in there.

> I'd rather keep it out of this series and to
> an interested party.  Then again x32 doesn't seem to have a whole lot
> of interested parties..

Fine with me. It's on my mental list of things that we want to kill off
eventually as soon as the remaining users stop replying to questions
about it.

In fact I should really turn that into a properly maintained list in
Documentation/... that contains any options that someone has
asked about removing in the past, along with the reasons for keeping
it around and a time at which we should ask about it again.

      Arnd
