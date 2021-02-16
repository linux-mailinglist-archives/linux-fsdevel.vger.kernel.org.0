Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A717231CD71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 17:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBPQDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 11:03:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:41212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhBPQDk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:03:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F282AC69;
        Tue, 16 Feb 2021 16:02:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EFA161F2AA7; Tue, 16 Feb 2021 17:02:58 +0100 (CET)
Date:   Tue, 16 Feb 2021 17:02:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
Message-ID: <20210216160258.GE21108@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202162010.305971-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

Looking at the patches I've got one idea:

Currently you have fsnotify_event like:

struct fsnotify_event {
        struct list_head list;
        unsigned int key;
        unsigned int next_bucket;
};

And 'list' is used for hashed queue list, next_bucket is used to simulate
single queue out of all the individual lists. The option I'm considering
is:

struct fsnotify_event {
        struct list_head list;
	struct fsnotify_event *hash_next;
        unsigned int key;
};

So 'list' would stay to be used for the single queue of events like it was
before your patches. 'hash_next' would be used for list of events in the
hash chain. The advantage of this scheme would be somewhat more obvious
handling, also we can handle removal of permission events (they won't be
hashed so there's no risk of breaking hash-chain in the middle, removal
from global queue is easy as currently). The disadvantage is increase of
event size by one pointer on 64-bit but I think we can live with that. What
do you think?

								Honza

On Tue 02-02-21 18:20:03, Amir Goldstein wrote:
> Jan,
> 
> fanotify_merge() has been observed [1] to consume a lot of CPU.
> This is not surprising considering that it is implemented as a linear
> search on a practically unbounded size list.
> 
> The following series improves the linear search for an event to merge
> in three different ways:
> 1. Hash events into as much as to 128 lists
> 2. Limit linear search to 128 last list elements
> 3. Use a better key - instead of victim inode ptr, use a hash of all
>    the compared fields
> 
> The end result can be observed in the test run times below.
> The test is an extension of your queue overflow LTP test [2].
> The timing results use are from the 2nd run of -i 2, where files
> are already existing in the test fs.
> 
> With an unlimited queue, queueing of 16385 events on unique objects
> is ~3 times faster than before the change.
> 
> In fact, the run time of queueing 16385 events (~600ms) is almost the
> same as the run time of rejecting 16385 events (~550ms) due to full
> queue, which suggest a very low overhead for merging events.
> 
> The test runs two passes to test event merge, the "create" pass and
> the "open" pass.
> 
> Before the change (v5.11-rc2) 100% of the events of the "open" pass
> are merged (16385 files and 16385 events).
> 
> After the change, only %50 of the events of the "open" pass are
> merged (16385 files and 25462 events).
> 
> This is because 16384 is the maximum number of events that we can
> merge when hash table is fully balanced.
> When reducing the number of unique objects to 8192, all events
> on the "open" pass are merged.
> 
> Thanks,
> Amir.
> 
> v5.11-rc2, run #2 of ./fanotify05 -i 2:
> 
> fanotify05.c:109: TINFO: Test #0: Limited queue
> fanotify05.c:98: TINFO: Created 16385 files in 1653ms
> fanotify05.c:98: TINFO: Opened 16385 files in 543ms
> fanotify05.c:77: TINFO: Got event #0 filename=fname_0
> fanotify05.c:176: TPASS: Got an overflow event: pid=0 fd=-1
> fanotify05.c:182: TINFO: Got 16385 events
> 
> fanotify05.c:109: TINFO: Test #1: Unlimited queue
> fanotify05.c:98: TINFO: Created 16385 files in 1683ms
> fanotify05.c:98: TINFO: Opened 16385 files in 1647ms
> fanotify05.c:77: TINFO: Got event #0 filename=fname_0
> fanotify05.c:138: TPASS: Overflow event not generated!
> fanotify05.c:182: TINFO: Got 16385 events
> 
> fanotify_merge branch, run #2 of ./fanotify05 -i 2:
> 
> fanotify05.c:109: TINFO: Test #0: Limited queue
> fanotify05.c:98: TINFO: Created 16385 files in 616ms
> fanotify05.c:98: TINFO: Opened 16385 files in 549ms
> fanotify05.c:77: TINFO: Got event #0 filename=fname_0
> fanotify05.c:176: TPASS: Got an overflow event: pid=0 fd=-1
> fanotify05.c:182: TINFO: Got 16385 events
> 
> fanotify05.c:109: TINFO: Test #1: Unlimited queue
> fanotify05.c:98: TINFO: Created 16385 files in 614ms
> fanotify05.c:98: TINFO: Opened 16385 files in 599ms
> fanotify05.c:77: TINFO: Got event #0 filename=fname_0
> fanotify05.c:138: TPASS: Overflow event not generated!
> fanotify05.c:182: TINFO: Got 25462 events
> 
> [1] https://lore.kernel.org/linux-fsdevel/20200714025417.A25EB95C0339@us180.sjc.aristanetworks.com/
> [2] https://github.com/amir73il/ltp/commits/fanotify_merge
> 
> Amir Goldstein (7):
>   fsnotify: allow fsnotify_{peek,remove}_first_event with empty queue
>   fsnotify: support hashed notification queue
>   fsnotify: read events from hashed notification queue by order of
>     insertion
>   fanotify: enable hashed notification queue for FAN_CLASS_NOTIF groups
>   fanotify: limit number of event merge attempts
>   fanotify: mix event info into merge key hash
>   fsnotify: print some debug stats on hashed queue overflow
> 
>  fs/notify/fanotify/fanotify.c      |  40 ++++++-
>  fs/notify/fanotify/fanotify.h      |  24 +++-
>  fs/notify/fanotify/fanotify_user.c |  55 ++++++---
>  fs/notify/group.c                  |  37 ++++--
>  fs/notify/inotify/inotify_user.c   |  22 ++--
>  fs/notify/notification.c           | 175 +++++++++++++++++++++++++----
>  include/linux/fsnotify_backend.h   | 105 +++++++++++++++--
>  7 files changed, 383 insertions(+), 75 deletions(-)
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
