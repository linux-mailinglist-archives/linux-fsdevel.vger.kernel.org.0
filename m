Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5D2CD51C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 13:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgLCMDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 07:03:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:32960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgLCMDl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:03:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AC3FAC90;
        Thu,  3 Dec 2020 12:02:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3B3FA1E12FF; Thu,  3 Dec 2020 13:02:59 +0100 (CET)
Date:   Thu, 3 Dec 2020 13:02:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/7] fsnotify: generalize handle_inode_event()
Message-ID: <20201203120259.GE11854@quack2.suse.cz>
References: <20201202120713.702387-1-amir73il@gmail.com>
 <20201202120713.702387-2-amir73il@gmail.com>
 <20201203095101.GA11854@quack2.suse.cz>
 <CAOQ4uxj4jX9gy2JdJBoExsxA0nsKN1Z21K+yj=a4rkr5_OTxdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj4jX9gy2JdJBoExsxA0nsKN1Z21K+yj=a4rkr5_OTxdQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 03-12-20 12:41:41, Amir Goldstein wrote:
> On Thu, Dec 3, 2020 at 11:51 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 02-12-20 14:07:07, Amir Goldstein wrote:
> > > The handle_inode_event() interface was added as (quoting comment):
> > > "a simple variant of handle_event() for groups that only have inode
> > > marks and don't have ignore mask".
> > >
> > > In other words, all backends except fanotify.  The inotify backend
> > > also falls under this category, but because it required extra arguments
> > > it was left out of the initial pass of backends conversion to the
> > > simple interface.
> > >
> > > This results in code duplication between the generic helper
> > > fsnotify_handle_event() and the inotify_handle_event() callback
> > > which also happen to be buggy code.
> > >
> > > Generalize the handle_inode_event() arguments and add the check for
> > > FS_EXCL_UNLINK flag to the generic helper, so inotify backend could
> > > be converted to use the simple interface.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > The patch looks good to me. Just one curious question below.
> >
> > > +static int fsnotify_handle_inode_event(struct fsnotify_group *group,
> > > +                                    struct fsnotify_mark *inode_mark,
> > > +                                    u32 mask, const void *data, int data_type,
> > > +                                    struct inode *dir, const struct qstr *name,
> > > +                                    u32 cookie)
> > > +{
> > > +     const struct path *path = fsnotify_data_path(data, data_type);
> > > +     struct inode *inode = fsnotify_data_inode(data, data_type);
> > > +     const struct fsnotify_ops *ops = group->ops;
> > > +
> > > +     if (WARN_ON_ONCE(!ops->handle_inode_event))
> > > +             return 0;
> > > +
> > > +     if ((inode_mark->mask & FS_EXCL_UNLINK) &&
> > > +         path && d_unlinked(path->dentry))
> > > +             return 0;
> >
> > When I was looking at this condition I was wondering why do we check
> > d_unlinked() and not inode->i_nlink? When is there a difference?
> 
> When a hardlink has been unlinked.
> inotify gets the filename and it doesn't want to get events with unlinked
> names (although another name could still be linked) I suppose...

OK, fair enough. I didn't think about this case.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
