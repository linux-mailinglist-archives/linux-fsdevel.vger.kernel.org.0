Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB00D574CAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 14:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiGNMBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 08:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiGNMBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:01:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2B595B7A8
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 05:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657800079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eo54O2xCYx2NW0FGu98tWkr1EbZZUok8MtcsOnw642U=;
        b=YjwnzuDGZMo3gzzDhwVlIS8vE1rjGqbk6MD5PwuaNLvRf+jHu5mbU6cvM7xvq9oSE6TmmQ
        6HFRrc0YsBcQLvq1FtzSfbeam4NAM22XGi5/+096zL15g9HF/2LJh7/k9+jQGhQcg3D5Z9
        YWjBmpbrzqh8ES2nRzzAKe6DqsanV7g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-gFAW5dYcMMiw8TLUceTUPQ-1; Thu, 14 Jul 2022 08:01:18 -0400
X-MC-Unique: gFAW5dYcMMiw8TLUceTUPQ-1
Received: by mail-qv1-f70.google.com with SMTP id r12-20020ad4404c000000b00472ffb530e2so1081668qvp.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Jul 2022 05:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Eo54O2xCYx2NW0FGu98tWkr1EbZZUok8MtcsOnw642U=;
        b=SluDellE32h3k22qUU/pP3f8GrPDW5GO6WKFjg6jWWV1eNmEN6BMZbdRm2kQzRJoH3
         iVQXc7SGEubKN1TNL1Bgpgpg8D0ogDoVU4KBginhkrvPpIoubW6fWQ0G/MLSIWc1Jvm/
         5h3PNFV1+lwC3iFk5Wj4Cyl1mjpQflX5duqp1COZCmXWB9ISDj9bJ+8Ek7vfvXikI1v+
         LH5pWGikKLMhuYcm9sKLbfg7BDcltXAtSvvMX0omf0EhNFB8ePHfatCDasKJkBWnKetV
         PjpsC7XFDGmksMyGAbThhaIRmdF8WjsPrMRCi3aiX1ROcnfgMo62suaSwV7cmgmLeavH
         30Bg==
X-Gm-Message-State: AJIora/yyIKytioLwJCANZSLLbdyYyqsfxKMu2OikvyOrwTtzp9XFwi8
        c71LPrBsTyt0iUXFUP3vFntzuTbQ5Cfta7nqmSqVXmWUU98cM8XkuAnrNYVsH3e+BBakC8fGuc9
        sMCbrNE4G4Tq41dLhewHVDEFukQ==
X-Received: by 2002:ad4:5d6e:0:b0:473:72a7:5baf with SMTP id fn14-20020ad45d6e000000b0047372a75bafmr7668241qvb.80.1657800078128;
        Thu, 14 Jul 2022 05:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uP+NFtZ8QWNwBgFu4Gi9Iby4shTSx/07AjGZuma3HWWYm9JbzBEUM1ziGqMjStyWMhTLUkmw==
X-Received: by 2002:ad4:5d6e:0:b0:473:72a7:5baf with SMTP id fn14-20020ad45d6e000000b0047372a75bafmr7668200qvb.80.1657800077813;
        Thu, 14 Jul 2022 05:01:17 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id n20-20020ac81e14000000b003177969a48fsm1334267qtl.21.2022.07.14.05.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:01:17 -0700 (PDT)
Date:   Thu, 14 Jul 2022 08:01:15 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     ebiederm@xmission.com, willy@infradead.org, bhe@redhat.com,
        akpm@linux-foundation.org, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH v5] proc: Fix a dentry lock race between release_task and
 lookup
