Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94D572F26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 09:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGMHZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiGMHZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:25:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2035AB3D4A;
        Wed, 13 Jul 2022 00:25:03 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LjTdJ4JRSzFq2Z;
        Wed, 13 Jul 2022 15:24:04 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 15:24:51 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 15:24:50 +0800
Subject: Re: [PATCH v4] proc: Fix a dentry lock race between release_task and
 lookup
To:     Brian Foster <bfoster@redhat.com>
CC:     <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
References: <20220601062332.232439-1-chengzhihao1@huawei.com>
 <Ys2CPO4FodMlAqRR@bfoster>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f64637ac-9c9e-06c4-bbea-4af5c24878bf@huawei.com>
Date:   Wed, 13 Jul 2022 15:24:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <Ys2CPO4FodMlAqRR@bfoster>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

在 2022/7/12 22:16, Brian Foster 写道:
> On Wed, Jun 01, 2022 at 02:23:32PM +0800, Zhihao Cheng wrote:
>> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
>> moved proc_flush_task() behind __exit_signal(). Then, process systemd
>> can take long period high cpu usage during releasing task in following
>> concurrent processes:
>>
>>    systemd                                 ps
>> kernel_waitid                 stat(/proc/tgid)
>>    do_wait                       filename_lookup
>>      wait_consider_task            lookup_fast
>>        release_task
>>          __exit_signal
>>            __unhash_process
>>              detach_pid
>>                __change_pid // remove task->pid_links
>>                                       d_revalidate -> pid_revalidate  // 0
>>                                       d_invalidate(/proc/tgid)
>>                                         shrink_dcache_parent(/proc/tgid)
>>                                           d_walk(/proc/tgid)
>>                                             spin_lock_nested(/proc/tgid/fd)
>>                                             // iterating opened fd
>>          proc_flush_pid                                    |
>>             d_invalidate (/proc/tgid/fd)                   |
>>                shrink_dcache_parent(/proc/tgid/fd)         |
>>                  shrink_dentry_list(subdirs)               ↓
>>                    shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock
>>
> 
> Curious... can this same sort of thing happen with /proc/<tgid>/task if
> that dir similarly has a lot of dentries?
> 

Yes. It could happend too. There will be many dentries under 
/proc/<tgid>/task when there are many tasks under same thread group.

We must put /proc/<tgid>/task into pid->inodes, because we have to 
handle single thread exiting situation: Any one of threads should 
invalidate its /proc/<tgid>/task/<pid> dentry before begin released. You 
may refer to the function proc_flush_task_mnt() before commit 
7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc").

> ...
>> Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   v1->v2: Add new helper proc_pid_make_base_inode that performs the extra
>> 	 work of adding to the pid->list.
>>   v2->v3: Add performance regression in commit message.
>>   v3->v4: Make proc_pid_make_base_inode() static
>>   fs/proc/base.c | 34 ++++++++++++++++++++++++++--------
>>   1 file changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>> index c1031843cc6a..d884933950fd 100644
>> --- a/fs/proc/base.c
>> +++ b/fs/proc/base.c
> ...
>> @@ -1931,6 +1926,27 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>>   	return NULL;
>>   }
>>   
>> +static struct inode *proc_pid_make_base_inode(struct super_block *sb,
>> +				struct task_struct *task, umode_t mode)
>> +{
>> +	struct inode *inode;
>> +	struct proc_inode *ei;
>> +	struct pid *pid;
>> +
>> +	inode = proc_pid_make_inode(sb, task, mode);
>> +	if (!inode)
>> +		return NULL;
>> +
>> +	/* Let proc_flush_pid find this directory inode */
>> +	ei = PROC_I(inode);
>> +	pid = ei->pid;
>> +	spin_lock(&pid->lock);
>> +	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
>> +	spin_unlock(&pid->lock);
>> +
>> +	return inode;
>> +}
>> +
> 
> Somewhat related to the question above.. it would be nice if this
> wrapper had a line or two comment above it that explained when it should
> or shouldn't be used over the underlying function (for example, why or
> why not include /proc/<tgid>/task?). Otherwise the patch overall seems
> reasonable to me..
> 

Thanks for advice, I will add some notes in v5.
> Brian
> 
>>   int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
>>   		struct kstat *stat, u32 request_mask, unsigned int query_flags)
>>   {
>> @@ -3350,7 +3366,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
>>   {
>>   	struct inode *inode;
>>   
>> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
>> +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
>> +					 S_IFDIR | S_IRUGO | S_IXUGO);
>>   	if (!inode)
>>   		return ERR_PTR(-ENOENT);
>>   
>> @@ -3649,7 +3666,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
>>   	struct task_struct *task, const void *ptr)
>>   {
>>   	struct inode *inode;
>> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
>> +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
>> +					 S_IFDIR | S_IRUGO | S_IXUGO);
>>   	if (!inode)
>>   		return ERR_PTR(-ENOENT);
>>   
>> -- 
>> 2.31.1
>>
> 
> .
> 

