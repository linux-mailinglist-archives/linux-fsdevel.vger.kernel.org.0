Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818D132D448
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 14:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhCDNi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 08:38:59 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13432 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbhCDNid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:38:33 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DrsMt2L4JzjVKJ;
        Thu,  4 Mar 2021 21:36:26 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Mar 2021 21:37:43 +0800
Subject: Re: [PATCH] block_dump: don't put the last refcount when marking
 inode dirty
To:     Jan Kara <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <tytso@mit.edu>, <viro@zeniv.linux.org.uk>,
        <linfeilong@huawei.com>, Ye Bin <yebin10@huawei.com>
References: <20210226103103.3048803-1-yi.zhang@huawei.com>
 <20210301112102.GD25026@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <5f72dc70-9fb0-0d3b-dc31-f60d35929991@huawei.com>
Date:   Thu, 4 Mar 2021 21:37:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210301112102.GD25026@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/3/1 19:21, Jan Kara wrote:
> On Fri 26-02-21 18:31:03, zhangyi (F) wrote:
>> There is an AA deadlock problem when using block_dump on ext4 file
>> system with data=journal mode.
>>
>>   watchdog: BUG: soft lockup - CPU#19 stuck for 22s! [jbd2/pmem0-8:1002]
>>   CPU: 19 PID: 1002 Comm: jbd2/pmem0-8
>>   RIP: 0010:queued_spin_lock_slowpath+0x60/0x3b0
>>   ...
>>   Call Trace:
>>    _raw_spin_lock+0x57/0x70
>>    jbd2_journal_invalidatepage+0x166/0x680
>>    __ext4_journalled_invalidatepage+0x8c/0x120
>>    ext4_journalled_invalidatepage+0x12/0x40
>>    truncate_cleanup_page+0x10e/0x1c0
>>    truncate_inode_pages_range+0x2c8/0xec0
>>    truncate_inode_pages_final+0x41/0x90
>>    ext4_evict_inode+0x254/0xac0
>>    evict+0x11c/0x2f0
>>    iput+0x20e/0x3a0
>>    dentry_unlink_inode+0x1bf/0x1d0
>>    __dentry_kill+0x14c/0x2c0
>>    dput+0x2bc/0x630
>>    block_dump___mark_inode_dirty.cold+0x5c/0x111
>>    __mark_inode_dirty+0x678/0x6b0
>>    mark_buffer_dirty+0x16e/0x1d0
>>    __jbd2_journal_temp_unlink_buffer+0x127/0x1f0
>>    __jbd2_journal_unfile_buffer+0x24/0x80
>>    __jbd2_journal_refile_buffer+0x12f/0x1b0
>>    jbd2_journal_commit_transaction+0x244b/0x3030
>>
>> The problem is a race between jbd2 committing data buffer and user
>> unlink the file concurrently. The jbd2 will get jh->b_state_lock and
>> redirty the inode's data buffer and inode itself. If block_dump is
>> enabled, it will try to find inode's dentry and invoke the last dput()
>> after the inode was unlinked. Then the evict procedure will unmap
>> buffer and get jh->b_state_lock again in journal_unmap_buffer(), and
>> finally lead to deadlock. It works fine if block_dump is not enabled
>> because the last evict procedure is not invoked in jbd2 progress and
>> the jh->b_state_lock will also prevent inode use after free.
>>
>> jbd2                                xxx
>>                                     vfs_unlink
>>                                      ext4_unlink
>> jbd2_journal_commit_transaction
>> **get jh->b_state_lock**
>> jbd2_journal_refile_buffer
>>  mark_buffer_dirty
>>   __mark_inode_dirty
>>    block_dump___mark_inode_dirty
>>     d_find_alias
>>                                      d_delete
>>                                       unhash
>>     dput  //put the last refcount
>>      evict
>>       journal_unmap_buffer
>>        **get jh->b_state_lock again**
>>
>> In most cases of where invoking mark_inode_dirty() will get inode's
>> refcount and the last iput may not happen, but it's not safe. After
>> checking the block_dump code, it only want to dump the file name of the
>> dirty inode, so there is no need to get and put denrty, and dump an
>> unhashed dentry is also fine. This patch remove the dget() && dput(),
>> print the dentry name directly.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> Signed-off-by: yebin (H) <yebin10@huawei.com>
> 
> Hrm, ok. Honestly, I wanted to just delete that code for a long time. IMO
> tracepoints (and we have one in __mark_inode_dirty) are much more useful
> for tracing anyway. This code exists only because it was there much before
> tracepoints existed... Do you have a strong reason why are you using
> block_dump instead of tracepoint trace_writeback_mark_inode_dirty() for
> your monitoring?
> 

Hi, Jan. We just do some stress tests and find this issue, I'm not sure who
are still using this old debug interface and gather it may need time. Could
we firstly fix this issue, and then delete this code if no opposed?

Thanks,
Yi.
