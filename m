Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0251E33C879
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 22:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhCOVcu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 17:32:50 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:34556 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhCOVcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:32:39 -0400
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id B1728E80100;
        Mon, 15 Mar 2021 22:32:35 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 5D27D160945; Mon, 15 Mar 2021 22:32:35 +0100 (CET)
Date:   Mon, 15 Mar 2021 22:32:35 +0100
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Boccassi <bluca@debian.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
Message-ID: <YE/ScxsHLAI49Ba1@gardel-login>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
 <20210315201824.GB2577561@casper.infradead.org>
 <20210315210452.GC2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315210452.GC2577561@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mo, 15.03.21 21:04, Matthew Wilcox (willy@infradead.org) wrote:

> On Mon, Mar 15, 2021 at 08:18:24PM +0000, Matthew Wilcox wrote:
> > On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
> > > From: Matteo Croce <mcroce@microsoft.com>
> > >
> > > Add a sequence number to the disk devices. This number is put in the
> > > uevent so userspace can correlate events when a driver reuses a device,
> > > like the loop one.
> >
> > Should this be documented as monotonically increasing?  I think this
> > is actually a media identifier.  Consider (if you will) a floppy disc.
> > Back when such things were common, it was possible with personal computers
> > of the era to have multiple floppy discs "in play" and be prompted to
> > insert them as needed.  So shouldn't it be possible to support something
> > similar here -- you're really removing the media from the loop device.
> > With a monotonically increasing number, you're always destroying the
> > media when you remove it, but in principle, it should be possible to
> > reinsert the same media and have the same media identifier number.
>
> So ... a lot of devices have UUIDs or similar.  eg:
>
> $ cat /sys/block/nvme0n1/uuid
> e8238fa6-bf53-0001-001b-448b49cec94f
>
> https://linux.die.net/man/8/scsi_id (for scsi)
>
> how about making this way more generic; create an xattr on a file to
> store the uuid (if one doesn't already exist) whenever it's used as the
> base for a loop device.  then sysfs (or whatever) can report the contents
> of that xattr as the unique id.
>
> That can be mostly in userspace -- losetup can create it, and read it.
> It can be passed in as the first two current-reserved __u64 entries in
> loop_config.  The only kernel change should be creating the sysfs
> entry /sys/block/loopN/uuid from those two array entries.

As a (part-time) maintainer of udev: as one major likely consumer of
this I'd *really* prefer some concept here that works without
`losetup` needing to be patched. i.e. we have plenty userspace that
calls LOOP_CONFIGURE or LOOP_SET_FD, not just losetup, and we'd have
to patch them all. In particular in a world of containers it's even
worse: people probably will continue to use old userspaces (mixed with
newer ones) for a very long time (decades!), and those old userpace
won't fill in the fields for the ioctl hence.

Hence, for me it would be essential to have an identifier that is
assigned by the kernel, instead of requiring userspace to assign it,
because userspace won't for a long long time.

I'd be OK with a hybrid approach where userspace *can* fill
something in, but doesn't have to in which case the kernel would fill
it in.

That all said, I very much prefer if we'd use a kernel-enforced
"sequence number" or "generation counter" or so for this instead of a
uuid or random cookie or so. Why? because it allows userspace that
monitors things to derive ordering from these ids: when you watch
these events and see a uevent for a device seqno=4711 then you know
that it is from an earlier use than one you see for seqno=8878. UUIDs
can't give you that. That's in particular a nice property since
uevents/netlink are not a reliable transport: messages can get lost
when the socket buffers overrun, or when udev as the uevent broker
gets overloaded. Hence, for a userspace program it's kinda nice to
know whether it' worth waiting for a specific loop device use or if
it's clear that ship has sailed already: i.e. if my own use of a
specific loop device gets seqno 777 then I know it still makes sense
to wait for appropriate uevents as long as I see seqno <= 776. But if
we I see seqneo >= 778 then I know it's not worth waiting anymore and
one component in the uevent message chain has dropped my messages.

But of course, beggars can't be choosers. If a seqno/generation
counter concept is not in the cards, I'd be OK with a uuid/random
cooie approach too. And if an approach where the kernel assigns these
seqnos strictly monotonically is not in the cards, then I'd be OK with
an approach where userspace can pick the ids, too. I'll take what I
can get. My primary concern is that we get something to match up
uevents, partition devices and the main block device with, and all of
the suggested approaches could deliver that.

Lennart

--
Lennart Poettering, Berlin
