Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421F125D93E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 15:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgIDNFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 09:05:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36773 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729297AbgIDNFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:05:15 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-V0DZXFnYOJGrCpMc9yvhpg-1; Fri, 04 Sep 2020 09:05:11 -0400
X-MC-Unique: V0DZXFnYOJGrCpMc9yvhpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C29D107B271;
        Fri,  4 Sep 2020 13:05:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-41.rdu2.redhat.com [10.10.115.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31F7A7E41C;
        Fri,  4 Sep 2020 13:05:03 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A9D322256EC; Fri,  4 Sep 2020 09:05:02 -0400 (EDT)
Date:   Fri, 4 Sep 2020 09:05:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 0/2] fuse, dax: Couple of fixes for fuse dax support
Message-ID: <20200904130502.GA55989@redhat.com>
References: <20200901142634.1227109-1-vgoyal@redhat.com>
 <CAJfpegtBA6XSbb+futZGt=NY-VjnN_GWFmnNfGjLfgnZ1ynM0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtBA6XSbb+futZGt=NY-VjnN_GWFmnNfGjLfgnZ1ynM0w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 11:45:53AM +0200, Miklos Szeredi wrote:
> On Tue, Sep 1, 2020 at 4:26 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi Miklos,
> >
> > I am testing fuse dax branch now. To begin with here are couple of
> > simple fixes to make sure I/O is going through dax path.
> >
> > Either you can roll these fixes into existing patches or apply on
> > top.
> >
> > I ran blogbench workload and some fio mmap jobs and these seem to be
> > running fine after these fixes.
> 
> Thanks for testing and fixing.
> 
> Pushed a rerolled series to #for-next.   Would be good if you cour retest.

Thanks. Will test again next week.

> 
> There's one checkpatch warning I'm unsure about:
> 
> | WARNING: Using vsprintf specifier '%px' potentially exposes the
> kernel memory layout, if you don't really need the address please
> consider using '%p'.
> | #173: FILE: fs/fuse/virtio_fs.c:812:
> | +    dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx
> len 0x%llx\n",
> | +        __func__, fs->window_kaddr, cache_reg.addr, cache_reg.len);
> |
> | total: 0 errors, 1 warnings, 175 lines checked
> |
> | NOTE: For some of the reported defects, checkpatch may be able to
> |       mechanically convert to the typical style using --fix or --fix-inplace.
> |
> | patches/virtio_fs-dax-set-up-virtio_fs-dax_device.patch has style
> problems, please review.
> 
> Do you think that the kernel address in the debug output is necessary?

It is more of a nice to have thing. Was more useful in initial
development. Now things have stablized, so I don't use it that much
anymore.

So I am fine converting %px to %p. I am not sure though how people
practically make use of %p output for debugging. IIUC, that's a
hash of actual value.

This debug output atleast tells us that a certain virtio device
provided a cache window and driver mapped it.

Thanks
Vivek

