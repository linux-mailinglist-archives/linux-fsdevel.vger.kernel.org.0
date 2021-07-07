Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81A3BF03B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhGGT1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:27:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55992 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGT1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:27:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D168322046;
        Wed,  7 Jul 2021 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625685866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/jzQ4eougwpQsFFhw7UoJdFuHPsU9zjSMn7cH0iGQA=;
        b=h9PqXGjW5MCF7Dc7VRT4BzUj2/od+pz3dF4CSW3fX5a039yRhyzPFEsFfh+kMz+rDbnlad
        QbUcIqe5lX1I2KjZQ/QdANNx1ahm6jsoJOHL8bwQosYeBHVem7ywDAFadNg7izKq4dP5Ed
        /DxPJ5wJPOPQztGyblSBwITyYmTft8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625685866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/jzQ4eougwpQsFFhw7UoJdFuHPsU9zjSMn7cH0iGQA=;
        b=MDc8jJB4060Qbei30xTgBl4eLiSpqcTAaFMHJouLfK2VnNS0Et+OseU0DdWeJYRtVT2QcG
        cxA3cR9RtOQxYXCg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id B7DE0A3BA3;
        Wed,  7 Jul 2021 19:24:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 924701F2CD7; Wed,  7 Jul 2021 21:24:26 +0200 (CEST)
Date:   Wed, 7 Jul 2021 21:24:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 03/15] fanotify: Split fsid check from other fid mode
 checks
Message-ID: <20210707192426.GE18396@quack2.suse.cz>
References: <20210629191035.681913-1-krisman@collabora.com>
 <20210629191035.681913-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629191035.681913-4-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 29-06-21 15:10:23, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR will require fsid, but not necessarily require the
> filesystem to expose a file handle.  Split those checks into different
> functions, so they can be used separately when setting up an event.
> 
> While there, update a comment about tmpfs having 0 fsid, which is no
> longer true.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v2:
>   - FAN_ERROR -> FAN_FS_ERROR (Amir)
>   - Update comment (Amir)
> 
> Changes since v1:
>   (Amir)
>   - Sort hunks to simplify diff.
> Changes since RFC:
>   (Amir)
>   - Rename fanotify_check_path_fsid -> fanotify_test_fsid.
>   - Use dentry directly instead of path.
> ---
>  fs/notify/fanotify/fanotify_user.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 68a53d3534f8..67b18dfe0025 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1192,16 +1192,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
>  	return fd;
>  }
>  
> -/* Check if filesystem can encode a unique fid */
> -static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
> +static int fanotify_test_fsid(struct dentry *dentry, __kernel_fsid_t *fsid)
>  {
>  	__kernel_fsid_t root_fsid;
>  	int err;
>  
>  	/*
> -	 * Make sure path is not in filesystem with zero fsid (e.g. tmpfs).
> +	 * Make sure dentry is not of a filesystem with zero fsid (e.g. fuse).
>  	 */
> -	err = vfs_get_fsid(path->dentry, fsid);
> +	err = vfs_get_fsid(dentry, fsid);
>  	if (err)
>  		return err;
>  
> @@ -1209,10 +1208,10 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>  		return -ENODEV;
>  
>  	/*
> -	 * Make sure path is not inside a filesystem subvolume (e.g. btrfs)
> +	 * Make sure dentry is not of a filesystem subvolume (e.g. btrfs)
>  	 * which uses a different fsid than sb root.
>  	 */
> -	err = vfs_get_fsid(path->dentry->d_sb->s_root, &root_fsid);
> +	err = vfs_get_fsid(dentry->d_sb->s_root, &root_fsid);
>  	if (err)
>  		return err;
>  
> @@ -1220,6 +1219,12 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>  	    root_fsid.val[1] != fsid->val[1])
>  		return -EXDEV;
>  
> +	return 0;
> +}
> +
> +/* Check if filesystem can encode a unique fid */
> +static int fanotify_test_fid(struct dentry *dentry)
> +{
>  	/*
>  	 * We need to make sure that the file system supports at least
>  	 * encoding a file handle so user can use name_to_handle_at() to
> @@ -1227,8 +1232,8 @@ static int fanotify_test_fid(struct path *path, __kernel_fsid_t *fsid)
>  	 * objects. However, name_to_handle_at() requires that the
>  	 * filesystem also supports decoding file handles.
>  	 */
> -	if (!path->dentry->d_sb->s_export_op ||
> -	    !path->dentry->d_sb->s_export_op->fh_to_dentry)
> +	if (!dentry->d_sb->s_export_op ||
> +	    !dentry->d_sb->s_export_op->fh_to_dentry)
>  		return -EOPNOTSUPP;
>  
>  	return 0;
> @@ -1379,7 +1384,11 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	}
>  
>  	if (fid_mode) {
> -		ret = fanotify_test_fid(&path, &__fsid);
> +		ret = fanotify_test_fsid(path.dentry, &__fsid);
> +		if (ret)
> +			goto path_put_and_out;
> +
> +		ret = fanotify_test_fid(path.dentry);
>  		if (ret)
>  			goto path_put_and_out;
>  
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
