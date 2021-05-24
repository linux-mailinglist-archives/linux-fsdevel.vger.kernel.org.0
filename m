Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC61A38E270
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 10:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhEXInT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 04:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXInS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 04:43:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCC8C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 01:41:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u7so5713198plq.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 01:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGHOKl3pqqMLz+8ICMZGvdk1tuSYnM0ieL2nE+2z6ww=;
        b=PrxijNHtZaEXtInghxiB1h6/OBrs3A6iqiLqobR+u7CRlZTVvLVAAapWCTcaXlmPy1
         XA/VN6UqSXwxjzL5Olil3NHIQh52qXzdklsbh5KTsR4ao7Rt2vKKqS+5w1bvq+YuiVVU
         Z11nWhXq2Hi4rhqN6HxhR6WMfSYgtXjF7GxjTZQroxDgk8ntX7th6uiXEaLsJ50YPNtN
         Gd7jkQyn2F3f8JwytTO4wmqC8/EYBHJpAnFkp8s5SCNAK7CQHxMoAz8HVyF4maPsRwkO
         E6arfY5BdoPQRnGQcVh1NS9qIKEs6opnytLHCZ+9hoAuhwQLj7eWWPS+5S0wv1emUrxh
         hofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGHOKl3pqqMLz+8ICMZGvdk1tuSYnM0ieL2nE+2z6ww=;
        b=demFYfXZgM3D5ah1WZugHd0feW1hxU3eak5BSUwj0jyKIJbH0BfKtU+eY1oAZFsguE
         sWpR9XweBDPmphdPj0BkrG0rY6CTNJluTTTstKcRK/wr1/ziWvOKvp8JwCbCl3hb1XPN
         XjSjs/919DX8VPxv/yfjWoSXnsdb7f9PZtzIos7kvwrnqz9jKjpFU05CPJLUOplsSX7m
         joIygZFm1R2lM06ccwEnCy77R+CRsttj6VZw6NpfDU7rGmujd7VOl6Y6zauToIpYH5U7
         j/MFzDjiKJ8dOXjyRt+kOKqOzJZnhuLH0tA64dKJbzwTkODKs7MoqgCqXeVd310f5iDS
         k6JQ==
X-Gm-Message-State: AOAM530G6KIrEXRb869fWKdrqroWMDMI+STtKd1WjWF88X5ZAHc/+p98
        OgStcZHiOKOlJ1ItH5MmwLMkyA==
X-Google-Smtp-Source: ABdhPJwzupOMEEyuxCdN6pTnW8SOS4mWlmZH142kBu1KA9MvqNTRp9ZL+OQl41e0P0XV/0b3jaQFgg==
X-Received: by 2002:a17:902:6904:b029:fb:42b6:e952 with SMTP id j4-20020a1709026904b02900fb42b6e952mr696465plk.16.1621845709563;
        Mon, 24 May 2021 01:41:49 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:fd86:de3d:256d:6afc])
        by smtp.gmail.com with ESMTPSA id d131sm10600658pfd.176.2021.05.24.01.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 01:41:48 -0700 (PDT)
Date:   Mon, 24 May 2021 18:41:36 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fanotify: fix permission model of unprivileged group
Message-ID: <YKtmwOM9WqUTK/u4@google.com>
References: <20210522091916.196741-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522091916.196741-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 22, 2021 at 12:19:16PM +0300, Amir Goldstein wrote:
> Reporting event->pid should depend on the privileges of the user that
> initialized the group, not the privileges of the user reading the
> events.
> 
> Use an internal group flag FANOTIFY_UNPRIV to record the fact the the
> group was initialized by an unprivileged user.
> 
> To be on the safe side, the premissions to setup filesystem and mount
> marks now require that both the user that initialized the group and
> the user setting up the mark have CAP_SYS_ADMIN.
> 
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thanks for sending through this patch Amir!

