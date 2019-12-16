Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1744121455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 19:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfLPSK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 13:10:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38938 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730601AbfLPSK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576519825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h6VrGNpFemlDLaD9vxutvKkD8W8dnGU6FQoXLjmTtYc=;
        b=MGVJp9fdfHKW74NasqGgIWWe0keJb+lwiPC1+Wh5o+lUiS+mNQ+JqUR6T0yAOaZN2/2G2K
        vbNZ/Jp8K+kfrqQRZubZLzxDZlQ2ZplSTTafntl8yMFGGm6E8Vbdj2FdmV4Y6pr8Uqi9D1
        wCwrmtI9jkoHTmtjUDuKFrrF/+DbUPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-hZe2nHW0NpqB8uv36jRMYQ-1; Mon, 16 Dec 2019 13:10:21 -0500
X-MC-Unique: hZe2nHW0NpqB8uv36jRMYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C0F91800D7B;
        Mon, 16 Dec 2019 18:10:20 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03A7D68863;
        Mon, 16 Dec 2019 18:10:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7F15F220A24; Mon, 16 Dec 2019 13:10:14 -0500 (EST)
Date:   Mon, 16 Dec 2019 13:10:14 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20191216181014.GA30106@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-2-vgoyal@redhat.com>
 <20190826115152.GA21051@infradead.org>
 <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:04:11PM -0700, Dan Williams wrote:
> On Wed, Aug 28, 2019 at 3:53 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Aug 28, 2019 at 01:58:43PM -0400, Vivek Goyal wrote:
> > > On Tue, Aug 27, 2019 at 11:58:09PM -0700, Christoph Hellwig wrote:
> > > > On Tue, Aug 27, 2019 at 12:38:28PM -0400, Vivek Goyal wrote:
> > > > > > For bdev_dax_pgoff
> > > > > > I'd much rather have the partition offset if there is on in the daxdev
> > > > > > somehow so that we can get rid of the block device entirely.
> > > > >
> > > > > IIUC, there is one block_device per partition while there is only one
> > > > > dax_device for the whole disk. So we can't directly move bdev logical
> > > > > offset into dax_device.
> > > >
> > > > Well, then we need to find a way to get partitions for dax devices,
> > > > as we really should not expect a block device hiding behind a dax
> > > > dev.  That is just a weird legacy assumption - block device need to
> > > > layer on top of the dax device optionally.
> > > >
> > > > >
> > > > > We probably could put this in "iomap" and leave it to filesystems to
> > > > > report offset into dax_dev in iomap that way dax generic code does not
> > > > > have to deal with it. But that probably will be a bigger change.
> > > >
> > > > And where would the file system get that information from?
> > >
> > > File system knows about block device, can it just call get_start_sect()
> > > while filling iomap->addr. And this means we don't have to have
> > > parition information in dax device. Will something like following work?
> > > (Just a proof of concept patch).
> > >
> > >
> > > ---
> > >  drivers/dax/super.c |   11 +++++++++++
> > >  fs/dax.c            |    6 +++---
> > >  fs/ext4/inode.c     |    6 +++++-
> > >  include/linux/dax.h |    1 +
> > >  4 files changed, 20 insertions(+), 4 deletions(-)
> > >
> > > Index: rhvgoyal-linux/fs/ext4/inode.c
> > > ===================================================================
> > > --- rhvgoyal-linux.orig/fs/ext4/inode.c       2019-08-28 13:51:16.051937204 -0400
> > > +++ rhvgoyal-linux/fs/ext4/inode.c    2019-08-28 13:51:44.453937204 -0400
> > > @@ -3589,7 +3589,11 @@ retry:
> > >                       WARN_ON_ONCE(1);
> > >                       return -EIO;
> > >               }
> > > -             iomap->addr = (u64)map.m_pblk << blkbits;
> > > +             if (IS_DAX(inode))
> > > +                     iomap->addr = ((u64)map.m_pblk << blkbits) +
> > > +                                   (get_start_sect(iomap->bdev) * 512);
> > > +             else
> > > +                     iomap->addr = (u64)map.m_pblk << blkbits;
> >
> > I'm not a fan of returning a physical device sector address from an
> > interface where ever other user/caller expects this address to be a
> > logical block address into the block device. It creates a landmine
> > in the iomap API that callers may not be aware of and that's going
> > to cause bugs. We're trying really hard to keep special case hacks
> > like this out of the iomap infrastructure, so on those grounds alone
> > I'd suggest this is a dead end approach.
> >
> > Hence I think that if the dax device needs a physical offset from
> > the start of the block device the filesystem sits on, it should be
> > set up at dax device instantiation time and so the filesystem/bdev
> > never needs to be queried again for this information.
> >
> 
> Agree. In retrospect it was my laziness in the dax-device
> implementation to expect the block-device to be available.
> 
> It looks like fs_dax_get_by_bdev() is an intercept point where a
> dax_device could be dynamically created to represent the subset range
> indicated by the block-device partition. That would open up more
> cleanup opportunities.

Hi Dan,

After a long time I got time to look at it again. Want to work on this
cleanup so that I can make progress with virtiofs DAX paches.

I am not sure I understand the requirements fully. I see that right now
dax_device is created per device and all block partitions refer to it. If
we want to create one dax_device per partition, then it looks like this
will be structured more along the lines how block layer handles disk and
partitions. (One gendisk for disk and block_devices for partitions,
including partition 0). That probably means state belong to whole device
will be in common structure say dax_device_common, and per partition state
will be in dax_device and dax_device can carry a pointer to
dax_device_common.

I am also not sure what does it mean to partition dax devices. How will
partitions be exported to user space.

Thanks
Vivek

