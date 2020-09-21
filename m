Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A8A2736D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 01:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgIUXvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 19:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgIUXvP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 19:51:15 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B12423A79
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600732274;
        bh=39KukzOe6AolOem+gjVISioBf02u3SpMpVZVGYy+mj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQl/bTc6Te74pAw6+D+sJO31hgooXd1lkXVQyxDfGKz1Liczz1BI7NPcqJhTuNqcT
         fnFpNuCOXIfJl8K7eXwl9pCc8CXzuV86S9ibqoMrPRXETBdCXtl0g/rP48hc1vB+jG
         xW2h3Zo8OM2lyDPqAHm7IdDEhvR5Hy6ynKk6lJOA=
Received: by mail-wr1-f53.google.com with SMTP id t10so15013817wrv.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2020 16:51:14 -0700 (PDT)
X-Gm-Message-State: AOAM531tDNhln7vFFWblr8M+6CBX/VOmB5b/fy3nn/zcp9RP5C+qaCQO
        tzmNj8KLnh7GA7TIw0Lft8yGdmWLcpN2au1SBIC/Mg==
X-Google-Smtp-Source: ABdhPJzKuMXKYXqnIGS0yDLp4LGoqUZ+je+eZvXpafAIww15bS0o/seL9c9Y7bM14ZwES1psTTy6TgvO3gjUrDpJ/g4=
X-Received: by 2002:adf:ce8e:: with SMTP id r14mr2144251wrn.257.1600732273206;
 Mon, 21 Sep 2020 16:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Mi+1yttyGk4k7HxRVrMtmFqJewouVhynqUL0PJycmog@mail.gmail.com>
 <D0791499-1190-4C3F-A984-0A313ECA81C7@amacapital.net> <563138b5-7073-74bc-f0c5-b2bad6277e87@gmail.com>
 <486c92d0-0f2e-bd61-1ab8-302524af5e08@gmail.com>
In-Reply-To: <486c92d0-0f2e-bd61-1ab8-302524af5e08@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 21 Sep 2020 16:51:01 -0700
X-Gmail-Original-Message-ID: <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
Message-ID: <CALCETrW3rwGsgfLNnu_0JAcL5jvrPVTLTWM3JpbB5P9Hye6Fdw@mail.gmail.com>
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Network Development <netdev@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 9:15 AM Pavel Begunkov <asml.silence@gmail.com> wro=
te:
>
> On 21/09/2020 19:10, Pavel Begunkov wrote:
> > On 20/09/2020 01:22, Andy Lutomirski wrote:
> >>
> >>> On Sep 19, 2020, at 2:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>
> >>> =EF=BB=BFOn Sat, Sep 19, 2020 at 6:21 PM Andy Lutomirski <luto@kernel=
.org> wrote:
> >>>>> On Fri, Sep 18, 2020 at 8:16 AM Christoph Hellwig <hch@lst.de> wrot=
e:
> >>>>> On Fri, Sep 18, 2020 at 02:58:22PM +0100, Al Viro wrote:
> >>>>>> Said that, why not provide a variant that would take an explicit
> >>>>>> "is it compat" argument and use it there?  And have the normal
> >>>>>> one pass in_compat_syscall() to that...
> >>>>>
> >>>>> That would help to not introduce a regression with this series yes.
> >>>>> But it wouldn't fix existing bugs when io_uring is used to access
> >>>>> read or write methods that use in_compat_syscall().  One example th=
at
> >>>>> I recently ran into is drivers/scsi/sg.c.
> >>>
> >>> Ah, so reading /dev/input/event* would suffer from the same issue,
> >>> and that one would in fact be broken by your patch in the hypothetica=
l
> >>> case that someone tried to use io_uring to read /dev/input/event on x=
32...
> >>>
> >>> For reference, I checked the socket timestamp handling that has a
> >>> number of corner cases with time32/time64 formats in compat mode,
> >>> but none of those appear to be affected by the problem.
> >>>
> >>>> Aside from the potentially nasty use of per-task variables, one thin=
g
> >>>> I don't like about PF_FORCE_COMPAT is that it's one-way.  If we're
> >>>> going to have a generic mechanism for this, shouldn't we allow a ful=
l
> >>>> override of the syscall arch instead of just allowing forcing compat
> >>>> so that a compat syscall can do a non-compat operation?
> >>>
> >>> The only reason it's needed here is that the caller is in a kernel
> >>> thread rather than a system call. Are there any possible scenarios
> >>> where one would actually need the opposite?
> >>>
> >>
> >> I can certainly imagine needing to force x32 mode from a kernel thread=
.
> >>
> >> As for the other direction: what exactly are the desired bitness/arch =
semantics of io_uring?  Is the operation bitness chosen by the io_uring cre=
ation or by the io_uring_enter() bitness?
> >
> > It's rather the second one. Even though AFAIR it wasn't discussed
> > specifically, that how it works now (_partially_).
>
> Double checked -- I'm wrong, that's the former one. Most of it is based
> on a flag that was set an creation.
>

Could we get away with making io_uring_enter() return -EINVAL (or
maybe -ENOTTY?) if you try to do it with bitness that doesn't match
the io_uring?  And disable SQPOLL in compat mode?

--Andy
