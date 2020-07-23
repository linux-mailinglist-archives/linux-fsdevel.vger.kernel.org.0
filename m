Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E422A5ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 05:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbgGWDRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 23:17:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8253 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728902AbgGWDRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:17:23 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22A981FEE23B5CF0C187;
        Thu, 23 Jul 2020 11:17:19 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.20) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Jul 2020 11:17:10 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <yi.zhang@huawei.com>
CC:     <ast@kernel.org>, <chenjie6@huawei.com>, <daniel@iogearbox.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <viro@zeniv.linux.org.uk>,
        <zhongguohua1@huawei.com>, <wangfangpeng1@huawei.com>
Subject: Re: [PATCH] jffs2: move jffs2_init_inode_info() just after allocating inode
Date:   Thu, 23 Jul 2020 11:17:08 +0800
Message-ID: <1595474228-20495-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1559fa23-525b-5dad-220e-2ab2821d33eb@huawei.com>
References: <1559fa23-525b-5dad-220e-2ab2821d33eb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/1/6 16:04, zhangyi (F) wrote:
> After commit 4fdcfab5b553 ("jffs2: fix use-after-free on symlink
> traversal"), it expose a freeing uninitialized memory problem due to
> this commit move the operaion of freeing f->target to
> jffs2_i_callback(), which may not be initialized in some error path of
> allocating jffs2 inode (eg: jffs2_iget()->iget_locked()->
> destroy_inode()->..->jffs2_i_callback()->kfree(f->target)).
> 
> Fix this by initialize the jffs2_inode_info just after allocating it.

We are having the same problem. After commit 4fdcfab5b553 ("jffs2: fix use-after-free on symlink
> traversal"), f->target is freed before it is initialized in the iget_locked() path. This is dangerous and may trigger slub BUG_ON:

kernel BUG at mm/slub.c:3824!
Internal error: Oops - BUG: 0 [#1] SMP ARM
CPU: 2 PID: 9 Comm: rcuos/0 Tainted: P           O    4.4.185 #1
task: cf4a3f68 task.stack: cf4ca000
PC is at kfree+0xfc/0x264
LR is at jffs2_i_callback+0x10/0x28 [jffs2]
pc : [<c032a4f0>]    lr : [<bf0ab188>]    psr: 400e0213
sp : cf4cbec8  ip : 00000000  fp : c0273df8
r10: ceb12848  r9 : 0000000c  r8 : cdd52000
r7 : bf0ab188  r6 : 0000000c  r5 : e7fddef0  r4 : c1121ba0
r3 : 00000100  r2 : c0ac4010  r1 : 00000002  r0 : e7fddef0
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 32c5387d  Table: 0e315940  DAC: 55555555
Process rcuos/0 (pid: 9, stack limit = 0xcf4ca190)
Stack: (0xcf4cbec8 to 0xcf4cc000)
bec0:                   c086efa8 c032a3a8 00000001 c0273e9c c0a29214 c3931db8
bee0: 00000000 0000000c ffffe000 cdd52000 0000000c ceb12848 c0273df8 bf0ab188
bf00: c0adf980 c0273e9c c0adf980 00000001 00000000 ffffff7c 00000000 cf4a3f68
bf20: c025bc18 cf4cbf24 cf4cbf24 c0a22448 c0adf980 cf4ca000 cf485ac0 00000000
bf40: c0adf980 c02739b0 00000000 00000000 00000000 c02380bc 00000000 c0adf380
bf60: c0adf980 00000000 00000000 00000000 00008001 cf4cbf74 cf4cbf74 00000000
bf80: 00000000 00000000 00008001 cf4cbf8c cf4cbf8c c0a22448 cf485ac0 c0237fb8
bfa0: 00000000 00000000 00000000 c0202db4 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c032a4f0>] (kfree) from [<bf0ab188>] (jffs2_i_callback+0x10/0x28 [jffs2])
[<bf0ab188>] (jffs2_i_callback [jffs2]) from [<c0273e9c>] (rcu_nocb_kthread+0x4ec/0x504)
[<c0273e9c>] (rcu_nocb_kthread) from [<c02380bc>] (kthread+0x104/0x118)
[<c02380bc>] (kthread) from [<c0202db4>] (ret_from_fork+0x14/0x20)
Code: 0300001a 143094e5 010013e3 0000001a (f201f0e7)
