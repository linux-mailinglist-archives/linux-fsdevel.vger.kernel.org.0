Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68B260A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 11:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfEVJmD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 05:42:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728609AbfEVJmC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 05:42:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50B87AE65;
        Wed, 22 May 2019 09:42:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 217AA1E3C69; Wed, 22 May 2019 11:42:01 +0200 (CEST)
Date:   Wed, 22 May 2019 11:42:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: Disallow permission events for proc filesystem
Message-ID: <20190522094201.GF17019@quack2.suse.cz>
References: <20190515193337.11167-1-jack@suse.cz>
 <CAOQ4uxhKV9qXGDA6PuCKrbBjM_f2ed_XScY3KkWVX8PXzwCwCA@mail.gmail.com>
 <20190516083632.GC13274@quack2.suse.cz>
 <20190521215716.GB20383@neo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521215716.GB20383@neo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 22-05-19 07:57:18, Matthew Bobrowski wrote:
> On Thu, May 16, 2019 at 10:36:32AM +0200, Jan Kara wrote:
> > On Thu 16-05-19 08:54:37, Amir Goldstein wrote:
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/notify/fanotify/fanotify_user.c | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > > index a90bb19dcfa2..73719949faa6 100644
> > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > @@ -920,6 +920,20 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> > > >         return 0;
> > > >  }
> > > >
> > > > +static int fanotify_events_supported(struct path *path, __u64 mask)
> > > > +{
> > > > +       /*
> > > > +        * Proc is special and various files have special locking rules so
> > > > +        * fanotify permission events have high chances of deadlocking the
> > > > +        * system. Just disallow them.
> > > > +        */
> > > > +       if (mask & FANOTIFY_PERM_EVENTS &&
> > > > +           !strcmp(path->mnt->mnt_sb->s_type->name, "proc")) {
> > > 
> > > Better use an SB_I_ flag to forbid permission events on fs?
> > 
> > So checking s_type->name indeed felt dirty. I don't think we need a
> > superblock flag though. I'll probably just go with FS_XXX flag in
> > file_system_type.
> 
> Would the same apply for some files that backed by sysfs and reside in
> /sys?

So far I'm not aware of similar easy to trigger deadlocks with sysfs. So I
opted for a cautious path and disabled permission events only for proc.
We'll see how that fares.

> > > > +               return -EOPNOTSUPP;
> > > 
> > > I would go with EINVAL following precedent of per filesystem flags
> > > check on rename(2), but not insisting.
> > 
> > I was undecided between EOPNOTSUPP and EINVAL. So let's go with EINVAL.
> 
> I was also thinking that EINVAL makes more sense in this particular
> case.

Good, that's what I used in v2.

> > > Anyway, following Matthew's man page update for FAN_REPORT_FID,
> > > we should also add this as reason for EOPNOTSUPP/EINVAL.
> > 
> > Good point.
> 
> I've followed up Michael in regards to the FAN_REPORT_FID patch series,
> but no response as of yet. I'm happy to write the changes for this one
> if you like?

If you had time for that, that would be nice. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
