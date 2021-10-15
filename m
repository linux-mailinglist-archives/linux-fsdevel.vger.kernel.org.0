Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1F42ED90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhJOJ2Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:28:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhJOJ2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:28:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA64E21A62;
        Fri, 15 Oct 2021 09:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634289972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/PvVpM/xUYJP+dyyzsjaQiWfwCqYj6zggpaVZS6Low=;
        b=gvV83mKmFvjGexnNk7d+XfRymjejz0WCpgdCIEmssbSnkEIg93D/eKDCA3P6kcRZmLwBkp
        5O/YswVlrzu/fncYHI1d6cH5/5yJLj9tKi1ZUCNmQYAGgZ7J2XK2pewIjOFiQMabpwMwsX
        XDmcz69TtVP03qCYWkMzv6IC6hWYKSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634289972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/PvVpM/xUYJP+dyyzsjaQiWfwCqYj6zggpaVZS6Low=;
        b=YHx4KN+655I35KL/xRCOclKGxENMgOGbdMDrYIPe86Iu3oqp2vKAqOL8fDysYUOhf72BpR
        TvAUM/YtA01mVrBQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B9E68A3B8C;
        Fri, 15 Oct 2021 09:26:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 95AE31E0A40; Fri, 15 Oct 2021 11:26:12 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:26:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v7 10/28] fsnotify: Retrieve super block from the data
 field
Message-ID: <20211015092612.GD23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-11-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-11-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:28, Gabriel Krisman Bertazi wrote:
> Some file system events (i.e. FS_ERROR) might not be associated with an
> inode or directory.  For these, we can retrieve the super block from the
> data field.  But, since the super_block is available in the data field
> on every event type, simplify the code to always retrieve it from there,
> through a new helper.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> --
> Changes since v6:
>   - Always use data field for superblock retrieval
> Changes since v5:
>   - add fsnotify_data_sb handle to retrieve sb from the data field. (jan)
> ---
>  fs/notify/fsnotify.c             |  7 +++----
>  include/linux/fsnotify_backend.h | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 963e6ce75b96..fde3a1115a17 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -455,16 +455,16 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>   *		@file_name is relative to
>   * @file_name:	optional file name associated with event
>   * @inode:	optional inode associated with event -
> - *		either @dir or @inode must be non-NULL.
> - *		if both are non-NULL event may be reported to both.
> + *		If @dir and @inode are both non-NULL, event may be
> + *		reported to both.
>   * @cookie:	inotify rename cookie
>   */
>  int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	     const struct qstr *file_name, struct inode *inode, u32 cookie)
>  {
>  	const struct path *path = fsnotify_data_path(data, data_type);
> +	struct super_block *sb = fsnotify_data_sb(data, data_type);
>  	struct fsnotify_iter_info iter_info = {};
> -	struct super_block *sb;
>  	struct mount *mnt = NULL;
>  	struct inode *parent = NULL;
>  	int ret = 0;
> @@ -483,7 +483,6 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  		 */
>  		parent = dir;
>  	}
> -	sb = inode->i_sb;
>  
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index b323d0c4b967..035438fe4a43 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -289,6 +289,21 @@ static inline const struct path *fsnotify_data_path(const void *data,
>  	}
>  }
>  
> +static inline struct super_block *fsnotify_data_sb(const void *data,
> +						   int data_type)
> +{
> +	switch (data_type) {
> +	case FSNOTIFY_EVENT_INODE:
> +		return ((struct inode *)data)->i_sb;
> +	case FSNOTIFY_EVENT_DENTRY:
> +		return ((struct dentry *)data)->d_sb;
> +	case FSNOTIFY_EVENT_PATH:
> +		return ((const struct path *)data)->dentry->d_sb;
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  enum fsnotify_obj_type {
>  	FSNOTIFY_OBJ_TYPE_INODE,
>  	FSNOTIFY_OBJ_TYPE_PARENT,
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
