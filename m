Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A622CD3CC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfJKJyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 05:54:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfJKJyD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 05:54:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D19618C8902;
        Fri, 11 Oct 2019 09:54:02 +0000 (UTC)
Received: from [10.36.118.168] (unknown [10.36.118.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84D1A6092F;
        Fri, 11 Oct 2019 09:53:58 +0000 (UTC)
Subject: Re: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>, Qian Cai <cai@lca.pw>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Hocko <mhocko@kernel.org>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20191009091205.11753-1-david@redhat.com>
 <20191009095721.GC20971@hori.linux.bs1.fc.nec.co.jp>
 <f0fcdacc-814b-49d6-78da-beeb1fa6b67a@redhat.com>
 <20191011001124.GA17127@hori.linux.bs1.fc.nec.co.jp>
 <20191011005042.GB18881@hori.linux.bs1.fc.nec.co.jp>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <21d97a65-aa66-75ee-9c63-b5a3dad13b43@redhat.com>
Date:   Fri, 11 Oct 2019 11:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011005042.GB18881@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 11 Oct 2019 09:54:02 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.10.19 02:50, Naoya Horiguchi wrote:
> On Fri, Oct 11, 2019 at 12:11:25AM +0000, Horiguchi Naoya(堀口 直也) wrote:
>> On Thu, Oct 10, 2019 at 09:30:01AM +0200, David Hildenbrand wrote:
>>> On 09.10.19 11:57, Naoya Horiguchi wrote:
>>>> Hi David,
>>>>
>>>> On Wed, Oct 09, 2019 at 11:12:04AM +0200, David Hildenbrand wrote:
>>>>> There are various places where we access uninitialized memmaps, namely:
>>>>> - /proc/kpagecount
>>>>> - /proc/kpageflags
>>>>> - /proc/kpagecgroup
>>>>> - memory_failure() - which reuses stable_page_flags() from fs/proc/page.c
>>>>
>>>> Ah right, memory_failure is another victim of this bug.
>>>>
>>>>>
>>>>> We have initialized memmaps either when the section is online or when
>>>>> the page was initialized to the ZONE_DEVICE. Uninitialized memmaps contain
>>>>> garbage and in the worst case trigger kernel BUGs, especially with
>>>>> CONFIG_PAGE_POISONING.
>>>>>
>>>>> For example, not onlining a DIMM during boot and calling /proc/kpagecount
>>>>> with CONFIG_PAGE_POISONING:
>>>>> :/# cat /proc/kpagecount > tmp.test
>>>>> [   95.600592] BUG: unable to handle page fault for address: fffffffffffffffe
>>>>> [   95.601238] #PF: supervisor read access in kernel mode
>>>>> [   95.601675] #PF: error_code(0x0000) - not-present page
>>>>> [   95.602116] PGD 114616067 P4D 114616067 PUD 114618067 PMD 0
>>>>> [   95.602596] Oops: 0000 [#1] SMP NOPTI
>>>>> [   95.602920] CPU: 0 PID: 469 Comm: cat Not tainted 5.4.0-rc1-next-20191004+ #11
>>>>> [   95.603547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
>>>>> [   95.604521] RIP: 0010:kpagecount_read+0xce/0x1e0
>>>>> [   95.604917] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 e7 48 c1 e7 06 48 03 3d ab 51 01 01 74 1d 48 8b 57 08 480
>>>>> [   95.606450] RSP: 0018:ffffa14e409b7e78 EFLAGS: 00010202
>>>>> [   95.606904] RAX: fffffffffffffffe RBX: 0000000000020000 RCX: 0000000000000000
>>>>> [   95.607519] RDX: 0000000000000001 RSI: 00007f76b5595000 RDI: fffff35645000000
>>>>> [   95.608128] RBP: 00007f76b5595000 R08: 0000000000000001 R09: 0000000000000000
>>>>> [   95.608731] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
>>>>> [   95.609327] R13: 0000000000020000 R14: 00007f76b5595000 R15: ffffa14e409b7f08
>>>>> [   95.609924] FS:  00007f76b577d580(0000) GS:ffff8f41bd400000(0000) knlGS:0000000000000000
>>>>> [   95.610599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   95.611083] CR2: fffffffffffffffe CR3: 0000000078960000 CR4: 00000000000006f0
>>>>> [   95.611686] Call Trace:
>>>>> [   95.611906]  proc_reg_read+0x3c/0x60
>>>>> [   95.612228]  vfs_read+0xc5/0x180
>>>>> [   95.612505]  ksys_read+0x68/0xe0
>>>>> [   95.612785]  do_syscall_64+0x5c/0xa0
>>>>> [   95.613092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>>
>>>>> Note that there are still two possible races as far as I can see:
>>>>> - pfn_to_online_page() succeeding but the memory getting offlined and
>>>>>    removed. get_online_mems() could help once we run into this.
>>>>> - pfn_zone_device() succeeding but the memmap not being fully
>>>>>    initialized yet. As the memmap is initialized outside of the memory
>>>>>    hoptlug lock, get_online_mems() can't help.
>>>>>
>>>>> Let's keep the existing interfaces working with ZONE_DEVICE memory. We
>>>>> can later come back and fix these rare races and eventually speed-up the
>>>>> ZONE_DEVICE detection.
>>>>
>>>> Actually, Toshiki is writing code to refactor and optimize the pfn walking
>>>> part, where we find the pfn ranges covered by zone devices by running over
>>>> xarray pgmap_array and use the range info to reduce pointer dereferences
>>>> to speed up pfn walk. I hope he will share it soon.
>>>
>>> AFAIKT, Michal is not a friend of special-casing PFN walkers in that
>>> way. We should have a mechanism to detect if a memmap was initialized
>>> without having to go via pgmap, special-casing. See my other mail where
>>> I draft one basic approach.
>>
>> OK, so considering your v2 approach, we could have another pfn_to_page()
>> variant like pfn_to_zone_device_page(), where we check that a given pfn
>> belongs to the memory section backed by zone memory, then another check if
>> the pfn has initialized memmap or not, and return NULL if memmap not
>> initialied.  We'll try this approach then, but if you find problems/concerns,
>> please let me know.
> 
> Sorry, you already mentioned detail here,
> https://lore.kernel.org/lkml/c6198acd-8ff7-c40c-cb4e-f0f12f841b38@redhat.com/
> 

I'm planning on sending a proper writeup of the overall approach and  
pitfalls maybe next week. Feel free to ping me in case I forget.

-- 

Thanks,

David / dhildenb
