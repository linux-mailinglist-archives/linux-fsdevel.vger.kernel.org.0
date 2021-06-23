Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552523B1D9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhFWPbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 11:31:39 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:53826 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:31:37 -0400
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id A6871E8094B;
        Wed, 23 Jun 2021 17:29:17 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 5CE82160DC0; Wed, 23 Jun 2021 17:29:17 +0200 (CEST)
Date:   Wed, 23 Jun 2021 17:29:17 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luca Boccassi <bluca@debian.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 6/6] loop: increment sequence number
Message-ID: <YNNTTUYRlpXDqMgX@gardel-login>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-7-mcroce@linux.microsoft.com>
 <YNMhwLMr7DiNdqC/@infradead.org>
 <bbd3d100ee997431b2905838575eb4bdec820ad3.camel@debian.org>
 <YNNEdbr+0p+PzinQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNNEdbr+0p+PzinQ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 23.06.21 15:25, Christoph Hellwig (hch@infradead.org) wrote:

> On Wed, Jun 23, 2021 at 02:13:25PM +0100, Luca Boccassi wrote:
> > On Wed, 2021-06-23 at 12:57 +0100, Christoph Hellwig wrote:
> > > On Wed, Jun 23, 2021 at 12:58:58PM +0200, Matteo Croce wrote:
> > > > From: Matteo Croce <mcroce@microsoft.com>
> > > >
> > > > On a very loaded system, if there are many events queued up from multiple
> > > > attach/detach cycles, it's impossible to match them up with the
> > > > LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the position
> > > > of our own association in the queue is[1].
> > > > Not even an empty uevent queue is a reliable indication that we already
> > > > received the uevent we were waiting for, since with multi-partition block
> > > > devices each partition's event is queued asynchronously and might be
> > > > delivered later.
> > > >
> > > > Increment the disk sequence number when setting or changing the backing
> > > > file, so the userspace knows which backing file generated the event:
> > >
> > > Instead of manually incrementing the sequence here, can we make loop
> > > generate the DISK_EVENT_MEDIA_CHANGE event on a backing device (aka
> > > media) change?
> >
> > Hi,
> >
> > This was answered in the v1 thread:
> >
> > https://lore.kernel.org/linux-fsdevel/20210315201331.GA2577561@casper.infradead.org/t/#m8a677028572e826352cbb1e19d1b9c1f3b6bff4b
> >
> > The fundamental issue is that we'd be back at trying to correlate
> > events to loopdev instances, which does not work reliably - hence this
> > patch series. With the new ioctl, we can get the id immediately and
> > without delay when we create the device, with no possible races. Then
> > we can handle events reliably, as we can correlate correctly in all
> > cases.
>
> I very much disagree with your reply there.  The device now points to
> a different media.  Both for the loop device, a floppy or a CD changer
> probably by some kind of user action.  In the last cast it might even
> by done entirely locally through a script just like the loop device.

I am not sure I grok your point.

but let me try to explain why I think it's better to make media
changes *also* trigger seqno changes, and not make media change events
the *only* way to trigger seqno changes.

1. First of all, loopback devices currently don't hook into the media
   change logic (which so far is focussed on time-based polling
   actually, for both CDs and floppies). Adding this would change
   semantics visibly to userspace (since userspace would suddenly see
   another action=change + DISK_MEDIA_CHANGE=1 uevent suddenly that it
   needs to handle correctly). One can certainly argue that userspace
   must be ready to get additional uevents like this any time, but
   knowing userspace a bit I am pretty sure this will confuse some
   userspace that doesn't expect this. I mean loopback block devices
   already issue "change" uevents on attachment and detachment, one
   that userpace typically expects, but adding the media change one
   probably means sending two (?) of these out for each
   attachment. One being the old one from the loopback device itself,
   and then another one for the media change from the mdia change
   logic. That's not just noisy, but also ugly.

2. We want seqnums to be allocated for devices not only when doing
   media change (e.g. when attaching or detaching a loopback device)
   but also when allocating a block device, so that even before the
   first media change event a block device has a sequence number. This
   means allocating a sequence number for block devices won't be
   limited to the media change code anyway.

3. Doing the sequence number bumping in media change code exclusively
   kinda suggests this was something we could properly abstract away,
   to be done only there, and that the rest of the block subsystems
   wouldn#t have to bother much. But I am pretty sure that's not
   correct: in particular in the loopback block device code (but in
   other block subsystems too I guess) we really want to be able to
   atomically attach a loopback block device and return the seqnum of
   that very attachmnt so that we can focus on uevents for it. Thus,
   attachment, allocation and returning the seqnum to userspace in the
   LOOP_CONFIGURE ioctl (or whatever is appropriate) kinda go hand in
   hand.

4. The media change protocol follows a protocol along with the eject
   button handling (DISK_EVENT_EJECT_REQUEST), the locking of the tray
   and the time based polling. i.e. it's specifically focussed on
   certain hw features, none of which really apply to loopback block
   devices, which have no trays to lock, but eject buttons to handle,
   and where media change is always triggered internally by privileged
   code, never externally by the user. I doubt it makes sense to mix
   these up. Currently udev+udisks in userspace implement that
   procotol for cdroms/floppies, and I doubt we would want to bother
   to extend this for loopback devices in userspace. In fact, if media
   change events are added to loopback devices, we probably would have
   to change userspace to ignore them.

TLDR: making loopback block devices generate media is a (probably
minor, but unclear) API break, probably means duplicating uevent
traffic for it, won't abstract things away anyway, won't allocate a
seqnum on device allocation, and won't actually use anything of the
real media change functionality.

Or to say this differently: if the goal is to make loopback block
devices to send CDROM compatible media change events to userspace,
then I think it would probably make more sense to attach the
DISK_MEDIA_CHANGE=1 property to the attachment/detachment uevents the
loopback devices *already* generate, rather than to try to shoehorn the
existing media change infrastructure into the loopback device logic,
trying to reuse it even though nothing of it is really needed.

But that said, I am not aware of anyone ever asking for CDROM
compatible EDISK_MEDIA_CHANGE=1 uevents for loopback devices. I really
wouldn't bother with that. Sounds like nothing anyone want with a
chance of breaking things everywhere. (i.e. remember the
"bind"/"unbind" uevent fiasco?)

Lennart

--
Lennart Poettering, Berlin
