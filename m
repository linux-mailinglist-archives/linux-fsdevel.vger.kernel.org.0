Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A829E6D03A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 16:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390645AbfGROrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 10:47:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfGROrU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 10:47:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65C6A89AD0;
        Thu, 18 Jul 2019 14:47:19 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 489261001B0C;
        Thu, 18 Jul 2019 14:47:10 +0000 (UTC)
Date:   Thu, 18 Jul 2019 16:47:07 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com,
        Sebastian Ott <sebott@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Message-ID: <20190718164707.76d60fdc.cohuck@redhat.com>
In-Reply-To: <20190718132049.37bea675.pasic@linux.ibm.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
        <20190515192715.18000-19-vgoyal@redhat.com>
        <20190717192725.25c3d146.pasic@linux.ibm.com>
        <20190718110417.561f6475.cohuck@redhat.com>
        <20190718132049.37bea675.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 18 Jul 2019 14:47:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Jul 2019 13:20:49 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 18 Jul 2019 11:04:17 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 17 Jul 2019 19:27:25 +0200
> > Halil Pasic <pasic@linux.ibm.com> wrote:

> > > I'm trying to figure out how is this supposed to work on s390. My concern
> > > is, that on s390 PCI memory needs to be accessed by special
> > > instructions. This is taken care of by the stuff defined in
> > > arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> > > the appropriate s390 instruction. However if the code does not use the
> > > linux abstractions for accessing PCI memory, but assumes it can be
> > > accessed like RAM, we have a problem.
> > > 
> > > Looking at this patch, it seems to me, that we might end up with exactly
> > > the case described. For example AFAICT copy_to_iter() (3) resolves to
> > > the function in lib/iov_iter.c which does not seem to cater for s390
> > > oddities.  
> > 
> > What about the new pci instructions recently introduced? Not sure how
> > they differ from the old ones (which are currently the only ones
> > supported in QEMU...), but I'm pretty sure they are supposed to solve
> > an issue :)
> >   
> 
> I'm struggling to find the connection between this topic and the new pci
> instructions. Can you please explain in more detail?

The problem is that I'm lacking detail myself... if the new approach is
handling some things substantially differently (e.g. you set up
something and then do read/writes instead of going through
instructions), things will probably work out differently.

> 
> > > 
> > > I didn't have the time to investigate this properly, and since virtio-fs
> > > is virtual, we may be able to get around what is otherwise a
> > > limitation on s390. My understanding of these areas is admittedly
> > > shallow, and since I'm not sure I'll have much more time to
> > > invest in the near future I decided to raise concern.
> > > 
> > > Any opinions?  
> > 
> > Let me point to the thread starting at
> > https://marc.info/?l=linux-s390&m=155048406205221&w=2 as well. That
> > memory region stuff is still unsolved for ccw, and I'm not sure if we
> > need to do something for zpci as well.
> >   
> 
> Right virtio-ccw is another problem, but at least there we don't have the
> need to limit ourselves to a very specific set of instructions (for
> accessing memory).
> 
> zPCI i.e. virtio-pci on z should require much less dedicated love if any

s/virtio-pci/pci/

> at all. Unfortunately I'm not very knowledgeable on either PCI in general
> or its s390 variant.

Right, the biggest issue with zpci and shared regions is the
interaction with ccw using shared regions as well.

Unfortunately, I can't judge any zpci details from here, either :(

If virtio-fs is working in its non-dax version, we'll at least have
something on s390. (Has anyone tried that, btw?) It seems that s390 is
only supporting a limited subset of dax anyway.
