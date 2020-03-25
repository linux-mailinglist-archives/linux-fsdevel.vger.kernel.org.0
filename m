Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 964E2192567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 11:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgCYKW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 06:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:55244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgCYKW7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:22:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5F8DABEA;
        Wed, 25 Mar 2020 10:22:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 82D8F1E10FB; Wed, 25 Mar 2020 11:22:57 +0100 (CET)
Date:   Wed, 25 Mar 2020 11:22:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 06/14] fsnotify: pass dentry instead of inode for
 events possible on child
Message-ID: <20200325102257.GH28951@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
 <20200319151022.31456-7-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319151022.31456-7-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-03-20 17:10:14, Amir Goldstein wrote:
> Most events that can be reported to watching parent pass
> FSNOTIFY_EVENT_PATH as event data, except for FS_ARRTIB and FS_MODIFY
> as a result of truncate.
> 
> Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY
> and use it to pass the dentry instead of it's ->d_inode for those events.
> 
> Soon, we are going to use the dentry data type to report events
> with name info in fanotify backend.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

I've skipped this patch because FSNOTIFY_EVENT_DENTRY is not used by
anything in this series... Just that you don't wonder when rebasing later.

									Honza

> ---
>  include/linux/fsnotify.h         |  4 ++--
>  include/linux/fsnotify_backend.h | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 860018f3e545..d286663fcef2 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -49,8 +49,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
>  	if (S_ISDIR(inode->i_mode))
>  		mask |= FS_ISDIR;
>  
> -	fsnotify_parent(dentry, mask, inode, FSNOTIFY_EVENT_INODE);
> -	fsnotify(inode, mask, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
> +	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
> +	fsnotify(inode, mask, dentry, FSNOTIFY_EVENT_DENTRY, NULL, 0);
>  }
>  
>  static inline int fsnotify_file(struct file *file, __u32 mask)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 337c87cf34d6..ab0913619403 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -217,6 +217,7 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
> +	FSNOTIFY_EVENT_DENTRY,
>  };
>  
>  static inline const struct inode *fsnotify_data_inode(const void *data,
> @@ -225,6 +226,8 @@ static inline const struct inode *fsnotify_data_inode(const void *data,
>  	switch (data_type) {
>  	case FSNOTIFY_EVENT_INODE:
>  		return data;
> +	case FSNOTIFY_EVENT_DENTRY:
> +		return d_inode(data);
>  	case FSNOTIFY_EVENT_PATH:
>  		return d_inode(((const struct path *)data)->dentry);
>  	default:
> @@ -232,6 +235,20 @@ static inline const struct inode *fsnotify_data_inode(const void *data,
>  	}
>  }
>  
> +static inline struct dentry *fsnotify_data_dentry(const void *data,
> +						  int data_type)
> +{
> +	switch (data_type) {
> +	case FSNOTIFY_EVENT_DENTRY:
> +		/* Non const is needed for dget() */
> +		return (struct dentry *)data;
> +	case FSNOTIFY_EVENT_PATH:
> +		return ((const struct path *)data)->dentry;
> +	default:
> +		return NULL;
> +	}
> +}
> +
>  static inline const struct path *fsnotify_data_path(const void *data,
>  						    int data_type)
>  {
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
