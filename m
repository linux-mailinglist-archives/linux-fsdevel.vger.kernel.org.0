Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCA731D86B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 12:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbhBQLag (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 06:30:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:47884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231904AbhBQL0W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:26:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5C261B125;
        Wed, 17 Feb 2021 11:25:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 018071E0871; Wed, 17 Feb 2021 12:25:39 +0100 (CET)
Date:   Wed, 17 Feb 2021 12:25:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
Message-ID: <20210217112539.GC14758@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210216160258.GE21108@quack2.suse.cz>
 <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 12:52:21, Amir Goldstein wrote:
> On Tue, Feb 16, 2021 at 6:02 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > Looking at the patches I've got one idea:
> >
> > Currently you have fsnotify_event like:
> >
> > struct fsnotify_event {
> >         struct list_head list;
> >         unsigned int key;
> >         unsigned int next_bucket;
> > };
> >
> > And 'list' is used for hashed queue list, next_bucket is used to simulate
> > single queue out of all the individual lists. The option I'm considering
> > is:
> >
> > struct fsnotify_event {
> >         struct list_head list;
> >         struct fsnotify_event *hash_next;
> >         unsigned int key;
> > };
> >
> > So 'list' would stay to be used for the single queue of events like it was
> > before your patches. 'hash_next' would be used for list of events in the
> > hash chain. The advantage of this scheme would be somewhat more obvious
> > handling,
> 
> I can agree to that.
> 
> > also we can handle removal of permission events (they won't be
> > hashed so there's no risk of breaking hash-chain in the middle, removal
> > from global queue is easy as currently).
> 
> Ok. but I do not really see a value in hashing non-permission events
> for high priority groups, so this is not a strong argument.

The reason why I thought it is somewhat beneficial is that someone might be
using higher priority fanotify group just for watching non-permission
events because so far the group priority makes little difference. And
conceptually it isn't obvious (from userspace POV) why higher priority
groups should be merging events less efficiently...

> > The disadvantage is increase of
> > event size by one pointer on 64-bit but I think we can live with that. What
> > do you think?
> 
> Given the round size of fixes size events in v5.10, that would be a shame:
> 
> ls -l /sys/kernel/slab/*notify*event
> lrwxrwxrwx 1 root root 0 Feb 17 12:23
> /sys/kernel/slab/fanotify_fid_event -> :0000064
> lrwxrwxrwx 1 root root 0 Feb 17 12:23
> /sys/kernel/slab/fanotify_path_event -> :0000056
> lrwxrwxrwx 1 root root 0 Feb 17 12:23
> /sys/kernel/slab/fanotify_perm_event -> :0000064
> 
> Counter proposal:
> 
> struct fsnotify_event {
>         struct list_head list;
>         struct fsnotify_event *hash_next;
>         unsigned int key;
>         u32 mask;
> };

Even better!

> It is quite strange that mask is a member of struct fanotify_event and
> struct inotify_event_info to begin with.

Because they were moved there in the past to improve struct packing ;)

> Moving the mask member to struct fsnotify_event like that is not going
> to change the resulting inotify/fanotify event size.
> 
> We can actually squeeze fanotify_event_type into 2 low bits of pid
> pointer, and reduce the size of all fanotify events by one pointer,
> because FANOTIFY_EVENT_TYPE_OVERFLOW is nice to have.
> The overflow event can use FANOTIFY_EVENT_TYPE_PATH with a
> NULL path values (as early versions of the patch did).
> 
> This is not worth doing with current round event size, IMO.

I agree. Not worth it at this point.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
