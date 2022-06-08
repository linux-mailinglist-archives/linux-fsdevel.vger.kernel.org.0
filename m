Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6C6543722
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiFHPRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 11:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbiFHPQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:16:08 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224CD10A9;
        Wed,  8 Jun 2022 08:12:42 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id p3so7015367uam.12;
        Wed, 08 Jun 2022 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WG94p2edkIKDcgGBWYikbRM1gTNO7+P3Sh2LbeXDfqU=;
        b=pOfM/2EUVDmuVQ7A91fzp3O+W/p+wb1GKzUYWJ/bT/oWdW2QM8uYD0H4pYI/Bv9Y69
         nBsBQJSXR8CntPJwIGvC2XkJiTtXNnrbOFtsLhpxgoXV/2OSvpP9upgEp8/iq5e53gU8
         jYylvrzcCksi8nH3mND+M8xqZ5l+LhvrIeAwYzqywUyXNWuOp+MAxGJl5g2BW401lOWz
         Rsz5w3kvDZBM4Z+mBZB8BGr2++PJgbt1ZL7H36AriDmtP1j3srwz9Jb/YiXj1qgcLN7w
         e/TzmG2Qq2t8Yvu3ldbll8ld/jiEfkCoI7phj+G9QtW1cYyWV9oCZq2uhIWb57QAuUuD
         M86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WG94p2edkIKDcgGBWYikbRM1gTNO7+P3Sh2LbeXDfqU=;
        b=cfdu5FvEBCvOmInqDkDf5ZVZBuoNiXY/UFS60XjsNtgk2tEO4s358Y/81ylvMbUKzv
         uNEBJMVSL5TPYB/VQBnHF6y/Sfe8MKd/HW5YMoktrMHzGj4nXsBjB5XeTCEl/4eKI9U/
         fPohpban7KBIvmMkF9BlMQURzDhKiobZmqDNs4SJ2ndxPlGucTl8aA2PsfcFRARZ27NX
         /Emg4DnhPGJindxHFU4x1O/OZgSwAl90Jj//0GmjG0oBv3iKf/sDvqK26wZeVIO++Mzb
         HRR/DVpCp03mjV1llq4ebmTO5+n+fJojVsGjJZQ97yt5QxcFA2bcjvbpaP22zugcyYb4
         wgUA==
X-Gm-Message-State: AOAM532/uDJU30O3CbypSYsntytBx0M3f47GeBBnoebJLPVojLuKKlEc
        jnBqzW60klgQMgRNtdoAWHFjqSVBW87YQYbbNRE=
X-Google-Smtp-Source: ABdhPJz6+s2hS3jQ6SMpKkrD1/eP4KjxDzXlJbreb7w3OX8ahmGhGR0Care8jMIgSpEtyea5tkQD1mKKlvMd/mdu/Bc=
X-Received: by 2002:ab0:2315:0:b0:378:cc65:f798 with SMTP id
 a21-20020ab02315000000b00378cc65f798mr8801120uao.60.1654701161087; Wed, 08
 Jun 2022 08:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein>
In-Reply-To: <20220608124808.uylo5lntzfgxxmns@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 18:12:29 +0300
Message-ID: <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org> wrote=
:
>
> On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> > On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.org> w=
rote:
> > >
> > > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=C3=B6ttsche wro=
te:
> > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > >
> > > > Support file descriptors obtained via O_PATH for extended attribute
> > > > operations.
> > > >
> > > > Extended attributes are for example used by SELinux for the securit=
y
> > > > context of file objects. To avoid time-of-check-time-of-use issues =
while
> > > > setting those contexts it is advisable to pin the file in question =
and
> > > > operate on a file descriptor instead of the path name. This can be
> > > > emulated in userspace via /proc/self/fd/NN [1] but requires a procf=
s,
> > > > which might not be mounted e.g. inside of chroots, see[2].
> > > >
> > > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2ce=
e28f647376a7233d2ac2d12ca50
> > > > [2]: https://github.com/SELinuxProject/selinux/commit/de285252a1801=
397306032e070793889c9466845
> > > >
> > > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > > https://patchwork.kernel.org/project/linux-fsdevel/patch/2020050509=
5915.11275-6-mszeredi@redhat.com/
> > > >
> > > > > While this carries a minute risk of someone relying on the proper=
ty of
> > > > > xattr syscalls rejecting O_PATH descriptors, it saves the trouble=
 of