In general, the patch looks good to me, however there's just a few
nits below.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 71fefb30e015..7df6cba4a06d 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -424,11 +424,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	 * events generated by the listener process itself, without disclosing
>  	 * the pids of other processes.
>  	 */
> -	if (!capable(CAP_SYS_ADMIN) &&
> +	if (FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
>  	    task_tgid(current) != event->pid)
>  		metadata.pid = 0;
>  
> -	if (path && path->mnt && path->dentry) {
> +	/*
> +	 * For now, we require fid mode for unprivileged listener, which does
> +	 * record path events, but keep this check for safety in case we want
> +	 * to allow unprivileged listener to get events with no fd and no fid
> +	 * in the future.
> +	 */

I think it's best if we keep clear of using first person in our
comments throughout our code base. Maybe we could change this to:

* For now, fid mode is required for an unprivileged listener, which
  does record path events. However, this check must be kept...

> +	if (!FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) &&
> +	    path && path->mnt && path->dentry) {
>  		fd = create_fd(group, path, &f);
>  		if (fd < 0)
>  			return fd;
> @@ -1040,6 +1047,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	int f_flags, fd;
>  	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
>  	unsigned int class = flags & FANOTIFY_CLASS_BITS;
> +	unsigned int internal_flags = 0;
>  
>  	pr_debug("%s: flags=%x event_f_flags=%x\n",
>  		 __func__, flags, event_f_flags);
> @@ -1053,6 +1061,13 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  		 */
>  		if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) || !fid_mode)
>  			return -EPERM;
> +
> +		/*
> +		 * We set the internal flag FANOTIFY_UNPRIV on the group, so we
> +		 * know that we need to limit setting mount/filesystem marks on
> +		 * this group and avoid providing pid and open fd in the event.
> +		 */

Same comment as above applies here. This could be changed to:

* Set the internal FANOTIFY_UNPRIV flag for this notification group so
  that certain restrictions can be enforced upon it. This includes
  things like not permitting an unprivileged user from setting up
  mount/filesystem scoped marks and not returning an open file
  descriptor or pid meta-information within an event.

You can make it shorter if you like, but you get the drift.

> +		internal_flags |= FANOTIFY_UNPRIV;
>  	}
>  
>  #ifdef CONFIG_AUDITSYSCALL
> @@ -1105,7 +1120,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  		goto out_destroy_group;
>  	}
>  
> -	group->fanotify_data.flags = flags;
> +	group->fanotify_data.flags = flags | internal_flags;
>  	group->memcg = get_mem_cgroup_from_mm(current->mm);
>  
>  	group->fanotify_data.merge_hash = fanotify_alloc_merge_hash();
> @@ -1305,11 +1320,13 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	group = f.file->private_data;
>  
>  	/*
> -	 * An unprivileged user is not allowed to watch a mount point nor
> -	 * a filesystem.
> +	 * An unprivileged user is not allowed to setup mount point nor
  	      		   	       	       	  	      	   ^
								   s
> +	 * filesystem marks. It is not allowed to setup those marks for
> +	 * a group that was initialized by an unprivileged user.

I think the second sentence would better read as:

       * This also includes setting up such marks by a group that was
         intialized by an unprivileged user.

>  	ret = -EPERM;
> -	if (!capable(CAP_SYS_ADMIN) &&
> +	if ((!capable(CAP_SYS_ADMIN) ||
> +	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&

...

> diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
> index a712b2aaa9ac..57f0d5d9f934 100644
> --- a/fs/notify/fdinfo.c
> +++ b/fs/notify/fdinfo.c
> @@ -144,7 +144,7 @@ void fanotify_show_fdinfo(struct seq_file *m, struct file *f)
>  	struct fsnotify_group *group = f->private_data;
>  
>  	seq_printf(m, "fanotify flags:%x event-flags:%x\n",
> -		   group->fanotify_data.flags,
> +		   group->fanotify_data.flags & FANOTIFY_INIT_FLAGS,
>  		   group->fanotify_data.f_flags);

I feel like the internal initialization flags have been dropped off
here as FANOTIFY_INIT_FLAGS technically wouldn't cover all flags
present in group->fanotify_data.flags with FANOTIFY_UNPRIV, right?

>  	show_fdinfo(m, f, fanotify_fdinfo);
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index bad41bcb25df..f277d1c4e6b8 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -51,6 +51,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
>  				 FANOTIFY_USER_INIT_FLAGS)
>  
> +/* Internal flags */
> +#define FANOTIFY_UNPRIV		0x80000000
> +#define FANOTIFY_INTERNAL_FLAGS	(FANOTIFY_UNPRIV)

Should we be more distinct here i.e. FANOTIFY_INTERNAL_INIT_FLAGS?
Just thinking about a possible case where there's some other internal
fanotify flags that are used for something else?

>  #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
>  				 FAN_MARK_FILESYSTEM)

/M
