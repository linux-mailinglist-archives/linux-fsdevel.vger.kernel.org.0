Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62EC19F649
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgDFNBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 09:01:43 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51515 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDFNBm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:01:42 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N9MlI-1jIKor1ERw-015Lh9; Mon, 06 Apr 2020 15:01:41 +0200
Received: by mail-qt1-f176.google.com with SMTP id f20so12682135qtq.6;
        Mon, 06 Apr 2020 06:01:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuZRqJFzBfGN2kcbOmxTsxVGDR1Ew//AdsEuGdlqjoeFeM6O6XMp
        XK0D2kcs4tLnZfPliPVGccE1f1+4T+afC+8JkGQ=
X-Google-Smtp-Source: APiQypKGl0rcjmxPk7LYkIyq/3sFEAQ9JSPbooEo+AQI5dEX6atvP7qavyGi7h4ravOrmygkje1eLWDqMVjJqya7e2s=
X-Received: by 2002:ac8:d8e:: with SMTP id s14mr20274585qti.204.1586178100052;
 Mon, 06 Apr 2020 06:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200406120312.1150405-1-hch@lst.de> <20200406120312.1150405-3-hch@lst.de>
In-Reply-To: <20200406120312.1150405-3-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Apr 2020 15:01:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a02LQNOehukgaCj81wg1D2XhW1=_mQZ72cT6nQdO=mhOw@mail.gmail.com>
Message-ID: <CAK8P3a02LQNOehukgaCj81wg1D2XhW1=_mQZ72cT6nQdO=mhOw@mail.gmail.com>
Subject: Re: [PATCH 2/6] binfmt_elf: open code copy_siginfo_to_user to
 kernelspace buffer
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dGr/PTHzNlhAg8nmJiAVpx3qyNykoPFVVfJTEzev2QMu2b+GJt5
 MwseBCwLfebyAuVxIj/eu++fOsT1+89Ai5a1SSOdnXOQxMo6iiUdOEDBKBvBchemFXS/9iM
 ksV7b7Y7iaQmlwq2jnGXyH1a2sQhbvu7Vto269EJGL6tEVzCkJIhvqlL7Wpb9kxOD1Likzp
 EXMzAPOON4rmpwi8DBpEA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H8nvoPmcBCY=:+2G3Ozxt1Z+SydtUKt6d+5
 nhOaKGkoBaQLlFv/IWC59fP+dHQ2tuwUBpEkkjrzQNh0CBU2b/dcZd8jXcjA6Y2SVn4eiE0hU
 eay14z9qwK4/38FrfqmBY6zLzpomzZHdr5D77TZ5ALRZU380ACuLme1pGarQZ27GoOZ9YvlB3
 C716dVErOAKDR5FlSnHazfCKl2lRPs+vmeTXx5lRpnepmxoI1GJA5D+dCk+crd5UiNZBdOZFs
 BKaX0b/jWX+sqWXxtmMrZo63BsZALqajLIAbTEkPsk4CR05Ii9G9Aq8iYRLu3W3EbLgBYNJLL
 TDukJxQULIYJi658+D3FQ3YaW+RkaihjXBkRTWg2sGUej2jUtFS+v84wwgm6qIsfSPCVzwO8n
 On95rRtx/Zb1qe5WAJJcKNqBbYXJanXtcTr5nGzlfJ5ilNbdM/21+O0UkRvxNYA9VV93FsA3+
 Glr/520GmIxPmtFIBHC0MXy5saL92Xd3BuixvDZsfmJ6hli5jVO7jaOiXm5CGDhU9xousUa96
 jT3xC1Mhi7uz+tSY/JZHfXw3d+JTeV4uoHeTFQzPzKIBg0W1uVLpnTbvI04IFtyJxEfunZC03
 gtJuXf42oijsmYOTbyk8VKTmm/QgIaH0nNtuxMFEaGsHeoZeLHElAJSCBLVKOha5IDxJZheAg
 lp6o2OEcLoYDzRCDCmX7cvqJOWM/gIlgyDQWIS4w0w5bcu3Z0URlSPZpMC6U8t6p9FLtMLNTC
 vFJDGO5KOjV1qEgCXVohXE72xiqlUY/7DCcbqj9ags4/2F1OfuwR2JevtwdR/tGk8UVQ3JFW+
 gB59/5Fpbgxr2cQ13bEcWC5nKoxiXp+dSu50lHipR6kRWDLU+c=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 2:03 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Instead of messing with the address limit just open code the trivial
> memcpy + memset logic.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/binfmt_elf.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f4713ea76e82..d744ce9a4b52 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1556,10 +1556,9 @@ static void fill_auxv_note(struct memelfnote *note, struct mm_struct *mm)
>  static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
>                 const kernel_siginfo_t *siginfo)
>  {
> -       mm_segment_t old_fs = get_fs();
> -       set_fs(KERNEL_DS);
> -       copy_siginfo_to_user((user_siginfo_t __user *) csigdata, siginfo);
> -       set_fs(old_fs);
> +       memcpy(csigdata, siginfo, sizeof(struct kernel_siginfo));
> +       memset((char *)csigdata + sizeof(struct kernel_siginfo), 0,
> +               SI_EXPANSION_SIZE);
>         fill_note(note, "CORE", NT_SIGINFO, sizeof(*csigdata), csigdata);
>  }

I think this breaks compat binfmt-elf mode, which relies on this trick:

fs/compat_binfmt_elf.c:#define copy_siginfo_to_user     copy_siginfo_to_user32
fs/compat_binfmt_elf.c#include "binfmt_elf.c"

At least we seem to only have one remaining implementation of
__copy_siginfo_to_user32(), so fixing this won't require touching all
architectures, but I don't see an obvious way to do it right. Maybe
compat-binfmt-elf.c should just override fill_siginfo_note() itself
rather than overriding copy_siginfo_to_user().

       Arnd
