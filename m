Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFAC1DA5EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 02:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgETAAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 20:00:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56311 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgETAAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 20:00:14 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04K005Ys065809;
        Wed, 20 May 2020 09:00:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Wed, 20 May 2020 09:00:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04JNxwLe065757
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 May 2020 09:00:05 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] pipe: Fix pipe_full() test in opipe_prep().
Date:   Wed, 20 May 2020 08:59:58 +0900
Message-Id: <20200519235958.3802-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.2
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting unkillable task at splice(), and I found that
at least opipe_prep() is testing pipe_full() incorrectly.

CPU: 0 PID: 9460 Comm: syz-executor.5 Not tainted 5.6.0-rc3-next-20200228-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rol32 include/linux/bitops.h:105 [inline]
RIP: 0010:iterate_chain_key kernel/locking/lockdep.c:369 [inline]
RIP: 0010:__lock_acquire+0x6a3/0x5270 kernel/locking/lockdep.c:4178
Code: 89 c2 29 c1 44 01 e0 c1 c2 08 31 d1 89 ca 41 29 cc c1 c2 10 41 31 d4 8d 14 01 44 89 e1 44 29 e0 c1 c9 0d 89 d6 41 01 d4 31 c8 <89> c1 29 c6 44 01 e0 c1 c1 04 31 f1 48 c1 e1 20 48 09 c1 48 83 3c
RSP: 0018:ffffc900028e7a60 EFLAGS: 00000006
RAX: 00000000097f0e7e RBX: 0000000000000000 RCX: 00000000a6d2828a
RDX: 00000000fee63317 RSI: 00000000fee63317 RDI: ffffffff8c293888
RBP: ffff88808d606380 R08: 0000000000000001 R09: fffffbfff1852712
R10: ffff88808d606c20 R11: ffffffff8c29388f R12: 000000004f3787f1
R13: ffffffffffffffff R14: 0000000000000004 R15: 0000000000000001
FS:  00007fb7a92eb700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000234cfd0 CR3: 000000009efd9000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire+0x197/0x420 kernel/locking/lockdep.c:4720
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
 pipe_lock_nested fs/pipe.c:66 [inline]
 pipe_double_lock+0x1a0/0x1e0 fs/pipe.c:104
 splice_pipe_to_pipe fs/splice.c:1562 [inline]
 do_splice+0x35f/0x1520 fs/splice.c:1141
 __do_sys_splice fs/splice.c:1447 [inline]
 __se_sys_splice fs/splice.c:1427 [inline]
 __x64_sys_splice+0x2b5/0x320 fs/splice.c:1427
 do_syscall_64+0xf6/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 8cefc107ca54c8b0 ("pipe: Use head and tail pointers for the ring, not cursor and length")
Cc: stable@vger.kernel.org # 5.5+
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index fd0a1e7e5959..4e53efbd621d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1494,7 +1494,7 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
 	 * Check pipe occupancy without the inode lock first. This function
 	 * is speculative anyways, so missing one is ok.
 	 */
-	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
+	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage))
 		return 0;
 
 	ret = 0;
-- 
2.18.2

