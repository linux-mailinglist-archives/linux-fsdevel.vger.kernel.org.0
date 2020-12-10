Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA332D68CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 21:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404323AbgLJUfM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 15:35:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403909AbgLJUfH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:35:07 -0500
X-Gm-Message-State: AOAM531kqwgANVbjqEQV4jBDlNTgYLbXPAVVDoh9JPE1+7kMuLgMsQMc
        06rYqcMNju8zu+h22KXD/y3tmWY1Xwzq+oQCA9s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607632463;
        bh=eVhP+nGJSyyuJtycuRa7KQjrvFDk9SwKB7cTbFP8C2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BGBAMlYObNSAVIbg/ZGIvpraQ6np5066jsdhv66NF0TnuVkn9LGirvYJH0LPzG6cK
         84zDS1En/cnnnkwimJF9FDDf/4l7m/MbkFiXG/4owKyXMo2UmNsGSGnpYIxu1fh1xd
         i1Bc9kaTK3FI73jBs6Ry/NHPWjgz+U2hwB89WsW5nUXcf2bjWMrbcpdRT3GneUqxFW
         3yUxzzURVFNt+E0Aq1Hu17h2e58qjWDwwT3wBvJItHiGTmuL77hpQ0V2zLNB63XLnd
         31kbq6YHVh7qrTp5QCoBJb49WIN7chGjg0mspUzQJOd2IUnMXdKmoy8XDYZQIufrJY
         fSchh3yjlwmyA==
X-Google-Smtp-Source: ABdhPJx2RFX6+pqOpUSVZLrAgTNcxwEcD//sMWg69zU/v4eGdU1WfMj1mkowHbxCc5IjQ11TKLfgk4D9mM/ZAV4i+1M=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr7289670otm.305.1607632462654;
 Thu, 10 Dec 2020 12:34:22 -0800 (PST)
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
 <CAK8P3a1cJf7+b5HCmFiLq+FdM+D+37rHYaftRgRYbhTyjwR6wg@mail.gmail.com>
 <CAF=yD-LdtCCY=Mg9CruZHdjBXV6VmEPydzwfcE2BHUC8z7Xgng@mail.gmail.com>
 <CAK8P3a2WifcGmmFzSLC4-0SKsv0RT231P6TVKpWm=j927ykmQg@mail.gmail.com> <CA+FuTSdPir68M9PwhuCkd_Saz-Wi3xa_rNuwvbNmpAkMjOqhuA@mail.gmail.com>
In-Reply-To: <CA+FuTSdPir68M9PwhuCkd_Saz-Wi3xa_rNuwvbNmpAkMjOqhuA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 10 Dec 2020 21:34:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Z=X68aU27qQ_0vK6c_oj9CVbThuGscjqKXRCYKfFpgg@mail.gmail.com>
Message-ID: <CAK8P3a2Z=X68aU27qQ_0vK6c_oj9CVbThuGscjqKXRCYKfFpgg@mail.gmail.com>
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
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 6:33 PM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> On Sat, Nov 21, 2020 at 4:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > On Fri, Nov 20, 2020 at 11:28 PM Willem de Bruijn <willemdebruijn.kerne=
l@gmail.com> wrote:
> > I would imagine this can be done like the way I proposed
> > for get_bitmap() in sys_migrate_pages:
> >
> > https://lore.kernel.org/lkml/20201102123151.2860165-4-arnd@kernel.org/
>
> Coming back to this. Current patchset includes new select and poll
> selftests to verify the changes. I need to send a small kselftest
> patch for that first.
>
> Assuming there's no time pressure, I will finish up and send the main
> changes after the merge window, for the next release then.
>
> Current state against linux-next at
> https://github.com/wdebruij/linux-next-mirror/tree/select-compat-1

Ok, sounds good to me. I've had a (very brief) look and have one
suggestion: instead of open-coding the compat vs native mode
in multiple places like

if (!in_compat_syscall())
    =EF=BF=BC return copy_from_user(fdset, ufdset, FDS_BYTES(nr)) ? -EFAULT=
 : 0;
else
    =EF=BF=BC return compat_get_bitmap(fdset, ufdset, nr);

maybe move this into a separate function and call that where needed.

I've done this for the get_bitmap() function in my series at

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/=
?h=3Dcompat-alloc-user-space-7&id=3Db1b23ebb12b635654a2060df49455167a142c5d=
2

The definition is slightly differrent for cpumask, nodemask and fd_set,
so we'd need to try out the best way to structure the code to end
up with the most readable version, but it should be possible when
there are only three callers (and duplicating the function would
be the end of the world either)

        Arnd
