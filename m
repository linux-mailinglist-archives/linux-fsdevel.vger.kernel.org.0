Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC56C6C7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjCWPn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 11:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjCWPnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:43:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A420576;
        Thu, 23 Mar 2023 08:43:49 -0700 (PDT)
Received: from [192.168.10.28] (unknown [39.37.168.222])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1255366030F9;
        Thu, 23 Mar 2023 15:43:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679586227;
        bh=fqcMKt1oBSR5L6Q8opsI63fwItnsnZyiV5drCHsNuLI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=eNbPAtfwrGZFe7FIs6NljH+Y1y7/jks83wQi/OH9fQ0zixOK+wI9UClTwQVKgnOGr
         19s+YgE9ZDx1bwb/p6VvFqAJ6+9pmfSO9CaE5q6VXmA0bA91I1S1c7EwTkNvDiUsk2
         nNd22mJ30PPDaPc3iO+aBQxrgpIpCwI5rVZV2z8+2wccfYlXzhop17Rrxf0FyUUtuP
         qQ3nrOkV8K53MEiJGKaDU4YjuO9Ejv5ic9Yzdwi+7RZss6u97Mc+Sgpj2qVh7Akp8x
         m0RAN3N7TOqFKofqXaGy8nTgauWoeZKf5ABJ/GURFa9ahLP4PpXOO3s7PjE6LWpvQg
         HWq1+QR76EXzQ==
Message-ID: <996c14d4-6dcc-7d14-cf76-d8fbea0a9040@collabora.com>
Date:   Thu, 23 Mar 2023 20:43:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 1/7] userfaultfd: Add UFFD WP Async support
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-2-usama.anjum@collabora.com> <ZBNr4nohj/Tw4Zhw@x1n>
 <1b78ee32-003d-5645-c223-619b66d41733@collabora.com> <ZBoEpkq66ZxHFr8A@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ZBoEpkq66ZxHFr8A@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/22/23 12:25 AM, Peter Xu wrote:
> Hi, Muhammad,
> 
> On Tue, Mar 21, 2023 at 05:21:15PM +0500, Muhammad Usama Anjum wrote:
>> Thank you so much for the patch. I've tested hugetlb mem. This patch is
>> working fine for hugetlb shmem:
>> *shmid = shmget(2, size, SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
>> mem = shmat(*shmid, 0, 0);
>>
>> I've found slight issue with hugetlb mem which has been mmaped:
>> mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
>> 	   MAP_ANONYMOUS | MAP_HUGETLB | MAP_PRIVATE, -1, 0);
>> The issue is that even after witting to this memory, the wp flag is still
>> present there and memory doesn't appear to be dirty when it should have
>> been dirty. The temporary fix is to write to memory and write protect the
>> memory one extra time.
> 
> I looked into this today and found it's an existing bug that can trigger
> with sync mode too.. as long as protection applied to unpopulated hugetlb
> private mappings, then write to it.
> 
> I've sent a fix for it here and have you copied:
> 
> https://lore.kernel.org/linux-mm/20230321191840.1897940-1-peterx@redhat.com/T/#u
> 
> Please have a look and see whether it also fixes your issue.
Thanks for sending the patch. I've replied on the sent patch.

> 
> PS: recently I added a warning in commit c2da319c2e2789 and that can indeed
> capture this one when verifying using pagemap.  I'd guess your dmesg should
> also contain something dumped.
I didn't had debug_vm config enabled. I've enabled it now. I'm getting only
the following stack trace in failure scenario:

ok 1 Hugetlb shmem testing: all new pages must not be written (dirty) 0
ok 2 Hugetlb shmem testing: all pages must be written (dirty) 1 512 0 512
ok 3 Hugetlb mem testing: all new pages must not be written (dirty) 0
[   10.086540] ------------[ cut here ]------------
[   10.087758] WARNING: CPU: 0 PID: 175 at
arch/x86/include/asm/pgtable.h:313 pagemap_scan_hugetlb_entry+0x19c/0x230
[   10.090208] Modules linked in:
[   10.091059] CPU: 0 PID: 175 Comm: pagemap_ioctl Not tainted
6.3.0-rc3-next-20230320-00010-gdc395ccf1882 #88
[   10.093224] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.0-debian-1.16.0-5 04/01/2014
[   10.095879] RIP: 0010:pagemap_scan_hugetlb_entry+0x19c/0x230
[   10.097497] Code: 89 ca 41 89 c2 29 c8 4c 01 c2 49 39 d2 41 0f 43 c0 e9
53 ff ff ff 48 83 e2 9f 89 c7 31 ed 49 89 d1 83 e7 02 0f 84 30 ff ff ff
<0f> 0b 31 ff e9 27 ff ff ff 48 83 e2 9f 44 89 c0 bf 01 00 00 00 bd
[   10.102528] RSP: 0018:ffffb6cd80303d10 EFLAGS: 00010202
[   10.104002] RAX: 8000000000000ce7 RBX: 00007fcc84000000 RCX:
0000000000200000
[   10.105989] RDX: 80000002f7c00c87 RSI: 0000000000000001 RDI:
0000000000000002
[   10.108043] RBP: 0000000000000000 R08: 0000000000000200 R09:
80000002f7c00c87
[   10.110004] R10: ffffa08541e3220c R11: 0000000000000000 R12:
ffffa08541562420
[   10.112335] R13: ffffb6cd80303e70 R14: 00007fcc84000000 R15:
ffffffff8eae1520
[   10.114688] FS:  00007fcc8454b740(0000) GS:ffffa0886fc00000(0000)
knlGS:0000000000000000
[   10.116960] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.118187] CR2: 00007fcc84000000 CR3: 0000000102838000 CR4:
0000000000750ef0
[   10.119628] PKRU: 55555554
[   10.120184] Call Trace:
[   10.120730]  <TASK>
[   10.121206]  __walk_page_range+0xbe/0x1b0
[   10.122048]  walk_page_range+0x15f/0x1a0
[   10.122869]  do_pagemap_cmd+0x239/0x390
[   10.123672]  __x64_sys_ioctl+0x8b/0xc0
[   10.124462]  do_syscall_64+0x3a/0x90
[   10.125227]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   10.126326] RIP: 0033:0x7fcc8464bbab
[   10.127066] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00
00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05
<89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[   10.130868] RSP: 002b:00007fff9b864240 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   10.132412] RAX: ffffffffffffffda RBX: 0000000000001000 RCX:
00007fcc8464bbab
[   10.133880] RDX: 00007fff9b8642c0 RSI: 00000000c0586610 RDI:
0000000000000003
[   10.135328] RBP: 00007fff9b864320 R08: 0000000000000001 R09:
0000000000000000
[   10.136790] R10: 00007fff9b864217 R11: 0000000000000246 R12:
0000000000000000
[   10.138285] R13: 00007fff9b8644f8 R14: 0000000000409df0 R15:
00007fcc84862020
[   10.139729]  </TASK>
[   10.140197] ---[ end trace 0000000000000000 ]---
not ok 4 Hugetlb mem testing: all pages must be written (dirty) 0
-2072900416 0 512

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
