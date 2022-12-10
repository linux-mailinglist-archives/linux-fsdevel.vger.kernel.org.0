Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCF648D2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 06:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLJFM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 00:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiLJFM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 00:12:57 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCA911C1C;
        Fri,  9 Dec 2022 21:12:51 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NTbWl2BQszqSxp;
        Sat, 10 Dec 2022 13:08:35 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 10 Dec 2022 13:12:47 +0800
Subject: Re: [PATCH] hfs: fix missing hfs_bnode_get() in __hfs_bnode_create
To:     Viacheslav Dubeyko <slava@dubeyko.com>
References: <20221209091035.2062184-1-liushixin2@huawei.com>
 <500343C9-FA5B-4A7B-8E68-F45AF5697CBC@dubeyko.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <fc69f11d-774e-2611-1434-33c0c5d7f990@huawei.com>
Date:   Sat, 10 Dec 2022 13:12:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <500343C9-FA5B-4A7B-8E68-F45AF5697CBC@dubeyko.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/12/10 3:46, Viacheslav Dubeyko wrote:
>
>> On Dec 9, 2022, at 1:10 AM, Liu Shixin <liushixin2@huawei.com> wrote:
>>
>> Syzbot found a kernel BUG in hfs_bnode_put():
>>
>> kernel BUG at fs/hfs/bnode.c:466!
>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 3634 Comm: kworker/u4:5 Not tainted 6.1.0-rc7-syzkaller-00190-g97ee9d1c1696 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
>> Workqueue: writeback wb_workfn (flush-7:0)
>> RIP: 0010:hfs_bnode_put+0x46f/0x480 fs/hfs/bnode.c:466
>> Code: 8a 80 ff e9 73 fe ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a0 fe ff ff 48 89 df e8 db 8a 80 ff e9 93 fe ff ff e8 a1 68 2c ff <0f> 0b e8 9a 68 2c ff 0f 0b 0f 1f 84 00 00 00 00 00 55 41 57 41 56
>> RSP: 0018:ffffc90003b4f258 EFLAGS: 00010293
>> RAX: ffffffff825e318f RBX: 0000000000000000 RCX: ffff8880739dd7c0
>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: ffffc90003b4f430 R08: ffffffff825e2d9b R09: ffffed10045157d1
>> R10: ffffed10045157d1 R11: 1ffff110045157d0 R12: ffff8880228abe80
>> R13: ffff88807016c000 R14: dffffc0000000000 R15: ffff8880228abe00
>> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fa6ebe88718 CR3: 000000001e93d000 CR4: 00000000003506f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  hfs_write_inode+0x1bc/0xb40
>>  write_inode fs/fs-writeback.c:1440 [inline]
>>  __writeback_single_inode+0x4d6/0x670 fs/fs-writeback.c:1652
>>  writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1878
>>  __writeback_inodes_wb+0x125/0x420 fs/fs-writeback.c:1949
>>  wb_writeback+0x440/0x7b0 fs/fs-writeback.c:2054
>>  wb_check_start_all fs/fs-writeback.c:2176 [inline]
>>  wb_do_writeback fs/fs-writeback.c:2202 [inline]
>>  wb_workfn+0x827/0xef0 fs/fs-writeback.c:2235
>>  process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>>  kthread+0x266/0x300 kernel/kthread.c:376
>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>>  </TASK>
>>
>> By tracing the refcnt, I found the node is find by hfs_bnode_findhash() in
>> __hfs_bnode_create(). There is a missing of hfs_bnode_get() after find the
>> node.
>>
> The patch looks good. But could you add more detailed explanation
> of the place of issue? I mean of adding source code of issue place
> into comment section. Because, this place fs/hfs/bnode.c:466 is already
> not consistent for the latest kernel version. And it will be not easy to find
> in the future. But its is important to see the code that trigger the issue
> to understand the fix.
>
> /* Dispose of resources used by a node */
> void hfs_bnode_put(struct hfs_bnode *node)
> {	
>   if (node) {
>        <skipped>	
>        BUG_ON(!atomic_read(&node->refcnt)); <— we  have issue here!!!!
>        <skipped>
>   }
> }
>
> Am I correct?
Yes, that is where trigger the BUG_ON().
>
> I believe it will be great to have more detail explanation how the
> issue is working. I mean the explanation how the issue happens
> and for what use-case. Could you please add it?
Thanks for your advice, I will add more detail explanation.
>
> Thanks,
> Slava.
>
>> Reported-by: syzbot+5b04b49a7ec7226c7426@syzkaller.appspotmail.com
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>> fs/hfs/bnode.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
>> index 2015e42e752a..6add6ebfef89 100644
>> --- a/fs/hfs/bnode.c
>> +++ b/fs/hfs/bnode.c
>> @@ -274,6 +274,7 @@ static struct hfs_bnode *__hfs_bnode_create(struct hfs_btree *tree, u32 cnid)
>> 		tree->node_hash[hash] = node;
>> 		tree->node_hash_cnt++;
>> 	} else {
>> +		hfs_bnode_get(node2);
>> 		spin_unlock(&tree->hash_lock);
>> 		kfree(node);
>> 		wait_event(node2->lock_wq, !test_bit(HFS_BNODE_NEW, &node2->flags));
>> -- 
>> 2.25.1
>>
>
> .
>

