Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2689644CF1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 02:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhKKBoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 20:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhKKBoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:44:00 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3724C061766
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 17:41:12 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id b125so2420106vkb.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 17:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9ODKl1loCO7B0LW/VsHM9DMQhs7CgP/8R1pMI7+CYE=;
        b=WeKBgCxA7q5n70VDdPZ6971JrfIPL+AbzsW3e+kmC85GIiOHUkw02QRzceGqj4v15d
         /PbGvPyQkg8NZar+avLqtYan0ugTsXliIhUGS5vzaQwYEW7u9F3HtE8MROYna4Fx76Dt
         Od3RPjdEZ6rTtNwlrMs4vHqmaZmDkefueL1Zbqq+CU8aEn4NCHA1UKvTpEa0zIKGalor
         skN+GNhDyo8b0dX71lJSXa/E8Q/4oZNNHYZql0GoRQ8Yj7ygW+fx0lUOkb8Sw+KrAc/O
         o9MEdfgzFzhZxyi/P8QQvrtSRb75KbGxOcLD1AiBRPjPOFBT2rgUTLNo3T+xVy7ixsDe
         u2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9ODKl1loCO7B0LW/VsHM9DMQhs7CgP/8R1pMI7+CYE=;
        b=h2c5ohM6NgsXJoRczubMe6mO3NZ5Oz2HXAeWVduyZzAGQPVfj+I5mNqal0BiVG7bdc
         w2a/ODqmlfqT7sNymjLJ/sQfEkwgK7b7OL5Z32S1R80ZhE9LMS12y/DyzltYfSqqBxH+
         f0yRQqi9XU/owq4mQlRXUHs7yqr+l0iuc546zE/YPuJ59s6957VPa4timNDGZDCKXwRR
         5Ppy/AmluUQOj2lTk9dpC5AqJtwxALzZXD4NFFbIow1Slt9k5qXKj32fdgyfAtLAC3jF
         Mkfwe8jT2xsoUAloBL7twNyiOY4C/P8s7xHhGyNT6iyoof3rGuSnJAKwLkyo8Ldctqmt
         njOA==
X-Gm-Message-State: AOAM531P9/yeJTCFO5cyDLLXk/w0+liSmKHWmk63GgBymc94oyCBCT7p
        qI3t2L1vilEcqHBr42Xyeai6x0jIPdU2cPweO3I=
X-Google-Smtp-Source: ABdhPJzXCP49h8pFfUypn5ySr4bg5bqEV9UD6leWEaArBYA+wQqfQsuhOLgKkZ2dlI67qr/oDKHhuJI+x2msWIHgmhY=
X-Received: by 2002:a1f:5685:: with SMTP id k127mr5638502vkb.7.1636594871823;
 Wed, 10 Nov 2021 17:41:11 -0800 (PST)
MIME-Version: 1.0
References: <20211103011527.42711-1-flyingpeng@tencent.com>
 <CAJfpeguWtPFG_daMNA7=T-kQmgkcTPugMj7HWhh2mu+cwRWbxw@mail.gmail.com>
 <CAPm50a+pu0hB0WwjSkaz+F=BJEhD5mEjFfe019cZ7AGdO0t2Ow@mail.gmail.com> <CAJfpegusBqc7AsJK3+bT6Mp08UB3UN-oBn5K1yuzpgAC237DXg@mail.gmail.com>
In-Reply-To: <CAJfpegusBqc7AsJK3+bT6Mp08UB3UN-oBn5K1yuzpgAC237DXg@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Thu, 11 Nov 2021 09:40:36 +0800
Message-ID: <CAPm50aJ8dA-08JdM_gwP9_bNz6iYfuK6aiih_KkgcbPKeXAuXg@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix possible write position calculation error
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 6:40 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Fri, 5 Nov 2021 at 08:44, Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > On Thu, Nov 4, 2021 at 8:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, 3 Nov 2021 at 02:15, Peng Hao <flyingpenghao@gmail.com> wrote:
> > > >
> > > > The 'written' that generic_file_direct_write return through
> > > > filemap_write_and_wait_range is not necessarily sequential,
> > > > and its iocb->ki_pos has not been updated.
> > >
> > > I don't see the bug, but maybe I'm missing something.  Can you please
> > > explain in detail?
> > >
> > I think we shouldn't add "written" to variable pos.
> > generic_file_direct_write:
> >                 ....
> >                 written = filemap_write_and_wait_range(mapping, pos,
> >                                                         pos + write_len - 1);
> >                 if (written)  //the number of writes here reflects the
> > amount of writeback data
>
> No.  It's actually an error code in this case.
>
> It is confusing, though, so I guess cleaning this up (e.g. rename
> "written" to "retval") would make sense.
>
oh,sorry.
I misunderstood. I should deeply analyze the function called below.
> Thanks,
> Miklos
