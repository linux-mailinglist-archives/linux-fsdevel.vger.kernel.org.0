Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4E1AE674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgDQUGv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 16:06:51 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbgDQUGv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:06:51 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M8QiW-1jL9XV33js-004UwX; Fri, 17 Apr 2020 22:06:49 +0200
Received: by mail-qt1-f180.google.com with SMTP id x2so3110601qtr.0;
        Fri, 17 Apr 2020 13:06:49 -0700 (PDT)
X-Gm-Message-State: AGi0PubwJtWaPqKeB14VwyJ6MAaIMvki8umzIGon9wFv5dXOOshBcXnJ
        wqTjwtkMvXna0/5SxOXODZzqRtA4CRcsPqzHehY=
X-Google-Smtp-Source: APiQypIuVYTMsWNIMRfLctc2Px6V3Nv5laT/h9easo3nN8JdO/iC9u+TYaVOxEylqCGtuWj1RzmpVdKpAc4Qm4vntwk=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr4819273qtp.304.1587154008516;
 Fri, 17 Apr 2020 13:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de>
 <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com>
 <20200415074514.GA1393@lst.de> <CAK8P3a0QGQX85LaqKC1UuTERk6Bpr5TW6aWF+jxi2cOpa4L_AA@mail.gmail.com>
 <20200417132714.GA6401@lst.de> <87o8rqc7az.fsf@x220.int.ebiederm.org>
In-Reply-To: <87o8rqc7az.fsf@x220.int.ebiederm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Apr 2020 22:06:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0x0vsgVp-pRWd7rL-6Zg9KimNQjJpnp6KG+kS1=eK7wg@mail.gmail.com>
Message-ID: <CAK8P3a0x0vsgVp-pRWd7rL-6Zg9KimNQjJpnp6KG+kS1=eK7wg@mail.gmail.com>
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FJYARPUTcTI5ilVImAaKDLXrV419J/atlbHDqy6EpyXPfBFphnb
 Wu7yOUxKWwqU3TrJgIzUTWyK+Aoj7DObEifzaOTXALipy1aXN3EYWzu71cl2nIIXGNafjRL
 u1K1Y93P7sw2cdVx+jW5uYANF/5BVVjTu883KiqzIqFbian+a3floaeJshdvHYy2LxgZ/6D
 MvcnnNvyF0F12SINkKi7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8VDhBQqp7NI=:jpsEGnKPTVvn48t9buXnHl
 6Jq1w0wHxdwWyzV6tm1KaqKnx/Xob1WGBq0Jk2o93zy5Y6ftTNwO7dhUGxw4TLIFVYKzY1LQb
 0hqTM+7T6pM87aZxCKYBWRNcJwFR5Vju3cw0NqdmWbVLnN2kOfOTeFgLy1kur4YdgJjExKEoo
 pb+5m8IUWay24ToMzgcTEhQ8IVdOZvJyWLAD4gbCqpfWcJ3pjjVgAIPnBpCyfi1w/oX4Z1ZCD
 9rMPzMKRD/tpHLPdSbaNhPS41rEiwJi76XKIMJvHhdJU4RO6NSDJJph5LwORSiQVXNCN7AW0f
 6OQzjAvM1I9QJubyg52ViS98YVmWVB/2wjTOavfWFJOd5jnLg2Au9Nx0OlyDAQOKBHd+udi1H
 Umd8XBe6H/0p1q4wknQn0fgGmAsLBhz/vXRwPAEzoV1HAwnfHkFDdMDdFRFapMiZux7gP3Rfr
 iFVL2+wcqSI2CdY9b9UePuolpJR60tpVy9GPwG0wSpdN5LOyLbra6RN1k4LUJVA8QB1Hb7TiK
 eeFVBLRxdiJsnTC6HsdCg9lSMoF7drN1pNcJidJTJSMU1tF3hwYHWhlYMCzksTOODVwKTAI2M
 MRL2jfTIlSnNKg2Z0+HXUQ1f5BVV1OHvfCSG1vCTkeyIDBQWK7gGmH5LeM3kyAhLsH/01Rl48
 PDOkN1+sBWD3TwrH6PHij3lOGXAOL260fqMLLAx/BObKb0WQLzf+kRao12VdLLCiXynuH/MK2
 +t5o3tjLN/RLiOmBsAbsZrMveDlNzFC/uJJxEnXsuXC1AQvSPF06HthAdP+3sCw30+wxCOPzv
 e58tjvmiC73A9na962XZTKMh9rl/YRsy3NS0q2M2QzRlHxcyTM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 8:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Christoph Hellwig <hch@lst.de> writes:
>
> > On Wed, Apr 15, 2020 at 10:20:11AM +0200, Arnd Bergmann wrote:
> >> > I'd rather keep it out of this series and to
> >> > an interested party.  Then again x32 doesn't seem to have a whole lot
> >> > of interested parties..
> >>
> >> Fine with me. It's on my mental list of things that we want to kill off
> >> eventually as soon as the remaining users stop replying to questions
> >> about it.
> >>
> >> In fact I should really turn that into a properly maintained list in
> >> Documentation/... that contains any options that someone has
> >> asked about removing in the past, along with the reasons for keeping
> >> it around and a time at which we should ask about it again.
> >
> > To the newly added x86 maintainers:  Arnd brought up the point that
> > elf_core_dump writes the ABI siginfo format into the core dump. That
> > format differs for i386 vs x32.  Is there any good way to find out
> > which is the right format when are not in a syscall?
> >
> > As far a I can tell x32 vs i386 just seems to be based around what
> > syscall table was used for the current syscall, but core dumps aren't
> > always in syscall context.
>
> I don't think this matters.  The i386 and x32 signal structures
> only differ for SIGCHLD.  The SIGCHLD signal does cause coredumps.
> So as long as we get the 32bit vs 64bit distinct correct all should be
> well.

Ok, makes sense. Thanks for taking a look into this!

      Arnd
