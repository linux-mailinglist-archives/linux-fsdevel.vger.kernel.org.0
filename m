Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F733B1DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhFWPvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 11:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWPvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:51:19 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21FC061574;
        Wed, 23 Jun 2021 08:49:01 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 81C79E8094B;
        Wed, 23 Jun 2021 17:48:57 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 4239A160DC0; Wed, 23 Jun 2021 17:48:57 +0200 (CEST)
Date:   Wed, 23 Jun 2021 17:48:57 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
Message-ID: <YNNX6U5Ui95ZEJnw@gardel-login>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
 <YNM8T44v5FTViVWM@gardel-login>
 <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
 <YNNBOyUiztf2wxDu@gardel-login>
 <adeedcd2-15a7-0655-3b3c-85eec719ed37@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adeedcd2-15a7-0655-3b3c-85eec719ed37@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 23.06.21 17:02, Hannes Reinecke (hare@suse.de) wrote:

> > you imply it was easy to know which device use a uevent belongs
> > to. But that's the problem: it is not possible to do so safely. if i
> > see a uevent for a block device "loop0" I cannot tell if it was from
> > my own use of the device or for some previous user of it.
> >
> > And that's what we'd like to see fixed: i.e. we query the block device
> > for the seqeno now used and then we can use that to filter the uevents
> > and ignore the ones that do not carry the same sequence number as we
> > got assigned for our user.
>
> It is notoriously tricky to monitor the intended use-case for kernel
> devices, precisely because we do _not_ attach any additional information to
> it.
> I have send a proposal for LSF to implement block-namespaces, the prime
> use-case of which is indeed attaching cgroup/namespace information to block
> devices such that we _can_ match (block) devices to specific
> contexts.

The goal of the patchset is to make loopback block devices (and
similar) safely and robustly concurrently allocatable from the main OS
namespace, without any cgroup/containerization logic.

In systemd we want to be able to allocate loopback block devices from
any context, and concurrently without having to set up a
cgroup/namespace first for each user for it. Any approach that binds
two distinct subsystems like this together (e.g. "you need to set up
cgroups to safely allocate loopback block devices") is really
problematic for us, since we manage both, but independently and always
with minimal privileges.

> Which I rather prefer than adding sequence numbers to block devices;
> incidentally you could solve the same problem by _not_ reusing numbers
> aggressively but rather allocate the next free one after the most recently
> allocated one.

You are suggesting that instead of allocating loopback block devices
always from the "bottom", i.e. always handing out from "loop0" on,
with the lowest preferred we'd just always hand out "loop1", "loop2",
… with strictly monotonically increasing numbres and never reuse
"loop0" anymore and other names we already handed out? That would
certainly work, but this would require quite some kernel rework, since
the loopbck allocation API is really not designed to work like that
right now.

Moreover, the proposed sequence number stuff also covers
floppies/cdroms and other stuff nicely, i.e. where drives stick around
but their media changes. Also, USB sticks are currently effectively
always called /dev/sda. It would be great to be able to distinguish
each plug/replug too. Of course, you could argue that there too
/dev/sda should never be reused, but strictly monotonically increasing
/dev/sdb, /dev/sdc, …  and so on, and I'd sympathize with that, but
that makes it a major kernel rework, because basically every block
subsystem would have to be reworked to never reuse block device names
anymore.

Also, i doubt people would be happy if they then regularly would have
to deal with device names such as /dev/loop84763874658743 or
/dev/sdzbghz just because their system has been running for a while.

> The better alternative here would be to extend the loop ioctl to pass in an
> UUID when allocating the device.
> That way you can easily figure out whether the loop device has been
> modified.

UUIDs instead of sequence numbers would mostly solve our probelms
too. i.e. chaotic, randomized assignment of identifiers instead of
linearly progressing assignment of idenitifers. However I prefer
sequence numbers as discussed in this thread before: they allow us to
derive ordering from things: thus if you see an uevent with a seqnum
smaller than the one you are interested in you know its worth waiting
for the ones you are looking for to appear. But if you see a uevent
with a seqnum greater than the one you are interested in then you know
it's pointless to wait, the device has already been acquired by
someone else. With randomized UUIDs you can't know that, since uses by
other participants are only recognizable as distinct from your own but
don't tell you if they are earlier or later than your own. After all
the AF_NETLINK/uevent socket is lossy, so you must be prepared for
dropped messages, hence it's reat if we can easily resync when your
own messages get dropped.

Lennart

--
Lennart Poettering, Berlin
