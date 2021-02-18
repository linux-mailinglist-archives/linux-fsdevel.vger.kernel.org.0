Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4331EA23
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhBRM6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:58:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:33862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232333AbhBRMEW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:04:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7DA8ACE5;
        Thu, 18 Feb 2021 11:11:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6BCC51E0F3B; Thu, 18 Feb 2021 12:11:36 +0100 (CET)
Date:   Thu, 18 Feb 2021 12:11:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 6/7] fanotify: mix event info into merge key hash
Message-ID: <20210218111136.GA16953@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-7-amir73il@gmail.com>
 <20210216153943.GD21108@quack2.suse.cz>
 <CAOQ4uxhpJ=pNsKTpRwGYUancosdLRNaf596he4Ykmd8u=fPFBw@mail.gmail.com>
 <CAOQ4uxg0LfHaJz5t6a=4=OF26_+4ZfPAhB7vcj7xD0wBD7dAmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg0LfHaJz5t6a=4=OF26_+4ZfPAhB7vcj7xD0wBD7dAmA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-02-21 12:46:48, Amir Goldstein wrote:
> On Wed, Feb 17, 2021 at 12:13 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > @@ -154,7 +162,10 @@ static inline void fanotify_init_event(struct fanotify_event *event,
> > > >
> > > >  struct fanotify_fid_event {
> > > >       struct fanotify_event fae;
> > > > -     __kernel_fsid_t fsid;
> > > > +     union {
> > > > +             __kernel_fsid_t fsid;
> > > > +             void *fskey;    /* 64 or 32 bits of fsid used for salt */
> > > > +     };
> > > >       struct fanotify_fh object_fh;
> > > >       /* Reserve space in object_fh.buf[] - access with fanotify_fh_buf() */
> > > >       unsigned char _inline_fh_buf[FANOTIFY_INLINE_FH_LEN];
> > > > @@ -168,7 +179,10 @@ FANOTIFY_FE(struct fanotify_event *event)
> > > >
> > > >  struct fanotify_name_event {
> > > >       struct fanotify_event fae;
> > > > -     __kernel_fsid_t fsid;
> > > > +     union {
> > > > +             __kernel_fsid_t fsid;
> > > > +             void *fskey;    /* 64 or 32 bits of fsid used for salt */
> > > > +     };
> > > >       struct fanotify_info info;
> > > >  };
> > >
> > > What games are you playing here with the unions? I presume you can remove
> > > these 'fskey' unions and just use (void *)(event->fsid) at appropriate
> > > places? IMO much more comprehensible...
> >
> 
> FYI, this is what the open coded conversion looks like:
> 
> (void *)*(long *)event->fsid.val

Not great but at least fairly localized. I'd just note that this doesn't quite
work on 32-bit archs (sizeof(long) != sizeof(__kernel_fsid_t) there). Maybe
we could just use

hash_32(event->fsid.val[0]) ^ hash_32(event->fsid.val[1])

for mixing into the 'key' value and thus avoid all these games?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
