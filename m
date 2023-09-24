Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A61C7AC7CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Sep 2023 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjIXLsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 07:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXLsB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:48:01 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5FEAB
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 04:47:54 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4526ae5b0b3so1803298137.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695556073; x=1696160873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwB1t542kkaERwsoxYQ0F9sSaSy0Ag3hNeHi7ZKO4bI=;
        b=XfatOheMYcgIH0e3ItOYlyAwyHcEhycLDaROJzoFf94wTi60zPAp/5z1rbrH75CjOC
         4GUpOJqU/Q1H2ZhNFASZBeJKM7L503yaLEHKvpPTuQ8JdX2kO4OoH2BW318WZem0rE61
         vYcOff8ZI7995M0TeX8z6yJoBxhXeYPgqW4j9h62s0ITWWdsoPye9SOOTydeXxcXtDpM
         btX/KBhYzv0X32mhFpfG1EHmekOUj0me3EbsKdfZDEacVzeG70XjDU8uXqZZyjwHx4Oh
         xlXLyKNoSO7eObkoRlStrNnfyOgN1RqnCt2dqZ/8Du8nwCe3oleoSs6DYCca0vTtM4ph
         Jn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695556073; x=1696160873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwB1t542kkaERwsoxYQ0F9sSaSy0Ag3hNeHi7ZKO4bI=;
        b=RmwpZyXRRs3LsubpYBt5hZs+iCA5mnDgDqQ4+UC7vCPMA5fsighctfQvK7qFWInbNA
         XthsQPlvRaba4LcOuhR7S3vrVgLut9a+lv8WXHg7m8xtx/oiGg7/4Jo8F8G7lHHZYS7r
         yIJfFvqNF+gkNwHoau08bAV+/jVGrltUKsnfMzqdH9/Bp+7QWUiZNi3ZkNwENt1ni22j
         54wV3pYjuNPd2DTy3rURFps35TQWMhjFAtXHYKC8KyTRMDXR24neJT+Swnkqyi4HQMwg
         vfC6ZhgppS9lN194ayfs/AA+jzsMKqOwg27qHughxvdIRuYRmb2ZBPgdMitSSmWdtqsQ
         opBg==
X-Gm-Message-State: AOJu0YxsPfSrd+VYrXSroRJrM7dw2AK+mMne6cDMTzl2m0a4WHhTvJbw
        AzbXI7ldt4XyoI3OyvEvc5nA90L8d2BPtGxt2BShNQ+ZUjc=
X-Google-Smtp-Source: AGHT+IFx7p5lTC4A/7cAxVidzygF9J6VuZR8Jue4Kv/0rl8DUY12YC73r3tIp1kmxTiLPxAeLZ4KwD+fGf3w4cfTWcc=
X-Received: by 2002:a67:db8d:0:b0:44d:4c28:55ca with SMTP id
 f13-20020a67db8d000000b0044d4c2855camr1692784vsk.16.1695556073382; Sun, 24
 Sep 2023 04:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com> <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki> <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org> <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com> <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
In-Reply-To: <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 24 Sep 2023 14:47:42 +0300
Message-ID: <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>, brauner@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>, mszeredi@redhat.com, lkp@intel.com,
        linux-fsdevel@vger.kernel.org,
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

