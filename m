Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39B1797693
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 18:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjIGQN2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239971AbjIGQM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:12:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB16B33D;
        Thu,  7 Sep 2023 08:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A11C4DE17;
        Thu,  7 Sep 2023 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694101448;
        bh=ldvej6DbdMKOtKrMcX2LmElswHIsXD41vYYtsytz/hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNiiNMrSH5V0icyNxRNJWoM+1UBu3abPnMJEu0zDrhmTNlGFRrq7WSv7drkamGPsT
         MLFBCM8cW9v206xVNKl+Om6u942LZoLJ2jmjgSnYXqzksrdBB0HAZgOh889Gr9jRcU
         /1feh3xlRtxF96153z/jgqUy2o68EO5aPXJ65mjMRo3bIIztx1J8r8iXd24nHGdbf0
         0+qPwGAVl4kwcCXTT4ra527kk3ep2zZUMOjMpktUXSFuqF4DkX8V6gGdp1heInC3Mt
         GpxHuYWugbTDcL/yWdQdpgUtB6MyxCG0QoPGynSMzWc8Sz8zvmpZbPGs6dr2nA7NbW
         9Cmaz/gbDZy1g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Shiu <Will.Shiu@mediatek.com>,
        Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, matthias.bgg@gmail.com,
        linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 4/4] locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock
Date:   Thu,  7 Sep 2023 11:44:00 -0400
Message-Id: <20230907154400.3421858-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907154400.3421858-1-sashal@kernel.org>
References: <20230907154400.3421858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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
index 240b9309ed6d5..1047ab2b15e96 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1300,6 +1300,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
  out:
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
+	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
@@ -1308,7 +1309,6 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 	if (new_fl2)
 		locks_free_lock(new_fl2);
 	locks_dispose_list(&dispose);
-	trace_posix_lock_inode(inode, request, error);
 
 	return error;
 }
-- 
2.40.1

