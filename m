Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED667AC6D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjIXGqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 02:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 02:46:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02EE107
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 23:46:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-414b0bdea1cso29877211cf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Sep 2023 23:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695537975; x=1696142775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw83IUfQOP3EPzhuJykvexUS/eQ7Pw6APXqp0soyYmc=;
        b=VWYntA/4Gff6TJKqFRRqq74mG4WLJREhB48pmMmy/dhOuww1oAeG3QnmgeuVZsQzdO
         IliSD/7nAjCqfMw33DQ3hzn7AGc1wRG5InxVGAuVWzr8m6qsawv2Q82tNmZFkEHu33mF
         FS/HR8E0a+W8Hk5uOIPbWQV0fhDZn5/vVAWnf/a2XoMR49UdR2gr5dtfV06FQwaccKH2
         SNBiuIJ+ii7HT6B4eEGRysqm6GnRJCPNapc/ZfxQ47pQDu0z8YoPlqY+6UgrGYZM+ZgF
         h3AhCnYVitnIEDNgGX5+zkJJLwTb64APDx7ViBjb4BDeDJB7GF7Wi2hAXHbbkJ7DvhzE
         R8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695537975; x=1696142775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sw83IUfQOP3EPzhuJykvexUS/eQ7Pw6APXqp0soyYmc=;
        b=ONivmopfGamE4VEHjNT39Y4wE+Jfz0PQZLqp8k54ZrFlFSEFzrtD/3X6idEkwbGVeL
         6FAnYagQzACUBMIA1LeatO0h4HmBufFuf69MrmhqhgahGhOY4ZMLf9zJG5pTt61Ob5ML
         +TtaVQz6sqMZ3gDEJqRpIoLOGpPQ2KWphMCsYgyf8NodI+CSw4VQpiYJBif8zLcX8WqT
         IjJo0spfIBAMpwfL/jHPXF0OTuoUoYM/eAKfvEVuzKocJcfc9ZYsuxtLnS3N6fNCMQrl
         JCr7OOHv21R27XQuofhqWF8EFeDUM2fMvn/smWNy+QsoWYsHRg9teFtL8WMm30DIdnqC
         2Irw==
X-Gm-Message-State: AOJu0Yx+h9GXUj9yH7irWP/GSOGS9EDvBLFYYrGQ/Ve72tSAsgAzUXeF
        Wm3EPhTCexuQXMCQoEJY6ZLCEkFvfvmRHKS3Rno=
X-Google-Smtp-Source: AGHT+IHfPeicL1opYbA37mRkfqAkFJLmBHj9gEA7b/4KXA1o0GERRH7w24kfchkbmVnzPNkQ+7WtAl5KhdO8aWuibfk=
X-Received: by 2002:a05:620a:22b:b0:774:131c:854d with SMTP id
 u11-20020a05620a022b00b00774131c854dmr4099448qkm.72.1695537974912; Sat, 23
 Sep 2023 23:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com> <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki> <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org> <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
In-Reply-To: <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Sep 2023 09:46:03 +0300
Message-ID: <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com,
        brauner@kernel.org, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 24, 2023 at 6:48=E2=80=AFAM Reuben Hawkins <reubenhwk@gmail.com=
> wrote:
>
>
>
> On Sat, Sep 23, 2023 at 10:48=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
>>
>> On Sat, Sep 23, 2023 at 5:41=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
>> >
>> > On Sat, Sep 23, 2023 at 08:56:28AM +0300, Amir Goldstein wrote:
>> > > We decided to deliberately try the change of behavior
>> > > from EINVAL to ESPIPE, to align with fadvise behavior,
>> > > so eventually the LTP test should be changed to allow both.
>> > >
>> > > It was the test failure on the socket that alarmed me.
>> > > However, if we will have to special case socket in
>> > > readahead() after all, we may as well also special case
>> > > pipe with it and retain the EINVAL behavior - let's see
>> > > what your findings are and decide.
>> >
>> > If I read it correctly, LTP is reporting that readhaead() on a socket
>> > returned success instead of an error.  Sockets do have a_ops, right?
>> > It's set to empty_aops in inode_init_always, I think.
>> >
>>
>> Yeh, you are right.
>> I guess the check !f.file->f_mapping->a_ops is completely futile
>> in that code. It's the only place I could find this sort of check
>> except for places like:
>> if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
>> which just looks like a coding habit.
>>
>> > It would be nice if we documented somewhere which pointers should be
>> > checked for NULL for which cases ... it doesn't really make sense for
>> > a socket inode to have an i_mapping since it doesn't have pagecache.
>> > But maybe we rely on i_mapping always being set.
>> >
>>
>> I can't imagine that a socket has f_mapping.
>> There must have been something off with this specific bug report,
>> because it was reported on a WIP patch.
>>
>> > Irritatingly, POSIX specifies ESPIPE for pipes, but does not specify
>> > what to do with sockets.  It's kind of a meaningless syscall for
>> > any kind of non-seekable fd.  lseek() returns ESPIPE for sockets
>> > as well as pipes, so I'd see this as an oversight.
>> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/posix_fadvi=
se.html
>> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/lseek.html
>> >
>>
>> Indeed, we thought it wouldn't be too bad to align the
>> readahead errors with those of posix_fadvise.
>> That's why we asked to remove the S_ISFIFO check for v2.
>> But looking again, pipe will get EINVAL for !f_mapping, so the
>> UAPI wasn't changed at all and we were just talking BS all along.
>> Let's leave the UAPI as is.
>>
>> > Of course readahead() is a Linux-specific syscall, so we can do whatev=
er
>> > we want here, but I'm really tempted to just allow readahead() for
>> > regular files and block devices.  Hmm.  Can we check FMODE_LSEEK
>> > instead of (S_ISFILE || S_ISBLK)?
>>
>> I think the f_mapping check should be good.
>> Reuben already said he could not reproduce the LTP failure with
>> v2 that is on Christian's vfs.misc branch.
>>
>> The S_ISREG check I put in the Fixes commit was completely
>> unexplained in the commit message and completely unneeded.
>> Just removing it as was done in v2 is enough.
>>
>> However, v2 has this wrong comment in the commit message:
>> "The change also means that readahead will return -ESPIPE
>>   on FIFO files instead of -EINVAL."
>>
>> We need to remove this comment
>> and could also remove the unneeded !f.file->f_mapping->a_ops
>> check while at it.
>>
>> Thanks,
>> Amir.
>
>
> It looks to me like the following will fix the problem without breaking t=
he tests...
>
> - if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
> -    !S_ISREG(file_inode(f.file)->i_mode))
> + if (!(f.file->f_mode & FMODE_LSEEK))
>
> ...I'll put this in a v3 patch soon unless somebody can spot any reasons =
why
> this is no good.

I am confused.
I thought you wrote that v2 did not break the test.
Why then is this change to use FMODE_LSEEK needed?
Why is it not enough to leave just
   if (!f.file->f_mapping)

Perhaps my comment to remove the unneeded
 !f.file->f_mapping->a_ops was misunderstood?

Also, in patch v3, you added RVB of Jan, but this is not the
version that Jan has reviewed.

Thanks,
Amir.
