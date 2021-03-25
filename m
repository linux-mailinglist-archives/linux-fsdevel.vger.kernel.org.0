Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559FE349B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 21:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhCYUwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 16:52:31 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:43152 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCYUw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 16:52:26 -0400
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 8B60CE80932;
        Thu, 25 Mar 2021 21:52:22 +0100 (CET)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id E49031608A1; Thu, 25 Mar 2021 21:52:21 +0100 (CET)
Date:   Thu, 25 Mar 2021 21:52:21 +0100
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
Message-ID: <YFz4BabOiNDcnHIm@gardel-login>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
 <20210315201824.GB2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315201824.GB2577561@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mo, 15.03.21 20:18, Matthew Wilcox (willy@infradead.org) wrote:
65;6203;1c
> On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Add a sequence number to the disk devices. This number is put in the
> > uevent so userspace can correlate events when a driver reuses a device,
> > like the loop one.
>
> Should this be documented as monotonically increasing?

I think this would be great. My usecase for this would be to match up
uevents with loopback block device attachments, because that's
basically impossible right now: you attach a loopback device to a
file, and then wait for the relevant uevents to happen, for all
partitions but you cannot do this safely right now, since loopback
block devices are heavily reused in many scenarios so you never know
if a uevent is from the attachment you created yourself or from a
previous one — or even already for the next.

If this would be documented as being monotonic this would be excellent
for this usecase: if you know that your own use of a specific loopback
device got seqno x then you know that if you see uevents for seqno < x
it makes sense to wait longer, but when you see seqno > x then you
know it's too late, somehow you lost uevents and hsould abort.

Hence: for my usecase having this strictly monotonic, and thus being
able to *order* attachments across all areas where the seqno appears
would be absolutely excellent and make this as robust as it possibly
could be.

> I think this is actually a media identifier.  Consider (if you will)
> a floppy disc.  Back when such things were common, it was possible
> with personal computers of the era to have multiple floppy discs "in
> play" and be prompted to insert them as needed.  So shouldn't it be
> possible to support something similar here -- you're really removing
> the media from the loop device.  With a monotonically increasing
> number, you're always destroying the media when you remove it, but
> in principle, it should be possible to reinsert the same media and
> have the same media identifier number.

This would be useless for my usecase, we don't really care for the
precise file being attached (which is queriable via sysfs anyway), but
we want to match up our use of the device with the uevents it
generates on itself and decendend partition block devices.

Hence: for my usecase I want something that recognizes *attachments*
and not media. If i attach the same media 3 times i want to be able to
discern the three times. And more importantly: if I attach it once and
someone else also once, then I don't want to get confused by that and
be able ti distinguish both attachments.

Morevoer, I am not even sure what media identifier would mean: if you
have one image and then copy it, is that still the same image? in your
model, should that have distinct ids? or the same, because it is from
the same common original version? and if i then modify one, what
happens then?

Finally, media usually comes with ids anyway. i.e. file systems have
uuids, GPT partition tables have meda uuids. The infrastructure for
that already exists. What we need really is something that allows us
to track attachments, not media.

(That said, I think it would make sense to bump the IDs not only on
explicit user-induced reattachments, but also when media is replaced,
i.e. bump it more often than not)

Lennart

--
Lennart Poettering, Berlin
