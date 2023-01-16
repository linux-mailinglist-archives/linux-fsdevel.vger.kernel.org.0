Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE266BB65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAPKNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 05:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjAPKKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:10:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338D418AAC;
        Mon, 16 Jan 2023 02:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E63FDB80B28;
        Mon, 16 Jan 2023 10:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FB1C433F1;
        Mon, 16 Jan 2023 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673863802;
        bh=WvUKV+LJJqo7bAhYclYeSMFCwFldg4KmpbXOAYz8QWo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lBW89nC335bSKVJufIQTqJ90AU9ql4YIY+Ppj9Gwj3YZEZSp/xPavFF4GGeXyd/RM
         ck+8dh37dVIL5J4En4mxnCR7gJ2/yLSWAw5XQL6Tio402pzpwhcUl2xxtaAcy+onfI
         khZWWGjbhZH02MiydW/l6V+jcb9luEFu91HBnU5hZ9l03DTfChxEV2A2l7XQUEPwj5
         sacnw3pUmG3judnxU2OuyQmJIRBoL2P99WngbmQZhO74uE8DECcUSTMU4XfohH3JWL
         ZycQrhEjsc2fkoPrqUaa/9INUPpD864zkw6zIK3XZ3z1ac1S0JDT1oAp4i2N4V+7xA
         zAnFJeSynL+lQ==
Received: by mail-lj1-f169.google.com with SMTP id x37so29469142ljq.1;
        Mon, 16 Jan 2023 02:10:02 -0800 (PST)
X-Gm-Message-State: AFqh2kqomSnjxTkNbWv1JXr9Q9QtFXzNMix87tbQA0sgFh+xUl/FBEYh
        6Wvyx9Lskc/XHpuv3jwkvktxlP0EC7IfBvGqEcA=
X-Google-Smtp-Source: AMrXdXuci9MgC4Yqkq9KkHHd04QolyddrXOjxcSpOm/4blocNC+0ii0paVfsFlAG2o8dCizIgUWfTcSThbA29z7ap4s=
X-Received: by 2002:a2e:96ce:0:b0:283:33fa:ee22 with SMTP id
 d14-20020a2e96ce000000b0028333faee22mr1349344ljj.415.1673863800637; Mon, 16
 Jan 2023 02:10:00 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXEqbMEcrKYzz2-huLPMnotPoxFY8adyH=Xb4Ex8o98x-w@mail.gmail.com>
 <db6937a1-e817-2d7b-0062-9aff012bb3e8@physik.fu-berlin.de>
 <CAMj1kXEtTuaNFiKWn3cJngR0J2vr0G07HR6+5PBodtr1b7vNxg@mail.gmail.com> <9f91942e-f4bf-e38c-2bb9-b32941b6d5f1@physik.fu-berlin.de>
In-Reply-To: <9f91942e-f4bf-e38c-2bb9-b32941b6d5f1@physik.fu-berlin.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Jan 2023 11:09:49 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH1SjPrPWyQbsYUHhVfgWH_p-sf-mhbeKMQn-QyOjBRng@mail.gmail.com>
Message-ID: <CAMj1kXH1SjPrPWyQbsYUHhVfgWH_p-sf-mhbeKMQn-QyOjBRng@mail.gmail.com>
Subject: Re: ia64 removal (was: Re: lockref scalability on x86-64 vs cpu_relax)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Jan Glauber <jan.glauber@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Jan 2023 at 10:33, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Ard!
>
> On 1/14/23 00:25, Ard Biesheuvel wrote:
> > Thanks for reporting back. I (mis)read the debian ports page [3],
> > which mentions Debian 7 as the highest Debian version that supports
> > IA64, and so I assumed that support had been dropped from Debian.
>
> This page talks about officially supported ports. Debian Ports is an
> unofficial spin maintained by a number of Debian Developers and external
> developers that are volunteering to maintain these ports.
>
> > However, if only a handful of people want to keep this port alive for
> > reasons of nostalgia, it is obviously obsolete, and we should ask
> > ourselves whether it is reasonable to expect Linux contributors to
> > keep spending time on this.
>
> You could say this about a lot of hardware, can't you?
>

Uhm, yes. Linux contributor effort is a scarce resource, and spending
it on architectures that nobody actually uses, such as alpha or ia64,
means it is not spent on things that are useful to more people.

I really do sympathize with the enthusiast/hobbyist PoV - I am also an
engineer that likes to tinker. So 'use' can be defined liberally here,
and cover running the latest Linux on ancient hardware just for
entertainment.

However, the question is not how you or I choose to spend (or waste)
their time. The question is whether it is reasonable *as a community*
to insist that everyone who contributes a cross-architecture change
also has to ensure that obsolete architectures such as i64 or alpha
are not left behind.

The original thread is an interesting example here - removing a
cpu_relax() in cmpxchg() that was only there because of IA64's clunky
SMT implementation. Perhaps this means that IA64 performance is going
to regress substantially for some workloads? Should anyone care?
Should we test such changes first? And how should we do that if there
is no maintainer and nobody has access to the hardware?

The other example is EFI, which i maintain. Should I require from
contributors that they build and boot test EFI changes on ia64 if I
myself don't even have access to the hardware? It is good to know that
things don't seem to be broken today, but if it is going to fall over,
it may take a while before anybody notices. What happens then?

> > Does the Debian ia64 port have any users? Or is the system that builds
> > the packages the only one that consumes them?
>
> There is the popcon statistics. However, that is opt-on and the numbers are
> not really trustworthy. We are getting feedback from time to time from people
> using it.
>
> Is there any problem with the ia64 port at the moment that would justify removal?
>

I would argue that we should mark it obsolete at the very least, so
that it is crystal clear that regressing IA64 (either knowingly or
unknowingly) by a generic or cross-architecture change is not a
showstopper, even at build time. Then, if someone has the skill set
and the time on their hands, as well as access to actual hardware,
they can keep it alive if they want to.
