Return-Path: <linux-fsdevel+bounces-36413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B779E389F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 12:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877972818C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9310C1B21A2;
	Wed,  4 Dec 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3w7A8kU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B421AC884;
	Wed,  4 Dec 2024 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311077; cv=none; b=Lw9FuWMN01uVJgr2U73OGMGbbuB7kwLcJTvDTX2EgVyhEiItdqWMdstVmSZXm7CCN9yAU6Qme3qSAlZQ9Mqm8mGuyQbIJZv6PcrLr5MOqEyKq5AmTPZ2YzDcVidX5Ymg1eS9FPG/RW37ItBsKqVUmBWK2e3TB2jRZcyWmGHbEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311077; c=relaxed/simple;
	bh=94VKvdUtu2++ArXb8K4QoeUfSLejk8TVUbRQCFL9EkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fxg5Kcocj/7s3TOKzcXnzPaS9Xw4fCDUzSTWJKNgkCK3WXNkVwjaL6L67IS7xy6/LRgIH3MaizpdRU5o/wYvAqJjXE7DZOWkK+4c3YhGJNy3QreD3g0UJWKh1JutC86tU2RWoZcSdKYeDGde2O+pc0wdnRlqSYhbxQrvWZ+2i2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3w7A8kU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BC9C4CED1;
	Wed,  4 Dec 2024 11:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733311076;
	bh=94VKvdUtu2++ArXb8K4QoeUfSLejk8TVUbRQCFL9EkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O3w7A8kUUZ8SWVhueh0uc/Hj81Luw4T7EF2SXfZgOIZFOBFX5He/diKYkdU3wN7d0
	 fAYnkywFiN+SdeRNpg/xJ3Kf31tJ7qL14Nvz44fiOvFMX7BX4Ku0R9OBl86dV04SK6
	 U19CfYfc9xcTpXFyVGoZ+ZFa1rKejpwiDYtL3ldC8ZBEKkh3jUOWGJADePU6FuRCvS
	 Di8lNdbqK3itN2MqHSX7hIcE4Np5jhuNccrSElNgSmGWsgAClwKhic+bG6BtVRkzOk
	 RWjMUtgQgXtIUTsW59UhD9Uq2/Cf0Gm4JAZvoLh+I8kqD1dr0rLOYhOLXRkhNDKpiw
	 cTwnuQ9yARt0A==
Date: Wed, 4 Dec 2024 12:17:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	axboe@kernel.dk, linux-block@vger.kernel.org, agruenba@redhat.com, 
	gfs2@lists.linux.dev, amir73il@gmail.com, mic@digikod.net, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, yebin10@huawei.com, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 10/11] fs: fix hungtask due to repeated traversal of
 inodes list
Message-ID: <20241204-worden-tontechnik-3ce77e9f3bad@brauner>
References: <20241118114508.1405494-1-yebin@huaweicloud.com>
 <20241118114508.1405494-11-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118114508.1405494-11-yebin@huaweicloud.com>

