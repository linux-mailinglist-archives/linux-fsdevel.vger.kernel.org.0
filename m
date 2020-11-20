Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8E2BB52A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 20:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgKTTXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 14:23:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTTXp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:23:45 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA2D22254;
        Fri, 20 Nov 2020 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605900224;
        bh=6utPp8y2IfYmogUP7teaB/ARZBuClgZZ+lpoxaOZ1Tw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HdzUkH8aXfOx06ArXihJtVhMjRyBFPYN5WiUGxcu+uPOQwa+qRego7DIDxlrJpc3z
         OnrL5XHCOB41fkEHRIq3W14m0i86yIC+Tb33nzfNVX3cDP5OLf1l/SGmMjmtrmKjd/
         j6GJmogIJy3tnclRF3JshyrxKDgf52CK8xvmW8wU=
Received: by mail-oi1-f169.google.com with SMTP id a130so3538242oif.7;
        Fri, 20 Nov 2020 11:23:44 -0800 (PST)
X-Gm-Message-State: AOAM531F5d/sd2XemslXtgynMkG062nPnvri8ssuerARqx3JvwRFmShL
        aEbv4nYPEarRmvrXCwCxmSZpjPFObNJB4YFib0Q=
X-Google-Smtp-Source: ABdhPJy3M4r4RIwLPKw4jM9j70Gq7pe8ELR64/eLX4GDAY/+QnF48WsYtKd8QomkWGuoX98DlbImVcer5fOZAV1UTlk=
X-Received: by 2002:aca:180a:: with SMTP id h10mr7112996oih.4.1605900223419;
 Fri, 20 Nov 2020 11:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com>
 <20201118144617.986860-2-willemdebruijn.kernel@gmail.com> <20201118150041.GF29991@casper.infradead.org>
 <CA+FuTSdxNBvNMy341EHeiKOWZ19H++aw-tfr6Fx1mFmbg-z4zQ@mail.gmail.com>
 <CAK8P3a0t02o77+8QNZwXF2k1pY3Xrm5bydv8Vx1TW060P7BKqA@mail.gmail.com>
 <893e8ed21e544d048bff7933013332a0@AcuMS.aculab.com> <CAF=yD-+arBFuZCU3UDx0XKmUGaEz8P1EaDLPK0YFCz82MdwBcg@mail.gmail.com>
 <20201119143131.GG29991@casper.infradead.org> <CAK8P3a1SwQ=L_qA1BmeAt=Xc-Q9Mv4V+J5LFLB5R6rMDST8UiA@mail.gmail.com>
 <CAF=yD-Kd-6f9wAYLD=dP1pk4qncWim424Fu6Hgj=ZrnUtEPORA@mail.gmail.com>
 <CAK8P3a21JRFUJrz1+TYWcVL8s4uSfeSFyoMkGsqUPbV+F=r_yw@mail.gmail.com> <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com>
In-Reply-To: <CAF=yD-Lzu9j6T4ubRjawF-EKOC3pkQTkpigg=PugWwybY-1ZyQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 20 Nov 2020 20:23:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
Message-ID: <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
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

On Fri, Nov 20, 2020 at 5:01 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Fri, Nov 20, 2020 at 3:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Thu, Nov 19, 2020 at 9:13 PM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > > On Thu, Nov 19, 2020 at 10:45 AM Arnd Bergmann <arnd@kernel.org> wrote:

> Thanks for the suggestion.
>
> I do have an initial patchset. As expected, it does involve quite a
> bit of code churn to pass slack through the callers. I'll take a look
> at your suggestion to simplify it.
>
> As is, the patchset is not ready to send to the list for possible
> merge. In the meantime, I did push the patchset to github at
> https://github.com/wdebruij/linux/commits/epoll-nstimeo-1 . I can send
> a version marked RFC to the list if that's easier.

Looks all good to me, just two small things I noticed that you can
address before sending the new series:

* The div_u64_rem() in ep_timeout_to_timespec() looks wrong, as
  you are actually dividing a 'long' that does not need it.

* In "epoll: wire up syscall epoll_pwait2", the alpha syscall has the
wrong number, it
   should be 110 higher than the others, not 109.

> Btw, the other change, to convert epoll implementation to timespec64
> before adding the syscall, equally adds some code churn compared to
> patch v3. But perhaps the end state is cleaner and more consistent.

Right, that's what I meant. If it causes too much churn, don't worry
about it it.

       Arndd
