Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35E73E13E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 13:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241071AbhHEL26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 07:28:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47704 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241022AbhHEL26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 07:28:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DCD632237F;
        Thu,  5 Aug 2021 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628162922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoKvHquCkmVzescqlzv3YN5ekDTiL3w8qjDJ0pfVTP8=;
        b=Tx2Tcrc0YLU/PdbOV/GUv5NN5vYS7X0uz3V98zW1L2jZaM63Ehyg0sNdc1k599YYBwxihc
        LAgIwsHwkDWZgva54JHYPyP5JO12UBj+vW3pgDBhJtj/8JsRErSmKtnxsUCR92BN4rpR0t
        EU3G87EUWcBPPFAUcvsA/6bxBI4jZF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628162922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XoKvHquCkmVzescqlzv3YN5ekDTiL3w8qjDJ0pfVTP8=;
        b=zB/vXq8GHOe5WMBBd6igQd4StkjK2VKkhl/9xk0N3VlOnd5N1MRG76GvjaJY79RVLTvXAM
        j+SOSJrxkHrPMUAg==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id BEDB0A3B92;
        Thu,  5 Aug 2021 11:28:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 941881E1511; Thu,  5 Aug 2021 13:28:41 +0200 (CEST)
Date:   Thu, 5 Aug 2021 13:28:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 19/23] fanotify: Report fid info for file related file
 system errors
Message-ID: <20210805112841.GJ14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-20-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-20-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:06:08, Gabriel Krisman Bertazi wrote:
> Plumb the pieces to add a FID report to error records.  Since all error
> event memory must be pre-allocated, we estimate a file handler size and
> if it is insuficient, we report an invalid FID and increase the
> prediction for the next error slot allocation.

Hum, cannot we just preallocate MAX_HANDLE_SZ? It is wasteful but then I
don't expect error marks would be that frequent for this to really
matter and the code would be simpler.

								Honza

> 
> For errors that don't expose a file handler report it with an invalid
> FID.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c      | 27 +++++++++++++++++++++++++++
>  fs/notify/fanotify/fanotify.h      | 12 ++++++++++++
>  fs/notify/fanotify/fanotify_user.c | 19 ++++++++++++++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 4e9e271a4394..2fd30b5eb9d3 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -705,7 +705,9 @@ static void fanotify_insert_error_event(struct fsnotify_group *group,
>  {
>  	const struct fs_error_report *report = (struct fs_error_report *) data;
>  	struct fanotify_event *fae = FANOTIFY_E(event);
> +	struct inode *inode = report->inode;
>  	struct fanotify_error_event *fee;
> +	int fh_len;
>  
>  	/* This might be an unexpected type of event (i.e. overflow). */
>  	if (!fanotify_is_error_event(fae->mask))
> @@ -715,6 +717,31 @@ static void fanotify_insert_error_event(struct fsnotify_group *group,
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
>  	fee->error = report->error;
>  	fee->err_count = 1;
> +	fee->fsid = fee->sb_mark->fsn_mark.connector->fsid;
> +
> +	/*
> +	 * Error reporting needs to happen in atomic context.  If this
> +	 * inode's file handler length is more than we initially
> +	 * predicted, there is nothing better we can do than report the
> +	 * error with a bad file handler.
> +	 */
> +	fh_len = fanotify_encode_fh_len(inode);
> +	if (fh_len > fee->sb_mark->pred_fh_len) {
> +		pr_warn_ratelimited(
> +			"FH overflows error event. Drop inode information.\n");
> +		/*
> +		 * Update the handler size prediction for the next error
> +		 * event allocation.  This reduces the chance of another
> +		 * overflow.
> +		 */
> +		fee->sb_mark->pred_fh_len = fh_len;
> +
> +		/* For the current error, ignore the inode information. */
> +		inode = NULL;
> +		fh_len = fanotify_encode_fh_len(NULL);
> +	}
> +
> +	fanotify_encode_fh(&fee->object_fh, inode, fh_len, NULL, 0);
>  }
>  
>  /*
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 8929ea50f96f..e4e7968b70ee 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -142,6 +142,7 @@ FANOTIFY_MARK_FLAG(SB_MARK);
>  
>  struct fanotify_sb_mark {
>  	struct fsnotify_mark fsn_mark;
> +	size_t pred_fh_len;
>  	struct fanotify_error_event *fee_slot;
>  };
>  
> @@ -227,6 +228,13 @@ struct fanotify_error_event {
>  	u32 err_count; /* Suppressed errors count */
>  
>  	struct fanotify_sb_mark *sb_mark; /* Back reference to the mark. */
> +
> +	__kernel_fsid_t fsid; /* FSID this error refers to. */
> +	/*
> +	 * object_fh is followed by a variable sized buffer, so it must
> +	 * be the last element of this structure.
> +	 */
> +	struct fanotify_fh object_fh;
>  };
>  
>  static inline struct fanotify_error_event *
> @@ -241,6 +249,8 @@ static inline __kernel_fsid_t *fanotify_event_fsid(struct fanotify_event *event)
>  		return &FANOTIFY_FE(event)->fsid;
>  	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>  		return &FANOTIFY_NE(event)->fsid;
> +	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +		return &FANOTIFY_EE(event)->fsid;
>  	else
>  		return NULL;
>  }
> @@ -252,6 +262,8 @@ static inline struct fanotify_fh *fanotify_event_object_fh(
>  		return &FANOTIFY_FE(event)->object_fh;
>  	else if (event->type == FANOTIFY_EVENT_TYPE_FID_NAME)
>  		return fanotify_info_file_fh(&FANOTIFY_NE(event)->info);
> +	else if (event->type == FANOTIFY_EVENT_TYPE_FS_ERROR)
> +		return &FANOTIFY_EE(event)->object_fh;
>  	else
>  		return NULL;
>  }
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index e7fe6bc61b6f..74def82630bb 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -172,8 +172,25 @@ static struct fanotify_error_event *fanotify_alloc_error_event(
>  
>  {
>  	struct fanotify_error_event *fee;
> +	struct super_block *sb;
>  
> -	fee = kzalloc(sizeof(*fee), GFP_KERNEL_ACCOUNT);
> +	if (!sb_mark->pred_fh_len) {
> +		/*
> +		 * The handler size is initially predicted to be the
> +		 * same size as the root inode file handler.  It can be
> +		 * increased later if a larger file handler is found.
> +		 */
> +		sb = container_of(sb_mark->fsn_mark.connector->obj,
> +				  struct super_block, s_fsnotify_marks);
> +		sb_mark->pred_fh_len =
> +			fanotify_encode_fh_len(sb->s_root->d_inode);
> +	}
> +
> +	/* Guarantee there is always space to report an invalid FID. */
> +	if (sb_mark->pred_fh_len < FANOTIFY_NULL_FH_LEN)
> +		sb_mark->pred_fh_len = FANOTIFY_NULL_FH_LEN;
> +
> +	fee = kzalloc(sizeof(*fee) + sb_mark->pred_fh_len, GFP_KERNEL_ACCOUNT);
>  	if (!fee)
>  		return NULL;
>  
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
