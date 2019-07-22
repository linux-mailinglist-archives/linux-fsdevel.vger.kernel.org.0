Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446F86FF3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730005AbfGVMIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 08:08:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbfGVMIJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:08:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 58B74309B145;
        Mon, 22 Jul 2019 12:08:08 +0000 (UTC)
Received: from [10.36.116.75] (ovpn-116-75.ams2.redhat.com [10.36.116.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24F945C548;
        Mon, 22 Jul 2019 12:08:02 +0000 (UTC)
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        KVM list <kvm@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-19-vgoyal@redhat.com>
 <20190717192725.25c3d146.pasic@linux.ibm.com>
 <20190718131532.GA13883@redhat.com>
 <CAPcyv4i+2nKJYqkbrdm3hWcjaMYkCKUxqLBq96HOZe6xOZzGGg@mail.gmail.com>
 <c519011e-1df3-3f35-8582-2cb58367ff8a@de.ibm.com>
 <20190722105630.GC3035@work-vm>
 <cc96a4a7-ab24-ef2c-a210-dce0966e34c5@de.ibm.com>
 <20190722134317.39b148ce.cohuck@redhat.com>
 <b8239073-4c40-0ce6-2576-9d71ca0b1c18@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f7426953-8892-9f02-3f85-9f97cd12100b@redhat.com>
Date:   Mon, 22 Jul 2019 14:08:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b8239073-4c40-0ce6-2576-9d71ca0b1c18@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 22 Jul 2019 12:08:08 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22.07.19 14:00, Christian Borntraeger wrote:
> 
> 
> On 22.07.19 13:43, Cornelia Huck wrote:
>> On Mon, 22 Jul 2019 13:20:18 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 22.07.19 12:56, Dr. David Alan Gilbert wrote:
>>>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:  
>>>>>
>>>>>
>>>>> On 18.07.19 16:30, Dan Williams wrote:  
>>>>>> On Thu, Jul 18, 2019 at 6:15 AM Vivek Goyal <vgoyal@redhat.com> wrote:  
>>>>>>>
>>>>>>> On Wed, Jul 17, 2019 at 07:27:25PM +0200, Halil Pasic wrote:  
>>>>>>>> On Wed, 15 May 2019 15:27:03 -0400
>>>>>>>> Vivek Goyal <vgoyal@redhat.com> wrote:
>>>>>>>>  
>>>>>>>>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>>>
>>>>>>>>> Setup a dax device.
>>>>>>>>>
>>>>>>>>> Use the shm capability to find the cache entry and map it.
>>>>>>>>>
>>>>>>>>> The DAX window is accessed by the fs/dax.c infrastructure and must have
>>>>>>>>> struct pages (at least on x86).  Use devm_memremap_pages() to map the
>>>>>>>>> DAX window PCI BAR and allocate struct page.
>>>>>>>>>  
>>>>>>>>
>>>>>>>> Sorry for being this late. I don't see any more recent version so I will
>>>>>>>> comment here.
>>>>>>>>
>>>>>>>> I'm trying to figure out how is this supposed to work on s390. My concern
>>>>>>>> is, that on s390 PCI memory needs to be accessed by special
>>>>>>>> instructions. This is taken care of by the stuff defined in
>>>>>>>> arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
>>>>>>>> the appropriate s390 instruction. However if the code does not use the
>>>>>>>> linux abstractions for accessing PCI memory, but assumes it can be
>>>>>>>> accessed like RAM, we have a problem.
>>>>>>>>
>>>>>>>> Looking at this patch, it seems to me, that we might end up with exactly
>>>>>>>> the case described. For example AFAICT copy_to_iter() (3) resolves to
>>>>>>>> the function in lib/iov_iter.c which does not seem to cater for s390
>>>>>>>> oddities.
>>>>>>>>
>>>>>>>> I didn't have the time to investigate this properly, and since virtio-fs
>>>>>>>> is virtual, we may be able to get around what is otherwise a
>>>>>>>> limitation on s390. My understanding of these areas is admittedly
>>>>>>>> shallow, and since I'm not sure I'll have much more time to
>>>>>>>> invest in the near future I decided to raise concern.
>>>>>>>>
>>>>>>>> Any opinions?  
>>>>>>>
>>>>>>> Hi Halil,
>>>>>>>
>>>>>>> I don't understand s390 and how PCI works there as well. Is there any
>>>>>>> other transport we can use there to map IO memory directly and access
>>>>>>> using DAX?
>>>>>>>
>>>>>>> BTW, is DAX supported for s390.
>>>>>>>
>>>>>>> I am also hoping somebody who knows better can chip in. Till that time,
>>>>>>> we could still use virtio-fs on s390 without DAX.  
>>>>>>
>>>>>> s390 has so-called "limited" dax support, see CONFIG_FS_DAX_LIMITED.
>>>>>> In practice that means that support for PTE_DEVMAP is missing which
>>>>>> means no get_user_pages() support for dax mappings. Effectively it's
>>>>>> only useful for execute-in-place as operations like fork() and ptrace
>>>>>> of dax mappings will fail.  
>>>>>
>>>>>
>>>>> This is only true for the dcssblk device driver (drivers/s390/block/dcssblk.c
>>>>> and arch/s390/mm/extmem.c). 
>>>>>
>>>>> For what its worth, the dcssblk looks to Linux like normal memory (just above the
>>>>> previously detected memory) that can be used like normal memory. In previous time
>>>>> we even had struct pages for this memory - this was removed long ago (when it was
>>>>> still xip) to reduce the memory footprint for large dcss blocks and small memory
>>>>> guests.
>>>>> Can the CONFIG_FS_DAX_LIMITED go away if we have struct pages for that memory?
>>>>>
>>>>> Now some observations: 
>>>>> - dcssblk is z/VM only (not KVM)
>>>>> - Setting CONFIG_FS_DAX_LIMITED globally as a Kconfig option depending on wether
>>>>>   a device driver is compiled in or not seems not flexible enough in case if you
>>>>>   have device driver that does have struct pages and another one that doesn't
>>>>> - I do not see a reason why we should not be able to map anything from QEMU
>>>>>   into the guest real memory via an additional KVM memory slot. 
>>>>>   We would need to handle that in the guest somehow (and not as a PCI bar),
>>>>>   register this with struct pages etc.
>>
>> You mean for ccw, right? I don't think we want pci to behave
>> differently than everywhere else.
> 
> Yes for virtio-ccw. We would need to have a look at how virtio-ccw can create a memory
> mapping with struct pages, so that DAX will work.(Dan, it is just struct pages that 
> you need, correct?)
> 
> 
>>
>>>>> - we must then look how we can create the link between the guest memory and the
>>>>>   virtio-fs driver. For virtio-ccw we might be able to add a new ccw command or
>>>>>   whatever. Maybe we could also piggy-back on some memory hotplug work from David
>>>>>   Hildenbrand (add cc).
>>>>>
>>>>> Regarding limitations on the platform:
>>>>> - while we do have PCI, the virtio devices are usually plugged via the ccw bus.
>>>>>   That implies no PCI bars. I assume you use those PCI bars only to implicitely 
>>>>>   have the location of the shared memory
>>>>>   Correct?  
>>>>
>>>> Right.  
>>>
>>> So in essence we just have to provide a vm_get_shm_region callback in the virtio-ccw
>>> guest code?
>>>
>>> How many regions do we have to support? One region per device? Or many?
>>> Even if we need more, this should be possible with a 2 new CCWs, e.g READ_SHM_BASE(id)
>>> and READ_SHM_SIZE(id)
>>
>> I'd just add a single CCW with a control block containing id and size.
>>
>> The main issue is where we put those regions, and what happens if we
>> use both virtio-pci and virtio-ccw on the same machine.
> 
> Then these 2 devices should get independent memory regions that are added in an
> independent (but still exclusive) way.

I remember that one discussion was who dictates the physical address
mapping. If I'm not wrong, PCI bars can be mapped freely by the guest
intot he address space. So it would not just be querying the start+size.
Unless we want a pre-determined mapping (which might make more sense for
s390x).

-- 

Thanks,

David / dhildenb
