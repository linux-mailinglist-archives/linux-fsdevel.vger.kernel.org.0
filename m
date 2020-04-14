Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5B1A7E49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbgDNNgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 09:36:50 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502806AbgDNNPa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:15:30 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MxmJs-1j3uc50aLu-00zIi1; Tue, 14 Apr 2020 15:15:27 +0200
Received: by mail-qk1-f179.google.com with SMTP id w70so8841819qkb.7;
        Tue, 14 Apr 2020 06:15:26 -0700 (PDT)
X-Gm-Message-State: AGi0PuaZ5opB60kucpaK2dxIo1LPh1vIWAMOIHqNxBnuUvLBiuht7WaX
        l68Q8QjBWHmvRfWsPKpNrMC7cLC7CqoXhfmHQ/Q=
X-Google-Smtp-Source: APiQypKOQ+PuEkXGp7Hz6/dS0o0rdKdh/QEInnUOkTVAVIiLqxS184q6+DgOArKrPli8Cwrbt3SJu+aKb3Opir5v4iw=
X-Received: by 2002:a37:9d08:: with SMTP id g8mr13992637qke.138.1586870125394;
 Tue, 14 Apr 2020 06:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200414070142.288696-1-hch@lst.de> <20200414070142.288696-5-hch@lst.de>
In-Reply-To: <20200414070142.288696-5-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Apr 2020 15:15:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com>
Message-ID: <CAK8P3a3HvbPKTkwfWr6PbZ96koO_NrJP1qgk8H1mgk=qUScGkQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:niGzd+JIMAutrTQXi6aKMm7ZjyhZV08h5hlKZzx03Gb3lOmqT6z
 7i9vKEXvzYnwIGk8z3AGZjTgK2evm1jqoj8C/KsTN2Ng17n0WzNRUfAttBxm+cyLxzHRCbd
 ZgmOELgyTQmtDGKM9c0uepxXWGPrNEb5DvfV8rBFyumfuu2aoBGFr67kqa4kjgCo6DImAZb
 fC212L394gbLr8KoeHrRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:In4NPF/T4tQ=:D5Hh2GBE1UE4cO2sq1wZiv
 RC3T/YjsyxZv/Ps3c4TABpyGM0qA6CTNR2x4Rks4MoHbc7ZaTIf5R4s61VqPYspc/1nq1v5ul
 e6iKT3tPdL8wn3bTuJp5SqO6ncMhuC2n8ukLKcCkkKdIvd/XjcKdcMr0bmfw3xX17IlLVxwqD
 PcsmOzadW/bIy5VFJFWI8NDupqMlKM8Cxmp+XdqwPmlBSEqTwtUBDT6rl7EEIi6E9Y+IE8iG8
 a8vQNskKzM+Vo1MqAfhXJyxMu1CkvY7xoikclgJ0BAnNSaAAwpgnAcFTj9YAxkcd424JMuTVk
 +bmNAyEQshYaZ4wQBK1cs+mypFEa1q38cWAgCOLcGJqVSLFse6iWTQklWw/3Db2EFxAT8d+f+
 BxcRj4dBk9Cahs+kIctVw9mz7mdBKOZtI5sDIxKv96lWFo16sL5o7jJJBBXTTphXqb6m0ICrV
 frTKlzZnN4qNCGvTrUGSgkxekj/y0XhlnG9vGDX3fsCxw9H7Semf4n8JhdijAWCbEm3auYWMO
 JgY7Gu64sj1PqqvdO52ZIbz0CGPP391WCRIRQkdhvXvqgD6SS9pdncyT4tjohGVM0jQCDnb1w
 DCoK9zdPjPGAahfo3JRZjNtebuHMhMDbI1LN1zci9H8uNZBRvqt6alrXlj6Z9ZJw8BkIaoR+n
 tpOj6W213m7vpp5e5NxGkQB9wdpCUrWQFcS6tvZJqUiy4GXXXvHIUtkJOGjo/qNZWHJH4Oo/N
 7WyaUiDFlGuBzv+rPC9/aKBgh1ndpMJvQW5Yqoby+LyBpS83Yj70Y0QtBjD45AThagnWckzBU
 db9XVwsjcezC3Zga9uFW8Spn9Jk6s+D3epsJDdiSY3kyhSi/7M=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 9:02 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of messing with the address limit just open code the trivial
> memcpy + memset logic for the native version, and a call to
> to_compat_siginfo for the compat version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Nice!

>   */
>  #define user_long_t            compat_long_t
>  #define user_siginfo_t         compat_siginfo_t
> -#define copy_siginfo_to_user   copy_siginfo_to_user32
> +#define fill_siginfo_note(note, csigdata, siginfo)             \
> +do {                                                                   \
> +       to_compat_siginfo(csigdata, siginfo, compat_siginfo_flags());   \
> +       fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata); \
> +} while (0)

I don't think you are changing the behavior here, but I still wonder if it
is in fact correct for x32: is in_x32_syscall() true here when dumping an
x32 compat elf process, or should this rather be set according to which
binfmt_elf copy is being used?

     Arnd
