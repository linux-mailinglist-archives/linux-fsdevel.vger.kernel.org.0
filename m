Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA50AD21B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 09:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbfJJHiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 03:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733049AbfJJHaI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 03:30:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D504381F31;
        Thu, 10 Oct 2019 07:30:06 +0000 (UTC)
Received: from [10.36.117.125] (ovpn-117-125.ams2.redhat.com [10.36.117.125])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79425102BD82;
        Thu, 10 Oct 2019 07:30:02 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <f0fcdacc-814b-49d6-78da-beeb1fa6b67a@redhat.com>
Date:   Thu, 10 Oct 2019 09:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009095721.GC20971@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Oct 2019 07:30:07 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.10.19 11:57, Naoya Horiguchi wrote:
> Hi David,
> 
> On Wed, Oct 09, 2019 at 11:12:04AM +0200, David Hildenbrand wrote:
>> There are various places where we access uninitialized memmaps, namely:
>> - /proc/kpagecount
>> - /proc/kpageflags
>> - /proc/kpagecgroup
>> - memory_failure() - which reuses stable_page_flags() from fs/proc/page.c
> 
> Ah right, memory_failure is another victim of this bug.
> 
>>
>> We have initialized memmaps either when the section is online or when
>> the page was initialized to the ZONE_DEVICE. Uninitialized memmaps contain
>> garbage and in the worst case trigger kernel BUGs, especially with
>> CONFIG_PAGE_POISONING.
>>
>> For example, not onlining a DIMM during boot and calling /proc/kpagecount
>> with CONFIG_PAGE_POISONING:
>> :/# cat /proc/kpagecount > tmp.test
>> [   95.600592] BUG: unable to handle page fault for address: fffffffffffffffe
>> [   95.601238] #PF: supervisor read access in kernel mode
>> [   95.601675] #PF: error_code(0x0000) - not-present page
>> [   95.602116] PGD 114616067 P4D 114616067 PUD 114618067 PMD 0
>> [   95.602596] Oops: 0000 [#1] SMP NOPTI
>> [   95.602920] CPU: 0 PID: 469 Comm: cat Not tainted 5.4.0-rc1-next-20191004+ #11
>> [   95.603547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.4
>> [   95.604521] RIP: 0010:kpagecount_read+0xce/0x1e0
>> [   95.604917] Code: e8 09 83 e0 3f 48 0f a3 02 73 2d 4c 89 e7 48 c1 e7 06 48 03 3d ab 51 01 01 74 1d 48 8b 57 08 480
>> [   95.606450] RSP: 0018:ffffa14e409b7e78 EFLAGS: 00010202
>> [   95.606904] RAX: fffffffffffffffe RBX: 0000000000020000 RCX: 0000000000000000
>> [   95.607519] RDX: 0000000000000001 RSI: 00007f76b5595000 RDI: fffff35645000000
>> [   95.608128] RBP: 00007f76b5595000 R08: 0000000000000001 R09: 0000000000000000
>> [   95.608731] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000140000
>> [   95.609327] R13: 0000000000020000 R14: 00007f76b5595000 R15: ffffa14e409b7f08
>> [   95.609924] FS:  00007f76b577d580(0000) GS:ffff8f41bd400000(0000) knlGS:0000000000000000
>> [   95.610599] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   95.611083] CR2: fffffffffffffffe CR3: 0000000078960000 CR4: 00000000000006f0
>> [   95.611686] Call Trace:
>> [   95.611906]  proc_reg_read+0x3c/0x60
>> [   95.612228]  vfs_read+0xc5/0x180
>> [   95.612505]  ksys_read+0x68/0xe0
>> [   95.612785]  do_syscall_64+0x5c/0xa0
>> [   95.613092]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> Note that there are still two possible races as far as I can see:
>> - pfn_to_online_page() succeeding but the memory getting offlined and
>>   removed. get_online_mems() could help once we run into this.
>> - pfn_zone_device() succeeding but the memmap not being fully
>>   initialized yet. As the memmap is initialized outside of the memory
>>   hoptlug lock, get_online_mems() can't help.
>>
>> Let's keep the existing interfaces working with ZONE_DEVICE memory. We
>> can later come back and fix these rare races and eventually speed-up the
>> ZONE_DEVICE detection.
> 
> Actually, Toshiki is writing code to refactor and optimize the pfn walking
> part, where we find the pfn ranges covered by zone devices by running over
> xarray pgmap_array and use the range info to reduce pointer dereferences
> to speed up pfn walk. I hope he will share it soon.

AFAIKT, Michal is not a friend of special-casing PFN walkers in that
way. We should have a mechanism to detect if a memmap was initialized
without having to go via pgmap, special-casing. See my other mail where
I draft one basic approach.


-- 

Thanks,

David / dhildenb
