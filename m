Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB3A1E512F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 00:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgE0WaL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 18:30:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:41419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0WaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 18:30:10 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MF3Y8-1jp2uP0LBw-00FRqj; Thu, 28 May 2020 00:30:09 +0200
Received: by mail-qt1-f177.google.com with SMTP id k22so5915055qtm.6;
        Wed, 27 May 2020 15:30:08 -0700 (PDT)
X-Gm-Message-State: AOAM531BeyRwL05UY3rtLnPZvc2nbJNbb7sKMNzq6Vi5Bajd5Ejmnh1S
        VuZGpF2Ko/O/HaUuElbXzRtWmFX7xz/WtjZB+eY=
X-Google-Smtp-Source: ABdhPJw0Sdq4wNMlX0rj1KsXIR85+wLbprQ8GBhIKMq/tB+jncEhZv4Duy7U08/H3avF8quPov/6lj3lUKHLEdRZq/U=
X-Received: by 2002:ac8:306d:: with SMTP id g42mr167827qte.18.1590618607910;
 Wed, 27 May 2020 15:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134911.1024114-1-arnd@arndb.de> <877dwx3u9y.fsf@x220.int.ebiederm.org>
In-Reply-To: <877dwx3u9y.fsf@x220.int.ebiederm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 May 2020 00:29:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1YHS0kQODqKEqZ5DJCSodyOWE=G5i0pjoPq_V0pQDauA@mail.gmail.com>
Message-ID: <CAK8P3a1YHS0kQODqKEqZ5DJCSodyOWE=G5i0pjoPq_V0pQDauA@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf_fdpic: fix execfd build regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:mn+FbMg1s8+W/BDX/3TYVn27SMUH65f55dYgmSvfH4jdsYFfBLN
 z7kZYksZI7k4rE/aPCtpd8B0zCr3lc2MCl477i9HRgfOTNNQvwgyslE9gElrBxeNPuMfTFA
 pKQWoLs59oveokwRsYlhTFlCpyoLvrjil4lsGlg7h5t48jWeIH8zg3XAob0nqKCeJvx3YgD
 uU/kHsAqfz/bePWAWTWIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QbcoB7o2wfg=:5y+a6YqR/iiqxWm3KiMSh8
 /XtzUvtTg6sBa4ovt8apLRxrFxKc2FcD077v61lk//Lc+IixzyXbY+C8lOQXG9Au4lhrOPfMm
 jEvZuL/sC6UZhRdFqI/NulbPU7CH9/7MjrZP5RNVFYBgc28hY9Rb+1uQljgTmWowEUYa/HYI2
 wiaWPra/Ix/gK/J2+1FB9YOj9xeuOz9sBdFJbNa9KibFvwYK5juZzHkd/kWnxO9uzKNGUcrhu
 ccicWTVJkspNDwzcviFVJ6IX0JdjI2y5qhTCDH7pSSGWlYDJgQ8JOg8bIEREyrzpi1+1s6I6I
 6nzbxGdreRG93NcZIgpFVJ6iNh85VZMOSTzdM2zsFAI71fHP/TZXe5RRW0BSzdRTeKSXxalFW
 t5EYdNF0SPCHHGe0+e1XSvswHM9XzKCBEi4doL6P+07BDrFXRj3Ksq5LK0UV/H8mguyaSZhay
 M6Ku7Rbal/ApvOnsHor2VedqGgAxp9mQfFSlxoMP1ZNB4NCaHIg+PKjaLAiIgyW05hkmfX3Q8
 tEWGCsXBhYKADsRl8vJy3T/17NN4dczfHjKWRQnG6xMJCW8Iqfv1F3lY1MZEskZv0j5sinsvZ
 ou4PNsIy+g2X0GVd62R12t3P4aI9rkkRmXuCw95v0rfStyDmCACU+0r1ussGC2CmB/0oLXvIS
 oZRI3tYH+VmCYjSRVygeETzGPQWKOR/EAGBfTVxXWbVfgL3Co0g5M+s/eUu0u8NTIVbrkEBa3
 puEnjO9quI2tyfTUaKRT+ySkhKprEvhLJgT8GhgY7HHfBVZ8LSCIgf5N+VEAI0u0tTcUp3Qp0
 n4TMSWbhtY0IlXqaFAHKYVK79qJMC3LJaY0Ks4eROXiSomhISs=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 12:12 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
>
> > The change to bprm->have_execfd was incomplete, leading
> > to a build failure:
> >
> > fs/binfmt_elf_fdpic.c: In function 'create_elf_fdpic_tables':
> > fs/binfmt_elf_fdpic.c:591:27: error: 'BINPRM_FLAGS_EXECFD' undeclared
> >
> > Change the last user of BINPRM_FLAGS_EXECFD in a corresponding
> > way.
> >
> > Reported-by: Valdis Klētnieks <valdis.kletnieks@vt.edu>
> > Fixes: b8a61c9e7b4a ("exec: Generic execfd support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I have no idea whether this is right, I only looked briefly at
> > the commit that introduced the problem.
>
> It is correct and my fault.
>
> Is there an easy to build-test configuration that includes
> binfmt_elf_fdpic?
>
> I have this sense that it might be smart to unify binfmt_elf
> and binftm_elf_fdpic to the extent possible, and that will take build
> tests.

It should be included in an ARM allmodconfig. Nicolas Pitr did the
work to support ELF_FDPIC on ARM with MMU a while ago, but
I'm not sure what it would take to make this architecture independent
or support build-testing on x86.

       Arnd
