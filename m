Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C3832131F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBVJaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 04:30:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:33960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhBVJaG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:30:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00EF3AC6F;
        Mon, 22 Feb 2021 09:29:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7AEDC1E14ED; Mon, 22 Feb 2021 10:29:23 +0100 (CET)
Date:   Mon, 22 Feb 2021 10:29:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
Message-ID: <20210222092923.GA19630@quack2.suse.cz>
References: <20210216160258.GE21108@quack2.suse.cz>
 <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com>
 <20210217112539.GC14758@quack2.suse.cz>
 <CAOQ4uxiEuWaw1VKwJvp5V-_dN=MZNXWro4q8OnO8qhN-r7dLhA@mail.gmail.com>
 <20210218111558.GB16953@quack2.suse.cz>
 <CAOQ4uxj0HE1A=E3ufSVFjGa1MckkdbQz3n-tBEAS-Zx7nwOKOQ@mail.gmail.com>
 <20210219101556.GA6086@quack2.suse.cz>
 <20210219102125.GB6086@quack2.suse.cz>
 <CAOQ4uxjiJk9iiFtKJJXmyuxf0w2L+1GY6mixgoGiZbFn3vJvzQ@mail.gmail.com>
 <CAOQ4uxg1Fvyp+7MXyTKHohW2ka5nwEGEy5O4U1u1spegpeL0Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg1Fvyp+7MXyTKHohW2ka5nwEGEy5O4U1u1spegpeL0Cg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 21-02-21 14:53:46, Amir Goldstein wrote:
