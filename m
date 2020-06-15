Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4541F9F9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbgFOSrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 14:47:23 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgFOSrW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:47:22 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M7sM0-1jolkg0Aj4-0050Na; Mon, 15 Jun 2020 20:47:20 +0200
Received: by mail-qk1-f181.google.com with SMTP id q8so16734336qkm.12;
        Mon, 15 Jun 2020 11:47:19 -0700 (PDT)
X-Gm-Message-State: AOAM532Zh62jZF7IScwZrGQWmsKpDNcfc9mr6ToDm3Xp/YevH8LsXbpk
        TVopIoc7hWFDjm75Zu5ryClsRarU2rvwEYpEgvo=
X-Google-Smtp-Source: ABdhPJzcQbK0Gh43Vbjt9NhNlEHEP8lArPvLwYPZGPIYALBqTjBUF1iUc73zpucajmn7+xgOQVN3+L0nF4AR+SfsCY0=
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr15874842qki.3.1592246838316;
 Mon, 15 Jun 2020 11:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200615130032.931285-1-hch@lst.de> <20200615130032.931285-3-hch@lst.de>
 <CAK8P3a0bRD3RzE_X6Tjzu9Tj+OhHhP+S=k6+VYODBGko8oQhew@mail.gmail.com>
 <20200615141239.GA12951@lst.de> <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
In-Reply-To: <CAMzpN2heSzZzg16ws3yQkd7YZwmPPx_4RFCpb9JYfFWJ9gfPhA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jun 2020 20:47:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3q-hC7kZwLPbc+E5VYcqthQS4J4Rqo+rKkBRU2n071XA@mail.gmail.com>
Message-ID: <CAK8P3a3q-hC7kZwLPbc+E5VYcqthQS4J4Rqo+rKkBRU2n071XA@mail.gmail.com>
Subject: Re: [PATCH 2/6] exec: simplify the compat syscall handling
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
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
X-Provags-ID: V03:K1:5GjnYx0J87C77bLS6hMICrpv7SsJrmsJfyFkoZ/+LoKPVJfqpC4
 /AfZewhVis2YEpTJGiS6awXwvUfSN/3ej6d0BBm+Ts0UEPmvLjn5NbLiCLaAmpa1xxZc0vk
 gkrEPFCdlc6zQ2yi98hk0uCeSs8N88VAjJOfwnv1w8buTd3DApJh7sd3kb8kLOZb6d+0xGR
 y95oybICxuNU1Eu+9tA1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O00rYkEmzd4=:n94Ow7JDI1CgjsWhSySVId
 MFeIzFQ0ReIOQKC+1DIax5tWGzqGJPz1R27aM0+nQzOMAWlOh+BJkrLWFh+X4QAJ+rm77DwVy
 JCfBdMOZSV9mgrZq8ZvilMbNU9Ocyk9T0McCpKp7HRW1Dy7UGlIputexAoM9/EL4BAEB4kkuP
 pgrswxarTjgYKFeZXxGOH0HL9KJ158tVHglV4I5zFB/zllXofs5iMexfLb+EAgopQkCYY0kpS
 QXuYZmv0Qt1+kSbk+WK+5qfvvaJBa91JgxAPRUZ+adF8JFSQDlNm12cF+x1s8nKJYVPdk/+Uz
 e/8dDZ76C8ZTbbnyPC6KYaS2AEqJwyOZSFpt65Yj36I4tkitdbzQL3zuDZIh9UC8IswDNXlgn
 zwN11R6M7r6yMTJ++E0Y2Q85IN45qly+xWSeZ+Fgq2RUk0Wj4wF5UsHNgj7KtvV6KEy8gNDdA
 DuEaCrtiKM5BKY0GvHH5V65kuBqZ9VjxayvpibwVcQH2BRM6v+sH529ezlxRCvIcfRl9d30GN
 lus0EjHqd9f/adxr6q7fC7HNz7m+8EgDQH6OvXyZKoqv8tl1l1ic2UK0slQgEVeLxwZIjGHWq
 k6Y8kgNMaPbpQNgDzAr9k89BvfqQjHmqYuWSYIrU5QKTCMunaQ0hYPSLSL7gWV0xRpgw4FIs3
 MqwTHBmEdOuqVhjT7LZ2ksIwa0oFpIC8hcwWfTNeHSymsfs/ReN4fjU/L4TWGTj+ZcYCGgMuI
 zN3ivEq9V0UggtSP9EmDhxrpt4/6chz1kSPmour+ky9RwMTXPfFhXKNFAlHTN0bO5I7/ERIVp
 fBvbtu09WOLhNcG9dF+7v9uEtIqN1I8iMyQnVaFEhddMShJTNo=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 4:48 PM Brian Gerst <brgerst@gmail.com> wrote:
> On Mon, Jun 15, 2020 at 10:13 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Jun 15, 2020 at 03:31:35PM +0200, Arnd Bergmann wrote:

> >
> > I'd rather keep it in common code as that allows all the low-level
> > exec stuff to be marked static, and avoid us growing new pointless
> > compat variants through copy and paste.
> > smart compiler to d
> >
> > > I don't really understand
> > > the comment, why can't this just use this?
> >
> > That errors out with:
> >
> > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1040): undefined reference to
> > `__x32_sys_execve'
> > ld: arch/x86/entry/syscall_x32.o:(.rodata+0x1108): undefined reference to
> > `__x32_sys_execveat'
> > make: *** [Makefile:1139: vmlinux] Error 1
>
> I think I have a fix for this, by modifying the syscall wrappers to
> add an alias for the __x32 variant to the native __x64_sys_foo().
> I'll get back to you with a patch.

Do we actually need the __x32 prefix any more, or could we just
change all x32 specific calls to use __x64_compat_sys_foo()?

      Arnd
