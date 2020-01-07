Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95931132DE4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgAGSBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 13:01:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728391AbgAGSBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578420072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCioPbrHOnFEeTCk1vgQEdBJULoDBPQbI4x0bUxfuB4=;
        b=MhzG/3+uZjPRj2Ux8J4t4UYKXQ3fW3qdWjsC/U1rM0rMOsTi5YNymJuLsyTPppXogNlypn
        LhTIKP/CiTUJgtmNv6qLP8mA6MFT0vJJjMmjbtXTcrjpeqn+mzQxuK7sw2sNvQ2twwjs7+
        L4URlrU6Y4Cy+MGY/Ci5rpteItvKEmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Nxn0akJlOCG4ursA8-8saw-1; Tue, 07 Jan 2020 13:01:08 -0500
X-MC-Unique: Nxn0akJlOCG4ursA8-8saw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54EC0593A4;
        Tue,  7 Jan 2020 18:01:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B58E60C88;
        Tue,  7 Jan 2020 18:01:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CA8892202E9; Tue,  7 Jan 2020 13:01:01 -0500 (EST)
Date:   Tue, 7 Jan 2020 13:01:01 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200107180101.GC15920@redhat.com>
References: <20190827163828.GA6859@redhat.com>
 <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
 <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia>
 <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > >
> > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > implementation to expect the block-device to be available.
> > > > > >
> > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > indicated by the block-device partition. That would open up more
> > > > > > cleanup opportunities.
> > > > >
> > > > > Hi Dan,
> > > > >
> > > > > After a long time I got time to look at it again. Want to work on this
> > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > >
> > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > we want to create one dax_device per partition, then it looks like this
> > > > > will be structured more along the lines how block layer handles disk and
> > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > including partition 0). That probably means state belong to whole device
> > > > > will be in common structure say dax_device_common, and per partition state
> > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > dax_device_common.
> > > > >
> > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > partitions be exported to user space.
> > > >
> > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > devices and then remove them after a cycle or two?
> > >
> > > That does seem a better plan than trying to force partition support
> > > where it is not needed.
> >
> > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > create dm-linear devices for each partition, will DAX still work through
> > that?
> 
> The device-mapper support will continue, but it will be limited to
> whole device sub-components. I.e. you could use kpartx to carve up
> /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.

So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
is a block device, I thought tools will expect it to be partitioned.
Sometimes I create those partitions and use /dev/pmem0. So what's
the replacement for this. People often have tools/scripts which might
want to partition the device and these will start failing. 

IOW, I do not understand that why being able to partition /dev/pmem0
(which is a block device from user space point of view), is pointless.

Thanks
Vivek

