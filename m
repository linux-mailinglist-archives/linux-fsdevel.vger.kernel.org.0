Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7122336A19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 03:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCKCQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 21:16:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13591 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCKCQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 21:16:28 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dwsvy6Fcbz17JSD;
        Thu, 11 Mar 2021 10:14:38 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 11 Mar
 2021 10:16:21 +0800
Subject: Re: [PATCH] configfs: Fix use-after-free issue in
 __configfs_open_file
From:   Chao Yu <yuchao0@huawei.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Daiyue Zhang <zhangdaiyue1@huawei.com>,
        Yi Chen <chenyi77@huawei.com>, Ge Qiu <qiuge@huawei.com>,
        <linux-fsdevel@vger.kernel.org>
References: <20210301061053.105377-1-yuchao0@huawei.com>
 <040d3680-0e12-7957-da05-39017d33edb4@huawei.com>
Message-ID: <c9aa911a-aebc-37b8-67b3-b7670424226b@huawei.com>
Date:   Thu, 11 Mar 2021 10:16:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <040d3680-0e12-7957-da05-39017d33edb4@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Joel, Christoph, Al

Does any one have time to review this patch, ten days past...

Thanks,

On 2021/3/5 11:29, Chao Yu wrote:
> +Cc fsdevel
> 
> Ping,
> 
> Any comments one this patch?
> 
> On 2021/3/1 14:10, Chao Yu wrote:
>> From: Daiyue Zhang <zhangdaiyue1@huawei.com>
>>
>> Commit b0841eefd969 ("configfs: provide exclusion between IO and removals")
>> uses ->frag_dead to mark the fragment state, thus no bothering with extra
>> refcount on config_item when opening a file. The configfs_get_config_item
>> was removed in __configfs_open_file, but not with config_item_put. So the
>> refcount on config_item will lost its balance, causing use-after-free
>> issues in some occasions like this:
>>
>> Test:
>> 1. Mount configfs on /config with read-only items:
>> drwxrwx--- 289 root   root            0 2021-04-01 11:55 /config
>> drwxr-xr-x   2 root   root            0 2021-04-01 11:54 /config/a
>> --w--w--w-   1 root   root         4096 2021-04-01 11:53 /config/a/1.txt
>> ......
>>
>> 2. Then run:
>> for file in /config
>> do
>> echo $file
>> grep -R 'key' $file
>> done
>>
>> 3. __configfs_open_file will be called in parallel, the first one
>> got called will do:
>> if (file->f_mode & FMODE_READ) {
>> 	if (!(inode->i_mode & S_IRUGO))
>> 		goto out_put_module;
>> 			config_item_put(buffer->item);
>> 				kref_put()
>> 					package_details_release()
>> 						kfree()
>>
>> the other one will run into use-after-free issues like this:
>> BUG: KASAN: use-after-free in __configfs_open_file+0x1bc/0x3b0
>> Read of size 8 at addr fffffff155f02480 by task grep/13096
>> CPU: 0 PID: 13096 Comm: grep VIP: 00 Tainted: G        W       4.14.116-kasan #1
>> TGID: 13096 Comm: grep
>> Call trace:
>> dump_stack+0x118/0x160
>> kasan_report+0x22c/0x294
>> __asan_load8+0x80/0x88
>> __configfs_open_file+0x1bc/0x3b0
>> configfs_open_file+0x28/0x34
>> do_dentry_open+0x2cc/0x5c0
>> vfs_open+0x80/0xe0
>> path_openat+0xd8c/0x2988
>> do_filp_open+0x1c4/0x2fc
>> do_sys_open+0x23c/0x404
>> SyS_openat+0x38/0x48
>>
>> Allocated by task 2138:
>> kasan_kmalloc+0xe0/0x1ac
>> kmem_cache_alloc_trace+0x334/0x394
>> packages_make_item+0x4c/0x180
>> configfs_mkdir+0x358/0x740
>> vfs_mkdir2+0x1bc/0x2e8
>> SyS_mkdirat+0x154/0x23c
>> el0_svc_naked+0x34/0x38
>>
>> Freed by task 13096:
>> kasan_slab_free+0xb8/0x194
>> kfree+0x13c/0x910
>> package_details_release+0x524/0x56c
>> kref_put+0xc4/0x104
>> config_item_put+0x24/0x34
>> __configfs_open_file+0x35c/0x3b0
>> configfs_open_file+0x28/0x34
>> do_dentry_open+0x2cc/0x5c0
>> vfs_open+0x80/0xe0
>> path_openat+0xd8c/0x2988
>> do_filp_open+0x1c4/0x2fc
>> do_sys_open+0x23c/0x404
>> SyS_openat+0x38/0x48
>> el0_svc_naked+0x34/0x38
>>
>> To fix this issue, remove the config_item_put in
>> __configfs_open_file to balance the refcount of config_item.
>>
>> Fixes: b0841eefd969 ("configfs: provide exclusion between IO and removals")
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Daiyue Zhang <zhangdaiyue1@huawei.com>
>> Signed-off-by: Yi Chen <chenyi77@huawei.com>
>> Signed-off-by: Ge Qiu <qiuge@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>    fs/configfs/file.c | 6 ++----
>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/configfs/file.c b/fs/configfs/file.c
>> index 1f0270229d7b..da8351d1e455 100644
>> --- a/fs/configfs/file.c
>> +++ b/fs/configfs/file.c
>> @@ -378,7 +378,7 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
>>    
>>    	attr = to_attr(dentry);
>>    	if (!attr)
>> -		goto out_put_item;
>> +		goto out_free_buffer;
>>    
>>    	if (type & CONFIGFS_ITEM_BIN_ATTR) {
>>    		buffer->bin_attr = to_bin_attr(dentry);
>> @@ -391,7 +391,7 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
>>    	/* Grab the module reference for this attribute if we have one */
>>    	error = -ENODEV;
>>    	if (!try_module_get(buffer->owner))
>> -		goto out_put_item;
>> +		goto out_free_buffer;
>>    
>>    	error = -EACCES;
>>    	if (!buffer->item->ci_type)
>> @@ -435,8 +435,6 @@ static int __configfs_open_file(struct inode *inode, struct file *file, int type
>>    
>>    out_put_module:
>>    	module_put(buffer->owner);
>> -out_put_item:
>> -	config_item_put(buffer->item);
>>    out_free_buffer:
>>    	up_read(&frag->frag_sem);
>>    	kfree(buffer);
>>
> .
> 
