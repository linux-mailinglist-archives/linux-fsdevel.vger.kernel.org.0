Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2233DCF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 19:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhCPSx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 14:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240200AbhCPSxY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D0856514B;
        Tue, 16 Mar 2021 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615920803;
        bh=SdgPXfd1GX0HxBpnuqAYxYxIA045/B5izyywjEHSB2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oQQg9sAJMRzTz/mGOagHrIUD2U+4+dxDyV0stlTFPVZ80RKnA9wo0nRo3Ny1i51RP
         QDbpQjA+VIC1dshlU4TbV2j79GqWGc7OaQasxwizX844yHrJ2QIUYgZqxouNFTkHTg
         cR+YtKMvCfcJ1BKxZIGysOuWZfIo6Cna5Mr3NbHMSrXgD4xNDf2V+DdS8WUodh1LuP
         4ueef99fiueVcFJzmH4BwV3ASixsQwE43K8HMRO2MWJoZ7RVe7hJgxg2fG0AbNU3ou
         3wNAMAGwah7FmqdP8zzDQmB3rtHplYjXCFziVhODWnY4GF8z3XOSkcPLqpwFVoY0GD
         hFwsiAUOPCsyQ==
Received: by mail-oo1-f42.google.com with SMTP id n12-20020a4ad12c0000b02901b63e7bc1b4so4406565oor.5;
        Tue, 16 Mar 2021 11:53:23 -0700 (PDT)
X-Gm-Message-State: AOAM533O3ojaF195i8dK8TPCURqtQXn7wzvAUSl8diSAPF+Kars+e++c
        jkPbJqJlvZ5DkHtL4jtRYV51Ty9u6uTPWRpKu8M=
X-Google-Smtp-Source: ABdhPJzn0i4w3u0huXHq7pnjViu24Wv1YVxCUfI1amFd+69q4KthvnTtLggH8Vm3k4PUwrTQY3HpO0X6NmVh7Tt27Ow=
X-Received: by 2002:a4a:8ed2:: with SMTP id c18mr197825ool.66.1615920802789;
 Tue, 16 Mar 2021 11:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-3-balsini@android.com>
In-Reply-To: <20210125153057.3623715-3-balsini@android.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Mar 2021 19:53:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2VDH9-reuj8QTkFzbaU9XTUEOWFCmCVg1Snb6RjD6mHw@mail.gmail.com>
Message-ID: <CAK8P3a2VDH9-reuj8QTkFzbaU9XTUEOWFCmCVg1Snb6RjD6mHw@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 2/8] fuse: 32-bit user space ioctl compat for
 fuse device
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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

On Mon, Jan 25, 2021 at 4:48 PM Alessio Balsini <balsini@android.com> wrote:
>
> With a 64-bit kernel build the FUSE device cannot handle ioctl requests
> coming from 32-bit user space.
> This is due to the ioctl command translation that generates different
> command identifiers that thus cannot be used for direct comparisons
> without proper manipulation.
>
> Explicitly extract type and number from the ioctl command to enable
> 32-bit user space compatibility on 64-bit kernel builds.
>
> Signed-off-by: Alessio Balsini <balsini@android.com>

I saw this commit go into the mainline kernel, and I'm worried that this
doesn't do what the description says. Since the argument is a 'uint32_t',
it is the same on both 32-bit and 64-bit user space, and the patch won't
make any difference for compat mode, as long as that is using the normal
uapi headers.

If there is any user space that has a different definition of
FUSE_DEV_IOC_CLONE, that may now successfully call
this ioctl command, but the kernel will now also accept any other
command code that has the same type and number, but an
arbitrary direction or size argument.

I think this should be changed back to specifically allow the
command code(s) that are actually used and nothing else.

       Arnd
