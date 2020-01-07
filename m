Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DDD132006
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 07:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgAGGyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 01:54:35 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37315 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 01:54:35 -0500
Received: by mail-il1-f193.google.com with SMTP id t8so44867543iln.4;
        Mon, 06 Jan 2020 22:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SCicnEjkyGwhQ2AgjvMF6X8DeQvHHm5K6F+M+EsiSo=;
        b=VauDvkWvynYu3g7Fs6x0yQotweycU1WnoCLtCr61aTA7fmLaQ0tMBm6lm6lyPzBJEr
         pKm512nt7Bn8iunBUOhvg9mNL6dKI6YrstUHevxFGjMryXMnXtSbr8Jgm6iS7SnukDHU
         X1k+q7mDT2d3DVYzK4G9PketVqxnQhZwo6SuLu79XVoTHYLdRk0dWdK0IJTiPnPQsVDd
         bDbg7zu4/Fyl6TEO8J+AYb8uG5qccIWPQKU/w1+L4i6KKAK66Ezni4xpN0AHyGdRi/CV
         fUiT7h4O8D1pwRdHlHTi/vXzZ85O7uZsFLkM/M8/n/fUOUCeo9BWWObsBNrhQoaJy1ET
         ZzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SCicnEjkyGwhQ2AgjvMF6X8DeQvHHm5K6F+M+EsiSo=;
        b=UEQ9Wfvs25QKSW//NZPV2V8R64+UF8aTbs4WuJ/9dBB3iGwe5ZpkEjsUZYQTn2bQXC
         a4WZKEJRQuKfGdKgXng9fXqvK+9mHAnuGo1Yid1nOWbRit3SoKHc2QV1iE0GD7pImgbm
         zm4UFSg3qPG+GkUICZuTNh9xcwPP6RuW4Pw/BtfDl2jM3hRM+o/KQgoj2rL9RKmqyKMY
         0bINFwVwnXTZFXvThIwkY6E4mMnwlwMBJIoa7ntqEX+LxFENqK28ZykMI38XrAFvZPx2
         W7c3QOS7/cYjpNQYb7vU13YXqQbJklSFMzA1PfawWOENvTqH5Qf+djD9zO4dlNK3XLwA
         a+oQ==
X-Gm-Message-State: APjAAAWGN81S9GX1AjI0CsaCxgWk0Sh5kjKkKJ31dOmAM5GRoPmNjr3W
        nsP5y4NyxqP5+huipLyRjFrA8aYjgC/CYHydpRQ=
X-Google-Smtp-Source: APXvYqxCG63+ToFv7QxbgGA8nekvOLEB3uq0vA184/pCTkC0mQiIYHbo0bQs0D1l/B5uwGv5o8P/yTE1tHYkViMPURA=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr94426988ilh.9.1578380074721;
 Mon, 06 Jan 2020 22:54:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578225806.git.chris@chrisdown.name> <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area> <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
In-Reply-To: <20200107003944.GN23195@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 08:54:23 +0200
Message-ID: <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
To:     Dave Chinner <david@fromorbit.com>
Cc:     Chris Down <chris@chrisdown.name>, Linux MM <linux-mm@kvack.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 7, 2020 at 2:40 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Jan 07, 2020 at 12:16:43AM +0000, Chris Down wrote:
> > Dave Chinner writes:
> > > It took 15 years for us to be able to essentially deprecate
> > > inode32 (inode64 is the default behaviour), and we were very happy
> > > to get that albatross off our necks.  In reality, almost everything
> > > out there in the world handles 64 bit inodes correctly
> > > including 32 bit machines and 32bit binaries on 64 bit machines.
> > > And, IMNSHO, there no excuse these days for 32 bit binaries that
> > > don't using the *64() syscall variants directly and hence support
> > > 64 bit inodes correctlyi out of the box on all platforms.
> > >
> > > I don't think we should be repeating past mistakes by trying to
> > > cater for broken 32 bit applications on 64 bit machines in this day
> > > and age.
> >
> > I'm very glad to hear that. I strongly support moving to 64-bit inums in all
> > cases if there is precedent that it's not a compatibility issue, but from
> > the comments on my original[0] patch (especially that they strayed from the
> > original patches' change to use ino_t directly into slab reuse), I'd been
> > given the impression that it was known to be one.
> >
> > From my perspective I have no evidence that inode32 is needed other than the
> > comment from Jeff above get_next_ino. If that turns out not to be a problem,
> > I am more than happy to just wholesale migrate 64-bit inodes per-sb in
> > tmpfs.
>
> Well, that's my comment above about 32 bit apps using non-LFS
> compliant interfaces in this day and age. It's essentially a legacy
> interface these days, and anyone trying to access a modern linux
> filesystem (btrfs, XFS, ext4, etc) ion 64 bit systems need to handle
> 64 bit inodes because they all can create >32bit inode numbers
> in their default configurations.
>

Chris,

Following Dave's comment, let's keep the config option, but make it
default to Y and remove the mount option for now.
If somebody shouts, mount option could be re-added later.
This way at least we leave an option for workaround for an unlikely
breakage.

Thanks,
Amir.
