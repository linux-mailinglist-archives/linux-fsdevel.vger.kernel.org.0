Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5941343F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 15:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhIUNel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 09:34:41 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhIUNek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:34:40 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5lvf-1mvLdF29Wd-017CGe; Tue, 21 Sep 2021 15:33:10 +0200
Received: by mail-wr1-f42.google.com with SMTP id g16so39234234wrb.3;
        Tue, 21 Sep 2021 06:33:10 -0700 (PDT)
X-Gm-Message-State: AOAM533nIUvODTBLAsOFQ+6F+Qlg2Ihyf8/04NktttFljLN8S0c57nfl
        n5UOSTZf/ARXQmXCjmxHxn5oLsvHGLPRgThMzf4=
X-Google-Smtp-Source: ABdhPJxRIj5D47cQHOOP5MhzKSO5m6QcwBx7ekdGgjsOCcTSMmeomDdEql9MadmQK5oL6aEohxff777ifq2jViQ91sU=
X-Received: by 2002:a05:600c:3209:: with SMTP id r9mr4658602wmp.35.1632231189987;
 Tue, 21 Sep 2021 06:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210921130127.24131-1-rpalethorpe@suse.com>
In-Reply-To: <20210921130127.24131-1-rpalethorpe@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Sep 2021 15:32:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
Message-ID: <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
Subject: Re: [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for x86
To:     Richard Palethorpe <rpalethorpe@suse.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rEwtQybMOsPtIqOiGh5l9QIlVdlihtiMzP1HSKK979YWuWXlUJ+
 Til4ZqzWnjwjxy4///KxWbY5XoiduSa3wlyyoh8/YO9jN12sTHE8l1RMlzuDk4YcQ1T+qu0
 z36UBnIP9gZscszniqyRCCBgIDfSHH3VGvNdwtsuUCqTUR6bwm4tIgz/Ijzanv2iphiGUmd
 XwjmaRz0GFcYhGP+2eUVA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gQI7dtakFmY=:rVEwEk6k3ETOr0m/H+ELxl
 dDZNVLAN009nk3/5T4kI+TBegHMcX/wFUkZteEm5C5TZhxNEfWgZM+Xte32/eRgb5WQkp2OVq
 gxUJnpDFDAhSzG24Ugoi/qVtiGE0lNdqO4xUU9zsvJzdmly8GDFUa+wRaoo/ld0D1q3Ccx8Pm
 DXhIkHKp9urvlZoKw4sjR+NEhg+Pqid10SqY5sQQlwVoZl5zHE4Xil2uLYSa3g2S5vT3ClwBt
 j4/GWLwTEC2+nl5WME8vPd0hHuaaVClObYkb9aQvxCM8bwPnJ9m/07/xPDeL47YC71bwO4yVD
 1BqEuf5iWplpw/B1MGfJAq8bEIrA26LNDbmiCvkRAY2uyKHii00MGxZzKcmxtWD4a9Leo/O2i
 dJotBoj6y2xv0k4XgOcnQfdik4dMet078G7LpMWIy/yLCi9KmMmeOsyx8mA66JVrvVlMely3J
 oJzKJI2TtdFX2oDFnSz4ZLq27TdTL8UFkPQEx9VhTAmV50gAEafjZPKm5OK9cTjBcxUlInP6b
 x57otZWNSzWOIPE8LRXcuM8+erjL6CpiG2eKuXzaQ9J8MSjq5iKX59h//h/cI16s+YWd5zwxc
 earm8VMMuAh2dkyXT6r7OwmshHqSy8O8z7LEuAF888k/YDRr9r1bUf5WT4RcpZ9POPvxEGu+D
 nLzU1VTnD9XmHQKIYQgixOAzB4k8ZLkvCTKfolLIn+BgTTZ9uhDc3i88NkUyn0C+CHonlnHQZ
 ADWZoL97ybP2Qs4Bk2RcE4St5P1DnNgL3OyXEL4CeA3t6SR6zqnqoOBj1H4asItU8jG2XH3z+
 Arv/WGGkvLYjKADxHFyE6qVZ9Jpdf2ox+5MlUZxvFXPWeJNm8oZYRwHgz/PyV7KE5IXtPCVsm
 C6LZgt0mUAjDSSsKOCow==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 3:01 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> The LTP test io_pgetevents02 fails in 32bit compat mode because an
> nr_max of -1 appears to be treated as a large positive integer. This
> causes pgetevents_time64 to return an event. The test expects the call
> to fail and errno to be set to EINVAL.
>
> Using the compat syscall fixes the issue.
>
> Fixes: 7a35397f8c06 ("io_pgetevents: use __kernel_timespec")
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Thanks a lot for finding this, indeed there is definitely a mistake that
this function is defined and not used, but I don't yet see how it would
get to the specific failure you report.

Between the two implementations, I can see a difference in the
handling of the signal mask, but that should only affect architectures
with incompatible compat_sigset_t, i.e. big-endian or
_COMPAT_NSIG_WORDS!=_NSIG_WORDS, and the latter is
never true for currently supported architectures. On x86, there is
no difference in the sigset at all.

The negative 'nr' and 'min_nr' arguments that you list as causing
the problem /should/ be converted by the magic
SYSCALL_DEFINE6() definition. If this is currently broken, I would
expect other syscalls to be affected as well.

Have you tried reproducing this on non-x86 architectures? If I
misremembered how the compat conversion in SYSCALL_DEFINE6()
works, then all architectures that support CONFIG_COMPAT have
to be fixed.

         Arnd
