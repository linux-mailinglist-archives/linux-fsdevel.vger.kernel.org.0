Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284392BBE35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 10:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgKUJ15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Nov 2020 04:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbgKUJ14 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Nov 2020 04:27:56 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A5F22269;
        Sat, 21 Nov 2020 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605950875;
        bh=uUE+BwhJZQbnAt5h9J7aJjQ56rhNF6AJaSotMShsjjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ON94Agc/s57Gqw3EUmZlgsso7EUmKsH7ty9efQnjbxpm/7Uvzx8Glg8536rUjh1RK
         ctShKcEsxsK4H6T/fE/adSdr+yC6M9lmTEKL7pXTbEnuYoGTQKPe0THVuHJvy2zgnS
         G+H1bWuB7l9jYDVl4nxJezbY8tV7fbujYf7ER+DU=
Received: by mail-ot1-f42.google.com with SMTP id 92so8125097otd.5;
        Sat, 21 Nov 2020 01:27:55 -0800 (PST)
X-Gm-Message-State: AOAM531zzI8pNQYHrpX2C9CJWsjj6atrN8XTGrwhv0CxKPD2oz+GBagw
        fAL6q9UDUc5e8uqoEuUxHkXuBOaqdji5PE/2CUk=
X-Google-Smtp-Source: ABdhPJw8tZEWlczyttYsnJQ6uLhwZuA22h1QJBv7lMqVso6n63xbWEtnhxTHnmW/htaNLmzBLlOTQkGDkhJBZcl9sFg=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr7263123otk.251.1605950874850;
 Sat, 21 Nov 2020 01:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
 <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com>
 <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com>
 <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com> <CAF=yD-LdtCCY=Mg9CruZHdjBXV6VmEPydzwfcE2BHUC8z7Xgng@mail.gmail.com>
In-Reply-To: <CAF=yD-LdtCCY=Mg9CruZHdjBXV6VmEPydzwfcE2BHUC8z7Xgng@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 21 Nov 2020 10:27:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2WifcGmmFzSLC4-0SKsv0RT231P6TVKpWm=j927ykmQg@mail.gmail.com>
Message-ID: <CAK8P3a2WifcGmmFzSLC4-0SKsv0RT231P6TVKpWm=j927ykmQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:28 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Fri, Nov 20, 2020 at 2:23 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Fri, Nov 20, 2020 at 5:01 PM Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
>
> I think it'll be better to split the patchsets:
>
> epoll: convert internal api to timespec64
> epoll: add syscall epoll_pwait2
> epoll: wire up syscall epoll_pwait2
> selftests/filesystems: expand epoll with epoll_pwait2
>
> and
>
> select: compute slack based on relative time
> epoll: compute slack based on relative time
>
> and judge the slack conversion on its own merit.

Yes, makes sense.

> I also would rather not tie this up with the compat deduplication.
> Happy to take a stab at that though. On that note, when combining
> functions like
>
>   int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
>                            fd_set __user *exp, struct timespec64 *end_time,
>                            u64 slack)
>
> and
>
>   static int compat_core_sys_select(int n, compat_ulong_t __user *inp,
>         compat_ulong_t __user *outp, compat_ulong_t __user *exp,
>         struct timespec64 *end_time, u64 slack)
>
> by branching on in_compat_syscall() inside get_fd_set/set_fd_set and
> deprecating their compat_.. counterparts, what would the argument
> pointers look like? Or is that not the approach you have in mind?

In this case, the top-level entry points becomes unified, and you get
the prototype from core_sys_select() with the native arguments.

I would imagine this can be done like the way I proposed
for get_bitmap() in sys_migrate_pages:

https://lore.kernel.org/lkml/20201102123151.2860165-4-arnd@kernel.org/

        Arnd
