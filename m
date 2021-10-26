Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEFC43B17E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 13:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhJZLuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 07:50:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhJZLuF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:50:05 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 53A5021155;
        Tue, 26 Oct 2021 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635248860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGE0snSaCarKzqGQiZVI+d/WqBBBgakc9up3nBxmlvE=;
        b=rrIOS5yvo7D2mmma9GOesa85R2mkJ7jxrsojk1nEjBjq4bRHb/SipoLqxKZG1y+XvUBrae
        0RuvnMKjTqQM63ctKw+UYUhX0OdPUpeJGFiljuNO1HMpmCXrRr+oFPWMi+DXjv3cuY0C+C
        9DBMTdW5z6AqoiU5EEBEcpevznkDZ9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635248860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGE0snSaCarKzqGQiZVI+d/WqBBBgakc9up3nBxmlvE=;
        b=RHGQAn1DAtLVjI4+BV6bMlZ/jKZPTCAvEen2rbDk1YMX1ahGy/OrQ/thyTAhKO8bfO3uvN
        jdqXIYMin3csD/Bg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 2F55AA3B81;
        Tue, 26 Oct 2021 11:47:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F03A31F2C66; Tue, 26 Oct 2021 13:47:36 +0200 (CEST)
Date:   Tue, 26 Oct 2021 13:47:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-ext4@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v9 11/31] fsnotify: Protect fsnotify_handle_inode_event
 from no-inode events
Message-ID: <20211026114736.GC21228@quack2.suse.cz>
References: <20211025192746.66445-1-krisman@collabora.com>
 <20211025192746.66445-12-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025192746.66445-12-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-10-21 16:27:26, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR allows events without inodes - i.e. for file system-wide
> errors.  Even though fsnotify_handle_inode_event is not currently used
> by fanotify, this patch protects other backends from cases where neither
> inode or dir are provided.  Also document the constraints of the
> interface (inode and dir cannot be both NULL).
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v8:
>   - Convert verifications to WARN_ON
>   - Require either inode or dir
>   - Protect nfsd backend from !inode.
> ---
>  fs/nfsd/filecache.c              | 3 +++
>  fs/notify/fsnotify.c             | 3 +++
>  include/linux/fsnotify_backend.h | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index be3c1aad50ea..fdf89fcf1a0c 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -602,6 +602,9 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
>  				struct inode *inode, struct inode *dir,
>  				const struct qstr *name, u32 cookie)
>  {
> +	if (WARN_ON_ONCE(!inode))
> +		return 0;
> +
>  	trace_nfsd_file_fsnotify_handle_event(inode, mask);
>  
>  	/* Should be no marks on non-regular files */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index fde3a1115a17..4034ca566f95 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -252,6 +252,9 @@ static int fsnotify_handle_inode_event(struct fsnotify_group *group,
>  	if (WARN_ON_ONCE(!ops->handle_inode_event))
>  		return 0;
>  
> +	if (WARN_ON_ONCE(!inode && !dir))
> +		return 0;
> +
>  	if ((inode_mark->mask & FS_EXCL_UNLINK) &&
>  	    path && d_unlinked(path->dentry))
>  		return 0;
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 035438fe4a43..b71dc788018e 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -136,6 +136,7 @@ struct mem_cgroup;
>   * @dir:	optional directory associated with event -
>   *		if @file_name is not NULL, this is the directory that
>   *		@file_name is relative to.
> + *		Either @inode or @dir must be non-NULL.
>   * @file_name:	optional file name associated with event
>   * @cookie:	inotify rename cookie
>   *
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
