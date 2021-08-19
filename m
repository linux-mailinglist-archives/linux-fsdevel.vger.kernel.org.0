Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AB3F1228
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 05:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhHSD70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 23:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235893AbhHSD70 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:59:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4475C610CB;
        Thu, 19 Aug 2021 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629345530;
        bh=It3UWJT/EISjJbSXJOa9YOZrmo0c8cMi/Z71oauhW1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8YJS3s9/SG4ffD2pUndnBEUmZ/rGTKk143b5aSWLidLDRfF3rRHrbS3sG/KdLFoe
         fO2i8I4B/tdR+nOAn50qXcduL736ue0ayVwSLKnC/382wpgRKNX5yQDev19DIoX1a+
         UwlH6klunOX5kQtDhqsLRRIrl+3915OVPlaZ7Y9f2us1VPtcFk+i63959XJXFvw/M5
         QRlP2OK4MdbEHUVxd7bTwXjGnxQc6dfcZsNPZBIVoWma/HKUPKgOERVOqcosqqCvTZ
         s+IKizsl4Qz4slLXVbqbopf3vCpQcnfx6wBx7Iyx2br0qroybo7gYnk7e+GEniPSC5
         7Q1M+zJjI5SCg==
Date:   Wed, 18 Aug 2021 20:58:49 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
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
Message-ID: <20210819035849.GA12586@magnolia>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-19-krisman@collabora.com>
 <20210816214103.GA12664@magnolia>
 <20210817090538.GA26181@quack2.suse.cz>
 <CAOQ4uxgdJpovZ-zzJkLOdQ=YYF3ta46m0_jrt0QFSdJ9GdXR=g@mail.gmail.com>
 <20210818001632.GD12664@magnolia>
 <CAOQ4uxhccRchiajjje3C20UOKwxQUapu=RYPsM1Y0uTnS81Vew@mail.gmail.com>
 <20210818095818.GA28119@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818095818.GA28119@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 11:58:18AM +0200, Jan Kara wrote:
> On Wed 18-08-21 06:24:26, Amir Goldstein wrote:
> > [...]
> > 
> > > > Just keep in mind that the current scheme pre-allocates the single event slot
> > > > on fanotify_mark() time and (I think) we agreed to pre-allocate
> > > > sizeof(fsnotify_error_event) + MAX_HDNALE_SZ.
> > > > If filesystems would want to store some variable length fs specific info,
> > > > a future implementation will have to take that into account.
> > >
> > > <nod> I /think/ for the fs and AG metadata we could preallocate these,
> > > so long as fsnotify doesn't free them out from under us.
> > 
> > fs won't get notified when the event is freed, so fsnotify must
> > take ownership on the data structure.
> > I was thinking more along the lines of limiting maximum size for fs
> > specific info and pre-allocating that size for the event.
> 
> Agreed. If there's a sensible upperbound than preallocating this inside
> fsnotify is likely the least problematic solution.
> 
> > > For inodes...
> > > there are many more of those, so they'd have to be allocated
> > > dynamically.
> > 
> > The current scheme is that the size of the queue for error events
> > is one and the single slot is pre-allocated.
> > The reason for pre-allocate is that the assumption is that fsnotify_error()
> > could be called from contexts where memory allocation would be
> > inconvenient.
> > Therefore, we can store the encoded file handle of the first erroneous
> > inode, but we do not store any more events until user read this
> > one event.
> 
> Right. OTOH I can imagine allowing GFP_NOFS allocations in the error
> context. At least for ext4 it would be workable (after all ext4 manages to
> lock & modify superblock in its error handlers, GFP_NOFS allocation isn't
> harder). But then if events are dynamically allocated there's still the
> inconvenient question what are you going to do if you need to report fs
> error and you hit ENOMEM. Just not sending the notification may have nasty
> consequences and in the world of containerization and virtualization
> tightly packed machines where ENOMEM happens aren't that unlikely. It is
> just difficult to make assumptions about filesystems overall so we decided
> to be better safe and preallocate the event.
> 
> Or, we could leave the allocation troubles for the filesystem and
> fsnotify_sb_error() would be passed already allocated event (this way
> attaching of fs-specific blobs to the event is handled as well) which it
> would just queue. Plus we'd need to provide some helper to fill in generic
> part of the event...
> 
> The disadvantage is that if there are filesystems / callsites needing
> preallocated events, it would be painful for them. OTOH current two users -
> ext4 & xfs - can handle allocation in the error path AFAIU.
> 
> Thinking about this some more, maybe we could have event preallocated (like
> a "rescue event"). Normally we would dynamically allocate (or get passed
> from fs) the event and only if the allocation fails, we would queue the
> rescue event to indicate to listeners that something bad happened, there
> was error but we could not fully report it.

