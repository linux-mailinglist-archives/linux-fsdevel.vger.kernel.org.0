Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357AA170159
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 15:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgBZOiq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 09:38:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:33900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgBZOiq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:38:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 408DDAC69;
        Wed, 26 Feb 2020 14:38:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CD8091E0EA2; Wed, 26 Feb 2020 15:38:43 +0100 (CET)
Date:   Wed, 26 Feb 2020 15:38:43 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 08/16] fanotify: merge duplicate events on parent and
 child
Message-ID: <20200226143843.GT10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-9-amir73il@gmail.com>
 <20200226091804.GD10728@quack2.suse.cz>
 <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 14:14:50, Amir Goldstein wrote:
> On Wed, Feb 26, 2020 at 11:18 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 17-02-20 15:14:47, Amir Goldstein wrote:
> > > With inotify, when a watch is set on a directory and on its child, an
> > > event on the child is reported twice, once with wd of the parent watch
> > > and once with wd of the child watch without the filename.
> > >
> > > With fanotify, when a watch is set on a directory and on its child, an
> > > event on the child is reported twice, but it has the exact same
> > > information - either an open file descriptor of the child or an encoded
> > > fid of the child.
> > >
> > > The reason that the two identical events are not merged is because the
> > > tag used for merging events in the queue is the child inode in one event
> > > and parent inode in the other.
> > >
> > > For events with path or dentry data, use the dentry instead of inode as
> > > the tag for event merging, so that the event reported on parent will be
> > > merged with the event reported on the child.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > I agree that reporting identical event twice seems wasteful but ...
> >
> > > @@ -312,7 +313,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> > >       if (!event)
> > >               goto out;
> > >  init: __maybe_unused
> > > -     fsnotify_init_event(&event->fse, inode);
> > > +     /*
> > > +      * Use the dentry instead of inode as tag for event queue, so event
> > > +      * reported on parent is merged with event reported on child when both
> > > +      * directory and child watches exist.
> > > +      */
> > > +     fsnotify_init_event(&event->fse, (void *)dentry ?: inode);
> >
> > ... this seems quite ugly and also previously we could merge 'inode' events
> > with others and now we cannot because some will carry "dentry where event
> > happened" and other ones "inode with watch" as object identifier. So if you
> > want to do this, I'd use "inode where event happened" as object identifier
> > for fanotify.
> 
> <scratch head> Why didn't I think of that?...
> 
> I suppose you mean to just use:
> 
>      fsnotify_init_event(&event->fse, id);

Yes.

> > Hum, now thinking about this, maybe we could clean this up even a bit more.
> > event->inode is currently used only by inotify and fanotify for merging
> > purposes. Now inotify could use its 'wd' instead of inode with exactly the
> > same results, fanotify path or fid check is at least as strong as the inode
> > check. So only for the case of pure "inode" events, we need to store inode
> > identifier in struct fanotify_event - and we can do that in the union with
> > struct path and completely remove the 'inode' member from fsnotify_event.
> > Am I missing something?
> 
> That generally sounds good and I did notice it is strange that wd is not
> being compared.  However, I think I was worried that comparing fid+name
> (in following patches) would be more expensive than comparing dentry (or
> object inode) as a "rule out first" in merge, so I preferred to keep the
> tag/dentry/id comparison for fanotify_fid case.

Yes, that could be a concern.
 
> Given this analysis (and assuming it is correct), would you like me to
> just go a head with the change suggested above? or anything beyond that?

Let's go just with the change suggested above for now. We can work on this
later (probably with optimizing of the fanotify merging code).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
