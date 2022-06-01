Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28E539ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348974AbiFAB1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 21:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiFAB1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 21:27:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B4AE0B5;
        Tue, 31 May 2022 18:27:12 -0700 (PDT)
Received: from kwepemi100016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCWdJ48BRzRhWP;
        Wed,  1 Jun 2022 09:24:04 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100016.china.huawei.com (7.221.188.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 09:27:10 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 09:27:09 +0800
Subject: Re: [PATCH RFC] proc: Fix a dentry lock race between release_task and
 lookup
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>,
        Alexey Gladkov <legion@kernel.org>
References: <20220531153708.3449446-1-chengzhihao1@huawei.com>
 <877d61ej27.fsf@email.froward.int.ebiederm.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <999b101e-329a-d8d3-0dec-3714aac828fe@huawei.com>
Date:   Wed, 1 Jun 2022 09:27:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877d61ej27.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
> If I understand correctly you are saying that under some circumstances
> this code runs slow, and you are proposing an optimization.
> 

> That optimization is to change the content of the pid->inodes list
> from all directories under that pid, to just the /proc/<tgid> and
> /proc/<tgid>/task/<pid>.
> 

Yes and yes.

> The justification being that d_invalidate on the parent directory will
> invalidate all children.  So only those two directories are interesting
> from a d_invalidate point of view.
> 
Absolutely right.
> That seems like a valid optimization.
> 
> This could also count as a regression fix if you can show how the
> performance changed poorly when the pid->inodes change was introduced
> and how the performance improves with your change.   I currently only
> see that you hit a pathological case and you are correcting it.

There is a reproducer attached in commit msg:
https://bugzilla.kernel.org/show_bug.cgi?id=216054

Create 200 tasks, each task open one file for 50,000 times. Kill all 
tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).
Before fix:
$ time killall -wq aa
real	4m40.946s   # During this period, we can see 'ps' and 'systemd' 
taking high cpu usage.

After fix:
$ time killall -wq aa
real	1min~    # During this period, we can see 'systemd' taking high cpu 
usage.

> 
> As for the actual code change I think it would be better to
> remove the code from proc_pid_make_inode and make a helper
> proc_pid_make_base_inode that performs the extra work of
> adding to the pid->list.  Not adding a flag makes the code
> easier to follow.
> 
Agree, will send a v2.
> Something like the code below.
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d654ce7150fd..9d025e70ddc3 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1915,11 +1915,6 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>   
>   	/* Let the pid remember us for quick removal */
>   	ei->pid = pid;
> -	if (S_ISDIR(mode)) {
> -		spin_lock(&pid->lock);
> -		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> -		spin_unlock(&pid->lock);
> -	}
>   
>   	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
>   	security_task_to_inode(task, inode);
> @@ -1932,6 +1927,27 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>   	return NULL;
>   }
>   
> +struct inode *proc_pid_make_base_inode(struct super_block * sb,
> +				       struct task_struct *task, umode_t mode)
> +{
> +	struct inode * inode;
> +	struct proc_inode *ei;
> +	struct pid *pid;
> +
> +	inode = proc_pid_make_inode(sb, task, mode);
> +	if (!inode)
> +		return NULL;
> +
> +	/* Let proc_flush_pid find this directory inode */
> +	ei = PROC_I(inode);
> +	pid = ei->pid;
> +	spin_lock(&pid->lock);
> +	hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> +	spin_unlock(&pid->lock);
> +
> +	return inode;
> +}
> +
>   int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
>   		struct kstat *stat, u32 request_mask, unsigned int query_flags)
>   {
> @@ -3351,7 +3367,7 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
>   {
>   	struct inode *inode;
>   
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_base_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
>   	if (!inode)
>   		return ERR_PTR(-ENOENT);
>   
> @@ -3650,7 +3666,7 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
>   	struct task_struct *task, const void *ptr)
>   {
>   	struct inode *inode;
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_base_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
>   	if (!inode)
>   		return ERR_PTR(-ENOENT);
>   
> 
> Eric
> .
> 

