Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D369834FDCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhCaKJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 06:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234916AbhCaKI7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A540661959;
        Wed, 31 Mar 2021 10:08:57 +0000 (UTC)
Date:   Wed, 31 Mar 2021 12:08:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 07:24:02PM +0300, Amir Goldstein wrote:
> On Tue, Mar 30, 2021 at 12:31 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Mar 30, 2021 at 10:31 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > > > Add a high level hook fsnotify_path_create() which is called from
> > > > syscall context where mount context is available, so that FAN_CREATE
> > > > event can be added to a mount mark mask.
> > > >
> > > > This high level hook is called in addition to fsnotify_create(),
> > > > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > > > context is not available.
> > > >
> > > > In the context where fsnotify_path_create() will be called, a dentry flag
> > > > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > > > level hooks.
> > > >
> > > > This functionality was requested by Christian Brauner to replace
> > > > recursive inotify watches for detecting when some path was created under
> > > > an idmapped mount without having to monitor FAN_CREATE events in the
> > > > entire filesystem.
> > > >
> > > > In combination with more changes to allow unprivileged fanotify listener
> > > > to watch an idmapped mount, this functionality would be usable also by
> > > > nested container managers.
> > > >
> > > > Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
> > > > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > >
> > > Was about to look at this. Does this require preliminary patches since
> > > it doesn't apply to current master. If so, can you just give me a link
> > > to a branch so I can pull from that? :)
> > >
> >
> > The patch is less useful on its own.
> > Better take the entire work for the demo which includes this patch:
> >
> > [1] https://github.com/amir73il/linux/commits/fanotify_userns
> > [2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns
> >
> 
> Christian,
> 
> Apologies for the fast moving target.

No problem.

> I just force force the kernel+demo branches to include support for
> the two extra events (delete and move) on mount mark.

Sounds good.

One thing your patch

commit ea31e84fda83c17b88851de399f76f5d9fc1abf4
Author: Amir Goldstein <amir73il@gmail.com>
Date:   Sat Mar 20 12:58:12 2021 +0200

    fs: allow open by file handle inside userns

    open_by_handle_at(2) requires CAP_DAC_READ_SEARCH in init userns,
    where most filesystems are mounted.

    Relax the requirement to allow a user with CAP_DAC_READ_SEARCH
    inside userns to open by file handle in filesystems that were
    mounted inside that userns.

    In addition, also allow open by handle in an idmapped mount, which is
    mapped to the userns while verifying that the returned open file path
    is under the root of the idmapped mount.

    This is going to be needed for setting an fanotify mark on a filesystem
    and watching events inside userns.

    Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Requires fs/exportfs/expfs.c to be made idmapped mounts aware.
open_by_handle_at() uses exportfs_decode_fh() which e.g. has the
following and other callchains:

exportfs_decode_fh()
-> exportfs_decode_fh_raw()
   -> lookup_one_len()
      -> inode_permission(mnt_userns, ...)

That's not a huge problem though I did all these changes for the
overlayfs support for idmapped mounts I have in a branch from an earlier
version of the idmapped mounts patchset. Basically lookup_one_len(),
lookup_one_len_unlocked(), and lookup_positive_unlocked() need to take
the mnt_userns into account. I can rebase my change and send it for
consideration next cycle. If you can live without the
open_by_handle_at() support for now in this patchset (Which I think you
said you could.) then it's not a blocker either. Sorry for the
inconvenience.

Christian
