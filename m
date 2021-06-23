Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54203B1CEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWO5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:57:35 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:53798 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWO5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:57:34 -0400
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 2AE4FE8094B;
        Wed, 23 Jun 2021 16:55:15 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id CEA8B160DC0; Wed, 23 Jun 2021 16:55:14 +0200 (CEST)
Date:   Wed, 23 Jun 2021 16:55:14 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Luca Boccassi <bluca@debian.org>,
        Matteo Croce <mcroce@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
Message-ID: <YNNLUnGMO/gNNIJK@gardel-login>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
 <YNM8T44v5FTViVWM@gardel-login>
 <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
 <1b55bc67b75e5cf982c0c1e8f45096f2eb6e8590.camel@debian.org>
 <f84cab19-fb5c-634b-d1ca-51404907a623@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f84cab19-fb5c-634b-d1ca-51404907a623@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 23.06.21 16:21, Hannes Reinecke (hare@suse.de) wrote:

> > We need this so that we can reliably correlate events to instances of a
> > device. Events alone cannot solve this problem, because events _are_
> > the problem.
> >
> In which sense?
> Yes, events can be delayed (if you list to uevents), but if you listen to
> kernel events there shouldn't be a delay, right?

uevents are delivered to userpace via an AF_NETLINK socket. The
AF_NETLINK socket is basically an asynchronous buffer.

I mean, consider what you are saying: you establish the AF_NETLINK
uevent watching socket, then you allocate /dev/loop0. Since you cannot
do that atomically, you'll first have to do one, and then the
other. But if you do that in two steps, then in the middle some other
process might get scheduled that quickly allocates /dev/loop0 and
releases it again, before your code gets to run. So now you have in
your AF_NETLINK socket buffer the uevents for that other process' use
of the device, and you cannot sanely distinguish them from your own.

of course you could do it the other way: allocate the device first,
and only then allocate the AF_NETLINK uevent socket. But then you
might or might not lose the "add" event for the device you just
allocated. And you don't know if you should wait for it or not.

This isn't even a constructed issue, this is the common case if you
have multiple processes all simultaneously trying to acquire a loopback
block device, because they all will end up eying /dev/loop0 at the same time.

But it gets worse IRL because of various factors. For example,
partition probing is asynchronous, so if you use LO_FLAGS_PARTSCAN and
want to watch for some partition device associated to your loopback
block device to show up, this can take *really* long, so the race
window is large. Or you actually use udev (like most userspace
probably should) because you want the metainfo it collects about the
device, in which case it will take even longer for the uevent to reach
you, i.e. the time window where a previous user's uevents and your own
for the same loopback device "overlap" can be quite large and you
cannot determine if they are yours or the previous user's uevents —
unless we have these new sequence numbers.

Lennart

--
Lennart Poettering, Berlin
