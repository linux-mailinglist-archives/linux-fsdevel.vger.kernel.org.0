Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC7349B55
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 21:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhCYU7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 16:59:02 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:43180 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhCYU6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:58:45 -0400
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 8EDABE80A76;
        Thu, 25 Mar 2021 21:58:42 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 3914A1608A1; Thu, 25 Mar 2021 21:58:42 +0100 (CET)
Date:   Thu, 25 Mar 2021 21:58:42 +0100
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
Message-ID: <YFz5gjRDtrW6RxFk@gardel-login>
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

I prefer seqnos over uuids because we can order them when we see a
bunch of uevents for the same loopback device with their seqnos, as
mentioned in that other mail.

But beggars can't be choosers. If we could propagate some uuid from
the loopback setup ioctl into the device so that that appears via
sysfs that would work too for me, but not as robustly, since we lack
the ordering to detect whether it's worth waiting for more uevents or
if already somebody else took possesion of the device.

TLDR: seqnos FTW! but uuids assigned at attachment time is better than
nothing.

Lennart

--
Lennart Poettering, Berlin
