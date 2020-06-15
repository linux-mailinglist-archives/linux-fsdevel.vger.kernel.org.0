Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF51F9A80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 16:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgFOOkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 10:40:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbgFOOks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:40:48 -0400
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MhFpq-1jFNQS2dOs-00eMxN; Mon, 15 Jun 2020 16:40:46 +0200
Received: by mail-qv1-f44.google.com with SMTP id p15so7836070qvr.9;
        Mon, 15 Jun 2020 07:40:45 -0700 (PDT)
X-Gm-Message-State: AOAM530oKr5G6Wya8ZW8EcZAQsiktb3q8OAbapeIjGV508MLBbm5q2Ya
        dRnpTrf84sI4lMGHMpWYxx4xoENEvkrSYnIG4p4=
X-Google-Smtp-Source: ABdhPJy5G+lqXMDgYV5VNdPxt3xfenQEOCWyA8aXe4/SWcJM/wjewAOCgmyKi30Ru8Z83jxOnA642v09TgrEUqRdTlc=
X-Received: by 2002:ad4:4b33:: with SMTP id s19mr23452579qvw.211.1592232044975;
 Mon, 15 Jun 2020 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com> <20200615141239.GA12951@lst.de>
In-Reply-To: <20200615141239.GA12951@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jun 2020 16:40:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
Message-ID: <CAK8P3a2MeZhayZWkPbd4Ckq3n410p_n808NJTwN=JjzqHRiAXg@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yeyn4LpBjnSQIL5kmXl59WvDCslbrj9cB+DtsPez3ktB1CQQRma
 Wys1ZX994H4JCDvP0zEMNnj97nFfkV8XQ8W59Yp7HuS3/bWo+blADuXafMKBgjxPd1GURDR
 nVOjqlFFWNphzXU+UQBD06kJYPMLH6lQwc8izTEFtL6jyDDxG5F9nhXAOwmyJBqNZ28HKbH
 azWTAkJSQKXT25ml0g6Ug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CnPrP/o/P08=:f/QukO5DjQmM0jq7i3UNlT
 /iTb4X9zyrotln7mI6R3s2273e0i48RiLhjNxIwV1LIbF+NrO1u0OvKPGTMS8/YOUFLbBpGdL
 i8cFbR6pUUVKNQ1mRY9hzGPqZ+ZzAQiZO7+3iijn1t0Hljh7+rWNjm1f3u+mmszn4CS1m1RK/
 +Fda3A7N16NNNBPh7itpeIZuzu0g0MBMNFTv2pTIa7oYc8RlC73oeFPvoprU1di/JYqfF+1ar
 CHG5gskG3ZuDSuoO+M7+mJvD9UWz530A+Cc/swVkq9nqehf6yyNldcZa9O/GmjO5wgu8I2Hst
 zJWUcmXe49izUFHgaturu1BlqUx30YcFQzQWnMUrK3C/lWLBwViDleuE+noaZTXIE2eUxgm4U
 HCBg5d+2s+eXTcQENpPAr53mA5xzGUeZYCAuTyf15hpSFHKq3yh/azxk4NvEcZ6QhITgj80mH
 Rgmo4GEI5b1xJaY9PFCzC+6xV0VbcbyP6qKgf8i4741vmRtRygqqsrrcHLaUHPHdetiRokeVi
 y0nGT6NWtMBnnJ9N0tb2gQ6fmGURdISohB5GyvgRdjqne7JYa0v+ltKiN6+snk9Tn3KdFh7MN
 Q8pSKgVxI2JmMTs+y3n4I5vjAlBM7Mryy3d/ns41Nq3ia0eo1P9SaUTvySbFChf8UEfuEMxW5
 xLTePhBkX9UpbX6xHFJ2crlXLCSPYFNjTz7wt59LhC6GAYwjVTfeN/4WpaakGXQ0qE1Lj9R16
 NbHBa1Ulp0y3Zqo0iVlevDZUVErGhx1gQBnxaan4GzemyP88NrUYinQCJha4qOb6r6zXoDOQX
 KOooMqgr5qovbuc/5wLI83qzQ7fFEBn4ysISz6QxP9QKeJNOnY=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 4:12 PM Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:

>
> > I don't really understand
> > the comment, why can't this just use this?
>
> That errors out with:
>
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> `__x32_sys_execve'
> ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> `__x32_sys_execveat'
> make: *** [Makefile:1139: vmlinux] Error 1

Ah, I see: it's marked x32-only, so arch/x86/entry/syscall_x32.c
uses the __x32 prefix instead of the __x64 one. Marking it 'common'
instead would make it work, but also create an extra entry point
for native processes, something that commit
6365b842aae4 ("x86/syscalls: Split the x32 syscalls into their own table")
was trying to avoid.

      Arnd
