Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10032D1007
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 13:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLGMEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 07:04:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20773 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727320AbgLGMEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607342577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VV+E+pdDesJK1ua/OBZSFe/m+EuDUY9iFBTNIzHgamg=;
        b=QgeRJL1L5axjqAY6q7oo6tSmjr1/VW1ayJiZcxxhDjfcwBWJctug9cVrDvJHm01j2mgApl
        COYsG8/kfx+drQdpKkw2LndxkG2ANQIr0EviOoWotwQy6O6j/K7T9LKWf2Gcoqf1YJFESj
        S4lTnKMYz856vCCB6fGco1+HrOc4kAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-tlIb3Xe8OLCWM9fm3MzovQ-1; Mon, 07 Dec 2020 07:02:53 -0500
X-MC-Unique: tlIb3Xe8OLCWM9fm3MzovQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED8511015C88;
        Mon,  7 Dec 2020 12:02:50 +0000 (UTC)
Received: from [10.36.114.33] (ovpn-114-33.ams2.redhat.com [10.36.114.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 879A860BD8;
        Mon,  7 Dec 2020 12:02:47 +0000 (UTC)
Subject: Re: [RFC V2 00/37] Enhance memory utilization with DMEMFS
To:     yulei.kernel@gmail.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        naoya.horiguchi@nec.com, viro@zeniv.linux.org.uk,
        pbonzini@redhat.com, Dan Williams <dan.j.williams@intel.com>
Cc:     joao.m.martins@oracle.com, rdunlap@infradead.org,
        sean.j.christopherson@intel.com, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>
References: <cover.1607332046.git.yuleixzhang@tencent.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <33a1c4ca-9f78-96ca-a774-3adea64aaed3@redhat.com>
Date:   Mon, 7 Dec 2020 13:02:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cover.1607332046.git.yuleixzhang@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07.12.20 12:30, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> In current system each physical memory page is assocaited with
> a page structure which is used to track the usage of this page.
> But due to the memory usage rapidly growing in cloud environment,
> we find the resource consuming for page structure storage becomes
> more and more remarkable. So is it possible that we could reclaim
> such memory and make it reusable?
> 
> This patchset introduces an idea about how to save the extra
> memory through a new virtual filesystem -- dmemfs.
> 
> Dmemfs (Direct Memory filesystem) is device memory or reserved
> memory based filesystem. This kind of memory is special as it
> is not managed by kernel and most important it is without 'struct page'.
> Therefore we can leverage the extra memory from the host system
> to support more tenants in our cloud service.

"is not managed by kernel" well, it's obviously is managed by the
kernel. It's not managed by the buddy ;)

How is this different to using "mem=X" and mapping the relevant memory
directly into applications? Is this "simply" a control instance on top
that makes sure unprivileged process can access it and not step onto
each others feet? Is that the reason why it's called  a "file system"?
(an example would have helped here, showing how it's used)

It's worth noting that memory hotunplug, memory poisoning and probably
more is currently fundamentally incompatible with this approach - which
should better be pointed out in the cover letter.

Also, I think something similar can be obtained by using dax/hmat
infrastructure with "memmap=", at least I remember a talk where this was
discussed (but not sure if they modified the firmware to expose selected
memory as soft-reserved - we would only need a cmdline parameter to
achieve the same - Dan might know more).

> 
> As the belowing figure shows, we uses a kernel boot parameter 'dmem='
> to reserve the system memory when the host system boots up, the
> remaining system memory is still managed by system memory management
> which is associated with "struct page", the reserved memory
> will be managed by dmem and assigned to guest system, the details
> can be checked in /Documentation/admin-guide/kernel-parameters.txt.
> 
>    +------------------+--------------------------------------+
>    |  system memory   |     memory for guest system          | 
>    +------------------+--------------------------------------+
>     |                                   |
>     v                                   |
> struct page                             |
>     |                                   |
>     v                                   v
>     system mem management             dmem  
> 
> And during the usage, the dmemfs will handle the memory request to
> allocate and free the reserved memory on each NUMA node, the user 
> space application could leverage the mmap interface to access the 
> memory, and kernel module such as kvm and vfio would be able to pin
> the memory thongh follow_pfn() and get_user_page() in different given
> page size granularities.

I cannot say that I really like this approach. I really prefer the
proposal to free-up most vmemmap pages for huge/gigantic pages instead
if all this is about is reducing the memmap size.


-- 
Thanks,

David / dhildenb

