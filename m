Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC192ED2F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 15:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbhAGOpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 09:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbhAGOpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:45:12 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA3C0612F4;
        Thu,  7 Jan 2021 06:44:31 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e7so6942623ile.7;
        Thu, 07 Jan 2021 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8989NeeO+e7j0S5eqB/NrqdewSkIg2p+TIQ1tazPIU=;
        b=L9sNcQzcAXBzGYZBi4H5W7wy1z236YfWSn60WX0Azfa3IoVrFOXW1uc9E2213YrUwf
         H+CdI18UyjP21UK/Dsgj8S28EGQROyvDO33rQ/sbCuoMXaVtAj3a9U/+GGyVDTQ8QEEM
         NpyNDoRzBqAYGz2JzLKe6t2XJFG/wne2oZdnQyOPci2fIjh6nW5SEbu/GiZScPp48Wgb
         NdhFxf+q0RjogKnVhPKSiPLooFZzNGC/+ecteuOzlsLDqDJfs7hEUeR7rHU9Zu/+fArf
         zgF9lt8ZptgfC94JFWP4eGmsuuIATgekLoIbnZfctNArdV75d075PtsHUtSLpPh7eUmC
         2ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8989NeeO+e7j0S5eqB/NrqdewSkIg2p+TIQ1tazPIU=;
        b=uoZeCSOt3x8rq7mBZADt+3tiu+Lj5L0OJjQdg8H8aV5lE0ePJjo82yG8qT7eHHdUyM
         l4WV2tPs51UwG3f1cgliRFYX2ZbJe69q5WlNCBlNp2IBD4D7sI6sE1+4yAwTq54Jixad
         sekjdthXvXHGWF0dU4fy0dL5CiTcaY+zgwc/A+U6s5lFPIjGG5MufBc5fDNIz5wAcDkx
         Efqj4JxH4A/Fd9ubEoOOqoOeqEQ6tMa63+G/Y5sdUaSUAAvoQrY7po6RhrQ7f6RHJw19
         dqJJjYI7Maks9R99wer/eqPLt46C+/7bdVFx451SA0nv77ajUPAA9wrb7LNWepTpoaa/
         cvew==
X-Gm-Message-State: AOAM533Lx/OaXeUk9Y71kYTuCkQsSbxDuuImQWGukf01gxgMyKlcy2ZG
        3cTrfrr8WkcQv7tbDKh1V1EbMTsXjpEUwXhpLl8=
X-Google-Smtp-Source: ABdhPJznrJ0uFVgO0YUs4zRJQFWIqKjLxvw/HYOdlQlslzjh3hMFTNXMyg8fb8ZWjttNIhzDFyM592xIaFhVRiXcdyQ=
X-Received: by 2002:a92:6403:: with SMTP id y3mr9220163ilb.72.1610030670897;
 Thu, 07 Jan 2021 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20210106083546.4392-1-sargun@sargun.me> <20210106194658.GA3290@redhat.com>
 <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com> <20210107134456.GA3439@redhat.com>
In-Reply-To: <20210107134456.GA3439@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Jan 2021 16:44:19 +0200
Message-ID: <CAOQ4uxjdPkO1OEOFBdgS1ps0GzBrN1jCF5zFkAoLeCJEtkALwg@mail.gmail.com>
Subject: Re: [PATCH v3] overlay: Implement volatile-specific fsync error behaviour
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.com>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:45 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Jan 07, 2021 at 09:02:00AM +0200, Amir Goldstein wrote:
> > On Wed, Jan 6, 2021 at 9:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Wed, Jan 06, 2021 at 12:35:46AM -0800, Sargun Dhillon wrote:
> > > > Overlayfs's volatile option allows the user to bypass all forced sync calls
> > > > to the upperdir filesystem. This comes at the cost of safety. We can never
> > > > ensure that the user's data is intact, but we can make a best effort to
> > > > expose whether or not the data is likely to be in a bad state.
> > > >
> > > > The best way to handle this in the time being is that if an overlayfs's
> > > > upperdir experiences an error after a volatile mount occurs, that error
> > > > will be returned on fsync, fdatasync, sync, and syncfs. This is
> > > > contradictory to the traditional behaviour of VFS which fails the call
> > > > once, and only raises an error if a subsequent fsync error has occurred,
> > > > and been raised by the filesystem.
> > > >
> > > > One awkward aspect of the patch is that we have to manually set the
> > > > superblock's errseq_t after the sync_fs callback as opposed to just
> > > > returning an error from syncfs. This is because the call chain looks
> > > > something like this:
> > > >
> > > > sys_syncfs ->
> > > >       sync_filesystem ->
> > > >               __sync_filesystem ->
> > > >                       /* The return value is ignored here
> > > >                       sb->s_op->sync_fs(sb)
> > > >                       _sync_blockdev
> > > >               /* Where the VFS fetches the error to raise to userspace */
> > > >               errseq_check_and_advance
> > > >
> > > > Because of this we call errseq_set every time the sync_fs callback occurs.
> > >
> > > Why not start capturing return code of ->sync_fs and then return error
> > > from ovl->sync_fs. And then you don't have to do errseq_set(ovl_sb).
> > >
> > > I already posted a patch to capture retrun code from ->sync_fs.
> > >
> > > https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
> > >
> > >
> >
> > Vivek,
> >
> > IMO the more important question is "Why not?".
> >
> > Your patches will undoubtedly get to mainline in the near future and they do
> > make the errseq_set(ovl_sb) in this patch a bit redundant,
>
> I thought my patch of capturing ->sync_fs is really simple (just few
> lines), so backportability should not be an issue. That's why I
> asked for it.
>

Apologies. I thought you meant your entire patch set.
I do agree to that. In fact, I think I suggested it myself at one
point or another.

> > but I really see no
> > harm in it. It is very simple for you to remove this line in your patch.
> > I do see the big benefit of an independent patch that is easy to apply to fix
> > a fresh v5.10 feature.
> >
> > I think it is easy for people to dismiss the importance of "syncfs on volatile"
> > which sounds like a contradiction, but it is not.
> > The fact that the current behavior is documented doesn't make it right either.
> > It just makes our review wrong.
> > The durability guarantee (that volatile does not provide) is very different
> > from the "reliability" guarantee that it CAN provide.
> > We do not want to have to explain to people that "volatile" provided different
> > guarantees depending on the kernel they are running.
> > Fixing syncfs/fsync of volatile is much more important IMO than erroring
> > on other fs ops post writeback error, because other fs ops are equally
> > unreliable on any filesystem in case application did not do fsync.
> >
> > Ignoring the factor of "backporting cost" when there is no engineering
> > justification to do so is just ignoring the pain of others.
> > Do you have an engineering argument for objecting this patch is
> > applied before your fixes to syncfs vfs API?
>
> Carrying ->sync_fs return code patch is definitely not a blocker. It
> is just nice to have. Anyway, I you don't want to carry that ->sync_fs
> return patch in stable, I am fine with this patch. I will follow up
> on that fix separately.
>

Please collaborate with Sargun.
I think it is best if one of you will post those two patches in the same
series. I think you had a few minor comments to address, so many
send the final patch version to Sargun to he can test the two patches
together and post them?

Sorry for the confusion.
Too many "the syncfs patch" to juggle.

Thanks,
Amir.
