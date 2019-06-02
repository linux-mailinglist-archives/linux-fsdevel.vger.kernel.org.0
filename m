Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CBD324A3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2019 21:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFBT3B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sun, 2 Jun 2019 15:29:01 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63692 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbfFBT3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jun 2019 15:29:01 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16768014-1500050 
        for multiple; Sun, 02 Jun 2019 20:28:09 +0100
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
Message-ID: <155950368509.22493.15394943722747213271@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Date:   Sun, 02 Jun 2019 20:28:05 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Matthew Wilcox (2019-06-02 11:51:50)
> On Sat, Jun 01, 2019 at 12:44:28PM +0100, Chris Wilson wrote:
> > Quoting Chris Wilson (2019-06-01 10:26:21)
> > > Quoting Matthew Wilcox (2019-03-07 15:30:51)
> > > > Transparent Huge Pages are currently stored in i_pages as pointers to
> > > > consecutive subpages.  This patch changes that to storing consecutive
> > > > pointers to the head page in preparation for storing huge pages more
> > > > efficiently in i_pages.
> > > > 
> > > > Large parts of this are "inspired" by Kirill's patch
> > > > https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> > > > 
> > > > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > > > Acked-by: Jan Kara <jack@suse.cz>
> > > > Reviewed-by: Kirill Shutemov <kirill@shutemov.name>
> > > > Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>
> > > > Tested-by: William Kucharski <william.kucharski@oracle.com>
> > > > Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> > > 
> > > I've bisected some new softlockups under THP mempressure to this patch.
> > > They are all rcu stalls that look similar to:
> > > [  242.645276] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > [  242.645293] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P828
> > > [  242.645301]  (detected by 1, t=5252 jiffies, g=55501, q=221)
> > > [  242.645307] gem_syslatency  R  running task        0   828    815 0x00004000
> > > [  242.645315] Call Trace:
> > > [  242.645326]  ? __schedule+0x1a0/0x440
> > > [  242.645332]  ? preempt_schedule_irq+0x27/0x50
> > > [  242.645337]  ? apic_timer_interrupt+0xa/0x20
> > > [  242.645342]  ? xas_load+0x3c/0x80
> > > [  242.645347]  ? xas_load+0x8/0x80
> > > [  242.645353]  ? find_get_entry+0x4f/0x130
> > > [  242.645358]  ? pagecache_get_page+0x2b/0x210
> > > [  242.645364]  ? lookup_swap_cache+0x42/0x100
> > > [  242.645371]  ? do_swap_page+0x6f/0x600
> > > [  242.645375]  ? unmap_region+0xc2/0xe0
> > > [  242.645380]  ? __handle_mm_fault+0x7a9/0xfa0
> > > [  242.645385]  ? handle_mm_fault+0xc2/0x1c0
> > > [  242.645393]  ? __do_page_fault+0x198/0x410
> > > [  242.645399]  ? page_fault+0x5/0x20
> > > [  242.645404]  ? page_fault+0x1b/0x20
> > > 
> > > Any suggestions as to what information you might want?
> > 
> > Perhaps,
> > [   76.175502] page:ffffea00098e0000 count:0 mapcount:0 mapping:0000000000000000 index:0x1
> > [   76.175525] flags: 0x8000000000000000()
> > [   76.175533] raw: 8000000000000000 ffffea0004a7e988 ffffea000445c3c8 0000000000000000
> > [   76.175538] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
> > [   76.175543] page dumped because: VM_BUG_ON_PAGE(entry != page)
> > [   76.175560] ------------[ cut here ]------------
> > [   76.175564] kernel BUG at mm/swap_state.c:170!
> > [   76.175574] invalid opcode: 0000 [#1] PREEMPT SMP
> > [   76.175581] CPU: 0 PID: 131 Comm: kswapd0 Tainted: G     U            5.1.0+ #247
> > [   76.175586] Hardware name:  /NUC6CAYB, BIOS AYAPLCEL.86A.0029.2016.1124.1625 11/24/2016
> > [   76.175598] RIP: 0010:__delete_from_swap_cache+0x22e/0x340
> > [   76.175604] Code: e8 b7 3e fd ff 48 01 1d a8 7e 04 01 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c6 03 7e bf 81 48 89 c7 e8 92 f8 fd ff <0f> 0b 48 c7 c6 c8 7c bf 81 48 89 df e8 81 f8 fd ff 0f 0b 48 c7 c6
> > [   76.175613] RSP: 0000:ffffc900008dba88 EFLAGS: 00010046
> > [   76.175619] RAX: 0000000000000032 RBX: ffffea00098e0040 RCX: 0000000000000006
> > [   76.175624] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffffffff81bf6d4c
> > [   76.175629] RBP: ffff888265ed8640 R08: 00000000000002c2 R09: 0000000000000000
> > [   76.175634] R10: 0000000273a4626d R11: 0000000000000000 R12: 0000000000000001
> > [   76.175639] R13: 0000000000000040 R14: 0000000000000000 R15: ffffea00098e0000
> > [   76.175645] FS:  0000000000000000(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
> > [   76.175651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   76.175656] CR2: 00007f24e4399000 CR3: 0000000002c09000 CR4: 00000000001406f0
> > [   76.175661] Call Trace:
> > [   76.175671]  __remove_mapping+0x1c2/0x380
> > [   76.175678]  shrink_page_list+0x11db/0x1d10
> > [   76.175684]  shrink_inactive_list+0x14b/0x420
> > [   76.175690]  shrink_node_memcg+0x20e/0x740
> > [   76.175696]  shrink_node+0xba/0x420
> > [   76.175702]  balance_pgdat+0x27d/0x4d0
> > [   76.175709]  kswapd+0x216/0x300
> > [   76.175715]  ? wait_woken+0x80/0x80
> > [   76.175721]  ? balance_pgdat+0x4d0/0x4d0
> > [   76.175726]  kthread+0x106/0x120
> > [   76.175732]  ? kthread_create_on_node+0x40/0x40
> > [   76.175739]  ret_from_fork+0x1f/0x30
> > [   76.175745] Modules linked in: i915 intel_gtt drm_kms_helper
> > [   76.175754] ---[ end trace 8faf2ec849d50724 ]---
> > [   76.206689] RIP: 0010:__delete_from_swap_cache+0x22e/0x340
> > [   76.206708] Code: e8 b7 3e fd ff 48 01 1d a8 7e 04 01 48 83 c4 30 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c6 03 7e bf 81 48 89 c7 e8 92 f8 fd ff <0f> 0b 48 c7 c6 c8 7c bf 81 48 89 df e8 81 f8 fd ff 0f 0b 48 c7 c6
> > [   76.206718] RSP: 0000:ffffc900008dba88 EFLAGS: 00010046
> > [   76.206723] RAX: 0000000000000032 RBX: ffffea00098e0040 RCX: 0000000000000006
> > [   76.206729] RDX: 0000000000000007 RSI: 0000000000000000 RDI: ffffffff81bf6d4c
> > [   76.206734] RBP: ffff888265ed8640 R08: 00000000000002c2 R09: 0000000000000000
> > [   76.206740] R10: 0000000273a4626d R11: 0000000000000000 R12: 0000000000000001
> > [   76.206745] R13: 0000000000000040 R14: 0000000000000000 R15: ffffea00098e0000
> > [   76.206750] FS:  0000000000000000(0000) GS:ffff888277a00000(0000) knlGS:0000000000000000
> > [   76.206757] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 
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
>                 VM_BUG_ON_PAGE(entry != page, entry);
>                 set_page_private(page + i, 0);
>                 xas_next(&xas);
>         }
> 
> I'll re-read the patch and see if I can figure out how the cache is getting
> screwed up.  Given what you said, probably on the swap-in path.

I can give you a clue, it requires split_huge_page_to_list().
-Chris
