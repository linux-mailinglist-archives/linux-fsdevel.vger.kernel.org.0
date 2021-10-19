Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A16433A3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhJSP01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:26:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54984 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhJSP01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:26:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2FB9821981;
        Tue, 19 Oct 2021 15:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634657053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AML3PYlDqtrcTft56XcxezYSLWwIid+Vb1UjOdUy3Is=;
        b=xXV3VqI5duLhh/4XIMQcupRj9G5bT2yV31EXpVaDHwYaYc/cz2bf6KJUWF7IpAveMavLzv
        mqOYnatVsBvvXj7g2QZOKwWbmnrM2Zzrp/XIQbJeErrnt0KfDEvqDzCu/l1e12aeIgb/J1
        iFElEBdxrSuMSg69LxJed1Znxy87WCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634657053;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AML3PYlDqtrcTft56XcxezYSLWwIid+Vb1UjOdUy3Is=;
        b=xGqTmKZlVeCLMBBF2gTCXjdd1neaznDwgoIUvvjp7KRx0mwVuqM03boXun87kQL9V3SW2x
        TgpgSd9DLj46b2Bw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 15002A3B84;
        Tue, 19 Oct 2021 15:24:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E16DF1E0983; Tue, 19 Oct 2021 17:24:09 +0200 (CEST)
Date:   Tue, 19 Oct 2021 17:24:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 29/32] fanotify: Allow users to request FAN_FS_ERROR
 events
Message-ID: <20211019152409.GQ3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-30-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-30-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:12, Gabriel Krisman Bertazi wrote:
> Wire up the FAN_FS_ERROR event in the fanotify_mark syscall, allowing
> user space to request the monitoring of FAN_FS_ERROR events.
> 
> These events are limited to filesystem marks, so check it is the
> case in the syscall handler.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> ---
> Changes since v7:
>   - Move the verification closer to similar code (Amir)
> ---
>  fs/notify/fanotify/fanotify.c      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 4 ++++
>  include/linux/fanotify.h           | 6 +++++-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0f6694eadb63..20169b8d5ab7 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -821,7 +821,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>  	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
>  	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>  
> -	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
> +	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
>  
>  	mask = fanotify_group_event_mask(group, iter_info, mask, data,
>  					 data_type, dir);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index b83c61c934d0..22dca806c7e2 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1535,6 +1535,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	    group->priority == FS_PRIO_0)
>  		goto fput_and_out;
>  
> +	if (mask & FAN_FS_ERROR &&
> +	    mark_type != FAN_MARK_FILESYSTEM)
> +		goto fput_and_out;
> +
>  	/*
>  	 * Events that do not carry enough information to report
>  	 * event->fd require a group that supports reporting fid.  Those
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 52d464802d99..616af2ea20f3 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -91,9 +91,13 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
>  #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
>  				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
>  
> +/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
> +#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
> +
>  /* Events that user can request to be notified on */
>  #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
> -				 FANOTIFY_INODE_EVENTS)
> +				 FANOTIFY_INODE_EVENTS | \
> +				 FANOTIFY_ERROR_EVENTS)
>  
>  /* Events that require a permission response from user */
>  #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
