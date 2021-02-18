Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD631EA21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhBRM61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 07:58:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:58992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhBRLQn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:16:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C79FAFCD;
        Thu, 18 Feb 2021 11:15:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3DE2B1E0F3B; Thu, 18 Feb 2021 12:15:58 +0100 (CET)
Date:   Thu, 18 Feb 2021 12:15:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 0/7] Performance improvement for fanotify merge
Message-ID: <20210218111558.GB16953@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210216160258.GE21108@quack2.suse.cz>
 <CAOQ4uxi7NdNQOpGResWEtRDPv+yGSTkMY99tVDVv2mkOW3g97w@mail.gmail.com>
 <20210217112539.GC14758@quack2.suse.cz>
 <CAOQ4uxiEuWaw1VKwJvp5V-_dN=MZNXWro4q8OnO8qhN-r7dLhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiEuWaw1VKwJvp5V-_dN=MZNXWro4q8OnO8qhN-r7dLhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 18-02-21 12:56:18, Amir Goldstein wrote:
> On Wed, Feb 17, 2021 at 1:25 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 17-02-21 12:52:21, Amir Goldstein wrote:
> > > On Tue, Feb 16, 2021 at 6:02 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Hi Amir!
> > > >
> > > > Looking at the patches I've got one idea:
> > > >
> > > > Currently you have fsnotify_event like:
> > > >
> > > > struct fsnotify_event {
> > > >         struct list_head list;
> > > >         unsigned int key;
> > > >         unsigned int next_bucket;
> > > > };
> > > >
> > > > And 'list' is used for hashed queue list, next_bucket is used to simulate
> > > > single queue out of all the individual lists. The option I'm considering
> > > > is:
> > > >
> > > > struct fsnotify_event {
> > > >         struct list_head list;
> > > >         struct fsnotify_event *hash_next;
> > > >         unsigned int key;
> > > > };
> > > >
> > > > So 'list' would stay to be used for the single queue of events like it was
> > > > before your patches. 'hash_next' would be used for list of events in the
> > > > hash chain. The advantage of this scheme would be somewhat more obvious
> > > > handling,
> > >
> > > I can agree to that.
> > >
> > > > also we can handle removal of permission events (they won't be
> > > > hashed so there's no risk of breaking hash-chain in the middle, removal
> > > > from global queue is easy as currently).
> > >
> > > Ok. but I do not really see a value in hashing non-permission events
> > > for high priority groups, so this is not a strong argument.
> >
> > The reason why I thought it is somewhat beneficial is that someone might be
> > using higher priority fanotify group just for watching non-permission
> > events because so far the group priority makes little difference. And
> > conceptually it isn't obvious (from userspace POV) why higher priority
> > groups should be merging events less efficiently...
> >
> 
> So I implemented your suggestion with ->next_event, but it did not
> end up with being able to remove from the middle of the queue.
> The thing is we know that permission events are on list #0, but what
> we need to find out when removing a permission event is the previous
> event in timeline order and we do not have that information.

So my idea was that if 'list' is the time ordered list and permission
events are *never inserted into the hash* (we don't need them there as
hashed lists are used only for merging), then removal of permission events
is no problem.

> So I stayed with hashed queue only for group priority 0.
> 
> Pushed partly tested result to fanotify_merge branch.
> 
> Will post after testing unless you have reservations.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
