Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D5240648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Aug 2020 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgHJM7l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Aug 2020 08:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHJM7j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:59:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954FC061787
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 05:59:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so8069362wrs.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2020 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FW1Q4XjebKZk2m+j8IXILmM0Omvwg7J33e4+M4nS+ck=;
        b=Tf7pYYXr7LzEHY1LEd8JqT9o7fgZW4/hKMxt+9miHol6zc4GEq0kDtcsZ/lauz3QYT
         zwnmzyNSRf+MdEr/cBebqmPfzC/00PUpS4ziiQZS2hg3WxL4aXadsGfNYdD3VqY5OHC1
         WsfTNZHU1VgK4/SZuyqBWGCGfmGUV0MGbuJfasP33MC9EJSEFt9rfjfY8FYmDsmF6ELM
         xR/g8oHsCmuI/7Yurg8WFy0LlscUlOpAWB67GDDHk29VNOtRawojqkvuZ1H+9WkYow/h
         qfHcym9L+tZaG9rpHbmCdozST7I8SslhknWWbG2zuAWfR+FhZ7JchmCm5XwXTLcgFj8X
         iLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FW1Q4XjebKZk2m+j8IXILmM0Omvwg7J33e4+M4nS+ck=;
        b=ApffKaUdMYBb/97sLIRYq0dWMFwCaRb0+ZRoz2zKww2avR3lIp5cGQ2OGjc15vUaG/
         hnXx0G9RbED+hn1DkEuOsy1XmRdjuvzvbz1e4UlLvJ+4UW/K4texOHYzrKCyfFQMQZJw
         sy/bHnciK4JyTeJEOItxS5+OlXZPDUcUGNF3icdRzxCQAHAobPHtisKzg+JqOHsxiHwF
         QuLaVWEIdQxGcqMWSMEcBUPGxkiRDEKPnC5KWJPTl8yuw8kdq3kUkpY+0HZSSu/jce3C
         BMtOQIGQStAtMwexO2GXWJohZPNsP9bQT/8s/kLkXgZnJ3s774IZbXtl8lPLrSiAksMl
         80qg==
X-Gm-Message-State: AOAM532Ngj5tV8ysATfwS/LdoRr62SBSvw3deT1l3awdZpcoT3FNoXvV
        31iEH1SeGNdw0q/yiJwd4UzkWw==
X-Google-Smtp-Source: ABdhPJxmRba7iwHejaH4O2ObE3V+8JvqGeqhqMilpq6wDP046/AA7nJ7lbA+LHnLCMkaNlbtX0w6Hw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr24437320wru.211.1597064377541;
        Mon, 10 Aug 2020 05:59:37 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id y203sm22876993wmc.29.2020.08.10.05.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:59:36 -0700 (PDT)
Date:   Mon, 10 Aug 2020 14:59:31 +0200
From:   Marco Elver <elver@google.com>
To:     syzbot <syzbot+0d4522639ba75b02bf19@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: KCSAN: data-race in __xa_clear_mark / xas_find_marked
Message-ID: <20200810125931.GA1734171@elver.google.com>
References: <00000000000062a49205ac854581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000062a49205ac854581@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc XArray maintainer]

Hi Matthew,

On Mon, Aug 10, 2020 at 05:41AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fc80c51f Merge tag 'kbuild-v5.9' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cb73fa900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=997a92ee4b5588ef
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d4522639ba75b02bf19
> compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0d4522639ba75b02bf19@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in __xa_clear_mark / xas_find_marked
> 
> write to 0xffff8880bace9b30 of 8 bytes by interrupt on cpu 1:
>  instrument_write include/linux/instrumented.h:42 [inline]
>  __test_and_clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:85 [inline]
>  node_clear_mark lib/xarray.c:100 [inline]
>  xas_clear_mark lib/xarray.c:908 [inline]
>  __xa_clear_mark+0x229/0x350 lib/xarray.c:1726
>  test_clear_page_writeback+0x28d/0x480 mm/page-writeback.c:2739
>  end_page_writeback+0xa7/0x110 mm/filemap.c:1369
>  page_endio+0x1aa/0x1e0 mm/filemap.c:1400
>  mpage_end_io+0x186/0x1d0 fs/mpage.c:54
>  bio_endio+0x28a/0x370 block/bio.c:1447
>  req_bio_endio block/blk-core.c:259 [inline]
>  blk_update_request+0x535/0xbd0 block/blk-core.c:1576
>  blk_mq_end_request+0x22/0x50 block/blk-mq.c:562
>  lo_complete_rq+0xca/0x180 drivers/block/loop.c:500
>  blk_done_softirq+0x1a5/0x200 block/blk-mq.c:586
>  __do_softirq+0x198/0x360 kernel/softirq.c:298
>  run_ksoftirqd+0x2f/0x60 kernel/softirq.c:652
>  smpboot_thread_fn+0x347/0x530 kernel/smpboot.c:165
>  kthread+0x20d/0x230 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> read to 0xffff8880bace9b30 of 8 bytes by task 12715 on cpu 0:
>  xas_find_chunk include/linux/xarray.h:1625 [inline]
>  xas_find_marked+0x22f/0x6b0 lib/xarray.c:1198
>  find_get_pages_range_tag+0xa3/0x580 mm/filemap.c:1976
>  pagevec_lookup_range_tag+0x37/0x50 mm/swap.c:1120
>  __filemap_fdatawait_range+0xab/0x1b0 mm/filemap.c:519
>  filemap_fdatawait_range mm/filemap.c:554 [inline]
>  filemap_write_and_wait_range+0x119/0x2a0 mm/filemap.c:664
>  generic_file_read_iter+0x11d/0x3e0 mm/filemap.c:2375
>  call_read_iter include/linux/fs.h:1866 [inline]
>  generic_file_splice_read+0x22b/0x310 fs/splice.c:312
>  do_splice_to fs/splice.c:870 [inline]
>  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
>  do_splice_direct+0xf2/0x170 fs/splice.c:1059
>  do_sendfile+0x56a/0xba0 fs/read_write.c:1540
>  __do_sys_sendfile64 fs/read_write.c:1595 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
>  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1587
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 12715 Comm: syz-executor.4 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================

We had a discussion around this earlier this year:

	https://lore.kernel.org/lkml/20200305151831.GM29971@bombadil.infradead.org/#t

where you mentioned:

> - If a bit was set before and after the modification, it must be seen to
>   be set.
> - If a bit was clear before and after the modification, it must be seen to
>   be clear.
> - If a bit is modified, it may be seen as set or clear.

Do the atomic bitops satisfy those criteria?
(Though there were still some issues around find_next_bit(), but maybe
we can fix that?)

In general, we're wondering what is required to address this properly.

[ Note: There are a bunch more syzbot reports, which can be treated as
  duplicates, and haven't been sent to LKML:
	https://syzkaller.appspot.com/bug?id=b3f09ccd19880d00592d1692ae3bfe5933fa2b86
	https://syzkaller.appspot.com/bug?id=783c9bf4ad668f022c60e9b12bd8ce9974c1512a
	https://syzkaller.appspot.com/bug?id=711fd5ad665157363e7a21df0c3808884ebeabb9
	https://syzkaller.appspot.com/bug?id=cd60a83c9ff17c293fbb51355cf7b2f0420c4e0e
	https://syzkaller.appspot.com/bug?id=4b16c74b38549b01920b73e5f2df53be5e8dae75
	https://syzkaller.appspot.com/bug?id=7df642f4aa1c195834b4687ed3a9f18cd7f12ae8 ]

Thanks,
-- Marco
