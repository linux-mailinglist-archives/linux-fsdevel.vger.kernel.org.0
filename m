Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5AE433A4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhJSPat (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhJSPas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:30:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98ABC06161C;
        Tue, 19 Oct 2021 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Irq5/RNAL7WL43IvnY258AeD+l1VaGXwOE52U+SqXPo=; b=BqHGICTN9X/CcGdj7L0ihv22zQ
        9q/SVG92dfC5oLbZmYixLJ1VoeZjUhyTv0j7beDiDnYzqJ574VBpdNozgOG0wpkTvZgUtJfb+eyRU
        67mH1EwkXdtlZ3p5s0bUScCzno9A7LX9i7efipTyVJ8Wvw3A2x28NbLz1TSEa3PmID9extSQyAg1g
        Iy6XY94RjdxjfyH304yfNLl/hOiRqm1zKIKcEjznjnyFeorh9b7ERTaNViTYOlgikBzTH5y7st9g2
        xMUWCCoYsKuj3jtlez6AQl+/jXVPGHzvIk5GfkVgDpt28kwJfj8iFoHzuzjSrPyUkz9cXJgIJB0eg
        OMGR8F7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcr2L-001gwU-3x; Tue, 19 Oct 2021 15:28:21 +0000
Date:   Tue, 19 Oct 2021 08:28:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YW7kFXlzRrvwzARP@bombadil.infradead.org>
References: <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
 <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW4uwep3BCe9Vxq8@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:34:41AM +0800, Ming Lei wrote:
> Please try the following patch against upstream(linus or next) tree(basically
> fold revised 2 and 3 of V1, and cover two issues: not fail zram_remove in
> module_exit(), race between zram_remove() and disksize_store()), and see if
> everything is fine for you:

Page fault ...

[   18.284256] zram: Removed device: zram0
[   18.312974] BUG: unable to handle page fault for address:
ffffad86de903008
[   18.313707] #PF: supervisor read access in kernel mode
[   18.314248] #PF: error_code(0x0000) - not-present page
[   18.314797] PGD 100000067 P4D 100000067 PUD 10031e067 PMD 136a28067
PTE 0
[   18.315538] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   18.316012] CPU: 3 PID: 1198 Comm: rmmod Tainted: G            E
5.15.0-rc3-next-20210927+ #89
[   18.316979] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.14.0-2 04/01/2014
[   18.317876] RIP: 0010:zram_free_page+0x1b/0xf0 [zram]
[   18.318430] Code: 1f 44 00 00 48 89 c8 c3 0f 1f 80 00 00 00 00 0f 1f
44 00 00 41 54 49 89 f4 55 89 f5 53 48 8b 17 48 c1 e5 04 48 89 fb 48 01
ea <48> 8b 42 08 a9 00 00 00 20 74 14 48 25 ff ff ff df 48 89 42 08 48
[   18.320412] RSP: 0018:ffffad86f8013df8 EFLAGS: 00010286
[   18.320978] RAX: 0000000000000001 RBX: ffff9b7b435c7800 RCX:
0000000000000200
[   18.321758] RDX: ffffad86de903000 RSI: 0000000000000000 RDI:
ffff9b7b435c7800
[   18.322524] RBP: 0000000000000000 R08: 0000000000000200 R09:
0000000000000000
[   18.323299] R10: 0000000000000200 R11: 0000000000000000 R12:
0000000000000000
[   18.324030] R13: ffff9b7b55191800 R14: ffff9b7b435c7820 R15:
ffff9b7b4677f960
[   18.324784] FS:  00007fc8e4c90580(0000) GS:ffff9b7c77cc0000(0000)
knlGS:0000000000000000
[   18.325651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.326272] CR2: ffffad86de903008 CR3: 000000014f1de003 CR4:
0000000000370ee0
[   18.327047] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   18.327818] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   18.328586] Call Trace:
[   18.328852]  <TASK>
[   18.329284]  zram_reset_device+0xd8/0x140 [zram]
[   18.329983]  zram_remove.cold+0xa/0x20 [zram]
[   18.330644]  ? hot_remove_store+0xe0/0xe0 [zram]
[   18.331367]  zram_remove_cb+0xd/0x10 [zram]
[   18.332010]  idr_for_each+0x5b/0xd0
[   18.332578]  destroy_devices+0x26/0x50 [zram]
[   18.333238]  __do_sys_delete_module+0x18d/0x2a0
[   18.333913]  ? fpregs_assert_state_consistent+0x1e/0x40
[   18.334665]  ? exit_to_user_mode_prepare+0x3a/0x180
[   18.335395]  do_syscall_64+0x38/0xc0
[   18.335966]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   18.336681] RIP: 0033:0x7fc8e4db64a7

