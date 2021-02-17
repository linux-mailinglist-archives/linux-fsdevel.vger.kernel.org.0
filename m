Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C8E31DAF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 14:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhBQNtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 08:49:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232069AbhBQNtT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:49:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E835FB1FA;
        Wed, 17 Feb 2021 13:48:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9F18F1E0871; Wed, 17 Feb 2021 14:48:37 +0100 (CET)
Date:   Wed, 17 Feb 2021 14:48:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] fsnotify: support hashed notification queue
Message-ID: <20210217134837.GD14758@quack2.suse.cz>
References: <20210202162010.305971-1-amir73il@gmail.com>
 <20210202162010.305971-3-amir73il@gmail.com>
 <20210216150247.GB21108@quack2.suse.cz>
 <CAOQ4uxhLQBPd3aeVOj0E3HpKiYoqpfzPv9wZ8H8ncWTG4FOrtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhLQBPd3aeVOj0E3HpKiYoqpfzPv9wZ8H8ncWTG4FOrtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 17-02-21 14:33:46, Amir Goldstein wrote:
> On Tue, Feb 16, 2021 at 5:02 PM Jan Kara <jack@suse.cz> wrote:
> > > @@ -300,10 +301,16 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
> > >       switch (cmd) {
> > >       case FIONREAD:
> > >               spin_lock(&group->notification_lock);
> > > -             list_for_each_entry(fsn_event, &group->notification_list,
> > > -                                 list) {
> > > -                     send_len += sizeof(struct inotify_event);
> > > -                     send_len += round_event_name_len(fsn_event);
> > > +             list = fsnotify_first_notification_list(group);
> > > +             /*
> > > +              * With multi queue, send_len will be a lower bound
> > > +              * on total events size.
> > > +              */
> > > +             if (list) {
> > > +                     list_for_each_entry(fsn_event, list, list) {
> > > +                             send_len += sizeof(struct inotify_event);
> > > +                             send_len += round_event_name_len(fsn_event);
> > > +                     }
> >
> > As I write below IMO we should enable hashed queues also for inotify (is
> > there good reason not to?)
> 
> I see your perception of inotify_merge() is the same as mine was
> when I wrote a patch to support hashed queues for inotify.
> It is only after that I realized that inotify_merge() only ever merges
> with the last event and I dropped that patch.
> I see no reason to change this long time behavior.

Ah, I even briefly looked at that code but didn't notice it merges only
with the last event. I agree that hashing for inotify doesn't make sense
then.

Hum, if the hashing and merging is specific to fanotify and as we decided
to keep the event->list for the global event list, we could easily have the
hash table just in fanotify private group data and hash->next pointer in
fanotify private part of the event? Maybe that would even result in a more
compact code?

> > > +static inline size_t fsnotify_group_size(unsigned int q_hash_bits)
> > > +{
> > > +     return sizeof(struct fsnotify_group) + (sizeof(struct list_head) << q_hash_bits);
> > > +}
> > > +
> > > +static inline unsigned int fsnotify_event_bucket(struct fsnotify_group *group,
> > > +                                              struct fsnotify_event *event)
> > > +{
> > > +     /* High bits are better for hash */
> > > +     return (event->key >> (32 - group->q_hash_bits)) & group->max_bucket;
> > > +}
> >
> > Why not use hash_32() here? IMHO better than just stripping bits...
> 
> See hash_ptr(). There is a reason to use the highest bits.

Well, but event->key is just a 32-bit number so I don't follow how high
bits used by hash_ptr() matter?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
