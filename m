Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0F432C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhJSDmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 23:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhJSDmC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 23:42:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF45C06161C;
        Mon, 18 Oct 2021 20:39:50 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b188so13869928iof.8;
        Mon, 18 Oct 2021 20:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6lDICXPanQEczqPf1bcFgv6zFUKLXclwZT3Vx8an2c=;
        b=FMbqaiTr5PEeUP75Jb/aP4hyS7MEL/x+jux2gmx6RlE5rZ137vcbkE6G4dglSyX7Or
         2Ld2QAK4iBk8ygsowwZ9vBNBin7fVmHNsN9J9SVvQA7Rk4NcLjfLJ4zzUx3Ks3vtsiQS
         yLthCRU2DkR1Oe4RDnFrc5JkgU/wNxmA53sq2HTbil7N6g0NSVOqA8hdo5MxqDkjhWJG
         Ol7Aqirb0ATLZF+WuBu9JcsNiSk7Vbz468S5J8q37lKK2tF06bpWrZl81OVgevJkGHzk
         1IiVmrasxxAKWyMlY/ZYncPWfw2O8h/K1daXQ26p335GGkcsTzeemlFWyn4htDL5GG/z
         As/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6lDICXPanQEczqPf1bcFgv6zFUKLXclwZT3Vx8an2c=;
        b=O37DIE/5zHwXCmPG2++ya4YpSt8e015m7kbeC+e1tNXRBF7y9EXYX3Zms00OQgkI8t
         sG8/oPB+kxLjtaufpwalOJAHWRnOo6v1lhO1McYOCt4+gvSmSBnVPRdt1pejubXvGAYJ
         tjx368VIdXuxofUk2dJJcQXctT/c5Ct5uhQlrIdr3+FyapyTsN36MbAYBImyq39OQRqL
         izEGt0gSa2hQsFuMxr/DeR+Sxc+VsNMhRt6exOyBu/YNQVg6XLSMEQkUvzCJdPle9xKZ
         V5+H/VmhWJMpwXesi6HBgo2HARJ7ZntVFEFnPcJYQqh64t6U+5RYwrHhujncuM8Qya4O
         KJcQ==
X-Gm-Message-State: AOAM533EJL//cEvfCEqrbJNSdjNPbrXdQQOXSd1eZrIsB8UFCvhxvE5T
        sBvgJUtQslbPRaaPb+1UDzrn1tY14o67OG+fBok=
X-Google-Smtp-Source: ABdhPJz4nuA7PmwfuBJ5tsyh2CNf4H3pm0RviWHWzHavFd+QgNNxCpNXGjvnjLX2bXNayB6lkBKOMknS//U/nml9C+c=
X-Received: by 2002:a05:6602:2dd2:: with SMTP id l18mr17560574iow.86.1634614789863;
 Mon, 18 Oct 2021 20:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <CAOOPZo4ZycbV8W2w48oD+bM8a1+WqejSjjYuheZPyxm2uE-=rA@mail.gmail.com> <20211018114349.b80a27af9bfa7f16162b0ec4@linux-foundation.org>
In-Reply-To: <20211018114349.b80a27af9bfa7f16162b0ec4@linux-foundation.org>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Tue, 19 Oct 2021 11:39:38 +0800
Message-ID: <CAOOPZo4HtGB5MYETpj_q++m+PvomNqasNdaPa65gp2hsQ5H67A@mail.gmail.com>
Subject: Re: Problem with direct IO
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        mysql@lists.mysql.com, linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 2:43 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 18 Oct 2021 09:09:06 +0800 Zhengyuan Liu <liuzhengyuang521@gmail.com> wrote:
>
> > Ping.
> >
> > I think this problem is serious and someone may  also encounter it in
> > the future.
> >
> >
> > On Wed, Oct 13, 2021 at 9:46 AM Zhengyuan Liu
> > <liuzhengyuang521@gmail.com> wrote:
> > >
> > > Hi, all
> > >
> > > we are encounting following Mysql crash problem while importing tables :
> > >
> > >     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
> > >     fsync() returned EIO, aborting.
> > >     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
> > >     Assertion failure: ut0ut.cc:555 thread 281472996733168
> > >
> > > At the same time , we found dmesg had following message:
> > >
> > >     [ 4328.838972] Page cache invalidation failure on direct I/O.
> > >     Possible data corruption due to collision with buffered I/O!
> > >     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
> > >     625 Comm: kworker/42:1
> > >
> > > Firstly, we doubled Mysql has operating the file with direct IO and
> > > buffered IO interlaced, but after some checking we found it did only
> > > do direct IO using aio. The problem is exactly from direct-io
> > > interface (__generic_file_write_iter) itself.
> > >
> > > ssize_t __generic_file_write_iter()
> > > {
> > > ...
> > >         if (iocb->ki_flags & IOCB_DIRECT) {
> > >                 loff_t pos, endbyte;
> > >
> > >                 written = generic_file_direct_write(iocb, from);
> > >                 /*
> > >                  * If the write stopped short of completing, fall back to
> > >                  * buffered writes.  Some filesystems do this for writes to
> > >                  * holes, for example.  For DAX files, a buffered write will
> > >                  * not succeed (even if it did, DAX does not handle dirty
> > >                  * page-cache pages correctly).
> > >                  */
> > >                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inode))
> > >                         goto out;
> > >
> > >                 status = generic_perform_write(file, from, pos = iocb->ki_pos);
> > > ...
> > > }
> > >
> > > From above code snippet we can see that direct io could fall back to
> > > buffered IO under certain conditions, so even Mysql only did direct IO
> > > it could interleave with buffered IO when fall back occurred. I have
> > > no idea why FS(ext3) failed the direct IO currently, but it is strange
> > > __generic_file_write_iter make direct IO fall back to buffered IO, it
> > > seems  breaking the semantics of direct IO.
>
> That makes sense.
>
> > > The reproduced  environment is:
> > > Platform:  Kunpeng 920 (arm64)
> > > Kernel: V5.15-rc
> > > PAGESIZE: 64K
> > > Mysql:  V8.0
> > > Innodb_page_size: default(16K)
>
> This is all fairly mature code, I think.  Do you know if earlier
> kernels were OK, and if so which versions?

we have tested v4.18 and v4.19 and the problem is still here,  the earlier
version such before v4.12 doesn't support Arm64 well  so we can't test.

I think this problem has something to do with page size,  if we change kernel
page size from 64K to 4k or just set Innodb_page_size to 64K then we cannot
reproduce this problem.  Typically we use 4k as kernel page size and FS block
size, if database use more than 4k as IO unit then it won't interleave for each
IO in kernel page cache as each one will occupy one or more page cache, that
means it is hard to trigger this problem on x84 or other platforms using 4k page
size.  But thing got changed when come to Arm64 64K page size, if database uses
a smaller IO unit, in our Mysql case that is 16K DIO, then two IO
could share one
page cache and if one falls back to buffered IO it can trigger the problem. For
example,  aio got two direct IO which share the same page cache to write , it
dispatched the first one to storage and begin process the second one before
the first one completed, if the second one fall back to buffered IO it will been
copy to page cache and mark the page as dirty, upon that the first one completed
it will check and invalidate it's page cache, if it is dirty then the
problem occured.

If my analysis isn't correct please point it out, thanks.
