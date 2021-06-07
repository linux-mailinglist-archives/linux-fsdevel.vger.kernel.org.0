Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF8839D64A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 09:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhFGHtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 03:49:21 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40560 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhFGHtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:49:20 -0400
Received: by mail-pf1-f179.google.com with SMTP id q25so12462766pfh.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jun 2021 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DodaeneTSitzgzJXeCCRXbjiNdJoXEj83o/MdYpmtA=;
        b=h+8tMj9mn8wQPDpTHQlTCo0cpEV1hAs57O3TVDVZ/IZn9O2eYr/lLmWRsQ6xtxPEHh
         NMEK4TFk0mcTwx3VpJ635Je2OHUT4nHJs4IjXCDGvkB6NANVhMaqc9p5XLzKIxgnZVM/
         KEDr5M38dhknIqipFODGd7NsgUirMhwNJApNicRB75vJJJTd9o7jqn4yfUPvZoZ/8Y1x
         DmWvQjQegQ/XYm1R96F601llnWhzxgQT2t6jj0Ui3Trq7Rj1YVV3Hvov18bmf8E1BxD/
         HGASRilgpzYUMb86c83z4VF4Xubo3T+5UHuaH3alMlPzINKxNkpkNOXTz06iH5Kma/u6
         WuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DodaeneTSitzgzJXeCCRXbjiNdJoXEj83o/MdYpmtA=;
        b=XuKg+8Du5zeGa+whjz5Oy7j1ALVjvuG5NxfVyfy0INjd7O6r4V49M6lXJwZhtVWEMb
         b7Gmu073iouU6bA3dFjB2H2XqRwyrMbNgLk0St6z9IP2x3OyENp8mSsPv23Rwd1js24R
         jaGCmZwSVyQR8AnfZej3qb1WWTjmTLPDumpvgV+iCoXprdTgj7lmpRUKqJouSUNgSPP4
         GutV5ZLncVFvZEHehq+uGTHnRnU9i8jUdgs0tpsvvOHPvx+sjoOCBLrfcTdlXMTuNKCc
         jf6CcUIl1gY3qG6ZXs3wAPMlxtEzIw+B4ZKbKJCnvTPeHn5kAuAfC/IZMJaLRAm/p7LO
         DLVQ==
X-Gm-Message-State: AOAM530JmK6aU8HPDapoC0tVs3CpIeO0QApriNRdtaD7xVjFhRzQ4cL1
        LJ/T4T8X1jcjsN+4CJIgoXw1oIY3ZHjLDEkq/Bc=
X-Google-Smtp-Source: ABdhPJzG9BjvCqRVErGOyuAxgEKIHiDERevV35Y9lIyNmAzIzCkdxMSwTdPf22u8PcbNN67iK4+1auD7WLUrE5TcXo4=
X-Received: by 2002:a63:1f57:: with SMTP id q23mr2175596pgm.398.1623051989993;
 Mon, 07 Jun 2021 00:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com> <YLeoucLiMOSPwn4U@google.com>
In-Reply-To: <YLeoucLiMOSPwn4U@google.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Mon, 7 Jun 2021 15:46:18 +0800
Message-ID: <CA+a=Yy4kjVJvaf4YWsUQRmhs58zbyt6APs5U+yz_m+MFtA3FUQ@mail.gmail.com>
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     Alessio Balsini <balsini@android.com>
Cc:     Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 2, 2021 at 11:52 PM Alessio Balsini <balsini@android.com> wrote:
>
> On Tue, Jun 01, 2021 at 04:58:26PM +0800, Peng Tao wrote:
> > Add a generic file store that userspace can save/restore any open file
> > descriptor. These file descriptors can be managed by different
> > applications not just the same user space application.
> >
> > A possible use case is fuse fd passthrough being developed
> > by Alessio Balsini [1] where underlying file system fd can be saved in
> > this file store.
> >
> > Another possible use case is user space application live upgrade and
> > failover (upon panic etc.). Currently during userspace live upgrade and
> > failover, open file descriptors usually have to be saved seprately in
> > a different management process with AF_UNIX sendmsg.
> >
> > But it causes chicken and egg problem and such management process needs
> > to support live upgrade and failover as well. With a generic file store
> > in the kernel, application live upgrade and failover no longer require such
> > management process to hold reference for their open file descriptors.
> >
> > This is an RFC to see if the approach makes sense to upstream and it can be
> > tested with the following C programe.
> >
> > Why FUSE?
> > - Because we are trying to solve FUSE fd passthrough and FUSE daemon
> >   live upgrade.
> >
> > Why global IDR rather than per fuse connnection one?
> > - Because for live upgrade new process, we don't have a valid fuse connection
> >   in the first place.
> >
> > Missing cleanup method in case user space messes up?
> > - We can limit the number of saved FDs and hey it is RFC ;).
> >
> > [1] https://lore.kernel.org/lkml/20210125153057.3623715-1-balsini@android.com/
> > --------
> >
> > [...]
> >
>
>
> Hi Peng,
Hi Alessio,

>
> This is a cool feature indeed.
>
> I guess we also want to ensure that restoring an FD can only be
> performed by a trusted FUSE daemon, and not any other process attached
> to /dev/fuse. Maybe adding some permission checks?
>
The idea is to allow any daemon capable of opening /dev/fuse to be
able to restore an FD. I don't quite get which permissions do you like
to check? SYS_ADMIN?

> I also see that multiple restores can be done on the same FD, is that
> intended? Shouldn't the IDR entry be removed once restored?
>
In a crash recovery scenario, if the kernel destroys the IDR once an
FD is restored, and the recovering daemon panics again, the FD is lost
forever. So I would prefer to keep it in the kernel until explicit FD
removal.

> As far as I understand, the main use case is to be able to replace a
> FUSE daemon with another, preserving the opened lower file system files.
> How would user space handle the unmounting of the old FUSE file system
> and mounting of the new one?
It can call FUSE_DEV_IOC_REMOVE_FD before or after unmounting the old
FUSE file system. Either way, the last closer of the FUSE connection
FD would actually close the FUSE connection.

> I wonder if something can be done with a pair of ioctls similar to
> FUSE_DEV_IOC_CLONE to transfer the FUSE connection from the old to the
> new FUSE daemon.  Maybe either the IDR or some other container to store
> the files that are intended to be preserved can be put in fuse_conn
> instead of keeping it global.
>
> Does it make sense?
>
It makes sense at first glance since obviously it helps IDR cleaning
up as we can do it on a per fuse_conn basis. But giving it a second
thought, how do we preserve the FUSE connection fd representing the
same fuse_conn itself? We need to do it because we want to handle FUSE
daemon crash recovery cases. Maybe we can have something like:
1. use a tag to uniquely identify a fuse conn (as being done for virtio-fs)
2. in each of these SAVE/GET/REMOVE ioctls, it takes a tag argument so
FDs are kept locally to the specified fuse_conn
3. add FUSE_DEV_IOC_TRANSFER ioctl to transfer ownership of a saved FD
to a new userspace daemon. It can be seen as a combination of GET and
REMOVE ioctls

Cheers,
Tao

-- 
Into Sth. Rich & Strange
