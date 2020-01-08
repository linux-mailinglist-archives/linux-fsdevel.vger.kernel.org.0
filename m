Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A2134165
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 13:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgAHMEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 07:04:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:36954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgAHMEZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:04:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00B65B275;
        Wed,  8 Jan 2020 12:04:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4485A1E0B47; Wed,  8 Jan 2020 13:04:22 +0100 (CET)
Date:   Wed, 8 Jan 2020 13:04:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20200108120422.GD20521@quack2.suse.cz>
References: <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz>
 <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
 <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
 <20200107171014.GI25547@quack2.suse.cz>
 <CAOQ4uxjx_n3f44yu9_2dGxtBGy3WssG0xfZykwjQ+n=Wcii2-w@mail.gmail.com>
 <20200108090434.GA20521@quack2.suse.cz>
 <CAOQ4uxjPyaMs0dvObkJR49kjf6zga553wEFRsWDBA28Vta-FnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjPyaMs0dvObkJR49kjf6zga553wEFRsWDBA28Vta-FnQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-01-20 12:25:55, Amir Goldstein wrote:
> > > What I like about the fact that users don't need to choose between
> > > 'parent fid' and 'object fid' is that it makes some hard questions go away:
> > > 1. How are "self" events reported? simple - just with 'object id'
> > > 2. How are events on disconnected dentries reported? simple - just
> > > with 'object id'
> > > 3. How are events on the root of the watch reported? same answer
> > >
> > > Did you write 'directory fid' as opposed to 'parent fid' for a reason?
> > > Was it your intention to imply that events on directories (e.g.
> > > open/close/attrib) are
> > > never reported with 'parent fid' , 'name in directory'?
> >
> > Yes, that was what I thought.
> >
> > > I see no functional problem with making that distinction between directory and
> > > non-directory, but I have a feeling that 'parent fid', 'name in
> > > directory', 'object id',
> > > regardless of dir/non-dir is going to be easier to document and less confusing
> > > for users to understand, so this is my preference.
> >
> > Understood. The reason why I decided like this is that for a directory,
> > the parent may be actually on a different filesystem (so generating fid
> > will be more difficult) and also that what you get from dentry->d_parent
> > need not be the dir through which you actually reached the directory (think
> > of bind mounts) which could be a bit confusing. So I have no problem with
> > always providing 'parent fid' if we can give good answers to these
> > questions...
> >
> 
> Actually, my current code in branch fanotify_name already takes care of
> some of those cases and it is rather easy to deal with the bind mount case
> if path is available:
> 
>       if (path && path->mnt->mnt_root != dentry)
>                mnt = real_mount(path->mnt);
> 
>       /* Not reporting parent fid + name for fs root, bind mount root and
>          disconnected dentry */
>       if (!IS_ROOT(dentry) && (!path || mnt))
>                marks_mask |= fsnotify_watches_children(
>                                                dentry->d_sb->s_fsnotify_mask);
>       if (mnt)
>                marks_mask |= fsnotify_watches_children(
>                                                mnt->mnt_fsnotify_mask);
> 
> Note that a non-dir can also be bind mounted, so the concern you raised is
> actually not limited to directories.
> It is true that with the code above, FAN_ATTRIB and FAN_MODIFY (w/o path)
> could still be reported to sb mark with the parent/name under the bind mount,
> but that is not wrong at all IMO - I would say that is the expected behavior for
> a filesystem mark.

Yes, good points.

> IOW, the answer to your question, phrased in man page terminology is:
> (parent fid + name) information is not guarantied to be available except for
> FAN_DIR_MODIFY, but it may be available as extra info in addition to object fid
> for events that are possible on child.
> 
> For example, an application relying on (parent fid + name) information for
> FAN_MODIFY (e.g. for remote mirror) simply cannot get this information when
> nfsd opens a file with a disconnected dentry and writes to it.

And another good point.

> TBH, I am not convinced myself that reporting (parent fid + name) for
> directories
> is indeed easier to document/implement than treating directories different that
> non-directories, but I am going to try and implement it this way and prepare a
> draft man page update to see how it looks - I may yet change my mind after
> going through this process...

Ok, fair enough. I guess you've convinced me that both 'parent fid' and
'directory fid' approaches are somewhat messy so whatever ends up being
simplier / easier to understand is good :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
