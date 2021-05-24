Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86938F61F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 01:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhEXXPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXXPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 19:15:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2172C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:14:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso11441132pjq.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zZ5jnn9SMfBG+xdA+zIPKIEZPMgd0G+BLZtjOL4wFAw=;
        b=Vr1uoQEpaQbNott+Cowd+uZ3wxwIeIAMcMLyfmlzQlHmcWqXYkDlu+UB8cMssrDB6s
         lnWogfzp7aJMLX1bm4RijZP20Tux6f1Efe85rKI6QjE+nnL3LOVO9ZVRuUFpvf/2DMkV
         X7Na2STnvPI+gTrF6xEoCz+xtVp7rbWYRO1qbTnGF1/PLG8qB7pPr9yD6kZeXm19XfO4
         48cE4ZhX7eLRtwEZbZZbyq1qNL1GUfW00rSWEinpbZVcJGM3+iQo19UG/5BjBoH6TCcy
         WE5z6AeCwKS2Pm8UmG7OIAc6JTysmK3vd0Q2hHZeLRRJDK7+As0NSFWjtCSbJubyjw32
         fYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZ5jnn9SMfBG+xdA+zIPKIEZPMgd0G+BLZtjOL4wFAw=;
        b=RIqALEa5eUcQtE+eB5KerKCmfAH6aWIK9WdhgrHcqlsH+XOlhKVeYT1zinpG1gT5AJ
         oJHHrEEOTJvlM6h9jXmjC60Y5K+3FqvKoF1LRnS/C4iG+U5Mrh2Xn00x8Ns2pN8I839Q
         ZhvubpAxVBSrwHX6sKvO/eJIkMD/IrK+i+vf6+8nwLFrfmkWiQTe+jKeKNEo6k9LaFRj
         Q255AkOKQztyEkPdPo/dOFW/XRIRNSe9B4+bpOql68zmgzBN9KweZaU9RFHD1EpEyoSo
         fNONVdBqOyb7cfXRwxWAE7vg5fAwYwKFcf66C5lCawgSPo1ttAD54OxPhn0Evpw1z1lg
         bSAg==
X-Gm-Message-State: AOAM531ud7VuE/0918Edck0HAoNc43Te1iwmlAxAnHGhwnKkPS5IdyTA
        +YD1oLJUx3ZcoCicssPK+Dl7RNGe8HvMbg==
X-Google-Smtp-Source: ABdhPJw9MaV3RJV3BJZjKW+TgegZ7kdJCimdNY5KJ+vvLb3JcvbyzXSybxCiIJC0pqOHIinRl/GdaA==
X-Received: by 2002:a17:902:ea0c:b029:f0:af3d:c5d6 with SMTP id s12-20020a170902ea0cb02900f0af3dc5d6mr27231726plg.45.1621898047051;
        Mon, 24 May 2021 16:14:07 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:fd86:de3d:256d:6afc])
        by smtp.gmail.com with ESMTPSA id 13sm12077027pfz.91.2021.05.24.16.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:14:06 -0700 (PDT)
Date:   Tue, 25 May 2021 09:13:55 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][v2] fanotify: fix permission model of unprivileged group
Message-ID: <YKwzM8vUHGQJIrl8@google.com>
References: <20210524135321.2190062-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524135321.2190062-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 04:53:21PM +0300, Amir Goldstein wrote:
> Reporting event->pid should depend on the privileges of the user that
> initialized the group, not the privileges of the user reading the
> events.
> 
> Use an internal group flag FANOTIFY_UNPRIV to record the fact that the
> group was initialized by an unprivileged user.
> 
> To be on the safe side, the premissions to setup filesystem and mount
> marks now require that both the user that initialized the group and
> the user setting up the mark have CAP_SYS_ADMIN.
> 
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com/
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivileged users")
> Cc: <Stable@vger.kernel.org> # v5.12+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Changes since v1:
> - Address Matthew's editorial review comments
> - Rename macro FANOTIFY_INTERNAL_GROUP_FLAGS

Nice, LGTM. Feel free to add:

Reviewed-by: Matthew Bobrowski <repnop@google.com>

>  fs/notify/fanotify/fanotify_user.c | 30 ++++++++++++++++++++++++------
>  fs/notify/fdinfo.c                 |  2 +-
>  include/linux/fanotify.h           |  4 ++++
>  3 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 71fefb30e015..be5b6d2c01e7 100644
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
> +	 * For now, fid mode is required for an unprivileged listener and
> +	 * fid mode does not report fd in events.  Keep this check anyway
> +	 * for safety in case fid mode requirement is relaxed in the future
> +	 * to allow unprivileged listener to get events with no fd and no fid.
> +	 */
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
> +		 * Setting the internal flag FANOTIFY_UNPRIV on the group
> +		 * prevents setting mount/filesystem marks on this group and
> +		 * prevents reporting pid and open fd in events.
> +		 */
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
> +	 * An unprivileged user is not allowed to setup mount nor filesystem
> +	 * marks.  This also includes setting up such marks by a group that
> +	 * was initialized by an unprivileged user.
>  	 */
>  	ret = -EPERM;
> -	if (!capable(CAP_SYS_ADMIN) &&
> +	if ((!capable(CAP_SYS_ADMIN) ||
> +	     FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV)) &&
>  	    mark_type != FAN_MARK_INODE)
>  		goto fput_and_out;
>  
> @@ -1460,6 +1477,7 @@ static int __init fanotify_user_setup(void)
>  	max_marks = clamp(max_marks, FANOTIFY_OLD_DEFAULT_MAX_MARKS,
>  				     FANOTIFY_DEFAULT_MAX_USER_MARKS);
>  
> +	BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS);
>  	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
>  	BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
>  
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
>  
>  	show_fdinfo(m, f, fanotify_fdinfo);
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index bad41bcb25df..a16dbeced152 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -51,6 +51,10 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INIT_FLAGS	(FANOTIFY_ADMIN_INIT_FLAGS | \
>  				 FANOTIFY_USER_INIT_FLAGS)
>  
> +/* Internal group flags */
> +#define FANOTIFY_UNPRIV		0x80000000
> +#define FANOTIFY_INTERNAL_GROUP_FLAGS	(FANOTIFY_UNPRIV)
> +
>  #define FANOTIFY_MARK_TYPE_BITS	(FAN_MARK_INODE | FAN_MARK_MOUNT | \
>  				 FAN_MARK_FILESYSTEM)
>  
> -- 
> 2.25.1
> 
/M
