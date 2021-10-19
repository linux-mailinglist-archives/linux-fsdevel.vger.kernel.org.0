Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114D54337D0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 15:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhJSNyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 09:54:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58074 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbhJSNyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 09:54:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 319321FD66;
        Tue, 19 Oct 2021 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634651557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNc5SonS47DrCer2vgSoP5sU2/PAkUiPIPbWzXD99qM=;
        b=eU9LIJPCOp+zDJrDARf7FW18nubjdu347sU8StdqOxZvGv+KsKGp6Oh3+SEho6MViejzs4
        HQg3FhPHRVrYxMTnbCDpJH+AxCwF+YJOt4X3NyTTcJWI2d4tf0HUuCLUhE3jUuWsPUnIgQ
        UzfRw8L6mBs28HKGWPtXaLxgqtbEM78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634651557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNc5SonS47DrCer2vgSoP5sU2/PAkUiPIPbWzXD99qM=;
        b=bSPMUpzhrhHj63ZVgWV/R7pqkUKPX7g+jAh0LUUA+vgeOpDH1mwWkdO6oLGfaUkx7BmI+z
        ieI08RM/5B4SUQDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 151E3A3B83;
        Tue, 19 Oct 2021 13:52:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E7B3C1E0983; Tue, 19 Oct 2021 15:52:36 +0200 (CEST)
Date:   Tue, 19 Oct 2021 15:52:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 22/32] fanotify: Support merging of error events
Message-ID: <20211019135236.GK3255@quack2.suse.cz>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-23-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-23-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-10-21 21:00:05, Gabriel Krisman Bertazi wrote:
> Error events (FAN_FS_ERROR) against the same file system can be merged
> by simply iterating the error count.  The hash is taken from the fsid,
> without considering the FH.  This means that only the first error object
> is reported.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> Changes since v7:
>   - Move fee->fsid assignment here (Amir)
>   - Open code error event merge logic in fanotify_merge (Jan)
> ---
>  fs/notify/fanotify/fanotify.c | 26 ++++++++++++++++++++++++--
>  fs/notify/fanotify/fanotify.h |  4 +++-
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 1f195c95dfcd..cedcb1546804 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -111,6 +111,16 @@ static bool fanotify_name_event_equal(struct fanotify_name_event *fne1,
>  	return fanotify_info_equal(info1, info2);
>  }
>  
> +static bool fanotify_error_event_equal(struct fanotify_error_event *fee1,
> +				       struct fanotify_error_event *fee2)
> +{
> +	/* Error events against the same file system are always merged. */
> +	if (!fanotify_fsid_equal(&fee1->fsid, &fee2->fsid))
> +		return false;
> +
> +	return true;
> +}
> +
>  static bool fanotify_should_merge(struct fanotify_event *old,
>  				  struct fanotify_event *new)
>  {
> @@ -141,6 +151,9 @@ static bool fanotify_should_merge(struct fanotify_event *old,
>  	case FANOTIFY_EVENT_TYPE_FID_NAME:
>  		return fanotify_name_event_equal(FANOTIFY_NE(old),
>  						 FANOTIFY_NE(new));
> +	case FANOTIFY_EVENT_TYPE_FS_ERROR:
> +		return fanotify_error_event_equal(FANOTIFY_EE(old),
> +						  FANOTIFY_EE(new));
>  	default:
>  		WARN_ON_ONCE(1);
>  	}
> @@ -176,6 +189,10 @@ static int fanotify_merge(struct fsnotify_group *group,
>  			break;
>  		if (fanotify_should_merge(old, new)) {
>  			old->mask |= new->mask;
> +
> +			if (fanotify_is_error_event(old->mask))
> +				FANOTIFY_EE(old)->err_count++;
> +
>  			return 1;
>  		}
>  	}
> @@ -577,7 +594,8 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>  static struct fanotify_event *fanotify_alloc_error_event(
>  						struct fsnotify_group *group,
>  						__kernel_fsid_t *fsid,
> -						const void *data, int data_type)
> +						const void *data, int data_type,
> +						unsigned int *hash)
>  {
>  	struct fs_error_report *report =
>  			fsnotify_data_error_report(data, data_type);
> @@ -591,6 +609,10 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  		return NULL;
>  
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +	fee->err_count = 1;
> +	fee->fsid = *fsid;
> +
> +	*hash ^= fanotify_hash_fsid(fsid);
>  
>  	return &fee->fae;
>  }
> @@ -664,7 +686,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
>  		event = fanotify_alloc_perm_event(path, gfp);
>  	} else if (fanotify_is_error_event(mask)) {
>  		event = fanotify_alloc_error_event(group, fsid, data,
> -						   data_type);
> +						   data_type, &hash);
>  	} else if (name_event && (file_name || child)) {
>  		event = fanotify_alloc_name_event(id, fsid, file_name, child,
>  						  &hash, gfp);
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index ebef952481fa..2b032b79d5b0 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -199,6 +199,9 @@ FANOTIFY_NE(struct fanotify_event *event)
>  
>  struct fanotify_error_event {
>  	struct fanotify_event fae;
> +	u32 err_count; /* Suppressed errors count */
> +
> +	__kernel_fsid_t fsid; /* FSID this error refers to. */
>  };
>  
>  static inline struct fanotify_error_event *
> @@ -332,7 +335,6 @@ static inline struct path *fanotify_event_path(struct fanotify_event *event)
>  static inline bool fanotify_is_hashed_event(u32 mask)
>  {
>  	return !(fanotify_is_perm_event(mask) ||
> -		 fanotify_is_error_event(mask) ||
>  		 fsnotify_is_overflow_event(mask));
>  }
>  
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
