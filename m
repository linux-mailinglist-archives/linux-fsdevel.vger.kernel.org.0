Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD952B857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 13:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiERLMH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 07:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiERLMG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 07:12:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247BD13B8E6;
        Wed, 18 May 2022 04:12:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF70521BAB;
        Wed, 18 May 2022 11:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652872323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJwKG57RWDGJ1oMgfPTV0ZpppuDp60feAI7THcn80qg=;
        b=r231nlMXw62fATk7CPdCROZZTQ20E8sitKi38zs3Chx6LiZr2iYGUeeiaF/YgP2Ju29VyU
        0Im/WLSyje62i+2DF7fao/ni8B3ztKxy2jkOQmxEg2iYQoMtBwN5R5FY5cig59EudImraw
        HDXozxs8xCL83DwUcf8bJVbUNjbqgs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652872323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJwKG57RWDGJ1oMgfPTV0ZpppuDp60feAI7THcn80qg=;
        b=BSmCor0MSvUg7LYlmUKzkFU94em8BdUF89+848BnkZvKU9/SChV6NYICOTcN5AK5tbTp3S
        9jMU6T/ljtXbLIDg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AEFC22C141;
        Wed, 18 May 2022 11:12:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E7C0A062F; Wed, 18 May 2022 13:12:02 +0200 (CEST)
Date:   Wed, 18 May 2022 13:12:02 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] sparse: fix incorrect fmode_t casts
Message-ID: <20220518111202.33qkxrfui7o7bb2o@quack3.lan>
References: <YoNDA0SOFjyoFlJS@infradead.org>
 <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e82d40-0952-e76f-aac5-53abe48ec770@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-05-22 13:49:07, Vasily Averin wrote:
> Fixes sparce warnings:
> fs/notify/fanotify/fanotify_user.c:267:63: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
>  warning: restricted fmode_t degrades to integer
> fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
> fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
> fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t
> fs/open.c:1024:21: sparse: warning: restricted fmode_t degrades to integer
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

for the fanotify bits.

								Honza

> ---
> v2:
>  1) use __FMODE_NONOTIFY instead of FMODE_NONOTIFY
>  2) introduced fmode_instantiate_de/encode helpers
>       thanks Christoph Hellwig for the hints
> ---
>  fs/notify/fanotify/fanotify_user.c |  4 ++--
>  fs/open.c                          |  2 +-
>  fs/proc/base.c                     | 21 ++++++++++++++++-----
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9b32b76a9c30..2bec3b612618 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>  	 * originally opened O_WRONLY.
>  	 */
>  	new_file = dentry_open(path,
> -			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
> +			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
>  			       current_cred());
>  	if (IS_ERR(new_file)) {
>  		/*
> @@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
>  		return -EINVAL;
>  
> -	f_flags = O_RDWR | FMODE_NONOTIFY;
> +	f_flags = O_RDWR | __FMODE_NONOTIFY;
>  	if (flags & FAN_CLOEXEC)
>  		f_flags |= O_CLOEXEC;
>  	if (flags & FAN_NONBLOCK)
> diff --git a/fs/open.c b/fs/open.c
> index 1315253e0247..386c52e4c3b1 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1021,7 +1021,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
>  inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  {
>  	u64 flags = how->flags;
> -	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
> +	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
>  	int lookup_flags = 0;
>  	int acc_mode = ACC_MODE(flags);
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c1031843cc6a..b8ed41eb5784 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2233,11 +2233,21 @@ static const struct inode_operations proc_map_files_link_inode_operations = {
>  	.setattr	= proc_setattr,
>  };
>  
> +static fmode_t fmode_instantiate_decode(const void *ptr)
> +{
> +	return (__force fmode_t)(unsigned long)ptr;
> +}
> +
> +static void *fmode_instantiate_encode(fmode_t fmode)
> +{
> +	return (void *)(__force unsigned long)fmode;
> +}
> +
>  static struct dentry *
>  proc_map_files_instantiate(struct dentry *dentry,
>  			   struct task_struct *task, const void *ptr)
>  {
> -	fmode_t mode = (fmode_t)(unsigned long)ptr;
> +	fmode_t mode = fmode_instantiate_decode(ptr);
>  	struct proc_inode *ei;
>  	struct inode *inode;
>  
> @@ -2292,10 +2302,11 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>  	if (!vma)
>  		goto out_no_vma;
>  
> -	if (vma->vm_file)
> -		result = proc_map_files_instantiate(dentry, task,
> -				(void *)(unsigned long)vma->vm_file->f_mode);
> +	if (vma->vm_file) {
> +		void *ptr = fmode_instantiate_encode(vma->vm_file->f_mode);
>  
> +		result = proc_map_files_instantiate(dentry, task, ptr);
> +	}
>  out_no_vma:
>  	mmap_read_unlock(mm);
>  out_put_mm:
> @@ -2391,7 +2402,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  				      buf, len,
>  				      proc_map_files_instantiate,
>  				      task,
> -				      (void *)(unsigned long)p->mode))
> +				      (void *)(__force unsigned long)p->mode))
>  			break;
>  		ctx->pos++;
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
