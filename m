Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B784622E6DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgG0HoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 03:44:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgG0HoU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:44:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 460E8AAC5;
        Mon, 27 Jul 2020 07:44:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D38C81E12C5; Mon, 27 Jul 2020 09:44:17 +0200 (CEST)
Date:   Mon, 27 Jul 2020 09:44:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fsnotify: minimise overhead when there are no marks related to sb
Message-ID: <20200727074417.GB23179@quack2.suse.cz>
References: <20200612093343.5669-1-amir73il@gmail.com>
 <20200612093343.5669-2-amir73il@gmail.com>
 <20200703140342.GD21364@quack2.suse.cz>
 <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
 <20200706110526.GA3913@quack2.suse.cz>
 <CAOQ4uxi5Zpp7rCKdOkdw9Nkd=uGC-K2AuLqOFc0WQc_CgJQP2Q@mail.gmail.com>
 <CAOQ4uxgYpufPyhivOQyEhUQ0g+atKLwAAuefkSwaWXYAyMgw5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgYpufPyhivOQyEhUQ0g+atKLwAAuefkSwaWXYAyMgw5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 26-07-20 18:20:26, Amir Goldstein wrote:
> On Thu, Jul 9, 2020 at 8:56 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > > Otherwise the patch looks good. One observation though: The (mask &
> > > > > FS_MODIFY) check means that all vfs_write() calls end up going through the
> > > > > "slower" path iterating all mark types and checking whether there are marks
> > > > > anyway. That could be relatively simply optimized using a hidden mask flag
> > > > > like FS_ALWAYS_RECEIVE_MODIFY which would be set when there's some mark
> > > > > needing special handling of FS_MODIFY... Not sure if we care enough at this
> > > > > point...
> > > >
> > > > Yeh that sounds low hanging.
> > > > Actually, I Don't think we need to define a flag for that.
> > > > __fsnotify_recalc_mask() can add FS_MODIFY to the object's mask if needed.
> > >
> > > Yes, that would be even more elegant.
> > >
> > > > I will take a look at that as part of FS_PRE_MODIFY work.
> > > > But in general, we should fight the urge to optimize theoretic
> > > > performance issues...
> > >
> > > Agreed. I just suspect this may bring measurable benefit for hackbench pipe
> > > or tiny tmpfs writes after seeing Mel's results. But as I wrote this is a
> > > separate idea and without some numbers confirming my suspicion I don't
> > > think the complication is worth it so I don't want you to burn time on this
> > > unless you're really interested :).
> > >
> >
> > You know me ;-)
> > FS_MODIFY optimization pushed to fsnotify_pre_modify branch.
> > Only tested that LTP tests pass.
> >
> > Note that this is only expected to improve performance in case there *are*
> > marks, but not marks with ignore mask, because there is an earlier
> > optimization in fsnotify() for the no marks case.
> >
> 
> Hi Mel,
> 
> After following up on Jan's suggestion above, I realized there is another
> low hanging optimization we can make.
> 
> As you may remember, one of the solutions we considered was to exclude
> special or internal sb's from notifications based on some SB flag, but making
> assumptions about which sb are expected to provide notifications turned out
> to be a risky game.
> 
> We can however, keep a counter on sb to *know* there are no watches
> on any object in this sb, so the test:
> 
>         if (!sb->s_fsnotify_marks &&
>             (!mnt || !mnt->mnt_fsnotify_marks) &&
>             (!inode || !inode->i_fsnotify_marks))
>                 return 0;
> 
> Which is not so nice for inlining, can be summarized as:
> 
>         if (atomic_long_read(&inode->i_sb->s_fsnotify_obj_refs) == 0)
>                 return 0;
> 
> Which is nicer for inlining.

That's a nice idea. I was just wondering why do you account only inode
references in the superblock. Because if there's only say mount watch,
s_fsnotify_obj_refs will be 0 and you will wrongly skip reporting. Or am I
misunderstanding something? I'd rather have counter like
sb->s_fsnotify_connectors, that will account all connectors related to the
superblock - i.e., connectors attached to the superblock, mounts referring
to the superblock, or inodes referring to the superblock...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
