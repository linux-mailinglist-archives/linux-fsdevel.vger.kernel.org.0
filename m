Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D33E1295
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 12:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHEKZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 06:25:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbhHEKZJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:25:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 513181FE42;
        Thu,  5 Aug 2021 10:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628159094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OopdBnDHUtM8IOTs8NaZRBC1jh08ubPFyp+LKmm9j4=;
        b=IYWCe5TvVO+6SaP7tdJFmOmhA+IeTSSySaz46iMQCooAH3vby15+Pgx7jMCKhi3BUdITtU
        2r0ImdIThfFG2bFk+K00TT69aKsOfNBZ+0uT+esHYNKZdyj2sp2s+V3y+uJ8Zr/EAjaqEz
        sDPfP8TbCluR2SJThzkGvdvq/wOEnZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628159094;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9OopdBnDHUtM8IOTs8NaZRBC1jh08ubPFyp+LKmm9j4=;
        b=DmCOgO4xqADWFp8bpCjrjE4TsFrSMyqtaTS/UzGbbcHPfWelUSetj0kQJ7VxhBP+w5D8oZ
        esYIpevJtJqIQVBw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 25A82A3B91;
        Thu,  5 Aug 2021 10:24:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E5FF31E1511; Thu,  5 Aug 2021 12:24:53 +0200 (CEST)
Date:   Thu, 5 Aug 2021 12:24:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 10/23] fsnotify: Allow events reported with an empty
 inode
Message-ID: <20210805102453.GG14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-11-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-11-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:05:59, Gabriel Krisman Bertazi wrote:
> Some file system events (i.e. FS_ERROR) might not be associated with an
> inode.  For these, it makes sense to associate them directly with the
> super block of the file system they apply to.  This patch allows the
> event to be reported directly against the super block instead of an
> inode.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

There's a comment before fsnotify() declaration that states that 'either
@dir or @inode must be non-NULL' - in this patch it would be good time to
update that comment.

> @@ -459,12 +460,13 @@ static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>   *		if both are non-NULL event may be reported to both.
>   * @cookie:	inotify rename cookie
>   */
> -int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
> -	     const struct qstr *file_name, struct inode *inode, u32 cookie)
> +int fsnotify(__u32 mask, const void *data, int data_type,
> +	     struct super_block *sb, struct inode *dir,
> +	     const struct qstr *file_name, struct inode *inode,
> +	     u32 cookie)
>  {

Two notes as ideas for consideration:

1) We could derive 'sb' from 'data'. I.e., have a helper like
fsnotify_data_sb(data, data_type). For FSNOTIFY_EVENT_PATH and
FSNOTIFY_EVENT_INODE this is easy to provide, for FSNOTIFY_EVENT_ERROR we
would have to add sb pointer to the structure but I guess that's easy. That
way we'd avoid the mostly NULL 'sb' argument. What do you guys think?

2) AFAICS 'inode' can be always derived from 'data' as well. So maybe we
can drop it Amir?

That being said I can live with the code as is in this patch as well
(although with a bit of "ugh, irk ;)" so I want to discuss these ideas).

								Honza

>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	struct fsnotify_iter_info iter_info = {};
> -	struct super_block *sb;
>  	struct mount *mnt = NULL;
>  	struct inode *parent = NULL;
>  	int ret = 0;
> @@ -483,7 +485,9 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  		 */
>  		parent = dir;
>  	}
> -	sb = inode->i_sb;
> +
> +	if (!sb)
> +		sb = inode->i_sb;
>  
>  	/*
>  	 * Optimization: srcu_read_lock() has a memory barrier which can
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..39c9dbc46d36 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -30,7 +30,8 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
>  				 struct inode *child,
>  				 const struct qstr *name, u32 cookie)
>  {
> -	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
> +	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, NULL, dir, name, NULL,
> +		 cookie);
>  }
>  
>  static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
> @@ -44,7 +45,8 @@ static inline void fsnotify_inode(struct inode *inode, __u32 mask)
>  	if (S_ISDIR(inode->i_mode))
>  		mask |= FS_ISDIR;
>  
> -	fsnotify(mask, inode, FSNOTIFY_EVENT_INODE, NULL, NULL, inode, 0);
> +	fsnotify(mask, inode, FSNOTIFY_EVENT_INODE, NULL, NULL, NULL, inode,
> +		 0);
>  }
>  
>  /* Notify this dentry's parent about a child's events. */
> @@ -68,7 +70,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>  	return __fsnotify_parent(dentry, mask, data, data_type);
>  
>  notify_child:
> -	return fsnotify(mask, data, data_type, NULL, NULL, inode, 0);
> +	return fsnotify(mask, data, data_type, NULL, NULL, NULL, inode, 0);
>  }
>  
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 693fe4cb48cf..4a765edd3b2a 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -423,8 +423,9 @@ struct fsnotify_mark {
>  
>  /* main fsnotify call to send events */
>  extern int fsnotify(__u32 mask, const void *data, int data_type,
> -		    struct inode *dir, const struct qstr *name,
> -		    struct inode *inode, u32 cookie);
> +		    struct super_block *sb, struct inode *dir,
> +		    const struct qstr *name, struct inode *inode,
> +		    u32 cookie);
>  extern int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>  			   int data_type);
>  extern void __fsnotify_inode_delete(struct inode *inode);
> @@ -618,8 +619,9 @@ static inline void fsnotify_init_event(struct fsnotify_event *event)
>  #else
>  
>  static inline int fsnotify(__u32 mask, const void *data, int data_type,
> -			   struct inode *dir, const struct qstr *name,
> -			   struct inode *inode, u32 cookie)
> +			   struct super_block *sb, struct inode *dir,
> +			   const struct qstr *name, struct inode *inode,
> +			   u32 cookie)
>  {
>  	return 0;
>  }
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
