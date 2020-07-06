Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C679521560D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgGFLF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 07:05:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:51468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgGFLF2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:05:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B0755AE92;
        Mon,  6 Jul 2020 11:05:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2AF4E1E1311; Mon,  6 Jul 2020 13:05:26 +0200 (CEST)
Date:   Mon, 6 Jul 2020 13:05:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 01/20] fsnotify: Rearrange fast path to minimise overhead
 when there is no watcher
Message-ID: <20200706110526.GA3913@quack2.suse.cz>
References: <20200612093343.5669-1-amir73il@gmail.com>
 <20200612093343.5669-2-amir73il@gmail.com>
 <20200703140342.GD21364@quack2.suse.cz>
 <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 04-07-20 12:30:10, Amir Goldstein wrote:
> On Fri, Jul 3, 2020 at 5:03 PM Jan Kara <jack@suse.cz> wrote:
> > >  /* Notify this dentry's parent about a child's events. */
> > > -int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > > +int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > >                   int data_type)
> > >  {
> > >       struct dentry *parent;
> >
> > Hum, should we actually remove the DCACHE_FSNOTIFY_PARENT_WATCHED check
> > from here when it's moved to fsnotify_parent() inline helper?
> 
> No point.
> It is making a comeback on:
>  fsnotify: send event with parent/name info to sb/mount/non-dir marks

Right, I've noticed that later as well.

> > > @@ -337,13 +331,22 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> > >       if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> > >           (!mnt || !mnt->mnt_fsnotify_marks))
> > >               return 0;
> > > +
> > > +     /* An event "on child" is not intended for a mount/sb mark */
> > > +     marks_mask = to_tell->i_fsnotify_mask;
> > > +     if (!(mask & FS_EVENT_ON_CHILD)) {
> > > +             marks_mask |= sb->s_fsnotify_mask;
> > > +             if (mnt)
> > > +                     marks_mask |= mnt->mnt_fsnotify_mask;
> > > +     }
> > > +
> > >       /*
> > >        * if this is a modify event we may need to clear the ignored masks
> > >        * otherwise return if neither the inode nor the vfsmount/sb care about
> > >        * this type of event.
> > >        */
> > > -     if (!(mask & FS_MODIFY) &&
> > > -         !(test_mask & (to_tell->i_fsnotify_mask | mnt_or_sb_mask)))
> > > +     test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> > > +     if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
> > >               return 0;
> >
> > Otherwise the patch looks good. One observation though: The (mask &
> > FS_MODIFY) check means that all vfs_write() calls end up going through the
> > "slower" path iterating all mark types and checking whether there are marks
> > anyway. That could be relatively simply optimized using a hidden mask flag
> > like FS_ALWAYS_RECEIVE_MODIFY which would be set when there's some mark
> > needing special handling of FS_MODIFY... Not sure if we care enough at this
> > point...
> 
> Yeh that sounds low hanging.
> Actually, I Don't think we need to define a flag for that.
> __fsnotify_recalc_mask() can add FS_MODIFY to the object's mask if needed.

Yes, that would be even more elegant.

> I will take a look at that as part of FS_PRE_MODIFY work.
> But in general, we should fight the urge to optimize theoretic
> performance issues...

Agreed. I just suspect this may bring measurable benefit for hackbench pipe
or tiny tmpfs writes after seeing Mel's results. But as I wrote this is a
separate idea and without some numbers confirming my suspicion I don't
think the complication is worth it so I don't want you to burn time on this
unless you're really interested :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
