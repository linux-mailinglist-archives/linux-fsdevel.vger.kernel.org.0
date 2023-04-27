Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F266F00D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 08:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242951AbjD0GhL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbjD0GhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:37:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358204497;
        Wed, 26 Apr 2023 23:37:09 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q6QwJ0kWnzsR8d;
        Thu, 27 Apr 2023 14:35:28 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 14:37:06 +0800
Message-ID: <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
Date:   Thu, 27 Apr 2023 14:36:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
To:     Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Theodore Ts'o <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
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
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
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

On 2023/4/27 12:50, Ming Lei wrote:
> Hello Matthew,
>
> On Thu, Apr 27, 2023 at 04:58:36AM +0100, Matthew Wilcox wrote:
>> On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
>>> Hello Guys,
>>>
>>> I got one report in which buffered write IO hangs in balance_dirty_pages,
>>> after one nvme block device is unplugged physically, then umount can't
>>> succeed.
>> That's a feature, not a bug ... the dd should continue indefinitely?
> Can you explain what the feature is? And not see such 'issue' or 'feature'
> on xfs.
>
> The device has been gone, so IMO it is reasonable to see FS buffered write IO
> failed. Actually dmesg has shown that 'EXT4-fs (nvme0n1): Remounting
> filesystem read-only'. Seems these things may confuse user.


The reason for this difference is that ext4 and xfs handle errors 
differently.

ext4 remounts the filesystem as read-only or even just continues, 
vfs_write does not check for these.

xfs shuts down the filesystem, so it returns a failure at 
xfs_file_write_iter when it finds an error.


``` ext4
ksys_write
  vfs_write
   ext4_file_write_iter
    ext4_buffered_write_iter
     ext4_write_checks
      file_modified
       file_modified_flags
        __file_update_time
         inode_update_time
          generic_update_time
           __mark_inode_dirty
            ext4_dirty_inode ---> 2. void func, No propagating errors out
             __ext4_journal_start_sb
              ext4_journal_check_start ---> 1. Error found, remount-ro
     generic_perform_write ---> 3. No error sensed, continue
      balance_dirty_pages_ratelimited
       balance_dirty_pages_ratelimited_flags
        balance_dirty_pages
         // 4. Sleeping waiting for dirty pages to be freed
         __set_current_state(TASK_KILLABLE)
         io_schedule_timeout(pause);
```

``` xfs
ksys_write
  vfs_write
   xfs_file_write_iter
    if (xfs_is_shutdown(ip->i_mount))
      return -EIO;    ---> dd fail
```
>> balance_dirty_pages() is sleeping in KILLABLE state, so kill -9 of
>> the dd process should succeed.
> Yeah, dd can be killed, however it may be any application(s), :-)
>
> Fortunately it won't cause trouble during reboot/power off, given
> userspace will be killed at that time.
>
>
>
> Thanks,
> Ming
>
Don't worry about that, we always set the current thread to TASK_KILLABLE

while waiting in balance_dirty_pages().


-- 
With Best Regards,
Baokun Li
.
