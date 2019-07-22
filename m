Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B06FE2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfGVK4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 06:56:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGVK4n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:56:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4AFE0308219F;
        Mon, 22 Jul 2019 10:56:42 +0000 (UTC)
Received: from work-vm (ovpn-117-221.ams2.redhat.com [10.36.117.221])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0992E60497;
        Mon, 22 Jul 2019 10:56:32 +0000 (UTC)
Date:   Mon, 22 Jul 2019 11:56:30 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
Message-ID: <20190722105630.GC3035@work-vm>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com>
 <20190718131532.GA13883@redhat.com>
 <CAPcyv4i+2nKJYqkbrdm3hWcjaMYkCKUxqLBq96HOZe6xOZzGGg@mail.gmail.com>
 <c519011e-1df3-3f35-8582-2cb58367ff8a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c519011e-1df3-3f35-8582-2cb58367ff8a@de.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 22 Jul 2019 10:56:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> 
> 
> On 18.07.19 16:30, Dan Williams wrote:
> > On Thu, Jul 18, 2019 at 6:15 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >>
> >> On Wed, Jul 17, 2019 at 07:27:25PM +0200, Halil Pasic wrote:
> >>> On Wed, 15 May 2019 15:27:03 -0400
> >>> Vivek Goyal <vgoyal@redhat.com> wrote:
> >>>
> >>>> From: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>
> >>>> Setup a dax device.
> >>>>
> >>>> Use the shm capability to find the cache entry and map it.
> >>>>
> >>>> The DAX window is accessed by the fs/dax.c infrastructure and must have
> >>>> struct pages (at least on x86).  Use devm_memremap_pages() to map the
> >>>> DAX window PCI BAR and allocate struct page.
> >>>>
> >>>
> >>> Sorry for being this late. I don't see any more recent version so I will
> >>> comment here.
> >>>
> >>> I'm trying to figure out how is this supposed to work on s390. My concern
> >>> is, that on s390 PCI memory needs to be accessed by special
> >>> instructions. This is taken care of by the stuff defined in
> >>> arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> >>> the appropriate s390 instruction. However if the code does not use the
> >>> linux abstractions for accessing PCI memory, but assumes it can be
> >>> accessed like RAM, we have a problem.
> >>>
> >>> Looking at this patch, it seems to me, that we might end up with exactly
> >>> the case described. For example AFAICT copy_to_iter() (3) resolves to
> >>> the function in lib/iov_iter.c which does not seem to cater for s390
> >>> oddities.
> >>>
> >>> I didn't have the time to investigate this properly, and since virtio-fs
> >>> is virtual, we may be able to get around what is otherwise a
> >>> limitation on s390. My understanding of these areas is admittedly
> >>> shallow, and since I'm not sure I'll have much more time to
> >>> invest in the near future I decided to raise concern.
> >>>
> >>> Any opinions?
> >>
> >> Hi Halil,
> >>
> >> I don't understand s390 and how PCI works there as well. Is there any
> >> other transport we can use there to map IO memory directly and access
> >> using DAX?
> >>
> >> BTW, is DAX supported for s390.
> >>
> >> I am also hoping somebody who knows better can chip in. Till that time,
> >> we could still use virtio-fs on s390 without DAX.
> > 
> > s390 has so-called "limited" dax support, see CONFIG_FS_DAX_LIMITED.
> > In practice that means that support for PTE_DEVMAP is missing which
> > means no get_user_pages() support for dax mappings. Effectively it's
> > only useful for execute-in-place as operations like fork() and ptrace
> > of dax mappings will fail.
> 
> 
> This is only true for the dcssblk device driver (drivers/s390/block/dcssblk.c
> and arch/s390/mm/extmem.c). 
> 
> For what its worth, the dcssblk looks to Linux like normal memory (just above the
> previously detected memory) that can be used like normal memory. In previous time
> we even had struct pages for this memory - this was removed long ago (when it was
> still xip) to reduce the memory footprint for large dcss blocks and small memory
> guests.
> Can the CONFIG_FS_DAX_LIMITED go away if we have struct pages for that memory?
> 
> Now some observations: 
> - dcssblk is z/VM only (not KVM)
> - Setting CONFIG_FS_DAX_LIMITED globally as a Kconfig option depending on wether
>   a device driver is compiled in or not seems not flexible enough in case if you
>   have device driver that does have struct pages and another one that doesn't
> - I do not see a reason why we should not be able to map anything from QEMU
>   into the guest real memory via an additional KVM memory slot. 
>   We would need to handle that in the guest somehow (and not as a PCI bar),
>   register this with struct pages etc.
> - we must then look how we can create the link between the guest memory and the
>   virtio-fs driver. For virtio-ccw we might be able to add a new ccw command or
>   whatever. Maybe we could also piggy-back on some memory hotplug work from David
>   Hildenbrand (add cc).
> 
> Regarding limitations on the platform:
> - while we do have PCI, the virtio devices are usually plugged via the ccw bus.
>   That implies no PCI bars. I assume you use those PCI bars only to implicitely 
>   have the location of the shared memory
>   Correct?

Right.

> - no real memory mapped I/O. Instead there are instructions that work on the mmio.
>   As I understand things, this is of no concern regarding virtio-fs as you do not
>   need mmio in the sense that a memory access of the guest to such an address 
>   triggers an exit. You just need the shared memory as a mean to have the data
>   inside the guest. Any notification is done via normal virtqueue mechanisms
>   Correct?

Yep.

> 
> Adding Heiko, maybe he remembers some details of the dcssblk/xip history.
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
