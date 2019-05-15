Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1C1F0A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfEOLpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 07:45:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45278 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729557AbfEOLpn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 07:45:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8DC13AF46;
        Wed, 15 May 2019 11:45:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82A571E3CA1; Wed, 15 May 2019 13:45:39 +0200 (CEST)
Date:   Wed, 15 May 2019 13:45:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC][PATCH 4/4] fsnotify: move fsnotify_nameremove() hook out
 of d_delete()
Message-ID: <20190515114539.GC7418@quack2.suse.cz>
References: <20190514221901.29125-1-amir73il@gmail.com>
 <20190514221901.29125-5-amir73il@gmail.com>
 <20190515082407.GD11965@quack2.suse.cz>
 <CAOQ4uxgP3BaEoYEHoCKHxeueG=eZjxfgD3=sJUfhqSk7xKV47g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgP3BaEoYEHoCKHxeueG=eZjxfgD3=sJUfhqSk7xKV47g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-05-19 13:56:47, Amir Goldstein wrote:
> On Wed, May 15, 2019 at 11:24 AM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > > index 8c7cbac7183c..5433e37fb0c5 100644
> > > --- a/fs/notify/fsnotify.c
> > > +++ b/fs/notify/fsnotify.c
> > > @@ -107,47 +107,6 @@ void fsnotify_sb_delete(struct super_block *sb)
> > >       fsnotify_clear_marks_by_sb(sb);
> > >  }
> > >
> > > -/*
> > > - * fsnotify_nameremove - a filename was removed from a directory
> > > - *
> > > - * This is mostly called under parent vfs inode lock so name and
> > > - * dentry->d_parent should be stable. However there are some corner cases where
> > > - * inode lock is not held. So to be on the safe side and be reselient to future
> > > - * callers and out of tree users of d_delete(), we do not assume that d_parent
> > > - * and d_name are stable and we use dget_parent() and
> > > - * take_dentry_name_snapshot() to grab stable references.
> > > - */
> > > -void fsnotify_nameremove(struct dentry *dentry, int isdir)
> > > -{
> > > -     struct dentry *parent;
> > > -     struct name_snapshot name;
> > > -     __u32 mask = FS_DELETE;
> > > -
> > > -     /* d_delete() of pseudo inode? (e.g. __ns_get_path() playing tricks) */
> > > -     if (IS_ROOT(dentry))
> > > -             return;
> > > -
> > > -     if (isdir)
> > > -             mask |= FS_ISDIR;
> > > -
> > > -     parent = dget_parent(dentry);
> > > -     /* Avoid unneeded take_dentry_name_snapshot() */
> > > -     if (!(d_inode(parent)->i_fsnotify_mask & FS_DELETE) &&
> > > -         !(dentry->d_sb->s_fsnotify_mask & FS_DELETE))
> > > -             goto out_dput;
> > > -
> > > -     take_dentry_name_snapshot(&name, dentry);
> > > -
> > > -     fsnotify(d_inode(parent), mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
> > > -              &name.name, 0);
> > > -
> > > -     release_dentry_name_snapshot(&name);
> > > -
> > > -out_dput:
> > > -     dput(parent);
> > > -}
> > > -EXPORT_SYMBOL(fsnotify_nameremove);
> > > -
> > >  /*
> > >   * Given an inode, first check if we care what happens to our children.  Inotify
> > >   * and dnotify both tell their parents about events.  If we care about any event
> > > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > > index 455dff82595e..7f68cb9825dd 100644
> > > --- a/include/linux/fsnotify.h
> > > +++ b/include/linux/fsnotify.h
> > > @@ -158,10 +158,15 @@ static inline void fsnotify_vfsmount_delete(struct vfsmount *mnt)
> > >   */
> > >  static inline void fsnotify_remove(struct inode *dir, struct dentry *dentry)
> > >  {
> > > +     __u32 mask = FS_DELETE;
> > > +
> > >       /* Expected to be called before d_delete() */
> > >       WARN_ON_ONCE(d_is_negative(dentry));
> > >
> > > -     /* TODO: call fsnotify_dirent() */
> > > +     if (d_is_dir(dentry))
> > > +             mask |= FS_ISDIR;
> > > +
> > > +     fsnotify_dirent(dir, dentry, mask);
> > >  }
> >
> > With folding patch 2 into this patch, I'd leave fsnotify changes for a
> > separate patch. I.e., keep fsnotify_nameremove() as is in this patch just
> > change its callsites and then simplify fsnotify_nameremove() in the next
> > patch.
> >
> 
> I agree we should leave simplifying fsontify hook to last patch, but
> I *would* like to add new hook name(s) and discard the old hook, because:
> 1. I hate the moniker nameremove
> 2. fsnotify_nameremove() args are incompatible with similar hooks
> 3. Will allow me to write individual patches for btrfs, devpty, configfs
> 4. I'd like to suggest fsnotify_rmdir/fsnotify_unlink to pair with
>     fsnotify_mkdir/fsnotify_create
> 
> - I can start with empty hooks.
> - Then add new hooks to all chosen call sites
> - Then move fsnotify_nameremove() from d_delete() into
>   fsnotify_rmdir/fsnotify_unlink.
> - Finally, simply fsnotify_rmdir/fsnotify_unlink to use fsnotify_dirent()
>   and kill the complicated fsnotify_nameremove().

This sounds OK to me as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
