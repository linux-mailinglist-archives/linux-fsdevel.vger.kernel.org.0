Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB8939A199
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFCMzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 08:55:51 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44787 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhFCMzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:55:50 -0400
Received: by mail-pg1-f171.google.com with SMTP id 29so5025859pgu.11;
        Thu, 03 Jun 2021 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P9XdF4IQa4HICLHDrIl6ecj193EbDBWLk7oFGC3LTNE=;
        b=pMLaMz4C7sgoxAN7CQFAJ5+pEG2Z5L9VuYYCsiIMFZ1PhBdpB0a5srLkrthUfo5aZB
         XNhdhN79/SH80c0R5npENFUDJ++PmRzITiVPRV7XI7xDPg3tUlo6OsIWwXdRoxb9CPKM
         V9c2iz4oTeloF1bNjm9wi8D1zq+GW4MNeItOmvyb4zNFXIPKw56gXvZnUNUnydgOFCll
         2h22Q/g6+Ne4zm1n3p87ngsPYXcaePA4F4zZkLFuSe3ERfT/0wv2QIzLOG8TlTb2X4Rh
         r0aqXaY8WJY/HU6aJikDnhNyRrxBDchQxSkQxdfmhtlT+MqXcckoJXQ3VowXpiVt0pIZ
         gzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P9XdF4IQa4HICLHDrIl6ecj193EbDBWLk7oFGC3LTNE=;
        b=nDGEoXwiSTHB7vzCkIr9jPDtN3NwMDR3lfMICVvL9aWXNkTZHSd1nDE6OUIpa7i1cv
         ThKZdeJA1mnJnxy0rhLfYj56yKa8ZDSfK1vGcouzxgxTt7E972SQIYiXcTg7nqI0l6By
         hKM+sHq4KNJaEjMPp5NR2JjU5nCtqRyHHTJzfLftgxNEvwj0/SQs1hFUDmpR+ST2Sdyx
         PYvVml+PyaqQxO/VKzTcZ5ypH/GU4dPHcDi7t9q20TO3IsbiKchevLW6Ph6iS7BbYQ8z
         qsNYkzpb3sFwxEOvO69uDYj2E0eeQzQzZ3ZRGZYtSYXdoKcpvh2QFfzizzD7vUTb3cS1
         ckdw==
X-Gm-Message-State: AOAM533cDzfOE9IfuieI+HTl+RnL9wiRiHJQqIHC3shUoWELyOCY3IG/
        GczBfrIBzLVd+ytuKBicHWjrpRrXYKTxNt6l
X-Google-Smtp-Source: ABdhPJxx20lQ+jQGl9QqaPoW7vZEl7Z6gK7J8BE5VLB5oDyEbR56TL6tocuucFNeHeepYfODfM4ofA==
X-Received: by 2002:a63:4706:: with SMTP id u6mr38960272pga.152.1622724770644;
        Thu, 03 Jun 2021 05:52:50 -0700 (PDT)
Received: from mi-HP-ProDesk-600-G5-PCI-MT.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id y14sm2253754pjr.51.2021.06.03.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:52:50 -0700 (PDT)
From:   chenguanyou <chenguanyou9338@gmail.com>
X-Google-Original-From: chenguanyou <chenguanyou@xiaomi.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenguanyou <chenguanyou@xiaomi.com>
Subject: [PATCH] [fuse] alloc_page nofs avoid deadlock
Date:   Thu,  3 Jun 2021 20:52:42 +0800
Message-Id: <20210603125242.31699-1-chenguanyou@xiaomi.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ABA deadlock

PID: 17172 TASK: ffffffc0c162c000 CPU: 6 COMMAND: "Thread-21"
0 [ffffff802d16b400] __switch_to at ffffff8008086a4c
1 [ffffff802d16b470] __schedule at ffffff80091ffe58
2 [ffffff802d16b4d0] schedule at ffffff8009200348
3 [ffffff802d16b4f0] bit_wait at ffffff8009201098
4 [ffffff802d16b510] __wait_on_bit at ffffff8009200a34
5 [ffffff802d16b5b0] inode_wait_for_writeback at ffffff800830e1e8
6 [ffffff802d16b5e0] evict at ffffff80082fb15c
7 [ffffff802d16b620] iput at ffffff80082f9270
8 [ffffff802d16b680] dentry_unlink_inode at ffffff80082f4c90
9 [ffffff802d16b6a0] __dentry_kill at ffffff80082f1710
10 [ffffff802d16b6d0] shrink_dentry_list at ffffff80082f1c34
11 [ffffff802d16b750] prune_dcache_sb at ffffff80082f18a8
12 [ffffff802d16b770] super_cache_scan at ffffff80082d55ac
13 [ffffff802d16b860] shrink_slab at ffffff8008266170
14 [ffffff802d16b900] shrink_node at ffffff800826b420
15 [ffffff802d16b980] do_try_to_free_pages at ffffff8008268460
16 [ffffff802d16ba60] try_to_free_pages at ffffff80082680d0
17 [ffffff802d16bbe0] __alloc_pages_nodemask at ffffff8008256514
18 [ffffff802d16bc60] fuse_copy_fill at ffffff8008438268
19 [ffffff802d16bd00] fuse_dev_do_read at ffffff8008437654
20 [ffffff802d16bdc0] fuse_dev_splice_read at ffffff8008436f40
21 [ffffff802d16be60] sys_splice at ffffff8008315d18
22 [ffffff802d16bff0] __sys_trace at ffffff8008084014

PID: 9652 TASK: ffffffc0c9ce0000 CPU: 4 COMMAND: "kworker/u16:8"
0 [ffffff802e793650] __switch_to at ffffff8008086a4c
1 [ffffff802e7936c0] __schedule at ffffff80091ffe58
2 [ffffff802e793720] schedule at ffffff8009200348
3 [ffffff802e793770] __fuse_request_send at ffffff8008435760
4 [ffffff802e7937b0] fuse_simple_request at ffffff8008435b14
5 [ffffff802e793930] fuse_flush_times at ffffff800843a7a0
6 [ffffff802e793950] fuse_write_inode at ffffff800843e4dc
7 [ffffff802e793980] __writeback_single_inode at ffffff8008312740
8 [ffffff802e793aa0] writeback_sb_inodes at ffffff80083117e4
9 [ffffff802e793b00] __writeback_inodes_wb at ffffff8008311d98
10 [ffffff802e793c00] wb_writeback at ffffff8008310cfc
11 [ffffff802e793d00] wb_workfn at ffffff800830e4a8
12 [ffffff802e793d90] process_one_work at ffffff80080e4fac
13 [ffffff802e793e00] worker_thread at ffffff80080e5670
14 [ffffff802e793e60] kthread at ffffff80080eb650

Signed-off-by: chenguanyou <chenguanyou@xiaomi.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c0fee830a34e..d36125ff0405 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -721,7 +721,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
 			if (!page)
 				return -ENOMEM;
 
-- 
2.17.1

