Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035FA1AAFF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411421AbgDORij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 13:38:39 -0400
Received: from sandeen.net ([63.231.237.45]:51432 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411346AbgDORif (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:38:35 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 1DFF6F8C2B;
        Wed, 15 Apr 2020 12:38:08 -0500 (CDT)
Subject: Re: [PATCH 2/5] blktrace: fix debugfs use after free
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
References: <20200414041902.16769-1-mcgrof@kernel.org>
 <20200414041902.16769-3-mcgrof@kernel.org>
From:   Eric Sandeen <sandeen@sandeen.net>
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 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 pA==
Message-ID: <55401e02-f61c-25eb-271c-3ec7baf35e28@sandeen.net>
Date:   Wed, 15 Apr 2020 12:38:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414041902.16769-3-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/13/20 11:18 PM, Luis Chamberlain wrote:
> On commit 6ac93117ab00 ("blktrace: use existing disk debugfs directory")
> merged on v4.12 Omar fixed the original blktrace code for request-based
> drivers (multiqueue). This however left in place a possible crash, if you
> happen to abuse blktrace in a way it was not intended.
> 
> Namely, if you loop adding a device, setup the blktrace with BLKTRACESETUP,
> forget to BLKTRACETEARDOWN, and then just remove the device you end up
> with a panic:

I think this patch makes this all cleaner anyway, but - without the apparent
loop bug mentioned by Bart which allows removal of the loop device while blktrace
is active (if I read that right), can this still happen?

-Eric

> [  107.193134] debugfs: Directory 'loop0' with parent 'block' already present!
> [  107.254615] BUG: kernel NULL pointer dereference, address: 00000000000000a0
> [  107.258785] #PF: supervisor write access in kernel mode
> [  107.262035] #PF: error_code(0x0002) - not-present page
> [  107.264106] PGD 0 P4D 0
> [  107.264404] Oops: 0002 [#1] SMP NOPTI
> [  107.264803] CPU: 8 PID: 674 Comm: kworker/8:2 Tainted: G            E 5.6.0-rc7-next-20200327 #1
> [  107.265712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> [  107.266553] Workqueue: events __blk_release_queue
> [  107.267051] RIP: 0010:down_write+0x15/0x40
> [  107.267488] Code: eb ca e8 ee a5 8d ff cc cc cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 55 48 89 fd e8 52 db ff ff 31 c0 ba 01 00 00 00 <f0> 48 0f b1 55 00 75 0f  65 48 8b 04 25 c0 8b 01 00 48 89 45 08 5d
> [  107.269300] RSP: 0018:ffff9927c06efda8 EFLAGS: 00010246
> [  107.269841] RAX: 0000000000000000 RBX: ffff8be7e73b0600 RCX: ffffff8100000000
> [  107.270559] RDX: 0000000000000001 RSI: ffffff8100000000 RDI: 00000000000000a0
> [  107.271281] RBP: 00000000000000a0 R08: ffff8be7ebc80fa8 R09: ffff8be7ebc80fa8
> [  107.272001] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  107.272722] R13: ffff8be7efc30400 R14: ffff8be7e0571200 R15: 00000000000000a0
> [  107.273475] FS:  0000000000000000(0000) GS:ffff8be7efc00000(0000) knlGS:0000000000000000
> [  107.274346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  107.274968] CR2: 00000000000000a0 CR3: 000000042abee003 CR4: 0000000000360ee0
> [  107.275710] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  107.276465] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  107.277214] Call Trace:
> [  107.277532]  simple_recursive_removal+0x4e/0x2e0
> [  107.278049]  ? debugfs_remove+0x60/0x60
> [  107.278493]  debugfs_remove+0x40/0x60
> [  107.278922]  blk_trace_free+0xd/0x50
> [  107.279339]  __blk_trace_remove+0x27/0x40
> [  107.279797]  blk_trace_shutdown+0x30/0x40
> [  107.280256]  __blk_release_queue+0xab/0x110
> [  107.280734]  process_one_work+0x1b4/0x380
> [  107.281194]  worker_thread+0x50/0x3c0
> [  107.281622]  kthread+0xf9/0x130
> [  107.281994]  ? process_one_work+0x380/0x380
> [  107.282467]  ? kthread_park+0x90/0x90
> [  107.282895]  ret_from_fork+0x1f/0x40
> [  107.283316] Modules linked in: loop(E) <etc>
> [  107.288562] CR2: 00000000000000a0
> [  107.288957] ---[ end trace b885d243d441bbce ]---