> On Fri, Feb 19, 2021 at 3:38 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Feb 19, 2021 at 12:21 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 19-02-21 11:15:56, Jan Kara wrote:
> > > > On Thu 18-02-21 14:35:39, Amir Goldstein wrote:
> > > > > On Thu, Feb 18, 2021 at 1:15 PM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Thu 18-02-21 12:56:18, Amir Goldstein wrote:
> > > > > > > On Wed, Feb 17, 2021 at 1:25 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > >
> > > > > > > > On Wed 17-02-21 12:52:21, Amir Goldstein wrote:
> > > > > > > > > On Tue, Feb 16, 2021 at 6:02 PM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Amir!
> > > > > > > > > >
> > > > > > > > > > Looking at the patches I've got one idea:
> > > > > > > > > >
> > > > > > > > > > Currently you have fsnotify_event like:
> > > > > > > > > >
> > > > > > > > > > struct fsnotify_event {
> > > > > > > > > >         struct list_head list;
> > > > > > > > > >         unsigned int key;
> > > > > > > > > >         unsigned int next_bucket;
> > > > > > > > > > };
> > > > > > > > > >
> > > > > > > > > > And 'list' is used for hashed queue list, next_bucket is used to simulate
> > > > > > > > > > single queue out of all the individual lists. The option I'm considering
> > > > > > > > > > is:
> > > > > > > > > >
> > > > > > > > > > struct fsnotify_event {
> > > > > > > > > >         struct list_head list;
> > > > > > > > > >         struct fsnotify_event *hash_next;
> > > > > > > > > >         unsigned int key;
> > > > > > > > > > };
> > > > > > > > > >
> > > > > > > > > > So 'list' would stay to be used for the single queue of events like it was
> > > > > > > > > > before your patches. 'hash_next' would be used for list of events in the
> > > > > > > > > > hash chain. The advantage of this scheme would be somewhat more obvious
> > > > > > > > > > handling,
> > > > > > > > >
> > > > > > > > > I can agree to that.
> > > > > > > > >
> > > > > > > > > > also we can handle removal of permission events (they won't be
> > > > > > > > > > hashed so there's no risk of breaking hash-chain in the middle, removal
> > > > > > > > > > from global queue is easy as currently).
> > > > > > > > >
> > > > > > > > > Ok. but I do not really see a value in hashing non-permission events
> > > > > > > > > for high priority groups, so this is not a strong argument.
> > > > > > > >
> > > > > > > > The reason why I thought it is somewhat beneficial is that someone might be
> > > > > > > > using higher priority fanotify group just for watching non-permission
> > > > > > > > events because so far the group priority makes little difference. And
> > > > > > > > conceptually it isn't obvious (from userspace POV) why higher priority
> > > > > > > > groups should be merging events less efficiently...
> > > > > > > >
> > > > > > >
> > > > > > > So I implemented your suggestion with ->next_event, but it did not
> > > > > > > end up with being able to remove from the middle of the queue.
> > > > > > > The thing is we know that permission events are on list #0, but what
> > > > > > > we need to find out when removing a permission event is the previous
> > > > > > > event in timeline order and we do not have that information.
> > > > > >
> > > > > > So my idea was that if 'list' is the time ordered list and permission
> > > > > > events are *never inserted into the hash* (we don't need them there as
> > > > > > hashed lists are used only for merging), then removal of permission events
> > > > > > is no problem.
> > > > >
> > > > > We are still not talking in the same language.
> > > >
> > > > Yes, I think so :).
> > > >
> > > > > I think what you mean is use a dedicated list only for permission events
> > > > > which is not any one of the hash lists.
> > > > >
> > > > > In that case, get_one_event() will have to look at both the high
> > > > > priority queue and the hash queue if we want to allow mixing hashed
> > > > > event with permission events.
> > > > >
> > > > > It will also mean that permission events always get priority over non-permission
> > > > > events. While this makes a lot of sense, this is not the current behavior.
> > > > >
> > > > > So what am I missing?
> > > >
> > > > Let me explain with the pseudocode. fsnotify_add_event() will do:
> > > >
> > > > spin_lock(&group->notification_lock);
> > > > ...
> > > > if (!list_empty(list) && merge) {
> > > >       ret = merge(list, event);
> > > >       if (ret)
> > > >               bail
> > > > }
> > > > group->q_len++;
> > > > list_add_tail(&event->list, &group->notification_list);
> > > > if (add_hash) {
> > > >       /* Add to merge hash */
> > > >       *(group->merge_hash[hash(event->key)]->lastp) = event;
> > > >       group->merge_hash[hash(event->key)]->lastp = &(event->hash_next);
> > > > }
> > > > spin_unlock(&group->notification_lock);
> > > >
> > > > And we set 'add_hash' to true only for non-permission events. The merge()
> > > > function can use merge_hash[] to speedup the search for merge candidates.
> > > > There will be no changes to fsnotify_peek_first_event() (modulo cleanups)
> > > > compared to current upstream. fsnotify_remove_queued_event() needs to
> > > > update ->first and ->lastp pointers in merge_hash[]. So something like:
> > > >
> > > > list_del_init(&event->list);
> > > > group->q_len--;
> > > > group->merge_hash[hash(event->key)]->first = event->next_hash;
> > >
> > > Actually we must do hash handling only if the event was added to the hash.
> > > So either fsnotify_remove_queued_event() needs to take an argument whether
> > > it should add event to a hash or we need to somehow identify that based on
> > > ->key having special value or checking
> > >   group->merge_hash[hash(event->key)]->first == event
> > >
> >
> > Not a problem.
> > Permission events and the overflow event already have zero key.
> > In the very unlikely event of a random zero hash, that unicorn event
> > won't get merged - so what.
> >
> > But anyway, I think we can keep the hash handling confined in fanotify.
> > With your suggestion, there can be no hashing code left in fsnotify core
> > and the only hash handling will remain in the fanotify insert() hook as in
> > current fanotify_merge branch.
> >
> > Because the only case we care about the hash is actually when removing
> > the first event, fanotify already knows to identify if the event is hashed.
> > The other cases where event is removed on group cleanup the hash
> > chains are not relevant so fsnotify core doesn't need to care about it.
> >
> > >
> > > > if (!event->next_hash) {
> > > >       group->merge_hash[hash(event->key)]->lastp =
> > > >               &(group->merge_hash[hash(event->key)]->first);
> > > > }
> > > >
> > > > Clearer now?
> >
> > Yes, and much simpler.
> >
> 
> Much simpler but doesn't work.
> The merge list needs to be ordered from the most recent event for merging,
> not from the oldest event.

Hum, right. It is more efficient and when we limit the scanning to 128
elements, it is necessary.

> Anyway, enough with those games. I implemented the hash table using
> hlist's and obviously the result is much simpler.

Agreed.

> The space we lost for the pprev pointer of hlist_node I won us back
> by cramming the hash together with the type:
> 
> struct fanotify_event {
>         struct fsnotify_event fse;
>         struct hlist_node merge_list;   /* List for hashed merge */
>         u32 mask;
>         struct {
>                 unsigned int type : FANOTIFY_EVENT_TYPE_BITS;
>                 unsigned int hash : FANOTIFY_EVENT_HASH_BITS;
>         };
>         struct pid *pid;
> };
> 
> Anyway, pushed the following branches to my github linux and ltp trees:
> * fanotify_merge
> * fanotify_limits
> * fanotify_unpriv

I'll check it.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
