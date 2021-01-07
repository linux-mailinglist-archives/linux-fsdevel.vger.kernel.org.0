Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78062ECAC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 08:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbhAGHCw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 02:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbhAGHCw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 02:02:52 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC9C0612F4;
        Wed,  6 Jan 2021 23:02:12 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e7so5789099ile.7;
        Wed, 06 Jan 2021 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YTt2iOcdKE4UY7gFfdehlngY69FHJ1uqrL8kNL4lN74=;
        b=p7IBiiEnJr6wVwYOhRWuzN8CFzPgocDKLDIlO4X9eKj00/6fj/6l6+29/3E3/KJEFA
         Ld3DHmarBLEC79P4JolvmhP5bKuxm71ca8ziHbJa+RZXGpN365j5y2iyg2UcJ0MGpr9Q
         AhtH40mfMqvmJdzFEkhvDF9A4M0IusRhk5mkxd3X0/bkf1QZ2uZvuGSzLH6RaPT+AZw0
         K1JJI7FVqwAneWNJ2k3dNE3Pe7W70IY9/WkEZyFIxHPj4koKZnWX+2xQXVreze/5aT0w
         SlWDFg1uVNC/azAaC14bKDPy40ze02hXSdq2HQgylwuhcu1bA7MQkNFw9N+ae6PLaQsx
         IMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YTt2iOcdKE4UY7gFfdehlngY69FHJ1uqrL8kNL4lN74=;
        b=B0lsfwuDPuOSGWUTH51MIotcPStnpJpGI9XjY5Mk5UZMwptokFAXrvRamds0ivelSL
         enNVn3vc5y8DPQJlBsKL7OdCghsMU1z8wtPO3cAUi9PP41l1yPZmveYUalhUcU1FGCmX
         odC83TSHBCNvCrM2cC/8CXtQgxxLp2eKTqAcYYhLuKEFe7R8EgtyzwxdGdluqXViJQqY
         BJs5YbzwZQRP0Tdl6OeDukp7OP9MxawficKNcNPD0IhiLgyMZ1A73opvcr4fkpMhywRG
         faEyHMYM13H24lHLFXKFFSrKOPPs9ySTVNo2BVDrJ6erGejOjU8mwa+82Nbyt6rDLYUK
         Nt1g==
X-Gm-Message-State: AOAM532GfTie9jZcxpally+UZVAKu3sAYfennVQHzmPapcKYvMu2O4WB
        7EvzAFtLEznv+wnbAI4nIhvcPZwy/QVfD/yt0rdJQnNni6A=
X-Google-Smtp-Source: ABdhPJzCmV6l8fuKW9Y+8fwWPFDTKkDc86N/yWJKxC11RItaXjTAhczgzZ19hsGw+rmdj9qKF/wiN5hNWm9sDKJqxkY=
X-Received: by 2002:a92:d587:: with SMTP id a7mr3487057iln.250.1610002931441;
 Wed, 06 Jan 2021 23:02:11 -0800 (PST)
MIME-Version: 1.0
References: <20210106083546.4392-1-sargun@sargun.me> <20210106194658.GA3290@redhat.com>
In-Reply-To: <20210106194658.GA3290@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 7 Jan 2021 09:02:00 +0200
Message-ID: <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 9:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jan 06, 2021 at 12:35:46AM -0800, Sargun Dhillon wrote:
> > Overlayfs's volatile option allows the user to bypass all forced sync calls
> > to the upperdir filesystem. This comes at the cost of safety. We can never
> > ensure that the user's data is intact, but we can make a best effort to
> > expose whether or not the data is likely to be in a bad state.
> >
> > The best way to handle this in the time being is that if an overlayfs's
> > upperdir experiences an error after a volatile mount occurs, that error
> > will be returned on fsync, fdatasync, sync, and syncfs. This is
> > contradictory to the traditional behaviour of VFS which fails the call
> > once, and only raises an error if a subsequent fsync error has occurred,
> > and been raised by the filesystem.
> >
> > One awkward aspect of the patch is that we have to manually set the
> > superblock's errseq_t after the sync_fs callback as opposed to just
> > returning an error from syncfs. This is because the call chain looks
> > something like this:
> >
> > sys_syncfs ->
> >       sync_filesystem ->
> >               __sync_filesystem ->
> >                       /* The return value is ignored here
> >                       sb->s_op->sync_fs(sb)
> >                       _sync_blockdev
> >               /* Where the VFS fetches the error to raise to userspace */
> >               errseq_check_and_advance
> >
> > Because of this we call errseq_set every time the sync_fs callback occurs.
>
> Why not start capturing return code of ->sync_fs and then return error
> from ovl->sync_fs. And then you don't have to do errseq_set(ovl_sb).
>
> I already posted a patch to capture retrun code from ->sync_fs.
>
> https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
>
>

Vivek,

IMO the more important question is "Why not?".

Your patches will undoubtedly get to mainline in the near future and they do
make the errseq_set(ovl_sb) in this patch a bit redundant, but I really see no
harm in it. It is very simple for you to remove this line in your patch.
I do see the big benefit of an independent patch that is easy to apply to fix
a fresh v5.10 feature.

I think it is easy for people to dismiss the importance of "syncfs on volatile"
which sounds like a contradiction, but it is not.
The fact that the current behavior is documented doesn't make it right either.
It just makes our review wrong.
The durability guarantee (that volatile does not provide) is very different
from the "reliability" guarantee that it CAN provide.
We do not want to have to explain to people that "volatile" provided different
guarantees depending on the kernel they are running.
Fixing syncfs/fsync of volatile is much more important IMO than erroring
on other fs ops post writeback error, because other fs ops are equally
unreliable on any filesystem in case application did not do fsync.

Ignoring the factor of "backporting cost" when there is no engineering
justification to do so is just ignoring the pain of others.
Do you have an engineering argument for objecting this patch is
applied before your fixes to syncfs vfs API?

Sargun,

Please add Fixes/Stable #v5.10 tags.

Thanks,
Amir.