On Mon, Nov 18, 2024 at 07:45:07PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's a issue when remove scsi disk, the invalidate_inodes() function
> cannot exit for a long time, then trigger hungtask:
> INFO: task kworker/56:0:1391396 blocked for more than 122 seconds.
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Workqueue: events_freezable virtscsi_handle_event [virtio_scsi]
> Call Trace:
>  __schedule+0x33c/0x7f0
>  schedule+0x46/0xb0
>  schedule_preempt_disabled+0xa/0x10
>  __mutex_lock.constprop.0+0x22b/0x490
>  mutex_lock+0x52/0x70
>  scsi_scan_target+0x6d/0xf0
>  virtscsi_handle_event+0x152/0x1a0 [virtio_scsi]
>  process_one_work+0x1b2/0x350
>  worker_thread+0x49/0x310
>  kthread+0xfb/0x140
>  ret_from_fork+0x1f/0x30
> 
> PID: 540499  TASK: ffff9b15e504c080  CPU: 44  COMMAND: "kworker/44:0"
> Call trace:
>  invalidate_inodes at ffffffff8f3b4784
>  __invalidate_device at ffffffff8f3dfea3
>  invalidate_partition at ffffffff8f526b49
>  del_gendisk at ffffffff8f5280fb
>  sd_remove at ffffffffc0186455 [sd_mod]
>  __device_release_driver at ffffffff8f738ab2
>  device_release_driver at ffffffff8f738bc4
>  bus_remove_device at ffffffff8f737f66
>  device_del at ffffffff8f73341b
>  __scsi_remove_device at ffffffff8f780340
>  scsi_remove_device at ffffffff8f7803a2
>  virtscsi_handle_event at ffffffffc017204f [virtio_scsi]
>  process_one_work at ffffffff8f1041f2
>  worker_thread at ffffffff8f104789
>  kthread at ffffffff8f109abb
>  ret_from_fork at ffffffff8f001d6f
> 
> As commit 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> introduces the retry logic. In the problem environment, the 'i_count'
> of millions of files is not zero. As a result, the time slice for each
> traversal to the matching inode process is almost used up, and then the
> traversal is started from scratch. The worst-case scenario is that only
> one inode can be processed after each wakeup. Because this process holds
> a lock, other processes will be stuck for a long time, causing a series
> of problems.
> To solve the problem of repeated traversal from the beginning, each time
> the CPU needs to be freed, a cursor is inserted into the linked list, and
> the traversal continues from the cursor next time.
> 
> Fixes: 04646aebd30b ("fs: avoid softlockups in s_inodes iterators")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/inode.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index dc966990bda6..b78895af8779 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -857,11 +857,16 @@ static void dispose_list(struct list_head *head)
>  void evict_inodes(struct super_block *sb)
>  {
>  	struct inode *inode, *next;
> +	struct inode cursor;

It seems pretty adventurous to me to just add in a random inode whose
only fiels that is initialized is i_state. That would need a proper
analysis and argument that this is safe to do and won't cause trouble
for any filesystem.

Jan, do you have thoughts on this?

>  	LIST_HEAD(dispose);
>  
> +	cursor.i_state = I_CURSOR;
> +	INIT_LIST_HEAD(&cursor.i_sb_list);
> +	inode = list_entry(&sb->s_inodes, typeof(*inode), i_sb_list);
> +
>  again:
>  	spin_lock(&sb->s_inode_list_lock);
> -	sb_for_each_inodes_safe(inode, next, &sb->s_inodes) {
> +	sb_for_each_inodes_continue_safe(inode, next, &sb->s_inodes) {
>  		if (atomic_read(&inode->i_count))
>  			continue;
>  
> @@ -886,12 +891,16 @@ void evict_inodes(struct super_block *sb)
>  		 * bit so we don't livelock.
>  		 */
>  		if (need_resched()) {
> +			list_del(&cursor.i_sb_list);
> +			list_add(&cursor.i_sb_list, &inode->i_sb_list);
> +			inode = &cursor;
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
>  			dispose_list(&dispose);
>  			goto again;
>  		}
>  	}
> +	list_del(&cursor.i_sb_list);
>  	spin_unlock(&sb->s_inode_list_lock);
>  
>  	dispose_list(&dispose);
> @@ -907,11 +916,16 @@ EXPORT_SYMBOL_GPL(evict_inodes);
>  void invalidate_inodes(struct super_block *sb)
>  {
>  	struct inode *inode, *next;
> +	struct inode cursor;
>  	LIST_HEAD(dispose);
>  
> +	cursor.i_state = I_CURSOR;
> +	INIT_LIST_HEAD(&cursor.i_sb_list);
> +	inode = list_entry(&sb->s_inodes, typeof(*inode), i_sb_list);
> +
>  again:
>  	spin_lock(&sb->s_inode_list_lock);
> -	sb_for_each_inodes_safe(inode, next, &sb->s_inodes) {
> +	sb_for_each_inodes_continue_safe(inode, next, &sb->s_inodes) {
>  		spin_lock(&inode->i_lock);
>  		if (inode->i_state & (I_NEW | I_FREEING | I_WILL_FREE)) {
>  			spin_unlock(&inode->i_lock);
> @@ -927,12 +941,16 @@ void invalidate_inodes(struct super_block *sb)
>  		spin_unlock(&inode->i_lock);
>  		list_add(&inode->i_lru, &dispose);
>  		if (need_resched()) {
> +			list_del(&cursor.i_sb_list);
> +			list_add(&cursor.i_sb_list, &inode->i_sb_list);
> +			inode = &cursor;
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
>  			dispose_list(&dispose);
>  			goto again;
>  		}
>  	}
> +	list_del(&cursor.i_sb_list);
>  	spin_unlock(&sb->s_inode_list_lock);
>  
>  	dispose_list(&dispose);
> -- 
> 2.34.1
> 

