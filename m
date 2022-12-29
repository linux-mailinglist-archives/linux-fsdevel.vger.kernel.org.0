Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F316659258
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 23:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiL2WBj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 17:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiL2WBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:01:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D2A8FFE;
        Thu, 29 Dec 2022 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=71ak5DlLjqSfR20yVQ7y5XOXC9hkAGkrWLM+CHpcQgg=; b=qV4Qk4gZyAcvKE830nfXFxPEIU
        fX1FThun24ssMt/swQAohcn8rfySf7aqky46NiShyMKvVmPtU1m8rC5bonY+R5k+Iz/utrNM3/Qwx
        2n63kT0EaHDbV7XqeWV8K38b2d/pbM/QGohtaruP+B4QJwrEEvHA+jLGd/jeVsh1xj9eA8Tp7OI+t
        GE4XaUhH7eu+O2BQ/LPWJ71kuRPFdzCO9Z+9LS9wVAeuxFuxIpWlv4QGIIxGrPJvvjAJLi3Lb4+/J
        jZjODdZjerCyuD3b18A3W7UGratRKQhbKXrcnxRU+W59d4gEl5vdXKOSLDfiwRHnWz4GXSqWq/XK0
        qL8yb4bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pB0y6-00A9CE-9d; Thu, 29 Dec 2022 22:01:42 +0000
Date:   Thu, 29 Dec 2022 22:01:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+b7ad168b779385f8cd58@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] INFO: task hung in __unmap_and_move (4)
Message-ID: <Y64ORhZY4erFd3X7@casper.infradead.org>
References: <000000000000e5738d05f0f46309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e5738d05f0f46309@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 29, 2022 at 01:48:42AM -0800, syzbot wrote:
> INFO: task kcompactd1:32 blocked for more than 143 seconds.
>       Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kcompactd1      state:D stack:26360 pid:32    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5244 [inline]
>  __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
>  schedule+0xcb/0x190 kernel/sched/core.c:6631
>  io_schedule+0x83/0x100 kernel/sched/core.c:8811
>  folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
>  folio_lock include/linux/pagemap.h:938 [inline]
>  __unmap_and_move+0x835/0x12a0 mm/migrate.c:1040
>  unmap_and_move+0x28f/0xd80 mm/migrate.c:1194
>  migrate_pages+0x50f/0x14d0 mm/migrate.c:1477
>  compact_zone+0x2893/0x37a0 mm/compaction.c:2413
>  proactive_compact_node mm/compaction.c:2665 [inline]
>  kcompactd+0x1b46/0x2750 mm/compaction.c:2975

OK, so kcompactd is trying to compact a zone, has called folio_lock()
and whoever has the folio locked has had it locked for 143 seconds.
That seems like quite a long time.  Probably it is locked waiting
for I/O.

> NMI backtrace for cpu 1
[...]
>  lock_release+0x81/0x870 kernel/locking/lockdep.c:5679
>  rcu_read_unlock include/linux/rcupdate.h:797 [inline]
>  folio_evictable+0x1df/0x2d0 mm/internal.h:140
>  move_folios_to_lru+0x324/0x25c0 mm/vmscan.c:2413
>  shrink_inactive_list+0x60b/0xca0 mm/vmscan.c:2529
>  shrink_list mm/vmscan.c:2767 [inline]
>  shrink_lruvec+0x449/0xc50 mm/vmscan.c:5951
>  shrink_node_memcgs+0x35c/0x780 mm/vmscan.c:6138
>  shrink_node+0x299/0x1050 mm/vmscan.c:6169
>  shrink_zones+0x4fb/0xc40 mm/vmscan.c:6407
>  do_try_to_free_pages+0x215/0xcd0 mm/vmscan.c:6469
>  try_to_free_pages+0x3e8/0xc60 mm/vmscan.c:6704
>  __perform_reclaim mm/page_alloc.c:4750 [inline]
>  __alloc_pages_direct_reclaim mm/page_alloc.c:4772 [inline]
>  __alloc_pages_slowpath+0xd5c/0x2120 mm/page_alloc.c:5178
>  __alloc_pages+0x3d4/0x560 mm/page_alloc.c:5562
>  folio_alloc+0x1a/0x50 mm/mempolicy.c:2296
>  filemap_alloc_folio+0xca/0x2c0 mm/filemap.c:972
>  page_cache_ra_unbounded+0x212/0x820 mm/readahead.c:248
>  do_sync_mmap_readahead+0x786/0x950 mm/filemap.c:3062
>  filemap_fault+0x38d/0x1060 mm/filemap.c:3154

So dhcpd has taken a page fault, missed in the page cache, called
readahead, is presumably partway through the readahead (ie has folios
locked in the page cache, not uptodate and I/O hasn't been submitted
on them).  It's trying to allocate pages, but has fallen into reclaim.
It's trying to shrink the inactive list at this point, but is not
having much luck.  For one thing, it's a GFP_NOFS allocation.  So
it was probably the one who woke kcompactd.

Should readahead be trying less hard to allocate memory?  It's already
using __GFP_NORETRY.
