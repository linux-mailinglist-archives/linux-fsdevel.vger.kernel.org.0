Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C6233C823
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 22:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhCOVFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 17:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhCOVFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:05:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7048C06174A;
        Mon, 15 Mar 2021 14:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mipVcPgUrd+3HFD65EuwhnJwQPlV9zdNxH74YQjuxSk=; b=X0DFCQ9D5Q5P9elSsDANxvz6+8
        6Fzdu5livWeCHsWmwhNuOsGTKeVdpct2E/zattr8W2sGyBBNRo9ypNinmV6qdrnJ1PdYod107zgRS
        Ov3nprLAbFNrA5dNhzsOC2A5zhUmW12p6rFqzBjquiKzJf+N+nV4AKJLA9+pY9PN9cax13kc78mUq
        Eysnjb0IYlUJM/t/0ZY7BE2rRO9I5nkOv5sQoj2WNW8Rmm2BgXGYfybX19rT1grnGgMh1RvUPT2vw
        AsuDgVTwv5RV8GdacJyaCQBqj4T3Kc6mb/fJsR2yNETdZr8IJ6x3kEJmv2VWhgsyJFjGq3/kPxrol
        EiZhaiAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLuOS-000lg9-Sj; Mon, 15 Mar 2021 21:05:06 +0000
Date:   Mon, 15 Mar 2021 21:04:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH -next 1/5] block: add disk sequence number
Message-ID: <20210315210452.GC2577561@casper.infradead.org>
References: <20210315200242.67355-1-mcroce@linux.microsoft.com>
 <20210315200242.67355-2-mcroce@linux.microsoft.com>
 <20210315201824.GB2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315201824.GB2577561@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 08:18:24PM +0000, Matthew Wilcox wrote:
> On Mon, Mar 15, 2021 at 09:02:38PM +0100, Matteo Croce wrote:
> > From: Matteo Croce <mcroce@microsoft.com>
> > 
> > Add a sequence number to the disk devices. This number is put in the
> > uevent so userspace can correlate events when a driver reuses a device,
> > like the loop one.
> 
> Should this be documented as monotonically increasing?  I think this
> is actually a media identifier.  Consider (if you will) a floppy disc.
> Back when such things were common, it was possible with personal computers
> of the era to have multiple floppy discs "in play" and be prompted to
> insert them as needed.  So shouldn't it be possible to support something
> similar here -- you're really removing the media from the loop device.
> With a monotonically increasing number, you're always destroying the
> media when you remove it, but in principle, it should be possible to
> reinsert the same media and have the same media identifier number.

So ... a lot of devices have UUIDs or similar.  eg:

$ cat /sys/block/nvme0n1/uuid 
e8238fa6-bf53-0001-001b-448b49cec94f

https://linux.die.net/man/8/scsi_id (for scsi)

how about making this way more generic; create an xattr on a file to
store the uuid (if one doesn't already exist) whenever it's used as the
base for a loop device.  then sysfs (or whatever) can report the contents
of that xattr as the unique id.

That can be mostly in userspace -- losetup can create it, and read it.
It can be passed in as the first two current-reserved __u64 entries in
loop_config.  The only kernel change should be creating the sysfs
entry /sys/block/loopN/uuid from those two array entries.

