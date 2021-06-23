Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0093B1BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFWOAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:00:31 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:53724 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhFWOAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:00:30 -0400
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 10:00:30 EDT
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 3DC0EE8094B;
        Wed, 23 Jun 2021 15:51:12 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id EEA28160DC0; Wed, 23 Jun 2021 15:51:11 +0200 (CEST)
Date:   Wed, 23 Jun 2021 15:51:11 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Boccassi <bluca@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
Message-ID: <YNM8T44v5FTViVWM@gardel-login>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
 <20210623105858.6978-2-mcroce@linux.microsoft.com>
 <YNMffBWvs/Fz2ptK@infradead.org>
 <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mi, 23.06.21 15:10, Matteo Croce (mcroce@linux.microsoft.com) wrote:

> On Wed, Jun 23, 2021 at 1:49 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Jun 23, 2021 at 12:58:53PM +0200, Matteo Croce wrote:
> > > +void inc_diskseq(struct gendisk *disk)
> > > +{
> > > +     static atomic64_t diskseq;
> >
> > Please don't hide file scope variables in functions.
> >
>
> I just didn't want to clobber that file namespace, as that is the only
> point where it's used.
>
> > Can you explain a little more why we need a global sequence count vs
> > a per-disk one here?
>
> The point of the whole series is to have an unique sequence number for
> all the disks.
> Events can arrive to the userspace delayed or out-of-order, so this
> helps to correlate events to the disk.
> It might seem strange, but there isn't a way to do this yet, so I come
> up with a global, monotonically incrementing number.

To extend on this and given an example why the *global* sequence number
matters:

Consider you plug in a USB storage key, and it gets named
/dev/sda. You unplug it, the kernel structures for that device all
disappear. Then you plug in a different USB storage key, and since
it's the only one it will too be called /dev/sda.

With the global sequence number we can still distinguish these two
devices even though otherwise they can look pretty much identical. If
we had per-device counters then this would fall flat because the
counter would be flushed out when the device disappears and when a device
reappears under the same generic name we couldn't assign it a
different sequence number than before.

Thus: a global instead of local sequence number counter is absolutely
*key* for the problem this is supposed to solve

Lennart

--
Lennart Poettering, Berlin
