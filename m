Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 212C613B3AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 21:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgANUbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 15:31:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727102AbgANUbu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579033908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wtpq5coZ2n/ZQ8jUD3c2zBl1PMy/gRfERqCXjCgcqe0=;
        b=aGNveF/y13pQdlpCrRHJjfk9+pVVd/SUw6ttc5hrkTGS5M8AQRVlR0Wm9wiay5zThIP3Hm
        sLzYtrKp8VyouXQLl7b4F0i1CaInHDOAX77rLNv12H8L7peA4vuxyQzi8ZM72D3I4/WbuP
        vZn01Pbf6O+PiLDpAfIOMg+n2Ifbem4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-8W0FTxhgPbSbgnwHyRaNiQ-1; Tue, 14 Jan 2020 15:31:45 -0500
X-MC-Unique: 8W0FTxhgPbSbgnwHyRaNiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA35EDB62;
        Tue, 14 Jan 2020 20:31:43 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D992760BE0;
        Tue, 14 Jan 2020 20:31:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6B78F220A24; Tue, 14 Jan 2020 15:31:38 -0500 (EST)
Date:   Tue, 14 Jan 2020 15:31:38 -0500
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200114203138.GA3145@redhat.com>
References: <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia>
 <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
 <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:03:01PM -0800, Dan Williams wrote:
> On Thu, Jan 9, 2020 at 3:27 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 07-01-20 10:49:55, Dan Williams wrote:
> > > On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > > > dax code refers back to block device to figure out partition offset in
> > > > dax device. If we create a dax object corresponding to "struct block_device"
> > > > and store sector offset in that, then we could pass that object to dax
> > > > code and not worry about referring back to bdev. I have written some
> > > > proof of concept code and called that object "dax_handle". I can post
> > > > that code if there is interest.
> > >
> > > I don't think it's worth it in the end especially considering
> > > filesystems are looking to operate on /dev/dax devices directly and
> > > remove block entanglements entirely.
> > >
> > > > IMHO, it feels useful to be able to partition and use a dax capable
> > > > block device in same way as non-dax block device. It will be really
> > > > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > > > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > > > will work.
> > >
> > > That can already happen today. If you do not properly align the
> > > partition then dax operations will be disabled. This proposal just
> > > extends that existing failure domain to make all partitions fail to
> > > support dax.
> >
> > Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
> > decides to create partitions on it for whatever (possibly misguided)
> > reason and then ponders why the hell DAX is not working? And PAGE_SIZE
> > partition alignment is so obvious and widespread that I don't count it as a
> > realistic error case sysadmins would be pondering about currently.
> >
> > So I'd find two options reasonably consistent:
> > 1) Keep status quo where partitions are created and support DAX.
> > 2) Stop partition creation altogether, if anyones wants to split pmem
> > device further, he can use dm-linear for that (i.e., kpartx).
> >
> > But I'm not sure if the ship hasn't already sailed for option 2) to be
> > feasible without angry users and Linus reverting the change.
> 
> Christoph? I feel myself leaning more and more to the "keep pmem
> partitions" camp.
> 
> I don't see "drop partition support" effort ending well given the long
> standing "ext4 fails to mount when dax is not available" precedent.
> 
> I think the next least bad option is to have a dax_get_by_host()
> variant that passes an offset and length pair rather than requiring a
> later bdev_dax_pgoff() to recall the offset. This also prevents
> needing to add another dax-device object representation.

I am wondering what's the conclusion on this. I want to this to make
progress in some direction so that I can make progress on virtiofs DAX
support.

Thanks
Vivek

