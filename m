Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDC765B8FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 02:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbjACBo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Jan 2023 20:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjACBoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 20:44:19 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193DA62C4;
        Mon,  2 Jan 2023 17:44:17 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NmFrv2BgHz8QrkZ;
        Tue,  3 Jan 2023 09:44:15 +0800 (CST)
Received: from szxlzmapp05.zte.com.cn ([10.5.230.85])
        by mse-fl1.zte.com.cn with SMTP id 3031i4UL034383;
        Tue, 3 Jan 2023 09:44:04 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 3 Jan 2023 09:44:05 +0800 (CST)
Date:   Tue, 3 Jan 2023 09:44:05 +0800 (CST)
X-Zmail-TransId: 2b0363b38865ffffffffeece9359
X-Mailer: Zmail v1.0
Message-ID: <202301030944053580173@zte.com.cn>
In-Reply-To: <Y63IWTOE4sNKuseL@casper.infradead.org>
References: 202212292130035747813@zte.com.cn,Y63IWTOE4sNKuseL@casper.infradead.org
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <hannes@cmpxchg.org>, <iamjoonsoo.kim@lge.com>
Cc:     <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <willy@infradead.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBzd2FwX3N0YXRlOiB1cGRhdGUgc2hhZG93X25vZGVzIGZvciBhbm9ueW1vdXMgcGFnZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3031i4UL034383
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63B3886F.000 by FangMail milter!
X-FangMail-Envelope: 1672710255/4NmFrv2BgHz8QrkZ/63B3886F.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63B3886F.000/4NmFrv2BgHz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I tested the patch, and occur kernel panic, I am trying to solve it.

Hardware: qemu with 4G memory of x86.
OS: 5.14-rc6, with zram enabled.
Test program: some programs malloc and access some memory.
Trigger: count_shadow_nodes() return > 0 many times, and shadow_lru_isolate()
started it's work.
Log:
[ 4955.607376] BUG: unable to handle page fault for address: 000000ab000000aa
[ 4955.607376] #PF: supervisor read access in kernel mode
[ 4955.607376] #PF: error_code(0x0000) - not-present page
[ 4955.607376] PGD 115588067 P4D 0
[ 4955.607376] Oops: 0000 [#1] SMP NOPTI
[ 4955.607376] CPU: 2 PID: 72 Comm: kswapd0 Not tainted 5.14.0-rc6+ #101
[ 4955.607376] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[ 4955.607376] RIP: 0010:_raw_spin_trylock+0x0/0x20
[ 4955.607376] Code: 0f c1 07 f7 c6 00 02 00 00 74 01 fb c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f7 c6 00 02 00 00 c6 07 00 74 01 fb c3 0f 1f 00 <8b> 07 85 c0 75 0b ba 01 00 00 00 f0 0f b1 17 74 03 31 c0 c3 b8 01
[ 4955.607376] RSP: 0018:ff504e75c0267bc0 EFLAGS: 00000082
[ 4955.607376] RAX: 000000000000002f RBX: ff286ccb402c6108 RCX: c0000001001b49d9
[ 4955.607376] RDX: 0000000000000000 RSI: 00000001001b49d9 RDI: 000000ab000000aa
[ 4955.607376] RBP: ff286ccb6f6426e0 R08: 0000000000000003 R09: 000000000752a700
[ 4955.607376] R10: 000000000000003e R11: ff504e75c02679f0 R12: ff286ccb6f6426c8
[ 4955.607376] R13: 000000ab000000aa R14: ff286ccb402c6100 R15: ff286ccb402c6100
[ 4955.607376] FS:  0000000000000000(0000) GS:ff286ccb7bd00000(0000) knlGS:0000000000000000
[ 4955.607376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4955.607376] CR2: 000000ab000000aa CR3: 00000001001ae000 CR4: 00000000007516e0
[ 4955.607376] PKRU: 55555554
[ 4955.607376] Call Trace:
[ 4955.607376]  shadow_lru_isolate+0x5d/0x1a0
[ 4955.607376]  ? workingset_update_node+0x110/0x110
[ 4955.607376]  __list_lru_walk_one.isra.14+0x57/0x110
[ 4955.607376]  ? workingset_update_node+0x110/0x110
[ 4955.607376]  list_lru_walk_one_irq+0x32/0x40
[ 4955.607376]  shrink_slab.constprop.88+0x17a/0x380
[ 4955.607376]  shrink_node+0x1a8/0x400
[ 4955.607376]  balance_pgdat+0x288/0x520
[ 4955.607376]  kswapd+0x15e/0x390
[ 4955.607376]  ? wait_woken+0x60/0x60
[ 4955.607376]  ? balance_pgdat+0x520/0x520
[ 4955.607376]  kthread+0xf9/0x140
[ 4955.607376]  ? set_kthread_struct+0x40/0x40
[ 4955.607376]  ret_from_fork+0x22/0x30
[ 4955.607376] Modules linked in:
[ 4955.607376] CR2: 000000ab000000aa
[ 4955.607376] ---[ end trace 74c5ee73e52d917d ]---
[ 4955.607376] RIP: 0010:_raw_spin_trylock+0x0/0x20
[ 4955.607376] Code: 0f c1 07 f7 c6 00 02 00 00 74 01 fb c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 f7 c6 00 02 00 00 c6 07 00 74 01 fb c3 0f 1f 00 <8b> 07 85 c0 75 0b ba 01 00 00 00 f0 0f b1 17 74 03 31 c0 c3 b8 01
[ 4955.607376] RSP: 0018:ff504e75c0267bc0 EFLAGS: 00000082
[ 4955.607376] RAX: 000000000000002f RBX: ff286ccb402c6108 RCX: c0000001001b49d9
[ 4955.607376] RDX: 0000000000000000 RSI: 00000001001b49d9 RDI: 000000ab000000aa
[ 4955.607376] RBP: ff286ccb6f6426e0 R08: 0000000000000003 R09: 000000000752a700
[ 4955.607376] R10: 000000000000003e R11: ff504e75c02679f0 R12: ff286ccb6f6426c8
[ 4955.607376] R13: 000000ab000000aa R14: ff286ccb402c6100 R15: ff286ccb402c6100
[ 4955.607376] FS:  0000000000000000(0000) GS:ff286ccb7bd00000(0000) knlGS:0000000000000000
[ 4955.607376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4955.607376] CR2: 000000ab000000aa CR3: 00000001001ae000 CR4: 00000000007516e0
[ 4955.607376] PKRU: 5555555
