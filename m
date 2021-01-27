Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED423059A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 12:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhA0L1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 06:27:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:42844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236506AbhA0LY6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:24:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4ECCBAD26;
        Wed, 27 Jan 2021 11:24:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0BDF71E14C8; Wed, 27 Jan 2021 12:24:16 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:24:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: fanotify_merge improvements
Message-ID: <20210127112416.GB3108@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-9-amir73il@gmail.com>
 <20200226091804.GD10728@quack2.suse.cz>
 <CAOQ4uxiXbGF+RRUmnP4Sbub+3TxEavmCvi0AYpwHuLepqexdCA@mail.gmail.com>
 <20200226143843.GT10728@quack2.suse.cz>
 <CAOQ4uxh+Mpr-f3LY5PHNDtCoqTrey69-339DabzSkhRR4cbUYA@mail.gmail.com>
 <CAOQ4uxj_C4EbzwwcrE09P5Z83WqmwNVdeZRJ6qNaThM3pkUinQ@mail.gmail.com>
 <20210125130149.GC1175@quack2.suse.cz>
 <CAOQ4uxiSSYr4bejwZBBPDjs1Vg_BUSSjY4YiUAgri=adHdOLuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiSSYr4bejwZBBPDjs1Vg_BUSSjY4YiUAgri=adHdOLuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 26-01-21 18:21:26, Amir Goldstein wrote:
> On Mon, Jan 25, 2021 at 3:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 23-01-21 15:30:59, Amir Goldstein wrote:
> > > On Fri, Jan 22, 2021 at 3:59 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > > > > Hum, now thinking about this, maybe we could clean this up even a bit more.
> > > > > > > event->inode is currently used only by inotify and fanotify for merging
> > > > > > > purposes. Now inotify could use its 'wd' instead of inode with exactly the
> > > > > > > same results, fanotify path or fid check is at least as strong as the inode
> > > > > > > check. So only for the case of pure "inode" events, we need to store inode
> > > > > > > identifier in struct fanotify_event - and we can do that in the union with
> > > > > > > struct path and completely remove the 'inode' member from fsnotify_event.
> > > > > > > Am I missing something?
> > > > > >
> > > > > > That generally sounds good and I did notice it is strange that wd is not
> > > > > > being compared.  However, I think I was worried that comparing fid+name
> > > > > > (in following patches) would be more expensive than comparing dentry (or
> > > > > > object inode) as a "rule out first" in merge, so I preferred to keep the
> > > > > > tag/dentry/id comparison for fanotify_fid case.
> > > > >
> > > > > Yes, that could be a concern.
> > > > >
> > > > > > Given this analysis (and assuming it is correct), would you like me to
> > > > > > just go a head with the change suggested above? or anything beyond that?
> > > > >
> > > > > Let's go just with the change suggested above for now. We can work on this
> > > > > later (probably with optimizing of the fanotify merging code).
> > > > >
> > > >
> > > > Hi Jan,
> > > >
> > > > Recap:
> > > > - fanotify_merge is very inefficient and uses extensive CPU if queue contains
> > > >   many events, so it is rather easy for a poorly written listener to
> > > > cripple the system
> > > > - You had an idea to store in event->objectid a hash of all the compared
> > > >   fields (e.g. fid+name)
> > > > - I think you had an idea to keep a hash table of events in the queue
> > > > to find the
> > > >   merge candidates faster
> > > > - For internal uses, I carry a patch that limits the linear search for
> > > > last 128 events
> > > >   which is enough to relieve the CPU overuse in case of unattended long queues
> > > >
> > > > I tried looking into implementing the hash table idea, assuming I understood you
> > > > correctly and I struggled to choose appropriate table sizes. It seemed to make
> > > > sense to use a global hash table, such as inode/dentry cache for all the groups
> > > > but that would add complexity to locking rules of queue/dequeue and
> > > > group cleanup.
> > > >
> > > > A simpler solution I considered, similar to my 128 events limit patch,
> > > > is to limit
> > > > the linear search to events queued in the last X seconds.
> > > > The rationale is that event merging is not supposed to be long term at all.
> > > > If a listener fails to perform read from the queue, it is not fsnotify's job to
> > > > try and keep the queue compact. I think merging events mechanism was
> > > > mainly meant to merge short bursts of events on objects, which are quite
> > > > common and surely can happen concurrently on several objects.
> > > >
> > > > My intuition is that making event->objectid into event->hash in addition
> > > > to limiting the age of events to merge would address the real life workloads.
> > > > One question if we do choose this approach is what should the age limit be?
> > > > Should it be configurable? Default to infinity and let distro cap the age or
> > > > provide a sane default by kernel while slightly changing behavior (yes please).
> > > >
> > > > What are your thoughts about this?
> > >
> > > Aha! found it:
> > > https://lore.kernel.org/linux-fsdevel/20200227112755.GZ10728@quack2.suse.cz/
> > > You suggested a small hash table per group (128 slots).
> > >
> > > My intuition is that this will not be good enough for the worst case, which is
> > > not that hard to hit is real life:
> > > 1. Listener sets FAN_UNLIMITED_QUEUE
> > > 2. Listener adds a FAN_MARK_FILESYSTEM watch
> > > 3. Many thousands of events are queued
> > > 4. Listener lingers (due to bad implementation?) in reading events
> > > 5. Every single event now incurs a huge fanotify_merge() cost
> > >
> > > Reducing the cost of merge from O(N) to O(N/128) doesn't really fix the
> > > problem.
> >
> > So my thought was that indeed reducing the overhead of merging by a factor
> > of 128 should be enough for any practical case as much as I agree that in
> > principle the computational complexity remains the same. And I've picked
> > per-group hash table to avoid interferences among notification groups and
> > to keep locking simple. That being said I'm not opposed to combining this
> > with a limit on the number of elements traversed in a hash chain (e.g.
> > those 128 you use yourself) - it will be naturally ordered by queue order
> > if we are a bit careful. This will provide efficient and effective merging
> > for ~8k queued events which seems enough to me. I find time based limits
> > not really worth it. Yes, they provide more predictable behavior but less
> > predictable runtime and overall I don't find the complexity worth the
> > benefit.
> >
> 
> Sounds reasonable.
> If you have time, please take a look at this WIP branch:
> https://github.com/amir73il/linux/commits/fanotify_merge
> and let me know if you like the direction it is taking.
> 
> This branch is only compile tested, but I am asking w.r.t to the chosen
> data structures.  So far it is just an array of queues selected by (yet
> unmodified) objectid.  Reading is just from any available queue.
> 
> My goal was to avoid having to hang the event on multiple list/hlist and
> the idea is to implement read by order of events as follows:

