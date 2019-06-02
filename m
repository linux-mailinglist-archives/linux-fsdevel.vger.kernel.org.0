Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2C32356
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2019 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfFBNMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 2 Jun 2019 09:12:03 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:54628 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726084AbfFBNMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jun 2019 09:12:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16766024-1500050 
        for multiple; Sun, 02 Jun 2019 14:11:48 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Matthew Wilcox <willy@infradead.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190602105150.GB23346@bombadil.infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <liu.song.a23@gmail.com>
References: <20190307153051.18815-1-willy@infradead.org>
 <155938118174.22493.11599751119608173366@skylake-alporthouse-com>
 <155938946857.22493.6955534794168533151@skylake-alporthouse-com>
 <20190602105150.GB23346@bombadil.infradead.org>
Message-ID: <155948110413.22493.13971476014077289998@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Date:   Sun, 02 Jun 2019 14:11:44 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Matthew Wilcox (2019-06-02 11:51:50)
> Thanks for the reports, Chris.
> 
> I think they're both canaries; somehow the page cache / swap cache has
> got corrupted and contains entries that it shouldn't.
> 
> This second one (with the VM_BUG_ON_PAGE in __delete_from_swap_cache)
> shows a regular (non-huge) page at index 1.  There are two ways we might
> have got there; one is that we asked to delete a page at index 1 which is
> no longer in the cache.  The other is that we asked to delete a huge page
> at index 0, but the page wasn't subsequently stored in indices 1-511.
> 
> We dump the page that we found; not the page we're looking for, so I don't
> know which.  If this one's easy to reproduce, you could add:
> 
>         for (i = 0; i < nr; i++) {
>                 void *entry = xas_store(&xas, NULL);
> +               if (entry != page) {
> +                       printk("Oh dear %d %d\n", i, nr);
> +                       dump_page(page, "deleting page");
> +               }

[  113.423120] Oh dear 0 1
[  113.423141] page:ffffea000911cdc0 refcount:0 mapcount:0 mapping:ffff88826aee7bb1 index:0x7fce6ff37
[  113.423146] anon
[  113.423150] flags: 0x8000000000080445(locked|uptodate|workingset|owner_priv_1|swapbacked)
[  113.423161] raw: 8000000000080445 dead000000000100 dead000000000200 ffff88826aee7bb1
[  113.423167] raw: 00000007fce6ff37 0000000000054537 00000000ffffffff 0000000000000000
[  113.423171] page dumped because: deleting page
[  113.423176] page:ffffea0009118000 refcount:1 mapcount:0 mapping:ffff88826aee7bb1 index:0x7fce6fe00
[  113.423182] anon
[  113.423183] flags: 0x8000000000080454(uptodate|lru|workingset|owner_priv_1|swapbacked)
[  113.423191] raw: 8000000000080454 ffffea0009118048 ffffea000911ce08 ffff88826aee7bb1
[  113.423198] raw: 00000007fce6fe00 0000000000054400 00000001ffffffff ffff8882693e5000
[  113.423204] page dumped because: VM_BUG_ON_PAGE(entry != page)
[  113.423209] page->mem_cgroup:ffff8882693e5000
[  113.423222] ------------[ cut here ]------------
[  113.423227] kernel BUG at mm/swap_state.c:174!
[  113.423236] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC
[  113.423243] CPU: 1 PID: 131 Comm: kswapd0 Tainted: G     U            5.2.0-rc2+ #251
[  113.423248] Hardware name:  /NUC6CAYB, BIOS AYAPLCEL.86A.0029.2016.1124.1625 11/24/2016
[  113.423260] RIP: 0010:__delete_from_swap_cache.cold.17+0x30/0x36
[  113.423265] Code: 48 c7 c7 13 94 bf 81 e8 cd 7f f3 ff 48 89 df 48 c7 c6 24 94 bf 81 e8 95 6c fd ff 48 c7 c6 32 94 bf 81 4c 89 ff e8 86 6c fd ff <0f> 0b 90 90 90 90 48 8b 07 48 8b 16 48 c1 e8 3a 48 c1 ea 3a 29 d0
[  113.423274] RSP: 0018:ffffc900008b3a80 EFLAGS: 00010046
[  113.423280] RAX: 0000000000000000 RBX: ffffea000911cdc0 RCX: 0000000000000006
[  113.423285] RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff888276c963c0
[  113.423290] RBP: ffff888265a98d20 R08: 00000000000002ce R09: 0000000000000000
[  113.423296] R10: 0000000272bc445c R11: 0000000000000000 R12: 0000000000000001
[  113.423301] R13: 0000000000000000 R14: 0000000000000000 R15: ffffea0009118000
[  113.423306] FS:  0000000000000000(0000) GS:ffff888276c80000(0000) knlGS:0000000000000000
[  113.423313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.423317] CR2: 00007fce7c857000 CR3: 0000000002c09000 CR4: 00000000001406e0
[  113.423323] Call Trace:
[  113.423331]  __remove_mapping+0x1c2/0x380
[  113.423337]  shrink_page_list+0x123c/0x1d00
[  113.423343]  shrink_inactive_list+0x130/0x300
[  113.423348]  shrink_node_memcg+0x20e/0x740
[  113.423354]  shrink_node+0xba/0x420
[  113.423359]  balance_pgdat+0x27d/0x4d0
[  113.423365]  kswapd+0x216/0x300
[  113.423372]  ? wait_woken+0x80/0x80
[  113.423378]  ? balance_pgdat+0x4d0/0x4d0
[  113.423384]  kthread+0x106/0x120
[  113.423389]  ? kthread_create_on_node+0x40/0x40
[  113.423398]  ret_from_fork+0x1f/0x30
[  113.423405] Modules linked in: i915 intel_gtt drm_kms_helper
[  113.423414] ---[ end trace 328930613dd77e06 ]---
[  113.454546] RIP: 0010:__delete_from_swap_cache.cold.17+0x30/0x36

>                 VM_BUG_ON_PAGE(entry != page, entry);
>                 set_page_private(page + i, 0);
>                 xas_next(&xas);
>         }
> 
> I'll re-read the patch and see if I can figure out how the cache is getting
> screwed up.  Given what you said, probably on the swap-in path.

It may be self-incriminating, but this only occurs when i915.ko is also
involved via shrink_slab.
-Chris
