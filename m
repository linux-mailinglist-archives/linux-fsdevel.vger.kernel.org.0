Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB37AFCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfG3R0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 13:26:35 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33087 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfG3R0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:26:35 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so11099224iog.0;
        Tue, 30 Jul 2019 10:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsLPrLOcclqm31GATo5KG4DgL5WcwoSIYZV9oMmibkM=;
        b=LUamGemkbRqnOVHbq7CXnlGi/lEYqOEEySiKtSrwXqEp6shA4gxXuseHjOaOiH3aa7
         q4CF5Eum/dqTa4wC00EDfSR4wSTPClq6Y3O6fnjnuTa8UISAGRv24/2prGpJP4yj+/5K
         pp6QgCoaOkGX8YfVQJvI0ldkf7g5Qtz5YPjBIm1MafS1QJbnmne2KPhWiFiOFjpLhpua
         9zkTIHWrBNLvn7Si20xo61CMzJCVm2tyy8IPzybo7iqfWECXz7HiHXR7qDV7Zs/ri977
         AjNYEbpGf5FVBSgWnRjBEI6oRswJ4WN7oBSH2Oh+cBt5ZquUgXtZtN3ILEA184MLtXtW
         bQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsLPrLOcclqm31GATo5KG4DgL5WcwoSIYZV9oMmibkM=;
        b=NG2H9GcQ68UYhIqA3DHz1MQLHBYaQ6WlL5Ny3/8lQ+dUWqFqL+0L6+rDa36qxFvQWo
         qMlymEW3nT8NX9di+UldcC6QvPOwEoBDK8G71ADLWoOhkQLLVLOJ0MzNvcgU+im+3N9l
         0BD0DOaj7nSX8SKV5YisV6gKrqQzYYU00M93mWK33/quxMoauh+PjgBn9HTVH4lTo48Z
         Ut5k9KXyRWhmkxbRKPwQuIlZ6I4FdJpAg1A8AHgAFMgu3nf4fo9dUgNCg8f3ZorlsVrK
         laySDgwqOElPQ8R4gIQL8jTinjNKE4LwOu8VL/rhqOLHGs/VwpUNogcvtGwYrYKg2H16
         Nwqw==
X-Gm-Message-State: APjAAAXXMf4nUgxDA8dmzb1URvoerk/7LBTv3dn0IeKspqQXe4i/dWfu
        5Cno/1ccIv/b3fNd+TbqTWxsv/rX8e9g11HV/j8=
X-Google-Smtp-Source: APXvYqy+9zDOTHm2OHuBLA2soclNQ3YwB8p18dgCUYzErzvrXdSDbEEW8GCwNV3FQCvXOrwwAN9MF+uqzNXPUM4I49E=
X-Received: by 2002:a5e:8210:: with SMTP id l16mr81558885iom.240.1564507594217;
 Tue, 30 Jul 2019 10:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190730014924.2193-1-deepa.kernel@gmail.com> <20190730014924.2193-4-deepa.kernel@gmail.com>
 <87d0hsapwr.fsf@mail.parknet.co.jp>
In-Reply-To: <87d0hsapwr.fsf@mail.parknet.co.jp>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 30 Jul 2019 10:26:22 -0700
Message-ID: <CABeXuvqgaxDSR8N_D1Tdw06g_5PGinZS--6nx-bPtAWP4v+mwg@mail.gmail.com>
Subject: Re: [PATCH 03/20] timestamp_truncate: Replace users of timespec64_trunc
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, anton@tuxera.com,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        stoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Richard Weinberger <richard@nod.at>, Tejun Heo <tj@kernel.org>,
        yuchao0@huawei.com,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-mtd <linux-mtd@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 1:27 AM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> Deepa Dinamani <deepa.kernel@gmail.com> writes:
>
> > diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> > index 1e08bd54c5fb..53bb7c6bf993 100644
> > --- a/fs/fat/misc.c
> > +++ b/fs/fat/misc.c
> > @@ -307,8 +307,9 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
> >               inode->i_atime = (struct timespec64){ seconds, 0 };
> >       }
> >       if (flags & S_CTIME) {
> > -             if (sbi->options.isvfat)
> > -                     inode->i_ctime = timespec64_trunc(*now, 10000000);
> > +             if (sbi->options.isvfat) {
> > +                     inode->i_ctime = timestamp_truncate(*now, inode);
> > +             }
> >               else
> >                       inode->i_ctime = fat_timespec64_trunc_2secs(*now);
> >       }
>
> Looks like broken. It changed to sb->s_time_gran from 10000000, and
> changed coding style.

This is using a new api: timestamp_truncate(). granularity is gotten
by inode->sb->s_time_gran. See Patch [2/20]:
https://lkml.org/lkml/2019/7/29/1853

So this is not broken if fat is filling in the right granularity in the sb.

-Deepa
