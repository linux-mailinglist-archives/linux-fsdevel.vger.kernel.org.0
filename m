Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9027976AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjIGQOS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjIGQOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:14:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF608284CF;
        Thu,  7 Sep 2023 08:47:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA45C4E663;
        Thu,  7 Sep 2023 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101455;
        bh=5UamJ9ke8+7Uvtdu9TDUqApCfgI2GisAxIGGy4At/hI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHNJtSIJlr8nRhN6424p6M1z36bwSCy/n6t+8Sd3Xj5nXy+lclogWlkhUSD8w2x5C
         o9GVP7pVh0ZAGTcF+Efo7toK7NvX9VIg+luGDwEy5c1VDSnpWBtyW3MbZiBuBXwY1T
         d7srHyLnnDbpLydGwwlaoAu5ebOIbJIYHHuwKzf/SU2YVeBiXbiHpX6qSRC1KkxPpz
         34/aJnEOVovQ84Cd3uB9cNZ7xzeXDzF6KivAqhUHkiT6Y5MZ3x38vvfg14qJnHnK4T
         kw56ZhTSohMQnMtuDDjHXMKT0LrEmMxupKvz6Oaq0k76gMOEBEBLobOBsxpYqN1KPU
         IHjdZt4Oc9D0g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Shiu <Will.Shiu@mediatek.com>,
        Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        matthias.bgg@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 3/3] locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock
Date:   Thu,  7 Sep 2023 11:44:08 -0400
Message-Id: <20230907154408.3421918-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907154408.3421918-1-sashal@kernel.org>
References: <20230907154408.3421918-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Will Shiu <Will.Shiu@mediatek.com>

[ Upstream commit 74f6f5912693ce454384eaeec48705646a21c74f ]

As following backtrace, the struct file_lock request , in posix_lock_inode
is free before ftrace function using.
Replace the ftrace function ahead free flow could fix the use-after-free
issue.

[name:report&]===============================================
BUG:KASAN: use-after-free in trace_event_raw_event_filelock_lock+0x80/0x12c
[name:report&]Read at addr f6ffff8025622620 by task NativeThread/16753
[name:report_hw_tags&]Pointer tag: [f6], memory tag: [fe]
[name:report&]
BT:
Hardware name: MT6897 (DT)
Call trace:
 dump_backtrace+0xf8/0x148
 show_stack+0x18/0x24
 dump_stack_lvl+0x60/0x7c
 print_report+0x2c8/0xa08
 kasan_report+0xb0/0x120
 __do_kernel_fault+0xc8/0x248
 do_bad_area+0x30/0xdc
 do_tag_check_fault+0x1c/0x30
 do_mem_abort+0x58/0xbc
 el1_abort+0x3c/0x5c
 el1h_64_sync_handler+0x54/0x90
 el1h_64_sync+0x68/0x6c
 trace_event_raw_event_filelock_lock+0x80/0x12c
 posix_lock_inode+0xd0c/0xd60
 do_lock_file_wait+0xb8/0x190
 fcntl_setlk+0x2d8/0x440
...
[name:report&]
[name:report&]Allocated by task 16752:
...
 slab_post_alloc_hook+0x74/0x340
 kmem_cache_alloc+0x1b0/0x2f0
 posix_lock_inode+0xb0/0xd60
...
 [name:report&]
 [name:report&]Freed by task 16752:
...
  kmem_cache_free+0x274/0x5b0
  locks_dispose_list+0x3c/0x148
  posix_lock_inode+0xc40/0xd60
  do_lock_file_wait+0xb8/0x190
  fcntl_setlk+0x2d8/0x440
  do_fcntl+0x150/0xc18
...

Signed-off-by: Will Shiu <Will.Shiu@mediatek.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 881fd16905c61..4899a4666f24d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1339,6 +1339,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
  out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
+	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
@@ -1347,7 +1348,6 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	if (new_fl2)
 		locks_free_lock(new_fl2);
 	locks_dispose_list(&dispose);
-	trace_posix_lock_inode(inode, request, error);
 
 	return error;
 }
-- 
2.40.1

