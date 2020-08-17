Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B89247819
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgHQU3Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 16:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgHQU3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597696160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vcZ5xeR/B2zIC2A6zYV92v7HTxGjQeb7b0PrwKaVjKY=;
        b=gWy/6kjwZfnl7wDwl+SCrZFhqUUTD0qHCxiRWyJ7Q40Nr2dHq9wDQTGIOKUpDTktnKnFoF
        qFxgPb1CPlL3Yb/FGMIVA6f7ONIp9ud2RFbUPq5iR3FLg+9RndlFx61vUuDVJAK4rdtKPj
        wowrTp2x4bnbQC3h2kaS31Hhj1FuTF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-6zTHQQx7Ojqg_stoRS3UUA-1; Mon, 17 Aug 2020 16:29:16 -0400
X-MC-Unique: 6zTHQQx7Ojqg_stoRS3UUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD71D1005E5F;
        Mon, 17 Aug 2020 20:29:14 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-81.rdu2.redhat.com [10.10.115.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39FED5D9D2;
        Mon, 17 Aug 2020 20:29:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A93D3222E58; Mon, 17 Aug 2020 16:29:05 -0400 (EDT)
Date:   Mon, 17 Aug 2020 16:29:05 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Gurchetan Singh <gurchetansingh@google.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kbuild test robot <lkp@intel.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 04/20] virtio: Implement get_shm_region for PCI
 transport
Message-ID: <20200817202905.GA659987@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-5-vgoyal@redhat.com>
 <20200810100327-mutt-send-email-mst@kernel.org>
 <20200810145019.GB455528@redhat.com>
 <CAAfnVBk+Hmcm2ftd3wOK-P2NyYQ7z4Wrf1JKhLJaNkCZBLoo6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfnVBk+Hmcm2ftd3wOK-P2NyYQ7z4Wrf1JKhLJaNkCZBLoo6g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 07:51:56PM -0700, Gurchetan Singh wrote:
> On Mon, Aug 10, 2020 at 7:50 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Mon, Aug 10, 2020 at 10:05:17AM -0400, Michael S. Tsirkin wrote:
> > > On Fri, Aug 07, 2020 at 03:55:10PM -0400, Vivek Goyal wrote:
> > > > From: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > >
> > > > On PCI the shm regions are found using capability entries;
> > > > find a region by searching for the capability.
> > > >
> > > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > Signed-off-by: kbuild test robot <lkp@intel.com>
> > > > Cc: kvm@vger.kernel.org
> > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > >
> > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> >
> > [..]
> > > > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > > > +                         struct virtio_shm_region *region, u8 id)
> > > > +{
> > > > +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > > > +   struct pci_dev *pci_dev = vp_dev->pci_dev;
> > > > +   u8 bar;
> > > > +   u64 offset, len;
> > > > +   phys_addr_t phys_addr;
> > > > +   size_t bar_len;
> > > > +
> > > > +   if (!virtio_pci_find_shm_cap(pci_dev, id, &bar, &offset, &len)) {
> > > > +           return false;
> > > > +   }
> > > > +
> > > > +   phys_addr = pci_resource_start(pci_dev, bar);
> > > > +   bar_len = pci_resource_len(pci_dev, bar);
> > > > +
> > > > +   if ((offset + len) < offset) {
> > > > +           dev_err(&pci_dev->dev, "%s: cap offset+len overflow
> > detected\n",
> > > > +                   __func__);
> > > > +           return false;
> > > > +   }
> > > > +
> > > > +   if (offset + len > bar_len) {
> > > > +           dev_err(&pci_dev->dev, "%s: bar shorter than cap
> > offset+len\n",
> > > > +                   __func__);
> > > > +           return false;
> > > > +   }
> > >
> > > Maybe move this to a common header so the checks can be reused by
> > > other transports? Can be a patch on top.
> >
> > Will do as patch on top once these patches get merged.
> >
> 
> There's also some minor checkpatch complaints.  I fixed them with the
> series I sent out with virtio-gpu.

Thanks Gurchetan. I will post the patch with V3 posting anyway. We both
need these patches. So whatever gets merged in the tree first, other
person can use it.

Vivek

