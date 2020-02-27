Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C659F171595
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgB0LBP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:01:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:50282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728744AbgB0LBO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:01:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 586DBAB3D;
        Thu, 27 Feb 2020 11:01:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 681191E0F04; Thu, 27 Feb 2020 12:01:05 +0100 (CET)
Date:   Thu, 27 Feb 2020 12:01:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200227110105.GY10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz>
 <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz>
 <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 19:50:30, Amir Goldstein wrote:
> On Wed, Feb 26, 2020 at 7:07 PM Jan Kara <jack@suse.cz> wrote:
> > Looking at this I'm not quite happy either :-| E.g. 'dfh' contents here
> > somewhat magically tells that this is not fanotify_event but
> > fanotify_name_event. Also I agree that fsid hidden in 'object' is not ideal
> > although I still dislike having it directly in fanotify_event as for path
> > events it will not be filled and that can lead to confusion.
> >
> > I understand this is so convoluted because there are several constraints:
> > 1) We don't want to grow event size unnecessarily.
> > 2) We prefer allocating from dedicated slab cache
> > 3) We have events of several types needing to store different kind of
> > information.
> >
> > But seeing how things evolve I think we should consider relaxing some of
> > the constraints to make the code easier to follow. How about having
> > something like:
> >
> > struct fanotify_event {
> >         struct fsnotify_event fse;
> >         u32 mask;
> >         enum fanotify_event_type type;
> >         struct pid *pid;
> > };
> >
> > where type would identify what kind of event we have. Then we would have
> >
> > struct fanotify_path_event {
> >         struct fanotify_event fae;
> >         struct path path;
> > };
> >
> > struct fanotify_perm_path_event {
> >         struct fanotify_event fae;
> >         struct path path;
> 
> Any reason not to "inherit" from fanotify_path_event?
> There is code that is generic to permission and non-permission path
> events that accesses event->path and I wouldn't
> want to make that code two cases instead of just one.

I'm OK with that if it works better for you. I was just thinking that we'll
have a helper like:

struct path *fanotify_event_path(struct fanotify_event *event)
{
	if (event->type == FA_PATH_EVENT)
		return ((struct fanotify_path_event *)event)->path;
	else if (event->type == FA_PERM_PATH_EVENT)
		return ((struct fanotify_perm_path_event *)event)->path;
	else
		return NULL;
}

and thus in most of code all the type details could be abstracted by this
helper and so there won't be reason for "intermediate" types. But as I
wrote above if you find good use for them, I'm OK with that.

> >         unsigned short response;
> >         unsigned short state;
> >         int fd;
> > };
> >
> > struct fanotify_fh {
> >         u8 type;
> >         u8 len;
> 
> That's a 6 bytes hole! and then there are two of those
> in object_fh and dir_fh.
> That is why I stored the header in separate from the fh itself
> so that two headers could pack up nicely and yes,
> I also used the headers as an event type indication.

Yes, I know but this packing of loosely related things is exactly what makes
the code difficult to follow... 

> >         union {
> >                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> >                 unsigned char *ext_fh;
> >         };
> > };
> >
> > struct fanotify_fid_event {
> >         struct fanotify_event fae;
> >         __kernel_fsid_t fsid;
> >         struct fanotify_fh object_fh;
> > };
> >
> > struct fanofify_name_event {
> >         struct fanotify_event fae;
> >         __kernel_fsid_t fsid;
> >         struct fanotify_fh object_fh;
> 
> Again, any reason not to "inherit" from fanotify_fid_event?
> There is plenty of code that is common to fid and name events
> because name events are also fid events.

We could if the helper functions do not abstract the difference enough...

> >         struct fanotify_fh dir_fh;
> >         u8 name_len;
> >         char name[0];
> > };
> >
> > WRT size, this would grow fanotify_fid_event by 1 long on 64-bits,
> > fanotify_path_event would be actually smaller by 1 long, fanofify_name_event
> > would be smaller but that's not really comparable because you chose a
> > solution with fixed-inline length while I'd just go with allocating from
> > kmalloc when we have to store the name.
> 
> OK. Same an inotify.
> I guess I started with the name_snapshot thing that was really fixed-size
> event and then reused the same construct without the snapshot, but I
> guess we can do away with the inline name.
> 
> > In terms of kmalloc caches, we would need three: for path, perm_path, fid
> > events, I'd allocate name events from generic kmalloc caches.
> >
> > So overall I think this would be better. The question is whether the
> > resulting code will really be more readable. I hope so because the
> > structures are definitely nicer this way and things belonging logically
> > together are now together. But you never know until you convert the code...
> > Would you be willing to try this refactoring?
> 
> Yes, but I would like to know what you think about the two 6 byte holes
> Just let that space be wasted for the sake of nicer abstraction?
> It seems like too much to me.

Well, it's wasting 1 long per FID event (i.e., 72 vs 64 bytes on 64-bits if
I'm counting right) compared to the tight packing we had previously. I'd
say that's bearable.

For name events we are wasting two longs per event compared to the tightest
packing I can imagine (i.e., 97+name vs 81+name). That's bad enough but I
can live with that for now...

We could actually improve packing of name events by declaring handle as:

struct fanotify_fh {
	u8 type;
	u8 len;
	u8 fh[FANOTIFY_INLINE_FH_LEN];
};

This is a structure that has no padding requirements and so if we place two
next to each other they will use just 36 bytes instead of 48. But then we
have to play games with hiding pointer inside 'fh' like:

char **fh_ext_ptr(struct fanotify_fh *fh)
{
	return (char **)ALIGN((unsigned long)(fh->fh), __alignof__(char *));
}

Probably it's worth it but I wouldn't bother for this series if you don't
want to.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
