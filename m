Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D975282FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 13:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiEPLSb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbiEPLSQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 07:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26AB33E1B;
        Mon, 16 May 2022 04:18:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF5D121FB5;
        Mon, 16 May 2022 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652699892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4y5Eu1odimLQ873P0ypZTi2ejaIGyFmk+lYhYTeKC0=;
        b=fpRLbmMyuQIekcel3eoDF2Tl6XjfLbbwJWrNUsWSyAcFnDSj+meP5cjZSybflEpYaMHNlU
        kcX1MuzOJgjHwQJWfbb8q3HDn6jNXI97i1Wk02j4LWR1Et3d+nlVu5KlksbfqhGFROzWJ4
        gROnU+gwyVJH9kY4PAg/wAKQhZZic28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652699892;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4y5Eu1odimLQ873P0ypZTi2ejaIGyFmk+lYhYTeKC0=;
        b=eqjD3VWC/WRI2mf9l3nOmqUwy4Vk0NmTacvN7804QYmAKr12AyHm3Zd9qxUneu1vBN5dea
        Piy3wZuyZPCYs3Aw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 80DC72C141;
        Mon, 16 May 2022 11:18:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 29DB3A062F; Mon, 16 May 2022 13:18:12 +0200 (CEST)
Date:   Mon, 16 May 2022 13:18:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sparse: use force attribute for fmode_t casts
Message-ID: <20220516111812.wr37km2553grqr7y@quack3.lan>
References: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 14-05-22 13:22:28, Vasily Averin wrote:
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

Looks good. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

for the fsnotify related bits.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 4 ++--
>  fs/open.c                          | 2 +-
>  fs/proc/base.c                     | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9b32b76a9c30..6b058828e412 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>  	 * originally opened O_WRONLY.
>  	 */
>  	new_file = dentry_open(path,
> -			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
> +			       group->fanotify_data.f_flags | (__force int)FMODE_NONOTIFY,
>  			       current_cred());
>  	if (IS_ERR(new_file)) {
>  		/*
> @@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
>  		return -EINVAL;
>  
> -	f_flags = O_RDWR | FMODE_NONOTIFY;
> +	f_flags = O_RDWR | (__force int)FMODE_NONOTIFY;
>  	if (flags & FAN_CLOEXEC)
>  		f_flags |= O_CLOEXEC;
>  	if (flags & FAN_NONBLOCK)
> diff --git a/fs/open.c b/fs/open.c
> index 1315253e0247..b5ff39ccebfd 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1021,7 +1021,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
>  inline int build_open_flags(const struct open_how *how, struct open_flags *op)
>  {
>  	u64 flags = how->flags;
> -	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
> +	u64 strip = (__force u64)FMODE_NONOTIFY | O_CLOEXEC;
>  	int lookup_flags = 0;
>  	int acc_mode = ACC_MODE(flags);
>  
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c1031843cc6a..194b5ac069e7 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2237,7 +2237,7 @@ static struct dentry *
>  proc_map_files_instantiate(struct dentry *dentry,
>  			   struct task_struct *task, const void *ptr)
>  {
> -	fmode_t mode = (fmode_t)(unsigned long)ptr;
> +	fmode_t mode = (__force fmode_t)(unsigned long)ptr;
>  	struct proc_inode *ei;
>  	struct inode *inode;
>  
> @@ -2294,7 +2294,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
>  
>  	if (vma->vm_file)
>  		result = proc_map_files_instantiate(dentry, task,
> -				(void *)(unsigned long)vma->vm_file->f_mode);
> +				(void *)(__force unsigned long)vma->vm_file->f_mode);
>  
>  out_no_vma:
>  	mmap_read_unlock(mm);
> @@ -2391,7 +2391,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
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
