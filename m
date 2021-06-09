Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB46A3A1E57
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhFIUyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFIUyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 16:54:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA14DC061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jun 2021 13:52:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x14so1602461ljp.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 13:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XArs7dfKd1jb8KVECknZ5tHK7pCuauc7kNtOU0BuGyQ=;
        b=d2c1kWEJ0AgEydECoXutpmofFDQXFyVtEZ9eA5D5JURcxb31tlEXBtljToI9e7Yp4S
         nnIcfeTgiuCVJKge24fWKsfVzi+rcZe0APlOb5EAnE+y2tUwASVAyuMnEM1BsjngaF8O
         6ZbYHAR2LSXCzqR6zx26XbzDZ2HReHBMouhrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XArs7dfKd1jb8KVECknZ5tHK7pCuauc7kNtOU0BuGyQ=;
        b=hd+RWBl9fh/AfxEdPhKcz9O7nE/vRG/DoMB0qhvq82KYJKs9W2qWgmZCQWNlRIxsLf
         zVwoV2IZd3pmaK1gy+GW3n3EzVhAs/z4Ofr/MBwIT98fXtYUDBKLL+WR2tz0lhAkZViT
         BgBBnZN84LzY7AAoH8QrrfPls8IvpFQi1auEwhSIrOj1fONI/DnRWJRi20oj3SIOdeoZ
         r/KO7P0N9qFPdIvupgell1SgwWul33aeCK4pGP92haRht5aBmPbcvQct1Lz8/biuymzD
         7gxv+158ddHIij5HyqxCyw7EdeYrKltamDJRYGaPpWqDIEV5Ukk7d4d1WDr3cQ+vLsyk
         eXwQ==
X-Gm-Message-State: AOAM533+AHNSaCLWxSQIo9UKutQfHeOmXXFkEzSh8seouZG3D9i6OqEz
        fdc+3pMT2CFD1KxO/NfQ1rv0mvcs0JMaOwj59UU=
X-Google-Smtp-Source: ABdhPJweCDx3iQcUhkEyEQPcD58XXj0vBtqQ1cV1c9JCATdorcXJARc5MGJo2wK3AdWNTxumA930Pw==
X-Received: by 2002:a05:651c:323:: with SMTP id b3mr1280556ljp.139.1623271944862;
        Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id c14sm88237lfh.257.2021.06.09.13.52.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id r198so36821653lff.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr826068lfl.253.1623271944108;
 Wed, 09 Jun 2021 13:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <192c9697e379bf084636a8213108be6c3b948d0b.camel@trillion01.com>
 <9692dbb420eef43a9775f425cb8f6f33c9ba2db9.camel@trillion01.com>
 <87h7i694ij.fsf_-_@disp2133> <CAHk-=wjC7GmCHTkoz2_CkgSc_Cgy19qwSQgJGXz+v2f=KT3UOw@mail.gmail.com>
 <8735tq9332.fsf@disp2133>
In-Reply-To: <8735tq9332.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Jun 2021 13:52:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXROFSDa6gHei4fNmdU=VppqnBThdCraNpuirriSyKQA@mail.gmail.com>
Message-ID: <CAHk-=wgXROFSDa6gHei4fNmdU=VppqnBThdCraNpuirriSyKQA@mail.gmail.com>
Subject: Re: [RFC] coredump: Do not interrupt dump for TIF_NOTIFY_SIGNAL
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Olivier Langlois <olivier@trillion01.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Pavel Begunkov>" <asml.silence@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 9, 2021 at 1:48 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> It looks like it would need to be:
>
> static bool dump_interrupted(void)
> {
>         return fatal_signal_pending() || freezing();
> }
>
> As the original implementation of dump_interrupted 528f827ee0bb
> ("coredump: introduce dump_interrupted()") is deliberately allowing the
> freezer to terminate the core dumps to allow for reliable system
> suspend.

Ack. That would seem to be the right conversion to do.

Now, I'm not sure if system suspend really should abort a core dump,
but it's clearly what we have done in the past.

Maybe we'd like to remove that "|| freezing()" at some point, but
that's a separate discussion, I think. At least having it in that form
makes it all very explicit, instead of the current very subtle exact
interaction with the TIF_NOTIFY_SIGNAL bit (that has other meanings).

Hmm?

             Linus