Message-ID: <YtAFix81eUBjzgGN@bfoster>
References: <20220713130029.4133533-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220713130029.4133533-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:00:29PM +0800, Zhihao Cheng wrote:
> Commit 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> moved proc_flush_task() behind __exit_signal(). Then, process systemd
> can take long period high cpu usage during releasing task in following
> concurrent processes:
> 
>   systemd                                 ps
> kernel_waitid                 stat(/proc/tgid)
>   do_wait                       filename_lookup
>     wait_consider_task            lookup_fast
>       release_task
>         __exit_signal
>           __unhash_process
>             detach_pid
>               __change_pid // remove task->pid_links
>                                      d_revalidate -> pid_revalidate  // 0
>                                      d_invalidate(/proc/tgid)
>                                        shrink_dcache_parent(/proc/tgid)
>                                          d_walk(/proc/tgid)
>                                            spin_lock_nested(/proc/tgid/fd)
>                                            // iterating opened fd
>         proc_flush_pid                                    |
>            d_invalidate (/proc/tgid/fd)                   |
>               shrink_dcache_parent(/proc/tgid/fd)         |
>                 shrink_dentry_list(subdirs)               ↓
>                   shrink_lock_dentry(/proc/tgid/fd) --> race on dentry lock
> 
> Function d_invalidate() will remove dentry from hash firstly, but why does
> proc_flush_pid() process dentry '/proc/tgid/fd' before dentry '/proc/tgid'?
> That's because proc_pid_make_inode() adds proc inode in reverse order by
> invoking hlist_add_head_rcu(). But proc should not add any inodes under
> '/proc/tgid' except '/proc/tgid/task/pid', fix it by adding inode into
> 'pid->inodes' only if the inode is /proc/tgid or /proc/tgid/task/pid.
> 
> Performance regression:
> Create 200 tasks, each task open one file for 50,000 times. Kill all
> tasks when opened files exceed 10,000,000 (cat /proc/sys/fs/file-nr).
> 
> Before fix:
> $ time killall -wq aa
>   real    4m40.946s   # During this period, we can see 'ps' and 'systemd'
> 			taking high cpu usage.
> 
> After fix:
> $ time killall -wq aa
>   real    1m20.732s   # During this period, we can see 'systemd' taking
> 			high cpu usage.
> 
> Fixes: 7bc3e6e55acf06 ("proc: Use a list of inodes to flush from proc")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216054
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Brian Foster <bfoster@redhat.com>
> ---

LGTM, and thanks for the tweaks:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  v1->v2: Add new helper proc_pid_make_base_inode that performs the extra
> 	 work of adding to the pid->list.
>  v2->v3: Add performance regression in commit message.
>  v3->v4: Make proc_pid_make_base_inode() static
>  v4->v5: Add notes to explain what proc_pid_make_base_inode() does
>  fs/proc/base.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 8dfa36a99c74..93f7e3d971e4 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1885,7 +1885,7 @@ void proc_pid_evict_inode(struct proc_inode *ei)
>  	put_pid(pid);
>  }
>  
> -struct inode *proc_pid_make_inode(struct super_block * sb,
> +struct inode *proc_pid_make_inode(struct super_block *sb,
>  				  struct task_struct *task, umode_t mode)
>  {
>  	struct inode * inode;
> @@ -1914,11 +1914,6 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>  
>  	/* Let the pid remember us for quick removal */
>  	ei->pid = pid;
> -	if (S_ISDIR(mode)) {
> -		spin_lock(&pid->lock);
> -		hlist_add_head_rcu(&ei->sibling_inodes, &pid->inodes);
> -		spin_unlock(&pid->lock);
> -	}
>  
>  	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
>  	security_task_to_inode(task, inode);
> @@ -1931,6 +1926,39 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
>  	return NULL;
>  }
>  
> +/*
> + * Generating an inode and adding it into @pid->inodes, so that task will
> + * invalidate inode's dentry before being released.
> + *
> + * This helper is used for creating dir-type entries under '/proc' and
> + * '/proc/<tgid>/task'. Other entries(eg. fd, stat) under '/proc/<tgid>'
> + * can be released by invalidating '/proc/<tgid>' dentry.
> + * In theory, dentries under '/proc/<tgid>/task' can also be released by
> + * invalidating '/proc/<tgid>' dentry, we reserve it to handle single
> + * thread exiting situation: Any one of threads should invalidate its
> + * '/proc/<tgid>/task/<pid>' dentry before released.
> + */
> +static struct inode *proc_pid_make_base_inode(struct super_block *sb,
> +				struct task_struct *task, umode_t mode)
> +{
> +	struct inode *inode;
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
>  int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
>  		struct kstat *stat, u32 request_mask, unsigned int query_flags)
>  {
> @@ -3369,7 +3397,8 @@ static struct dentry *proc_pid_instantiate(struct dentry * dentry,
>  {
>  	struct inode *inode;
>  
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
> +					 S_IFDIR | S_IRUGO | S_IXUGO);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> @@ -3671,7 +3700,8 @@ static struct dentry *proc_task_instantiate(struct dentry *dentry,
>  	struct task_struct *task, const void *ptr)
>  {
>  	struct inode *inode;
> -	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFDIR | S_IRUGO | S_IXUGO);
> +	inode = proc_pid_make_base_inode(dentry->d_sb, task,
> +					 S_IFDIR | S_IRUGO | S_IXUGO);
>  	if (!inode)
>  		return ERR_PTR(-ENOENT);
>  
> -- 
> 2.31.1
> 

