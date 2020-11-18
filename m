Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1F2B79DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 10:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgKRJAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 04:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgKRJAh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:00:37 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDBBD24248;
        Wed, 18 Nov 2020 09:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605690036;
        bh=i9tBV0oZBsTReps0EogPqekfIEGahPYtFjMV0dB8U+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TjCzdqFScODCSwu2HqQV/hZsXCizf8cSQGNq0E4s6V9KEfsorLbCddbZe5wx8Pvfq
         QUGYUe3B/02nyoOG++Le+tTxAzAu8vcdiXUBicX/furVaJA/8OMu9uobWvcycgmi68
         YbRE+d1hXTXxUMEjluROqGJr09HxR0jj4VUdy1Xg=
Received: by mail-oi1-f174.google.com with SMTP id k26so1444194oiw.0;
        Wed, 18 Nov 2020 01:00:36 -0800 (PST)
X-Gm-Message-State: AOAM5313tO3mHx/3SRkk+XORL/lHPnGwNAKy3KQYTXXo6mpolRhfYxoJ
        afM+Acg1VYntv5yx1GcZlsCjkIg0lrKpH2xtYIA=
X-Google-Smtp-Source: ABdhPJydSZXfIA6Ryj/nqlJBnSxKnJFPoskTXFwxpwxSaoVGbr/P/APPPfzylLk92sw1xEZ6AWYdYCMkzWbPDL2wVtI=
X-Received: by 2002:aca:180a:: with SMTP id h10mr2022489oih.4.1605690035742;
 Wed, 18 Nov 2020 01:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20201012220620.124408-1-linus.walleij@linaro.org>
 <20201013092240.GI32292@arm.com> <CACRpkdZoMoUQX+CPd31qwjXSKJvaZ6=jcFvUrK_3hkxaUWJNJg@mail.gmail.com>
In-Reply-To: <CACRpkdZoMoUQX+CPd31qwjXSKJvaZ6=jcFvUrK_3hkxaUWJNJg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 18 Nov 2020 10:00:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2SN2zeK=dj01Br-m86rJmK8mOyH=gHAidwSPgKAEthVw@mail.gmail.com>
Message-ID: <CAK8P3a2SN2zeK=dj01Br-m86rJmK8mOyH=gHAidwSPgKAEthVw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] fcntl: Add 32bit filesystem mode
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:38 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Oct 13, 2020 at 11:22 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> > >       case F_SETFD:
> > >               err = 0;
> > >               set_close_on_exec(fd, arg & FD_CLOEXEC);
> > > +             if (arg & FD_32BIT_MODE)
> > > +                     filp->f_mode |= FMODE_32BITHASH;
> > > +             else
> > > +                     filp->f_mode &= ~FMODE_32BITHASH;
> >
> > This seems inconsistent?  F_SETFD is for setting flags on a file
> > descriptor.  Won't setting a flag on filp here instead cause the
> > behaviour to change for all file descriptors across the system that are
> > open on this struct file?  Compare set_close_on_exec().
> >
> > I don't see any discussion on whether this should be an F_SETFL or an
> > F_SETFD, though I see F_SETFD was Ted's suggestion originally.
>
> I cannot honestly say I know the semantic difference.
>
> I would ask the QEMU people how a user program would expect
> the flag to behave.

I agree it should either use F_SETFD to set a bit in the fdtable structure
like set_close_on_exec() or it should use F_SETFL to set a bit in
filp->f_mode.

It appears the reason FMODE_32BITHASH is part of  filp->f_mode
is that the only user today is nfsd, which does not have a file
descriptor but only has a struct file. Similarly, the only code that
understands the difference (ext4_readdir()) has no reference to
the file descriptor.

If this becomes an O_DIR32BITHASH flag for F_SETFL,
I suppose it should also be supported by openat2().

       Arnd
