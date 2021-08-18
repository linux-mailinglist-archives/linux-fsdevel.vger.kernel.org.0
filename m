Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48E3F011F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhHRJ67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 05:58:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34184 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJ6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 05:58:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5156520062;
        Wed, 18 Aug 2021 09:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629280699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+rRQt+xchplA/lQroz3AGG/lSqy7x3et1wOuKoPYcI=;
        b=2WgJQfml0HC8ZChU4woY8/ZYiIFO3bKTpxHEpgpQg7Z65fglewLlavFSyieM2blBevpcR3
        Ag6p7dFgx5Hm833BTfP6q8JT5R937W4JNI0aXtmGEAC+t2R41Trqo6Yne2PhQIemta1IRF
        GzbDFTJwLPNIhEDay8wQi9Hbtp3E0/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629280699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h+rRQt+xchplA/lQroz3AGG/lSqy7x3et1wOuKoPYcI=;
        b=b9tNGYu3lxjwFwKMh9TjvA2OTxvgYAoQKMuoPx6o74EpVtizbcWyBWO6utHO2JjUMHdHH8
        QGGCZEafKm6h3oBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 39C90A3B96;
        Wed, 18 Aug 2021 09:58:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F1DE91E14B9; Wed, 18 Aug 2021 11:58:18 +0200 (CEST)
Date:   Wed, 18 Aug 2021 11:58:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com
Subject: Re: [PATCH v6 18/21] fanotify: Emit generic error info type for
 error event
Message-ID: <20210818095818.GA28119@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
 <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz>
 <CAOQ4uxgdJpovZ-zzJkLOdQ=YYF3ta46m0_jrt0QFSdJ9GdXR=g@mail.gmail.com>
 <20210818001632.GD12664@magnolia>
 <CAOQ4uxhccRchiajjje3C20UOKwxQUapu=RYPsM1Y0uTnS81Vew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhccRchiajjje3C20UOKwxQUapu=RYPsM1Y0uTnS81Vew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-08-21 06:24:26, Amir Goldstein wrote:
> [...]
> 
> > > Just keep in mind that the current scheme pre-allocates the single event slot
> > > on fanotify_mark() time and (I think) we agreed to pre-allocate
> > > sizeof(fsnotify_error_event) + MAX_HDNALE_SZ.
> > > If filesystems would want to store some variable length fs specific info,
> > > a future implementation will have to take that into account.
> >
> > <nod> I /think/ for the fs and AG metadata we could preallocate these,
> > so long as fsnotify doesn't free them out from under us.
> 
> fs won't get notified when the event is freed, so fsnotify must
> take ownership on the data structure.
> I was thinking more along the lines of limiting maximum size for fs
> specific info and pre-allocating that size for the event.

Agreed. If there's a sensible upperbound than preallocating this inside
fsnotify is likely the least problematic solution.

> > For inodes...
> > there are many more of those, so they'd have to be allocated
> > dynamically.
> 
> The current scheme is that the size of the queue for error events
> is one and the single slot is pre-allocated.
> The reason for pre-allocate is that the assumption is that fsnotify_error()
> could be called from contexts where memory allocation would be
> inconvenient.
> Therefore, we can store the encoded file handle of the first erroneous
> inode, but we do not store any more events until user read this
> one event.

Right. OTOH I can imagine allowing GFP_NOFS allocations in the error
context. At least for ext4 it would be workable (after all ext4 manages to
lock & modify superblock in its error handlers, GFP_NOFS allocation isn't
harder). But then if events are dynamically allocated there's still the
inconvenient question what are you going to do if you need to report fs
error and you hit ENOMEM. Just not sending the notification may have nasty
consequences and in the world of containerization and virtualization
tightly packed machines where ENOMEM happens aren't that unlikely. It is
just difficult to make assumptions about filesystems overall so we decided
to be better safe and preallocate the event.

Or, we could leave the allocation troubles for the filesystem and
fsnotify_sb_error() would be passed already allocated event (this way
attaching of fs-specific blobs to the event is handled as well) which it
would just queue. Plus we'd need to provide some helper to fill in generic
part of the event...

The disadvantage is that if there are filesystems / callsites needing
preallocated events, it would be painful for them. OTOH current two users -
ext4 & xfs - can handle allocation in the error path AFAIU.

Thinking about this some more, maybe we could have event preallocated (like
a "rescue event"). Normally we would dynamically allocate (or get passed
from fs) the event and only if the allocation fails, we would queue the
rescue event to indicate to listeners that something bad happened, there
was error but we could not fully report it.

But then, even if we'd go for dynamic event allocation by default, we need
to efficiently merge events since some fs failures (e.g. resulting in
journal abort in ext4) lead to basically all operations with the filesystem
to fail and that could easily swamp the notification system with useless
events. Current system with preallocated event nicely handles this
situation, it is questionable how to extend it for online fsck usecase
where we need to queue more than one event (but even there probably needs
to be some sensible upper-bound). I'll think about it...

> > Hmm.  For handling accumulated errors, can we still access the
> > fanotify_event_info_* object once we've handed it to fanotify?  If the
> > user hasn't picked up the event yet, it might be acceptable to set more
> > bits in the type mask and bump the error count.  In other words, every
> > time userspace actually reads the event, it'll get the latest error
> > state.  I /think/ that's where the design of this patchset is going,
> > right?
> 
> Sort of.
> fsnotify does have a concept of "merging" new event with an event
> already in queue.
> 
> With most fsnotify events, merge only happens if the info related
> to the new event (e.g. sb,inode) is the same as that off the queued
> event and the "merge" is only in the event mask
> (e.g. FS_OPEN|FS_CLOSE).
> 
> However, the current scheme for "merge" of an FS_ERROR event is only
> bumping err_count, even if the new reported error or inode do not
> match the error/inode in the queued event.
> 
> If we define error event subtypes (e.g. FS_ERROR_WRITEBACK,
> FS_ERROR_METADATA), then the error event could contain
> a field for subtype mask and user could read the subtype mask
> along with the accumulated error count, but this cannot be
> done by providing the filesystem access to modify an internal
> fsnotify event, so those have to be generic UAPI defined subtypes.
> 
> If you think that would be useful, then we may want to consider
> reserving the subtype mask field in fanotify_event_info_error in
> advance.

It depends on what exactly Darrick has in mind but I suspect we'd need a
fs-specific merge helper that would look at fs-specific blobs in the event
and decide whether events can be merged or not, possibly also handling the
merge by updating the blob. From the POV of fsnotify that would probably
mean merge callback in the event itself. But I guess this needs more
details from Darrick and maybe we don't need to decide this at this moment
since nobody is close to the point of having code needing to pass fs-blobs
with events.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
