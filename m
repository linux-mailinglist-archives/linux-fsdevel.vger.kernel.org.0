Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2142120161
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEPIge (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 04:36:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:59022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfEPIgd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 04:36:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D69BCAE2C;
        Thu, 16 May 2019 08:36:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 98F761E3ED6; Thu, 16 May 2019 10:36:32 +0200 (CEST)
Date:   Thu, 16 May 2019 10:36:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] fanotify: Disallow permission events for proc filesystem
Message-ID: <20190516083632.GC13274@quack2.suse.cz>
References: <20190515193337.11167-1-jack@suse.cz>
 <CAOQ4uxhKV9qXGDA6PuCKrbBjM_f2ed_XScY3KkWVX8PXzwCwCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhKV9qXGDA6PuCKrbBjM_f2ed_XScY3KkWVX8PXzwCwCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-05-19 08:54:37, Amir Goldstein wrote:
> On Wed, May 15, 2019 at 10:33 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Proc filesystem has special locking rules for various files. Thus
> > fanotify which opens files on event delivery can easily deadlock
> > against another process that waits for fanotify permission event to be
> > handled. Since permission events on /proc have doubtful value anyway,
> > just disallow them.
> >
> 
> Let's add context:
> Link: https://lore.kernel.org/linux-fsdevel/20190320131642.GE9485@quack2.suse.cz/

OK, will add.

> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index a90bb19dcfa2..73719949faa6 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -920,6 +920,20 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> >         return 0;
> >  }
> >
> > +static int fanotify_events_supported(struct path *path, __u64 mask)
> > +{
> > +       /*
> > +        * Proc is special and various files have special locking rules so
> > +        * fanotify permission events have high chances of deadlocking the
> > +        * system. Just disallow them.
> > +        */
> > +       if (mask & FANOTIFY_PERM_EVENTS &&
> > +           !strcmp(path->mnt->mnt_sb->s_type->name, "proc")) {
> 
> Better use an SB_I_ flag to forbid permission events on fs?

So checking s_type->name indeed felt dirty. I don't think we need a
superblock flag though. I'll probably just go with FS_XXX flag in
file_system_type.

> 
> > +               return -EOPNOTSUPP;
> 
> I would go with EINVAL following precedent of per filesystem flags
> check on rename(2), but not insisting.

I was undecided between EOPNOTSUPP and EINVAL. So let's go with EINVAL.

> Anyway, following Matthew's man page update for FAN_REPORT_FID,
> we should also add this as reason for EOPNOTSUPP/EINVAL.

Good point.

Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
