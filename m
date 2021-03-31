Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4234FE6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhCaK51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 06:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbhCaK5M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:57:12 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0CBC061574;
        Wed, 31 Mar 2021 03:57:12 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id u2so16825714ilk.1;
        Wed, 31 Mar 2021 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dElUpclszfmuTzdAJR3Bfu932OnRJH6x2FQDa8QtJL4=;
        b=FerCr8EPtI0zidGhTWSgpjD4X/nDK3LnZMveCkZ4z/arBcnQ4/sKtq9dLnfSRyox0X
         gunAPTykB/Yz2uqBh4mwTYUd3GqDoNNPKsGmGSxPaPu1R93NMJp4HlD+V1xKauBvUn/b
         z8HHc2UUafT4jSqGLH8JIU3eVAMQ4TMI52CaRZ9mYYDio/zz9htPnxF9w9ddz30NO/Gd
         gkpnEXKpYbdRWa0p6vErLwa5VWYLqsvPwaOYFs2n4KtYbjHxK7n9lgdJ/yLvo1POC9L4
         ahF/6DIjpiqpdDnB7u87LYX6uUJeu1nlZbjYTjdEOQNgRmjDD7qBjXxD/MuNMGl8HChY
         /RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dElUpclszfmuTzdAJR3Bfu932OnRJH6x2FQDa8QtJL4=;
        b=C1jqBEFETOBCx+1+SkCp4J1Ein/v/zNJFl151nwQs7GuDFfCxDxJNOUZ8/5g3BQy2o
         I44ws/tOYHWvYAlJGthn3SWsVeNtgdIb2RRfd0zBc3iERKVK47EMLnsNI/gVjxLFnDKi
         Xjzu0sjkqbhxPLL1iPsG119G3/4OhB6AZFQ7Lx+RVA96ZC0ibhZbD7OKmjj1o3WBuYI0
         EcK93ehei/DLMilUwlB0Zjhmea2nPH9xwvx/Llc39UB92Ib0dXZ1MwInzROXQJpFfKPS
         4DFVEAMZskeHQK7FeWGzn7j/bICyVh3ZW5dkrVAfFCqV2o6hlxAKXlk5Q7vUyQCr1GAM
         RJfw==
X-Gm-Message-State: AOAM533Frn8W71MgfzaCiyO8siCd0gsfYWqeCkgibh10TS+jbo5isOA6
        sEVetf3VZs87SY1XhGiyFwQi7mTdsWj+9+ALpE4=
X-Google-Smtp-Source: ABdhPJzNUOaZ9ft9fWBmsrxAFHCXpBCLP/guEUS2TWNPzYyMUz808JIMpJys3CmDxkKn9bzZICGWjSJTXop3T1GtgJM=
X-Received: by 2002:a05:6e02:b2a:: with SMTP id e10mr2195129ilu.9.1617188231798;
 Wed, 31 Mar 2021 03:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com> <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
In-Reply-To: <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 31 Mar 2021 13:57:00 +0300
Message-ID: <CAOQ4uxiEx7YANtoBRrWCM26HA-XpbRcpgB+Nj-Up9-BWL=KHcA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 1:08 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Mar 30, 2021 at 07:24:02PM +0300, Amir Goldstein wrote:
> > On Tue, Mar 30, 2021 at 12:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Mar 30, 2021 at 10:31 AM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > > > > Add a high level hook fsnotify_path_create() which is called from
> > > > > syscall context where mount context is available, so that FAN_CREATE
> > > > > event can be added to a mount mark mask.
> > > > >
> > > > > This high level hook is called in addition to fsnotify_create(),
> > > > > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > > > > context is not available.
> > > > >
> > > > > In the context where fsnotify_path_create() will be called, a dentry flag
> > > > > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > > > > level hooks.
> > > > >
> > > > > This functionality was requested by Christian Brauner to replace
> > > > > recursive inotify watches for detecting when some path was created under
> > > > > an idmapped mount without having to monitor FAN_CREATE events in the
> > > > > entire filesystem.
> > > > >
> > > > > In combination with more changes to allow unprivileged fanotify listener
> > > > > to watch an idmapped mount, this functionality would be usable also by
> > > > > nested container managers.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
> > > > > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > >
> > > > Was about to look at this. Does this require preliminary patches since
> > > > it doesn't apply to current master. If so, can you just give me a link
> > > > to a branch so I can pull from that? :)
> > > >
> > >
> > > The patch is less useful on its own.
> > > Better take the entire work for the demo which includes this patch:
> > >
> > > [1] https://github.com/amir73il/linux/commits/fanotify_userns
> > > [2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns
> > >
> >
> > Christian,
> >
> > Apologies for the fast moving target.
>
> No problem.
>
> > I just force force the kernel+demo branches to include support for
> > the two extra events (delete and move) on mount mark.
>
> Sounds good.
>
> One thing your patch
>
> commit ea31e84fda83c17b88851de399f76f5d9fc1abf4
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Sat Mar 20 12:58:12 2021 +0200
>
>     fs: allow open by file handle inside userns
>
>     open_by_handle_at(2) requires CAP_DAC_READ_SEARCH in init userns,
>     where most filesystems are mounted.
>
>     Relax the requirement to allow a user with CAP_DAC_READ_SEARCH
>     inside userns to open by file handle in filesystems that were
>     mounted inside that userns.
>
>     In addition, also allow open by handle in an idmapped mount, which is
>     mapped to the userns while verifying that the returned open file path
>     is under the root of the idmapped mount.
>
>     This is going to be needed for setting an fanotify mark on a filesystem
>     and watching events inside userns.
>
>     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Requires fs/exportfs/expfs.c to be made idmapped mounts aware.
> open_by_handle_at() uses exportfs_decode_fh() which e.g. has the
> following and other callchains:
>
> exportfs_decode_fh()
> -> exportfs_decode_fh_raw()
>    -> lookup_one_len()
>       -> inode_permission(mnt_userns, ...)
>
> That's not a huge problem though I did all these changes for the
> overlayfs support for idmapped mounts I have in a branch from an earlier
> version of the idmapped mounts patchset. Basically lookup_one_len(),
> lookup_one_len_unlocked(), and lookup_positive_unlocked() need to take
> the mnt_userns into account. I can rebase my change and send it for
> consideration next cycle. If you can live without the
> open_by_handle_at() support for now in this patchset (Which I think you
> said you could.) then it's not a blocker either. Sorry for the
> inconvenience.
>

My preference is that you take this patch through your branch.
I think you will do a much better job than me selling it and arguing for
its correctness.

The ability to setup fanotify marks on idmapped mounts does not
depend on it in any way.
I've only added it to my branch to facilitate the demo, which also
independently resolves the reported fids to paths.

Thanks,
Amir.
