Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310292EED6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 07:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbhAHGVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 01:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbhAHGVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:21:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC02C0612F4;
        Thu,  7 Jan 2021 22:21:10 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id o6so8702823iob.10;
        Thu, 07 Jan 2021 22:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fRt9iAXeB2GI80EtXCRbQ5aPiZvmK+o9C7d1Bsvt+do=;
        b=YxOpNcVVoOZcKlJ+jiokzag6bi0HEzoKriJlkH//jlV1sPU3hIViinaCAL/qHDr2wL
         FuZ/waQYK90AYDAwq48hHhRfskGWNaI6ck3/4gWTOYytUl0CTyx3HmXv+fCxSA1S2KWK
         KE0NdIdrjvzxpx9GPdjnKzp1+w/iNFyshGmsW0TdoywtCVA2NQqOQYSu0aZMPbTpO4gp
         bZe+NkauFHsSdm/oVSJkBuqLM0Y45CIFvuG37e8evCO+/SjHV1c9wnIPAXy2J4eh+7iV
         ivEPaeM9X6gx0CjqsF/PZ9BFPPhnBfCoZ76VshdqfNV+I01yClfjbT1qA2w+WHus+OG3
         jV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=fRt9iAXeB2GI80EtXCRbQ5aPiZvmK+o9C7d1Bsvt+do=;
        b=fliO1kIgiL4mIYsmvgggaiI/PanaxczdqobkGBslCJxU64fRYqjdpBnLkbiSTkEkzj
         nP16TD2JTSRGQIM1dB9DB9hrX5lpqvVFZPu51cL8z/tAJpvq4Xp0qgbVwbNoJ5/sBRDz
         XOSfi+fUCTQeXzJsnGlgX0hP2lr+U1Q3PdcjLM/Szd6XYjCo/vDr4T8SGpLc3xbKCkYs
         tcWrAMYo3ieWag1B/EJlmNXeDayD/7mSzgb5djeBOE+aC2nJeYWWjpZtYseBncNtnZp8
         pGEtEYJeIzE34ZZCw0MvkkCf9wwGMLRP5/BesQ6vLMEqfAEt4Sy7BHHWASB3zCOF5TgM
         VC7Q==
X-Gm-Message-State: AOAM531yWK3k1LYkf/FkMjrxfQgsItNRspsVv4hAc04ayof3edodEdbN
        onEads+2PaTQrehPGR5fZS02ywRd3hCIcpNPjwo=
X-Google-Smtp-Source: ABdhPJxsdAo6XSDAxRybNW7xXZoQEcdYx521f19aso48ztHDovkw0r9XhjsnHio7q4YIwwUmhcfg4q1gjT6R1dsQyuo=
X-Received: by 2002:a02:2ace:: with SMTP id w197mr2101883jaw.132.1610086869403;
 Thu, 07 Jan 2021 22:21:09 -0800 (PST)
MIME-Version: 1.0
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk>
 <CAD=FV=WJzNEf+=H2_Eyz3HRnv+0hW5swikg=hFMkHxGb569Bpw@mail.gmail.com> <6fdffaf6-2a40-da4f-217d-157f163111cb@kernel.dk>
In-Reply-To: <6fdffaf6-2a40-da4f-217d-157f163111cb@kernel.dk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 Jan 2021 07:20:57 +0100
Message-ID: <CA+icZUV2jRPtKyTw7h-mST83yooTdOLYRBWcoLFgUSjtcUMVgg@mail.gmail.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 4:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 1/7/21 3:17 PM, Doug Anderson wrote:
> > Hi,
> >
> > On Tue, Jan 5, 2021 at 10:30 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> Song reported a boot regression in a kvm image with 5.11-rc, and bisected
> >> it down to the below patch. Debugging this issue, turns out that the boot
> >> stalled when a task is waiting on a pipe being released. As we no longer
> >> run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
> >> task goes idle without running the task_work. This prevents ->release()
> >> from being called on the pipe, which another boot task is waiting on.
> >>
> >> Use TWA_SIGNAL for the file fput work to ensure it's run before the task
> >> goes idle.
> >>
> >> Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
> >> Reported-by: Song Liu <songliubraving@fb.com>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >
> > I just spend a bit of time bisecting and landed on commit 98b89b649fce
> > ("signal: kill JOBCTL_TASK_WORK") causing my failure to bootup
> > mainline.  Your patch fixes my problem.  I haven't done any analysis
> > of the code--just testing, thus:
> >
> > Tested-by: Douglas Anderson <dianders@chromium.org>
>
> Thanks, adding your Tested-by.
>

I have this in my patch-series since it appeared in [1].

Feel free to add my:

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang version 11.0.1

- Sedat -

[1] https://git.kernel.dk/cgit/linux-block/log/?h=task_work

- Sedat -
