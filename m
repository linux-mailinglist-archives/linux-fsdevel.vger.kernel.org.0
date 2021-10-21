Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6980435895
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhJUCYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 22:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbhJUCYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 22:24:22 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9DCC06161C;
        Wed, 20 Oct 2021 19:22:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y67so27046804iof.10;
        Wed, 20 Oct 2021 19:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WoTi8ousAru3u0x0PqEa5h1DYc5xyn/i9aNhj594NLQ=;
        b=mko1nnW1L4r6x8ovrfGJ8Vdqyy3gMW9Y2Uifz5qYgK1j7sAOD/Gr368bSaNruSQpgG
         QdzA7NYFPgL74ysqR2aEWuctR1mC6Hx90V1GdSJIy8jWgYm86DuUmi4GD1VJReM4Un+S
         1/0QzJFhnz3oOJtW+rrIsw1w5Py469OZJuD7aRVnNf0yFYg5i8m+xDZRIEa4x1LxTcQu
         Z4cfN49q1mzBOYsGOe5te55GfeFkB5AHDPBiqn8KiYbAklZi3ID7wTjYqEwSQ8kMwgRI
         yqcHnE9+i0qRl3R0M8ANV2z7N27AimcGjhv8iCFD8FleAuwkD9yEOlV1YnNNTGi9Mb+Z
         QwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WoTi8ousAru3u0x0PqEa5h1DYc5xyn/i9aNhj594NLQ=;
        b=ETkR2qEpwGWcU+HXQL3ckS3dC0XpPaYd+wmiYFMtk4jATyv5R0qK7AA+jwZv+uDSib
         /ldc7F89dcWBIqN2GL6YuM2amF8WbX4KcWoX9+2BjWsCTTwdlWONEPVF2qxHKdcE5xpS
         BBVGODU+D6LfRXvSvPfabAKBe7g1CtR7DrwdkHvYL+rmdgTi+/NwINO0LYcNsx/LtiPc
         Wu+VWKditkb7ypDTapq9YHlOeSGoAQq1cPdI/zgXYkdrbjRmRflF6EuBjXrnzA2HSTHt
         fIHjOFnxIBukzaGDYKoZxK57ObyRryGhZ8Weks2aBO4uKFleOELFvqaIFCgHPqdmRaci
         QTCA==
X-Gm-Message-State: AOAM5300gXvuFYMg1/1QcRJPJ1R3ekHaWV1Gd0aK1GXuq3PBZtHqbvVg
        hczbFjr4sVG+f4oRLFKikZMGFbyelRB7dDEpsK3YqSN7dxTxRA==
X-Google-Smtp-Source: ABdhPJyQLft+phhyBF9CudOwsTpzEFxOcJktVFW5DovKAmrYGrQGzGN/FUzB39UwIqIwczFgH6/yTAVqDfmW4Dex8SE=
X-Received: by 2002:a6b:7302:: with SMTP id e2mr2037346ioh.41.1634782927264;
 Wed, 20 Oct 2021 19:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOOPZo52azGXN-BzWamA38Gu=EkqZScLufM1VEgDuosPoH6TWA@mail.gmail.com>
 <20211020173729.GF16460@quack2.suse.cz>
In-Reply-To: <20211020173729.GF16460@quack2.suse.cz>
From:   Zhengyuan Liu <liuzhengyuang521@gmail.com>
Date:   Thu, 21 Oct 2021 10:21:55 +0800
Message-ID: <CAOOPZo43cwh5ujm3n-r9Bih=7gS7Oav0B=J_8AepWDgdeBRkYA@mail.gmail.com>
Subject: Re: Problem with direct IO
To:     Jan Kara <jack@suse.cz>
Cc:     viro@zeniv.linux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        tytso@mit.edu, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-ext4@vger.kernel.org,
        =?UTF-8?B?5YiY5LqR?= <liuyun01@kylinos.cn>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 1:37 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-10-21 09:46:46, Zhengyuan Liu wrote:
