Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C62ECB5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 09:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAGIDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 03:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhAGIDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:03:33 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F7C0612F5
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 00:02:47 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id r17so5858511ilo.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 00:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zZbv/aFx7sGBOlp1fU4Bcw2SrbmJe+Tt0vbChEOr1Bc=;
        b=I8qTyvaFf39Vzwn5hhUK4ltzhyoxogjcmowbf8cci4SCHWzNTxWgVHqlCt1ruBtBpU
         riBu5NaX3hSdai1HafFpz9ribcv3EnjbyvdHZZXWcIgu/Ib+bGDX6BL8QGJRbzJhxyhf
         1WaP5fRrC9MNOIhCJNVPwZQbURdFo6LCjB4KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zZbv/aFx7sGBOlp1fU4Bcw2SrbmJe+Tt0vbChEOr1Bc=;
        b=S9dkLMAuPDngAsQKk4FKMF9zMhNJw0dEYOpR1hYmGy1ZFI93nLmZMSQcW18vNAcHpf
         Gv4Fujcx1aR90khpc+lrG+1WSrBpbJwId/FdnJWLgsPMD3SyOX7UrEhZz7xCndNg/wfa
         4XsYDwNXGv1mdCja0KFmNeEkQgxloXsUA6q59HZbpCFfPWWxAR/rqIP3KrngWMRY61xU
         LH88xSKsmAbEc+qmqo5OG61Q/xaFcA7/5ojOeH76wk14wW4mBHjIipyHaxoHDCWHNt5y
         LGX7Gvi+C4p/piAOQ2xbIthLeUEYSJIZ/MHOSdNBv/x/VdksAKcEBbAYck8Iv2qqlv1R
         53dA==
X-Gm-Message-State: AOAM533/SkcSnNfo2PWz7oMSysSVyXvwz55PHUbWNMQnRpH6nmNPRsLm
        3hoh08l2OAFN9jmWQpuhbc3oZVVgT7WrxF4ITmlhtQ==
X-Google-Smtp-Source: ABdhPJythKXltWK4yQ1/zXPA+d12bilmDTK162TOgVvQ72EmvL4qWXdsTHAtAmQHEUmXlyhm3eHy2ilLMi/46n/MH3w=
X-Received: by 2002:a05:6e02:148f:: with SMTP id n15mr8232588ilk.17.1610006566755;
 Thu, 07 Jan 2021 00:02:46 -0800 (PST)
MIME-Version: 1.0
References: <20210106083546.4392-1-sargun@sargun.me> <20210106194658.GA3290@redhat.com>
 <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgR_gybovg6t4+=MbeMXS6jm5ov1ULDGZgzg7yCxETsDw@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 7 Jan 2021 00:02:10 -0800
Message-ID: <CAMp4zn_fgpsDjObTpXk9=sDEdQf3dhod+54ZvwogNLcQwR--UQ@mail.gmail.com>
Subject: Re: [PATCH v3] overlay: Implement volatile-specific fsync error behaviour
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
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

On Wed, Jan 6, 2021 at 11:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Jan 6, 2021 at 9:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Wed, Jan 06, 2021 at 12:35:46AM -0800, Sargun Dhillon wrote:
> > > Overlayfs's volatile option allows the user to bypass all forced sync calls
> > > to the upperdir filesystem. This comes at the cost of safety. We can never
> > > ensure that the user's data is intact, but we can make a best effort to
> > > expose whether or not the data is likely to be in a bad state.
> > >
> > > The best way to handle this in the time being is that if an overlayfs's
> > > upperdir experiences an error after a volatile mount occurs, that error
> > > will be returned on fsync, fdatasync, sync, and syncfs. This is
> > > contradictory to the traditional behaviour of VFS which fails the call
> > > once, and only raises an error if a subsequent fsync error has occurred,
> > > and been raised by the filesystem.
> > >
> > > One awkward aspect of the patch is that we have to manually set the
> > > superblock's errseq_t after the sync_fs callback as opposed to just
> > > returning an error from syncfs. This is because the call chain looks
> > > something like this:
> > >
> > > sys_syncfs ->
> > >       sync_filesystem ->
> > >               __sync_filesystem ->
> > >                       /* The return value is ignored here
> > >                       sb->s_op->sync_fs(sb)
> > >                       _sync_blockdev
> > >               /* Where the VFS fetches the error to raise to userspace */
> > >               errseq_check_and_advance
> > >
> > > Because of this we call errseq_set every time the sync_fs callback occurs.
> >
> > Why not start capturing return code of ->sync_fs and then return error
> > from ovl->sync_fs. And then you don't have to do errseq_set(ovl_sb).
> >
> > I already posted a patch to capture retrun code from ->sync_fs.
> >
> > https://lore.kernel.org/linux-fsdevel/20201221195055.35295-2-vgoyal@redhat.com/
> >
> >
>
> Vivek,
>
> IMO the more important question is "Why not?".
>
> Your patches will undoubtedly get to mainline in the near future and they do
> make the errseq_set(ovl_sb) in this patch a bit redundant, but I really see no
> harm in it. It is very simple for you to remove this line in your patch.
> I do see the big benefit of an independent patch that is easy to apply to fix
> a fresh v5.10 feature.
>
> I think it is easy for people to dismiss the importance of "syncfs on volatile"
> which sounds like a contradiction, but it is not.
> The fact that the current behavior is documented doesn't make it right either.
> It just makes our review wrong.
> The durability guarantee (that volatile does not provide) is very different
> from the "reliability" guarantee that it CAN provide.
> We do not want to have to explain to people that "volatile" provided different
> guarantees depending on the kernel they are running.
> Fixing syncfs/fsync of volatile is much more important IMO than erroring
> on other fs ops post writeback error, because other fs ops are equally
> unreliable on any filesystem in case application did not do fsync.
>
> Ignoring the factor of "backporting cost" when there is no engineering
> justification to do so is just ignoring the pain of others.
> Do you have an engineering argument for objecting this patch is
> applied before your fixes to syncfs vfs API?
>
> Sargun,
>
> Please add Fixes/Stable #v5.10 tags.
>
> Thanks,
> Amir.

I was going to send the patch to stable once it was picked up in
the unionfs tree. I will resend / re-roll with a CC to stable.