Yes.

> But then, even if we'd go for dynamic event allocation by default, we need
> to efficiently merge events since some fs failures (e.g. resulting in
> journal abort in ext4) lead to basically all operations with the filesystem
> to fail and that could easily swamp the notification system with useless
> events.

Hm.  Going out on a limb, I would guess that the majority of fs error
flood events happen if the storage fails catastrophically.  Assuming
that a catastrophic failure will quickly take the filesystem offline, I
would say that for XFS we should probably send one last "and then we
died" event and stop reporting after that.

> Current system with preallocated event nicely handles this
> situation, it is questionable how to extend it for online fsck usecase
> where we need to queue more than one event (but even there probably needs
> to be some sensible upper-bound). I'll think about it...

At least for XFS, I was figuring that xfs_scrub errors wouldn't be
reported via fsnotify since the repair tool is already running anyway.

> > > Hmm.  For handling accumulated errors, can we still access the
> > > fanotify_event_info_* object once we've handed it to fanotify?  If the
> > > user hasn't picked up the event yet, it might be acceptable to set more
> > > bits in the type mask and bump the error count.  In other words, every
> > > time userspace actually reads the event, it'll get the latest error
> > > state.  I /think/ that's where the design of this patchset is going,
> > > right?
> > 
> > Sort of.
> > fsnotify does have a concept of "merging" new event with an event
> > already in queue.
> > 
> > With most fsnotify events, merge only happens if the info related
> > to the new event (e.g. sb,inode) is the same as that off the queued
> > event and the "merge" is only in the event mask
> > (e.g. FS_OPEN|FS_CLOSE).
> > 
> > However, the current scheme for "merge" of an FS_ERROR event is only
> > bumping err_count, even if the new reported error or inode do not
> > match the error/inode in the queued event.
> > 
> > If we define error event subtypes (e.g. FS_ERROR_WRITEBACK,
> > FS_ERROR_METADATA), then the error event could contain
> > a field for subtype mask and user could read the subtype mask
> > along with the accumulated error count, but this cannot be
> > done by providing the filesystem access to modify an internal
> > fsnotify event, so those have to be generic UAPI defined subtypes.
> > 
> > If you think that would be useful, then we may want to consider
> > reserving the subtype mask field in fanotify_event_info_error in
> > advance.
> 
> It depends on what exactly Darrick has in mind but I suspect we'd need a
> fs-specific merge helper that would look at fs-specific blobs in the event
> and decide whether events can be merged or not, possibly also handling the
> merge by updating the blob.

Yes.  If the filesystem itself were allowed to manage the lifespan of
the fsnotify error event object then this would be trivial -- we'll own
the object, keep it updated as needed, and fsnotify can copy the
contents to userspace whenever convenient.

(This might be a naïve view of fsnotify...)

> From the POV of fsnotify that would probably
> mean merge callback in the event itself. But I guess this needs more
> details from Darrick and maybe we don't need to decide this at this moment
> since nobody is close to the point of having code needing to pass fs-blobs
> with events.

<nod> We ... probably don't need to decide this now.

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
