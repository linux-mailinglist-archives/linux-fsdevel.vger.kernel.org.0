Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5F203F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfEPK5w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:57:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41987 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfEPK5v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:57:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id d4so1917260qkc.9;
        Thu, 16 May 2019 03:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCf53hCQoTWRnc+iZ0G/hbKzA1wZVJqGhF/yu3TPIjE=;
        b=gbZ/qRMDZrPE69UC8+4w1zV6JINvrCpjsLbWcwKwzI8UI3CJNjoenAFYH1N2Vpp4RP
         gJ0f5NKpKdbmpdSvHH8NLcXXJGLStzulS33eBiDk/hJ0PIZybWi+yDNlV85jkBc+eRSq
         rsVSeLMI4Dr+8nzyNpEkuXtQ3cfSI8Bh1lF9MK3na8eS+dX2GHsKu8Xf9y1x1mVxfjEF
         VzMB1DfMI/LjlWj2SqE5sxbsQXP/3C6VMaykTpOTdUfw12voknPi+3n2newXT/9RD2sd
         GjItkfXxQPZ0Et5IFv1mYiP3Jk6OfvkV4TVh9aOaD52NK6tEaW4S7lSAoXrNPpW8BATD
         T6KQ==
X-Gm-Message-State: APjAAAU3MtrF1KOg1zE2HUIbv0lDqeV8DomIMCeuiBDghMBhlGi/lfku
        GHe0Sl48zNyCsCFyfcpRMJBW2fGeyNqjOk3DueM=
X-Google-Smtp-Source: APXvYqxHUlclMun46EUI6hhWL0uRd1RyH8Yxyp8/vUn1bjtLtEkR/SvlDGi7zqiTh66Giq0qf20Kt0cHa0y9xR0L/WI=
X-Received: by 2002:a37:ac0a:: with SMTP id e10mr37762394qkm.254.1558004270813;
 Thu, 16 May 2019 03:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190516085810.31077-1-rpenyaev@suse.de> <20190516085810.31077-14-rpenyaev@suse.de>
 <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com> <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
In-Reply-To: <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 12:57:34 +0200
Message-ID: <CAK8P3a2TqHVyuPpQrghS8LfrvBffavsAFA5XC20Unf89CssRPw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 12:20 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> On 2019-05-16 12:03, Arnd Bergmann wrote:
> > On Thu, May 16, 2019 at 10:59 AM Roman Penyaev <rpenyaev@suse.de>
> > wrote:
> >>
> >> epoll_create2() is needed to accept EPOLL_USERPOLL flags
> >> and size, i.e. this patch wires up polling from userspace.
> >
> > Could you add the system call to all syscall*.tbl files at the same
> > time here?
>
> For all other archs, you mean?  Sure.  But what is the rule of thumb?
> Sometimes people tend to add to the most common x86 and other tables
> are left untouched, but then you commit the rest, e.g.
>
> commit 39036cd2727395c3369b1051005da74059a85317
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Feb 28 13:59:19 2019 +0100
>
>      arch: add pidfd and io_uring syscalls everywhere

We only recently introduced syscall.tbl files in a common format,
which makes it much easier to add new ones. I hope we can
do it for all architectures right away from now on.

I just noticed that the new mount API assigns six new system
calls as well, but did not use the same numbers across
architectures. I hope we can still rectify that before -rc1
and use the next available ones (428..433), then yours should
be 434 on all architectures, with the exception of arch/alpha.

      Arnd