As a side note, since we use notification_list as a strict queue, we could
actually use a singly linked list for linking all the events (implemented
in include/linux/llist.h). That way we can save one pointer in
fsnotify_event if we wish without too much complication AFAICT. But I'm not
sure we really care.

> - With multi queue, high bit of obejctid will be masked for merge compare.
> - Instead, they will be used to store the next_qid to read from
> 
> For example:
> - event #1 is added to queue 6
> - set group->last_qid = 6
> - set group->next_qid = 6 (because group->num_events == 1)
> - event #2 is added to queue 13
> - the next_qid bits of the last event in last_qid (6) queue are set to 13
> - set group->last_qid = 13
>
> - read() checks value of group->next_qid and reads the first event
> from queue 6 (event #1)
> - event #1 has 13 stored in next_qid bits so set group->next_qid = 13
> - read() reads first event from queue 13 (event #2)

That's an interesting idea. I like it and I think it would work. Just
instead of masking, I'd use bitfields. Or we could just restrict objectid
to 32-bits and use remaining 32-bits for the next_qid pointer. I know it
will waste some bits but 32-bits of objectid should provide us with enough
space to avoid doing full event comparison in most cases - BTW WRT naming I
find 'qid' somewhat confusing. Can we call it say 'next_bucket' or
something like that?

> Permission events require special care, but that is the idea of a simple
> singly linked list using qid's for reading events by insert order and
> merging by hashed queue.

Why are permission events special in this regard?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
