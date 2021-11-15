Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D8244FFF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhKOIVe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 03:21:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58592 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhKOIVb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:21:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 92168212C7;
        Mon, 15 Nov 2021 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636964315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ccqE4c3gCLqg8d20v5wXjWVxcM3BQIYb0Eqb0qrzUs=;
        b=C3PbvdUoekdI0t26f4z34wTHyEkH33oecYnZCMqcssmIiy/azZlw2hvBnIWqXyNSEG220I
        6rXSCcwGz/+BZ28fTLSlKW70ugY+x0Q2Jb4545Z0iAVae00A15+K6LIEbF83TfVGaWCjrz
        9a0yMvyI+bJVmgu3puL6VsaSTl1SAEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636964315;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ccqE4c3gCLqg8d20v5wXjWVxcM3BQIYb0Eqb0qrzUs=;
        b=MiNd8ZIyoH68GB/58lDW/g4X7Sg7yowNmn515wGOzpf15Rfx3SVEjWxBfuKdzOYf1O/4Wk
        0macx8WIONLDH5Dg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 7C408A3B85;
        Mon, 15 Nov 2021 08:18:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3F1C21E0BEB; Mon, 15 Nov 2021 09:18:35 +0100 (CET)
Date:   Mon, 15 Nov 2021 09:18:35 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/7] fanotify: record new parent and name in MOVED_FROM
 event
Message-ID: <20211115081835.GA23412@quack2.suse.cz>
References: <20211029114028.569755-1-amir73il@gmail.com>
 <20211029114028.569755-6-amir73il@gmail.com>
 <20211112164824.GB30295@quack2.suse.cz>
 <CAOQ4uxgHSiksnkg1TARxcpddnqD5yzreoh4NiWLk+Q+nOO+Duw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgHSiksnkg1TARxcpddnqD5yzreoh4NiWLk+Q+nOO+Duw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 13-11-21 11:40:39, Amir Goldstein wrote:
> On Fri, Nov 12, 2021 at 6:48 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 29-10-21 14:40:26, Amir Goldstein wrote:
> > > In the special case of MOVED_FROM event, if we are recording the child
> > > fid due to FAN_REPORT_TARGET_FID init flag, we also record the new
> > > parent and name.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ...
> > > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > > index 795bedcb6f9b..d1adcb3437c5 100644
> > > --- a/fs/notify/fanotify/fanotify.c
> > > +++ b/fs/notify/fanotify/fanotify.c
> > > @@ -592,21 +592,30 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
> > >                                                       __kernel_fsid_t *fsid,
> > >                                                       const struct qstr *name,
> > >                                                       struct inode *child,
> > > +                                                     struct dentry *moved,
> > >                                                       unsigned int *hash,
> > >                                                       gfp_t gfp)
> > >  {
> > >       struct fanotify_name_event *fne;
> > >       struct fanotify_info *info;
> > >       struct fanotify_fh *dfh, *ffh;
> > > +     struct inode *dir2 = moved ? d_inode(moved->d_parent) : NULL;
> >
> > I think we need to be more careful here (like dget_parent()?). Fsnotify is
> > called after everything is unlocked after rename so dentry can be changing
> > under us, cannot it? Also does that mean that we could actually get a wrong
> > parent here if the dentry is renamed immediately after we unlock things and
> > before we report fsnotify event?
> 
> fsnotify_move() is called inside lock_rename() (both old_dir and new_dir locks),
> which are held by the caller of vfs_rename(), and prevent d_parent/d_name
> changes to child dentries, so moved->d_parent is stable here.
> You are probably confusing with inode_unlock(target), which is the
> child inode lock.
> 
> d_parent/d_name are also stable for fsnotify_create/link/unlink/mkdir/rmdir
> per the vfs locking rules for those operations. In all those cases, the parent
> dir lock is held for vfs helper callers.
> This is why we can use dentry->d_name (and moved->d_name) in all those
> fsnotify hooks.

Bah, you're right. I got confused by the locking of source and target
inside vfs_rename() but those are not parent directories but rather "files"
being renamed from / two. Sorry for the noise.

								Honza

> 
> Thanks,
> Amir.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
