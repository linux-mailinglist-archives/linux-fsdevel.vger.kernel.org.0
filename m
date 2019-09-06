Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C92B3AB7D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbfIFMI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 08:08:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732863AbfIFMI1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:08:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE7243082137;
        Fri,  6 Sep 2019 12:08:26 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40F4660C18;
        Fri,  6 Sep 2019 12:08:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CC7AA220292; Fri,  6 Sep 2019 08:08:17 -0400 (EDT)
Date:   Fri, 6 Sep 2019 08:08:17 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/18] virtiofs: Fix various races and cleanups round 1
Message-ID: <20190906120817.GA22083@redhat.com>
References: <20190905194859.16219-1-vgoyal@redhat.com>
 <CAJfpegu8POz9gC4MDEcXxDWBD0giUNFgJhMEzntJX_u4+cS9Zw@mail.gmail.com>
 <20190906103613.GH5900@stefanha-x1.localdomain>
 <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegudNVZitQ5L8gPvA45mRPFDk9fhyboceVW6xShpJ4mLww@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 06 Sep 2019 12:08:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 01:52:41PM +0200, Miklos Szeredi wrote:
> On Fri, Sep 6, 2019 at 12:36 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Fri, Sep 06, 2019 at 10:15:14AM +0200, Miklos Szeredi wrote:
> > > On Thu, Sep 5, 2019 at 9:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Michael Tsirkin pointed out issues w.r.t various locking related TODO
> > > > items and races w.r.t device removal.
> > > >
> > > > In this first round of cleanups, I have taken care of most pressing
> > > > issues.
> > > >
> > > > These patches apply on top of following.
> > > >
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4
> > > >
> > > > I have tested these patches with mount/umount and device removal using
> > > > qemu monitor. For example.
> > >
> > > Is device removal mandatory?  Can't this be made a non-removable
> > > device?  Is there a good reason why removing the virtio-fs device
> > > makes sense?
> >
> > Hot plugging and unplugging virtio PCI adapters is common.  I'd very
> > much like removal to work from the beginning.
> 
> Can you give an example use case?

David Gilbert mentioned this could be useful if daemon stops responding
or dies. One could remove device. That will fail all future requests
and allow unmounting filesystem.

Havind said that, current implementation will help in above situation
only if there are no pending requests. If there are pending requests
and daemon stops responding, then removal will hang too, as we wait
for draining the queues.

So at some point of time, we also need some sort of timeout functionality
where we end requests with error after a timeout.

I feel we should support removing device at some point of time. But its
not necessarily a must have feature for first round.

Thanks
Vivek
