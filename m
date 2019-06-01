Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A931AE8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfFAJ0v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 1 Jun 2019 05:26:51 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53427 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727158AbfFAJ0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:26:50 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16757666-1500050 
        for multiple; Sat, 01 Jun 2019 10:26:25 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190307153051.18815-1-willy@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Song Liu <liu.song.a23@gmail.com>
References: <20190307153051.18815-1-willy@infradead.org>
Message-ID: <155938118174.22493.11599751119608173366@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH v4] page cache: Store only head pages in i_pages
Date:   Sat, 01 Jun 2019 10:26:21 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Quoting Matthew Wilcox (2019-03-07 15:30:51)
> Transparent Huge Pages are currently stored in i_pages as pointers to
> consecutive subpages.  This patch changes that to storing consecutive
> pointers to the head page in preparation for storing huge pages more
> efficiently in i_pages.
> 
> Large parts of this are "inspired" by Kirill's patch
> https://lore.kernel.org/lkml/20170126115819.58875-2-kirill.shutemov@linux.intel.com/
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Acked-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Kirill Shutemov <kirill@shutemov.name>
> Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>
> Tested-by: William Kucharski <william.kucharski@oracle.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

I've bisected some new softlockups under THP mempressure to this patch.
They are all rcu stalls that look similar to:
[  242.645276] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  242.645293] rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-3): P828
[  242.645301] 	(detected by 1, t=5252 jiffies, g=55501, q=221)
[  242.645307] gem_syslatency  R  running task        0   828    815 0x00004000
[  242.645315] Call Trace:
[  242.645326]  ? __schedule+0x1a0/0x440
[  242.645332]  ? preempt_schedule_irq+0x27/0x50
[  242.645337]  ? apic_timer_interrupt+0xa/0x20
[  242.645342]  ? xas_load+0x3c/0x80
[  242.645347]  ? xas_load+0x8/0x80
[  242.645353]  ? find_get_entry+0x4f/0x130
[  242.645358]  ? pagecache_get_page+0x2b/0x210
[  242.645364]  ? lookup_swap_cache+0x42/0x100
[  242.645371]  ? do_swap_page+0x6f/0x600
[  242.645375]  ? unmap_region+0xc2/0xe0
[  242.645380]  ? __handle_mm_fault+0x7a9/0xfa0
[  242.645385]  ? handle_mm_fault+0xc2/0x1c0
[  242.645393]  ? __do_page_fault+0x198/0x410
[  242.645399]  ? page_fault+0x5/0x20
[  242.645404]  ? page_fault+0x1b/0x20

Any suggestions as to what information you might want?
-Chris
