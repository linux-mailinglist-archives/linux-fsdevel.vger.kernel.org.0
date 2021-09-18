Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD5410227
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 02:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbhIRAIp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 20:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343701AbhIRAIj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:08:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD2DC061574;
        Fri, 17 Sep 2021 17:07:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v5so35510366edc.2;
        Fri, 17 Sep 2021 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCb02rFz7zrEJnzskA+LIE5W9dQmHkdeni2ADocJtPo=;
        b=O7/GDEztr/60U84WfYPkaOQcGWE3UdXreZuQ1YXIctUX7g1+zicIfj4dYCCTUA5fFB
         gQpMrt7FpMZJhi82EItITiVYbkNCsZ3pTVHm6h8D6FgrZ4B0dCU9Odw/b5B3tJA6nq/2
         Oayy6hN5K5xcT/W4o7K3ef7QBTO32t/mDspATsEUcE8Oq3B+HBFow/ePSlVRgQ+zoGuc
         VUQVW0gu0H4cUbHYwMOWBYcoOHTRfi3G57Hubg5LK2KfKFI63zFzhWy34cD7ZRkLU7m+
         tkTktg1ihwdp0beAVG10bTZighDXFmmH4tYe8ksi4orUY4r8cJelNUdjdZE1vm9d9KRN
         UbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCb02rFz7zrEJnzskA+LIE5W9dQmHkdeni2ADocJtPo=;
        b=sQJn1hDgCPHDdbdDGf7oEqMF/xerOIanqtu5Zd31B1MCd7Gk7XxsPk7BJquGtrj/71
         vR6xb0cXXG/H2yYGkAdHFSdi0BVC5/7RPYp6vPGuOLHjXJsw3j+91ZIIK6PdVducmGyl
         ejervtlzOFMI8LjIiC8ErCI6UmbUHqI9NRfBRDtG1Q3KnNb4A9GyGVIWvVzccOGJduBS
         NqI4BuZQEzL4MPh2PuC4qdsCtPEpr/MRdIy92Lg3QheDI0Kjt2yHjhl/mJz4ok75d/tT
         Qcqk3JUfcvIHPcOZTTRR3dvC8L0jhWUVgUTVU5FcwIqfIY5F2TjytfyCMx+s7q7Zc9Wp
         xI0A==
X-Gm-Message-State: AOAM531bLdlUG7AhoWhzDXLljL3V6MTtQp6woUxKG/kFFFzrgju293Nl
        pJuxm6jr5QZRUFFBzuXJNZ/nYZp/EdTo5VJycxo=
X-Google-Smtp-Source: ABdhPJznflaA3g55kqFdCiBRdu8gODjPXte0QNfteEawuyjCIgDeO6ZmlayWZkYv4MboUWElfR1/90yh4yRwzZBQ7Nc=
X-Received: by 2002:aa7:cd96:: with SMTP id x22mr15419773edv.46.1631923635126;
 Fri, 17 Sep 2021 17:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210917205731.262693-1-shy828301@gmail.com>
In-Reply-To: <20210917205731.262693-1-shy828301@gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 17 Sep 2021 17:07:03 -0700
Message-ID: <CAHbLzkqmooOJ0A6JmGD+y5w_BcFtSAJtKBXpXxYNcYrzbpCrNQ@mail.gmail.com>
Subject: Re: [PATCH] fs: buffer: check huge page size instead of single page
 for invalidatepage
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, cfijalkovich@google.com,
        song@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Hao Sun <sunhao.th@gmail.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc to the reporter. Sorry for missing Hao Sun in the first place.

On Fri, Sep 17, 2021 at 1:57 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Hao Sun reported the below BUG on v5.15-rc1 kernel:
>
> kernel BUG at fs/buffer.c:1510!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.14.0+ #15
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Workqueue: events delayed_fput
> RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
> Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
> e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
> RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
> RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
> RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
> R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
> FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4aef93fb08 CR3: 0000000108cf2000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  do_invalidatepage -origin/mm/truncate.c:157 [inline]
>  truncate_cleanup_page+0x15c/0x280 -origin/mm/truncate.c:176
>  truncate_inode_pages_range+0x169/0xc30 -origin/mm/truncate.c:325
>  kill_bdev.isra.29+0x28/0x30
>  blkdev_flush_mapping+0x4c/0x130 -origin/block/bdev.c:658
>  blkdev_put_whole+0x54/0x60 -origin/block/bdev.c:689
>  blkdev_put+0x6f/0x210 -origin/block/bdev.c:953
>  blkdev_close+0x25/0x30 -origin/block/fops.c:459
>  __fput+0xdf/0x380 -origin/fs/file_table.c:280
>  delayed_fput+0x25/0x40 -origin/fs/file_table.c:308
>  process_one_work+0x359/0x850 -origin/kernel/workqueue.c:2297
>  worker_thread+0x41/0x4d0 -origin/kernel/workqueue.c:2444
>  kthread+0x178/0x1b0 -origin/kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 -origin/arch/x86/entry/entry_64.S:295
> Modules linked in:
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> ---[ end trace 9dbb8f58f2109f10 ]---
> RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
> Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
> c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
> e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
> RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
> RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
> RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
> R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
> R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
> FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff98674f000 CR3: 0000000106b2e000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
>
> The debugging showed the page passed to invalidatepage is a huge page
> and the length is the size of huge page instead of single page due to
> read only FS THP support.  But block_invalidatepage() would throw BUG if
> the size is greater than single page.
>
> However there is actually a bigger problem in invalidatepage().  All the
> implementations are *NOT* THP aware and hardcoded PAGE_SIZE.  Some triggers
> BUG(), like block_invalidatepage(), some just returns error if length is
> greater than PAGE_SIZE.
>
> Converting PAGE_SIZE to thp_size() actually is not enough since the actual
> invalidation part just assumes single page is passed in.  Since other subpages
> may have private too because PG_private is per subpage so there may be
> multiple subpages have private.  This may prevent the THP from splitting
> and reclaiming since the extra refcount pins from private of subpages.
>
> The complete fix seems not trivial and involve how to deal with huge
> page in page cache.  So the scope of this patch is limited to close the
> BUG at the moment.
>
> Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs")
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Tested-by: Hao Sun <sunhao.th@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  fs/buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ab7573d72dd7..4bcb54c4d1be 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1507,7 +1507,7 @@ void block_invalidatepage(struct page *page, unsigned int offset,
>         /*
>          * Check for overflow
>          */
> -       BUG_ON(stop > PAGE_SIZE || stop < length);
> +       BUG_ON(stop > thp_size(page) || stop < length);
>
>         head = page_buffers(page);
>         bh = head;
> @@ -1535,7 +1535,7 @@ void block_invalidatepage(struct page *page, unsigned int offset,
>          * The get_block cached value has been unconditionally invalidated,
>          * so real IO is not possible anymore.
>          */
> -       if (length == PAGE_SIZE)
> +       if (length >= PAGE_SIZE)
>                 try_to_release_page(page, 0);
>  out:
>         return;
> --
> 2.26.2
>