> > Hi, all
> >
> > we are encounting following Mysql crash problem while importing tables =
:
> >
> >     2021-09-26T11:22:17.825250Z 0 [ERROR] [MY-013622] [InnoDB] [FATAL]
> >     fsync() returned EIO, aborting.
> >     2021-09-26T11:22:17.825315Z 0 [ERROR] [MY-013183] [InnoDB]
> >     Assertion failure: ut0ut.cc:555 thread 281472996733168
> >
> > At the same time , we found dmesg had following message:
> >
> >     [ 4328.838972] Page cache invalidation failure on direct I/O.
> >     Possible data corruption due to collision with buffered I/O!
> >     [ 4328.850234] File: /data/mysql/data/sysbench/sbtest53.ibd PID:
> >     625 Comm: kworker/42:1
> >
> > Firstly, we doubled Mysql has operating the file with direct IO and
> > buffered IO interlaced, but after some checking we found it did only
> > do direct IO using aio. The problem is exactly from direct-io
> > interface (__generic_file_write_iter) itself.
> >
> > ssize_t __generic_file_write_iter()
> > {
> > ...
> >         if (iocb->ki_flags & IOCB_DIRECT) {
> >                 loff_t pos, endbyte;
> >
> >                 written =3D generic_file_direct_write(iocb, from);
> >                 /*
> >                  * If the write stopped short of completing, fall back =
to
> >                  * buffered writes.  Some filesystems do this for write=
s to
> >                  * holes, for example.  For DAX files, a buffered write=
 will
> >                  * not succeed (even if it did, DAX does not handle dir=
ty
> >                  * page-cache pages correctly).
> >                  */
> >                 if (written < 0 || !iov_iter_count(from) || IS_DAX(inod=
e))
> >                         goto out;
> >
> >                 status =3D generic_perform_write(file, from, pos =3D io=
cb->ki_pos);
> > ...
> > }
> >
> > From above code snippet we can see that direct io could fall back to
> > buffered IO under certain conditions, so even Mysql only did direct IO
> > it could interleave with buffered IO when fall back occurred. I have
> > no idea why FS(ext3) failed the direct IO currently, but it is strange
> > __generic_file_write_iter make direct IO fall back to buffered IO, it
> > seems  breaking the semantics of direct IO.
> >
> > The reproduced  environment is:
> > Platform:  Kunpeng 920 (arm64)
> > Kernel: V5.15-rc
> > PAGESIZE: 64K
> > Mysql:  V8.0
> > Innodb_page_size: default(16K)
>
> Thanks for report. I agree this should not happen. How hard is this to
> reproduce? Any idea whether the fallback to buffered IO happens because
> iomap_dio_rw() returns -ENOTBLK or because it returns short write?

It is easy to reproduce in my test environment, as I said in the previous e=
mail
replied to Andrew this problem is related to kernel page size.

> Can you post output of "dumpe2fs -h <device>" for the filesystem where th=
e
> problem happens? Thanks!

Sure, the output is:

# dumpe2fs -h /dev/sda3
dumpe2fs 1.45.3 (14-Jul-2019)
Filesystem volume name:   <none>
Last mounted on:          /data
Filesystem UUID:          09a51146-b325-48bb-be63-c9df539a90a1
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index
filetype needs_recovery sparse_super large_file
Filesystem flags:         unsigned_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              11034624
Block count:              44138240
Reserved block count:     2206912
Free blocks:              43168100
Free inodes:              11034613
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      1013
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
Filesystem created:       Thu Oct 21 09:42:03 2021
Last mount time:          Thu Oct 21 09:43:36 2021
Last write time:          Thu Oct 21 09:43:36 2021
Mount count:              1
Maximum mount count:      -1
Last checked:             Thu Oct 21 09:42:03 2021
Check interval:           0 (<none>)
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:           256
Required extra isize:     32
Desired extra isize:      32
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      a7b04e61-1209-496d-ab9d-a51009b51ddb
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Journal size:             1024M
Journal length:           262144
Journal sequence:         0x00000002
Journal start:            1

BTW=EF=BC=8C we have  also tested Ext4 and XFS and didn't see direct write =
fallback.

Thanks,
