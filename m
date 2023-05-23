Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D553170E267
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 18:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbjEWQcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 12:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjEWQck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 12:32:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C1DD;
        Tue, 23 May 2023 09:32:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 893EA22925;
        Tue, 23 May 2023 16:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684859557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Jgln17Itx5qPVoKJlWMfz4FJb2LjDNqFHYWInznf3aw=;
        b=QxkQFOSxtNEoEdH1bnrO66HEJd2Zwin6JvwUuTU958yG6YUL/HVKt6sZtMzjDsMZkim/dK
        YxsYK8Cc6Xh/N+RfWa8wkbvwHEgw7p6sLLYPQdv5sCRY6PX8pGWaTcGTf6SKaezCcWLP+b
        bBctfzPkyZVIDTqf32NnLE+p5XNIV00=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 65ADE2C141;
        Tue, 23 May 2023 16:32:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DECACDA7D7; Tue, 23 May 2023 18:26:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] fs: use UB-safe check for signed addition overflow in remap_verify_area
Date:   Tue, 23 May 2023 18:26:28 +0200
Message-Id: <20230523162628.17071-1-dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

 fs/remap_range.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 1331a890f2f2..87ae4f0dc3aa 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -15,6 +15,7 @@
 #include <linux/mount.h>
 #include <linux/fs.h>
 #include <linux/dax.h>
+#include <linux/overflow.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -101,10 +102,12 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 			     bool write)
 {
+	loff_t tmp;
+
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
 
-	if (unlikely((loff_t) (pos + len) < 0))
+	if (unlikely(check_add_overflow(pos, len, &tmp)))
 		return -EINVAL;
 
 	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
-- 
2.40.0

