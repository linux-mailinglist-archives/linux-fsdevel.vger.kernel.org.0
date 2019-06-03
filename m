Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671433315F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfFCNoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 09:44:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:45178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbfFCNoA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:44:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2571DAF0F;
        Mon,  3 Jun 2019 13:43:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2DE08DA85E; Mon,  3 Jun 2019 15:44:49 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH] fs: use UB-safe check for signed addition overflow in remap_verify_area
Date:   Mon,  3 Jun 2019 15:44:32 +0200
Message-Id: <20190603134432.32156-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following warning pops up with enabled UBSAN in tests fstests/generic/303:

  [23127.529395] UBSAN: Undefined behaviour in fs/read_write.c:1725:7
  [23127.529400] signed integer overflow:
  [23127.529403] 4611686018427322368 + 9223372036854775807 cannot be represented in type 'long long int'
  [23127.529412] CPU: 4 PID: 26180 Comm: xfs_io Not tainted 5.2.0-rc2-1.ge195904-vanilla+ #450
  [23127.556999] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
  [23127.557001] Call Trace:
  [23127.557060]  dump_stack+0x67/0x9b
  [23127.557070]  ubsan_epilogue+0x9/0x40
  [23127.573496]  handle_overflow+0xb3/0xc0
  [23127.573514]  do_clone_file_range+0x28f/0x2a0
  [23127.573547]  vfs_clone_file_range+0x35/0xb0
  [23127.573564]  ioctl_file_clone+0x8d/0xc0
  [23127.590144]  do_vfs_ioctl+0x300/0x700
  [23127.590160]  ksys_ioctl+0x70/0x80
  [23127.590203]  ? trace_hardirqs_off_thunk+0x1a/0x1c
  [23127.590210]  __x64_sys_ioctl+0x16/0x20
  [23127.590215]  do_syscall_64+0x5c/0x1d0
  [23127.590224]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
  [23127.590231] RIP: 0033:0x7ff6d7250327
  [23127.590241] RSP: 002b:00007ffe3a38f1d8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
  [23127.590246] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007ff6d7250327
  [23127.590249] RDX: 00007ffe3a38f220 RSI: 000000004020940d RDI: 0000000000000003
  [23127.590252] RBP: 0000000000000000 R08: 00007ffe3a3c80a0 R09: 00007ffe3a3c8080
  [23127.590255] R10: 000000000fa99fa0 R11: 0000000000000206 R12: 0000000000000000
  [23127.590260] R13: 0000000000000000 R14: 3fffffffffff0000 R15: 00007ff6d750a20c

As loff_t is a signed type, we should use the safe overflow checks
instead of relying on compiler implementation.

The bogus values are intentional and the test is supposed to verify the
boundary conditions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/read_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index c543d965e288..a8bd974edf72 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/overflow.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -1718,11 +1719,12 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 			     bool write)
 {
 	struct inode *inode = file_inode(file);
+	loff_t tmp;
 
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
 
-	 if (unlikely((loff_t) (pos + len) < 0))
+	if (unlikely(check_add_overflow(pos, len, &tmp)))
 		return -EINVAL;
 
 	if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
-- 
2.21.0

