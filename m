Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DB742F147
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhJOMtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 08:49:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhJOMtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:49:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5C77B21A5B;
        Fri, 15 Oct 2021 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634302021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=im1Uarlinuj8wrn8bftfMEL7dxLxBvs0yrqpufXRFDY=;
        b=fs20q1umuT/eUlI5BbhKf6XlsNaMJdWgqDnteyHRSkSc69fRBdxgWyQJxxh6XGP8ImuYVE
        DK4tuGBmWCgzEnmfeI7x4SoCarWRpGRpcTu2/k1FN4aG/0Kvd6YNs9I4kCKsp0ejNSDsrc
        eNxVwz67noZtlObb9CWeSkjWlnoxju0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634302021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=im1Uarlinuj8wrn8bftfMEL7dxLxBvs0yrqpufXRFDY=;
        b=g/y38nq1ZIZBJxAxwaZFxpvPln496regFbrV2VE5YsjF3J5OMjveG0uCHHVcHeFN1g7ZnB
        kjgJSkaQlAXCv3Cw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4C395A3B83;
        Fri, 15 Oct 2021 12:47:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 348301E0A40; Fri, 15 Oct 2021 14:47:01 +0200 (CEST)
Date:   Fri, 15 Oct 2021 14:47:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 24/28] fanotify: Emit generic error info for error
 event
Message-ID: <20211015124701.GL23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-25-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-25-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:42, Gabriel Krisman Bertazi wrote:
> The error info is a record sent to users on FAN_FS_ERROR events
> documenting the type of error.  It also carries an error count,
> documenting how many errors were observed since the last reporting.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> Changes since v6:
>   - Rebase on top of pidfd patches
> Changes since v5:
>   - Move error code here
> ---
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify.h      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 35 ++++++++++++++++++++++++++++++
>  include/uapi/linux/fanotify.h      |  7 ++++++
>  4 files changed, 44 insertions(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 8a60c96f5fb2..47e28f418711 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -623,6 +623,7 @@ static struct fanotify_event *fanotify_alloc_error_event(
>  		return NULL;
>  
>  	fee->fae.type = FANOTIFY_EVENT_TYPE_FS_ERROR;
> +	fee->error = report->error;
>  	fee->err_count = 1;
>  	fee->fsid = *fsid;
>  
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index b58400926f92..a0897425df07 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -199,6 +199,7 @@ FANOTIFY_NE(struct fanotify_event *event)
>  
>  struct fanotify_error_event {
>  	struct fanotify_event fae;
> +	s32 error; /* Error reported by the Filesystem. */
>  	u32 err_count; /* Suppressed errors count */
>  
>  	__kernel_fsid_t fsid; /* FSID this error refers to. */
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 39cf8ba4a6ce..8f7c2f4ce674 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -115,6 +115,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
>  	(sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
>  #define FANOTIFY_PIDFD_INFO_HDR_LEN \
>  	sizeof(struct fanotify_event_info_pidfd)
> +#define FANOTIFY_ERROR_INFO_LEN \
> +	(sizeof(struct fanotify_event_info_error))
>  
>  static int fanotify_fid_info_len(int fh_len, int name_len)
>  {
> @@ -149,6 +151,9 @@ static size_t fanotify_event_len(unsigned int info_mode,
>  	if (!info_mode)
>  		return event_len;
>  
> +	if (fanotify_is_error_event(event->mask))
> +		event_len += FANOTIFY_ERROR_INFO_LEN;
> +
>  	info = fanotify_event_info(event);
>  	dir_fh_len = fanotify_event_dir_fh_len(event);
>  	fh_len = fanotify_event_object_fh_len(event);
> @@ -333,6 +338,28 @@ static int process_access_response(struct fsnotify_group *group,
>  	return -ENOENT;
>  }
>  
> +static size_t copy_error_info_to_user(struct fanotify_event *event,
> +				      char __user *buf, int count)
> +{
> +	struct fanotify_event_info_error info;
> +	struct fanotify_error_event *fee = FANOTIFY_EE(event);
> +
> +	info.hdr.info_type = FAN_EVENT_INFO_TYPE_ERROR;
> +	info.hdr.pad = 0;
> +	info.hdr.len = FANOTIFY_ERROR_INFO_LEN;
> +
> +	if (WARN_ON(count < info.hdr.len))
> +		return -EFAULT;
> +
> +	info.error = fee->error;
> +	info.error_count = fee->err_count;
> +
> +	if (copy_to_user(buf, &info, sizeof(info)))
> +		return -EFAULT;
> +
> +	return info.hdr.len;
> +}
> +
>  static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
>  				 int info_type, const char *name,
>  				 size_t name_len,
> @@ -540,6 +567,14 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>  		total_bytes += ret;
>  	}
>  
> +	if (fanotify_is_error_event(event->mask)) {
> +		ret = copy_error_info_to_user(event, buf, count);
> +		if (ret < 0)
> +			return ret;
> +		buf += ret;
> +		count -= ret;
> +	}
> +
>  	return total_bytes;
>  }
>  
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index 2990731ddc8b..bd1932c2074d 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -126,6 +126,7 @@ struct fanotify_event_metadata {
>  #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
>  #define FAN_EVENT_INFO_TYPE_DFID	3
>  #define FAN_EVENT_INFO_TYPE_PIDFD	4
> +#define FAN_EVENT_INFO_TYPE_ERROR	5
>  
>  /* Variable length info record following event metadata */
>  struct fanotify_event_info_header {
> @@ -160,6 +161,12 @@ struct fanotify_event_info_pidfd {
>  	__s32 pidfd;
>  };
>  
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};
> +
>  struct fanotify_response {
>  	__s32 fd;
>  	__u32 response;
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
