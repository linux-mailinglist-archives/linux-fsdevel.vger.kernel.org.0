Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7892F89C7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Jan 2021 01:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbhAPAIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 19:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbhAPAIl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:08:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A708B23A9D
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Jan 2021 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610755681;
        bh=+2AMcX5I9sdDNTAf5qRgriFiAplt2ZW+PvqTt0Q1cUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uYH1XhjPX4cvFTvubDMmAXsVAN4E3GXzd6Kga4Ts0FRuFGosoKl4CjmCC4xQp4djp
         1WWGmoTf9S89yyGe/XUfwreRjM+epyHkkxFcfBjNzkMGhRMDMT5OjFOUg8+dClXbwc
         wUoxAlOvWznbvdfqNMZNNzuFEIvbJA2fbh/QFJ9KEmvSAHGOA5gT6yTpuanqjfQXWk
         YcddFhEjVXQBNe6nCygAzCeJoyczQfz8GamYzUlKxyq5S8LBlpoWWCetFeRxdedPMl
         yq5GUlmIUwwyIJ/qv1Trcmvg2SOzKUgb8LEa+GI+YGMtMWX0fEvh1zCBR3xXm2RXt/
         WkyDPSrqsETEg==
Received: by mail-lf1-f48.google.com with SMTP id b26so15725578lff.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Jan 2021 16:08:00 -0800 (PST)
X-Gm-Message-State: AOAM530QIlLB7fx6WMIFRpYz4SrUfHSwL8PMVToXucvLD7YC6MhZI/HM
        NWTPAUJGWXZ/X9gy7/3cS3jJXb2CyuE0eQiHUNvAag==
X-Google-Smtp-Source: ABdhPJwA0R2ivqxfLZj25fjGEkl6YCppBiN4+N4FJIG/Q6L6/jH79qY/NR2oZiGDsSgT9/JyW8mJ9D5qzsk1TFAAdjk=
X-Received: by 2002:a05:6402:a5b:: with SMTP id bt27mr11884235edb.222.1610755677728;
 Fri, 15 Jan 2021 16:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20210106064807.253112-1-Sonicadvance1@gmail.com>
 <CAK8P3a2tV3HzPpbCR7mAeutx38_D2d-vfpEgpXv+GW_98w3VSQ@mail.gmail.com>
 <CABnRqDfQ5Qfa2ybut0qXcKuYnsMcG7+9gqjL-e7nZF1bkvhPRw@mail.gmail.com> <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
In-Reply-To: <CAK8P3a2vfVfEWTk1ig349LGqt8bkK8YQWjE6PRyx+xvgYx7-gA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 15 Jan 2021 16:07:46 -0800
X-Gmail-Original-Message-ID: <CALCETrUtyVaGSE9fcFAkhrGCpkyYcYnZb6tj8227o2EH5hgOfg@mail.gmail.com>
Message-ID: <CALCETrUtyVaGSE9fcFAkhrGCpkyYcYnZb6tj8227o2EH5hgOfg@mail.gmail.com>
Subject: Re: [PATCH] Adds a new ioctl32 syscall for backwards compatibility layers
To:     Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Ryan Houdek <sonicadvance1@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Amanieu d'Antras" <amanieu@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>, Jan Kara <jack@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 1:03 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Jan 15, 2021 at 3:06 AM Ryan Houdek <sonicadvance1@gmail.com> wrote:
> > On Wed, Jan 6, 2021 at 12:49 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >> On Wed, Jan 6, 2021 at 7:48 AM <sonicadvance1@gmail.com> wrote:
> >> > From: Ryan Houdek <Sonicadvance1@gmail.com>
> >> ...
> >>
> >> For x86, this has another complication, as some ioctls also need to
> >> check whether they are in an ia32 task (with packed u64 and 32-bit
> >> __kernel_old_time_t) or an x32 task (with aligned u64 and 64-bit
> >> __kernel_old_time_t). If the new syscall gets wired up on x86 as well,
> >> you'd need to decide which of the two behaviors you want.
> >
> >
> > I can have a follow-up patch that makes this do ni-syscall on x86_64 since
> > we can go through the int 0x80 handler, or x32 handler path and choose
> > whichever one there.
>
> I'd say for consistency
>

We need to make it crystal clear on x86 what this ioctl does.  We have
a silly selection of options:

 - ioctl32() via SYSCALL, x32 bit clear -- presumably does an i386 ioctl?
 - ioctl32() via SYSCALL, x32 bit set -- this needs to do something
clearly documented.
 - ioctl32() via int80 -- presumably you're not wiring this up

In any case, the compat alloc thing should just go away.  It's a hack
and serves no real purpose.

Finally, I'm not convinced that this patch works correctly.  We have
in_compat_syscall(), and code that uses it may well be reachable from
ioctl.  I personally would like to see in_compat_syscall() go away,
but some other people (Hi, Christoph!) disagree, and usage seems to be
increasing, not decreasing.
