Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ED4214BFF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 13:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGELYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 07:24:20 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36334 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgGELYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:24:20 -0400
Received: by mail-ot1-f68.google.com with SMTP id 72so29692648otc.3;
        Sun, 05 Jul 2020 04:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxueHSFVe1aY1SfjGzwH+5B9lPYaHFHBKRhJv4KWryk=;
        b=nCWku/S1kkUEpt6XI/Vm3rAtbrZw+4HlOldVW6VCujhqHnbBLmpH3U77+YCRkbH278
         hCZ4MjxAEKlFbrBrOnaaQ5oXD9ZNM7C6534DOdvRP/jNl3EqozlXI16+pOfQGuHZugVN
         SIKe+ZNfrJ+zII4aGBcu6plOEPj2BWIKxCKRrmoDKRmqMxwmCUTjoqjdiLKTtRIgFnbw
         yUWseV2Dr2QtoQHuOTi4Y9ahC8t5M1Y/niPPwFFRLzQmLYMzZ1syuPnFFspmz39exobB
         58nedWlJIBgTfs77UQATqydRDWtw4X+H54k3hDNq4ce86DiCfONvURO3IXtnJQSiT/t4
         z5jA==
X-Gm-Message-State: AOAM530acvyzhicDfyPktu6HuKAVRB+MBQtSEwv9VN5PpmJbqjNq6TvF
        a31I9U9pBnOpQSJcrH7ZjUUHbIFJ2yX6EvjNdBI=
X-Google-Smtp-Source: ABdhPJy/L7XGfZyHJsgsdBjJrruteRX+ylOfRwuY53cd1zwMZL1gYan2bpX+i/exMvPsL3QjXVT37Dd41cZNOTtRE/o=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr25172162otp.250.1593948259060;
 Sun, 05 Jul 2020 04:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-4-gregkh@linuxfoundation.org> <CAMuHMdXck1u+Djv1xOvRA7riMN4m3qp8o4zmXVvqrC1S+0fifA@mail.gmail.com>
 <20200705065514.GA34145@kroah.com>
In-Reply-To: <20200705065514.GA34145@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 5 Jul 2020 13:24:07 +0200
Message-ID: <CAMuHMdVWebaq24=cC_LYkxuLMVrSRW3FDohE2CiueUWC15Tm7A@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests: add readfile(2) selftests
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-man@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On Sun, Jul 5, 2020 at 8:55 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Jul 04, 2020 at 08:38:26PM +0200, Geert Uytterhoeven wrote:
> > On Sat, Jul 4, 2020 at 4:05 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > Test the functionality of readfile(2) in various ways.
> > >
> > > Also provide a simple speed test program to benchmark using readfile()
> > > instead of using open()/read()/close().
> > >
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> > > --- /dev/null
> > > +++ b/tools/testing/selftests/readfile/readfile.c
> >
> > > +static void readfile(const char *filename)
> > > +{
> > > +//     int root_fd;
> >
> > ???
>
> Ugh, sorry about that, I obviously didn't clean up my last tests from
> this file, thanks for catching that.

Reading about seq_file behavior, did the commented-out test for
"/sys/kernel/debug/usb/devices" work?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
