Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FADF278064
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 08:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgIYGOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 02:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYGOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:14:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138A1C0613CE;
        Thu, 24 Sep 2020 23:14:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md22so895912pjb.0;
        Thu, 24 Sep 2020 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=be/0vLlE/LS0PZrj3/71lS5VwglJ0Fa9i+MMSb27bDU=;
        b=LHq28D0ipR6Og8vtGCYU4htehUf8oB02IwWqD2jMOkfRMS+N6TRfP27j6UvHyT5ur2
         WmdwrshEN3B/owH2TkGGrqfz55FA4LJHQw2+fRm3VFcFibRXziEIiQCSlJkiFO9KXd27
         aaM5hckTvo8hMF5MsHZahYHK85OzPSHphvvusxirCHSYC4rscnRI9IcFYjYu9jtYlyME
         75UwQkDIQmS4GuDQw3TUXCw5bs1TU4CFr7oD2rlazyvdurMjV2Z4xTCPTpI/8GFw0vVv
         Ap6dd8eP+Ek7O8pawjp9VhuGSZKK06iZrWNiWA3DCVVeT393J5uJP/bYGFXsL+xJV4kf
         bO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=be/0vLlE/LS0PZrj3/71lS5VwglJ0Fa9i+MMSb27bDU=;
        b=AhtUEwTllaQrF3e4kqzVVXcJJeVqkHEV23qQ43aaus1DRUpwjHanRmdzrjRR9y7q1u
         AFv3uRA8kTuvKIo0A/W/xxNPqbAK0uuEtYDpgdfif+qCSXkjqH/G+iFO06mFXgkZO6Fx
         FJ5YS0RkNPKvkfwUuoFPgYRygWFgOMLS9SWlJaX7QqmPfwncats/3icm+gC0jj77fwH/
         IjKZ3MWkaRCSABu/a4A4UpLhbYBGQGiCq1aaXQ7DStANeVUfqsN1GBksb447zonI5FZT
         6amYSK4Tb3Qm4Lc2uqCt+Pgv82vySInt2CQkj9SLESOZklfviShg5EOLzc/3p8vt2HoW
         +Ttg==
X-Gm-Message-State: AOAM533MS4hgt7CeVyni8OBZNk1Uad3KD/2kMYLMSo0JvBLuAAXL5Y0X
        kij6/Bzj0FbFHx7zrrQH22tZ70A2puE=
X-Google-Smtp-Source: ABdhPJx5KiNzPFIOfN1JZsXV8xiNPiD5FTfGDU9MJy5nhKixEnFTss0O2XdO0ChIOyUP1fUGjIsSNA==
X-Received: by 2002:a17:90a:ec05:: with SMTP id l5mr1284962pjy.172.1601014493578;
        Thu, 24 Sep 2020 23:14:53 -0700 (PDT)
Received: from bj08259pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f4sm1102759pgk.19.2020.09.24.23.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 23:14:53 -0700 (PDT)
From:   jing.xia.mail@gmail.com
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chunyan.zhang@unisoc.com, orson.zhai@unisoc.com,
        Jing Xia <jing.xia@unisoc.com>
Subject: [PATCH] fuse: avoid deadlock by clearing __GFP_FS
Date:   Fri, 25 Sep 2020 14:14:31 +0800
Message-Id: <1601014471-3126-1-git-send-email-jing.xia.mail@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jing Xia <jing.xia@unisoc.com>

Writeback thread and fuse block each other.
Writeback thread waits fuse's reply with inode's I_SYNC being
held.Fuse enters the slowpath of memory allocation when handle
the request and has to wait the inode's I_SYNC is cleared.

writeback's backtrace
---------------------
PID: 6197   TASK: ed130780  CPU: 3   COMMAND: "kworker/u8:7"
 #0 [<c0a0bae0>] (__schedule) from [<c0a0bdb0>]
 #1 [<c0a0bdb0>] (schedule) from [<c03d1330>]
 #2 [<c03d1330>] (__fuse_request_send) from [<c03d16a0>]
 #3 [<c03d16a0>] (fuse_simple_request) from [<c03d58fc>]
 #4 [<c03d58fc>] (fuse_flush_times) from [<c03d95dc>]
 #5 [<c03d95dc>] (fuse_write_inode) from [<c02df87c>]
 #6 [<c02df87c>] (__writeback_single_inode) from [<c02dee4c>]
 #7 [<c02dee4c>] (writeback_sb_inodes) from [<c02df0e8>]
 #8 [<c02df0e8>] (__writeback_inodes_wb) from [<c02de72c>]
 #9 [<c02de72c>] (wb_writeback) from [<c02dbafc>]
 #10 [<c02dbafc>] (wb_workfn) from [<c014d3d0>]
 #11 [<c014d3d0>] (process_one_work) from [<c014d9b8>]
 #12 [<c014d9b8>] (worker_thread) from [<c0151e40>]
 #13 [<c0151e40>] (kthread) from [<c0107648>]

fuse's backtrace
---------------------
PID: 4412   TASK: c4b47800  CPU: 3   COMMAND: "Thread-9"
 #0 [<c0a0bae0>] (__schedule) from [<c0a0bdb0>]
 #1 [<c0a0bdb0>] (schedule) from [<c0a0c74c>]
 #2 [<c0a0c74c>] (bit_wait) from [<c0a0c310>]
 #3 [<c0a0c310>] (__wait_on_bit) from [<c02db7d0>]
 #4 [<c02db7d0>] (__inode_wait_for_writeback) from [<c02db700>]
 #5 [<c02db700>] (inode_wait_for_writeback) from [<c02cb33c>]
 #6 [<c02cb33c>] (evict) from [<c02c40fc>]
 #7 [<c02c40fc>] (__dentry_kill) from [<c02c4430>]
 #8 [<c02c4430>] (shrink_dentry_list) from [<c02c41dc>]
 #9 [<c02c41dc>] (prune_dcache_sb) from [<c02af8a0>]
 #10 [<c02af8a0>] (super_cache_scan) from [<c0258f2c>]
 #11 [<c0258f2c>] (shrink_slab) from [<c025dc6c>]
 #12 [<c025dc6c>] (shrink_node) from [<c025b240>]
 #13 [<c025b240>] (do_try_to_free_pages) from [<c025adc0>]
 #14 [<c025adc0>] (try_to_free_pages) from [<c0249cb0>]
 #15 [<c0249cb0>] (__alloc_pages_nodemask) from [<c03d3638>]
 #16 [<c03d3638>] (fuse_copy_fill) from [<c03d33c0>]
 #17 [<c03d33c0>] (fuse_copy_one) from [<c03d2fe4>]
 #18 [<c03d2fe4>] (fuse_dev_do_read) from [<c03d2814>]
 #19 [<c03d2814>] (fuse_dev_splice_read) from [<c02e2548>]
 #20 [<c02e2548>] (sys_splice) from [<c0107740>]

This patch clears __GFP_FS flag when fuse alloctes pages to avoid
deadlock,as super_cache_scan will directly return SHRINK_STOP when
__GFP_FS is not set.

Signed-off-by: Jing Xia <jing.xia@unisoc.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 02b3c36..165c416 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -708,7 +708,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_HIGHUSER & ~__GFP_FS);
 			if (!page)
 				return -ENOMEM;
 
-- 
1.9.1

