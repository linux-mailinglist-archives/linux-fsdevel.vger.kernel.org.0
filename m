Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DD62C0381
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 11:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgKWKkT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 05:40:19 -0500
Received: from mail.alarsen.net ([144.76.18.233]:33806 "EHLO mail.alarsen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgKWKkT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:40:19 -0500
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 05:40:19 EST
Received: from oscar.alarsen.net (unknown [IPv6:2001:470:1f0b:246:3498:84b8:7f41:65f])
        by joe.alarsen.net (Postfix) with ESMTPS id 390C32B81DD6;
        Mon, 23 Nov 2020 11:34:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alarsen.net; s=joe;
        t=1606127676; bh=5UB9gRi58YkHAOOWjzB9D1YFAVo+0c+fLBzMcSZK4U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNKUunmlzlzNV4NcVdTNxs63JDsbZramNjylAouJz6OB3/4kfkuavMIcsupl9imaS
         xl/r06AgNhWNDQ6eX2KUMYe5ri5Bw+uv3Yszes+3wdozsEBG/4/y/4J1YyBoUrTlZ8
         RevcyYx/tmZQQA44DMKlmbQfBWlw5X5qkSboAXbY=
Received: by oscar.alarsen.net (Postfix, from userid 1000)
        id 2A1B327C0CAF; Mon, 23 Nov 2020 11:34:36 +0100 (CET)
From:   Anders Larsen <al@alarsen.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2] qnx4_match: do not over run the buffer
Date:   Mon, 23 Nov 2020 11:34:36 +0100
Message-Id: <20201123103436.7056-1-al@alarsen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201122012740.4814-1-ztong0001@gmail.com>
References: <20201122012740.4814-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tong Zhang <ztong0001@gmail.com>

the di_fname may not terminated by '\0', use strnlen to prevent buffer
overrun

[  513.248784] qnx4_readdir: bread failed (3718095557)
[  513.250880] ==================================================================
[  513.251109] BUG: KASAN: use-after-free in strlen+0x1f/0x40
[  513.251268] Read of size 1 at addr ffff888002700000 by task find/230
[  513.251419]
[  513.251677] CPU: 0 PID: 230 Comm: find Not tainted 5.10.0-rc4+ #64
[  513.251805] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-48-gd84
[  513.252069] Call Trace:
[  513.252310]  dump_stack+0x7d/0xa3
[  513.252443]  print_address_description.constprop.0+0x1e/0x220
[  513.252572]  ? _raw_spin_lock_irqsave+0x7b/0xd0
[  513.252681]  ? _raw_write_lock_irqsave+0xd0/0xd0
[  513.252785]  ? strlen+0x1f/0x40
[  513.252869]  ? strlen+0x1f/0x40
[  513.252955]  kasan_report.cold+0x37/0x7c
[  513.253059]  ? qnx4_block_map+0x130/0x1d0
[  513.253152]  ? strlen+0x1f/0x40
[  513.253237]  strlen+0x1f/0x40
[  513.253329]  qnx4_lookup+0xab/0x220
[  513.253431]  __lookup_slow+0x103/0x220
[  513.253531]  ? vfs_unlink+0x2e0/0x2e0
[  513.253626]  ? down_read+0xd8/0x190
[  513.253721]  ? down_write_killable+0x110/0x110
[  513.253823]  ? generic_permission+0x4c/0x240
[  513.253929]  walk_component+0x214/0x2c0
[  513.254035]  ? handle_dots.part.0+0x760/0x760
[  513.254137]  ? walk_component+0x2c0/0x2c0
[  513.254233]  ? path_init+0x546/0x6b0
[  513.254327]  ? __kernel_text_address+0x9/0x30
[  513.254430]  ? unwind_get_return_address+0x2a/0x40
[  513.254538]  ? create_prof_cpu_mask+0x20/0x20
[  513.254637]  ? arch_stack_walk+0x99/0xf0
[  513.254736]  path_lookupat.isra.0+0xb0/0x240
[  513.254840]  filename_lookup+0x128/0x250
[  513.254939]  ? may_linkat+0xb0/0xb0
[  513.255033]  ? __fput+0x199/0x3c0
[  513.255127]  ? kasan_save_stack+0x32/0x40
[  513.255224]  ? kasan_save_stack+0x1b/0x40
[  513.255323]  ? kasan_unpoison_shadow+0x33/0x40
[  513.255426]  ? __kasan_kmalloc.constprop.0+0xc2/0xd0
[  513.255538]  ? getname_flags+0x100/0x2a0
[  513.255635]  vfs_statx+0xd8/0x1d0
[  513.255728]  ? vfs_getattr+0x40/0x40
[  513.255821]  ? lockref_put_return+0xb2/0x120
[  513.255922]  __do_sys_newfstatat+0x7d/0xd0
[  513.256022]  ? __ia32_sys_newlstat+0x30/0x30
[  513.256122]  ? __kasan_slab_free+0x121/0x150
[  513.256222]  ? rcu_segcblist_enqueue+0x72/0x80
[  513.256333]  ? fpregs_assert_state_consistent+0x4d/0x60
[  513.256446]  ? exit_to_user_mode_prepare+0x2d/0xf0
[  513.256551]  ? __x64_sys_newfstatat+0x39/0x60
[  513.256651]  do_syscall_64+0x33/0x40
[  513.256750]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Co-Developed-by: Anders Larsen <al@alarsen.net>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Anders Larsen <al@alarsen.net>
---
v2: The name can grow longer than QNX4_SHORT_NAME_MAX if de is a
 QNX4_FILE_LINK type and de should points to a qnx4_link_info struct, so
 this is safe.  We also remove redundant checks in this version.

 fs/qnx4/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..2bcbbd7c772e 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -40,9 +40,7 @@ static int qnx4_match(int len, const char *name,
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
+	thislen = strnlen( de->di_fname, namelen );
 	if (len != thislen) {
 		return 0;
 	}
-- 
2.29.2

