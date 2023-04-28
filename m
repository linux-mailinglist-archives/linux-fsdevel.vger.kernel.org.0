Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1BD6F10E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 05:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjD1Drd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 23:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjD1Drc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 23:47:32 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6418A269D;
        Thu, 27 Apr 2023 20:47:29 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6z3R4R2vzpTMg;
        Fri, 28 Apr 2023 11:43:31 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 11:47:26 +0800
Message-ID: <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
Date:   Fri, 28 Apr 2023 11:47:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>,
        Baokun Li <libaokun1@huawei.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEny7Izr8iOc/23B@casper.infradead.org>
 <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/4/28 9:41, Ming Lei wrote:
> On Thu, Apr 27, 2023 at 07:27:04PM +0800, Ming Lei wrote:
>> On Thu, Apr 27, 2023 at 07:19:35PM +0800, Baokun Li wrote:
>>> On 2023/4/27 18:01, Ming Lei wrote:
>>>> On Thu, Apr 27, 2023 at 02:36:51PM +0800, Baokun Li wrote:
>>>>> On 2023/4/27 12:50, Ming Lei wrote:
>>>>>> Hello Matthew,
>>>>>>
>>>>>> On Thu, Apr 27, 2023 at 04:58:36AM +0100, Matthew Wilcox wrote:
>>>>>>> On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
>>>>>>>> Hello Guys,
>>>>>>>>
>>>>>>>> I got one report in which buffered write IO hangs in balance_dirty_pages,
>>>>>>>> after one nvme block device is unplugged physically, then umount can't
>>>>>>>> succeed.
>>>>>>> That's a feature, not a bug ... the dd should continue indefinitely?
>>>>>> Can you explain what the feature is? And not see such 'issue' or 'feature'
>>>>>> on xfs.
>>>>>>
>>>>>> The device has been gone, so IMO it is reasonable to see FS buffered write IO
>>>>>> failed. Actually dmesg has shown that 'EXT4-fs (nvme0n1): Remounting
>>>>>> filesystem read-only'. Seems these things may confuse user.
>>>>> The reason for this difference is that ext4 and xfs handle errors
>>>>> differently.
>>>>>
>>>>> ext4 remounts the filesystem as read-only or even just continues, vfs_write
>>>>> does not check for these.
>>>> vfs_write may not find anything wrong, but ext4 remount could see that
>>>> disk is gone, which might happen during or after remount, however.
>>>>
>>>>> xfs shuts down the filesystem, so it returns a failure at
>>>>> xfs_file_write_iter when it finds an error.
>>>>>
>>>>>
>>>>> ``` ext4
>>>>> ksys_write
>>>>>    vfs_write
>>>>>     ext4_file_write_iter
>>>>>      ext4_buffered_write_iter
>>>>>       ext4_write_checks
>>>>>        file_modified
>>>>>         file_modified_flags
>>>>>          __file_update_time
>>>>>           inode_update_time
>>>>>            generic_update_time
>>>>>             __mark_inode_dirty
>>>>>              ext4_dirty_inode ---> 2. void func, No propagating errors out
>>>>>               __ext4_journal_start_sb
>>>>>                ext4_journal_check_start ---> 1. Error found, remount-ro
>>>>>       generic_perform_write ---> 3. No error sensed, continue
>>>>>        balance_dirty_pages_ratelimited
>>>>>         balance_dirty_pages_ratelimited_flags
>>>>>          balance_dirty_pages
>>>>>           // 4. Sleeping waiting for dirty pages to be freed
>>>>>           __set_current_state(TASK_KILLABLE)
>>>>>           io_schedule_timeout(pause);
>>>>> ```
>>>>>
>>>>> ``` xfs
>>>>> ksys_write
>>>>>    vfs_write
>>>>>     xfs_file_write_iter
>>>>>      if (xfs_is_shutdown(ip->i_mount))
>>>>>        return -EIO;    ---> dd fail
>>>>> ```
>>>> Thanks for the info which is really helpful for me to understand the
>>>> problem.
>>>>
>>>>>>> balance_dirty_pages() is sleeping in KILLABLE state, so kill -9 of
>>>>>>> the dd process should succeed.
>>>>>> Yeah, dd can be killed, however it may be any application(s), :-)
>>>>>>
>>>>>> Fortunately it won't cause trouble during reboot/power off, given
>>>>>> userspace will be killed at that time.
>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Ming
>>>>>>
>>>>> Don't worry about that, we always set the current thread to TASK_KILLABLE
>>>>>
>>>>> while waiting in balance_dirty_pages().
>>>> I have another concern, if 'dd' isn't killed, dirty pages won't be cleaned, and
>>>> these (big amount)memory becomes not usable, and typical scenario could be USB HDD
>>>> unplugged.
>>>>
>>>>
>>>> thanks,
>>>> Ming
>>> Yes, it is unreasonable to continue writing data with the previously opened
>>> fd after
>>> the file system becomes read-only, resulting in dirty page accumulation.
>>>
>>> I provided a patch in another reply.
>>> Could you help test if it can solve your problem?
>>> If it can indeed solve your problem, I will officially send it to the email
>>> list.
>> OK, I will test it tomorrow.
> Your patch can avoid dd hang when bs is 512 at default, but if bs is
> increased to 1G and more 'dd' tasks are started, the dd hang issue
> still can be observed.

Thank you for your testing!

Yes, my patch only prevents the adding of new dirty pages, but it 
doesn't clear
the dirty pages that already exist. The reason why it doesn't work after 
bs grows
is that there are already enough dirty pages to trigger 
balance_dirty_pages().
Executing drop_caches at this point may make dd fail and exit. But the 
dirty pages
are still not cleared, nor is the shutdown implemented by ext4. These 
dirty pages
will not be cleared until the filesystem is unmounted.

This is the result of my test at bs=512:

ext4 -- remount read-only
OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
313872 313872 100%    0.10K   8048   39 32192K buffer_head   ---> wait 
to max
82602  82465  99%     0.10K   2118   39  8472K buffer_head   ---> kill 
dd && drop_caches
897    741    82%     0.10K     23   39    92K buffer_head   ---> umount

patched:
25233  25051  99%    0.10K    647     39     2588K buffer_head
>
> The reason should be the next paragraph I posted.
>
> Another thing is that if remount read-only makes sense on one dead
> disk? Yeah, block layer doesn't export such interface for querying
> if bdev is dead. However, I think it is reasonable to export such
> interface if FS needs that.
Ext4 just detects I/O Error and remounts it as read-only, it doesn't know
if the current disk is dead or not.

I asked Yu Kuai and he said that disk_live() can be used to determine 
whether
a disk has been removed based on the status of the inode corresponding to
the block device, but this is generally not done in file systems.
>
>> But I am afraid if it can avoid the issue completely because the
>> old write task hang in balance_dirty_pages() may still write/dirty pages
>> if it is one very big size write IO.
>
> thanks,
> Ming
>
Those dirty pages that are already there are piling up and can't be 
written back,
which I think is a real problem. Can the block layer clear those dirty 
pages when
it detects that the disk is deleted?


-- 
With Best Regards,
Baokun Li
.
