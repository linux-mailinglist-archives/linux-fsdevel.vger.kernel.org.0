Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C8B783CC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 11:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjHVJUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHVJUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA4189;
        Tue, 22 Aug 2023 02:20:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F088961389;
        Tue, 22 Aug 2023 09:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CF9C433C8;
        Tue, 22 Aug 2023 09:20:39 +0000 (UTC)
Date:   Tue, 22 Aug 2023 11:20:36 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] procfs: Fix /proc/self/maps output for 32-bit kernel and
 compat tasks
Message-ID: <ZOR95DiR8tdcHDfq@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On a 32-bit kernel addresses should be shown with 8 hex digits, e.g.:

root@debian:~# cat /proc/self/maps
00010000-00019000 r-xp 00000000 08:05 787324     /usr/bin/cat
00019000-0001a000 rwxp 00009000 08:05 787324     /usr/bin/cat
0001a000-0003b000 rwxp 00000000 00:00 0          [heap]
f7551000-f770d000 r-xp 00000000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
f770d000-f770f000 r--p 001bc000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
f770f000-f7714000 rwxp 001be000 08:05 794765     /usr/lib/hppa-linux-gnu/libc.so.6
f7d39000-f7d68000 r-xp 00000000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
f7d68000-f7d69000 r--p 0002f000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
f7d69000-f7d6d000 rwxp 00030000 08:05 794759     /usr/lib/hppa-linux-gnu/ld.so.1
f7ea9000-f7eaa000 r-xp 00000000 00:00 0          [vdso]
f8565000-f8587000 rwxp 00000000 00:00 0          [stack]

But since commmit 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up
/proc/pid/maps") even on native 32-bit kernels the output looks like this:

root@debian:~# cat /proc/self/maps
0000000010000-0000000019000 r-xp 00000000 000000008:000000005 787324  /usr/bin/cat
0000000019000-000000001a000 rwxp 000000009000 000000008:000000005 787324  /usr/bin/cat
000000001a000-000000003b000 rwxp 00000000 00:00 0  [heap]
00000000f73d1000-00000000f758d000 r-xp 00000000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
00000000f758d000-00000000f758f000 r--p 000000001bc000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
00000000f758f000-00000000f7594000 rwxp 000000001be000 000000008:000000005 794765  /usr/lib/hppa-linux-gnu/libc.so.6
00000000f7af9000-00000000f7b28000 r-xp 00000000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
00000000f7b28000-00000000f7b29000 r--p 000000002f000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
00000000f7b29000-00000000f7b2d000 rwxp 0000000030000 000000008:000000005 794759  /usr/lib/hppa-linux-gnu/ld.so.1
00000000f7e0c000-00000000f7e0d000 r-xp 00000000 00:00 0  [vdso]
00000000f9061000-00000000f9083000 rwxp 00000000 00:00 0  [stack]

This patch brings back the old default 8-hex digit output for
32-bit kernels and compat tasks.

Fixes: 0e3dc0191431 ("procfs: add seq_put_hex_ll to speed up /proc/pid/maps")
Cc: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Helge Deller <deller@gmx.de>

---
v2:
- Linux kernel test robot complained that is_compat_task() isn't known.
  Use in_compat_syscall() instead and check for 32-bit kernel with
  !IS_ENABLED(CONFIG_64BIT)

---

diff --git a/fs/seq_file.c b/fs/seq_file.c
index f5fdaf3b1572..52a0ea05cad2 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -19,6 +19,7 @@
 #include <linux/printk.h>
 #include <linux/string_helpers.h>
 #include <linux/uio.h>
+#include <linux/compat.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -759,8 +760,9 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 			seq_puts(m, delimiter);
 	}
 
-	/* If x is 0, the result of __builtin_clzll is undefined */
-	if (v == 0)
+	/* If v is 0, the result of __builtin_clzll is undefined */
+	/* Use provided width on 32-bit kernel and compat mode */
+	if (v == 0 || !IS_ENABLED(CONFIG_64BIT) || in_compat_syscall())
 		len = 1;
 	else
 		len = (sizeof(v) * 8 - __builtin_clzll(v) + 3) / 4;
