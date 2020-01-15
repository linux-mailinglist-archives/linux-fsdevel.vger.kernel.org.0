Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 475BF13CD8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgAOT4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 14:56:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22264 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729593AbgAOT4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579118189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFz2DGgnuoyO/vc+L4OwV72STrnhF4EdxNMzsd8pbN0=;
        b=IqzVONjdzHNKNs5wL5uhR7v5VVizrQhBiu1gU719XonOma1vsrOl4OMHEBg0sVYxf328sW
        fZSoocSDqDgL5H3SdPGJvq5SBxbtNuACkfxqOuDqCl4fY0Sn9hISkSuF7uYQiuFHkwtb+E
        kbyLBf6HlpnKvYoISWcymtlQAjsmnyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-C1mMTu0JOJ6LM089s9cTWA-1; Wed, 15 Jan 2020 14:56:25 -0500
X-MC-Unique: C1mMTu0JOJ6LM089s9cTWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DE0C10054E3;
        Wed, 15 Jan 2020 19:56:23 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA40E108132E;
        Wed, 15 Jan 2020 19:56:17 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 565B9220A24; Wed, 15 Jan 2020 14:56:17 -0500 (EST)
Date:   Wed, 15 Jan 2020 14:56:17 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200115195617.GA4133@redhat.com>
References: <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
 <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:23:04PM -0800, Dan Williams wrote:
> On Tue, Jan 14, 2020 at 1:28 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jan 14, 2020 at 12:39:00PM -0800, Dan Williams wrote:
> > > On Tue, Jan 14, 2020 at 12:31 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> > > > > On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
> > > > > >
> > > > > > On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > > > > > > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > > > > > > dax code refers back to block device to figure out partition offset in
> > > > > > > > dax device. If we create a dax object corresponding to "struct block_device"
> > > > > > > > and store sector offset in that, then we could pass that object to dax
> > > > > > > > code and not worry about referring back to bdev. I have written some
> > > > > > > > proof of concept code and called that object "dax_handle". I can post
> > > > > > > > that code if there is interest.
> > > > > > >
> > > > > > > I don't think it's worth it in the end especially considering
> > > > > > > filesystems are looking to operate on /dev/dax devices directly and
> > > > > > > remove block entanglements entirely.
> > > > > > >
> > > > > > > > IMHO, it feels useful to be able to partition and use a dax capable
> > > > > > > > block device in same way as non-dax block device. It will be really
> > > > > > > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > > > > > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > > > > > > will work.
> > > > > > >
> > > > > > > That can already happen today. If you do not properly align the
> > > > > > > partition then dax operations will be disabled. This proposal just
> > > > > > > extends that existing failure domain to make all partitions fail to
> > > > > > > support dax.
> > > > > >
> > > > > > Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> > > > > > decides to create partitions on it for whatever (possibly misguided)
> > > > > > reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> > > > > > partition alignment is so obvious and widespread that I don't count it as a
> > > > > > realistic error case sysadmins would be pondering about currently.
> > > > > >
> > > > > > So I'd find two options reasonably consistent:
> > > > > > 1) Keep status quo where partitions are created and support DAX.
> > > > > > 2) Stop partition creation altogether, if anyones wants to split pmem
> > > > > > device further, he can use dm-linear for that (i.e., kpartx).
> > > > > >
> > > > > > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > > > > > feasible without angry users and Linus reverting the change.
> > > > >
> > > > > Christoph? I feel myself leaning more and more to the "keep pmem
> > > > > partitions" camp.
> > > > >
> > > > > I don't see "drop partition support" effort ending well given the long
> > > > > standing "ext4 fails to mount when dax is not available" precedent.
> > > > >
> > > > > I think the next least bad option is to have a dax_get_by_host()
> > > > > variant that passes an offset and length pair rather than requiring a
> > > > > later bdev_dax_pgoff() to recall the offset. This also prevents
> > > > > needing to add another dax-device object representation.
> > > >
> > > > I am wondering what's the conclusion on this. I want to this to make
> > > > progress in some direction so that I can make progress on virtiofs DAX
> > > > support.
> > >
> > > I think we should at least try to delete the partition support and see
> > > if anyone screams. Have a module option to revert the behavior so
> > > people are not stuck waiting for the revert to land, but if it stays
> > > quiet then we're in a better place with that support pushed out of the
> > > dax core.
> >
> > Hi Dan,
> >
> > So basically keep partition support code just that disable it by default
> > and it is enabled by some knob say kernel command line option/module
> > option.
> 
> Yes.
> 
> > At what point of time will we remove that code completely. I mean what
> > if people scream after two kernel releases, after we have removed the
> > code.
> 
> I'd follow the typical timelines of Documentation/ABI/obsolete which
> is a year or more.
> 
> >
> > Also, from distribution's perspective, we might not hear from our
> > customers for a very long time (till we backport that code in to
> > existing releases or release this new code in next major release). From
> > that view point I will not like to break existing user visible behavior.
> >
> > How bad it is to keep partition support around. To me it feels reasonaly
> > simple where we just have to store offset into dax device into another
> > dax object:
> 
> If we end up keeping partition support, we're not adding another object.
> 
> > and pass that object around (instead of dax_device). If that's
> > the case, I am not sure why to even venture into a direction where some
> > user's setup might be broken.
> 
> It was a mistake to support them. If that mistake can be undone
> without breaking existing deployments the code base is better off
> without the concept.
> 
> > Also from an application perspective, /dev/pmem is a block device, so it
> > should behave like a block device, (including kernel partition table support).
> > From that view, dax looks like just an additional feature of that device
> > which can be enabled by passing option "-o dax".
> 
> dax via block devices was a crutch that we leaned on too heavily, and
> the implementation has slowly been moving away from it ever since.
> 
> > IOW, can we reconsider the idea of not supporting kernel partition tables
> > for dax capable block devices. I can only see downsides of removing kernel
> > partition table support and only upside seems to be little cleanup of dax
> > core code.
> 
> Can you help find end users that depend on it?

I can't think of a real user at this point of time. Just that I am
concerned, once the change goes in, somebody will get affected at later
point of time and comes out complainig and this change will be seen as
breaking user space and hence regression.

> Even the Red Hat
> installation guide example shows mounting on pmem0 directly. [1]

Below that example it also says.

"When creating partitions on a pmem device to be used for direct access,
partitions must be aligned on page boundaries. On the Intel 64 and AMD64
architecture, at least 4KiB alignment for the start and end of the
partition, but 2MiB is the preferred alignment. By default, the parted
tool aligns partitions on 1MiB boundaries. For the first partition,
specify 2MiB as the start of the partition. If the size of the partition
is a multiple of 2MiB, all other partitions are also aligned."

So documentation is clearly saying dax will work with partitions as well.
And some user might decide to just do that.

Thanks
Vivek

