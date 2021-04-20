Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447683660AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhDTUMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 16:12:52 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:34164 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhDTUMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:12:52 -0400
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 9EB00E8098F;
        Tue, 20 Apr 2021 22:12:15 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 2A6EE1604AE; Tue, 20 Apr 2021 22:12:15 +0200 (CEST)
Date:   Tue, 20 Apr 2021 22:12:15 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Boccassi <bluca@debian.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz?lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
Message-ID: <YH81n34d2G3C4Re+@gardel-login>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
 <20210315201824.GB2577561@casper.infradead.org>
 <20210316141326.GA37773@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316141326.GA37773@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Di, 16.03.21 14:13, Christoph Hellwig (hch@infradead.org) wrote:

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
> And we have some decent infrastructure related to media changes,
> grep for disk_events.  I think this needs to plug into that
> infrastructure instead of duplicating it.

I'd argue this makes sense in one way only, i.e. that whenever the
media_change event is seen the seqnum is implicitly bumped.

I am pretty sure though that loopback devices shouldn't synthesize
media_change events themselves though. There's quite a difference I
would argue between a real media change event caused by external
effect (i.e. humans/hw buttons/sensors) to loop device reuse, which is
exclusively triggered by internal events (i.e. local code). Moreover I
think the loopback subsystem should manage the seqnum on its own,
since it ideally would return the assigned seqnum immediately from the
attachment ioctl, i.e. it shouldn't just be a side-effect of
attachment, but a part of it, if you follow what I mean.

Does that make sense?

Matteo, would it make sense to extend your patch set to bump the
seqnum implicitly on media_change for devices that implement that?

Lennart
