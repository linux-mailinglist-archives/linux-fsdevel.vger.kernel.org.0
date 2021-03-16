Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8D33DCF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 19:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhCPS6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 14:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240252AbhCPS52 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BD6365144;
        Tue, 16 Mar 2021 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615921047;
        bh=fuqPWT9ZfDTWjTv6w3Fb6GeBN41qTet6kJjS9fS4hHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EI1G9nARmOORzV+S0XhsAd7FdHEnsgBS2qhowJTJUt7BWaNo8rEdQHkF7bvhlJl8T
         rUQyWEVlEDpjgRBKx1eN83Ria/jsq3Na2kao9zn5hDb5RGGFqlGeJxZnMp+hW3HKXk
         OZC4QM7xXQIIAYwyBxcx4BCERwVarTK4QsAH640yQmu83LLweFKgkYxE8DwKv7zmWY
         r80ZhqDkAD+ycWTNYXeDX4yjqC8rBS8l30TQ0HC+rPH5JpXvIoeKWsL1o08dloPzxE
         jdEk/ycE7fl0NP339OzdlLRKJzwvnJMhc/6ehuEcxRaEvLAncAH/tFej6MNioOqJ2T
         hmBIYVvb7Z2Kw==
Received: by mail-ot1-f43.google.com with SMTP id f8so9089497otp.8;
        Tue, 16 Mar 2021 11:57:27 -0700 (PDT)
X-Gm-Message-State: AOAM533ZG7pFvtNKMTAQKc1XGfqPrcpFd1Qw7A+U0LK/lAq/TIdCxzac
        JMqr6ftHZgPByLQN5l6dTzRV5NMTahl8ziAMsLM=
X-Google-Smtp-Source: ABdhPJz1W7Xll+XdK+pZriw5mP7sb2cdn1mH0Xz0V4HUQd4J/exhwq+Yn8DZw70WLdbDIdOAaV7C6wSZ5nhs6IubRBw=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr167743otq.251.1615921046478;
 Tue, 16 Mar 2021 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-3-balsini@android.com>
 <CAMAHBGzkfEd9-1u0iKXp65ReJQgUi_=4sMpmfkwEOaMp6Ux7pg@mail.gmail.com>
 <YBFtXqgvcXW5fFCR@google.com> <CAMAHBGwpKW+30kNQ_Apt8A-FTmr94hBOzkT21cjEHHW+t7yUMQ@mail.gmail.com>
 <YBLG+QlXqVB/bo/u@google.com>
In-Reply-To: <YBLG+QlXqVB/bo/u@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Mar 2021 19:57:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2K2FzPvqBYL9W=Yut58SFXyetXwU4Fz50G5O3TsS0pPQ@mail.gmail.com>
Message-ID: <CAK8P3a2K2FzPvqBYL9W=Yut58SFXyetXwU4Fz50G5O3TsS0pPQ@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
To:     Alessio Balsini <balsini@android.com>
Cc:     qxy <qxy65535@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net,
        Android Kernel Team <kernel-team@android.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 3:17 PM Alessio Balsini <balsini@android.com> wrote:
>
> Hi all,
>
> I'm more than happy to change the interface into something that is
> objectively better and accepted by everyone.
> I would really love to reach the point at which we have a "stable-ish"
> UAPI as soon as possible.

It's in the mainline kernel, so you already have a stable uapi and
cannot change that in any incompatible way!

> I've been thinking about a few possible approaches to fix the issue, yet
> to preserve its flexibility. These are mentioned below.
>
>
>   Solution 1: Size
>
> As mentioned in my previous email, one solution could be to introduce
> the "size" field to allow the structure to grow in the future.
>
> struct fuse_passthrough_out {
>     uint32_t        size;   // Size of this data structure
>     uint32_t        fd;
> };
>
> The problem here is that we are making the promise that all the upcoming
> fields are going to be maintained forever and at the offsets they were
> originally defined.
>
>
>   Solution 2: Version
>
> Another solution could be to s/size/version, where for every version of
> FUSE passthrough we reserve the right to modifying the fields over time,
> casting them to the right data structure according to the version.


Please read Documentation/driver-api/ioctl.rst for how to design
ioctls. Neither 'size' nor 'version' fields are appropriate here. If you
have a new behavior, you need a new command code.

      Arnd
