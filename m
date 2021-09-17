Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870DF410070
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhIQU66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 16:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbhIQU65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:58:57 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FFCC061574;
        Fri, 17 Sep 2021 13:57:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 203so2467444pfy.13;
        Fri, 17 Sep 2021 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYwIkcglVtBUNs/8XYOkfDTuYuTaGRxf1IE1dNFTBP0=;
        b=q7bF15N1jlNUh1O71Xb0VCkGx2rFXrm3zhJwFrD6jSVue0z+ZyjawlrLwFbh+9KIP6
         XSXFhCFVQWn0L/m4eegIy/+wME57I0X1ghaOgLw9DfnffY86nEG3n88f0zG5ZmUNketl
         3nleyctPZ0pgttFP8RPpSCVNHRLI/+TS4FzqbSK4Lmi+P+gZ4SgpcsUT42uQzF/JrAum
         NwKKdz1a5DuKjFjeIahIWRvOAeAr78nbhsYSMjEE0QaBQ8P+6X/DYkaclmjGlK1piW/k
         etdIUGkoVNfdsvLCiyag7CohgicUIYK7zkwzBZ3kJRaDHp5oTlp1Pk6hdA/cQmPu/r54
         tKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TYwIkcglVtBUNs/8XYOkfDTuYuTaGRxf1IE1dNFTBP0=;
        b=Xnt3bHHgAD3SZaNZUpMzD5K8UKVnUa6Yc7j6N4Pw54wy4eRMqGU9+SZ4Z5YTbmkWnI
         wAAYHm7jJfOGS6KX3WhiX1Doq7FLFGYyHVT9aOz8auSIZ+Eq5URrGJq4odo4CudUjv3L
         YAp01TOjGS1yXu85BBPJETMHrpE0MrdNCb1ivqTcmgRM1RA5RDZrO0kWUz3gUU3WmdXw
         3HhMwRPfeE9lXEO7vPrViJlTJXbN7BPxwRq7kLnrQcTLK9EG48U6cpPZeJcKlgtcitZ0
         63qsoGWezhcM9/PEonbUPIUw9MASgasyQD7oEa7Nlve6rQ3wB932vTlxvftJ+9/NSnnP
         Skvg==
X-Gm-Message-State: AOAM5302F7XiOSjEI8gjXx9nZnXjuLv0b7C6fKLXvYuEZi2iWxFI9HC3
        lTlHhE9wjFDHklWlSJGbe/o=
X-Google-Smtp-Source: ABdhPJwyMIF98TmO+53NAuE0Z6IeARMfNJBTMYgffoPm6vpRzgjO2GhfTaPMP5NVNK21K86yKtxoYA==
X-Received: by 2002:a63:741b:: with SMTP id p27mr11638047pgc.140.1631912254733;
        Fri, 17 Sep 2021 13:57:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-93-239-127.hsd1.ca.comcast.net. [73.93.239.127])
        by smtp.gmail.com with ESMTPSA id p15sm6781505pff.194.2021.09.17.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 13:57:33 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     willy@infradead.org, hughd@google.com, cfijalkovich@google.com,
        song@kernel.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: buffer: check huge page size instead of single page for invalidatepage
Date:   Fri, 17 Sep 2021 13:57:31 -0700
Message-Id: <20210917205731.262693-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hao Sun reported the below BUG on v5.15-rc1 kernel:

kernel BUG at fs/buffer.c:1510!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.14.0+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events delayed_fput
RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4aef93fb08 CR3: 0000000108cf2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 do_invalidatepage -origin/mm/truncate.c:157 [inline]
 truncate_cleanup_page+0x15c/0x280 -origin/mm/truncate.c:176
 truncate_inode_pages_range+0x169/0xc30 -origin/mm/truncate.c:325
 kill_bdev.isra.29+0x28/0x30
 blkdev_flush_mapping+0x4c/0x130 -origin/block/bdev.c:658
 blkdev_put_whole+0x54/0x60 -origin/block/bdev.c:689
 blkdev_put+0x6f/0x210 -origin/block/bdev.c:953
 blkdev_close+0x25/0x30 -origin/block/fops.c:459
 __fput+0xdf/0x380 -origin/fs/file_table.c:280
 delayed_fput+0x25/0x40 -origin/fs/file_table.c:308
 process_one_work+0x359/0x850 -origin/kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 -origin/kernel/workqueue.c:2444
 kthread+0x178/0x1b0 -origin/kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 -origin/arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 9dbb8f58f2109f10 ]---
RIP: 0010:block_invalidatepage+0x27f/0x2a0 -origin/fs/buffer.c:1510
Code: ff ff e8 b4 07 d7 ff b9 02 00 00 00 be 02 00 00 00 4c 89 ff 48
c7 c2 40 4e 25 84 e8 2b c2 c4 02 e9 c9 fe ff ff e8 91 07 d7 ff <0f> 0b
e8 8a 07 d7 ff 0f 0b e8 83 07 d7 ff 48 8d 5d ff e9 57 ff ff
RSP: 0018:ffffc9000065bb60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffea0000670000 RCX: 0000000000000000
RDX: ffff8880097fa240 RSI: ffffffff81608a9f RDI: ffffea0000670000
RBP: ffffea0000670000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000065b9f8 R11: 0000000000000003 R12: ffffffff81608820
R13: ffffc9000065bc68 R14: 0000000000000000 R15: ffffc9000065bbf0
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff98674f000 CR3: 0000000106b2e000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554

The debugging showed the page passed to invalidatepage is a huge page
and the length is the size of huge page instead of single page due to
read only FS THP support.  But block_invalidatepage() would throw BUG if
the size is greater than single page.

However there is actually a bigger problem in invalidatepage().  All the
implementations are *NOT* THP aware and hardcoded PAGE_SIZE.  Some triggers
BUG(), like block_invalidatepage(), some just returns error if length is
greater than PAGE_SIZE.

Converting PAGE_SIZE to thp_size() actually is not enough since the actual
invalidation part just assumes single page is passed in.  Since other subpages
may have private too because PG_private is per subpage so there may be
multiple subpages have private.  This may prevent the THP from splitting
and reclaiming since the extra refcount pins from private of subpages.

The complete fix seems not trivial and involve how to deal with huge
page in page cache.  So the scope of this patch is limited to close the
BUG at the moment.

Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Tested-by: Hao Sun <sunhao.th@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ab7573d72dd7..4bcb54c4d1be 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1507,7 +1507,7 @@ void block_invalidatepage(struct page *page, unsigned int offset,
 	/*
 	 * Check for overflow
 	 */
-	BUG_ON(stop > PAGE_SIZE || stop < length);
+	BUG_ON(stop > thp_size(page) || stop < length);
 
 	head = page_buffers(page);
 	bh = head;
@@ -1535,7 +1535,7 @@ void block_invalidatepage(struct page *page, unsigned int offset,
 	 * The get_block cached value has been unconditionally invalidated,
 	 * so real IO is not possible anymore.
 	 */
-	if (length == PAGE_SIZE)
+	if (length >= PAGE_SIZE)
 		try_to_release_page(page, 0);
 out:
 	return;
-- 
2.26.2

