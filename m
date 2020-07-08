Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6547218300
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 10:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGHI7K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 8 Jul 2020 04:59:10 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44433 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbgGHI7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:59:09 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M1HmE-1jvpjt0Vpq-002q2u; Wed, 08 Jul 2020 10:59:07 +0200
Received: by mail-qk1-f173.google.com with SMTP id 145so38292577qke.9;
        Wed, 08 Jul 2020 01:59:06 -0700 (PDT)
X-Gm-Message-State: AOAM5305UJ0SnXMSPNglsrHEvGM+hNgSwSEmNRF/8pbwwYLd0gnTHozI
        Ceev+fOU1N607fAA9nf8GxOV5jGLjDy6uwvEJ94=
X-Google-Smtp-Source: ABdhPJzLaMHmQ+d0DaK1+93L/dR3MzlE080J2I9IddvGS9yPpAL+dL55hLQlLBZanWkIYCvrPgtE5STzlyI22smNJzI=
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr49067426qko.138.1594198745401;
 Wed, 08 Jul 2020 01:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200707180955.53024-1-mic@digikod.net> <20200707180955.53024-10-mic@digikod.net>
 <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
 <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net> <CAK8P3a3Mf_+-MY5kdeY7sqwUgCUi=PksWz1pGDy+o0ZfgF93Zw@mail.gmail.com>
 <956a05c8-529b-bf97-99ac-8958cceb35f3@digikod.net>
In-Reply-To: <956a05c8-529b-bf97-99ac-8958cceb35f3@digikod.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 10:58:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0RKEb0jcisgaXVd6wJU6GaEsDAJp+jDFyJBdMPDE__ZQ@mail.gmail.com>
Message-ID: <CAK8P3a0RKEb0jcisgaXVd6wJU6GaEsDAJp+jDFyJBdMPDE__ZQ@mail.gmail.com>
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:xHTn1Z/zs2Cvp/Jis9ADqr2IAejWKErX2VZvYMpCYqk7nN38OGS
 hqnUoA/8tqXaX22IX+Xjh6COX7jWOlGeCZG9zOawyraaVVA3sM+bWf//mEECKw0TJHaa536
 emgPPoxis8hhtPlNxxeEeb1Goft2ZN7njCTaKLYp2KvXOYImAKvNR+oCJUtXuclxk+xiw5p
 0PxGi/RwzrhVLDK+mdbmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GzkeslkO6gE=:kM5RpU6Q+0lHtyoGKEprs5
 sxAllv15rCucfKqU8mXI3zK1iYT9XCeSUlYwH9752GoVt7J0Zpz2Tg9VUAWLPDBOmYzwxeSTt
 Ifpioku+VVsk68jI7OD/eruKHQJcoW05Ey0jJFcttHyPUKRYHpSENXAF6RWxNTLuI4otqWbFY
 o6ubgL8EswGQfaIffXK1kV+JFxBKVd9NZPKoRWoVP8/fXe1KDtnoAdPsQebFwSWc1beN0wRf+
 Dg4DTijMBcy39pGVgdIb8mEusN9xP5Np5798PsP81bIuo0Jr/kLNfmExmU+vSVHQ1eaEpcBJK
 tRfCW5poVhYoONA50kzGlVvj2jghd1iFnWGKZeEvAyjV5pvfqlko37YnFHyc0kcW1goqt239z
 +xMaV3fxspXepCuxwuRysmfiZOs9RNw0dmGevVIW3fajMueAleKwAWAVLwbcDpHm+U5VtVFYU
 yqm3UMSJo6dpDcmudK6+W0axGOhQENhzasfnm9PwzlvsOw7fb3GkUJrp14cfCtOKTUl0RtW1J
 qqNaXcLzjVmBnN5vga/vpSL+zsI7o/gql/jFJMT9RGjEY2YS9dyeLMusbWY1rObpazlsQ3VNL
 WUu5yhqltGZZ818FNnJ90c3cFL3BrmmXHYcRnm+Mevg3S9Gp5IDwz1X0zMqoeA5W0cmWT2nwK
 pf2aGV8896rYBtjF/vNwroH3jxUKTT4xifWoBQbtr3MAqyb68uMmZnY0GH1Zn4rzfaNM8dnCL
 OVeK0Va6WupDozvzLvgKGDKe3gtW5E/pRngw1Pt89CzMq7tlQv26J9Km/IvqFiV/jQuwr8waY
 alHPx5jZsdXbdB5cbe8s0TkEtfpiEH435jS3YZ07RhRGXCCXAebID1JmASw5Z55B65K27gMae
 WyxSPqR9f3Dh1LGFMUXPAojxqv/xoGiIVpm8e3oN5/shl/9skrcCVzh+q0hm6VSMYViCg0Vjy
 DipXxUOLBS6ViaTQI6wtCgIG0FLBFpkFPWhwJezEscPn0InnY25Hj
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 8, 2020 at 10:23 AM Mickaël Salaün <mic@digikod.net> wrote:
> On 08/07/2020 09:47, Arnd Bergmann wrote:
> > On Wed, Jul 8, 2020 at 9:31 AM Mickaël Salaün <mic@digikod.net> wrote:
> >> On 08/07/2020 09:22, Arnd Bergmann wrote:
> >>> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
> >>>
> >>>> index f4a01305d9a6..a63a411a74d5 100644
> >>>> --- a/include/uapi/asm-generic/unistd.h
> >>>> +++ b/include/uapi/asm-generic/unistd.h
> >>
> >> OK, I'll rebase the next series on linux-next.
> >
> > Just change the number to the next free one, without actually rebasing.
> > It's always a bit messy to have multiple syscalls added, but I think that
> > causes the least confusion.
>
> OK, but this will lead to two merge conflicts: patch 8 (asmlinkage) and
> patch 9 (tbl files).

Yes, there isn't really much one can do about that.

> Do you want me to update the tools/perf/arch/*.tbl too?

No, I would leave them unchanged.

     Arnd
