Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA369F9E20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 00:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLXWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 18:22:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40934 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLXWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:22:46 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iUfUe-0005iB-VZ; Tue, 12 Nov 2019 23:22:41 +0000
Date:   Wed, 13 Nov 2019 00:22:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
Message-ID: <20191112232239.yevpeemgxz4wy32b@wittgenstein>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc+ linux-api@vger.kernel.org]

since that's potentially relevant to quite a few people.

On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> Several items in /proc/sys need not be accessible to unprivileged
> tasks. Let the system administrator change the permissions, but only
> to more restrictive modes than what the sysctl tables allow.
> 
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index d80989b6c344..88c4ca7d2782 100644
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
>         head = grab_header(inode);
>         if (IS_ERR(head))
>                 return PTR_ERR(head);
> @@ -837,9 +841,35 @@ static int proc_sys_setattr(struct dentry *dentry,
> struct iattr *attr)
>         struct inode *inode = d_inode(dentry);
>         int error;
> 
> -       if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
> +       if (attr->ia_valid & (ATTR_UID | ATTR_GID))
>                 return -EPERM;
> 
> +       if (attr->ia_valid & ATTR_MODE) {
> +               struct ctl_table_header *head = grab_header(inode);
> +               struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> +               umode_t max_mode = 0777; /* Only these bits may change */
> +
> +               if (IS_ERR(head))
> +                       return PTR_ERR(head);
> +
> +               if (!table) /* global root - r-xr-xr-x */
> +                       max_mode &= ~0222;
> +               else /*
> +                     * Don't allow permissions to become less
> +                     * restrictive than the sysctl table entry
> +                     */
> +                       max_mode &= table->mode;
> +
> +               sysctl_head_finish(head);
> +
> +               /* Execute bits only allowed for directories */
> +               if (!S_ISDIR(inode->i_mode))
> +                       max_mode &= ~0111;
> +
> +               if (attr->ia_mode & ~S_IFMT & ~max_mode)
> +                       return -EPERM;
> +       }
> +
>         error = setattr_prepare(dentry, attr);
>         if (error)
>                 return error;
> @@ -853,17 +883,8 @@ static int proc_sys_getattr(const struct path *path,
> struct kstat *stat,
>                             u32 request_mask, unsigned int query_flags)
>  {
>         struct inode *inode = d_inode(path->dentry);
> -       struct ctl_table_header *head = grab_header(inode);
> -       struct ctl_table *table = PROC_I(inode)->sysctl_entry;
> -
> -       if (IS_ERR(head))
> -               return PTR_ERR(head);
> 
>         generic_fillattr(inode, stat);
> -       if (table)
> -               stat->mode = (stat->mode & S_IFMT) | table->mode;
> -
> -       sysctl_head_finish(head);
>         return 0;
>  }
> 
> -- 
> 2.24.0.rc1
> 


