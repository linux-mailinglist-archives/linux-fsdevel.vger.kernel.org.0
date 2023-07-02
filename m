Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638E4745070
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 21:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGBTi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGBTiX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71457C2;
        Sun,  2 Jul 2023 12:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06D6A60C83;
        Sun,  2 Jul 2023 19:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF1FC433CB;
        Sun,  2 Jul 2023 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326701;
        bh=3ddPsNWnWsc3KRBZaY4Vr9/bzTKlhYTv6uETFRaOq8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swEjSXAgRXiIopacl91hbTOwDMjDrc6y3DNnnjUqMXK5AHTE9P4PiYraeh/qkKPpy
         LFU61xnhYWFCq7PNgt7zvtiGXLu1f2Ibl9/L6nrF1E9BubdMz5Zze9Yyo9PzZajrSL
         +/v1ENHjPeSQJm0TSyxDQFbxhn6HCyfww4eF7v6QdreEGgYAx6yiM3h5z6FavPNaab
         eptLMU1Fhn5qTVYUidx9gVz4HgXhHFfSofhXAYY6wSTvNvRDYHa6Ncs2PzS41fSJx8
         X2IdyRbACYJAlA8aBtuUg/ux9YG5pIXGSASlUelQm93vZazjLJzrh+l76UJQm/xuT/
         t3s3In0eXNosw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 03/16] fs: use UB-safe check for signed addition overflow in remap_verify_area
Date:   Sun,  2 Jul 2023 15:38:02 -0400
Message-Id: <20230702193815.1775684-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193815.1775684-1-sashal@kernel.org>
References: <20230702193815.1775684-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

[ Upstream commit b7a9a503c38d665c05a789132b632d81ec0b2703 ]

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
Message-Id: <20230523162628.17071-1-dsterba@suse.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/remap_range.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 1331a890f2f29..87ae4f0dc3aa0 100644
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
2.39.2

