Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A73C2158
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jul 2021 11:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhGIJWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jul 2021 05:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhGIJWF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:22:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F17B613CC;
        Fri,  9 Jul 2021 09:19:18 +0000 (UTC)
Date:   Fri, 9 Jul 2021 11:19:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        jack@suse.cz, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210709091915.2bd4snyfjndexw2b@wittgenstein>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210708175738.360757-2-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 08, 2021 at 01:57:38PM -0400, Vivek Goyal wrote:
> Currently user.* xattr are not allowed on symlink and special files.
> 
> man xattr and recent discussion suggested that primary reason for this
> restriction is how file permissions for symlinks and special files
> are little different from regular files and directories.
> 
> For symlinks, they are world readable/writable and if user xattr were
> to be permitted, it will allow unpriviliged users to dump a huge amount
> of user.* xattrs on symlinks without any control.
> 
> For special files, permissions typically control capability to read/write
> from devices (and not necessarily from filesystem). So if a user can
> write to device (/dev/null), does not necessarily mean it should be allowed
> to write large number of user.* xattrs on the filesystem device node is
> residing in.
> 
> This patch proposes to relax the restrictions a bit and allow file owner
> or priviliged user (CAP_FOWNER), to be able to read/write user.* xattrs
> on symlink and special files.
> 
> virtiofs daemon has a need to store user.* xatrrs on all the files
> (including symlinks and special files), and currently that fails. This
> patch should help.
> 
> Link: https://lore.kernel.org/linux-fsdevel/20210625191229.1752531-1-vgoyal@redhat.com/
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---

Seems reasonable and useful.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

One question, do all filesystem supporting xattrs deal with setting them
on symlinks/device files correctly?

>  fs/xattr.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 5c8c5175b385..2f1855c8b620 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -120,12 +120,14 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
>  	}
>  
>  	/*
> -	 * In the user.* namespace, only regular files and directories can have
> -	 * extended attributes. For sticky directories, only the owner and
> -	 * privileged users can write attributes.
> +	 * In the user.* namespace, for symlinks and special files, only
> +	 * the owner and priviliged users can read/write attributes.
> +	 * For sticky directories, only the owner and privileged users can
> +	 * write attributes.
>  	 */
>  	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
> -		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
> +		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode) &&
> +		    !inode_owner_or_capable(mnt_userns, inode))
>  			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
>  		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
>  		    (mask & MAY_WRITE) &&
> -- 
> 2.25.4
> 
