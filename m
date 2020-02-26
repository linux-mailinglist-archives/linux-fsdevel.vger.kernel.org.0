Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF72417057F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgBZRHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 12:07:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:39550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgBZRHI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:07:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1CB0FAE71;
        Wed, 26 Feb 2020 17:07:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 60D431E0EA2; Wed, 26 Feb 2020 18:07:05 +0100 (CET)
Date:   Wed, 26 Feb 2020 18:07:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200226170705.GU10728@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz>
 <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 26-02-20 13:53:06, Amir Goldstein wrote:
> On Wed, Feb 26, 2020 at 12:23 PM Jan Kara <jack@suse.cz> wrote:
> >
> > > +     __kernel_fsid_t fsid;
> > >       union {
> > >               /*
> > >                * We hold ref to this path so it may be dereferenced at any
> >
> > Here I disagree. IMO 'fsid' should be still part of the union below because
> > the "object identification" is either struct path or (fsid + fh). I
> > understand that you want to reuse fsid for the other file handle. But then
> > I believe it should rather be done like:
> >
> > struct fanotify_fh {
> >         union {
> >                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> >                 unsigned char *ext_fh;
> >         };
> > };
> >
> 
> This I will do.
> 
> > struct fanotify_fid {
> >         __kernel_fsid_t fsid;
> >         struct fanotify_fh object;
> >         struct fanotify_fh dir;
> > }
> >
> 
> object and dir do not end up in the same struct.

Right, ok.

> object is in fanotify_event
> dir is in the extended fanotify_name_event, but I can do:
> 
> struct fanotify_fid {
>         __kernel_fsid_t fsid;
>         struct fanotify_fh fh;
> }
> 
>  struct fanotify_event {
>         struct fsnotify_event fse;
>         u32 mask;
>         struct fanotify_fid_hdr fh;
>         struct fanotify_fid_hdr dfh;
>         union {
>                 struct path path;
>                 struct fanotify_fid object;
>         };
>         struct pid *pid;
> };
> 
> struct fanotify_name_event {
>         struct fanotify_event fae;
>         struct fanotify_fh  dir;
>         struct qstr name;
>         unsigned char inline_name[FANOTIFY_INLINE_NAME_LEN];
> };

Looking at this I'm not quite happy either :-| E.g. 'dfh' contents here
somewhat magically tells that this is not fanotify_event but
fanotify_name_event. Also I agree that fsid hidden in 'object' is not ideal
although I still dislike having it directly in fanotify_event as for path
events it will not be filled and that can lead to confusion.

I understand this is so convoluted because there are several constraints:
1) We don't want to grow event size unnecessarily.
2) We prefer allocating from dedicated slab cache
3) We have events of several types needing to store different kind of
information.

But seeing how things evolve I think we should consider relaxing some of
the constraints to make the code easier to follow. How about having
something like:

struct fanotify_event {
	struct fsnotify_event fse;
	u32 mask;
	enum fanotify_event_type type;
	struct pid *pid;
};

where type would identify what kind of event we have. Then we would have

struct fanotify_path_event {
	struct fanotify_event fae;
	struct path path;
};

struct fanotify_perm_path_event {
	struct fanotify_event fae;
	struct path path;
	unsigned short response;
	unsigned short state;
	int fd;
};

struct fanotify_fh {
	u8 type;
	u8 len;
	union {
		unsigned char fh[FANOTIFY_INLINE_FH_LEN];
		unsigned char *ext_fh;
	};
};

struct fanotify_fid_event {
	struct fanotify_event fae;
	__kernel_fsid_t fsid;
	struct fanotify_fh object_fh;
};

struct fanofify_name_event {
	struct fanotify_event fae;
	__kernel_fsid_t fsid;
	struct fanotify_fh object_fh;
	struct fanotify_fh dir_fh;
	u8 name_len;
	char name[0];
};

WRT size, this would grow fanotify_fid_event by 1 long on 64-bits,
fanotify_path_event would be actually smaller by 1 long, fanofify_name_event
would be smaller but that's not really comparable because you chose a
solution with fixed-inline length while I'd just go with allocating from
kmalloc when we have to store the name.

In terms of kmalloc caches, we would need three: for path, perm_path, fid
events, I'd allocate name events from generic kmalloc caches.

So overall I think this would be better. The question is whether the
resulting code will really be more readable. I hope so because the
structures are definitely nicer this way and things belonging logically
together are now together. But you never know until you convert the code...
Would you be willing to try this refactoring?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
