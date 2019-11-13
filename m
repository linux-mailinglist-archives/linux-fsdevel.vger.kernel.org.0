Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F918F9F57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKMAf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 19:35:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44292 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKMAf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:35:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id az9so248967plb.11;
        Tue, 12 Nov 2019 16:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Xp8ONPPfhBnRoyC9cBJIaJxPAWYZePiBY4u6O+ABZE=;
        b=Th6coF08TQAFNHPMM7Y5KfXyF5DbxeW6fDq8BeKbYbj+wFAB7jQcRfoQwbY3WVEBjf
         fdy8cS1SqptBbUfbXhynZA8N+WU5MpkvpWi6j/xGP5OPlPwn0jOPFl8ZvYA4kSILpelU
         WqhT9UQP7hAcsiiuRL+1PR99QO4+m1QY9cwJHifrmCIbVBpblUS7qU+tt+vp7EaIcngS
         pXG1rqH5eeLCwUO1Q8PoZaduvV+RDK0qlpBk+Ql51e827vGE0Eox6+82XHVHvL7xkMAQ
         Mn2fu+P80BGodXTbYmX72KSBwi1OApkAwqjLUF466ZHkLRcaQyyKhnFqYzk6TGGY7evV
         0Qzg==
X-Gm-Message-State: APjAAAXZ7T5VQvpwmk+97O4U0NYthpCyyq0xRuPmOkBTOVUnoktX2c2S
        /hKkrN68bf2n3OLHyiRiIvY=
X-Google-Smtp-Source: APXvYqwdtZJOjNsmE8fH3CuNJBnfIuRPEXWzZ/Px4y0tej5p9SRcmyJ85r6QJlLupGJOYXmhQX2Kfg==
X-Received: by 2002:a17:902:aa8a:: with SMTP id d10mr627477plr.273.1573605326025;
        Tue, 12 Nov 2019 16:35:26 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 186sm155203pfb.99.2019.11.12.16.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 16:35:24 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 31BAE403DC; Wed, 13 Nov 2019 00:35:24 +0000 (UTC)
Date:   Wed, 13 Nov 2019 00:35:24 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] proc: Allow restricting permissions in /proc/sys
Message-ID: <20191113003524.GQ11244@42.do-not-panic.com>
References: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 02:07:29PM +0200, Topi Miettinen wrote:
> Several items in /proc/sys need not be accessible to unprivileged
> tasks. Let the system administrator change the permissions, but only
> to more restrictive modes than what the sysctl tables allow.

Thanks for taking the time for looking into this!

We don't get many eyeballs over this code, so while you're at it, if its
not too much trouble and since it seems you care: can you list proc sys
files which are glaring red flags to have their current defaults
permissions?

> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
> v2: actually keep track of changed permissions instead of relying on inode
> cache
> ---
>  fs/proc/proc_sysctl.c  | 42 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/sysctl.h |  1 +
>  2 files changed, 39 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d80989b6c344..1f75382c49fd 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
> mask)
>         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
>                 return -EACCES;
> 
> +       error = generic_permission(inode, mask);
> +       if (error)
> +               return error;
> +

This alone checks to see if the inode's uid and gid are mapped to the
current namespace, amonst other things. A worthy change in and of
itself, worthy of it being a separate patch.

Can it regress current uses? Well depends if namespaces exists today
where root is not mapped to other namespaces, and if that was *expected*
to work.

>         head = grab_header(inode);
>         if (IS_ERR(head))
>                 return PTR_ERR(head);
> @@ -835,17 +839,46 @@ static int proc_sys_permission(struct inode *inode,
> int mask)
>  static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
>  {
>         struct inode *inode = d_inode(dentry);
> +       struct ctl_table_header *head = grab_header(inode);
> +       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
>         int error;
> 
> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>                 return -EPERM;
> 
> +       if (attr->ia_valid & ATTR_MODE) {
> +               umode_t max_mode = 0777; /* Only these bits may change */
> +
> +               if (IS_ERR(head))
> +                       return PTR_ERR(head);
> +
> +               if (!table) /* global root - r-xr-xr-x */
> +                       max_mode &= ~0222;

max_mode &= root->permissions(head, table) ?

But why are we setting this? More in context below.

> +               else /*
> +                     * Don't allow permissions to become less
> +                     * restrictive than the sysctl table entry
> +                     */
> +                       max_mode &= table->mode;
> +
> +               /* Execute bits only allowed for directories */
> +               if (!S_ISDIR(inode->i_mode))
> +                       max_mode &= ~0111;
> +
> +               if (attr->ia_mode & ~S_IFMT & ~max_mode)

Shouldn't this error path call sysctl_head_finish(head) ?

> +                       return -EPERM;
> +       }
> +
>         error = setattr_prepare(dentry, attr);
>         if (error)
>                 return error;
> 
>         setattr_copy(inode, attr);
>         mark_inode_dirty(inode);
> +
> +       if (table)
> +               table->current_mode = inode->i_mode;

Here we only care about setting this current_mode if the
table is set is present, but above we did some processing
when it was not set. Why?

> +       sysctl_head_finish(head);
> +
>         return 0;
>  }
> 
> @@ -861,7 +894,7 @@ static int proc_sys_getattr(const struct path *path,
> struct kstat *stat,
> 
>         generic_fillattr(inode, stat);
>         if (table)
> -               stat->mode = (stat->mode & S_IFMT) | table->mode;
> +               stat->mode = (stat->mode & S_IFMT) | table->current_mode;
> 
>         sysctl_head_finish(head);
>         return 0;
> @@ -981,7 +1014,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set
> *set,
>         memcpy(new_name, name, namelen);
>         new_name[namelen] = '\0';
>         table[0].procname = new_name;
> -       table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
> +       table[0].current_mode = table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
>         init_header(&new->header, set->dir.header.root, set, node, table);
> 
>         return new;
> @@ -1155,6 +1188,7 @@ static int sysctl_check_table(const char *path, struct
> ctl_table *table)
>                 if ((table->mode & (S_IRUGO|S_IWUGO)) != table->mode)
>                         err |= sysctl_err(path, table, "bogus .mode 0%o",
>                                 table->mode);
> +               table->current_mode = table->mode;
>         }
>         return err;
>  }
> @@ -1192,7 +1226,7 @@ static struct ctl_table_header *new_links(struct
> ctl_dir *dir, struct ctl_table
>                 int len = strlen(entry->procname) + 1;
>                 memcpy(link_name, entry->procname, len);
>                 link->procname = link_name;
> -               link->mode = S_IFLNK|S_IRWXUGO;
> +               link->current_mode = link->mode = S_IFLNK|S_IRWXUGO;
>                 link->data = link_root;
>                 link_name += len;
>         }
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 6df477329b76..7c519c35bf9c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -126,6 +126,7 @@ struct ctl_table
>         void *data;
>         int maxlen;
>         umode_t mode;
> +       umode_t current_mode;

Please add kdoc, I know we don't have one, but we have to start, and
explain at least that mode is the original intended settings, and that
current_mode can only be stricter settings.

Also, I see your patch does a good sanity test on the input mask
and returns it back, howevever, I don't see how proc_sys_permission()
is using it?

  Luis
