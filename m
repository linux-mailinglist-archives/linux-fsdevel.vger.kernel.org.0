Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9593D22DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 13:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGVLB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 07:01:56 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38814 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhGVLBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:01:55 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by linux.microsoft.com (Postfix) with ESMTPSA id C9CAC20B8016;
        Thu, 22 Jul 2021 04:42:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9CAC20B8016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626954150;
        bh=sGwLum2AxhbtrpJ7xqyEMr2W/f/xXktE5uFvk0yKiMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=etVlz2pz2TaOE+R96P1w4ctlor8huZ3CIJ/Q8Qwx1k2+QfrdKxyAh17pJlpuF9ZVN
         c41fv0aoV6GXB8/NbJ0phlK18M8YRCnsjp3cYTpTBLqWrElAfNMQdO2bZg99Slp3LS
         UVGOcqT9TzAHjaBPx8yIluVr8bP7HR0fCX1HZchY=
Received: by mail-pj1-f52.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so5096611pju.1;
        Thu, 22 Jul 2021 04:42:30 -0700 (PDT)
X-Gm-Message-State: AOAM530eJEgVA6KTEtFrwqoNbGdEMytrHMe4c536RRoWHjm7T1niBIFe
        aUHfEEr8qpl3cn+YRHxj7+sSRQzsXDz9EQahHx8=
X-Google-Smtp-Source: ABdhPJzz4jFqHprYZm/Tu2+suDDmD9tWwVgUUCAvbfXUJw8mK1tkTXu6QD2LFCMB2NC9biNaXqVJpmykWKoowtucTB8=
X-Received: by 2002:a17:902:bf47:b029:12b:afd0:e39 with SMTP id
 u7-20020a170902bf47b029012bafd00e39mr1282903pls.19.1626954150202; Thu, 22 Jul
 2021 04:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210712230530.29323-1-mcroce@linux.microsoft.com> <3ca56654449b53814a22e3f06179292bc959ae72.camel@debian.org>
In-Reply-To: <3ca56654449b53814a22e3f06179292bc959ae72.camel@debian.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Thu, 22 Jul 2021 13:41:54 +0200
X-Gmail-Original-Message-ID: <CAFnufp2RmL3CQBJOmZgfsLEPKJ7g_qWJibzEhnMadhs=xC7mQw@mail.gmail.com>
Message-ID: <CAFnufp2RmL3CQBJOmZgfsLEPKJ7g_qWJibzEhnMadhs=xC7mQw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] block: add a sequence number to disks
To:     Luca Boccassi <bluca@debian.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:27 PM Luca Boccassi <bluca@debian.org> wrote:
>
> On Tue, 2021-07-13 at 01:05 +0200, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> >
> > Associating uevents with block devices in userspace is difficult and racy:
> > the uevent netlink socket is lossy, and on slow and overloaded systems has
> > a very high latency. Block devices do not have exclusive owners in
> > userspace, any process can set one up (e.g. loop devices). Moreover, device
> > names can be reused (e.g. loop0 can be reused again and again). A userspace
> > process setting up a block device and watching for its events cannot thus
> > reliably tell whether an event relates to the device it just set up or
> > another earlier instance with the same name.
> >
> > Being able to set a UUID on a loop device would solve the race conditions.
> > But it does not allow to derive orderings from uevents: if you see a uevent
> > with a UUID that does not match the device you are waiting for, you cannot
> > tell whether it's because the right uevent has not arrived yet, or it was
> > already sent and you missed it. So you cannot tell whether you should wait
> > for it or not.
> >
> > Being able to set devices up in a namespace would solve the race conditions
> > too, but it can work only if being namespaced is feasible in the first
> > place. Many userspace processes need to set devices up for the root
> > namespace, so this solution cannot always work.
> >
> > Changing the loop devices naming implementation to always use
> > monotonically increasing device numbers, instead of reusing the lowest
> > free number, would also solve the problem, but it would be very disruptive
> > to userspace and likely break many existing use cases. It would also be
> > quite awkward to use on long-running machines, as the loop device name
> > would quickly grow to many-digits length.
> >
> > Furthermore, this problem does not affect only loop devices - partition
> > probing is asynchronous and very slow on busy systems. It is very easy to
> > enter races when using LO_FLAGS_PARTSCAN and watching for the partitions to
> > show up, as it can take a long time for the uevents to be delivered after
> > setting them up.
> >
> > Associating a unique, monotonically increasing sequential number to the
> > lifetime of each block device, which can be retrieved with an ioctl
> > immediately upon setting it up, allows to solve the race conditions with
> > uevents, and also allows userspace processes to know whether they should
> > wait for the uevent they need or if it was dropped and thus they should
> > move on.
> >
> > This does not benefit only loop devices and block devices with multiple
> > partitions, but for example also removable media such as USB sticks or
> > cdroms/dvdroms/etc.
> >
> > The first patch is the core one, the 2..4 expose the information in
> > different ways, and the last one makes the loop device generate a media
> > changed event upon attach, detach or reconfigure, so the sequence number
> > is increased.
> >
> > If merged, this feature will immediately used by the userspace:
> > https://github.com/systemd/systemd/issues/17469#issuecomment-762919781
> >
> > v4 -> v5:
> > - introduce a helper to raise media changed events
> > - use the new helper in loop instead of the full event code
> > - unexport inc_diskseq() which is only used by the block code now
> > - rebase on top of 5.14-rc1
> >
> > v3 -> v4:
> > - rebased on top of 5.13
> > - hook the seqnum increase into the media change event
> > - make the loop device raise media change events
> > - merge 1/6 and 5/6
> > - move the uevent part of 1/6 into a separate one
> > - drop the now unneeded sysfs refactor
> > - change 'diskseq' to a global static variable
> > - add more comments
> > - refactor commit messages
> >
> > v2 -> v3:
> > - rebased on top of 5.13-rc7
> > - resend because it appeared archived on patchwork
> >
> > v1 -> v2:
> > - increase seqnum on media change
> > - increase on loop detach
> >
> > Matteo Croce (6):
> >   block: add disk sequence number
> >   block: export the diskseq in uevents
> >   block: add ioctl to read the disk sequence number
> >   block: export diskseq in sysfs
> >   block: add a helper to raise a media changed event
> >   loop: raise media_change event
> >
> >  Documentation/ABI/testing/sysfs-block | 12 ++++++
> >  block/disk-events.c                   | 62 +++++++++++++++++++++------
> >  block/genhd.c                         | 43 +++++++++++++++++++
> >  block/ioctl.c                         |  2 +
> >  drivers/block/loop.c                  |  5 +++
> >  include/linux/genhd.h                 |  3 ++
> >  include/uapi/linux/fs.h               |  1 +
> >  7 files changed, 114 insertions(+), 14 deletions(-)
>
> For the series:
>
> Tested-by: Luca Boccassi <bluca@debian.org>
>
> I have implemented the basic systemd support for this (ioctl + uevent,
> sysfs will be done later), and tested with this series on x86_64 and
> Debian 11 userspace, everything seems to work great. Thanks Matteo!
>
> Here's the implementation, in draft state until the kernel side is
> merged:
>
> https://github.com/systemd/systemd/pull/20257
>

Hi Jens,

Given that the whole series has been acked and tested, and the
userspace has a draft implementation for it, is there anything else we
can do here?

Regards,
-- 
per aspera ad upstream