On Sun, Sep 24, 2023 at 9:46=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sun, Sep 24, 2023 at 6:48=E2=80=AFAM Reuben Hawkins <reubenhwk@gmail.c=
om> wrote:
> >
> >
> >
> > On Sat, Sep 23, 2023 at 10:48=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> >>
> >> On Sat, Sep 23, 2023 at 5:41=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> >> >
> >> > On Sat, Sep 23, 2023 at 08:56:28AM +0300, Amir Goldstein wrote:
> >> > > We decided to deliberately try the change of behavior
> >> > > from EINVAL to ESPIPE, to align with fadvise behavior,
> >> > > so eventually the LTP test should be changed to allow both.
> >> > >
> >> > > It was the test failure on the socket that alarmed me.
> >> > > However, if we will have to special case socket in
> >> > > readahead() after all, we may as well also special case
> >> > > pipe with it and retain the EINVAL behavior - let's see
> >> > > what your findings are and decide.
> >> >
> >> > If I read it correctly, LTP is reporting that readhaead() on a socke=
t
> >> > returned success instead of an error.  Sockets do have a_ops, right?
> >> > It's set to empty_aops in inode_init_always, I think.
> >> >
> >>
> >> Yeh, you are right.
> >> I guess the check !f.file->f_mapping->a_ops is completely futile
> >> in that code. It's the only place I could find this sort of check
> >> except for places like:
> >> if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> >> which just looks like a coding habit.
> >>
> >> > It would be nice if we documented somewhere which pointers should be
> >> > checked for NULL for which cases ... it doesn't really make sense fo=
r
> >> > a socket inode to have an i_mapping since it doesn't have pagecache.
> >> > But maybe we rely on i_mapping always being set.
> >> >
> >>
> >> I can't imagine that a socket has f_mapping.
> >> There must have been something off with this specific bug report,
> >> because it was reported on a WIP patch.
> >>
> >> > Irritatingly, POSIX specifies ESPIPE for pipes, but does not specify
> >> > what to do with sockets.  It's kind of a meaningless syscall for
> >> > any kind of non-seekable fd.  lseek() returns ESPIPE for sockets
> >> > as well as pipes, so I'd see this as an oversight.
> >> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/posix_fad=
vise.html
> >> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/lseek.htm=
l
> >> >
> >>
> >> Indeed, we thought it wouldn't be too bad to align the
> >> readahead errors with those of posix_fadvise.
> >> That's why we asked to remove the S_ISFIFO check for v2.
> >> But looking again, pipe will get EINVAL for !f_mapping, so the
> >> UAPI wasn't changed at all and we were just talking BS all along.
> >> Let's leave the UAPI as is.
> >>
> >> > Of course readahead() is a Linux-specific syscall, so we can do what=
ever
> >> > we want here, but I'm really tempted to just allow readahead() for
> >> > regular files and block devices.  Hmm.  Can we check FMODE_LSEEK
> >> > instead of (S_ISFILE || S_ISBLK)?
> >>
> >> I think the f_mapping check should be good.
> >> Reuben already said he could not reproduce the LTP failure with
> >> v2 that is on Christian's vfs.misc branch.
> >>
> >> The S_ISREG check I put in the Fixes commit was completely
> >> unexplained in the commit message and completely unneeded.
> >> Just removing it as was done in v2 is enough.
> >>
> >> However, v2 has this wrong comment in the commit message:
> >> "The change also means that readahead will return -ESPIPE
> >>   on FIFO files instead of -EINVAL."
> >>
> >> We need to remove this comment
> >> and could also remove the unneeded !f.file->f_mapping->a_ops
> >> check while at it.
> >>
> >> Thanks,
> >> Amir.
> >
> >
> > It looks to me like the following will fix the problem without breaking=
 the tests...
> >
> > - if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
> > -    !S_ISREG(file_inode(f.file)->i_mode))
> > + if (!(f.file->f_mode & FMODE_LSEEK))
> >
> > ...I'll put this in a v3 patch soon unless somebody can spot any reason=
s why
> > this is no good.
>
> I am confused.
> I thought you wrote that v2 did not break the test.
> Why then is this change to use FMODE_LSEEK needed?
> Why is it not enough to leave just
>    if (!f.file->f_mapping)
>

Christian,

I cleared the confusion with Reuben off-list.

V2 on current vfs.misc is good as is, in the sense that it does
what we expected it to do - it breaks the LTP test for pipe because
the error value has changed from EINVAL to ESPIPE.
The error value for socket (EINVAL) has not changed.

Matthew,

Since you joined the discussion, you have the opportunity to agree or
disagree with our decision to change readahead() to ESPIPE.
Judging  by your citing of lseek and posix_fadvise standard,
I assume that you will be on board?

I think that the FMODE_LSEEK test would have been a good idea if
we wanted to preserve the EINVAL error code for pipe, but
I don't think that is the case?

Thanks,
Amir.
