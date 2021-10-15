Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FFE42F3EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhJONl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 09:41:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47226 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbhJONl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:41:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4967D21973;
        Fri, 15 Oct 2021 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634305190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTnq0UGHCHfxUpr/rvZAc+3hL2Fvz6piRi80GljMscM=;
        b=ZIOSbcHPjLcN9y2KZnBegWtHi6Ke2y25DV6WT4oetijXmSut30z1/eaQSaFC8OOf0m6mez
        tY2N3Cd+fcVB+ui1KJ5R/fsBYyh8a8Dnj3hvSUekBVNcEZYl+cwLR+MYS/qw7H52Gr8omg
        xB6IuRfekxt7XlAa7ehJI6NSxdyj1xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634305190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTnq0UGHCHfxUpr/rvZAc+3hL2Fvz6piRi80GljMscM=;
        b=86JwG3Jc+hbDUv2EFdvMq26W/DsBBf8zWlOpLoDEjDWgbikC/2ajme+llLExqOX0JT1ULY
        rnNCM1J/l39hT2AA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 39931A3B87;
        Fri, 15 Oct 2021 13:39:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 26CC71E0A40; Fri, 15 Oct 2021 15:39:50 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:39:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 02/28] fsnotify: pass dentry instead of inode data
Message-ID: <20211015133950.GP23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-3-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:20, Gabriel Krisman Bertazi wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> Define a new data type to pass for event - FSNOTIFY_EVENT_DENTRY.
> Use it to pass the dentry instead of it's ->d_inode where available.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Did this ever get used in this series?

								Honza

> ---
>  include/linux/fsnotify.h         |  5 ++---
>  include/linux/fsnotify_backend.h | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index d1144d7c3536..df0fa4687a18 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -39,8 +39,7 @@ static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
>  static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>  				   __u32 mask)
>  {
> -	fsnotify_name(mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
> -		      dir, &dentry->d_name, 0);
> +	fsnotify_name(mask, dentry, FSNOTIFY_EVENT_DENTRY, dir, &dentry->d_name, 0);
>  }
>  
>  static inline void fsnotify_inode(struct inode *inode, __u32 mask)
> @@ -87,7 +86,7 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>   */
>  static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
>  {
> -	fsnotify_parent(dentry, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE);
> +	fsnotify_parent(dentry, mask, dentry, FSNOTIFY_EVENT_DENTRY);
>  }
>  
>  static inline int fsnotify_file(struct file *file, __u32 mask)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 1ce66748a2d2..a2db821e8a8f 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -248,6 +248,7 @@ enum fsnotify_data_type {
>  	FSNOTIFY_EVENT_NONE,
>  	FSNOTIFY_EVENT_PATH,
>  	FSNOTIFY_EVENT_INODE,
> +	FSNOTIFY_EVENT_DENTRY,
>  };
>  
>  static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
> @@ -255,6 +256,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  	switch (data_type) {
>  	case FSNOTIFY_EVENT_INODE:
>  		return (struct inode *)data;
> +	case FSNOTIFY_EVENT_DENTRY:
> +		return d_inode(data);
>  	case FSNOTIFY_EVENT_PATH:
>  		return d_inode(((const struct path *)data)->dentry);
>  	default:
> @@ -262,6 +265,19 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
>  	}
>  }
>  
> +static inline struct dentry *fsnotify_data_dentry(const void *data, int data_type)
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
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