> > > > > introducing another set of syscalls.
> > > > >
> > > > > Only file->f_path and file->f_inode are accessed in these functio=
ns.
> > > > >
> > > > > Current versions return EBADF, hence easy to detect the presense =
of
> > > > > this feature and fall back in case it's missing.
> > > >
> > > > CC: linux-api@vger.kernel.org
> > > > CC: linux-man@vger.kernel.org
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > >
> > > I'd be somewhat fine with getxattr and listxattr but I'm worried that
> > > setxattr/removexattr waters down O_PATH semantics even more. I don't
> > > want O_PATH fds to be useable for operations which are semantically
> > > equivalent to a write.
> >
> > It is not really semantically equivalent to a write if it works on a
> > O_RDONLY fd already.
>
> The fact that it works on a O_RDONLY fd has always been weird. And is
> probably a bug. If you look at xattr_permission() you can see that it

Bug or no bug, this is the UAPI. It is not fixable anymore.

> checks for MAY_WRITE for set operations... setxattr() writes to disk for
> real filesystems. I don't know how much closer to a write this can get.
>
> In general, one semantic aberration doesn't justify piling another one
> on top.
>
> (And one thing that speaks for O_RDONLY is at least that it actually
> opens the file wheres O_PATH doesn't.)

Ok. I care mostly about consistent UAPI, so if you want to set the
rule that modify f*() operations are not allowed to use O_PATH fd,
I can live with that, although fcntl(2) may be breaking that rule, but
fine by me.
It's good to have consistent rules and it's good to add a new UAPI for
new behavior.

However...

>
> >
> > >
> > > In sensitive environments such as service management/container runtim=
es
> > > we often send O_PATH fds around precisely because it is restricted wh=
at
> > > they can be used for. I'd prefer to not to plug at this string.
> >
> > But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
> > are almost identical w.r.t permission checks and everything else.
> >
> > So this change introduces nothing new that a user in said environment
> > cannot already accomplish with setxattr().
> >
> > Besides, as the commit message said, doing setxattr() on an O_PATH
> > fd is already possible with setxattr("/proc/self/$fd"), so whatever sec=
urity
> > hole you are trying to prevent is already wide open.
>
> That is very much a something that we're trying to restrict for this
> exact reason and is one of the main motivator for upgrade mask in
> openat2(). If I want to send a O_PATH around I want it to not be
> upgradable. Aleksa is working on upgrade masks with openat2() (see [1]
> and part of the original patchset in [2]. O_PATH semantics don't need to
> become weird.
>
> [1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senku
> [2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/201907280102=
07.9781-8-cyphar@cyphar.com

... thinking forward, if this patch is going to be rejected, the patch that
will follow is *xattrat() syscalls.

What will you be able to argue then?

There are several *at() syscalls that modify metadata.
fchownat(.., AT_EMPTY_PATH) is intentionally designed for this.

Do you intend to try and block setxattrat()?
Just try and block setxattrat(.., AT_EMPTY_PATH)?
those *at() syscalls have real use cases to avoid TOCTOU races.
Do you propose that applications will have to use fsetxattr() on an open
file to avert races?

I completely understand the idea behind upgrade masks
for limiting f_mode, but I don't know if trying to retroactively
change semantics of setxattr() in the move to setxattrat()
is going to be a good idea.

And forgive me if I am failing to see the big picture.
It is certainly a possibility.

Thanks,
Amir.
