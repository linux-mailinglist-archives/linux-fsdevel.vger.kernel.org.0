Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24DB3B1C0C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFWOKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFWOKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:10:16 -0400
X-Greylist: delayed 1002 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Jun 2021 07:07:57 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E97C061574;
        Wed, 23 Jun 2021 07:07:56 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id A3933E8094B;
        Wed, 23 Jun 2021 16:07:54 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 4A707160DC0; Wed, 23 Jun 2021 16:07:54 +0200 (CEST)
Date:   Wed, 23 Jun 2021 16:07:54 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 0/6] block: add a sequence number to disks
Message-ID: <YNNAOpBsruHGCBIX@gardel-login>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <bfdd6f56-ce2b-ef74-27b1-83b922e5f7d9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdd6f56-ce2b-ef74-27b1-83b922e5f7d9@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 23.06.21 14:03, Hannes Reinecke (hare@suse.de) wrote:

> On 6/23/21 12:58 PM, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > With this series a monotonically increasing number is added to disks,
> > precisely in the genhd struct, and it's exported in sysfs and uevent.
> >
> > This helps the userspace correlate events for devices that reuse the
> > same device, like loop.
> >
> I'm failing to see the point here.
> Apparently you are assuming that there is a userspace tool tracking events,
> and has a need to correlate events related to different instances of the
> disk.
> But if you have an userspace application tracking events, why can't the same
> application track the 'add' and 'remove' events to track the lifetime of the
> devices, and implement its own numbering based on that?
>
> Why do we need to burden the kernel with this?

The problem is that tracking the "add" and "remove" events is simply
not safely possibly right now for block devices whose names are
frequently reused.

Consider the loopback block device subsystem: whenever some tool wants
a loopback block device it will ask the kernel for one and the kernel
allocates from the bottom, hence /dev/loop0 is the most frequently
used loopback block device. If a large number of concurrently running
programs now repeatedly/quickly allocate/deallocate block devices they
all sooner or later get /dev/loop0. If they now want to watch the
"add" and "remove" uevents for that device for their own use of it
there's a very good chance they'll end up seeing the previous user's
"add" and "remove" events, as there's simply no way to associate the
uevents you see with *your* *own* use of /dev/loop0 right now, and
distinguish them from the uevent that might have been queued from a
prior use of /dev/loop0 and were just slow to be processed.

or to say this differently: loopback devices are named from a very
small, dense pool of names, and are frequently and quickly
reused. uevents are enqeued asynchronously and potentially take a long
time to reach the listeners (after all they have to travel through two
AF_NETLINK sockets and udev) and the only way to match up the device
uses and their uevents is by these kernel device names that are so
useless as a stable identifier.

This not only applies to loopback block devices, but many other block
device subsystems too. For example nbd allocates from the bottom, too,
i.e. /dev/nbd0 is the most like name to be used. And for SCSI devices
too: if you quickly plug/unplug/replug a bunch of USB sticks, you'll
likely always get /dev/sda...

Lennart

--
Lennart Poettering, Berlin
